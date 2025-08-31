Return-Path: <linux-kernel+bounces-793476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 223C0B3D410
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6576D189A8EB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1334269CE6;
	Sun, 31 Aug 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="UCca4mI1"
Received: from smtpout6.mo534.mail-out.ovh.net (smtpout6.mo534.mail-out.ovh.net [54.36.140.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338D2475E3
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653153; cv=none; b=c2/hwiqVjUfHfkVsemMwP6DakC1wRfz9v5bKMmFvIwLXoXDjehR33+vTKZ03012JZdM/dm8JEWnhmxf2seEo/hAuVNzeCYv3oYrcF+u+cu7nAHA2aJGpc/O/yb050W83Qh/omnjjhhwTJivkTemUCg+IhMXuEmGcp1j4+mkawzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653153; c=relaxed/simple;
	bh=FPQaPwoeXYhWZyqooDCGO2WFzlf7VI2YSYM1Ci2vq2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdBLADpVSYxZfl2z/aO7YyR51RKgZPtxFJERfiSRWGo9exZnvRiFGj2LoJepZRlGxP/65QdH8yzq4VvOpu2GRPcYQON0fWhOXXcph2POQjL0WUXX3/B4gAis/uWu3zv59IzHNgwev90dyTaEZJQTOZMFWU53/OD5rd3A+yLqyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=UCca4mI1; arc=none smtp.client-ip=54.36.140.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4cFDz42dQ6z6F3w;
	Sun, 31 Aug 2025 14:34:08 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Sun, 31 Aug 2025 14:34:08 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.118.165])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cFDz40g97z1xnd;
	Sun, 31 Aug 2025 14:34:08 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.11])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 5B9D93E3332;
	Sun, 31 Aug 2025 14:34:05 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-107S001813568fc-dae5-4bb8-b732-b806965b7fc7,
                    23A339C4471D471A1DD83FCA36C9B7CDAC4723CD) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.112.4.128
Message-ID: <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
Date: Sun, 31 Aug 2025 16:34:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <202508291620.bcfb3924-lkp@intel.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <202508291620.bcfb3924-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6728377846728971956
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeelhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduuddvrdegrdduvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehsnhhovhhithholhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtgh
 hlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
DKIM-Signature: a=rsa-sha256; bh=6ZS+0qjMHtnOZV4jeeWAcsWiGsPsN5YEC7dK5camzzE=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756650849;
 v=1;
 b=UCca4mI1/xRnv8OWsOj2Q3U6u6Un8C4h70uEdDIk/NcVeJlmZR/sBsa8+l+gJeJvVN253lIu
 OalC6NVfr+wmtqOXZhj9GmtZ72/M4z8yoIC5539nFtZGD/kM+NoNiEYLa1n1nDngZ2Xeqia74T9
 ETsp6TBofkU61hvNriiTwifUzjLufWtfH8xOAYnuE6J+n9NjIvgEHul3XbI3wM0mHdRhA2yOBOM
 OfdhNP3DZ1iIcbUJwfFS2yA7wxDBYq4iAH+iwLcm7a02MdwiShV/xwSjj0rRq+q2081SYXgWfoR
 kEXPTAvorkB8WodPTvlgDe3oxTbMNl2TeC+9yVcR61sFA==

El 30/08/2025 a las 8:56, kernel test robot escribió:
> [   24.176151][ T2696] BUG: sleeping function called from invalid context at include/linux/uaccess.h:162
> [   24.176703][ T2696] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2696, name: trinity-c4
> [   24.177213][ T2696] preempt_count: 0, expected: 0
> [   24.177492][ T2696] no locks held by trinity-c4/2696.
> [   24.177788][ T2696] irq event stamp: 335112
> [ 24.178030][ T2696] hardirqs last enabled at (335111): irqentry_exit (kernel/entry/common.c:210) 
> [ 24.178521][ T2696] hardirqs last disabled at (335112): irqentry_enter (kernel/entry/common.c:?) 
> [ 24.179004][ T2696] softirqs last enabled at (332212): __do_softirq (kernel/softirq.c:614) 
> [ 24.179473][ T2696] softirqs last disabled at (332207): __do_softirq (kernel/softirq.c:614) 
> [   24.179948][ T2696] CPU: 1 UID: 65534 PID: 2696 Comm: trinity-c4 Tainted: G                T   6.17.0-rc2-00017-g09c737e0df5a #1 VOLUNTARY
> [   24.179952][ T2696] Tainted: [T]=RANDSTRUCT
> [   24.179954][ T2696] Call Trace:
> [ 24.179956][ T2696] __dump_stack (lib/dump_stack.c:95) 
> [ 24.179961][ T2696] dump_stack_lvl (lib/dump_stack.c:123) 
> [ 24.179963][ T2696] ? nbcon_get_cpu_emergency_nesting (kernel/printk/nbcon.c:1375) 
> [ 24.179967][ T2696] dump_stack (lib/dump_stack.c:129) 
> [ 24.179969][ T2696] __might_resched (kernel/sched/core.c:8958) 
> [ 24.179976][ T2696] __might_sleep (kernel/sched/core.c:8887) 
> [ 24.179979][ T2696] __might_fault (mm/memory.c:6957) 
> [ 24.179983][ T2696] _copy_from_user (include/linux/uaccess.h:?) 
> [ 24.179991][ T2696] insn_fetch_from_user (include/linux/uaccess.h:212 arch/x86/lib/insn-eval.c:1516) 
> [ 24.179995][ T2696] handle_invalid_op (arch/x86/kernel/traps.c:308) 
> [ 24.180010][ T2696] ? exc_overflow (arch/x86/kernel/traps.c:417) 
> [ 24.180012][ T2696] exc_invalid_op (arch/x86/kernel/traps.c:432) 
> [ 24.180014][ T2696] handle_exception (arch/x86/entry/entry_32.S:1055)

I am familiar with interrupts on microcontrollers and embedded systems,
but not with Linux's, so unsure how to proceed.

I've seen UMIP and IOPL emulation and they both run with interrupts enabled,
by means of cond_local_irq_enable, and then fetch from memory using regular
insn_fetch_from_user/get_user which may sleep.

VC, on the other hand, uses the insn_fetch_from_user_inatomic.

Can someone chime in on what should I do for this? Enable IRQs temporarily
using cond_local_irq_enable or local_irq_enable, or use the inatomic
version?

