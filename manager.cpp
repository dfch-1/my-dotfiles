#include <iostream>
#include <fstream>
#include <nlohmann/json.hpp>

using namespace std;
using json = nlohmann::json;

void save(const string& language)
{
    fstream input("config.json");
    json config;
    input >> config;
    input.close();

    config["languages"] = language;
    ofstream output("config.json");
    output << config.dump(4);
}


int main()
{
    fstream input("config.json");
    json config;
    input >> config;
    
    string lang;

    cout << "<== Select Language ==>" << endl;
    cout << "(en) English\n(es) Español\n(pt) Português*\n(fr) Français*\n(it) Italiano*\n(ja) 日本語*\n(ru) Русский*" << endl;
    cout << "Insert: ";
    cin >> lang;

    if (config.contains(lang))
    {
        save(lang);
    }
    else
    {
        cout << "error";
    }

    return 0;
}
