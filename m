Return-Path: <linux-kernel+bounces-796203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1A5B3FD44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FE77AC5A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D32F3C23;
	Tue,  2 Sep 2025 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="CNIAHw7F"
Received: from smtpout2.mo534.mail-out.ovh.net (smtpout2.mo534.mail-out.ovh.net [51.210.94.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4527B500
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.94.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756810962; cv=none; b=JgDU4sA0z8+GQ+CmjaXHVRmZ5gniB97K3riEi5OuakjoTeuJmi5F3h5t7y1OURC4rI+usfMr3MzGXRWl8xT6gL2yROQ3y0fR+GTbGLMAlcKeScwGNylSnLejUnwgibkjhEIETw5AYeRA8pdiZLawesCcSSCKHbMPzOmcW3ePucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756810962; c=relaxed/simple;
	bh=S/59Xx9oI7mO+mpnyCgAURFeUbqNOppr5oayG2oL7Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opyWamB//2Y7GJUuJOoN9yZ3LSgMt2cekUTvMf3uAYHIWBtZpY77tvEuszihkzTsAD233ZmeDGgBJP2yKhacZLsGeIEUBQULSkrOkD1yJaT2Z3vDU3S5hHK79YPhgbetSIeAF1UBdjtxA9CguUwZD/L4F5jZdYUg7+oz/fx/Nk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=CNIAHw7F; arc=none smtp.client-ip=51.210.94.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4cGMyY5jXtz68Z3;
	Tue,  2 Sep 2025 10:52:37 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Tue,  2 Sep 2025 10:52:37 +0000 (UTC)
Received: from mta10.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.118.77])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cGMyY3StSz1xnV;
	Tue,  2 Sep 2025 10:52:37 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.10])
	by mta10.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 85568783365;
	Tue,  2 Sep 2025 10:52:35 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-100R00373481084-c78c-42ba-8108-eb1093d9fa40,
                    B677A376967D575A53C78FE4FF5C940A066EF03B) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.41.176
Message-ID: <9412e249-8184-4817-bf35-1216db97ad4d@orca.pet>
Date: Tue, 2 Sep 2025 12:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
To: Marc Haber <mh+debian-kernel@zugschlus.de>, "H. Peter Anvin"
 <hpa@zytor.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>,
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <202508291620.bcfb3924-lkp@intel.com>
 <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
 <33A549B7-B442-402C-A82C-862C0F509274@zytor.com>
 <51c25fb7-46be-4364-9371-6a7cb6b07625@orca.pet>
 <772C4DE8-8564-430D-9304-A39F88E07EBF@zytor.com>
 <aLan9S_47ERx69xO@torres.zugschlus.de>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <aLan9S_47ERx69xO@torres.zugschlus.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14732681756472858292
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnhepkeetffeiudekueejvefhvdfgteekvdduteekieevlefggeekjefhleejueeuhffhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddupdejledruddujedrgedurddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehsnhhovhhithholhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtph
 htthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
DKIM-Signature: a=rsa-sha256; bh=S/HKLbQE8Om1L6HE5o++//1yk7zss695JjNjWDEwPKQ=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756810358;
 v=1;
 b=CNIAHw7F0d4KCvjpNx2B+4xFS+VkfBPQi3r4sdhMtd4kenzRyZn4kvrke0bXVvxSGK1s8w9V
 okTLPr7TUeD0VvkXLuXnzqMoUtsN3drFR+fjoH3CE9VxXSJ7jrHCm2S29lJauVzk0KgIGD27Bem
 SErrozX0+s9WoOjdHkguECFWMqqigrOHwOo/B1c6gP8PzYDAlxLFeN/bMMNe6BdIwMLcVD3/UWF
 QdwYUWf/RAkhOpliqWAzoPvTerSMTdFRPRsuzVr/tJXSjs59PQ0KnbcHbF0GSD+MhSzwgDEjVXd
 6G6Z5cN/vx8UTE6/7tTf19nhtajovV7HRjR1aaJMfXeUg==

El 02/09/2025 a las 10:16, Marc Haber escribió:
> So you're saying that -fcf-protection is basically a no-op on i386 and
> will never have an effect?

Feel free to wait for the reply of someone that is not "lobbying" for
this, but the documentation seems fairly clear on this [1]:

"Today in the 64-bit kernel, only userspace shadow stack and kernel IBT are
supported."

Checking the kernel trap handler itself [2]:

DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
{
	if (user_mode(regs)) {
		if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
			do_user_cp_fault(regs, error_code);
		else
			do_unexpected_cp(regs, error_code);
	} else {
		if (cpu_feature_enabled(X86_FEATURE_IBT))
			do_kernel_cp_fault(regs, error_code);
		else
			do_unexpected_cp(regs, error_code);
	}
}

And shadow stacks, the user mode protection, is explicitely "not supported
for 32 bit" [3]:

static int shstk_setup(void)
{
	struct thread_shstk *shstk = &current->thread.shstk;
	unsigned long addr, size;

	/* Already enabled */
	if (features_enabled(ARCH_SHSTK_SHSTK))
		return 0;

	/* Also not supported for 32 bit */
	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) || in_ia32_syscall())
		return -EOPNOTSUPP;
	...
}

"in_ia32_syscall" expands to constant "true" on 32-bit kernels, and
"not in 32-bit compatibility mode" for 64-bit kernels.

So TL;DR: unless I'm mistaken, the problematic ENDBRs do at the moment,
not even in 64-bit, offer any security improvements for user-mode
applications. Only shadow stacks are supported, and only in 64-bit.

1: https://docs.kernel.org/arch/x86/shstk.html
2: https://github.com/torvalds/linux/blob/v6.17-rc4/arch/x86/kernel/cet.c#L149-L162
3: https://github.com/torvalds/linux/blob/v6.17-rc4/arch/x86/kernel/shstk.c#L166-L168

