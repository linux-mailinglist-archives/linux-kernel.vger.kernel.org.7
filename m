Return-Path: <linux-kernel+bounces-844527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F403BC2213
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E307E3A78ED
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039852E8B6F;
	Tue,  7 Oct 2025 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+QVC1Kz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B4E2D9EE6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855134; cv=none; b=eSZcS2L/n6Jl7h8ahUih+seNz3J3CowBcTg25Ygwma5zjVhG8VLbAJDwJZUdIfixEAMqZmd3l2r+prUODESCgSOIL3Kpb7sF8of8YjZCa9dXhyy4vPXBk9Ev5jQmkWCjWOMKSMQIb4dnhBpzNcjKNiBmzfWt5xEPpQgq6n8Luqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855134; c=relaxed/simple;
	bh=J5OnNEzn8FxV3p2/qpRDm8coFVWni8NbtwUQ85iMavo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qwWUg1JftJQ0o/QmPP/GH/KH3fJ2/eymYWnYPf9DzV8miSpmVKn0eAOALDasmJO4LnKl0ee1pvuA67FV/s0fk1+sXlTqZ5IWmMH4S26PfKDCb+VhNcBFW31E2ic/zp7dA3cXGpEi3iDO+gh2GBPi0j7rNenbHmwfsTv0RLz+VJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+QVC1Kz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3307af9b595so5388334a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759855131; x=1760459931; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTd45WT1hazNfUJVaL/KMB7fCbNJILM67n3Zo28aclc=;
        b=s+QVC1Kz+eCLUB2C+ElnfxN855c2rPN6YDgokepYmNfUkgel54yLCw0Rhh6GHupzVm
         1FT0SDITiFL3g+exiwKD+Xp/oiwmvDjz973zatnndBkkOhMulJ1woPuZinHNfbzFJ6Jd
         uWUvexVj4suDgLSW7u+goIP3NxDm7tyJYZFyORz7T+ihnfF+bqJm6bonLPli6vFgyl0q
         OCom1K5swYP12uLtO2HMNIO5OXyYO5ARS+yHASYM2dH9js0yxLEVjb6mGsk5VKR4MDsS
         nXRNK/1AQ1Hzps9sSCbDgieeXPEdhW1OQjIaFcFm/G8ndOEHhTmX5Zfd136qvRNQnFGz
         xn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855131; x=1760459931;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTd45WT1hazNfUJVaL/KMB7fCbNJILM67n3Zo28aclc=;
        b=fRNmGpzaYy+Eo/dGt7PbPaTSmPL4+3XskXwpWmuvoL4awu1ORFYH5C7VHEQ2BXakzr
         8ar+Q/3lhQd4bISSERsWyqxfcsgoRbIWPjFiggbtOpy92tKUd7/vI6U5ZBEJuFExo/Rk
         4cqldBVQffimN8MzEcmzKdtS5/5hf/Yoe2VRzhy6pgn2tXgbc6AKPuRo467VucB42+Rr
         7bzcRyzSMKB9MNTlGSb28+lhHUGAs5BFckx707ZODOmEnVK9XPU7pBa8Q4ontDoX/M21
         xF6o3XaToVZLs9BF60Y4rH/pZ2usRS+dg6NATfcAs76KdpesU9tWXV4/idYuAIfT1cwk
         6h5w==
X-Forwarded-Encrypted: i=1; AJvYcCWvQR3q/cZ/id8ucQxEKRUG3Kt68Ext3bQFkOJyXu6ZnLsl40Vl/Z8UQ1R63kNJjE0FCdmF0qNMcDu8OCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xNyDrp1Wxoi2ux6sM5GF4WxHhUF+pXEX5sZoMvDTt4V0R72M
	pFkFDe189bGsKKc8YUKCWJSxyxoCwkrlnRj7KrRm07pU5UirQoPWYal3Kcd64wXSM0N+gub68Y4
	uPgm7cmLeUw==
X-Google-Smtp-Source: AGHT+IFWjQRqoY123n5OoDFLt1JXfuf4UgFlneo/oBha+yK82zI6dtPBt5TfeBYt2shRvWr9ap3xNR0pcmk1
X-Received: from plnx7.prod.google.com ([2002:a17:902:8207:b0:267:fa7d:b637])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b0d:b0:27e:ee83:fc80
 with SMTP id d9443c01a7336-2902741f56fmr4292255ad.57.1759855131331; Tue, 07
 Oct 2025 09:38:51 -0700 (PDT)
Date: Tue,  7 Oct 2025 09:38:35 -0700
In-Reply-To: <20251007163835.3152881-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007163835.3152881-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007163835.3152881-4-irogers@google.com>
Subject: [PATCH v8 3/3] perf llvm: Mangle libperf-llvm.so function names
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

For a function like llvm_addr2line having the libperf-llvm.so exported
symbol named llvm_addr2line meant that the perf llvm_addr2line could
sometimes erroneously be returned. This led to infinite recursion and
eventual stack overflow. To avoid this conflict add a new
BUILDING_PERF_LLVMSO when libperf-llvm.so is being built and use it to
alter the behavior of MANGLE_PERF_LLVM_API, a macro that prefixes the
name when libperf-llvm.so is being built. The prefixed named avoids
the name collision.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf           |  3 ++-
 tools/perf/util/llvm-c-helpers.cpp | 29 ++++++++++++++++++-----------
 tools/perf/util/llvm-c-helpers.h   | 24 ++++++++++++++++--------
 3 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 4f0c14c19c99..836dd0c25541 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1002,7 +1002,8 @@ $(LIBSYMBOL)-clean:
 	$(Q)$(RM) -r -- $(LIBSYMBOL_OUTPUT)
 
 ifdef LIBLLVM_DYNAMIC
-LIBPERF_LLVM_CXXFLAGS := $(call filter-out,-DHAVE_LIBLLVM_DYNAMIC,$(CXXFLAGS)) -DHAVE_LIBLLVM_SUPPORT
+LIBPERF_LLVM_CXXFLAGS := $(call filter-out,-DHAVE_LIBLLVM_DYNAMIC,$(CXXFLAGS))
+LIBPERF_LLVM_CXXFLAGS += -DHAVE_LIBLLVM_SUPPORT -DBUILDING_PERF_LLVMSO
 LIBPERF_LLVM_LIBS = -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM) -lstdc++
 
 $(OUTPUT)$(LIBPERF_LLVM): util/llvm-c-helpers.cpp
diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
index 5a6f76e6b705..8cea380be5c2 100644
--- a/tools/perf/util/llvm-c-helpers.cpp
+++ b/tools/perf/util/llvm-c-helpers.cpp
@@ -99,10 +99,12 @@ static int extract_file_and_line(const DILineInfo &line_info, char **file,
 #endif
 
 extern "C"
-int llvm_addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
-		   char **file __maybe_unused, unsigned int *line __maybe_unused,
-		   bool unwind_inlines __maybe_unused,
-		   llvm_a2l_frame **inline_frames __maybe_unused)
+int MANGLE_PERF_LLVM_API(llvm_addr2line)(const char *dso_name __maybe_unused,
+                                         u64 addr __maybe_unused,
+                                         char **file __maybe_unused,
+                                         unsigned int *line __maybe_unused,
+                                         bool unwind_inlines __maybe_unused,
+                                         llvm_a2l_frame **inline_frames __maybe_unused)
 {
 #if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
@@ -177,7 +179,8 @@ int llvm_addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused,
 		if (!handle)
 			return 0;
 
-		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_addr2line"));
+		fn = reinterpret_cast<decltype(fn)>(
+			dlsym(handle, MANGLE_PERF_LLVM_API_STR(llvm_addr2line)));
 		if (!fn)
 			pr_debug("dlsym failed for llvm_addr2line\n");
 		fn_init = true;
@@ -215,8 +218,9 @@ make_symbol_relative_string(struct dso *dso, const char *sym_name,
 #endif
 
 extern "C"
-char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __maybe_unused,
-			 u64 addr __maybe_unused)
+char *MANGLE_PERF_LLVM_API(llvm_name_for_code)(struct dso *dso __maybe_unused,
+					       const char *dso_name __maybe_unused,
+					       u64 addr __maybe_unused)
 {
 #if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
@@ -242,7 +246,8 @@ char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __
 		if (!handle)
 			return NULL;
 
-		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_name_for_code"));
+		fn = reinterpret_cast<decltype(fn)>(
+			dlsym(handle, MANGLE_PERF_LLVM_API_STR(llvm_name_for_code)));
 		if (!fn)
 			pr_debug("dlsym failed for llvm_name_for_code\n");
 		fn_init = true;
@@ -256,8 +261,9 @@ char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *dso_name __
 }
 
 extern "C"
-char *llvm_name_for_data(struct dso *dso __maybe_unused, const char *dso_name __maybe_unused,
-			 u64 addr __maybe_unused)
+char *MANGLE_PERF_LLVM_API(llvm_name_for_data)(struct dso *dso __maybe_unused,
+					       const char *dso_name __maybe_unused,
+					       u64 addr __maybe_unused)
 {
 #if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
 	LLVMSymbolizer *symbolizer = get_symbolizer();
@@ -283,7 +289,8 @@ char *llvm_name_for_data(struct dso *dso __maybe_unused, const char *dso_name __
 		if (!handle)
 			return NULL;
 
-		fn = reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm_name_for_data"));
+		fn = reinterpret_cast<decltype(fn)>(
+			dlsym(handle, MANGLE_PERF_LLVM_API_STR(llvm_name_for_data)));
 		if (!fn)
 			pr_debug("dlsym failed for llvm_name_for_data\n");
 		fn_init = true;
diff --git a/tools/perf/util/llvm-c-helpers.h b/tools/perf/util/llvm-c-helpers.h
index d2b99637a28a..cfcfd540cdae 100644
--- a/tools/perf/util/llvm-c-helpers.h
+++ b/tools/perf/util/llvm-c-helpers.h
@@ -13,6 +13,14 @@
 extern "C" {
 #endif
 
+/* Support name mangling so that libperf_llvm.so's names don't match those in perf. */
+#ifdef BUILDING_PERF_LLVMSO
+#define MANGLE_PERF_LLVM_API(x) PERF_LLVM_SO_ ## x
+#else
+#define MANGLE_PERF_LLVM_API(x) x
+#endif
+#define MANGLE_PERF_LLVM_API_STR(x) "PERF_LLVM_SO_" #x
+
 struct dso;
 
 struct llvm_a2l_frame {
@@ -37,12 +45,12 @@ struct llvm_a2l_frame {
  * a newly allocated array with that length. The caller is then responsible
  * for freeing both the strings and the array itself.
  */
-int llvm_addr2line(const char* dso_name,
-                   u64 addr,
-                   char** file,
-                   unsigned int* line,
-                   bool unwind_inlines,
-                   struct llvm_a2l_frame** inline_frames);
+int MANGLE_PERF_LLVM_API(llvm_addr2line)(const char *dso_name,
+					 u64 addr,
+					 char **file,
+					 unsigned int *line,
+					 bool unwind_inlines,
+					 struct llvm_a2l_frame **inline_frames);
 
 /*
  * Simple symbolizers for addresses; will convert something like
@@ -50,8 +58,8 @@ int llvm_addr2line(const char* dso_name,
  *
  * The returned value must be freed by the caller, with free().
  */
-char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 addr);
-char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 addr);
+char *MANGLE_PERF_LLVM_API(llvm_name_for_code)(struct dso *dso, const char *dso_name, u64 addr);
+char *MANGLE_PERF_LLVM_API(llvm_name_for_data)(struct dso *dso, const char *dso_name, u64 addr);
 
 #ifdef __cplusplus
 }
-- 
2.51.0.618.g983fd99d29-goog


