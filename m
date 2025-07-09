Return-Path: <linux-kernel+bounces-724433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2054AFF2CE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90904E6E5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05F242D79;
	Wed,  9 Jul 2025 20:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UNwEzBWR"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0795A1A2643
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092245; cv=none; b=MQjF4FYrcyGkrNGLqCXCyJL7F4KdajUiOsTL1nUC8YILvH2yl0dosNo4m3uDHXRYod+dZ5TRh03cHYftERk5xesNyNBBJy/5ND/RPHx8WI0tmszyZ76izpL4EF2GdmrgPQNcwxAPk93Cpe5GzUVGhvIqeygsF/wIJnNb/Gjv+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092245; c=relaxed/simple;
	bh=9cdKlVIq07K+LOmAuPiShw1Re+uLRRRQ5SU2/0La+4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iRLH/M4ksnBUziEw3vtzBHcoNt72ZE4u+mfGdNEsPj5JWreSvCZ3TdmRYGL3MU6MFa6Zi0q0YpyniN36G1jt1yAECoXYHS0A7ez4PdOzcFap6rEhNL0+dFFb9gipUqLgVIuq38jvErvA8gabW2+sGC+NEQ+OiUtkZKRM5rxT5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UNwEzBWR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id A4EC82112209; Wed,  9 Jul 2025 13:17:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4EC82112209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752092242;
	bh=loxMhYAhkVerxLNLpPv4l1YtrAuDnz920Ay7okkZJfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UNwEzBWRkTp0XcMYWHoligIW2jAYXrWjPLNpuzkYADKw8NFfUlc7K0vOkNFNcr10a
	 vT9IUUx8i+FPbm/pJkBgUBVdPasEru21sOvPo/kT6qr+2FlizdlCy6odDUH6ZGbYfT
	 2HHdmvCSb6leOTnuZV+555MZqUAF/654Ly+60U8M=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Jared White <jaredwhite@microsoft.com>
Subject: [PATCH 2/2] x86/mm/64: free the gap between BSS_MAIN and BSS_DECRYPTED
Date: Wed,  9 Jul 2025 13:16:59 -0700
Message-Id: <1752092219-16248-2-git-send-email-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752092219-16248-1-git-send-email-hamzamahfooz@linux.microsoft.com>
References: <1752092219-16248-1-git-send-email-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This region is unused after mark_rodata_ro() and takes up, up to 2 MiB
of memory. So, free it in mark_rodata_ro().

Co-developed-by: Jared White <jaredwhite@microsoft.com>
Signed-off-by: Jared White <jaredwhite@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 arch/x86/include/asm/sections.h | 1 +
 arch/x86/kernel/vmlinux.lds.S   | 2 ++
 arch/x86/mm/init_64.c           | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 30e8ee7006f9..1d6589bc0f68 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -8,6 +8,7 @@
 extern char __relocate_kernel_start[], __relocate_kernel_end[];
 extern char __brk_base[], __brk_limit[];
 extern char __end_rodata_aligned[];
+extern char __start_bss_decrypted_gap[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 522297cebe7c..f74a7a0d7a01 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -82,6 +82,8 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
  * decrypted to avoid exposing more than we wish.
  */
 #define BSS_DECRYPTED						\
+	. = ALIGN(PAGE_SIZE);					\
+	__start_bss_decrypted_gap = .;				\
 	. = ALIGN(PMD_SIZE);					\
 	__start_bss_decrypted = .;				\
 	__pi___start_bss_decrypted = .;				\
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index fdb6cab524f0..ff7ff5c12eb4 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1385,6 +1385,8 @@ void mark_rodata_ro(void)
 	unsigned long end = (unsigned long)__end_rodata_hpage_align;
 	unsigned long text_end = PFN_ALIGN(_etext);
 	unsigned long rodata_end = PFN_ALIGN(__end_rodata);
+	unsigned long bss_decrypted_gap_start = PFN_ALIGN(__start_bss_decrypted_gap);
+	unsigned long bss_decrypted_gap_stop = PFN_ALIGN(__start_bss_decrypted);
 	unsigned long all_end;
 
 	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
@@ -1422,6 +1424,8 @@ void mark_rodata_ro(void)
 				(void *)text_end, (void *)rodata_start);
 	free_kernel_image_pages("unused kernel image (rodata/data gap)",
 				(void *)rodata_end, (void *)_sdata);
+	free_kernel_image_pages("unused kernel image (bss_decrypted gap)",
+				(void *)bss_decrypted_gap_start, (void *)bss_decrypted_gap_stop);
 }
 
 /*
-- 
2.49.0


