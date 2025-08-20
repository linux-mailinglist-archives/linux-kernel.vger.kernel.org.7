Return-Path: <linux-kernel+bounces-777439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2896B2D92C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960A24E4A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B23327C879;
	Wed, 20 Aug 2025 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="alXELS6U"
Received: from smtpout9.mo534.mail-out.ovh.net (smtpout9.mo534.mail-out.ovh.net [178.33.251.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9ED221FC7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.251.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683496; cv=none; b=sVW64i0KTmguwiiygFZEYbJMtCypPpbNwa6DnfooVAA7jzahsU54pW0VLycxFxwrdQf54hnvF9c6EKnYcpQwYbNC7TLUFbry/P0Rosnb8chRDWJ9poCvTG5wS5qIQ1tBj+4OQJBXM0zQCCRHTuUdbmj8JLx0YFE9oyK7ke/PUXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683496; c=relaxed/simple;
	bh=LjIiuIvTvW3zfGFEHP8OBvqSzvdP3sXwjPprS50oumQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezeD1RtER9L23oebzTEy4M3sST8I67YOlZCwZWuwcbRDJTIFTCaUCvBSZ6LNcL7NyKFWAVcWKS8/pfjnuEbJOk7XLbsY+2NVAX9Z/rFhEtfYM8npFMf/FyBhN5y3EJvnjqHZitDXj/FBRtIdVYcA70s8WBx0EspazcHvmhEjeFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=alXELS6U; arc=none smtp.client-ip=178.33.251.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c6MD32WxKz6FyW;
	Wed, 20 Aug 2025 09:51:31 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Wed, 20 Aug 2025 09:51:30 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.37.159])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6MD240snz5xT3;
	Wed, 20 Aug 2025 09:51:30 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.5])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id DA0719A32D8;
	Wed, 20 Aug 2025 09:51:27 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-109S0037d4b4793-596f-4841-9b6e-7b1e6637a567,
                    616188B862BD6F9D24C783D7A018D61FF224AB69) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet>
Date: Wed, 20 Aug 2025 11:51:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add hintable NOPs emulation
To: Borislav Petkov <bp@alien8.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
 David Kaplan <david.kaplan@amd.com>, Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Oleg Nesterov <oleg@redhat.com>,
 "Xin Li (Intel)" <xin@zytor.com>, Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <20250820013452.495481-1-marcos@orca.pet>
 <aKWR8e6VUEZEgbkw@lx-t490> <2cd7b099-095d-405c-a7d9-b0f1f72184c2@orca.pet>
 <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250820094347.GDaKWY02hR3AAoT7la@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11142468429620008628
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheektdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
 gvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=kWW/8Tg7JsOPvL+m44dmm8o+Dy4w5rB6iMVBwkz49hI=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755683492;
 v=1;
 b=alXELS6UOwOWE5fjiKxnlgM/oEPEv/2G69FUimvRpdC1GVrjXJxHCHduslikk4YboyKmet67
 sg+Feo0S6DkOjiNuxQxxY06/EG48rDR4vs0eNnx2ZC0h5xePLM3T6eAEWG43Vqx1c6bowWFBNrL
 UAWUREqGECjP4xmB4CKpOAViYavsqU0oenSShDvgP3OT4IHvcCKe0ctJ7fWKBNXYpmEFk7RpF0R
 nKqwzAwMC/oAVLsD1XSy3f4Olrqn0+GNmyXTxFYGb4VJ7fO0i4rPnwakGx3eXUgnj8rCktP6dsf
 7fay3ZlBUNnnTKin8fHbz36iW9ZK5jpPHZX6FhxXwqWUw==

El 20/08/2025 a las 11:43, Borislav Petkov escribió:
> On Wed, Aug 20, 2025 at 11:33:05AM +0200, Marcos Del Sol Vives wrote:
>> But I think the kernel should let the user know the binaries they're
>> running are having some performance penalty due to this emulation, in case
>> they want to recompile without the offending flags.
> 
> Sure, once perhaps.
> 
> Do you want to let the user know for each binary?
> 
> And how many users do you really think will look at dmesg and recompile their
> binaries?

I mean, they should know what they need to recompile if they want to, not
just that their machine is having a bug triggered by some binary.

A global flag would mean they'd need to reboot to see if there is any other
binary triggering it too.

Whether they look or not at the dmesg I cannot tell, but if IOPL emulation
does logging this way, I assumed this should too. Otherwise, would that
mean IOPL emulation logging is also too verbose?

