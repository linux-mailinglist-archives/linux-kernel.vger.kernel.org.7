Return-Path: <linux-kernel+bounces-777513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E26B2DA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24675C5273
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACC2E2DE6;
	Wed, 20 Aug 2025 10:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="P+ODNSQr"
Received: from smtpout3.mo533.mail-out.ovh.net (3.mo533.mail-out.ovh.net [46.105.35.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8151C3F0C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.35.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687096; cv=none; b=du9cvNOvDqM0l+FnE/nkaoKDVLXV1ArRe3rRCS82ufEefxImX3eyOJ55eZSkfDqrRiC/6gXkq+L0VYxjFLowZc/0wc9y1UKLPmq4SyezCHYEf1RqTS9HSEl6OCVvPaTT+iz4YUmd0URM8z3YetibOc57S6TcRpDadAUXAxfRp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687096; c=relaxed/simple;
	bh=0+0C0ElcyEXA4jdCSmmm5yzTK8mDbztScHPUmWOwwTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKUDGlUbAKc+BoJvrqLdRE5dC8qnC4WRFJqIBbVPrEWvdRtzPaIgNwSfufw5uD/g1/BVphuf/Yp/pf9v+1wawdE+bABQZUSHtFEVQvljIVWyrMwsHzcLxOO1aghX5JwwrVk0LG3ZeloZ7WT3Ki5kZVTzxNnppk269xhLRwOByJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=P+ODNSQr; arc=none smtp.client-ip=46.105.35.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4c6Lps1yrrz5x2W;
	Wed, 20 Aug 2025 09:33:09 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Wed, 20 Aug 2025 09:33:08 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.164.164])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6Lpr5HLVz5wDK;
	Wed, 20 Aug 2025 09:33:08 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.7])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 26FF58E32D5;
	Wed, 20 Aug 2025 09:33:06 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-113S007de840050-a1f1-4138-b75f-720b7eb4cba9,
                    616188B862BD6F9D24C783D7A018D61FF224AB69) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
Date: Wed, 20 Aug 2025 11:33:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add hintable NOPs emulation
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <aKWR8e6VUEZEgbkw@lx-t490>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10832283004089489076
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheektdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
 gvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=izU720Mq1iB8t9xjnhr3sNW2J5sKD5b4HrcrFOqc/dk=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755682390;
 v=1;
 b=P+ODNSQr8UdRPnhfiVWUyFvcwMCUPIbllCaVGrRT1vwxjA+aJHJfPp7JrcKMN1g4nwk736jo
 fWVPOKww/JYAN6Z9FtUAXkYPa+uJ1WSkEv3FC8RXHM+8Ir6pCcbtGSXx4GWh3gUHX7pAxpNBZ8r
 Y6JhrAiuJj3yR5TdXSF6rzGwXlyn0F03GB84zNPvwXZKQYhKtJclUEQZWtawhwQutTXNatc+Qw5
 n9sQFxnIQjhrfAjaHX+tm83ufhIhz8pQEQh98lOsJBPld3U+AnD5RzmbkHREpFoy0RiMoJBpka3
 6Wgm3AEJAczq+EXgGjlCmOrP4ORdxUy8sJ4JsPxTvEibA==

Hi Ahmed,

El 20/08/2025 a las 11:14, Ahmed S. Darwish escribió:
> Can we please remove all this 'hnop_warn' trickery?  Removing it will
> simplifiy the code and avoid complicating 'thread_struct' further.
> 
> It's just the kernel doing its normal job.
> 
> And if the system is full of binaries with hintable NOPs, ratelimiting
> will not save you much.  I got hit recently by a 'ratelimited'
> correctible error PCI subsystem warning, and it still overflows the log
> buffers of my Thinkpad laptop, in just 4 to 5 days :(

But I think the kernel should let the user know the binaries they're
running are having some performance penalty due to this emulation, in case
they want to recompile without the offending flags.

Without the logging, they'd be in the dark and might get confused on why
their programs are running slower than on other machines.

>>
>> static inline void handle_invalid_op(struct pt_regs *regs)
>> {
>> +#ifdef CONFIG_X86_HNOP_EMU
>> +	if (user_mode(regs) && handle_hnop(regs))
>> +		return;
>> +#endif
>> +
>>
> 
> CPP conditionals within C function code are ugly.  Please do instead:
> 
>     static bool handle_hnop(struct pt_regs *regs)
>     {
> 	if (!IS_ENABLED(CONFIG_X86_HNOP_EMU))
> 		return false;
> 	...
>     }
> 
> Thanks for your contribution!

I originally did that, but then realized it was not possible due to
"handle_hnop" depending on the conditionally-available "hnop_warn" flag.

Greetings,
Marcos

