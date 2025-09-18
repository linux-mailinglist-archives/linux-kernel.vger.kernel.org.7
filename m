Return-Path: <linux-kernel+bounces-781737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E73B31612
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C7C7AFECF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49AB2EA473;
	Fri, 22 Aug 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="S0vKdSSv"
Received: from smtpout7.mo534.mail-out.ovh.net (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31132E92C6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755860683; cv=none; b=GTK/u4962UlQ/UbQTbBeYaBJAMSi7AnBrfgwmRMaj5uhaqigfR9QSgkhef/X9VoeNjYkEYQBYGElePC7AZOkMeek/v5J+qlNVLtlMGugd+0O9nCqcsLwFTTOIUbhhISpEP6FwO1VvuWZG3iAadQau7QMyZOGYsw3M+vJzCTyWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755860683; c=relaxed/simple;
	bh=4POstXQug6/tm324a/uxWTpYPZm2WzR82ZBrp7W+wwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6yxFPbGwclR6lbc0WK3ANCfQILZTNyfz9gGYpCS41+qu9WF/PLsvm+VMZ+Fy0rVdAmwtVj9KosniDRURGTi4oyS5lV3HLb5pN/ZSotelg7u6OpVv+4r3OE1cIqo2U7kX73S+3xM3QcNjkgAZsFEpyJ4yT7MSAtDCALY4LNcwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=S0vKdSSv; arc=none smtp.client-ip=54.36.140.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c7clP0r5yz6FhZ;
	Fri, 22 Aug 2025 11:04:33 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Fri, 22 Aug 2025 11:04:32 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.128])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c7clN5r1Vz1xpF;
	Fri, 22 Aug 2025 11:04:32 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.10])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 954BB9432CD;
	Fri, 22 Aug 2025 11:04:31 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-114S0082ef14080-d45a-44d5-83ba-a09211dd5816,
                    ADC0680FE15BB91110492B9A34CE42AA242C155A) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <9ee82305-6f46-461b-ad0d-441425727be3@orca.pet>
Date: Fri, 22 Aug 2025 13:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some
 behaviour
To: Michael Walle <mwalle@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250821101902.626329-1-marcos@orca.pet>
 <20250821101902.626329-2-marcos@orca.pet>
 <CACRpkdb7PZTx8WPQP8Jrj_sR8X2ejK3OgA+9v2PUaOcTM4NnrQ@mail.gmail.com>
 <DC8RMCPRX0UZ.3RP6IGY2KJ96@kernel.org>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <DC8RMCPRX0UZ.3RP6IGY2KJ96@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5674535533833246310
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
 hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=cwbNrb23A+8SUEIo2+pV65nYKzVzqJSprND2O24vDUY=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755860673;
 v=1;
 b=S0vKdSSvQfX3N/6oFSTGs2J5T6GgUc0m5ftAJnnkxcEwDKt9pPkI4m3pYDYeN2YaI3t4McKj
 zzvh2hP8yfNAvUyDorSzy9p5VTdNi87VJp0wYLROn8ZS7+CZEGv6K8oiVHJeQvUu0hbgw1bYA59
 AZho88FKBRbNQK9KM39/4XE5TlTlfECHJhvmyvFAmuNurQSqlWL3LJ3th+5VUNYR6xb7ZNdMZQF
 BRgdyDLAtlxr5TsHFb8FYsGP2YnSQRsgo4+OzX+6R6Agqe0f8RgOcZPRUBb+xcmSdQYDO+kgwUY
 F5hK6etT7RUbOV7s65bcFDqtfqfJOABQJQMnJa1BQxtIw==

El 22/08/2025 a las 9:07, Michael Walle escribió:
>>> +       ret = gpio_regmap_set(chip, offset, value);
>>> +       if (ret)
>>> +               return ret;
> 
> Could you add a short paragraph to the commit message that you've
> added error checking? Something like:
> 
>   While at it, add the missing error check in
>   gpio_regmap_direction_output().
> 

Added! Thanks for the feedback!

