project "nfd"
    kind "StaticLib"
    staticruntime "on"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")
    
    includedirs { "src/include/" }

    files
    {
        "src/*.h",
        "src/include/*.h",
        "src/nfd_common.c"
    }

    filter "system:windows"
        systemversion "latest"
        language "C++"
        files { "src/nfd_win.cpp " }
        
	filter "system:linux"
		systemversion "latest"
        language "C"
        files { "src/nfd_gtk.c" }
        buildoptions { "`pkg-config --cflags gtk+-3.0`" }
        linkoptions {"-lnfd `pkg-config --libs gtk+-3.0`"}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"