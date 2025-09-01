Return-Path: <linux-kernel+bounces-794748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2ABB3E6C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619441A815E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B83376AD;
	Mon,  1 Sep 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="TF+LZZ77"
Received: from 10.mo533.mail-out.ovh.net (10.mo533.mail-out.ovh.net [46.105.72.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE69223316
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.72.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735922; cv=none; b=ENdtwM09cjCoK16MBRIUzF5PagdUJKNYRY9rfm7qFo/wH7AGeuOiskIOcXmROuPI5GRowkLO1UDROMotELLkOgZommNSteOQAvWx9eKpx493uqwUntrLnrWAQ4+gnYeFxrQHzFpuBcTP4kIz/RIp4Y7FVIXq6yz/xc6y4FKM+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735922; c=relaxed/simple;
	bh=YNbKLVu710ZnrzYTvo4wSx4W8tYlyAAH4cE7VoeWUH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBjCVzsZ/i5Z2aMBswh0SgEMt/T7rdqUPWKY7Uc8pjySMvOO+lZPiZWAHrh9hE/cfqYDw4ALnKj6zuidzpVh1f1SMmqLPaPdWVFl/RUxeAMJldv/ojjtmJLvg6Nk7Wpii8i2qbxCdz8pzL6MPjFJ4PjjMyvtXQcWNY4YkoHIx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=TF+LZZ77; arc=none smtp.client-ip=46.105.72.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net [79.137.60.36])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4cFn7W2xVvz5yYR;
	Mon,  1 Sep 2025 11:43:19 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net (director2.derp.mail-out.ovh.net. [127.0.0.1])
        by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bp@alien8.de>; Mon,  1 Sep 2025 11:43:19 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.168.17])
	by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cFn7W14cnz1xnc;
	Mon,  1 Sep 2025 11:43:19 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id A30C88E335A;
	Mon,  1 Sep 2025 11:43:16 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-114S008a30e7f4f-665c-4b54-a687-c73cdc2d892e,
                    1138E50E5E9D1B19ED739114350B0823FA36FB47) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.112.4.128
Message-ID: <51c25fb7-46be-4364-9371-6a7cb6b07625@orca.pet>
Date: Mon, 1 Sep 2025 13:43:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86: add hintable NOPs emulation
To: "H. Peter Anvin" <hpa@zytor.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>,
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>
References: <202508291620.bcfb3924-lkp@intel.com>
 <0ffa7c6e-f32f-4966-85df-3ee5f2426e9e@orca.pet>
 <33A549B7-B442-402C-A82C-862C0F509274@zytor.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <33A549B7-B442-402C-A82C-862C0F509274@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9716234722312804020
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduuddvrdegrdduvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehsnhhovhhithholhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthhopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtgh
 hlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhm
DKIM-Signature: a=rsa-sha256; bh=S1+H7EVrDkz/KATiOPFwcYH4HLJvAW2YigB5VQKrlN8=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756726999;
 v=1;
 b=TF+LZZ77LidHIr033lJRuTidzY3G8KWg+r+7m3NbzTA0/REIRNTe7hvApI+Ii06iwae3svkw
 nMAuH7TEQVlvHTdUvUGiP8wrvy5o7CRLy3SJOVWOScAEz8I/yan+z8RWgPELsQ+Zle+iS3SFkzi
 vM5bQKpdyGZmSdL6n4bF52KK73QLXCDCrbKX0Jo1SPZzP1gTLs7yDSYXpfnOmxqhPKOHUwGex0G
 hg4aT4fWvXJESAKfvUUUQZu7c0gRCvnWWRkvxBXh1Ixnc4koDwyn+B7+mhrf8VZul0rVM2Sm9Q6
 qfRND1N4SWD8vEH+BRDV7dl56hJCdkm/lEb4mxOX4drbQ==

El 31/08/2025 a las 21:32, H. Peter Anvin escribió:
> I'm really, *really* starting to question this approach. 
> 
> The right thing would be to not compile in endbr instructions on 32 bits,
> since they aren't supported by the kernel (if you try to enable CET/IBT
> you will crash instantly, because there is no endbr32 at the vdso system
> can entry point right now.)
> 
> We are talking about a very small number of CPUs stuck between generation
> 5 and generation 6. Most likely we are talking about a much smaller number
> than the i486 support we have been debating lately...

I assume the kernel is currently simply ignoring the CET flag on ELF for
all 32-bit x86 binaries and libraries?

Anyhow, seeing this is indeed becoming more tricky and error-prone, I'm
contating the sudo developer which is, so far, the only software that
has this issue.

