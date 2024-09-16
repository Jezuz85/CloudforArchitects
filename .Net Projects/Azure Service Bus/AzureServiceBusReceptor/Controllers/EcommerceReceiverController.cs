using System.Text.Json;
using Azure.Messaging.ServiceBus;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace AzureServiceBusReceptor.Controllers
{
    public class EcommerceReceiverController : ControllerBase
    {
        private readonly ServiceBusClient _serviceBusClient;
        private readonly string _queueName;

        public EcommerceReceiverController(ServiceBusClient serviceBusClient, IConfiguration configuration)
        {
            _serviceBusClient = serviceBusClient;
            _queueName = configuration["ServiceBus:QueueName"];
        }

        [HttpGet("process")]
        public async Task<IActionResult> ProcessMessage()
        {
            ServiceBusReceiver receiver = _serviceBusClient.CreateReceiver(_queueName);

            // Recibir un mensaje
            ServiceBusReceivedMessage message = await receiver.ReceiveMessageAsync();

            if (message == null)
            {
                return NotFound(new { Message = "No hay mensajes en la cola" });
            }

            // Procesar el mensaje
            string messageBody = message.Body.ToString();
            var order = JsonSerializer.Deserialize<Order>(messageBody);

            // Completar el mensaje
            await receiver.CompleteMessageAsync(message);

            // Devolver la información de la orden procesada
            return Ok(new
            {
                Message = "Orden procesada correctamente",
                Order = order
            });
        }
    }
}
