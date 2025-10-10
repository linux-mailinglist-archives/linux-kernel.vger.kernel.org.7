Return-Path: <linux-kernel+bounces-848555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E54BCE06A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0CE41B207FE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CFE1DE2D8;
	Fri, 10 Oct 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="M5Wa5NMb"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEAC36B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760115647; cv=pass; b=ufTHnmJkxOXvhs4KS1fLANis6M6y+Dcm/q1vqOY8xfh7eedCKu1+I4fqYyRRw+PI/O1/xXrZGZ2D6nhgjjtxiiUM8y6c7xX9ktwxHQpDCmt6wfmMteOfKHuPnRQMb7T+Q6lt56UfY8EBpLb64+HkZuyqMFbtG+DV6JcyoVkzo5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760115647; c=relaxed/simple;
	bh=Uo7YVPf3D7fr7mvGJsdOHO05q0/KiGt6GgHf8bpO94Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aaXYyEMHqdOfckdoUta9Mkhz6liwy4Qpp34YP3ixWfMCleTfDkaPl7oc/XH0z7UNKcaFmLPTHDRtg2/6Tn8UJ8858eCGHVPtAY+ahYOTV+ZefwGebCFddxxRmRpEMPso6D4jV7XweuKDClpM+u6WgGsPf9tsKS+L0bcW0LSFkO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=M5Wa5NMb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760115607; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WK0ldhloqs9N2pJW2knu2eYQYn7eIv5hVyVd0D6DQ/czS8ZY6xb6xGAkdARTnZW2DcGOASlyn69LKZMpYVKG1S6whJs9nKP1XTWNYmU4SEfzM46iupqFzCLN5qA1GODzRKraDIvkro71xlhhv+vWwM4UoUFjIw0CPsKci4av4Ao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760115607; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KgwysMF2rRR6+p9fVeVMjAFUrSSb19D9ikbRt+kiKJs=; 
	b=QKPxFh25rwaP+TzsYHRx26iSlRrMV/hEarRxlDXB/HI/C4hSOV8nYGA/1y2mEeT5i/+SV67vM0xuScbUWONv0+VIsARV5bWVj+h0NqLfMbGlJFys2G2/P/Q9g/MsAkgj5Y8GGMtbAmR30obCCaidrpFGI9SyrygN0Wp5t3PetWM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760115607;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=KgwysMF2rRR6+p9fVeVMjAFUrSSb19D9ikbRt+kiKJs=;
	b=M5Wa5NMbIUUHtQOdBVpVR3ZaCauNk0B2kutFltyHdjHlJmcWn5tQOtFtUcoldIYs
	SySpSbuqMH5Uf7Bw9Fi8+dgbUEhKXOiQj39lvHsYlZwHXje4pMFgoWmIDdcY5zkgqfW
	mg9TnahpKFeotCLtGGLZAWZ4jhZnJqVyDHEP+55Q=
Received: by mx.zohomail.com with SMTPS id 1760115605203246.01198062238257;
	Fri, 10 Oct 2025 10:00:05 -0700 (PDT)
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
Subject: [PATCH v2] x86/CPU/AMD: Prevent reset reasons from being retained among boots
Date: Sat, 11 Oct 2025 00:59:58 +0800
Message-ID: <20251010165959.49737-1-i@rong.moe>
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

Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537#attach_303991
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- Remove a debug message (suggested by Borislav Petkov)
- No longer mention this behavior in the documentation
- Link to v1: https://lore.kernel.org/r/20250913144245.23237-1-i@rong.moe/
---
 arch/x86/kernel/cpu/amd.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5398db4dedb4a..ccaa51ce63f6e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1355,11 +1355,23 @@ static __init int print_s5_reset_status_mmio(void)
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
+	iounmap(addr);
 
 	for (i = 0; i < ARRAY_SIZE(s5_reset_reason_txt); i++) {
 		if (!(value & BIT(i)))

base-commit: 7d24c651ce163bc04e7683ec75bf976b6ff042e2
-- 
2.51.0


