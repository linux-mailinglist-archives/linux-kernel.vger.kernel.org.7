Return-Path: <linux-kernel+bounces-875050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB95CC18155
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0369A4E9C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77882E2DD4;
	Wed, 29 Oct 2025 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Aui1rmRQ"
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1FF266565
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705722; cv=none; b=lbDUPgMIQGcKSvhK9XNVsgNmK9K9GEbdcKbPd0MSDAzK90yQe9WTcAtg+YPEt6nJKRi+Wlo1DJx1qh8aucOrz37L9Gyg3OF/DWZKvDuIBrM0+ZDGvYLUsH2fAI+5iEYofA7cmziBw70BM9jBbrNOkqAyDTv47ifDWBTBrnPOYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705722; c=relaxed/simple;
	bh=H8in62bCZX1u6grl68iOx2j4pfI6C9u94V3AaNK2gB4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOxu6Y2ReLNUVKqE+DM8COXUm2faMgPN90vRmsQwD3VSgrpGxRZxedU2Gfv+JmybCK4+FeRNxNr4WIFiLFySKTQ6tUKTMZrx147EGhQTXalApuB9HkMqYcDPLInlOB+xREzwKpoLOu6E2/7N6jpmNHb+lY+h3/h20GMi5dIMtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Aui1rmRQ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FTZjyfw+Xgeed69jhy5PrzVKjkTsZcfK7eV+J3iJrzI=;
	b=Aui1rmRQGwtpzaZP4CDWOuHR1qNAPte2+RlcUSnoIYcf56zoatQeM6z9V6wkti3EPR0s9R1tj
	uzzCcgJXtdjJEcM9+fc7AbbZknSHvt0+rsHgNvJGQF9WSCCkWdqR8Utfmynr9hXZQKN2mDktowX
	hKih1QtHOmdRXsEH1kqQTbc=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cxBMM6jl5z12LJn;
	Wed, 29 Oct 2025 10:41:19 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 518FD180B4A;
	Wed, 29 Oct 2025 10:41:57 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 10:41:56 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <bigeasy@linutronix.de>
CC: <akpm@linux-foundation.org>, <arnd@arndb.de>, <brauner@kernel.org>,
	<kuninori.morimoto.gx@renesas.com>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
	<lorenzo.stoakes@oracle.com>, <marc.zyngier@arm.com>, <pfalcato@suse.de>,
	<punitagrawal@gmail.com>, <rjw@rjwysocki.net>, <rmk+kernel@armlinux.org.uk>,
	<rppt@kernel.org>, <tony@atomide.com>, <vbabka@suse.cz>, <will@kernel.org>,
	<xieyuanbin1@huawei.com>
Subject: Re: [PATCH v2 RESEND 1/2] ARM: spectre-v2: Fix potential missing mitigations
Date: Wed, 29 Oct 2025 10:41:51 +0800
Message-ID: <20251029024151.6005-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028182052.nrRad87D@linutronix.de>
References: <20251028182052.nrRad87D@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100009.china.huawei.com (7.202.194.3)

On Tue, 28 Oct 2025 17:20:05 +0100, Sebastian Andrzej Siewior wrote:
> If I apply both patches (of yours) then it sends a
> signal with disabled interrupts which breaks my PREEMPT_RT case.

I am not familiar with PREEMPT_RT yet and do not know that signals cannot
be sent with disabled interrupts and PREEMPT_RT=y.
I apologize for this.

On Tue, 28 Oct 2025 19:20:52 +0100, Sebastian Andrzej Siewior wrote:
> !LPAE does do_bad_area() -> __do_user_fault() and does not trigger the
> warning in harden_branch_predictor() because the interrupts are off.
> On PREEMPT_RT this leads to an error due to accessing spinlock_t from
> force_sig_fault() with disabled interrupts.

This seems to be a more serious bug, and may require another patch to
fix it. Not only !LPAE is affected, but LAPE=y is also affected:
do_translation_fault() -> do_bad_area() -> __do_user_fault()
This code path seems very easy to trigger.

> I guess the requirement is to invoke harden_branch_predictor() on the
> same CPU that triggered the page_fault, right? Couldn't we then move
> harden_branch_predictor() a little bit earlier, invoke it in the >=
> TASK_SIZE case and then enable interrupts if they were enabled?
>
> That would make me happy ;)

This seems to only fix the warning in harden_branch_predictor, but cannot
fix the issue of sending signals with disabled interrupts mentioned above.

What about adding:

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 09dde89a88ed..b9c9c80db109 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -182,6 +182,12 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 		int code, struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
+	const bool save_irqs_disabled = irqs_disabled();
+
+	if (save_irqs_disabled) {
+		preempt_disable();
+		local_irq_enable();
+	}

 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
@@ -207,6 +213,11 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 	tsk->thread.error_code = fsr;
 	tsk->thread.trap_no = 14;
 	force_sig_fault(sig, code, (void __user *)addr);
+
+	if (save_irqs_disabled) {
+		local_irq_disable();
+		preempt_enable_no_resched();
+	}
 }

and the modification of patch 1 is still retained.

Xie Yuanbin

