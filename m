Return-Path: <linux-kernel+bounces-842463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45CBBCC52
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0260118956FC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0462C08CA;
	Sun,  5 Oct 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FcMFlUpn"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B238D2BFC60
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699351; cv=none; b=l9zQ1KhG1/Qt3EdRFfJmITiP8TzuUe1u6SiXJaAC4LH5xOt1mYteB+s3ZBjhStPjcupKm7BT5OhyqdL6XHJY0Sa6wxWBT1YrvU263ozuk3csO1RcwvnQbqqlooq/CQSV8gDjehMQPFyYHEAk1G3UWnMO/LbNCoclNM1UblbNF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699351; c=relaxed/simple;
	bh=CCQPc58TSvr0cy3nKc2lprmjbQNbCaQTJI1JHBO4fZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UYocnPRfrr0SBI4jycFGNAR+2wAFOzwg/Jfxbu+5X537u6ltlJHrUCR0HQOpAjDnKVdfxFZFqkaty7tiEHN2BMBZGgKhii8rueINW6ABRAo5augz8q3OSodEHAiAONrFwX0AT8v2Yxg+18+CTySFzEO89+I4lrXA0+O8jzJXx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FcMFlUpn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269af520712so44405865ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699349; x=1760304149; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDQxJshrzMcNiF4ov5sFxJSEj5wisWjGXrUgTQiuK7I=;
        b=FcMFlUpndp5sInmz+zA9xLYJFRMm/CTgTtgtTNcOhjRvz4J0mgodt3RxPwrb0W38Pi
         gxg383Tcx+22FaNNcs86Quchuz4JH10ckxtRAKVKKwCH/r1HtydSBQi2aGujlrhRacxb
         D39JIG2QNgqU//gjQUah5e/UdOLOQSFYNrfPR2LV0U2EF5VQDnNIS9ChyM8fM7IvYyIa
         zKi3M7kMBfvuvDo613WLjYEaWghu4aotaByfaRc8iVueRqK1WLfofzH8Mcl6nm2JaoRk
         a5B3bNLQFow7k2C8J7qtVDcvEiYdH3HzO5X6kKRkj91ogrnOmT/m4x86SiO7ddy2ZZ0i
         EFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699349; x=1760304149;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDQxJshrzMcNiF4ov5sFxJSEj5wisWjGXrUgTQiuK7I=;
        b=s070wKoy5v6+Ao99vcGUDXQg3CiNnnoG/2RriXf6gmQitd58j7nhYM8hH4ajN54/Ej
         OBy8l7raCjIOEXfdfWkWebVfRUrTrp4tYAhf2hSS5poDyaDtp3xlTkitw14FWShTUEgp
         4+Uph43J5vXhdSLCWzkD4ApUZOm+tC+lmThPvC/LQ92izbvnq44A1Me8iuwKo9vTyzcO
         /42jSRLtkF0Zv8zWDHB7kalaCWMDv80W5GnYqh5l10uPA8PqdT+2HfL/y67xsbzGaGsr
         ITXP5Rttk1vpylMx0QbiRlWzArRcTyW2aNzdkXRUmCGktt3kHoEBuj93zjioQMtimhl/
         TRow==
X-Forwarded-Encrypted: i=1; AJvYcCX3/x6NmaXikja/0KGdoOC7vUYDsOVJSA8jxK8hO4sBE5ci3K0FmBx1vDszJz0PHlP+uQ4Z0B0TXk+JWCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcG6//zlua049YmymZe1q5Cs9mxbjbn9XE1WrB5MNR+UwPDwUn
	C4sie0zJawjfyLm86XAvP4g6/rqRSVcS6StdcsJUglM4GGDX23dLHeaf4/Ckp62MzpOrEy7V18k
	m3eznpFCubw==
X-Google-Smtp-Source: AGHT+IHNmdwNHNGJJio68vZQzxJW4gUw2wiEz4abGSKgXJDJaQ0VM0ja+fEKLhEkaSVx43BLmivRKC1zYmpG
X-Received: from plps1.prod.google.com ([2002:a17:902:9881:b0:24c:966a:4a6b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0c:b0:24b:25f:5f81
 with SMTP id d9443c01a7336-28e9a574b99mr129613255ad.17.1759699349121; Sun, 05
 Oct 2025 14:22:29 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:05 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-5-irogers@google.com>
Subject: [PATCH v7 04/11] perf dso: Support BPF programs in dso__read_symbol
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Set the buffer to the code in the BPF linear info. This enables BPF
JIT code disassembly by LLVM and capstone. Move the common but minimal
disassmble_bpf_image call to disassemble_objdump so that it is only
called after falling back to the objdump option. Similarly move the
disassmble_bpf function to disassemble_objdump and rename to
disassmble_bpf_libbfd to make it clearer that this support relies on
libbfd.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c |  12 +++--
 tools/perf/util/dso.c    | 100 ++++++++++++++++++++++++++-------------
 tools/perf/util/libbfd.c |   4 +-
 tools/perf/util/libbfd.h |   6 +--
 4 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index a1240543c89c..e64902e520ab 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1521,6 +1521,12 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return symbol__disassemble_bpf_libbfd(sym, args);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return symbol__disassemble_bpf_image(sym, args);
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
@@ -1655,11 +1661,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	pr_debug("annotating [%p] %30s : [%p] %30s\n", dso, dso__long_name(dso), sym, sym->name);
 
-	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
-		return symbol__disassemble_bpf(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
-		return symbol__disassemble_bpf_image(sym, args);
-	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__NOT_FOUND) {
 		return SYMBOL_ANNOTATE_ERRNO__COULDNT_DETERMINE_FILE_TYPE;
 	} else if (dso__is_kcore(dso)) {
 		kce.addr = map__rip_2objdump(map, sym->start);
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 87d075942de6..0aed5c8691bd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1816,23 +1816,17 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
-			   const struct map *map, const struct symbol *sym,
-			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+static const u8 *__dso__read_symbol(struct dso *dso, const char *symfs_filename,
+				    u64 start, size_t len,
+				    u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
 	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	size_t len;
+	int fd;
+	ssize_t count;
 	struct find_file_offset_data data = {
 		.ip = start,
 	};
-
-	*out_buf = NULL;
-	*out_buf_len = 0;
-	*is_64bit = false;
+	u8 *code_buf = NULL;
 
 	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 	fd = open(symfs_filename, O_RDONLY);
@@ -1840,28 +1834,70 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	if (fd < 0)
 		return NULL;
 
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
-		goto err;
-
-	len = end - start;
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+		close(fd);
+		return NULL;
+	}
+	code_buf = malloc(len);
+	if (code_buf == NULL) {
+		close(fd);
+		return NULL;
+	}
+	count = pread(fd, code_buf, len, data.offset);
 	close(fd);
-	fd = -1;
+	if ((u64)count != len) {
+		free(code_buf);
+		return NULL;
+	}
+	*out_buf = code_buf;
+	*out_buf_len = len;
+	return code_buf;
+}
 
-	if ((u64)count != len)
-		goto err;
+/*
+ * Read a symbol into memory for disassembly by a library like capstone of
+ * libLLVM. If memory is allocated out_buf holds it.
+ */
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+{
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	size_t len = end - start;
 
-	*out_buf = buf;
-	*out_buf_len = len;
-	return buf;
+	*out_buf = NULL;
+	*out_buf_len = 0;
+	*is_64bit = false;
 
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		/*
+		 * Note, there is fallback BPF image disassembly in the objdump
+		 * version but it currently does nothing.
+		 */
+		return NULL;
+	}
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
+#ifdef HAVE_LIBBPF_SUPPORT
+		struct bpf_prog_info_node *info_node;
+		struct perf_bpil *info_linear;
+
+		*is_64bit = sizeof(void *) == sizeof(u64);
+		info_node = perf_env__find_bpf_prog_info(dso__bpf_prog(dso)->env,
+							 dso__bpf_prog(dso)->id);
+		if (!info_node) {
+			errno = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
+			return NULL;
+		}
+		info_linear = info_node->info_linear;
+		assert(len <= info_linear->info.jited_prog_len);
+		*out_buf_len = len;
+		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
+#else
+		pr_debug("No BPF program disassembly support\n");
+		return NULL;
+#endif
+	}
+	return __dso__read_symbol(dso, symfs_filename, start, len,
+				  out_buf, out_buf_len, is_64bit);
 }
diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index 09a0eeb78a1a..01147fbf73b3 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -448,8 +448,8 @@ int libbfd_filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
-int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
-			    struct annotate_args *args  __maybe_unused)
+int symbol__disassemble_bpf_libbfd(struct symbol *sym __maybe_unused,
+				   struct annotate_args *args  __maybe_unused)
 {
 #ifdef HAVE_LIBBPF_SUPPORT
 	struct annotation *notes = symbol__annotation(sym);
diff --git a/tools/perf/util/libbfd.h b/tools/perf/util/libbfd.h
index 7441e95f8ec0..e300f171d1bd 100644
--- a/tools/perf/util/libbfd.h
+++ b/tools/perf/util/libbfd.h
@@ -29,7 +29,7 @@ int libbfd__read_build_id(const char *filename, struct build_id *bid, bool block
 
 int libbfd_filename__read_debuglink(const char *filename, char *debuglink, size_t size);
 
-int symbol__disassemble_bpf(struct symbol *sym, struct annotate_args *args);
+int symbol__disassemble_bpf_libbfd(struct symbol *sym, struct annotate_args *args);
 
 #else // !defined(HAVE_LIBBFD_SUPPORT)
 #include "annotate.h"
@@ -72,8 +72,8 @@ static inline int libbfd_filename__read_debuglink(const char *filename __always_
 	return -1;
 }
 
-static inline int symbol__disassemble_bpf(struct symbol *sym __always_unused,
-					  struct annotate_args *args __always_unused)
+static inline int symbol__disassemble_bpf_libbfd(struct symbol *sym __always_unused,
+						 struct annotate_args *args __always_unused)
 {
 	return SYMBOL_ANNOTATE_ERRNO__NO_LIBOPCODES_FOR_BPF;
 }
-- 
2.51.0.618.g983fd99d29-goog


