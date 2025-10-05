Return-Path: <linux-kernel+bounces-842461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99A8BBCC4C
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 23:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031B01895747
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 21:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17372BD58C;
	Sun,  5 Oct 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SepvnjU1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711012BE05F
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759699348; cv=none; b=ta6y1kz3hF4//QNYDV8Q9aSXSKibIQl3Ngc//FDaPISANZ/w3Q0bTNF77o7H6iuIb2RZGQfFq2DaTSeZx6p5mNiyF2N9meT0hH5R0TC9RaNIGZGuJEeuSXx0zYY1UGoJ6obS+QjLQcekQsiX860EeG4deipgTcfrR+nm+So410k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759699348; c=relaxed/simple;
	bh=jjogxjWTo8LEEeITCvVJ5lej7lh2270zJAspkUYjJfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QiN4kaGSTmYXlkrBT8sz8Y3us5/6xGxYxlUQKMhfprRKIJrcP6RypkuaT1e/r6dcSEZUepYiCOkKXe5Dd86TmeTEKZvH+5EvkOHu98n8xEuNbP62bSgzuwTy60XelxEWcP/9XtAnK6D4f5cc+yxFWf6JXHN9oXH4NtewgMrE7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SepvnjU1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2697c4e7354so50684095ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759699345; x=1760304145; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zr9vg9+dbl377j7bj7cPlJqbhOg0YG22m54UFPy9WZs=;
        b=SepvnjU1Ud8J2ZZQxQGdPV2bc4S1FGHbD6D17/aWCpSPJ9ihEVF2KZDI5M05Zpb0zs
         t49rH4bREqOGMzHo4aB3BHweQtb/jDcphq+wnJN9S2+WUuVxw8xLPRKN5jnpg6fI36sX
         6+TvrrIxTtUKHwoRT+sXESumjFMhp2rSfI72r+tHEYG0BHlgf/KulgizVf14sUlPCUQR
         Z8Ll5MHe7bU2QWRCq+1DIxieFto/DMiQYoZaVix7u1optdGKfzHfuv546+dE5Uqi8GPs
         iiTKywyRcQEqqZxBI7lvEtCx1Z3lO9TwU1H7X98/PWUdO1dj0thQoNc7h22w5FuKoLsy
         xMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759699345; x=1760304145;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zr9vg9+dbl377j7bj7cPlJqbhOg0YG22m54UFPy9WZs=;
        b=FiHB3Qto+wlkuWQNwf8+WcwKwylaHf8qZTgi9BYbapBJq0b3ukeqOuODMnfYVuHpA0
         GTFSjruhUgCBilo3ODHu2IDxzH2bBuRCHSfkjmSpfvGXLJLGKyNp0kSuACDibHHGtFhG
         BSAJDMfMYKq98JA0IwkBKZhlD0FQ5ruHtuTt6Y8+t3aUBQRumts0fhwnO26aviAOVrWm
         OVe+sLmP7j5xghREeguUwxv1YeRAjDHQ/S6JvA29Zyw7mjx3QoeoMbdJEGtIu2AVymle
         6KPcI7TjehqzEVhpLuub2modLhrXm/4q199iwRWEdfq3XU00YdUcCS/uqRfiiWLhjx8z
         EBWw==
X-Forwarded-Encrypted: i=1; AJvYcCWb1/5OMhzL3iSzYm0OhPOQc+430EC12HbZdhRREJPr0vPlpRDBm5DVM9tRJLw1Q484CT8jHEeiW7ddh5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBhJQ7Qdxb1zGZ7HQYBCEmHwUM8WR4hYYrBuxpVF0Sft3Ot3rQ
	3p7h79XliFcnrDliWkDjEwUu55kWvczTJ65MdO4giwnsYU7+1kBZh3rc/wzP/PlFqExt95dHtVu
	tT9tuRFDPuQ==
X-Google-Smtp-Source: AGHT+IFEaM+mFQzGCobgqNknXJ7y1TlfovFXjd/cXa5mwCMiuAzlKf2cDvpg0Dz2Z/gtCSnKr3ofcMi/Sj1q
X-Received: from pjbqo8.prod.google.com ([2002:a17:90b:3dc8:b0:32e:e06a:4668])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c0e:b0:27e:f03e:c6b7
 with SMTP id d9443c01a7336-28e8d038b9cmr181830185ad.10.1759699344812; Sun, 05
 Oct 2025 14:22:24 -0700 (PDT)
Date: Sun,  5 Oct 2025 14:22:03 -0700
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005212212.2892175-3-irogers@google.com>
Subject: [PATCH v7 02/11] perf llvm: Reduce LLVM initialization
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

Move the 3 LLVM initialization routines to be called in a single
init_llvm function that has its own bool to avoid repeated
initialization. Reduce the scope of triplet and avoid copying strings
for x86.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/llvm.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index ddc737194692..2356778955fe 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -74,6 +74,17 @@ void dso__free_a2l_llvm(struct dso *dso __maybe_unused)
 	/* Nothing to free. */
 }
 
+static void init_llvm(void)
+{
+	static bool init;
+
+	if (!init) {
+		LLVMInitializeAllTargetInfos();
+		LLVMInitializeAllTargetMCs();
+		LLVMInitializeAllDisassemblers();
+		init = true;
+	}
+}
 
 #if defined(HAVE_LIBLLVM_SUPPORT)
 struct find_file_offset_data {
@@ -184,7 +195,6 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	u64 len;
 	u64 pc;
 	bool is_64bit;
-	char triplet[64];
 	char disasm_buf[2048];
 	size_t disasm_len;
 	struct disasm_line *dl;
@@ -197,26 +207,25 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	LLVMInitializeAllTargetInfos();
-	LLVMInitializeAllTargetMCs();
-	LLVMInitializeAllDisassemblers();
-
 	buf = read_symbol(filename, map, sym, &len, &is_64bit);
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
+		disasm = LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					  /*get_op_info=*/NULL, symbol_lookup_callback);
 	} else {
+		char triplet[64];
+
 		scnprintf(triplet, sizeof(triplet), "%s-linux-gnu",
 			  args->arch->name);
+		disasm = LLVMCreateDisasm(triplet, &storage, /*tag_type=*/0,
+					  /*get_op_info=*/NULL, symbol_lookup_callback);
 	}
 
-	disasm = LLVMCreateDisasm(triplet, &storage, 0, NULL,
-				  symbol_lookup_callback);
 	if (disasm == NULL)
 		goto err;
 
-- 
2.51.0.618.g983fd99d29-goog


