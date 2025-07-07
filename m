Return-Path: <linux-kernel+bounces-720072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1962AAFB6A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D031AA5B37
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364D11EB36;
	Mon,  7 Jul 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="VYDIQ8bI"
Received: from smtpout8.mo534.mail-out.ovh.net (smtpout8.mo534.mail-out.ovh.net [54.36.140.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443329AAF5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900397; cv=none; b=bwqiZ5l/Y3PvyxwSo9qTim9kEOu8jS26JVfrkkTxM0SANByjsaiZ4ChU1sV7ZMXQYbIVBQPwg2JBvirONs0UtKtYuYK2ZCWs2diV0vmOGkhHs1c1Jo1B8aC/ey6FUneEwU3JBq/TJtSbPA0rirHeHn2NzskkyUrDQja9yWIJXBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900397; c=relaxed/simple;
	bh=zdEdHDTjhZ5ckA/m4c31bIgqREMkIWk9k23WQNtiaEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPOEcfpEAl7QxJ5DB3jgV9hLR6Bk1GFteMveXDPqgJC4+FZ9Z8EPjnwCLOsEAsIeU1Yff9gFgUzssTbrGkXVf/Z3VuGCVUriC7cgr2jnGNxC6IQsZ7r6RdESO1al8O79HQOcLr2goLVnQd5r66bT3701APbg/7kW7ECUZ/uDugA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=VYDIQ8bI; arc=none smtp.client-ip=54.36.140.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4bbRwb4QCwz6Fg8;
	Mon,  7 Jul 2025 14:49:51 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Mon,  7 Jul 2025 14:49:51 +0000 (UTC)
Received: from mta7.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.231.53])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4bbRwb0w8Fz1y3l;
	Mon,  7 Jul 2025 14:49:51 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.6])
	by mta7.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 59EE7C3CDA;
	Mon,  7 Jul 2025 14:49:50 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G003226193a2-2a6d-4ede-9af5-e8ebec56eebd,
                    F886D19416C0B9BC8E07D11B456840F184BAC853) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.116.47.195
Message-ID: <3f80b31d-855c-4591-9237-272895165f13@orca.pet>
Date: Mon, 7 Jul 2025 16:49:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: vortex86: add new GPIO device driver
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-gpio@vger.kernel.org
References: <20250707132154.771758-1-marcos@orca.pet>
 <CAMRc=Me5dfNFLS1qF0AWgg8sb_vk9J=d-JV3-C5xWv7pZM+sFg@mail.gmail.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <CAMRc=Me5dfNFLS1qF0AWgg8sb_vk9J=d-JV3-C5xWv7pZM+sFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16037036800080565979
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepofgrrhgtohhsucffvghlucfuohhlucggihhvvghsuceomhgrrhgtohhssehorhgtrgdrphgvtheqnecuggftrfgrthhtvghrnheptdegudfgiedugfekudfhlefgjefguedvjeffieevgeetjedvvdeihfeiudejvdehnecukfhppeduvdejrddtrddtrddupdejledrudduiedrgeejrdduleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=OJu8pJoid5qMGA+qH1sillUwasBPAhGzZR0zvE2aRfI=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1751899791;
 v=1;
 b=VYDIQ8bIzbLQZfTrc9BetegfdOkRinM3Pn/VY8VcgnLmYh097v0eoWJrxIgcd8Tsvn2pSoU8
 hiTpGjJOjquzBvWQchMUzH3ZScKtNkYAtzSRkR4D+t41udrfq+kACDOF7JzugMNobx4ML4kipKV
 4bAmlfby201ZgrhmgtgkLvr6JTM/6PsT7kGt/dmzttDdk+rLDyWrf4YqcrC+Kte5WByyQHWb8Rd
 d8DfyR/uUV2x1LhKamyQZfjZShuqRCos1rK/OKDzcTjiEBPykoJ7t/PqMSppUp2Kw9FT23iBoSZ
 CkH/SszOpk99p6Dy8gGzjIodSnuN4KR+KvR4ZuU825vdA==

El 07/07/2025 a las 16:10, Bartosz Golaszewski escribió:
> Hi!
> 
> This patch immediately rings alarm bells in my head because the chip
> is not registered with the driver model. It's not 2005 anymore so I'd
> need some more explanation. IMO there's nothing that makes it
> impossible to implement this as a platform device. Could you elaborate
> more on why you chose to implement it this way?
> 
> Bart

Hi Bart!

This is my first time writing a driver in general, so the only reason is
that the drivers I used as a reference (gpio-it87 and gpio-winbond) look
more or less like this. I used those because they are fairly simple and
also use fixed x86 ports for control.

I see now on gpio-f7188x that it is possible to detect if the SoC matches
using platform_driver and platform_device. I guess that is what you were
referring to? Should I thus make a V2 patch using those facilities? 

Thanks,
Marcos

