Return-Path: <linux-kernel+bounces-780536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36790B30329
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42E6AC6F80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E4214807;
	Thu, 21 Aug 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="Ciza71u1"
Received: from smtpout6.mo534.mail-out.ovh.net (smtpout6.mo534.mail-out.ovh.net [54.36.140.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268051A3167
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805610; cv=none; b=tpoUwlkK24udN0cYP8d+r56CI27PQ2oXeXl5z9H+wcUMekGU2lTd6eFsphHtolQQnCqh26RA8jurjUzslQ85Dr0HzdvTAr0KY1pF3lvp8B6g4LG9MWv+quNGRjIMsPO5Ad2vFRak8IRrUOkgUxNVW/2KjiOb9vb6I08bjVPX0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805610; c=relaxed/simple;
	bh=OzGAfxA6UkQxbuitNPlFZ8VRxKfQRQr7JTAuk3NSnbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcmooxYOMpMsXISeQ2xZ9NbpJkArU90zwgwM+IY4U2eK9fzO/O2Qoh1YCS/AOm2qMqvX54yEp9WFnTM6anNS59qG3kaZWLAma8ZzpzHfryiJmLUtipwurxQqkRSqmgsHpTgXI9d5kUpr3ZYgAKyn3doQuGHoW9t7dQhb3iOMwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=Ciza71u1; arc=none smtp.client-ip=54.36.140.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c7DNN5CH5z6F0M;
	Thu, 21 Aug 2025 19:46:44 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Thu, 21 Aug 2025 19:46:44 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.125])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c7DNN2gFlz1xnW;
	Thu, 21 Aug 2025 19:46:44 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.4])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id F0F1D8E32DF;
	Thu, 21 Aug 2025 19:46:41 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G00328b90658-b4be-4e7f-b429-215665bc2a60,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <75439282-9895-4b17-b6fd-3f0222fa2f03@orca.pet>
Date: Thu, 21 Aug 2025 21:46:42 +0200
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
 <20250821124659.GO3289052@noisy.programming.kicks-ass.net>
 <20250821194015.3c56964c@pumpkin>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250821194015.3c56964c@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8621015588640413364
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhhiugdrkhgrphhlrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtghomhdprhgtphhtthhopegsrhhgvghrshhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhnohhvihhtohhllhesghhmrghilhdrtghomhdprhgtphhtthhopehusg
 hiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=xl78LofKt0+INFktuzE+1A+t0PfnviezFsD07X9TVMw=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755805605;
 v=1;
 b=Ciza71u16On15W0ZkdzjlaO8xU2/qt0w/JFGywZLHti/juG2A/oVJU02g31iELGzJpL07weq
 lc3czEHtCeRhjB7nVI0tr+t3dzdEm7aVwHUGjaYSnZnf/DdPsijPwtBIDFvVrMfyO/qSCdDxgLG
 Ya/BPtb7IjrMN2Awh+uhTyG031rueJYlqo+vDKrIWxZ+YBXb29K2PStNT4FAw2BnltANBU7OxOH
 CiDhpcHMClCpPXSyQyK0aByDsu7yky7MXXZiXO8tM+8YKpz0ISNOleFMybQL12tfYLYK5qYfalO
 dIUR0uT8UYVKiDtYhg5mv7KYyhe/IeDLYbGYXItSCu0MA==

El 21/08/2025 a las 20:40, David Laight escribió:
> On Thu, 21 Aug 2025 14:46:59 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>> It would mean cloning the page as private. Yes you can do it, uprobes
>> has all the code for this. But it has non-trivial memory overhead.
> 
> I was thinking it would be safe to do this change without cloning the page.
> After all the change is needed for all processes executing the code.
> That might only be easy on UP systems - but I doubt the affected CPU are SMP.
> 
> 	David
> 

Actually...

marcos@vdx3:~$ nproc
2
marcos@vdx3:~$ cat /proc/cpuinfo
processor       : 0
vendor_id       : Vortex86 SoC
cpu family      : 6
model           : 1
model name      : Vortex86DX3
stepping        : 1
cpu MHz         : 1000.017
physical id     : 0
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 0
initial apicid  : 0
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu pse tsc msr cx8 apic sep pge cmov mmx fxsr sse cpuid
bugs            : itlb_multihit
bogomips        : 2000.03
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 32 bits virtual
power management:

processor       : 1
vendor_id       : Vortex86 SoC
cpu family      : 6
model           : 1
model name      : Vortex86DX3
stepping        : 1
cpu MHz         : 1000.017
physical id     : 1
siblings        : 1
core id         : 0
cpu cores       : 1
apicid          : 1
initial apicid  : 1
fdiv_bug        : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu pse tsc msr cx8 apic sep pge cmov mmx fxsr sse cpuid
bugs            : itlb_multihit
bogomips        : 2000.03
clflush size    : 32
cache_alignment : 32
address sizes   : 32 bits physical, 32 bits virtual
power management:

Vortex SoCs are true oddballs, aren't they?

