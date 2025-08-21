Return-Path: <linux-kernel+bounces-780130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC7AB2FDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2BB7B181F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7438D2D8362;
	Thu, 21 Aug 2025 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="du1VaMzg"
Received: from smtpout6.mo534.mail-out.ovh.net (smtpout6.mo534.mail-out.ovh.net [54.36.140.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BD827F759
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789088; cv=none; b=Mxn1l7EZCLc6Vttv0ZXaxLvj7h04tGHyqO0ymqVT25X+JEbtYVBUh5tVsPDEvq2GiELmhlfcZdZmsbl0UOHiznUlMT7pmda/EhNlBu3Eqky2tRN6uwxBLazpjnEi7eM3ezkxAEFqaanT7/cyvKirVf91SFKJEB1gSh5YOfZUvW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789088; c=relaxed/simple;
	bh=SyDcBCjUl2UTge3XmRjuH2AcNa9i01d108k6ueOFmr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSwFpK9nnHAMwRGWelqPCk9oSpm3hYG523xJyy01MlZKU33JQJLjR0HMttIkBzcRW7Zuy2PpHqWub8Xh3/hRcwR+TRI0NZ8t61FwSg7egOKM4kZi7xc4vgLy4A0rsVAyiPlbPUA6FigSezye4j3/9o0bnA+IWDMLHOtWhkdyh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=du1VaMzg; arc=none smtp.client-ip=54.36.140.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c76Gf2TDRz6GTv;
	Thu, 21 Aug 2025 15:11:22 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Thu, 21 Aug 2025 15:11:21 +0000 (UTC)
Received: from mta10.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.101.31])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c76Gd6Btpz1xpJ;
	Thu, 21 Aug 2025 15:11:21 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.5])
	by mta10.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 736EE7832E2;
	Thu, 21 Aug 2025 15:11:19 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G0023f322332-2362-4479-94ea-bf9a870d9e19,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <2e7029bd-5e3b-4c4b-b969-b1a3794b2fec@orca.pet>
Date: Thu, 21 Aug 2025 17:11:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add hintable NOPs emulation
To: David Laight <david.laight.linux@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, "Ahmed S. Darwish"
 <darwi@linutronix.de>, Kees Cook <kees@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250820013452.495481-1-marcos@orca.pet>
 <20250820090733.GJ3245006@noisy.programming.kicks-ass.net>
 <20250821132807.0a898dfa@pumpkin>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250821132807.0a898dfa@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3970204548927149748
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusg
 hiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=Fvb1hrWI5rhNu+9c7aAjt4RYLlhbLkm3O1wYlqc0QI4=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755789082;
 v=1;
 b=du1VaMzgDuMjOKup93F0kROKhUtkIzJr1hOyYZgrY91X+qF9JaX6C825J8XiQWwm0ComAR+c
 3fON26zP0UFObtWWUT86T+a6FovEwmeCjBcG6sb8rc1zxKc0mLnISr2RRdcDNGnlbtvzIxn4/mL
 QILJDN8YGKZwmcPIjUkQ7HijTh+lZnYJjH/Ru27eyDGXSRjkI7Up4HYDMnPJseve5r550k6fSBE
 zCS45KOt+nm9biaMLyx55HlSECZVbVPn7P0EvcjWoQM6gwKyMqFWAPMsXmsA+doQLl6r5QM9w5G
 4Q+DsnEp29420qN8iByOsgDR8+oayayvSnOY6VLBku24g==

El 21/08/2025 a las 14:28, David Laight escribió:
>> This is going to be terribly slow if there's a significant number of
>> traps (like with endbr32), but yeah, this ought to work.
> 
> Could you patch the memory resident page to contain a supported nop?
> (without marking it 'dirty')
> Then the same function wouldn't trap until the code page was reloaded
> from the source file.
> 

While I had thought of that, to be honest I'm not knowledgeable enough
in kernel development to pull that off without being 100% sure I did not
introduce any compatibility or security issues, so I preferred for the
time being to play it safe.

Anyhow, I made a simple benchmark running "sudo" with NOPASSWD as provided
by Debian bookworm i686, and another version compiled without ENDBR32s, and
the overhead does not seem to be too high:

# time for i in {1..100}; do ./sudo-nocet echo "" >/dev/null; done
real    0m6,001s
user    0m3,664s
sys     0m1,576s

# time for i in {1..100}; do sudo echo "" >/dev/null; done
real    0m5,983s
user    0m3,546s
sys     0m1,717s

The original binary has 203 "endbr32"s, and they result in a 0.3% slowdown
for this binary in particular, which is totally acceptable IMO.

Greetings,
Marcos

