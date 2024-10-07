using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace WebApiUsers.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly string _filePath;
        private static List<User> _users;

        public UserController(IWebHostEnvironment env)
        {
            var dataDirectory = Path.Combine(env.ContentRootPath, "data");
            _filePath = Path.Combine(dataDirectory, "users.json");

            if (!Directory.Exists(dataDirectory))
            {
                Directory.CreateDirectory(dataDirectory);
            }

            if (_users == null)
            {
                if (System.IO.File.Exists(_filePath))
                {
                    var json = System.IO.File.ReadAllText(_filePath);
                    _users = JsonConvert.DeserializeObject<List<User>>(json);
                }
                else
                {
                    _users = new List<User>();
                    SaveUsersToFile();
                }
            }
        }

        private void SaveUsersToFile()
        {
            var json = JsonConvert.SerializeObject(_users, Formatting.Indented);
            System.IO.File.WriteAllText(_filePath, json);
        }

        [HttpGet]
        public IActionResult GetAllUsers()
        {
            return Ok(_users);
        }

        [HttpGet("{id}")]
        public IActionResult GetUser(int id)
        {
            var user = _users.FirstOrDefault(u => u.Id == id);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }

        [HttpPost]
        public IActionResult CreateUser(User user)
        {
            user.Id = _users.Any() ? _users.Max(u => u.Id) + 1 : 1;
            _users.Add(user);
            SaveUsersToFile();
            return CreatedAtAction(nameof(GetUser), new { id = user.Id }, user);
        }

        [HttpPut("{id}")]
        public IActionResult UpdateUser(int id, User updatedUser)
        {
            var user = _users.FirstOrDefault(u => u.Id == id);
            if (user == null)
            {
                return NotFound();
            }
            user.Name = updatedUser.Name;
            user.Email = updatedUser.Email;
            SaveUsersToFile();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteUser(int id)
        {
            var user = _users.FirstOrDefault(u => u.Id == id);
            if (user == null)
            {
                return NotFound();
            }
            _users.Remove(user);
            SaveUsersToFile();
            return NoContent();
        }
    }
}