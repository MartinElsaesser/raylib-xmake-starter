add_rules("mode.debug", "mode.release")

add_requires("raylib")

target("xmake-test")
    set_kind("binary")
    add_packages("raylib")
    add_files("src/*.c")

    -- copy assets
    set_configdir("$(buildir)/$(plat)/$(arch)/$(mode)")
    add_configfiles("src/(resources/*.png)", {onlycopy = true})


    -- hide console window on windows release builds
    if is_plat("windows") and is_mode("release") then
        -- linker options as specified in https://learn.microsoft.com/en-us/cpp/build/reference/entry-entry-point-symbol?view=msvc-170
        add_ldflags("/SUBSYSTEM:WINDOWS", {force = true})
        add_ldflags("/ENTRY:mainCRTStartup", {force = true}) -- TODO: https://stackoverflow.com/questions/22934206/what-is-the-difference-between-main-and-maincrtstartup
    end


    -- optimization? TODO: research
    if is_mode("release") then
        set_symbols("hidden")
        set_optimize("fastest")
        set_strip("all")
    end

--
-- If you want to known more usage about xmake, please see https://xmake.io
--
-- ## FAQ
--
-- You can enter the project directory firstly before building project.
--
--   $ cd projectdir
--
-- 1. How to build project?
--
--   $ xmake
--
-- 2. How to configure project?
--
--   $ xmake f -p [macosx|linux|iphoneos ..] -a [x86_64|i386|arm64 ..] -m [debug|release]
--
-- 3. Where is the build output directory?
--
--   The default output directory is `./build` and you can configure the output directory.
--
--   $ xmake f -o outputdir
--   $ xmake
--
-- 4. How to run and debug target after building project?
--
--   $ xmake run [targetname]
--   $ xmake run -d [targetname]
--
-- 5. How to install target to the system directory or other output directory?
--
--   $ xmake install
--   $ xmake install -o installdir
--
-- 6. Add some frequently-used compilation flags in xmake.lua
--
-- @code
--    -- add debug and release modes
--    add_rules("mode.debug", "mode.release")
--
--    -- add macro definition
--    add_defines("NDEBUG", "_GNU_SOURCE=1")
--
--    -- set warning all as error
--    set_warnings("all", "error")
--
--    -- set language: c99, c++11
--    set_languages("c99", "c++11")
--
--    -- set optimization: none, faster, fastest, smallest
--    set_optimize("fastest")
--
--    -- add include search directories
--    add_includedirs("/usr/include", "/usr/local/include")
--
--    -- add link libraries and search directories
--    add_links("tbox")
--    add_linkdirs("/usr/local/lib", "/usr/lib")
--
--    -- add system link libraries
--    add_syslinks("z", "pthread")
--
--    -- add compilation and link flags
--    add_cxflags("-stdnolib", "-fno-strict-aliasing")
--    add_ldflags("-L/usr/local/lib", "-lpthread", {force = true})
--
-- @endcode
--

