Return-Path: <linux-kernel+bounces-782841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA32B325E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3336259EC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961E1FCD1F;
	Sat, 23 Aug 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCjeam7X"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483041F2C34
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909174; cv=none; b=YvPyTMQ06JlHrlyg1NJj14/m7JTZgIY5d9YfwztdmfBIfwUr7keJZSjbx1/h3eHP/UiZrU3Ld68cFs7P/2uLJNC0wEFEqpR51/2/uWZ3RzKUjdACdj/6zwZFL3DWwz1X1NmCbKTu4kpdz6+9phpjhcpPQ6i96U6mGW+z9jGT1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909174; c=relaxed/simple;
	bh=Fd29IYX/xpHAqMQkc8EyODPN9XEe5UxH0NFcKN/ROns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lqmOAq/MlxAxC9/1dmq136qd88vOmdk81uyhnFBfrgyZrEfaaz8FQnIyPXIeOG/4J622v9GowIDssy3/NFBRQiFqfA0WLfQ/ZNpur9b3X2AcQV1wqSoaG7oShRqtHLrL5fkLJwvGUN9yw15CIRlloKGiv0dxzTZESoVbVAjrfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCjeam7X; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so4514113a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909172; x=1756513972; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrnABPnhnjLPpde8R8ZKcXd7aM+wSVwyXCweNa59YQ0=;
        b=zCjeam7XwC5mfwhtUv13T4/amjvC6MbesrghExGYg8lfwD27xTLb0NL9ktC1vAVr78
         LWr3Ja8/huK7b6tIjujPp5dpxKyYEGwGbZpGMykfg/q0MbT4Zanva4hxCpei8neVesvt
         jXFV448tW83bx+afq26UpeV97Ulpv3AOBgNTwMkER/teMIqwMhOZob81pHwLWlzzIaiX
         Yx4/hn/p7TWxBnOURSS6LXAO2omJSSJ23W8F8FS5uG3poxVuHoHzxM7eIv7xUxCGwKRF
         Yd9s5hRO/bDcpIJ3n9bSiU2xHN6FM3WwvfZQqkXklhtujArSlzmVOubr7bu1lMSCM3bu
         ZcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909172; x=1756513972;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrnABPnhnjLPpde8R8ZKcXd7aM+wSVwyXCweNa59YQ0=;
        b=UmDfiSFFefWi2IzaSzpYJdz53ToSwGs3cm+XMpVK9S03ZuRRQU+hNYPEJ6bh3Gy5vc
         ZneHwdmPbomofykw1nF0uxNLKEeNgt6a4eXL02JLEPOQsYkydsXevrAWO/ZuQgnchyE3
         I9J/n++AhYyEKoIVibrftn+fWoIHqRRqlGjZ5PYuEDlI4qAnLGPb9bN9qRg/29hGc2KQ
         /f3Jr0jPD4V7hx6BW7i8AnBDZzjM0Rd1VT1S95M7CMcCDXH3fe5lhzIw3Jz+r1CE2dY0
         JjbZrG7Le63Iugd2myx+jEqGAfkZLuUUZowU0IkHRsswcOWXoe8huSgZkvSPfeL0N2da
         XnOg==
X-Forwarded-Encrypted: i=1; AJvYcCXz0HVwCTClKqQsEQb/ARA4v2197S0m9Xqel3xg/MD3EnF+R1p+YDv16rolU257iM2yVAAn5jxPrJ8UZOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qTSe0DtaIQ8MfQpKUVwnBwfsmpvvsji8pmKjZ8HOOym+fg0L
	CeQAUrUJhQSKhXA3MlaNuQRfKIMozYnD6TFlhUlrh/QG+IuHN2PZo42ZI+tKEtnBK+FPnhdEGer
	zLFKS1h2vaA==
X-Google-Smtp-Source: AGHT+IGAPuABV5wfdKDsaJ74CXJ2o+DPzp2QEHBI9R/mhtkFS1teUu4D5SJTofX9u3uOZBKi8+3TSgReDnK6
X-Received: from pljc15.prod.google.com ([2002:a17:903:3b8f:b0:243:31a:f8e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc6:b0:243:485:26a5
 with SMTP id d9443c01a7336-2462eeb70abmr66268945ad.34.1755909172541; Fri, 22
 Aug 2025 17:32:52 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:32:07 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-12-irogers@google.com>
Subject: [PATCH v5 11/19] perf llvm: Disassemble cleanup
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
2.51.0.rc2.233.g662b1ed5c5-goog


