Return-Path: <linux-kernel+bounces-782840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3FB325EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC2D8189E4FD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744CE1FC7E7;
	Sat, 23 Aug 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fww60dUx"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7E1EB5E3
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909174; cv=none; b=Yr1gdiS0OuDhH8jU/swqlzNcFIFQhq4qDoYYSqUzJXIyMpsQfhVh0cOsWVkZnFrcLI7o7wgrH+XGBXRifmhhxlmSfHNhfBX22Jq3blV51GeQmNGsKTVXY/3vO5nmi5OuRj906V7c0jqpnWmi0u7hG2Q4jozVqNuZZQ9Ozo0VSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909174; c=relaxed/simple;
	bh=Q/rXeAEhkxuFPjccnxCIzH7tlh0lULiUPkRufe9iE+s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nbb0Kjt6RREsuuTXVMaJOmo3jr3cIgYF7/rl2XUAEdFAIqPclMI1FxgMUMo265c4lormNRRzWraDa7gB360KL5cMdnkl2VGkkWp7kBrWwhrg1dWtXyBSSFXaNLtd8kIR0tpQsD+ju40a5BGaiU6NiLqjbkKZRRb88RynN3WGtUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fww60dUx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-246088fc25cso26837075ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909171; x=1756513971; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LGRBK4HNJps19DKyUYzYqKIeUoReuacj2yflz7VmQvc=;
        b=fww60dUxBvjAjaYbg/mC9874ri6OnNMMm+1eN47w3ftsh+sWAYprTWIuZBMXoT5bbU
         Nx0mzk8YjldThhKJmAeG+DE9tVqj/QZJ9twtP2s4B5XmSGX7wS8rCU/SbV8AVAeue/mK
         QQZeKK/J4x29mF+Egoz/mEDX7df0SAFRPvazUNw+lN9twi06T9xqDmDs36htwkMZXgNs
         sdl3tHjuKOoUA6bKGbD3DmtnUKrhNY8TeACvzirMUEJ3O8zelRBChOigZKHvSgnO41gu
         7dWdtWmpuXgILmoP27UC7Px6TDPT8hlrf63hFEgVtNIYex8GiiMErik76tHCCILJLB+g
         Xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909171; x=1756513971;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGRBK4HNJps19DKyUYzYqKIeUoReuacj2yflz7VmQvc=;
        b=Sm7HTFdlQmyV/0YzOZm9xNSHucfvoMkGJUKqr6fkqcnTmiHpt3aTBak7Y0UsiIKJDV
         iYT56eMsl3RXon9Zt0dLZ9N1WuelznS9Ta8hQ4e8gtAIMQpojSsw3tMerOqZzgwP1zep
         7HOKXWmXPatmKQ+nlk16kgaP7aGHSXF3OeAFeholuHjEgZA40xP3CC1RRuHqQmyAPYdX
         6JXc70UlFzMtP3q65AjL8ZA6jFTsP4Rwdn8VTN91Sq1dX+a7J2+7qpIJIb6mzxVjxqMf
         Xa35vLCYvZgBj4B5clz3R3l1BjI/vIng0k8yyhDkhTQjlNCxYPqSfH3YthidraF2OTgC
         JjVw==
X-Forwarded-Encrypted: i=1; AJvYcCUsujahXmWW7/cS81UF1or2cVgbitwFiTRlbQMQuiHjY828UMO5ZLjG+0lsM6rE6xYoJ2AUEj5AFY3UPMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHflWiznQdEOWJzwXwx/siD67piZ3XGfmWfPt/5XKb2sXrOmLe
	XmfrQMbtUlLR6iZRISOZV7FUBRxjwKOpwsVGiy4hrtcbw+T1Zmb85Sw0xLdvnaXeg01KNRD2zWP
	vAn4XCllZRg==
X-Google-Smtp-Source: AGHT+IGBn3ogB3LontfpDspe/kkcSqFJdkEiLLJCgmAVTw7Ghy/ncmS4udi4ZX5B/3tCkhU5ZNHVG8dlGB57
X-Received: from plbjx13.prod.google.com ([2002:a17:903:138d:b0:240:670f:ad71])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c950:b0:245:f161:35a3
 with SMTP id d9443c01a7336-2462ee59150mr70796845ad.15.1755909170563; Fri, 22
 Aug 2025 17:32:50 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:06 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-11-irogers@google.com>
Subject: [PATCH v5 10/19] perf dso: Support BPF programs in dso__read_symbol
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Set the buffer to the code in the BPF linear info. This enables BPF
JIT code disassembly by LLVM and capstone. Move the disassmble_bpf
calls to disassemble_objdump so that they are only called after
falling back to the objdump option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 12 +++---
 tools/perf/util/dso.c    | 85 +++++++++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 5a1a7be717d0..54b38dd696fe 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1501,6 +1501,12 @@ static int symbol__disassemble_objdump(const char *filename, struct symbol *sym,
 	struct child_process objdump_process;
 	int err;
 
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO)
+		return symbol__disassemble_bpf(sym, args);
+
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE)
+		return symbol__disassemble_bpf_image(sym, args);
+
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
@@ -1635,11 +1641,7 @@ int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
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
index 87d075942de6..277c7e81f1c8 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1820,48 +1820,69 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			   const struct map *map, const struct symbol *sym,
 			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
 {
-	struct nscookie nsc;
 	u64 start = map__rip_2objdump(map, sym->start);
 	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	size_t len;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
+	const u8 *buf;
+	size_t len = end - start;
 
 	*out_buf = NULL;
 	*out_buf_len = 0;
 	*is_64bit = false;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(symfs_filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
+	if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_IMAGE) {
+		pr_debug("No BPF image disassembly support\n");
 		return NULL;
+	} else if (dso__binary_type(dso) == DSO_BINARY_TYPE__BPF_PROG_INFO) {
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
+		buf = (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
+		assert(len <= info_linear->info.jited_prog_len);
+#else
+		pr_debug("No BPF program disassembly support\n");
+		return NULL;
+#endif
+	} else {
+		struct nscookie nsc;
+		int fd;
+		ssize_t count;
+		struct find_file_offset_data data = {
+			.ip = start,
+		};
+		u8 *code_buf = NULL;
 
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
-		goto err;
-
-	len = end - start;
-	buf = malloc(len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != len)
-		goto err;
+		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+		fd = open(symfs_filename, O_RDONLY);
+		nsinfo__mountns_exit(&nsc);
+		if (fd < 0)
+			return NULL;
 
-	*out_buf = buf;
+		if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0) {
+			close(fd);
+			return NULL;
+		}
+		buf = code_buf = malloc(len);
+		if (buf == NULL) {
+			close(fd);
+			return NULL;
+		}
+		count = pread(fd, code_buf, len, data.offset);
+		close(fd);
+		if ((u64)count != len) {
+			free(code_buf);
+			return NULL;
+		}
+		*out_buf = code_buf;
+	}
 	*out_buf_len = len;
 	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
 }
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


