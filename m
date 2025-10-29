Return-Path: <linux-kernel+bounces-875311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D14C18ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032851C882CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7520C312831;
	Wed, 29 Oct 2025 07:18:31 +0000 (UTC)
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C731282B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722311; cv=none; b=L01Jdod0Fw4ugmq5ZLQDZrTr/jAq5DhKF6TwoDO4Cgv5NoKAmTtqedwQ7jTdLa8QzgseQF/SQNVEhDi/emBgFmbUQcWoE5YLyiM5HpWLqDjfGBKo46GM2aDjLLUXz1HytkX7s60Z1uzTYTXElA5ld+uIBUKBjEDNIHb/Jv6cOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722311; c=relaxed/simple;
	bh=banAxjb4JzHKNTkqMrN0AxY2NcpGLG8o+yUWzEXgexM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HzBC1CPp2plbiS5ssRoNBqpH29OyIMNnEk+5AQYkVr4TNEzwjm33gxgGj1EI/8T3+TXPOZoaVQjdwnc8Ab4070UwdMZqyF8eCGiRysbE0dm9iSBtAvgvIrFojv/2YvdrYq79B0I/fLFYkiCuAFPb2nW+G2JSnA5jKDhkULkHACE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201624.home.langchao.com
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id 202510291518166893;
        Wed, 29 Oct 2025 15:18:16 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 jtjnmail201624.home.langchao.com (10.100.2.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 15:18:15 +0800
Received: from inspur.com (10.100.2.113) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 29 Oct 2025 15:18:15 +0800
Received: from localhost.localdomain.com (unknown [10.94.19.60])
	by app9 (Coremail) with SMTP id cQJkCsDwlHi3vwFpiTgHAA--.5618S2;
	Wed, 29 Oct 2025 15:18:15 +0800 (CST)
From: Bo Liu <liubo03@inspur.com>
To: <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Bo
 Liu <liubo03@inspur.com>
Subject: [PATCH] arm: Fix double word in comments
Date: Wed, 29 Oct 2025 15:18:14 +0800
Message-ID: <20251029071814.17760-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cQJkCsDwlHi3vwFpiTgHAA--.5618S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1rGFWktF13ArWxtr1kXwb_yoW8WF15pa
	nruws7trn5GFyrt34UJrWDur43Ar1vqa1jqrykKw17Gry5XryvvF1vqFnxC3WDXw4kCa1r
	WFySkFWq9FnxXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUb7KsUUUUU
	U==
X-CM-SenderInfo: xolxu0iqt6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?nVJfxmLVRuiwy3Lqe5bb/wL3YD0Z3+qys2oM3YyJaJDj+48qHwuUARU7xYOAI0q1Re
	KIpWCyR62XitOcery6tyBHnWmyvKcnPtkR1dGMHZVwjFacMm5gqyd54n/GdGSdAFvGdO89
	5naeRSV9yC1d1RJqrS0=
Content-Type: text/plain
tUid: 20251029151816fa16ea344ddbe361a716733dd1481dec
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Remove the repeated word "the" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 arch/arm/Kconfig              | 4 ++--
 arch/arm/include/asm/unwind.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9b4024b277d4..33bafc34baa5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1482,7 +1482,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1624,7 +1624,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index d60b09a5acfc..a75da9a01f91 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
-- 
2.31.1


