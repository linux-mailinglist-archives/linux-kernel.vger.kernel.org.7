Return-Path: <linux-kernel+bounces-619712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E9A9C04C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 10:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A551189C836
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 08:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30E2309B9;
	Fri, 25 Apr 2025 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G9Jt30zz"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6226AEC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568090; cv=none; b=VIRfRyFEentHv7oRmFCOpfKTiP+YsfD5bYan43e0wYmKlvD/g/4fDR9bhSheZ1xOTV+GZX+/J30WmvTg88wAtU7JrrvmjWQPlV/wyXBve7tZiaNk3m47WTJfGLo0ZVKXwUgRkmSGZI61tWS1efIQs2FHbI6nZPSa4BQ5xNLnMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568090; c=relaxed/simple;
	bh=9i0pqeJF9Lv6Vi+wvxKY/gQ+rtNhrwok614Nr1Sr4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jm3/EnaQYyPc4OBKqLGsDvLQS4wogrm6YiFhC9DtEPIAVU5y52MVOCyBqQmyzwKz0s5pr9nHbZ+g4QA50hzta5G1O20NzHPl3KJW5zo+QFpaAsovpVmYUfHRxcwpHvnZb9iGFROWMsd2fldOR+kXZxy9TStuWqEQDKVD1Zq8TOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G9Jt30zz; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745568085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ysvHHKCoxOnwQA+EqA6Oq9PHFBYzde/132axQDe0NyE=;
	b=G9Jt30zzgf32eLKfsf7tyBckgc77qsPK17FWt1YtgldgE1D8gcPJcopTrE3e0+7JKBvBmV
	NYWXYeQ/GrVYTSakQcISWs5Nk+AiGIjj1eZMM0sPucMK/gpwrWinMbBtvFMdHayTnLdPxh
	42j/xDljnjxTtpC65mu48C1tEdTngkk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Rik van Riel <riel@surriel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Max Grobecker <max@grobecker.info>,
	Sandipan Das <sandipan.das@amd.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brendan Jackman <jackmanb@google.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Russell Senior <russell@personaltelco.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Eric Biggers <ebiggers@google.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu: Replace deprecated strcpy() with strscpy()
Date: Fri, 25 Apr 2025 09:49:11 +0200
Message-ID: <20250425074917.1531-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

In cyrix.c, use 'c->x86_model_id' directly and remove the local variable
'buf' to retain the array size of the destination buffer.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/cpu/amd.c    | 3 ++-
 arch/x86/kernel/cpu/common.c | 6 +++---
 arch/x86/kernel/cpu/cyrix.c  | 7 +++----
 arch/x86/kernel/cpu/intel.c  | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2b36379ff675..3a6daa862536 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/random.h>
+#include <linux/string.h>
 #include <linux/topology.h>
 #include <asm/processor.h>
 #include <asm/apic.h>
@@ -643,7 +644,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	}
 
 	if (!c->x86_model_id[0])
-		strcpy(c->x86_model_id, "Hammer");
+		strscpy(c->x86_model_id, "Hammer");
 
 #ifdef CONFIG_SMP
 	/*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126adbc3a9..ea43e70a9b40 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -183,9 +183,9 @@ static void default_init(struct cpuinfo_x86 *c)
 	if (c->cpuid_level == -1) {
 		/* No cpuid. It must be an ancient CPU */
 		if (c->x86 == 4)
-			strcpy(c->x86_model_id, "486");
+			strscpy(c->x86_model_id, "486");
 		else if (c->x86 == 3)
-			strcpy(c->x86_model_id, "386");
+			strscpy(c->x86_model_id, "386");
 	}
 #endif
 }
@@ -1919,7 +1919,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 		const char *p;
 		p = table_lookup_model(c);
 		if (p)
-			strcpy(c->x86_model_id, p);
+			strscpy(c->x86_model_id, p);
 		else
 			/* Last resort... */
 			sprintf(c->x86_model_id, "%02x/%02x",
diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index dfec2c61e354..07521e3f94d8 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -192,7 +192,6 @@ static void early_init_cyrix(struct cpuinfo_x86 *c)
 static void init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
-	char *buf = c->x86_model_id;
 	const char *p = NULL;
 
 	/*
@@ -352,9 +351,9 @@ static void init_cyrix(struct cpuinfo_x86 *c)
 		dir0_msn = 7;
 		break;
 	}
-	strcpy(buf, Cx86_model[dir0_msn & 7]);
+	strscpy(c->x86_model_id, Cx86_model[dir0_msn & 7]);
 	if (p)
-		strcat(buf, p);
+		strcat(c->x86_model_id, p);
 	return;
 }
 
@@ -416,7 +415,7 @@ static void cyrix_identify(struct cpuinfo_x86 *c)
 	if (c->x86 == 4 && test_cyrix_52div()) {
 		unsigned char dir0, dir1;
 
-		strcpy(c->x86_vendor_id, "CyrixInstead");
+		strscpy(c->x86_vendor_id, "CyrixInstead");
 		c->x86_vendor = X86_VENDOR_CYRIX;
 
 		/* Actually enable cpuid on the older cyrix */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index cdc9813871ef..5e60aaa871cb 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -605,7 +605,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 		}
 
 		if (p)
-			strcpy(c->x86_model_id, p);
+			strscpy(c->x86_model_id, p);
 	}
 #endif
 
-- 
2.49.0


