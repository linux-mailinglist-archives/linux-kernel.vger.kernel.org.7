Return-Path: <linux-kernel+bounces-760095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37213B1E663
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC4916C24B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689532737E4;
	Fri,  8 Aug 2025 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="de0HcDcg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA0320E6F3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754648371; cv=none; b=XzqCJr4hXAumc7HpGWj4YIX/qwMexYdnzJ6QkVsZC+Jga1FbtprgkEmVNVH08lVMi+1DoAlBaCh03FaHxqFlcaumCUge7fSWLORkiUnUb1ZPmAQ/IdjkqBIajlreJLNqH9Ll/Yk5vwE3bN+f2lyGERVx2rOS+lg7aUDxNxV6haM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754648371; c=relaxed/simple;
	bh=ASv3hStQq7O6sTyM/Di8lawrZZXPfUnBQcVoF3yT3fU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/nHFSpxSfX19i2TLj9LaYC895njJ2KU2i3pGRRb+2zZRJnEwgo922PoDUn4X1IMlYRp716OE7cifruGSz9McDXC2Gaan3hQCOhZ24shKKdDNm8XSRoKCJc67PgVGAheTJxFG2Vd07Xnupg5sHYYCOiZpMq/+df/1Air9V5G19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=de0HcDcg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4A984320D;
	Fri,  8 Aug 2025 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754648367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfxpN6ZiqcVyW4i6uW3ZKSO2WB/dwXVU69neRz5alTU=;
	b=de0HcDcgkFyNffryiXNWtj9t9e6pkWr4eO+Ju24QUompQtVAHzWdirHO5b3WoIrsoFdMM/
	xMgS9HjJk3e4qsvLaXstVbszXWHSekkXHjX8frJOjK+sHgFPNmjyDVpd2ZeFz84eCUifXU
	V50emlFWTl0JDzRZ8vomXmgBRRx+DXBiosIJ826gNeXX3ZDqaNoH8ZKqWd8xc1T7Xp62XE
	i65Kl5n/ORw2ShJMKvvCS9NE7y/OAL6BUPIv3dQJHN3zA6ZU88/e7OeymDnWRFeHy4wgwS
	E4u8DIaZF6T1VRZXGy0bBnqtzDJ6ZCQvN+zYFIBFjZsMrefmmbkkIvz0ibkg1w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 2/2] mtd: spi-nand: macronix: Add randomizer support
In-Reply-To: <20250808095503.906244-3-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Fri, 8 Aug 2025 17:55:03 +0800")
References: <20250808095503.906244-1-linchengming884@gmail.com>
	<20250808095503.906244-3-linchengming884@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Fri, 08 Aug 2025 12:19:24 +0200
Message-ID: <87zfca9kur.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrddutdekrdeiheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrieehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhgthhgvnhhgmhhinhhgkeekgeesghhmrghilhdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrt
 hdprhgtphhtthhopegrlhhvihhniihhohhusehmgihitgdrtghomhdrthifpdhrtghpthhtoheplhgvohihuhesmhigihgtrdgtohhmrdhtfidprhgtphhtthhopegthhgvnhhgmhhinhhglhhinhesmhigihgtrdgtohhmrdhtfi
X-GND-Sasl: miquel.raynal@bootlin.com

On 08/08/2025 at 17:55:03 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> Enable randomizer function by specific flowchart to set the default value
> of RANDEN to 1.
>
> Randomizer introduces two new DT properties for child nodes to configure
> the randomizer functionality and coverage options.
>  - mxic,enable-randomizer-otp: Specify whether to activate the randomizer
>                                feature.
>  - mxic,randopt: Define the randomizer area per page.

Can we create a global NAND DT property for that? Enabling a randomizer
is quite a generic step.

> The penalty of randomizer are subpage accesses prohibited and more time
> period is needed in program operation and entering deep power-down mode.
> i.e., tPROG 320us to 360us (randomizer enabled).

Do you want to share what is the added value in terms of lifetime to
enable the randomizer, given the drawbacks which are significant?

Thanks,
Miqu=C3=A8l

