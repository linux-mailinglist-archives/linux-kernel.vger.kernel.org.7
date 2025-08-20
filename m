Return-Path: <linux-kernel+bounces-777477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2EBB2D9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2678617CF36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E902E041D;
	Wed, 20 Aug 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="GiwykPBy"
Received: from smtpout2.mo534.mail-out.ovh.net (smtpout2.mo534.mail-out.ovh.net [51.210.94.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065832D0C8A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.94.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685062; cv=none; b=hlhCOrLw6MXZ2Ds1sAB9vja1knSgvWkD/OZT0++y7QMGBLtFkZ2yX1ELAaL0Y7d+z9NRH0uHqS1dXnV2P5T1u/9MyVJ7FE6oF+MA4Jp/kF5eofq99l792+7aEVY3pWsFIy19h8UWguzAEvGd3oYmTsYWI/X4lmEvAm1SynDpPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685062; c=relaxed/simple;
	bh=wciRcggMJi5GG6dGYY5OwzT4DYT1ab+VyI2ZUzHlmuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VB1uLc9a+RrGsi+n/jlBV7cpJLyYnOEqG4yl4ZhT7BFlQsjb/VkrNGqp7VwQLUgj7ER43nWsgLI8184iUisopUiweJSlhpjOvIvUe4WKTm9ghTtcy3BV0RrBwHpnzjEPSNNU6edUYATL/JDp9fJto5j6QtvsHlyl4MzPQ8YoxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=GiwykPBy; arc=none smtp.client-ip=51.210.94.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c6MRf6CLSz6G6G;
	Wed, 20 Aug 2025 10:01:34 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Wed, 20 Aug 2025 10:01:34 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.54.141])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c6MRd55hhz1xsB;
	Wed, 20 Aug 2025 10:01:33 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.11])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id C8D619A32D3;
	Wed, 20 Aug 2025 10:01:30 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-111S005f0ff9220-28eb-43fd-b921-a03cb197dcb3,
                    616188B862BD6F9D24C783D7A018D61FF224AB69) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <3db7d599-c2a7-4bec-94b1-4872649dde8d@orca.pet>
Date: Wed, 20 Aug 2025 12:01:30 +0200
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
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250820095556.GEaKWbrMh24T7jTfBg@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11312197839614072500
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheektdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudekpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
 gvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhg
DKIM-Signature: a=rsa-sha256; bh=7ywoVmuDJMvVjQW9qj9BNxgunVZT9il645jXAJ7dNcE=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755684095;
 v=1;
 b=GiwykPBy1OzrZbKpCBLbIAsOnq0uww5YO/OnEXSrB5+UCxUUJdQHyg5K0yB5n5mBgsUhox2H
 k11zAb99+CqDD1SVkXC5fmAPi6DqdeuutWHEmMQ1A5m3Lsgdumwa8GU6sxXr8bk/3QZpIZAMjCy
 eNDpk8gF4O1cz+ZWGnRFaHY3khTjopT7utdC+FHEh9es4HSRuz9p9+CfpqweQtj2n57uHx8Z1f8
 TApUGLSb/EsOaQ250Lk9uBuFXBiiph3YFW1CTAxpHNm3nBiKF3E0HlgNMyCxq0uGm+peylHsbrO
 V0FYkV2gdUMZ78HUvCOPzFyiH3zBjXTPIhuNEa6RB+Z6A==

El 20/08/2025 a las 11:55, Borislav Petkov escribió:
> On Wed, Aug 20, 2025 at 11:51:27AM +0200, Marcos Del Sol Vives wrote:
>> I mean, they should know what they need to recompile if they want to, not
>> just that their machine is having a bug triggered by some binary.
> 
> And what's stopping you from writing a proper error message explaining that?
> 
> And issuing that error message *exactly once* instead of flooding dmesg for no
> good reason?

Please define "once". Once per what? Per boot? Per executable? Per process?

Once per boot would mean they'd need to reboot to see if any other executables
are affected. Per executable AFAIK there are no facilities to do that, and the
closest is per process which is what it's currently being done (again, like
IOPL emulation which was already deemed okay a couple years ago and merged
into the kernel)

