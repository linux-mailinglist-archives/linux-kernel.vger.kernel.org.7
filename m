Return-Path: <linux-kernel+bounces-779434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5360FB2F40C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE591BC1C19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB92D9ED8;
	Thu, 21 Aug 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="Ui9zIsF2"
Received: from 9.mo533.mail-out.ovh.net (9.mo533.mail-out.ovh.net [188.165.47.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672871DF74F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.47.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768910; cv=none; b=NzpvU0V8Ed33aiXxv9qbt2tnKl5kpf9GjH1I+aVd0gximXcfVO1OeYOAl2CTrncH783pdx4wgEdkrbxOEkjR2W6k/fR38K4eAx67WrHGg3C4MRWjdCEZK+dMkBoIl1JSiGqVT3CIRGgd+HWwJtKW88UOKEtf/NqH0oq3/32c/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768910; c=relaxed/simple;
	bh=vSy0u5rqzbAcHiM6ktr8vOBdqjdwmzLfCOVwg8VHRFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vvoh6/ITktGHrERNH+qFA0MfS/a3WPLingx+8mspOhnKCMij4YQySU57mHCa1q70InSuPdgMBt813flNzA5lpqnH7RrSP+Md9xn7qkC1x7U+Ri703/TpVQ+X5wysvGnmwY6xrNFZVw9TfJ6H5DoipoMaDyZ+F06mcI/Y1jAFVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=Ui9zIsF2; arc=none smtp.client-ip=188.165.47.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4c6ypb1vrqz5xHk;
	Thu, 21 Aug 2025 09:35:03 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Thu, 21 Aug 2025 09:35:02 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.101.166])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6ypZ4SsHz5xT4;
	Thu, 21 Aug 2025 09:35:02 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.6])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 6E42A3E32C5;
	Thu, 21 Aug 2025 09:35:00 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-106R0066d340cff-da3a-45d0-bbaf-3a55200613d7,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <77c08318-f67d-42e0-8745-6a999e2e9f62@orca.pet>
Date: Thu, 21 Aug 2025 11:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add hintable NOPs emulation
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, "Ahmed S. Darwish"
 <darwi@linutronix.de>, Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250820013452.495481-1-marcos@orca.pet>
 <08A1B314-C015-4EE9-A13D-3D712FD274C4@zytor.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <08A1B314-C015-4EE9-A13D-3D712FD274C4@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16737065066167359156
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpeeffeelueevgeeijeehgfegfeeltdetteeifeevtedtudehffeuudekgeevheeitdenucffohhmrghinhepuggvsghirghnrdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghkse
 hgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=vSy0u5rqzbAcHiM6ktr8vOBdqjdwmzLfCOVwg8VHRFA=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755768904;
 v=1;
 b=Ui9zIsF2Sh9TwEx/m7ijXoxNSpqYaBodi32hrDbx9deQOWBxB2PU24xemyvA2Qo/iomwZKou
 zqG28bdhoM259vVjcmAJy364UVJ7DM1VT7SNSHSeix734jlwEM5fJVBS+D46CltMq+uKE6mIXpp
 9iKXTcSnOpS1JZVAASKy3cGLpJ7f/VVvtn1rHNOb7icJWNcjJar5EXjMXgM2SQh4tpKi6XOy1ze
 17RsVkS0+nd6wlsAIKKnJudqww0b6UbqY1ZKZ90Z8OOahIf2RkVOqgqG+xUsDi76kXgFPOAblJ9
 0J24bV3BHyHzJceQPcY41tLxYZJWY5TUNYd94bNKpMDmQ==

El 21/08/2025 a las 3:43, H. Peter Anvin escribió:
> On August 19, 2025 6:34:46 PM PDT, Marcos Del Sol Vives <marcos@orca.pet> wrote:
>> One such software is sudo in Debian bookworm, which is compiled with
>> GCC -fcf-protection=branch and contains ENDBR32 instructions. It crashes
>> on my Vortex86DX3 processor and VIA C3 Nehalem processors [1].
>>
>> This patch is a much simplified version of my previous patch for x86
>> instruction emulation [2], that only emulates hintable NOPs.
>>
>> [1]: https://lists.debian.org/debian-devel/2023/10/msg00118.html
>> [2]: https://lore.kernel.org/all/20210626130313.1283485-1-marcos@orca.pet/
>
> Do those processors support FCOMI?

The Vortex86DX3, at the very least, does. Unlike the Vortex86MX I wrote the
previous patch for, this one seems to support all standard i686
instructions. It's modern enough to support SSE1, even.

I have tested it using the program I wrote for testing it on the -MX
last time: https://lore.kernel.org/all/b69e0c78-81eb-0d4d-dce5-076b5f239e28@orca.pet/.

> marcos@vdx3:~$ LANG=C gcc -Wall fucomi-test.c -o fucomi-test
> marcos@vdx3:~$ ./fucomi-test
> Float value: 6.210000
> FPU status: 3800 EFLAGS: 00000242

Which matches 1:1 my current desktop Ryzen 8645H.

Greetings,
Marcos

