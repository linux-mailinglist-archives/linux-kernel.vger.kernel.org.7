Return-Path: <linux-kernel+bounces-844526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D21BC221C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3C524F788D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42702E8B7E;
	Tue,  7 Oct 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HFCcofH"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788F2E7F39
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855132; cv=none; b=OjADAICI+MEaDps7fOABv3qJzwj6taIgI2pdaNOfA/PoDTLW9J1G419yM7N2FVf46j7vWuXCxNe8mtDnaw1LJw1KwNN1RmM4svqHih6EWKZWtPvvq8SAervsIxvTariQe8rJcuK3p9tSfn4NlIkE4ckbSFXXbx73mbs/Oo46Sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855132; c=relaxed/simple;
	bh=vjBojTequ849KhZx+OPWHUbBQuP1UVh8cdIGEgxW1PM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Sjj0C+LDUGR/ikNyayYTjbWQ4ahtoVmmZssH4XTcyjf/V/etsUB9XxxTnDV+m8AGXA0WKM2L23mooOCNMgkq4sP+mgFJtTq2S5oJCM+OX2jHmrwyAzSDavbyjog4bt5IJ7SoDrI1X/NkNwcQg/DRdZ4LjS2zq+oh2m2HbU5JdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HFCcofH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-277f0ea6ee6so83068305ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759855129; x=1760459929; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aknB5XtYstC1k8gPyqIF/B9vqIEpJ+aC+pWYHL1W2i0=;
        b=1HFCcofHNBGaT2CjxkXdj9044kAMX3w2Y0zRjLv2NlOOn41Sc4rPcGMmTNMk5RIPkg
         SLmgAxGZd1sFgfKKBXx95PBCyP3ikVTlQADALjMw7/y5Isodfrq8aC15qbUfRbDVtt/u
         3SLrD6Bj2P04Mm9x988IY900S4AuCMTS3yeLyAfwT3oyfdyOtbllgHomTLsu5ZwzyluB
         62JUfXj8M8Km5yvKWvvguMpLJp9FuJ06ITa433pXPz/hqeQfr7VtBnAITj43tlzHmTXK
         LrILhwybAqjg2yYgXTjKxgB20Cov4qaqOoHSFLANDNEAe/8kCsJE4Su/gYZO3WR31vEZ
         3a7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855129; x=1760459929;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aknB5XtYstC1k8gPyqIF/B9vqIEpJ+aC+pWYHL1W2i0=;
        b=sw1Qv6Eg5mrvOTWGzquG0WAtHy6PzzWWSSIl001I5nAFZIyPACia9ce1tsHCqoIvZs
         /quIR9BnX0oH8jcLEtYnoxO6MK4KhmEbOH2e2S1pkr6AB7rD2J95NN8Dinpj5q9zyqKp
         ZMNrv7AsaBvPoRgEPx5nQxVWJf5xDSMOpwMBUclD0zkCwD1vS0JJk0SSUvy1BZ4xqwNe
         eHaZijVKLxdBoGpHqU5omHv8gROeU7goJWP6rhXRf355ln+l1jeI5Gq6IFk9Dogfopxu
         Ls8Thrk+eoaHiyzegSRi2ve84X1jGujYC5F9Lc/TdYaWK4yqX+J1eIicqtrWE3S1W5nS
         oMVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7DdKa6V8GEmyfmLIJlIqNJ/ebhQg6aeSDdrPr3pyreKyC4jnQzrtmFFXRQeLMlQgm3CVfIneblKs4h4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+x1RAJPlHnWZI25iz68oEaioW/UqvfeNmKKjQjEMjDq+CV3a
	BbX/l22CJS1cP5ZcRZ5nSkU84oLwDbYe9/v6W32CjX4b4xrIaijAh8AXo55h2bFRMWKhIv2fozf
	fHS4JO4DOjg==
X-Google-Smtp-Source: AGHT+IFumipIDmxGOd1v2qwIxlRD1uQtmlTRmYZTQTsZloDV0ToR5PhglLf5frNoGS7geXkGSiodQECriur9
X-Received: from plbja12.prod.google.com ([2002:a17:902:efcc:b0:260:3d:8a7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:388c:b0:269:a4ed:13c3
 with SMTP id d9443c01a7336-290272161edmr5346495ad.5.1759855129058; Tue, 07
 Oct 2025 09:38:49 -0700 (PDT)
Date: Tue,  7 Oct 2025 09:38:34 -0700
In-Reply-To: <20251007163835.3152881-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007163835.3152881-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007163835.3152881-3-irogers@google.com>
Subject: [PATCH v8 2/3] perf llvm: Support for dlopen-ing libLLVM.so
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

If perf wasn't built against libLLVM, no HAVE_LIBLLVM_SUPPORT, support
dlopen-ing libLLVM.so and then calling the necessary functions by
looking them up using dlsym.

As the C++ code in llvm-c-helpers used for addr2line is problematic to
call using dlsym by default don't support its use if
HAVE_LIBLLVM_SUPPORT isn't present. Add a new build option
LIBLLVM_DYNAMIC=1 that builds a separate shared object called
libperf-llvm.so containing the LLVM addr2line functionality and
support dynamic loading of it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         |  13 ++
 tools/perf/Makefile.perf           |  23 ++-
 tools/perf/tests/make              |   2 +
 tools/perf/util/Build              |   2 +-
 tools/perf/util/llvm-c-helpers.cpp | 113 +++++++++++-
 tools/perf/util/llvm.c             | 273 +++++++++++++++++++++++++----
 6 files changed, 388 insertions(+), 38 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5700516aa84a..ca8857b00b5c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -991,6 +991,19 @@ ifndef NO_LIBLLVM
     NO_LIBLLVM := 1
   endif
 endif
+ifdef LIBLLVM_DYNAMIC
+  ifndef NO_LIBLLVM
+    $(error LIBLLVM_DYNAMIC should be used with NO_LIBLLVM)
+  endif
+  $(call feature_check,llvm-perf)
+  ifneq ($(feature-llvm-perf), 1)
+    $(warning LIBLLVM_DYNAMIC requires libLLVM.so which wasn't feature detected)
+  endif
+  CFLAGS += -DHAVE_LIBLLVM_DYNAMIC
+  CFLAGS += $(shell $(LLVM_CONFIG) --cflags)
+  CXXFLAGS += -DHAVE_LIBLLVM_DYNAMIC
+  CXXFLAGS += $(shell $(LLVM_CONFIG) --cxxflags)
+endif
 
 ifndef NO_DEMANGLE
   $(call feature_check,cxa-demangle)
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..4f0c14c19c99 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -423,6 +423,12 @@ ifndef NO_JVMTI
 PROGRAMS += $(OUTPUT)$(LIBJVMTI)
 endif
 
+LIBPERF_LLVM = libperf-llvm.so
+
+ifdef LIBLLVM_DYNAMIC
+PROGRAMS += $(OUTPUT)$(LIBPERF_LLVM)
+endif
+
 DLFILTERS := dlfilter-test-api-v0.so dlfilter-test-api-v2.so dlfilter-show-cycles.so
 DLFILTERS := $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
 
@@ -995,6 +1001,16 @@ $(LIBSYMBOL)-clean:
 	$(call QUIET_CLEAN, libsymbol)
 	$(Q)$(RM) -r -- $(LIBSYMBOL_OUTPUT)
 
+ifdef LIBLLVM_DYNAMIC
+LIBPERF_LLVM_CXXFLAGS := $(call filter-out,-DHAVE_LIBLLVM_DYNAMIC,$(CXXFLAGS)) -DHAVE_LIBLLVM_SUPPORT
+LIBPERF_LLVM_LIBS = -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM) -lstdc++
+
+$(OUTPUT)$(LIBPERF_LLVM): util/llvm-c-helpers.cpp
+	$(QUIET_LINK)$(CXX) $(LIBPERF_LLVM_CXXFLAGS) $(LIBPERF_LLVM_LIBS) -shared -o $@ $<
+
+$(OUTPUT)perf: $(OUTPUT)$(LIBPERF_LLVM)
+endif
+
 help:
 	@echo 'Perf make targets:'
 	@echo '  doc		- make *all* documentation (see below)'
@@ -1096,6 +1112,11 @@ ifndef NO_JVMTI
 	$(call QUIET_INSTALL, $(LIBJVMTI)) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
 		$(INSTALL) $(OUTPUT)$(LIBJVMTI) '$(DESTDIR_SQ)$(libdir_SQ)';
+endif
+ifdef LIBLLVM_DYNAMIC
+	$(call QUIET_INSTALL, $(LIBPERF_LLVM)) \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
+		$(INSTALL) $(OUTPUT)$(LIBPERF_LLVM) '$(DESTDIR_SQ)$(libdir_SQ)';
 endif
 	$(call QUIET_INSTALL, libexec) \
 		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
@@ -1281,7 +1302,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		-name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name '*.shellcheck_log' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
 	$(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-read-vdso32 \
-		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
+		perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI) $(OUTPUT)$(LIBPERF_LLVM)
 	$(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc */*.pyo \
 		$(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VERSION-FILE \
 		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index b650ce8864ed..691c7a7fc463 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -93,6 +93,7 @@ make_no_libbpf	    := NO_LIBBPF=1
 make_libbpf_dynamic := LIBBPF_DYNAMIC=1
 make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
 make_no_libllvm     := NO_LIBLLVM=1
+make_libllvm_dynamic := NO_LIBLLVM=1 LIBLLVM_DYNAMIC=1
 make_with_babeltrace:= LIBBABELTRACE=1
 make_with_coresight := CORESIGHT=1
 make_no_sdt	    := NO_SDT=1
@@ -162,6 +163,7 @@ run += make_no_auxtrace
 run += make_no_libbpf
 run += make_no_libbpf_DEBUG
 run += make_no_libllvm
+run += make_libllvm_dynamic
 run += make_no_sdt
 run += make_no_syscall_tbl
 run += make_with_babeltrace
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 4be313cd115a..8cc9b08790a3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -27,6 +27,7 @@ perf-util-y += find_bit.o
 perf-util-y += levenshtein.o
 perf-util-$(CONFIG_LIBBFD) += libbfd.o
 perf-util-y += llvm.o
+perf-util-y += llvm-c-helpers.o
 perf-util-y += mmap.o
 perf-util-y += memswap.o
 perf-util-y += parse-events.o
@@ -249,7 +250,6 @@ perf-util-$(CONFIG_CXX_DEMANGLE) += demangle-cxx.o
 perf-util-y += demangle-ocaml.o
 perf-util-y += demangle-java.o
 perf-util-y += demangle-rust-v0.o
-perf-util-$(CONFIG_LIBLLVM) += llvm-c-helpers.o
 
 CFLAGS_demangle-rust-v0.o += -Wno-shadow -Wno-declaration-after-statement \
     -Wno-switch-default -Wno-switch-enum -Wno-missing-field-initializers
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 004081bd12c9..5a6f76e6b705 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -5,17 +5,23 @@
  * macros (e.g. noinline) that conflict with compiler builtins used
  * by LLVM.
  */
+#ifdef HAVE_LIBLLVM_SUPPORT
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM <= 15 */
 #include <llvm/DebugInfo/Symbolize/Symbolize.h>
 #include <llvm/Support/TargetSelect.h>
 #pragma GCC diagnostic pop
+#endif
 
+#if !defined(HAVE_LIBLLVM_SUPPORT) || defined(HAVE_LIBLLVM_DYNAMIC)
+#include <dlfcn.h>
+#endif
 #include <inttypes.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <linux/compiler.h>
 extern "C" {
+#include "debug.h"
 #include <linux/zalloc.h>
 }
 #include "llvm-c-helpers.h"
@@ -23,14 +29,33 @@ extern "C" {
 extern "C"
 char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_name);
 
+#ifdef HAVE_LIBLLVM_SUPPORT
 using namespace llvm;
 using llvm::symbolize::LLVMSymbolizer;
+#endif
+
+#if !defined(HAVE_LIBLLVM_SUPPORT) && defined(HAVE_LIBLLVM_DYNAMIC)
+static void *perf_llvm_c_helpers_dll_handle(void)
+{
+	static bool dll_handle_init;
+	static void *dll_handle;
+
+	if (!dll_handle_init) {
+		dll_handle_init = true;
+		dll_handle = dlopen("libperf-llvm.so", RTLD_LAZY);
+		if (!dll_handle)
+			pr_debug("dlopen failed for libperf-llvm.so\n");
+	}
+	return dll_handle;
+}
+#endif
 
 /*
  * Allocate a static LLVMSymbolizer, which will live to the end of the program.
  * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do not need
  * to store anything in the dso struct.
  */
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 static LLVMSymbolizer *get_symbolizer()
 {
 	static LLVMSymbolizer *instance = nullptr;
@@ -49,8 +74,10 @@ static LLVMSymbolizer *get_symbolizer()
 	}
 	return instance;
 }
+#endif
 
 /* Returns 0 on error, 1 on success. */
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 static int extract_file_and_line(const DILineInfo &line_info, char **file,
 				 unsigned int *line)
 {
@@ -69,13 +96,15 @@ static int extract_file_and_line(const DILineInfo &line_info, char **file,
 		*line = line_info.Line;
 	return 1;
 }
+#endif
 
 extern "C"
-int llvm_addr2line(const char *dso_name, u64 addr,
-		   char **file, unsigned int *line,
-		   bool unwind_inlines,
-		   llvm_a2l_frame **inline_frames)
+int llvm_addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
+		   char **file __maybe_unused, unsigned int *line __maybe_unused,
+		   bool unwind_inlines __maybe_unused,
+		   llvm_a2l_frame **inline_frames __maybe_unused)
 {
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
 	object::SectionedAddress sectioned_addr = {
 		addr,
@@ -135,8 +164,33 @@ int llvm_addr2line(const char *dso_name, u64 addr,
 			return 0;
 		return extract_file_and_line(*res_or_err, file, line);
 	}
+#elif defined(HAVE_LIBLLVM_DYNAMIC)
+	static bool fn_init;
+	static int (*fn)(const char *dso_name, u64 addr,
+			 char **file, unsigned int *line,
+			 bool unwind_inlines,
+			 llvm_a2l_frame **inline_frames);
+
+	if (!fn_init) {
+		void * handle = perf_llvm_c_helpers_dll_handle();
+
+		if (!handle)
+			return 0;
+
+		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_addr2line"));
+		if (!fn)
+			pr_debug("dlsym failed for llvm_addr2line\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return 0;
+	return fn(dso_name, addr, file, line, unwind_inlines, inline_frames);
+#else
+	return 0;
+#endif
 }
 
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 static char *
 make_symbol_relative_string(struct dso *dso, const char *sym_name,
 			    u64 addr, u64 base_addr)
@@ -158,10 +212,13 @@ make_symbol_relative_string(struct dso *dso, const char *sym_name,
 			return strdup(sym_name);
 	}
 }
+#endif
 
 extern "C"
-char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr)
+char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __maybe_unused,
+			 u64 addr __maybe_unused)
 {
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
 	object::SectionedAddress sectioned_addr = {
 		addr,
@@ -175,11 +232,34 @@ char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr)
 	return make_symbol_relative_string(
 		dso, res_or_err->FunctionName.c_str(),
 		addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
+#elif defined(HAVE_LIBLLVM_DYNAMIC)
+	static bool fn_init;
+	static char *(*fn)(struct dso *dso, const char *dso_name, u64 addr);
+
+	if (!fn_init) {
+		void * handle = perf_llvm_c_helpers_dll_handle();
+
+		if (!handle)
+			return NULL;
+
+		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_name_for_code"));
+		if (!fn)
+			pr_debug("dlsym failed for llvm_name_for_code\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return NULL;
+	return fn(dso, dso_name, addr);
+#else
+	return 0;
+#endif
 }
 
 extern "C"
-char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr)
+char *llvm_name_for_data(struct dso *dso __maybe_unused, const char *dso_name __maybe_unused,
+			 u64 addr __maybe_unused)
 {
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
 	object::SectionedAddress sectioned_addr = {
 		addr,
@@ -193,4 +273,25 @@ char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr)
 	return make_symbol_relative_string(
 		dso, res_or_err->Name.c_str(),
 		addr, res_or_err->Start);
+#elif defined(HAVE_LIBLLVM_DYNAMIC)
+	static bool fn_init;
+	static char *(*fn)(struct dso *dso, const char *dso_name, u64 addr);
+
+	if (!fn_init) {
+		void * handle = perf_llvm_c_helpers_dll_handle();
+
+		if (!handle)
+			return NULL;
+
+		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_name_for_data"));
+		if (!fn)
+			pr_debug("dlsym failed for llvm_name_for_data\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return NULL;
+	return fn(dso, dso_name, addr);
+#else
+	return 0;
+#endif
 }
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 2ebf1f5f65bf..10def66ce8b2 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "llvm.h"
+#include "llvm-c-helpers.h"
 #include "annotate.h"
 #include "debug.h"
 #include "dso.h"
@@ -7,18 +8,244 @@
 #include "namespaces.h"
 #include "srcline.h"
 #include "symbol.h"
+#include <dlfcn.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <unistd.h>
 #include <linux/zalloc.h>
 
-#ifdef HAVE_LIBLLVM_SUPPORT
-#include "llvm-c-helpers.h"
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 #include <llvm-c/Disassembler.h>
 #include <llvm-c/Target.h>
+#else
+typedef void *LLVMDisasmContextRef;
+typedef int (*LLVMOpInfoCallback)(void *dis_info, uint64_t pc, uint64_t offset,
+				  uint64_t op_size, uint64_t inst_size,
+				  int tag_type, void *tag_buf);
+typedef const char *(*LLVMSymbolLookupCallback)(void *dis_info,
+						uint64_t reference_value,
+						uint64_t *reference_type,
+						uint64_t reference_pc,
+						const char **reference_name);
+#define LLVMDisassembler_ReferenceType_InOut_None 0
+#define LLVMDisassembler_ReferenceType_In_Branch 1
+#define LLVMDisassembler_ReferenceType_In_PCrel_Load 2
+#define LLVMDisassembler_Option_PrintImmHex 2
+#define LLVMDisassembler_Option_AsmPrinterVariant 4
+const char *llvm_targets[] = {
+	"AMDGPU",
+	"ARM",
+	"AVR",
+	"BPF",
+	"Hexagon",
+	"Lanai",
+	"LoongArch",
+	"Mips",
+	"MSP430",
+	"NVPTX",
+	"PowerPC",
+	"RISCV",
+	"Sparc",
+	"SystemZ",
+	"VE",
+	"WebAssembly",
+	"X86",
+	"XCore",
+	"M68k",
+	"Xtensa",
+};
+#endif
+
+#if !defined(HAVE_LIBLLVM_SUPPORT) || defined(HAVE_LIBLLVM_DYNAMIC)
+static void *perf_llvm_dll_handle(void)
+{
+	static bool dll_handle_init;
+	static void *dll_handle;
+
+	if (!dll_handle_init) {
+		dll_handle_init = true;
+		dll_handle = dlopen("libLLVM.so", RTLD_LAZY);
+		if (!dll_handle)
+			pr_debug("dlopen failed for libLLVM.so\n");
+	}
+	return dll_handle;
+}
+#endif
+
+#if !defined(HAVE_LIBLLVM_SUPPORT) || defined(HAVE_LIBLLVM_DYNAMIC)
+static void *perf_llvm_dll_fun(const char *fmt, const char *target)
+{
+	char buf[128];
+	void *fn;
+
+	snprintf(buf, sizeof(buf), fmt, target);
+	fn = dlsym(perf_llvm_dll_handle(), buf);
+	if (!fn)
+		pr_debug("dlsym failed for %s\n", buf);
+
+	return fn;
+}
+#endif
+
+static void perf_LLVMInitializeAllTargetInfos(void)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	LLVMInitializeAllTargetInfos();
+#else
+	/* LLVMInitializeAllTargetInfos is a header file function not available as a symbol. */
+	static bool done_init;
+
+	if (done_init)
+		return;
+
+	for (size_t i = 0; i < ARRAY_SIZE(llvm_targets); i++) {
+		void (*fn)(void) = perf_llvm_dll_fun("LLVMInitialize%sTargetInfo",
+						     llvm_targets[i]);
+
+		if (!fn)
+			continue;
+		fn();
+	}
+	done_init = true;
+#endif
+}
+
+static void perf_LLVMInitializeAllTargetMCs(void)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	LLVMInitializeAllTargetMCs();
+#else
+	/* LLVMInitializeAllTargetMCs is a header file function not available as a symbol. */
+	static bool done_init;
+
+	if (done_init)
+		return;
+
+	for (size_t i = 0; i < ARRAY_SIZE(llvm_targets); i++) {
+		void (*fn)(void) = perf_llvm_dll_fun("LLVMInitialize%sTargetMC",
+						     llvm_targets[i]);
+
+		if (!fn)
+			continue;
+		fn();
+	}
+	done_init = true;
+#endif
+}
+
+static void perf_LLVMInitializeAllDisassemblers(void)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	LLVMInitializeAllDisassemblers();
+#else
+	/* LLVMInitializeAllDisassemblers is a header file function not available as a symbol. */
+	static bool done_init;
+
+	if (done_init)
+		return;
+
+	for (size_t i = 0; i < ARRAY_SIZE(llvm_targets); i++) {
+		void (*fn)(void) = perf_llvm_dll_fun("LLVMInitialize%sDisassembler",
+						     llvm_targets[i]);
+
+		if (!fn)
+			continue;
+		fn();
+	}
+	done_init = true;
+#endif
+}
+
+static LLVMDisasmContextRef perf_LLVMCreateDisasm(const char *triple_name, void *dis_info,
+						int tag_type, LLVMOpInfoCallback get_op_info,
+						LLVMSymbolLookupCallback symbol_lookup)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	return LLVMCreateDisasm(triple_name, dis_info, tag_type, get_op_info, symbol_lookup);
+#else
+	static bool fn_init;
+	static LLVMDisasmContextRef (*fn)(const char *triple_name, void *dis_info,
+					int tag_type, LLVMOpInfoCallback get_op_info,
+					LLVMSymbolLookupCallback symbol_lookup);
+
+	if (!fn_init) {
+		fn = dlsym(perf_llvm_dll_handle(), "LLVMCreateDisasm");
+		if (!fn)
+			pr_debug("dlsym failed for LLVMCreateDisasm\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return NULL;
+	return fn(triple_name, dis_info, tag_type, get_op_info, symbol_lookup);
+#endif
+}
+
+static int perf_LLVMSetDisasmOptions(LLVMDisasmContextRef context, uint64_t options)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	return LLVMSetDisasmOptions(context, options);
+#else
+	static bool fn_init;
+	static int (*fn)(LLVMDisasmContextRef context, uint64_t options);
+
+	if (!fn_init) {
+		fn = dlsym(perf_llvm_dll_handle(), "LLVMSetDisasmOptions");
+		if (!fn)
+			pr_debug("dlsym failed for LLVMSetDisasmOptions\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return 0;
+	return fn(context, options);
+#endif
+}
+
+static size_t perf_LLVMDisasmInstruction(LLVMDisasmContextRef context, uint8_t *bytes,
+					uint64_t bytes_size, uint64_t pc,
+					char *out_string, size_t out_string_size)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	return LLVMDisasmInstruction(context, bytes, bytes_size, pc, out_string, out_string_size);
+#else
+	static bool fn_init;
+	static int (*fn)(LLVMDisasmContextRef context, uint8_t *bytes,
+			uint64_t bytes_size, uint64_t pc,
+			char *out_string, size_t out_string_size);
+
+	if (!fn_init) {
+		fn = dlsym(perf_llvm_dll_handle(), "LLVMDisasmInstruction");
+		if (!fn)
+			pr_debug("dlsym failed for LLVMDisasmInstruction\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return 0;
+	return fn(context, bytes, bytes_size, pc, out_string, out_string_size);
+#endif
+}
+
+static void perf_LLVMDisasmDispose(LLVMDisasmContextRef context)
+{
+#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
+	LLVMDisasmDispose(context);
+#else
+	static bool fn_init;
+	static int (*fn)(LLVMDisasmContextRef context);
+
+	if (!fn_init) {
+		fn = dlsym(perf_llvm_dll_handle(), "LLVMDisasmDispose");
+		if (!fn)
+			pr_debug("dlsym failed for LLVMDisasmDispose\n");
+		fn_init = true;
+	}
+	if (!fn)
+		return;
+	fn(context);
 #endif
+}
+
 
-#ifdef HAVE_LIBLLVM_SUPPORT
 static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
 				    int num_frames)
 {
@@ -30,14 +257,12 @@ static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
 		zfree(&inline_frames);
 	}
 }
-#endif
 
 int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
 		     char **file __maybe_unused, unsigned int *line __maybe_unused,
 		     struct dso *dso __maybe_unused, bool unwind_inlines __maybe_unused,
 		     struct inline_node *node __maybe_unused, struct symbol *sym __maybe_unused)
 {
-#ifdef HAVE_LIBLLVM_SUPPORT
 	struct llvm_a2l_frame *inline_frames = NULL;
 	int num_frames = llvm_addr2line(dso_name, addr, file, line,
 					node && unwind_inlines, &inline_frames);
@@ -65,20 +290,16 @@ int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused
 	free_llvm_inline_frames(inline_frames, num_frames);
 
 	return num_frames;
-#else
-	return -1;
-#endif
 }
 
-#ifdef HAVE_LIBLLVM_SUPPORT
 static void init_llvm(void)
 {
 	static bool init;
 
 	if (!init) {
-		LLVMInitializeAllTargetInfos();
-		LLVMInitializeAllTargetMCs();
-		LLVMInitializeAllDisassemblers();
+		perf_LLVMInitializeAllTargetInfos();
+		perf_LLVMInitializeAllTargetMCs();
+		perf_LLVMInitializeAllDisassemblers();
 		init = true;
 	}
 }
@@ -111,12 +332,10 @@ symbol_lookup_callback(void *disinfo, uint64_t value,
 	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
 	return NULL;
 }
-#endif
 
 int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 			     struct annotate_args *args __maybe_unused)
 {
-#ifdef HAVE_LIBLLVM_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
@@ -149,15 +368,15 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	if (arch__is(args->arch, "x86")) {
 		const char *triplet = is_64bit ? "x86_64-pc-linux" : "i686-pc-linux";
 
-		disasm = LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
-					  /*get_op_info=*/NULL, symbol_lookup_callback);
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	} else {
 		char triplet[64];
 
 		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
 			  args->arch->name);
-		disasm = LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
-					  /*get_op_info=*/NULL, symbol_lookup_callback);
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	}
 
 	if (disasm == NULL)
@@ -165,8 +384,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 
 	if (args->options->disassembler_style &&
 	    !strcmp(args->options->disassembler_style, "intel"))
-		LLVMSetDisasmOptions(disasm,
-				     LLVMDisassembler_Option_AsmPrinterVariant);
+		perf_LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_AsmPrinterVariant);
 
 	/*
 	 * This needs to be set after AsmPrinterVariant, due to a bug in LLVM;
@@ -174,7 +392,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	 * forget about the PrintImmHex flag (which is applied before if both
 	 * are given to the same call).
 	 */
-	LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex);
+	perf_LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex);
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
@@ -203,9 +421,9 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 		 * LLVM's API has the code be disassembled as non-const, cast
 		 * here as we may be disassembling from mapped read-only memory.
 		 */
-		ins_len = LLVMDisasmInstruction(disasm, (u8 *)(buf + offset),
-						buf_len - offset, pc,
-						disasm_buf, sizeof(disasm_buf));
+		ins_len = perf_LLVMDisasmInstruction(disasm, (u8 *)(buf + offset),
+						     buf_len - offset, pc,
+						     disasm_buf, sizeof(disasm_buf));
 		if (ins_len == 0)
 			goto err;
 		disasm_len = strlen(disasm_buf);
@@ -261,13 +479,8 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	ret = 0;
 
 err:
-	LLVMDisasmDispose(disasm);
+	perf_LLVMDisasmDispose(disasm);
 	free(code_buf);
 	free(line_storage);
 	return ret;
-#else // HAVE_LIBLLVM_SUPPORT
-	pr_debug("The LLVM disassembler isn't linked in for %s in %s\n",
-		 sym->name, filename);
-	return -1;
-#endif
 }
-- 
2.51.0.618.g983fd99d29-goog


