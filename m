Return-Path: <linux-kernel+bounces-757316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4CB1C0BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC60189B691
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7C213254;
	Wed,  6 Aug 2025 06:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bTEsT08T"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7324431
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463445; cv=none; b=sddXJJtqpalrDvUgLlHX5kEgUFJ2QYnICKkt01ccDassGWwNPAJqaY4P/BfKybTKz2ReQcIEB4LD3friXJ2VSrIagb8uF7dDhbnd4IiITQnj/E09+1XjDJ0kWJ9mtkVOlrZ4ZnP1RtHSbny61leLy37kWBk5F+740weks2+vm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463445; c=relaxed/simple;
	bh=Ztuv9Zl/QP1Ykqjs14qunqoxFKoTE2QwVzuw0OQI20w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KV6jlwbr3WK4YFg7pMm5R693JDI9k5HUjOWt730yCDkdgRmVqFBQUJ44628pbBL17JU5+HvuDhjYIYPFjPqga+q0zVuQFhemPnhPZkbiASLHAmX8GUV0GTU0nRe3KX9RYmlMG0QfvuroWZ/i/aqOecirnUu2GMcHB2qZuVDvd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bTEsT08T; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E1D1443DA;
	Wed,  6 Aug 2025 06:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754463434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ztuv9Zl/QP1Ykqjs14qunqoxFKoTE2QwVzuw0OQI20w=;
	b=bTEsT08TkeiaIq96drOmkJ7sImQn4KK3dOcj8ShyXHIfwHc4Wusod2Jj36LQJDRYElj8UA
	mye6o7RNqHrs4Tyl0RHJzV8KshA/poEqfR2CALXd3vY8ZcIwNlSjWmFX/PV4FGICyIiuID
	LPVaWnYBBGWTfkrolK9VSef1yDC8p4fFE0kDY4CCocjWgWtpOiTUI9f7Q7Z4eAQQKh/hJK
	qxwfujUchf3HBner1wH3v7yyq1SCQ5DI0P9K5+d4DK+zeKvHLg3A3gIlhMSR/KRQO8ZOUD
	4R63fjJRkK193w0ncGJABjdR34qFoOmvKcHfbyPnDwbbKxi3TArVkjDpLs7rng==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: expose ooblayout information via sysfs
In-Reply-To: <20250719-mtd-ooblayout-sysfs-v1-1-e0d68d872e17@gmail.com> (Gabor
	Juhos's message of "Sat, 19 Jul 2025 14:06:48 +0200")
References: <20250719-mtd-ooblayout-sysfs-v1-1-e0d68d872e17@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 06 Aug 2025 08:57:11 +0200
Message-ID: <87tt2ley48.fsf@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Gabor,

On 19/07/2025 at 14:06:48 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> Add two new sysfs device attributes which allows to determine the OOB
> layout used by a given MTD device. This can be useful to verify the
> current layout during driver development without adding extra debug
> code. The exposed information also makes it easier to analyze NAND
> dumps without the need of cravling out the layout from the driver
> code.

I would prefer a debugfs entry, as this is mostly focusing on
development and debugging purposes. sysfs has a stable API, which makes
it a less relevant place in this case.

Thanks,
Miqu=C3=A8l

