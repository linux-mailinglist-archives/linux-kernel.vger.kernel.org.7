Return-Path: <linux-kernel+bounces-724432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BF6AFF2CD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652FB1C85DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC014233714;
	Wed,  9 Jul 2025 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cKjayUXl"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078FF192B96
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092244; cv=none; b=Xqkc1OuYJhecjO9JN9LrPP9pXZHkm1uYwQFOS9WTYxYpmCZ9czf1YoJyoc63f/Me+eTeGP2KkhCLBsJmG1ddpvY2YzBnxZlXttOH5u/Az75OoNFS/oairp/yIy8olyfPS4b7cw4hIypkDUQBgxMUo9M+M6HkG2OVQpvUaJpQOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092244; c=relaxed/simple;
	bh=8PRNpQlw5cVQiU3Ay7iT0ACxAEga5uX0yyq9DKtBnn8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZWKqEXS2SoV3lvnNiMNAWppIRuidfodXGD9+x/amHLp6g1RJ23cuQG/iDBXAnxMikPOQYR88FGBoekw59liFDRwTyQ+JJESjPpY24o/x21Opp0agNu7sf18ivroGOyRhZGK12G50yNVex5WhBx/5WLgmdISzSqLCv0wokXK3FPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cKjayUXl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 9782D201A4CE; Wed,  9 Jul 2025 13:17:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9782D201A4CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752092242;
	bh=ycUyb3vpvCZc7LH6seCqrjGXc2qmEC/3oXRUoJRHcRU=;
	h=From:To:Cc:Subject:Date:From;
	b=cKjayUXlOfach3+INh62BhUDfDZzNkyR3s+Bs37hT6tH/QuR4oRNpebJzOVSNCm50
	 TMZDtQ66E1d74wIQ1arBu4uHGyDlD5uEgytDKh5hnVpDMUSJIErPHmQMh7iemW6PlX
	 BJORRqo6dmEwmhA0RNpNa1Ax0y38X/gMeDo6Gm2U=
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
Subject: [PATCH 1/2] x86/build: only align ENTRY_TEXT to PMD_SIZE if necessary
Date: Wed,  9 Jul 2025 13:16:58 -0700
Message-Id: <1752092219-16248-1-git-send-email-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

PTI requires the begin and end of ENTRY_TEXT be aligned to PMD_SIZE.
SRSO requires srso_alias_untrain_ret to be 2M aligned. This costs
between 2-4 MiB of RAM (depending on the size of the preceding section).
So, only align when PTI is enabled or SRSO is enabled.

Co-developed-by: Jared White <jaredwhite@microsoft.com>
Signed-off-by: Jared White <jaredwhite@microsoft.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 arch/x86/kernel/vmlinux.lds.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4fa0be732af1..522297cebe7c 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -65,8 +65,13 @@ const_cpu_current_top_of_stack = cpu_current_top_of_stack;
 		__end_rodata_hpage_align = .;			\
 		__end_rodata_aligned = .;
 
+#if defined(CONFIG_MITIGATION_PAGE_TABLE_ISOLATION) || defined(CONFIG_MITIGATION_SRSO)
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
+#else
+#define ALIGN_ENTRY_TEXT_BEGIN
+#define ALIGN_ENTRY_TEXT_END
+#endif
 
 /*
  * This section contains data which will be mapped as decrypted. Memory
-- 
2.49.0


