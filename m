Return-Path: <linux-kernel+bounces-751416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A945B16951
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8481AA3C50
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5D62343AE;
	Wed, 30 Jul 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hycS7UcX"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFB2237164
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918840; cv=none; b=Bl/wz+S+Kfnd8uyjmK9GCRr4lVkmspaXMJm3w8jmYPd7mhDKEOTArLPCX30+E28JthBFeJIjTqBcGmCACu53JigiP5Ogrx5FJ8FSj8vBvwHF/lzkqDZnliiEY5fE4USvxLK2K9EvG2XPrdrcJnj+QXUEEAc6FbslC6EdQaqFgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918840; c=relaxed/simple;
	bh=6npVYz6NLsnjIRWW33Y6e0e0HiFYCPIfn2U2oPOAsKo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELzuirKoNt7j4g5QlONLfSQ8Y2xj3GhbMZq3NEwXCJf/lgmQ9Uy582jZcSuIQn1LIHaVbQjokZhTXqIL46Z2kUYz8kR4TJ4yBKjaqXUHYBfPcITu3zMGno7CtzSlmB95jnZjDplYAFXJ4dOP5h9igPKl29zj2Wq5z8gh9OP79bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hycS7UcX; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB44E43287;
	Wed, 30 Jul 2025 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753918831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPK/+tRkFipPm1Q2/+R8GymrzprSbCpGJgSCzBqoOnc=;
	b=hycS7UcXFFaptgyCz6rW8VURqgJyAT/XPynfcrGpWBk34tHz0A4p8rGzGBugVta8kcBXCy
	m1t0BRAEE4b8LEuMZ1uA4I7lxgFZZyTeELSJ/ug2dL4QOPmmh7FYlMr4ILyPGvb0AAy4ig
	OJHa8PuZgSXChA5eexicjcFFethbPOwrJ6jrp12yJhFSDysR2cay+XMyZ1NUG1fzqwQr9h
	FchnNPa6znn1OWO8Ou8W6ey+HA8MkLmnelkL7g681qKHoavYVVzLeOneT1uiSxTNBT85Yk
	GbCkQ3e6jKp/ruQtEh++A4kudzkEiT9DW5eHVXI22a3KFN7+LBayg/yxSUjDGQ==
Date: Thu, 31 Jul 2025 01:40:29 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: =?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] i3c: master: cdns: Simplify handling clocks in probe()
Message-ID: <175391871294.1768453.10875050210045855745.b4-ty@bootlin.com>
References: <20250713152411.74917-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250713152411.74917-2-krzysztof.kozlowski@linaro.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuddtgfehteevtedvteelleefffekhfdthfelgeefueelgeeuueeggfehheelvdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeduvgeffeemfhelvdelmeehvggskeemuddugeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeduvgeffeemfhelvdelmeehvggskeemuddugeefpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepphhgrghjsegtrgguvghntggvrdgtohhmpdhrtghpthhtohephfhrrghnkhdrnfhisehngihprdgtohhmpdhrtghpthhtoheplhhinhhugidqiheft
 geslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Sun, 13 Jul 2025 17:24:12 +0200, Krzysztof Kozlowski wrote:
> The two clocks, driver is getting, are not being disabled/re-enabled
> during runtime of the device.  Eliminate one variable in state struct,
> all error paths and a lot of code from probe() and remove() by using
> devm_clk_get_enabled().
> 
> 

Applied, thanks!

[1/1] i3c: master: cdns: Simplify handling clocks in probe()
      https://git.kernel.org/abelloni/c/da9b54708ddf

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

