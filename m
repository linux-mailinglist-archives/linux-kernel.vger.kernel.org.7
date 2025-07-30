Return-Path: <linux-kernel+bounces-751413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B4BB1694E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB51AA3A07
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73832367AB;
	Wed, 30 Jul 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JptZENru"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9C22A7EF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918811; cv=none; b=Juzy4h1WwkIGjXoTRl9lLlbBs+CyAD8svPs7P2Ud12P3fPeA0c2bhvmF6jj1adxj57HdWSoNlZ8tbHvBIEUnl3C2vU9sJFRc3BwBynpB9/n3qsrA7R3NllUAOI0Y67w31VvvQ5umAvQ/HqqnNF5suIP0CH7b/6Nh2aoV6QhjkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918811; c=relaxed/simple;
	bh=n6lfdrWkpeinuS7+XQP7KEmFXBmxm78eAym+CKEj6yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAYcwa2/qJ37P3IqJwwvNpmV6o2ZVt48vc1M4OTIBDdbmi5sL7xvZNAnS4QKFhb+1uPzMfrJTKbaS3kKwcfM+dk+/63YrC4UHIgtOcgTlile/pfwhNey06QEkOn6UleAi/zHB/tTdTLBm2uSVoYMblQMfjckRMzijdKv4Sry7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JptZENru; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D050343848;
	Wed, 30 Jul 2025 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753918806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3bdQJx5RZs/LsiSuUfK/7GfgsqTy9SxRpZPG3z++wA=;
	b=JptZENrur7SVay8s00tLbl9Nq8AfOPw8Dj4alkaSWUntmSZtPimcx7FlLlnnD7e4IAkSxc
	ew4CedYr2zWenqUCQYMqcxyzRwUiIbgjBZ70RjbOe382GoouRSCEOcBcUcZlQDJHxNwZNo
	olVmhc7F2z1t/9lCKJyYJodCQ/Dr0P+VIXc5e/lnqwNEeaMStmyFXmW1Q0HwPzeK9IZ3H0
	Gkk5czgrrE8QIF1o9B1PPn3RzJKFiLMUUyWul1y040J/I9IgJokFMh9ekqVjs7YgbKtwYq
	nNmITnSpMqf9TkMy0or3JWtLaJkCPktTP7JYPT3NTTNP44zD14cT3O3BCOinxg==
Date: Thu, 31 Jul 2025 01:40:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix module_i3c_i2c_driver() with I3C=n
Message-ID: <175391871296.1768453.9315319722911667776.b4-ty@bootlin.com>
References: <20250725090609.2456262-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725090609.2456262-1-arnd@kernel.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepfihsrgdorhgvnhgvshgrshesshgrnhhgqdgvnhhgihhnvggvrhhinhhgrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsr
 dhnvghtpdhrtghpthhtohepsggsrhgviihilhhlohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggv
X-GND-Sasl: alexandre.belloni@bootlin.com

On Fri, 25 Jul 2025 11:06:03 +0200, Arnd Bergmann wrote:
> When CONFIG_I3C is disabled and the i3c_i2c_driver_register() happens
> to not be inlined, any driver calling it still references the i3c_driver
> instance, which then causes a link failure:
> 
> x86_64-linux-ld: drivers/hwmon/lm75.o: in function `lm75_i3c_reg_read':
> lm75.c:(.text+0xc61): undefined reference to `i3cdev_to_dev'
> x86_64-linux-ld: lm75.c:(.text+0xd25): undefined reference to `i3c_device_do_priv_xfers'
> x86_64-linux-ld: lm75.c:(.text+0xdd8): undefined reference to `i3c_device_do_priv_xfers'
> 
> [...]

Applied, thanks!

[1/1] i3c: fix module_i3c_i2c_driver() with I3C=n
      https://git.kernel.org/abelloni/c/5523a466e905

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

