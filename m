Return-Path: <linux-kernel+bounces-747818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7ADB138C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0B83A8E43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCD125C70C;
	Mon, 28 Jul 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MmPNSoMy"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4D12561A2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697835; cv=none; b=pZr8RKz1kEhAO3k67vb/dzyYDRoum8qvMayqS2g7XqcDeWa3LrWR/NtUZ7dq26zAgfnsTiocY73QAdFDwJ/yJE8d4f7vmo97rz/4330UrbC1ROKgxOVCHrNwYxPHHth6XYhQyppMYEeYKL+IWZwhzdr4r0W+5ew4y2X0xZufsIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697835; c=relaxed/simple;
	bh=c1RN+g2nu0vBJY1sBA694gPA4b5sCMgfkOXEiVtSlAA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fomiKApCvYB3PU4Fl8Nr58qHP4p3C0TdloC4sj//EeiEP2nAqzBtqG/xgjMn1Ch4L9Br3iPXZZ8LB1NVkLzQRujFU4LOdc6Eht3VtmyLcX4FzH0+buzc4wk1OUJkArgPj3q8NQYyDY1stnbq4EnQFq544537YiF3qFeTeq86MAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MmPNSoMy; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60BF843216;
	Mon, 28 Jul 2025 10:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753697825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1rfcU6bVAroB+JlXo4xz195PlOMcJxuJT/+Bzp7VP0=;
	b=MmPNSoMyWtFWYBokuTGwidoP3LyRH6iia+669R49ySQ4QmUwJlKh059AT7CpYf0GfjYqpF
	3+KpnHOTtSCtL07PcpHsi+yjFPIX5AOdIJF+zffnTUJ8fJM8OzrOwzqs6qOFG6j0d4jLGi
	/vXinb5e45jkQ/03yNXwhRtpYRItTY6e3AdWxys7TIHZk0yKrKo7ukXdN9M8+R9X8xCvFC
	zy0bHEH3mb6Y05rQEL8fgoJAXLkaPNd+YY5mBYH9svZIG5KulZu4Xk3vYuR+40T5tytpib
	tIFvNYPgQTRUZqqnF0Tpa/iMZ+3zv5zIV07ERFOSUq2dBRDtV8aro7KO+WU11Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 bcm-kernel-feedback-list@broadcom.com, william.zhang@broadcom.com, 
 anand.gore@broadcom.com, florian.fainelli@broadcom.com, 
 kamal.dasu@broadcom.com, dan.beygelman@broadcom.com, 
 =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>, 
 rafal@milecki.pl, computersforpeace@gmail.com, frieder.schrempf@kontron.de, 
 vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org, 
 kdasu.kdev@gmail.com, jaimeliao.tw@gmail.com, kilobyte@angband.pl, 
 jonas.gorski@gmail.com, dgcbueu@gmail.com, dregan@mail.com, 
 david regan <dregan@broadcom.com>
In-Reply-To: <20250703024719.2256470-1-dregan@broadcom.com>
References: <20250703024719.2256470-1-dregan@broadcom.com>
Subject: Re: [PATCH v3] mtd: nand: brcmnand: fix mtd corrected bits stat
Message-Id: <175369782433.102528.8293919155705720078.b4-ty@bootlin.com>
Date: Mon, 28 Jul 2025 12:17:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvjghfuffkffggtgfgofesthekredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffhfdufefgueeuheeuveduieeijefhjeduveduveeitedvteeftdffhfejieelfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegurhgvghgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegughgtsghuvghusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehvihhgnhgvshhhrhesthhir
 dgtohhmpdhrtghpthhtohepsggtmhdqkhgvrhhnvghlqdhfvggvuggsrggtkhdqlhhishhtsegsrhhorggutghomhdrtghomhdprhgtphhtthhopehjrghimhgvlhhirghordhtfiesghhmrghilhdrtghomhdprhgtphhtthhopegtohhmphhuthgvrhhsfhhorhhpvggrtggvsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 02 Jul 2025 19:47:05 -0700, david regan wrote:
> Currently we attempt to get the amount of flipped bits from a hardware
> location which is reset on every subpage. Instead obtain total flipped
> bits stat from hardware accumulator. In addition identify the correct
> maximum subpage corrected bits.
> 
> 

Applied to nand/next, thanks!

[1/1] mtd: nand: brcmnand: fix mtd corrected bits stat
      commit: a0276550dd4474a3767b435db1b41c37ea5dd718

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


