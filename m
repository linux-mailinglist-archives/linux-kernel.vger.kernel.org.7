Return-Path: <linux-kernel+bounces-779789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 606BAB2F8C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5150C4E5EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6472D3744;
	Thu, 21 Aug 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="P/ZNsl0w"
Received: from smtpout1.mo534.mail-out.ovh.net (smtpout1.mo534.mail-out.ovh.net [51.210.94.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE242E03E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.94.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780490; cv=none; b=o3LRxbbSkBd6n5CsqXPafiXi8ZQjo0KkEnsXVAc+JGpzuCw13Qv9lzqFbexWlHd1HjsrQ2IpTKHo9tI97SwaH7BNgrBadiT8f7wD0YLWiuHRDcqJRA/w3+y0R5K71yvlyW2WBxD6LThPWktQFZLcODuBQS+RfGF1Q1YpzFWiQuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780490; c=relaxed/simple;
	bh=oKStENpQEshey7YNoOtCrwuLKL8fkAkcMNV77p5iD70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqOQMYq1CjKZNgDfJBBud7romlQD0uNN9D9eBMLSNRlzxNaOOkPWZxzSfqcyZp1ONLSbkHt7k1lejtUL9/KhPoU0oNiKv5Tl2pVP3hxEEMD3GxuSXlp1RqylK90DE6vjyTjxrWGFVnLMPqoFECVvarXCiEQJqt0H03gTM+X09C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=P/ZNsl0w; arc=none smtp.client-ip=51.210.94.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c735H4Fxyz69tF;
	Thu, 21 Aug 2025 12:48:03 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Thu, 21 Aug 2025 12:48:03 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.198])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c735H06NYz5xTL;
	Thu, 21 Aug 2025 12:48:03 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.7])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 461199A32E3;
	Thu, 21 Aug 2025 12:48:00 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-103G005858eddca-51a9-495f-827d-2022d188ad41,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <2bbd0e25-a285-4475-9709-42ae65cb47ea@orca.pet>
Date: Thu, 21 Aug 2025 14:48:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add hintable NOPs emulation
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, "Ahmed S. Darwish"
 <darwi@linutronix.de>, Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250820013452.495481-1-marcos@orca.pet>
 <20250821132605.2093c37a@pumpkin>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250821132605.2093c37a@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1550082698867922612
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusg
 hiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=2d42E9Si50OB3pdcueb3fpHrheFKHYOtb9zddv0Zrgg=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755780484;
 v=1;
 b=P/ZNsl0wnIplYjLrOlIZbG53pm8gJnBWKNcRrBjrDlGg1Ml6AkSJo/jdoqsuTKHGJwahWWae
 dWj991pSMlRZdtJLdcehIYQ9htjku0Z2R5lW7GTUPaRsiLuSfypX41Sq11BdhkiyQBQAZHr7h2r
 U/WbV65eOSbBSXuQ5OeyqVOFArrVY9huVUFipT7WpO+ncZxWK/pVoSKiB5f/I3iROnsVBZ/bUPI
 d659oF/TRZA26kR/Jk9Zlfx+CM15mzzSZuzqtfJfrQWjH1EXwENCgIOSh1zN34theYQ8hETVsVx
 7qzal82j95VNEEXynoVuZ3rdgyMg2TCu72eqQNcLXKLzA==

El 21/08/2025 a las 14:26, David Laight escribió:
> Marcos Del Sol Vives <marcos@orca.pet> wrote:
>> +	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
>> +		return false;
>> +
>> +	/* Hintable NOPs cover 0F 18 to 0F 1F */
>> +	if (insn.opcode.bytes[0] != 0x0F ||
>> +		insn.opcode.bytes[1] < 0x18 || insn.opcode.bytes[1] > 0x1F)
>> +		return false;
> 
> Can you swap the order of those tests?
> Looks like the 'decode' is only needed for the length.
> 

Not really. The opcodes may have prefixes that are "removed" by the decode
function. ENDBR32 for instance is actually "F3 0F 1E FB", with a REP
prefix.

>> +#ifdef CONFIG_X86_HNOP_EMU
>> +	if (user_mode(regs) && handle_hnop(regs))
>> +		return;
> 
> Why not move the user_mode() test into handle_hnop() ?
> Should make the config tests easier.
> 

Other code I saw did this in the calling function itself (eg handle_bug)
so I did it here too.

