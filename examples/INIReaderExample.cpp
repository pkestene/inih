// Example that shows simple usage of the INIReader class

#include <iostream>
#include <fstream>
#include <string>
#include <array>
#include "../cpp/INIReader.h"

inline bool file_exists (const std::string& name) {
  std::ifstream f(name.c_str());
  return f.good();
}

int main()
{
  std::array<std::string, 3> filenames { "../examples/test.ini", "../test.ini", "./test.ini" };

  std::string ini_filename = "";
  for (int i = 0; i< filenames.size(); ++i)
  {
    ini_filename = filenames[i];
    if ( file_exists(ini_filename) )
      break;
  }

  INIReader reader(ini_filename);

  if (reader.ParseError() < 0) {
    std::cout << "Can't load '" << ini_filename << "'\n";
    return 1;
  }
  std::cout << "Config loaded from 'test.ini': version="
            << reader.GetInteger("protocol", "version", -1) << ", name="
            << reader.Get("user", "name", "UNKNOWN") << ", email="
            << reader.Get("user", "email", "UNKNOWN") << ", pi="
            << reader.GetReal("user", "pi", -1) << ", active="
            << reader.GetBoolean("user", "active", true) << "\n";
  std::cout << "Has values: user.name=" << reader.HasValue("user", "name")
            << ", user.nose=" << reader.HasValue("user", "nose") << "\n";
  std::cout << "Has sections: user=" << reader.HasSection("user")
            << ", fizz=" << reader.HasSection("fizz") << "\n";
  return 0;
}
