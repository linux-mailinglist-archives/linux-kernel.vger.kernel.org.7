Return-Path: <linux-kernel+bounces-609934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8EBA92DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 01:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD4171906
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 23:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B99C22B8C6;
	Thu, 17 Apr 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf8vRXlF"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4522A7FC
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744931300; cv=none; b=sKtMSMOV0DQrby15k23+XwfiVZHuuFM4drrHtSXuokx5x4IzSjCeKRFyfHy5Q9cjyBkfdU/CQlYBmg6bOU1dRyaXRzNQxVmj2NLqVnESCtQbOYCTY6vleOUy4jGUfU7ILe2tdFMPITz0nhIvwQWDFvyNAw9jobwboDl95BZTTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744931300; c=relaxed/simple;
	bh=Erynk8+/uixEXt7BeOJQFcm6Q561j11l35I5blMdZvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PcPUEFGSOB/kNA4N7lpGG0GJsdE+tSdnp73pbYr5wZVby5HGA14NvIs2z6ue66ChEglDNvF+8zDN2pAoh0GLBeUNUGMtRi7xUU26J7oTvork/KmG8s0Sf1d+9HZTjZA2vBXiqc/f5rRCifkAUMCy0jltSi51azgOJzZ5BWDqumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf8vRXlF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032ea03448so1294646a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744931297; x=1745536097; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB6ehE4CIrRVO0upk/cDtkYMX2P2CRQHtVQu5oompks=;
        b=bf8vRXlFL73TDTj5aSdIV6q6yBtWW/K7VosyXCUI/tmOkZB8cOw+MNdpJ9ig0/NPRg
         uB61rd58BSOdrkLwVNnP+4LlhK1wra8PLzPN0rPTAQ3zMEGzgI5/qUodvPeuqKELHJvk
         J2cfRrOkxyp0VbXia5tvQGa7ewRTSLROg3Pkm1UVTuA+JfMsYTn0TZ8pQJSTjWMEixGC
         csI4tQJxzP75rEaoZydrLUsdMB4+0GvpALUPZdHlx6eA4xJb7cuk0by/QBSVgE9/hRoH
         R/Xzoa7I39jtyBCS2hTWr5D4iO6pd/jiulJt2iDuru4o7uX3u30NXJ8xXJDmuARY0zOZ
         saNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744931297; x=1745536097;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IB6ehE4CIrRVO0upk/cDtkYMX2P2CRQHtVQu5oompks=;
        b=Bqd0ACNvW4HVPiVGoq5HbiTrib/E7O0OsAhC8XXzWB2LHvwnNgZRL/X1UxkeLS6h00
         t/ZLl2DKaCC5nJUJ1Pqb9NnjRDv93jh/9MIbJyEIibnIJzt09cFLIO0tI9Lq5CCRsgLf
         38h1bUBrCbftx2h4vxMWKLnldNFkKT9iV+Na2q9jPAJ6f4iLD+W+7QjY8MK9PPa1YxbC
         aVyBvYHXn2LHvMCj16WPZjsSJmde06+19SJ5ijuSHXG7fGfnZdBxTu9wpan7LSaLhQ06
         uGvkrhYTdhSoYiOnWncpbWBXAyJ0VfT7Nd7LsRykFugXTCMt+hWv8jc9HpYcq3ze1nns
         d3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbSNionkBMaEzu/spxm37XWh5LEpmucysiCrFmWRI09Rq6IJDxtixsC9JzZEfDItxgk+ktQx1kbW1VaVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5tGnU0hUUKK2nKUeIzuoaE/L667Pyt3XqXPQ+3Lqcuy5f1OO
	mV/5i91BZJvMoxAHcPRVsjoKfQoLPGAP392vJD8cnHSxIdis8s1n82djTBs+QfWDKodHT/Gh738
	R7l59pg==
X-Google-Smtp-Source: AGHT+IFSvMMY0LC4wHuomXbZ/DawwgteI1xq56I/oeBQmnsf6EEf9nYOa/akkIXnOi8k2ogjeqQdR6Ooifxj
X-Received: from pjbee3.prod.google.com ([2002:a17:90a:fc43:b0:308:6685:55e6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380b:b0:2f6:d266:f45e
 with SMTP id 98e67ed59e1d1-3087bb3e794mr1100495a91.2.1744931297373; Thu, 17
 Apr 2025 16:08:17 -0700 (PDT)
Date: Thu, 17 Apr 2025 16:07:32 -0700
In-Reply-To: <20250417230740.86048-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250417230740.86048-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250417230740.86048-12-irogers@google.com>
Subject: [PATCH v4 11/19] perf llvm: Disassemble cleanup
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

Move the 3 LLVM initialization routines to be called in a single
init_llvm function that has its own bool to avoid repeated
initialization. Reduce the scope of triplet and avoid copying strings
for x86.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index a0774373f0d6..a28f130c8951 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -244,6 +244,17 @@ static void perf_LLVMDisasmDispose(LLVMDisasmContextRef context)
 #endif
 }
 
+static void init_llvm(void)
+{
+	static bool init;
+
+	if (!init) {
+		perf_LLVMInitializeAllTargetInfos();
+		perf_LLVMInitializeAllTargetMCs();
+		perf_LLVMInitializeAllDisassemblers();
+		init = true;
+	}
+}
 
 static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_frames,
 				    int num_frames)
@@ -339,7 +350,6 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	u64 buf_len;
 	u64 pc;
 	bool is_64bit;
-	char triplet[64];
 	char disasm_buf[2048];
 	size_t disasm_len;
 	struct disasm_line *dl;
@@ -352,27 +362,25 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	perf_LLVMInitializeAllTargetInfos();
-	perf_LLVMInitializeAllTargetMCs();
-	perf_LLVMInitializeAllDisassemblers();
-
 	buf = dso__read_symbol(dso, filename, map, sym,
 			       &code_buf, &buf_len, &is_64bit);
 	if (buf == NULL)
 		return -1;
 
+	init_llvm();
 	if (arch__is(args->arch, "x86")) {
-		if (is_64bit)
-			scnprintf(triplet, sizeof(triplet), "x86_64-pc-linux");
-		else
-			scnprintf(triplet, sizeof(triplet), "i686-pc-linux");
+		const char *triplet = is_64bit ? "x86_64-pc-linux" : "i686-pc-linux";
+
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	} else {
+		char triplet[64];
+
 		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
 			  args->arch->name);
+		disasm = perf_LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					       /*get_op_info=*/NULL, symbol_lookup_callback);
 	}
-
-	disasm = perf_LLVMCreateDisasm(triplet, &storage, 0, NULL,
-				       symbol_lookup_callback);
 	if (disasm == NULL)
 		goto err;
 
-- 
2.49.0.805.g082f7c87e0-goog


