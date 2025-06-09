Return-Path: <linux-kernel+bounces-677462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDF7AD1ADD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 11:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E40A67A23C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C902512DD;
	Mon,  9 Jun 2025 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F2FIVahq"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6531E5205
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749462212; cv=none; b=EuN3sNdE7UmbSdsCyCzo6ckC5d4z1VzK6L2m0LkSz6PbRDBVNXJkdmajiKsuWf2wWYAq9wPennthiN53TV7MF7+dre44RFF+qM7ANb4BnShu6U+D25IQFi6xxFlWtuLaNloBKzd6wO/SrnYQ83I9mEHPg84wDIG7GxkXEmC9XJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749462212; c=relaxed/simple;
	bh=bQfF1mBZ2+ERL45NhLHX8Rrl4fm5xLxNZPJwGmKpTdE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TecHFDzDGkmtT13j+ns+Z4+hJfdohJEnXAZc7wxDWc3iGqpAOPG8e1tsKOn/bqtXFT0lvrpjROdFntiwYrwq1udAcgea+a37sbnHJ5XoOzM4ztHWsNrWgQHapX4T78Dw/yrSvswW3m/Z23wLS1Zhr03A0ehJ9ydXtPWsVchKO7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F2FIVahq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 840E743122;
	Mon,  9 Jun 2025 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749462202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4UgXCTTbnvHTrs3VX9TJ5+oerjkN8m/Ze1sEVtj3/o=;
	b=F2FIVahqxhWL8ygtZGnIRv3UVAlCxUn+9Pw6GtMfhalXGsZlVkZ2Rm77s3BY2zuRdb78lr
	jBXlvV57Sbhiflz9/0iFKSwL7sL+8yDcQY0TvU7Hp6tULiFFlnkE7r4VF41OmUr7q3rtVB
	L1TzWHN6FWANQcJ0muLsWtNyf8t5YA69TKnHn+K4yvWTbZJre6jUooiF4PkTlUri1jKsWt
	Q+HlcSNyYvCrQQutvNPU8/0bEfydjmOTvGZ/eiwd8j9w/wYeIPU5kaU7lmfkicjuzgcOhN
	6bS1QVLEEvUNVmeQ4s/HH1ZEOH93UvyG7zhSp3QvAg7M+uVMBhcP4sH1hVLQew==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  "De Marchi,
 Lucas" <lucas.demarchi@intel.com>,  Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>,  "Vivi, Rodrigo"
 <rodrigo.vivi@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,  Jani Nikula
 <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>,  Tvrtko Ursulin <tursulin@ursulin.net>,
  "Poosa, Karthik" <karthik.poosa@intel.com>,  "Abliyev, Reuven"
 <reuven.abliyev@intel.com>,  "Weil, Oren jer" <oren.jer.weil@intel.com>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
  "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/11] mtd: core: always create master device
In-Reply-To: <2f3d3ff9-e483-42cc-aaed-f376d46a6701@roeck-us.net> (Guenter
	Roeck's message of "Sun, 8 Jun 2025 17:59:37 -0700")
References: <20250302140921.504304-1-alexander.usyskin@intel.com>
	<20250302140921.504304-2-alexander.usyskin@intel.com>
	<9dfb2954-fc3e-464c-a4fd-8c1a4dffa327@roeck-us.net>
	<CY5PR11MB63666AE267B9F1609213D93CED68A@CY5PR11MB6366.namprd11.prod.outlook.com>
	<87bjqyja7o.fsf@bootlin.com>
	<2f3d3ff9-e483-42cc-aaed-f376d46a6701@roeck-us.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 09 Jun 2025 11:43:19 +0200
Message-ID: <87ikl5xnbc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeludefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedutedtfeelvefgjeevuedukefhtefgiefftdekffffteduheduheelgedutdetueenucffohhmrghinhepughtshhirdhishenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopegrlhgvgigrnhguvghrrdhushihshhkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehluhgtrghsrdguvghmrghrtghhihesihhnthgvlhdrt
 ghomhdprhgtphhtthhopehthhhomhgrshdrhhgvlhhlshhtrhhomheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrohgurhhighhordhvihhvihesihhnthgvlhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com


>>>> Several of my qemu boot tests fail to boot from mtd devices with this =
patch
>>>> in the mainline kernel. Reverting it fixes the problem. As far as I can
>>>> see this affects configurations with CONFIG_MTD_PARTITIONED_MASTER=3Dy
>>>> when
>>>> trying to boot from an mtd partition other than mtdblock0, with the
>>>> mtd partition data in devicetree (.../aspeed/openbmc-flash-layout.dtsi=
).
>>>> Is there a guidance describing the changed behavior, by any chance,
>>>> and how the boot command line now needs to look like when using one of
>>>> the flash partitions as root file system ?
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> I've tried to make is as transparent as possible for the existing users.
>>> Only change is that now every partition has master that is not partitio=
ned.
>>> Is the CONFIG_MTD_PARTITIONED_MASTER=3Dn fixed the problem for you?
>> No change is expected, can you please describe the devices that you
>> observe with and without the patch? Maybe there is something wrong in
>> the core logic.
>>=20
>
> I am trying to boot supermicro-x11spi-bmc in qemu from flash partition 6.
> The qemu command line is something like
>
>     qemu-system-arm -M supermicro-x11spi-bmc,fmc-model=3Dn25q256a13,spi-m=
odel=3Dn25q256a13 \
> 	-kernel arch/arm/boot/zImage -no-reboot -snapshot \
> 	-audio none \
> 	-drive file=3D/tmp/flash,format=3Draw,if=3Dmtd,index=3D1 \
> 	-nic user \
> 	--append "root=3D/dev/mtdblock6 rootwait console=3DttyS4,115200 earlycon=
=3Duart8250,mmio32,0x1e784000,115200n8" \
> 	-dtb arch/arm/boot/dts/aspeed/aspeed-bmc-supermicro-x11spi.dtb \
> 	-nographic -monitor null -serial stdio
>
> This is with aspeed_g5_defconfig. Note that the flash models need to be s=
pecified.
> The default flashes are no longer recognized when booting from qemu since=
 commit
> 947c86e481a0 ("mtd: spi-nor: macronix: Drop the redundant flash info fiel=
ds").
>
> The above only works with this patch reverted (or with v6.15 and older, o=
f course).
>
> Guenter

Alexander, can you please investigate? We need a fix because Guenter
might not be the only affecter user. Otherwise this patch can't stand,
unfortunately.

Thanks,
Miqu=C3=A8l

