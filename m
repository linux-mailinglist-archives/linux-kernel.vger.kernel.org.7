Return-Path: <linux-kernel+bounces-777490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1337FB2DA13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A60267AF1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D882E2DF5;
	Wed, 20 Aug 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="B2jm7XyD"
Received: from smtpout1.mo533.mail-out.ovh.net (smtpout1.mo533.mail-out.ovh.net [51.210.94.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D12E2847
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.94.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685897; cv=none; b=upb5bxfOEMbpi3ma2GDVeZmd6b6TLLJaHl4Q/jQWNbVBjGbsUmSUt7lvSSIJYkPv7cAQD4XTD539d0CH+snwal/8wthJB8uj9/dyifGB+R5Pa5ZS6OPCyNr9eXt6hx7T85riOyBwQJCwAKiBcUACzUXG5+VCGa5OflhUcOSJxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685897; c=relaxed/simple;
	bh=50P6jdL1wSOI6cAFuJxQzSrStkwb6vHkDTkewBe9OxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYeZmylSVCoKVtyLTsXRCIFpBDvtzDJBXY9Xm408M4N1+0EU5NYccRk6/6cb9NxeiT6KYGpgb+klDS+I7UdkX3waaian5K9mIwyh/nUSszWHpjchx4hcYUUmJJEQQkI3WGthkG7eebL4OwaUOzob+cSLY5ikVxWe3qtLtvItXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=B2jm7XyD; arc=none smtp.client-ip=51.210.94.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4c6Mtv1XlRz5y6j;
	Wed, 20 Aug 2025 10:21:43 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Wed, 20 Aug 2025 10:21:43 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.37.181])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6Mtt72Wvz1xpf;
	Wed, 20 Aug 2025 10:21:42 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.10])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 945D494329C;
	Wed, 20 Aug 2025 10:21:40 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-106R006643a39dd-4f29-4819-869f-07233b346813,
                    616188B862BD6F9D24C783D7A018D61FF224AB69) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <ddfe73ac-177a-431f-8e6e-807ff0746213@orca.pet>
Date: Wed, 20 Aug 2025 12:21:40 +0200
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
 <be242e65-b056-4e12-93e7-9a297aaf231a@orca.pet>
 <20250820095556.GEaKWbrMh24T7jTfBg@fat_crate.local>
 <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>
 <20250820100812.GFaKWejCFMSAS6QIfS@fat_crate.local>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250820100812.GFaKWejCFMSAS6QIfS@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11652782562187433652
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
 gvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=0WgxTiwE9lCVl6akB+HLPooec9IpmzRQo97+ST4njzk=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755685303;
 v=1;
 b=B2jm7XyDbBMZ7gAWvtUyhkh4VmzcW4JnDhumIuKsvqplgZsXNNBJzKafdkPcETBuCALLR6AW
 Q1xDWRm5aYugFC1Hk/FQZJppc/WUQD1EoheJ/awJfWhJ/yuBbE/qncAnzkLIi6ML/15Ma7wKcKZ
 CavsBop0PAsN+HYxrMzFKqcalNoYAOKWgOMUUFHaL0yGrrNno9WctFErNAz4+g8uWXy4GSNMB1Y
 kMy4OfonruQo3fDzBRoUJ/OgbJn8kJ3Um6T+mFCgceEVRB/pvN8y9Mah8Cuu5D4ML0UV8kDLqYT
 wk5x/J9pK1ctJiy3/0CWce/abw/o/ESXxLqXc59oZ51ZA==

El 20/08/2025 a las 12:08, Borislav Petkov escribió:
> On Wed, Aug 20, 2025 at 12:01:30PM +0200, Marcos Del Sol Vives wrote:
>> Please define "once". Once per what? Per boot? Per executable? Per process?
> 
> pr_err_once(). Per boot.

Would a simple:

> pr_warn_once("Your processor does not correctly handle hintable NOPs.\n");
> pr_warn_once("The kernel will emulate them, but the performance will be impacted!\n");

work for you, then? With no thread information, as that might make the user
think there is only once binary impacted.

