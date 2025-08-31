Return-Path: <linux-kernel+bounces-793544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6DFB3D4FC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 479173B7CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AABF22156A;
	Sun, 31 Aug 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A6cKU/lN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0871A8F97
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756668815; cv=none; b=t6b8X63mbfmWIJ8JFCVoGeDF+NAoSsZv4ZYjaewg/KWLmjEyysxnNVpaQl1xnDVQ118QjQkEyL6y2l9t8/1nPBJ63jKFrGMn8nE1RFoaqrAFnkRpeI4ApB590h3QYZ/AtSAQm/Qzws28PjA1aBuga6xs9rb8Z4WA0T2HIH02mrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756668815; c=relaxed/simple;
	bh=EaMPsSvE5PVbzUUTnekReEWMcEGq+VRsVOKjWj8jbb0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Yy5MpDOQoSxPyvbv/O0V/vnMyAoqMkGq43QwMWUq1zadMo2JK9erzFMn5VnkUKdg3BE5pLWA+HNPzq217/QEI3xjDZ7od9Oa1Il/T4I3tnz42j5B4uX9Qjh/RAkk7NcujkjO/VMHyrQdDk8rdqTXK6K0zQINnEu8ykUCS/THzys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=A6cKU/lN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 57VJWD7o3874731
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 31 Aug 2025 12:32:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 57VJWD7o3874731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025082201; t=1756668735;
	bh=a1X0BCW955Uxm38uJ6wH2GD1ohqLhfnibTONg+GpRSM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=A6cKU/lNinm0iPkLVpquticqOOrx06UL09F7JwCuVW/BL9x9NB1WkB9QIrrl1sYwZ
	 ZXLO98y9qxzBdqIi24uZCIeW2N6ZUyE9IPCsiBXZ7ejtoskg6Enm/7Dv2NK4Bh6tmQ
	 qwvrMs9AD8ULdtspwFOY+voBybS0DFrARZDfg5SLwrO5Jp+pk4Qiwn8NJ7wxoMAdmd
	 R4m1+fvM9m+oS3VKAqRtI1PVGqFcNJJVd7yBsUiQWQfZ+789dxKQZCIPT+5fQXUKfu
	 Vww334eFdCfvlm/tUb1JscvU7C2jEkpxznLQS6qIuw+AIDAoY28SPh/rPc9EdVgRIh
	 zLAAUCstL4gnw==
Date: Sun, 31 Aug 2025 12:32:13 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Marcos Del Sol Vives <marcos@orca.pet>,
        kernel test robot <oliver.sang@intel.com>
CC: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        "Xin Li (Intel)" <xin@zytor.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
User-Agent: K-9 Mail for Android
In-Reply-To: <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
References: <202508291620.bcfb3924-lkp@intel.com> <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
Message-ID: <33A549B7-B442-402C-A82C-862C0F509274@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 31, 2025 7:34:05 AM PDT, Marcos Del Sol Vives <marcos@orca=2Epet>=
 wrote:
>El 30/08/2025 a las 8:56, kernel test robot escribi=C3=B3:
>> [   24=2E176151][ T2696] BUG: sleeping function called from invalid con=
text at include/linux/uaccess=2Eh:162
>> [   24=2E176703][ T2696] in_atomic(): 0, irqs_disabled(): 1, non_block:=
 0, pid: 2696, name: trinity-c4
>> [   24=2E177213][ T2696] preempt_count: 0, expected: 0
>> [   24=2E177492][ T2696] no locks held by trinity-c4/2696=2E
>> [   24=2E177788][ T2696] irq event stamp: 335112
>> [ 24=2E178030][ T2696] hardirqs last enabled at (335111): irqentry_exit=
 (kernel/entry/common=2Ec:210)=20
>> [ 24=2E178521][ T2696] hardirqs last disabled at (335112): irqentry_ent=
er (kernel/entry/common=2Ec:?)=20
>> [ 24=2E179004][ T2696] softirqs last enabled at (332212): __do_softirq =
(kernel/softirq=2Ec:614)=20
>> [ 24=2E179473][ T2696] softirqs last disabled at (332207): __do_softirq=
 (kernel/softirq=2Ec:614)=20
>> [   24=2E179948][ T2696] CPU: 1 UID: 65534 PID: 2696 Comm: trinity-c4 T=
ainted: G                T   6=2E17=2E0-rc2-00017-g09c737e0df5a #1 VOLUNTAR=
Y
>> [   24=2E179952][ T2696] Tainted: [T]=3DRANDSTRUCT
>> [   24=2E179954][ T2696] Call Trace:
>> [ 24=2E179956][ T2696] __dump_stack (lib/dump_stack=2Ec:95)=20
>> [ 24=2E179961][ T2696] dump_stack_lvl (lib/dump_stack=2Ec:123)=20
>> [ 24=2E179963][ T2696] ? nbcon_get_cpu_emergency_nesting (kernel/printk=
/nbcon=2Ec:1375)=20
>> [ 24=2E179967][ T2696] dump_stack (lib/dump_stack=2Ec:129)=20
>> [ 24=2E179969][ T2696] __might_resched (kernel/sched/core=2Ec:8958)=20
>> [ 24=2E179976][ T2696] __might_sleep (kernel/sched/core=2Ec:8887)=20
>> [ 24=2E179979][ T2696] __might_fault (mm/memory=2Ec:6957)=20
>> [ 24=2E179983][ T2696] _copy_from_user (include/linux/uaccess=2Eh:?)=20
>> [ 24=2E179991][ T2696] insn_fetch_from_user (include/linux/uaccess=2Eh:=
212 arch/x86/lib/insn-eval=2Ec:1516)=20
>> [ 24=2E179995][ T2696] handle_invalid_op (arch/x86/kernel/traps=2Ec:308=
)=20
>> [ 24=2E180010][ T2696] ? exc_overflow (arch/x86/kernel/traps=2Ec:417)=
=20
>> [ 24=2E180012][ T2696] exc_invalid_op (arch/x86/kernel/traps=2Ec:432)=
=20
>> [ 24=2E180014][ T2696] handle_exception (arch/x86/entry/entry_32=2ES:10=
55)
>
>I am familiar with interrupts on microcontrollers and embedded systems,
>but not with Linux's, so unsure how to proceed=2E
>
>I've seen UMIP and IOPL emulation and they both run with interrupts enabl=
ed,
>by means of cond_local_irq_enable, and then fetch from memory using regul=
ar
>insn_fetch_from_user/get_user which may sleep=2E
>
>VC, on the other hand, uses the insn_fetch_from_user_inatomic=2E
>
>Can someone chime in on what should I do for this? Enable IRQs temporaril=
y
>using cond_local_irq_enable or local_irq_enable, or use the inatomic
>version?

I'm really, *really* starting to question this approach=2E=20

The right thing would be to not compile in endbr instructions on 32 bits, =
since they aren't supported by the kernel (if you try to enable CET/IBT you=
 will crash instantly, because there is no endbr32 at the vdso system can e=
ntry point right now=2E)

We are talking about a very small number of CPUs stuck between generation =
5 and generation 6=2E Most likely we are talking about a much smaller numbe=
r than the i486 support we have been debating lately=2E=2E=2E


