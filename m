Return-Path: <linux-kernel+bounces-812218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE625B534A4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC6C3B3196
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CE754763;
	Thu, 11 Sep 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E8XgB5JL"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396532F75F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599031; cv=none; b=sTUarOD+HySVPAWXUJRHg+xcWvPXcn56Uxv9tZoDyY/lpGhDiLHQlkq2hvEapUAV5ID8fVvNGggbUvYDqZer6jrNpwiq5SxPiasJjD/oWA7jN79gmK+ymIuviiJYKF22pexgXo/hD2qCSSAH1n+jeWZQJfFLpIw6QwVJ0EnU25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599031; c=relaxed/simple;
	bh=oDf5VY2SMDhWKzWUCn3C1u6sbTRxHqiOGBPOElxerfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tIItsWVklViFhjZWAJIlK/M6T5q7qONnBHLvCF/AFVdBBoQXr/JKkPFATzjBt1m4/RoWWcZkd3y8ZmluRiFthOG0FPsimXaAiR8LQ0oShS+8Bjf0q9Q6pQBS+I2skjwH6k8YtvpzblmcVD94WfMIA18AbvxNs/9i6+IHWUKMMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E8XgB5JL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9C4DEC6B3BD;
	Thu, 11 Sep 2025 13:56:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 73D0160630;
	Thu, 11 Sep 2025 13:57:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A837E102F28F0;
	Thu, 11 Sep 2025 15:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757599026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+8MOtjR/SCOGwiIdk6r9cBes34StJlpvtG+zzPpGcNk=;
	b=E8XgB5JLS/mPkRP1zvTiKqUhwKzCA50gJAmpUmbn01XBtfVmKS4Mmx2LW+weWFYiXbLH8B
	7U+nZamCADWhQ7XINEFNoWGdB6kbpB2qEKCacWxQ2puVuYq/3970GdAsI/HvDBhLCYI8a6
	THjK6d4knuwr10/hrmHRGtt4684EiGcs9uAoFv8id8p42I1TgMzZQ+wTUsiwHWgitCRJV5
	A4gtTMa0gNDS1DmQ9wLQkI4ZVAVL9rdt227qpHd/5W4ml06QAyFjhTILEGmzZzoh/rLZAU
	TMgyahAWNFF02OROSkqTXN1H4J7HdvZERF+ls+yJlZ0wezFot/vxH8S4YrQJ1g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  tudor.ambarus@linaro.org,
  mmkurbanov@salutedevices.com,  Takahiro.Kuwano@infineon.com,
  pratyush@kernel.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  alvinzhou@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add
 enable-randomizer-otp property
In-Reply-To: <CAAyq3SZUToRjWVgAX_=We7cMFjVjuGLvFYBSpOG=M_e_MD6aeQ@mail.gmail.com>
	(Cheng Ming Lin's message of "Thu, 11 Sep 2025 16:30:11 +0800")
References: <20250910030301.1368372-1-linchengming884@gmail.com>
	<20250910030301.1368372-2-linchengming884@gmail.com>
	<87wm66d67k.fsf@bootlin.com>
	<CAAyq3SbXiPUjZE7OCAe1=uw4h82bFN7DSU4bLx1dhKe_XFtu=w@mail.gmail.com>
	<878qilbes9.fsf@bootlin.com>
	<CAAyq3SZUToRjWVgAX_=We7cMFjVjuGLvFYBSpOG=M_e_MD6aeQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 11 Sep 2025 15:56:42 +0200
Message-ID: <87wm659jol.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

>> >> This is a NAND wide feature, so we should probably add a prefix, such=
 as
>> >> "nand,".
>> >>
>> >> Now, what about this "otp" suffix? Many (if not all) chips have a
>> >> volatile setting for that. About the naming, "otp" often reflects to =
the
>> >> OTP area, which is not what you imply here, as you want to insist
>> >> (rightfully) on the fact that this feature cannot be disabled.
>> >
>> > Yes, my intention is that once the randomizer feature is enabled, it
>> > should not be disabled again.
>>
>> I believe the motivation behind this choice is incorrect and does not
>> fit such an OS as Linux. We want to give the system administrator the
>> choice to select and unselect features as it sees fit. So if there is a
>> volatile way to enable something, we should go for it and we will pay
>> the extra penalty of a set_feature() (or whatever) command after each
>> boot. Making this type of change permanent makes development and
>> debugging much more painful. There are plenty of configurations that we
>> refuse to apply with non volatile configurations. In general, stateful
>> modes are problematic if they are kept after a reboot and we try our
>> best to avoid them.
>>
>> Once this feature is enabled, for the lifetime of "a product", it does
>> not make sense to disable it indeed. And the DT must remain correct, if
>> it is changed in a non compatible way, that's the administrator
>> responsibility.
>>
>> So are there ways to enable this feature in a way that returns to the
>> default state after a reset?
>
> Thank you for the detailed feedback. I understand and agree with the
> principle of favoring volatile configurations to give administrators
> more control and simplify debugging.
>
> Yes, it is possible to enable this feature in a way that it returns
> to the default state after a reset.
>
> We can use the standard set_feature command to set the RANDEN bit to 1,
> which enables the randomizer. This configuration is volatile and will
> not persist through a power cycle. The feature will remain disabled by
> default on each boot unless it is explicitly enabled again.
>
> I will update the patch to implement this volatile approach.

I would be in favour of implementing this method. Hence, no more OTP
constraint to express in the binding either.

>> > You are correct that this bit does not
>> > belong to the OTP area, but rather to the v2 volatile register. The v2
>> > volatile register has a default value that can be changed through a
>> > special OTP configuration register program operation. Regarding the
>> > "otp" suffix, I will remove it to avoid misunderstanding.
>> >
>> >>
>> >> Also, this is a per-chip configuration, while I would have welcomed a
>> >> per-partition configuration. I can easily imagine two cases:
>> >>
>> >> - The boot ROM, for longevity purposes, expects the first blocks
>> >>   containing the bootloader to be scrambled. However the rest of the
>> >>   system does not really care and disables randomization.
>> >>
>> >> - The boot ROM is not capable of de-scrambling, however the rest of t=
he
>> >>   system relies on the (probably) more robust scrambling feature.
>> >>
>> >> In both cases a chip wide variable is not relevant.
>> >
>> > The scrambling and descrambling are handled by the NAND flash hardware
>> > itself. Therefore, the boot ROM does not need to support a descrambling
>> > feature.
>> >
>> > In the case of Macronix parts, the randomizer is controlled through a
>> > configuration register, and once it is enabled it covers the entire ch=
ip
>> > (main and/or spare depending on the randopt bit). There is no hardware
>> > mechanism to enable it only on certain ranges.
>>
>> After thinking once again, I am no longer aligned with myself from the
>> past. This is perhaps too Macronix specific in the end and if it is a
>> fully transparent feature, then why not.
>>
>> Are there any ways we can read the raw data (unscrambled) once
>> scrambling has been enabled? (I mean, without changing the user default
>> OTP state). Maybe one big difference with the raw NAND world that needs
>> to be taken into account is that the chip itself always return
>> unscrambled data, hence we probably do not care much, from a Linux
>> perspective.
>
> Unfortunately, there is no way to do this. If a user decides to use the
> randomizer feature, they must enable it before programming the user OTP
> area. If the randomizer is not enabled before the user OTP is programmed,
> any subsequent reads will result in corrupted data.
>
> Marconix raw NAND chip itself does not always return unscrambled data.
>
> The ability to read unscrambled data is dependent on whether the
> randomizer feature was enabled and configured correctly. When the
> randomizer is turned on, the chip's internal hardware automatically
> handles the unscrambling process. If the feature is not enabled, the
> data read from the memory will be the raw, scrambled information, which
> is unusable without the correct key and algorithm. In other words, the
> chip only returns unscrambled data if randomizer feature is enabled.

That is interesting and might be useful. In Linux we will enable the
scrambler if the data property is enabled before we get to play with the
OTP anyway, so hopefully people will get it right.

Regarding the property name, it is going to be a per SPI NAND chip
property. I am still not sure whether we should make this prop generic
or not. Perhaps the safest approach is to keep it vendor specific, but
the concept of scrambling internal data for longevity purposes is common
enough to deserve a nand- prefix. Although it's gonna be like ECC
engines, we'll need to decide which part of the system handles the
scrambling (software, hardware on host or chip itself) and whether it is
enabled per-chip or per-partition when that's possible.

I am open to suggestions.

Thanks,
Miqu=C3=A8l

