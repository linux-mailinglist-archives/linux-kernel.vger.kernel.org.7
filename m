Return-Path: <linux-kernel+bounces-751415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63A8B16950
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E040543AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11859238C35;
	Wed, 30 Jul 2025 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QvvVjQn1"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B623816C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918825; cv=none; b=cKECGriGNyorF/YNq3zAVujVnqKHaTUcCMjimsx195B8yQuRmsHhS+4rx9HuqpX22MKqmjGJz2GGX/MpfSrOWuIQn/jsmLLtmA09WDB5W1kATATM36BMRUIXqEA0gfAqXQ2utfUkrIn93yJIdXKqGbIWobTjkrZT7Kz7++Wg20o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918825; c=relaxed/simple;
	bh=Yuo7bGTCr0ENSTEVaG9CVGAh7r4yjmM/lrAgnqSwpp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umTrnUtppnx4G+KtsN15j14hyLZphkmbffQTdBLWVNJ/tIPqqbosE81X7+UdikIpd7D0jgHSRWjMjddbjVjLK8VJtIHRm7oPUCIfovzSZTOQssnenalZCBBmdXFV09wIL2Eql/VVjg+f0/3yqhJb7OUsAiWuyHZwsnz6bhR07co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QvvVjQn1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C06B64338A;
	Wed, 30 Jul 2025 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753918821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYJ0/uSV52d3ObZ28JInnZr4F1z0KhVK08QGNJys/XQ=;
	b=QvvVjQn1B62ZegMNDD5gWRe/aLZcVjD4JX22IBUOd4ZzFDYUiK6GxKKfLjNgCRmRX+hott
	vswY+rXjW/v5Kr1JAvSjQVLCrFKsSpNUGtG7oKFgDxdx5MlN18FtlxP3nuPHRNVD/WpDnP
	/2G1TiZZNeoFjormZL2Avg1DhF4jTxvGLxFzX1H0mxWVP7SjAe7f75dJSA0DBfNuZQBgOz
	VRX8xLql9YPruILOZDf+GDsFqpzyyc6e3dQP7h03iTFyaMeSrp0XZPeVr+g6UcbyiM5iE3
	gq0iHcxN1+oeG8ihzP7pY30vhU88sIeoKKMA/BXNmLVdSxb0uJIeEm0QMvrgzw==
Date: Thu, 31 Jul 2025 01:40:18 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Frank Li <Frank.Li@nxp.com>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Jorge Marques <jorge.marques@analog.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add helper methods i3c_writel_fifo() and
 i3c_readl_fifo()
Message-ID: <175391871291.1768453.6107982035925873578.b4-ty@bootlin.com>
References: <20250624-i3c-writesl-readsl-v3-0-63ccf0870f01@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-i3c-writesl-readsl-v3-0-63ccf0870f01@analog.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehpghgrjhestggruggvnhgtvgdrtghomhdprhgtphhtthhopehjohhrghgvrdhmr
 ghrqhhuvghssegrnhgrlhhoghdrtghomhdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 24 Jun 2025 11:06:03 +0200, Jorge Marques wrote:
> The I3C abstraction expects u8 buffers, but some controllers operate with
> a 32-bit bus width FIFO and cannot flag valid bytes individually. To avoid
> reading or writing outside the buffer bounds, use 32-bit accesses where
> possible and apply memcpy for any remaining bytes.
> 
> Add two auxiliary methods to include/linux/i3c/master.h and use in the dw
> and cdns i3c controller drivers. The adi and renesas controller drivers
> will also use these methods.
> 
> [...]

Applied, thanks!

[1/3] i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
      https://git.kernel.org/abelloni/c/733b439375b4
[2/3] i3c: master: cdns: Use i3c_writel_fifo() and i3c_readl_fifo()
      https://git.kernel.org/abelloni/c/c20d3fa70491
[3/3] i3c: master: dw: Use i3c_writel_fifo() and i3c_readl_fifo()
      https://git.kernel.org/abelloni/c/6e055b1fb2fc

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

