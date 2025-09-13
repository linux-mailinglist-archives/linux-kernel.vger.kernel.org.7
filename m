Return-Path: <linux-kernel+bounces-815245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF02B5619F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99EB170A53
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6842F0666;
	Sat, 13 Sep 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="RdoAGk0r"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14D2ECD39
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757774617; cv=pass; b=nJmLVoSKKiC0SBFiNAl9dkWMmxiypO2zslWafLWRtnSM55B+HnucJUils8Q+F2vGRG6zIasODJWyLfpFJmer/elpT7eZfSZRzDcIMtid32bFsnkKA4P5stcMynjrqGAaD+Jclg31noPzaYm1ek461s44Y3MPBYZ5K5ZejwEm6O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757774617; c=relaxed/simple;
	bh=fc01Jut6MqNnd3xkzMmuqWihe5hLXskKpTvasOk3uw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uaiMDn64KWtT/FJAm0ZQK2DoZ5bwSq/za6H6Woy+FpCBkcFL1cO0bQ391G4vV477T3rSWS4a5qsmJdAMgvdpw6bymDjgsrfg4I5yQ0X2e35h1XS5q1da70gf8z48S1wioytcTXyHYsLBWVOpQ3AA956ns0tMjKJV6S+5T0kas6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=RdoAGk0r; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1757774577; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=a8nU9s6fD8p2ICRSPxAi57qU53XiwWmb9FJI9iqGbbXsSp08S+kCbTXwK6r3eS9DOLVgNa0gpukZp1gx0rHIuXrPKMqWXCZiZ9+Ch9ZNJ+NcI08mF7qaCjeG0Col4bzfAgkFnA7t4oztJ0uwbPxI8wTUiEhdLYRC8WNUGQWNpxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757774577; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mqo1jGC4Q9W8IEeh0d+tcrQri+kPzvpctJd541qUkrY=; 
	b=Vh9GBrdtEx7Mol3RGLWK9eGMKRbVDWGQ8+ze0jIi8unFOvo0i4z/f9szWkKcLsP8+Kr1Xo7ECIwjqtCMRAteUvB8vh6yO0569GKjtpCSxoLyZhRKGFGqUjQAvGwHZDMbIWlp9KDWtc5/khtfky5vWd/z3kSrYOFn1b4rlqN+FbU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757774577;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Mqo1jGC4Q9W8IEeh0d+tcrQri+kPzvpctJd541qUkrY=;
	b=RdoAGk0rYEeg4P1Qri03wGSpT5Ie97dOpVNTqLeV4xJyK70orp5lhyWmahEtVApj
	3iKKxiQnNazEYzi5I0FzpFqqvbDd+KDHMrt5QLeirbI03ct7t86HdEouhQrDnH3EnII
	Q/bC+bo38Fd5WhXpUZT/aIR5E7GIe6j7Jm4gM5pc=
Received: by mx.zohomail.com with SMTPS id 1757774575655490.4115458327798;
	Sat, 13 Sep 2025 07:42:55 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Rong Zhang <i@rong.moe>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/CPU/AMD: Prevent reset reasons from being retained among boots
Date: Sat, 13 Sep 2025 22:42:45 +0800
Message-ID: <20250913144245.23237-1-i@rong.moe>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The S5_RESET_STATUS register is parsed on boot and printed to kmsg.
However, this could sometimes be misleading and lead to users wasting a
lot of time on meaningless debugging for two reasons:

* Some bits are never cleared by hardware. It's the software's
responsibility to clear them as per the Processor Programming Reference
(see Link:).

* Some rare hardware-initiated platform resets do not update the
register at all.

In both cases, a previous reboot could leave its trace in the register,
resulting in users seeing unrelated reboot reasons while debugging
random reboots afterward.

Clearing all reason bits solves the issue. Since all reason bits are
write-1-to-clear and we must preserve all other bits, this is done by
writing the read value back to the register.

A debug message with the cleared register value is also printed to help
distinguish between non-reason bits set and present reserved values
defined in the future.

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537#attach_303991
Signed-off-by: Rong Zhang <i@rong.moe>
---
 Documentation/arch/x86/amd-debugging.rst |  3 +++
 arch/x86/kernel/cpu/amd.c                | 25 +++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/amd-debugging.rst b/Documentation/arch/x86/amd-debugging.rst
index d92bf59d62c77..4723ad32ddcd3 100644
--- a/Documentation/arch/x86/amd-debugging.rst
+++ b/Documentation/arch/x86/amd-debugging.rst
@@ -366,3 +366,6 @@ There are 6 classes of reasons for the reboot:
 This information is read by the kernel at bootup and printed into
 the syslog. When a random reboot occurs this message can be helpful
 to determine the next component to debug.
+
+To prevent unrelated reboot reasons from being retained among boots,
+the kernel clears all reason bits once reading the register.
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5398db4dedb4a..c2e3925eb6855 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1344,7 +1344,7 @@ static const char * const s5_reset_reason_txt[] = {
 static __init int print_s5_reset_status_mmio(void)
 {
 	void __iomem *addr;
-	u32 value;
+	u32 value, cleared_value;
 	int i;
 
 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
@@ -1355,11 +1355,25 @@ static __init int print_s5_reset_status_mmio(void)
 		return 0;
 
 	value = ioread32(addr);
-	iounmap(addr);
 
 	/* Value with "all bits set" is an error response and should be ignored. */
-	if (value == U32_MAX)
+	if (value == U32_MAX) {
+		iounmap(addr);
 		return 0;
+	}
+
+	/*
+	 * Clear all reason bits so they won't be retained if the next reset
+	 * does not update the register. Besides, some bits are never cleared by
+	 * hardware so it's software's responsibility to clear them.
+	 *
+	 * Writing the value back effectively clears all reason bits as they are
+	 * write-1-to-clear.
+	 */
+	iowrite32(value, addr);
+	cleared_value = ioread32(addr);
+
+	iounmap(addr);
 
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))
@@ -1371,6 +1385,11 @@ static __init int print_s5_reset_status_mmio(void)
 		}
 	}
 
+	if (cleared_value != value) {
+		pr_debug("x86/amd: Cleared system reset reasons [0x%08x => 0x%08x]\n",
+			 value, cleared_value);
+	}
+
 	return 0;
 }
 late_initcall(print_s5_reset_status_mmio);

base-commit: f7a6ef198ded30b63810efdc923b919606ea65c8
-- 
2.51.0


