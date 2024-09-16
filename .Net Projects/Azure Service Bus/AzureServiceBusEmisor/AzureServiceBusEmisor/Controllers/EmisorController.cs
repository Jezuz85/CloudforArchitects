using Azure.Messaging.ServiceBus;
using Microsoft.AspNetCore.Mvc;

namespace AzureServiceBusEmisor.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class EmisorController : ControllerBase
    {
        private readonly ServiceBusClient _serviceBusClient;
        private readonly string _queueName;

        public EmisorController(ServiceBusClient serviceBusClient, IConfiguration configuration)
        {
            _serviceBusClient = serviceBusClient;
            _queueName = configuration["ServiceBus:QueueName"];
        }

        // POST: EmisorController/Create
        [HttpPost]
        public async Task<IActionResult> CreateOrder([FromBody] Order order)
        {
            ServiceBusSender sender = _serviceBusClient.CreateSender(_queueName);

            // Serializar la orden a JSON
            string messageBody = System.Text.Json.JsonSerializer.Serialize(order);

            // Crear el mensaje de Service Bus
            ServiceBusMessage message = new ServiceBusMessage(messageBody)
            {
                ContentType = "application/json",
                Subject = "NuevaOrden",
                MessageId = order.OrderId.ToString()
            };

            // Enviar el mensaje
            await sender.SendMessageAsync(message);

            return Ok(new { Message = "Orden enviada correctamente", OrderId = order.OrderId });
        }
    }
}