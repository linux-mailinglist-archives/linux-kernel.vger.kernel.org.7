Return-Path: <linux-kernel+bounces-758772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FCB1D3B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431A617B780
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23011239E6E;
	Thu,  7 Aug 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dAECNntG"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1D21DF258
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553067; cv=none; b=dIlF1S5IxXwREBl1w9Ksgru3HaoCVzo6NSfIpT/yIojdhrnvaXNz03+Ow2UN48kGZpadnbthfguy6f/falP2IUhxprtWeymN6GQH4DdaN2vPGOUFECY6pDLaTPt3JzRUyfrK2eek9DNDp/mccZw0J/05EIMaDv4cBQj6SclhB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553067; c=relaxed/simple;
	bh=pGKstv3GuAM43Nh+BV2LNRRufA5d5mb33q0ZpOcVjS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKRu5bisHNThTQXIk70aDH9s2D/2QjB9fmQEpWkRf9RbqLFZbsII2QLXNK04p5YP5mvndPq4KBYrkJ+qynpc24OhY10M6Hir0HeR9A19Kh8ujQaRnCaUzx/XvkoUrC5FCrtD7e2OAh3HzQf+eG34cCNXoL8BZsE+/54zW0R7aLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dAECNntG; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 276E81F68F;
	Thu,  7 Aug 2025 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754553058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGKstv3GuAM43Nh+BV2LNRRufA5d5mb33q0ZpOcVjS8=;
	b=dAECNntGaaM4+2vbuxBwqgOyZhzw2ZjN6fYACuipFs0k5F3vaBccp4MMIdhbnuw/MyTSpu
	6MwANAT/S/hTUTSHFdQJZp0TEeVlpwhNufZIw4fGuhB2rMMcfryrXTYY3xLaUK8dnpAPSK
	tr1NhKeMBagC8Ck/g9IkP9mobQDX7C5ho6djxH5Sj2/y1OenhQMetphs/b6O+IzOPq1qEG
	hVyULqNmB3yHADZCyw1p3F1Aju96ui7z3k3e+MbRpkVEhDbij8yxTNs6W8he4YTZSQygwF
	ehGp1Ctv5BK84CCM0l4Mv2ILdAMvDhG6BfgK6q9mAJRIzKjTZxPMs/cNwVFxoQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: expose ooblayout information via sysfs
In-Reply-To: <25dcf103-3cd3-400a-b402-cbb5f23006c9@gmail.com> (Gabor Juhos's
	message of "Wed, 6 Aug 2025 20:40:21 +0200")
References: <20250719-mtd-ooblayout-sysfs-v1-1-e0d68d872e17@gmail.com>
	<87tt2ley48.fsf@bootlin.com>
	<25dcf103-3cd3-400a-b402-cbb5f23006c9@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 07 Aug 2025 09:50:57 +0200
Message-ID: <878qjvefj2.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Gabor,

>> I would prefer a debugfs entry, as this is mostly focusing on
>> development and debugging purposes. sysfs has a stable API, which makes
>> it a less relevant place in this case.
>
> Sorry, it seems that I misunderstood the ABI documentation.
>
> Since the 'sysfs-class-mtd' file is under the 'testing' directory
> within

It is indeed unclear. I'm not sure myself what that exactly means TBH,
but it's been there for a long time and can for sure be considered
stable. Sysfs in general is not for debugging.

> 'Documentation/ABI' I thought that it can be extended by attributes used =
for
> testing purposes. Additionally, the 'oobavail' and 'oobsize' attributes a=
re
> exposed via sysfs, so it seemed to be a logical place for the new oob rel=
ated ones.
>
> Nevertheless, I will check what can I do with the debugfs based
> approach.

Sure, thanks!

Miqu=C3=A8l

