Return-Path: <linux-kernel+bounces-751414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D3CB1694F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7DC5A7087
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08B2367AB;
	Wed, 30 Jul 2025 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WSbJN+7k"
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6322A7EF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753918818; cv=none; b=JeTHJezNSbZ1e9Mi90kCK8czlY5V2dpbePvzjyFOo18c+OKDKqJ2BEkF7+HUMnVvtdHeNadZqfItHkB8Z3eW++H3QTIeo5ATcrCqSSlIDyA7zySlWPWH73H+NbmYExEYawbNUMtmjcsM1YlFboAOCBFTp75Dq17CJes/H7jk9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753918818; c=relaxed/simple;
	bh=/sRwHFLugfSk76TD5+qjjwgkruWhdy1AIj9hs+TKQwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k71J5mi41wpmN8R5F5Tm7mdDVAZOa1n/d36GhE30+D2jRowYc0QKJgCgMCM6g3LbZgUPepHqznW27q3Mf4FWsV+sOJol4VH8xf7kX1x26S52LqV6wuTXHdHCyN0uxufDqj6vsgwIdLkUfIkzMaifray1tFph0CYvdJOlk4DvEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WSbJN+7k; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6A12F44952;
	Wed, 30 Jul 2025 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753918814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/7P0dyH/pOtJmRxErXBoF32ZKspF76xArSucRBMQX6Q=;
	b=WSbJN+7kF+EAffJb9AgMj5S8tFRIJr9rN7MCbaa9eOtm7O8Qmxas39cbOWWTxRu8erQfE6
	WtlOqdkLdQJPn38dEji+ngx1CINBce4Nu5/ePX2yT576o8zHHSIv9LcNI1rYAjCS37/EI6
	TU4cvpdkHcKpZsXgXUyPC05X/nrqmThoKDL5il6vU36kAfJUy3bZV3/UGIojDPFjXlW6Ju
	sct7hidh1uGWAy4uAStSgPdJIrxpghEvkB6h2VRmInyw7XTlF1ELW65PAvD7B23yuIZb1S
	ygjJv3xTeaEag6RBdBSbof9XxkQoUKmNYo69lDlrEFi7p/TxMX4nAPdGairdaQ==
Date: Thu, 31 Jul 2025 01:40:11 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux i3c <linux-i3c@lists.infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] i3c: Fix i3c_device_do_priv_xfers() kernel-doc
 indentation
Message-ID: <175391871293.1768453.17733730454995814545.b4-ty@bootlin.com>
References: <20250702040424.18577-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702040424.18577-1-bagasdotme@gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelledvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemudgvfeefmehfledvleemhegvsgekmeduudegfedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfr
 hgruggvrggurdhorhhgpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephfhrrghnkhdrnfhisehngihprdgtohhmpdhrtghpthhtohepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomh

On Wed, 02 Jul 2025 11:04:24 +0700, Bagas Sanjaya wrote:
> Sphinx reports indentation warning on i3c_device_do_priv_xfers() return
> value list:
> 
> Documentation/driver-api/i3c/device-driver-api:9: ./drivers/i3c/device.c:31: ERROR: Unexpected indentation. [docutils]
> 
> Format the list as bullet list to fix the warning.
> 
> [...]

Applied, thanks!

[1/1] i3c: Fix i3c_device_do_priv_xfers() kernel-doc indentation
      https://git.kernel.org/abelloni/c/ba12d5f11d52

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

