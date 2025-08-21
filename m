Return-Path: <linux-kernel+bounces-780353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4C8B300C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE9A3A8F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B25A2FB631;
	Thu, 21 Aug 2025 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="cIX1aJ8R"
Received: from smtpout8.mo534.mail-out.ovh.net (smtpout8.mo534.mail-out.ovh.net [54.36.140.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752F261B91
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796466; cv=none; b=bd6+F/q8qnzhL7ZxMBrFWdiJxoqcau8d3xhkBXccIKoLWkhGEG0qdfmGWxiSMIALzscx6iB50KTwiX/Tny8aAWybwJAYam8tXB8/DIhQVHwWYSKyZ3PxsG9WmDjG6zxOaRsB+EeB4lo93XVUcs4gNALj4S4H57yzptd45CwSkzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796466; c=relaxed/simple;
	bh=4s2SgBDIfhuiX/36eQkP9IdC8nSh5GIVHNKeKDZPuTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBp2Jc7/iMdxY+ya9biZBdSXCPOInRY1m6kwWyfQ3eni8ujdIBLfSycYfo5GhikFZJ9CWNYa/8utOEtLWhXogUz7M8lsuSlp+5dHwt2Ntn79ThPOFkIWL0lFn+zlj4ZO6T8F7yP7QxLG9JAs0q/uaR9GSwV3Qq6akIZ43VtB7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=cIX1aJ8R; arc=none smtp.client-ip=54.36.140.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c790Z2Sy3z6GJ0;
	Thu, 21 Aug 2025 17:14:22 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu, 21 Aug 2025 17:14:22 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.54.94])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c790Z0rWTz5wDd;
	Thu, 21 Aug 2025 17:14:22 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.4])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 99F9C9A32E2;
	Thu, 21 Aug 2025 17:14:20 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-105G00640d7eefc-a407-4406-bc8f-45b6a2a3f3a6,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <b11fe036-ff94-4226-a5c7-067a195196aa@orca.pet>
Date: Thu, 21 Aug 2025 19:14:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] gpio: gpio-regmap: add flags to control some
 behaviour
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>,
 Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250821143220.GA672670@bhelgaas>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250821143220.GA672670@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6047771352983492198
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedukeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrh
 hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=BBIMNKbgu0l71xtJeZDmDYq3dcY9gm17qcm0ICLyhI0=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755796462;
 v=1;
 b=cIX1aJ8RDgxXLQp6xwSGz6JSEQdBXA/ZjesSGA1AbTHwJIdSXQd4yvvb8/vBfVQM0UkcvepE
 Wg26iAD3aMQEzQhEyFg9AIg/kvdSHpr7/ew9SXDthdRLguvkZTnQ5jiWPPzuutCJq7JryCJq0pC
 l9BMaP3oc7w3DXSYPgz6rEEIcWmIUiKKqIkmtNUqz8CiHt3JMs09WBNhHlQl+QPEKNfgzhAvNK4
 Q5t9x/01kAD0VSnwFdjz4Ve+46XvF8mC58vm614e9Uz+gm3bKIuOqa9ROW+g+t9+puBJUyELGGX
 zfiBNtEWLQqQmhwkOVdHGPvN4qoHRtGW1GFY27E8IevlA==

El 21/08/2025 a las 16:32, Bjorn Helgaas escribió:
> Not my area, but consider making the subject more specific, e.g.,
> "add flag to set direction before value"
> 
> On Thu, Aug 21, 2025 at 12:18:57PM +0200, Marcos Del Sol Vives wrote:
>> The Vortex86 family of SoCs need the direction set before the value, else
>> writes to the DATA ports are ignored.
>>
>> This commit adds a new "flags" field plus a flag to change the default
>> behaviour, which is to set first the direction and then the value.
> 
> This sounds like the default behavior is to set direction, then value.
> But from the patch, it looks like:
> 
>   - default: set value, then direction
> 
>   - with GPIO_REGMAP_DIR_BEFORE_SET: set direction, then value
> 

Noted, thanks for the feedback! I've amended the commit and now it reads:

> gpio: gpio-regmap: add flag to set direction before value
>
> When configuring a pin as an output, the gpio-regmap driver by default
> writes first to the the value register, and then configures the direction.
>
> The Vortex86 family of SoCs, however, need the direction set before the
> value, else writes to the data ports are ignored.
>
> This commit adds a new "flags" field plus a flag to reverse that order,
> allowing the direction to be set before the value.

Hope that looks more clear!

Thanks,
Marcos


