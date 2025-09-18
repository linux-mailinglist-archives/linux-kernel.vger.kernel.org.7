Return-Path: <linux-kernel+bounces-782839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F71B325E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B87CB02FB3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1301F0E32;
	Sat, 23 Aug 2025 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNzpQrnd"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E91E0E14
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909171; cv=none; b=I3hC9+arTtlwE3Sim+23bwod/1QbB2vVSrLuY/9jMHwJkyc9XUc7u1z5twfFVpBPMYCgdYGHI6bEj0+2W4BrPpyhOPYaO0YvGswnIklZsvNrcN+nzO3205SS5ZjgB9DnE4FDpmgI3ePSRDRIaXBzw49ILhd/Wzm+TtnWpNlTb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909171; c=relaxed/simple;
	bh=Z7VPssF3bUNgdTwlsTGD3V6ckx5vCdjZubep8K/fgLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pfxmJLyRWLMWLrM0FsYFTzgWh811Znzku6kb+jGTrBaR3E8fDeyDA6xB1ISyyDzrZf431JZ0Astxaz4Yis399n/fKIDjnrP9YdOgZlAPdLnT/rirbh299tIjQLI27Cd6RRGy9lKt52ahkZCT8YAOM2SIQsPgkGUsbBtIK2CeY18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNzpQrnd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445805d386so32004835ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909168; x=1756513968; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3gB61DCA/Vjel4Yg0VRmeHLBpoCrBc48QfkMoiPEdE=;
        b=zNzpQrndOpv5YoirhrLDMHB0mXjH0dZMtvCfkttXWrrBJ+uOb4TKL6EDwHsxrLLzpc
         iTO6dtrd5VLdLiijeiVoWHf9wHCJO9/h/TXOHpve3rnd79YTJV9ocZg1F47h6QqogvPP
         H39//8//s+Mt/XGJG/DJSvc89PY/neWyPZHlCjdjhJ2WKUC6CXC1GWoqO5FrDa9yTF6y
         F0eLLO9i5niCaa9NO9ejDrb+iy1C08U6nDT9e/cvqD3yy8eL5w5DmrpF7AJOZ8kqFMBZ
         Ec9dZlCBNx+LAmnZKn4i+nyHTRM3m4Fy0gO3a29tjPFwozAnsvDdfJvUJqu+DUnd2Zah
         eRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909168; x=1756513968;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3gB61DCA/Vjel4Yg0VRmeHLBpoCrBc48QfkMoiPEdE=;
        b=viOP5/MXbntlqIL3P/C9vWy3tNNn8qqY9E6y/Oks8mgk6X+/AupvFdDKuOx9CcF9yi
         WnDtrqRr3Sklgh32px2Nq/h9UiS0OiGRvPYApYxRdNwivIbRjNP9/zmgaWbKfXF0miaE
         PURgNE7u8Lc09pX/+d+qSs0jKg2RSjPp8jZW/Db9SExltB+zoU1zf6ENxILJasC1oUzC
         eKNSi+B0gx8rXBIS+FoTQmK3rbcl493zBInw+xB6p3usyuK8zavfL0zVj+WJeUDexpib
         Z29zEanZWzKk4UhVUzbvlYiaHCcI//PLIZmR9+tACTzSn5dRIW1IHotWv1J9+2Qo+WFB
         ToWg==
X-Forwarded-Encrypted: i=1; AJvYcCX6zSyoqP03ilQJQAgthKajXDScMYoRhtBLtkJoaSGkkpEj5FszYCtM3o1Ijgj17yZLuxB0ijBk0MO3TRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/SInUXyIQ2Sf9HEHYK3byP/2q6FE+zrEiWNVJVVCMi6sitxd
	VQt6MHdAkAIKBy960riyOouS5i3XOGsVDnhaYSw7ZpRl8nZtLrxznkLb6AhCscyuDls0vd67RBy
	V0eeIx4t1mA==
X-Google-Smtp-Source: AGHT+IHHqOvMgCSRCa9kzTTb1GJ5NWUejKwbyrtF0K9SjnWfitaXUm4aUh+Cu2YxhPsOQ6+Tb6T83W4Ui2VE
X-Received: from pldb10.prod.google.com ([2002:a17:902:ed0a:b0:244:6b9d:49da])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc8e:b0:240:49bf:6332
 with SMTP id d9443c01a7336-2462ef6d9b8mr60932825ad.47.1755909168410; Fri, 22
 Aug 2025 17:32:48 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:05 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-10-irogers@google.com>
Subject: [PATCH v5 09/19] perf dso: Move read_symbol from llvm/capstone to dso
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

Move the read_symbol function to dso.h, make the return type const and
add a mutable out_buf out parameter. In future changes this will allow
a code pointer to be returned without necessary allocating memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/capstone.c | 64 +++++-----------------------
 tools/perf/util/dso.c      | 67 +++++++++++++++++++++++++++++
 tools/perf/util/dso.h      |  4 ++
 tools/perf/util/llvm.c     | 87 +++++++-------------------------------
 4 files changed, 97 insertions(+), 125 deletions(-)

diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
index fa9aa9cde68d..5aeae261f7ee 100644
--- a/tools/perf/util/capstone.c
+++ b/tools/perf/util/capstone.c
@@ -434,66 +434,23 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-
 int symbol__disassemble_capstone(const char *filename __maybe_unused,
 				 struct symbol *sym __maybe_unused,
 				 struct annotate_args *args __maybe_unused)
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
+	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
-	u64 len;
 	u64 offset;
 	int i, count, free_count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
-	u8 *buf = NULL;
+	/* Malloc-ed buffer containing instructions read from disk. */
+	u8 *code_buf = NULL;
+	/* Pointer to code to be disassembled. */
+	const u8 *buf;
+	u64 buf_len;
 	csh handle;
 	struct cs_insn *insn = NULL;
 	char disasm_buf[512];
@@ -503,7 +460,8 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	if (args->options->objdump_path)
 		return -1;
 
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
@@ -532,7 +490,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 
 	needs_cs_close = true;
 
-	free_count = count = perf_cs_disasm(handle, buf, len, start, len, &insn);
+	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
 
@@ -556,7 +514,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 	}
 
 	/* It failed in the middle: probably due to unknown instructions */
-	if (offset != len) {
+	if (offset != buf_len) {
 		struct list_head *list = &notes->src->source;
 
 		/* Discard all lines and fallback to objdump */
@@ -575,7 +533,7 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
 		if (free_count > 0)
 			perf_cs_free(insn, free_count);
 	}
-	free(buf);
+	free(code_buf);
 	return count < 0 ? count : 0;
 
 err:
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 282e3af85d5a..87d075942de6 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1798,3 +1798,70 @@ bool is_perf_pid_map_name(const char *dso_name)
 
 	return perf_pid_map_tid(dso_name, &tid);
 }
+
+struct find_file_offset_data {
+	u64 ip;
+	u64 offset;
+};
+
+/* This will be called for each PHDR in an ELF binary */
+static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
+{
+	struct find_file_offset_data *data = arg;
+
+	if (start <= data->ip && data->ip < start + len) {
+		data->offset = pgoff + data->ip - start;
+		return 1;
+	}
+	return 0;
+}
+
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit)
+{
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	int fd, count;
+	u8 *buf = NULL;
+	size_t len;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+
+	*out_buf = NULL;
+	*out_buf_len = 0;
+	*is_64bit = false;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(symfs_filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return NULL;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data, is_64bit) == 0)
+		goto err;
+
+	len = end - start;
+	buf = malloc(len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != len)
+		goto err;
+
+	*out_buf = buf;
+	*out_buf_len = len;
+	return buf;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	return NULL;
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 3457d713d3c5..acdd6c8a1fc9 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -903,4 +903,8 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 bool perf_pid_map_tid(const char *dso_name, int *tid);
 bool is_perf_pid_map_name(const char *dso_name);
 
+const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
+			   const struct map *map, const struct symbol *sym,
+			   u8 **out_buf, u64 *out_buf_len, bool *is_64bit);
+
 #endif /* __PERF_DSO */
diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index f6a8943b7c9d..a0774373f0d6 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -296,71 +296,6 @@ void dso__free_a2l_llvm(struct dso *dso __maybe_unused)
 	/* Nothing to free. */
 }
 
-
-struct find_file_offset_data {
-	u64 ip;
-	u64 offset;
-};
-
-/* This will be called for each PHDR in an ELF binary */
-static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
-{
-	struct find_file_offset_data *data = arg;
-
-	if (start <= data->ip && data->ip < start + len) {
-		data->offset = pgoff + data->ip - start;
-		return 1;
-	}
-	return 0;
-}
-
-static u8 *
-read_symbol(const char *filename, struct map *map, struct symbol *sym,
-	    u64 *len, bool *is_64bit)
-{
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
-	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	int fd, count;
-	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
-
-	*is_64bit = false;
-
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return NULL;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    is_64bit) == 0)
-		goto err;
-
-	*len = end - start;
-	buf = malloc(*len);
-	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, *len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != *len)
-		goto err;
-
-	return buf;
-
-err:
-	if (fd >= 0)
-		close(fd);
-	free(buf);
-	return NULL;
-}
-
 /*
  * Whenever LLVM wants to resolve an address into a symbol, it calls this
  * callback. We don't ever actually _return_ anything (in particular, because
@@ -397,8 +332,11 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	struct map *map = args->ms.map;
 	struct dso *dso = map__dso(map);
 	u64 start = map__rip_2objdump(map, sym->start);
-	u8 *buf;
-	u64 len;
+	/* Malloc-ed buffer containing instructions read from disk. */
+	u8 *code_buf = NULL;
+	/* Pointer to code to be disassembled. */
+	const u8 *buf;
+	u64 buf_len;
 	u64 pc;
 	bool is_64bit;
 	char triplet[64];
@@ -418,7 +356,8 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	perf_LLVMInitializeAllTargetMCs();
 	perf_LLVMInitializeAllDisassemblers();
 
-	buf = read_symbol(filename, map, sym, &len, &is_64bit);
+	buf = dso__read_symbol(dso, filename, map, sym,
+			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
@@ -466,14 +405,18 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	annotation_line__add(&dl->al, &notes->src->source);
 
 	pc = start;
-	for (u64 offset = 0; offset < len; ) {
+	for (u64 offset = 0; offset < buf_len; ) {
 		unsigned int ins_len;
 
 		storage.branch_addr = 0;
 		storage.pcrel_load_addr = 0;
 
-		ins_len = perf_LLVMDisasmInstruction(disasm, buf + offset,
-						     len - offset, pc,
+		/*
+		 * LLVM's API has the code be disassembled as non-const, cast
+		 * here as we may be disassembling from mapped read-only memory.
+		 */
+		ins_len = perf_LLVMDisasmInstruction(disasm, (u8 *)(buf + offset),
+						     buf_len - offset, pc,
 						     disasm_buf, sizeof(disasm_buf));
 		if (ins_len == 0)
 			goto err;
@@ -531,7 +474,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 
 err:
 	perf_LLVMDisasmDispose(disasm);
-	free(buf);
+	free(code_buf);
 	free(line_storage);
 	return ret;
 }
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


