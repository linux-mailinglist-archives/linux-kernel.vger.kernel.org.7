Return-Path: <linux-kernel+bounces-811179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A38B5257D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A8B189E246
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7771C7012;
	Thu, 11 Sep 2025 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="k0j2tXMd"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224402AD22;
	Thu, 11 Sep 2025 01:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552804; cv=none; b=CODpdEtO65NM5cjKAWKARLUnqQAnQ+++wADvJ+u+nPEYeLGfb1tssONLvk6FoRA3cAqw/gpLZokDXTrt7IC/GHPFvtwjT6e3Mha7dgra13yLQDiCKTwbyYD3gTZtI6nUwg3ovtYsNskIAsm6ZhEyJSwNlJ05Dv5WUB4tzxXSWwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552804; c=relaxed/simple;
	bh=JYSW4MB9pMusPzumKqihWAqFYMngihvRZKS64yMKi6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcvI7YNQdolyXoberZoknT8SOd/P0+5RDkibaKWUxXvi0isrXKZcftYd0yTB6paxmwmYzMIjC8ZFKJkVPcrji71KX9VFrCt/2h/3NE1GZ1TEX9RES2c0k/T8D7fdD5U2wsBXgRv/K5qyTjqc0fhd4NxC9wquhNiPp2p24NsBs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=k0j2tXMd; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=KbYMnuTWyfN0Gz6b3slKCQiIkGgeBPU1rlOHaU7fi2E=;
	b=k0j2tXMd+2VFECbFDfy941g+mbxW1NBDwcrE3/wLDkiaqNbzwytmU1S/CelBXR
	junfLtIVEt0g+hIijhJoz7K9h+uaVeNmC32B+tplAEFhVyeq4yIbFT6Hgtf4xr9U
	9NL6g6GKuA3VzM+iZUIjYAByrm7KOCd/HHcX4pxq6cttg=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAHP_d_IMJoJQFfBA--.42211S3;
	Thu, 11 Sep 2025 09:06:09 +0800 (CST)
Date: Thu, 11 Sep 2025 09:06:07 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Richard Hu <richard.hu@technexion.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Ray Chang <ray.chang@technexion.com>
Subject: Re: [PATCH v5 0/2] Add TechNexion EDM-G-IMX8M-PLUS SOM and WB-EDM-G
 carrier board support
Message-ID: <aMIgf50uRVg7fxKx@dragon>
References: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-add-technexion-edm-g-imx8m-plus-som-v5-0-bf745447345a@technexion.com>
X-CM-TRANSID:Ms8vCgAHP_d_IMJoJQFfBA--.42211S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOksqUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQHyWGjCIIEAowAA3i

On Fri, Aug 22, 2025 at 03:33:07PM +0800, Richard Hu wrote:
> Ray Chang (1):
>       dt-bindings: arm: fsl: Add EDM-G-IMX8M-PLUS SOM and WB-EDM-G carrier board
> 
> Richard Hu (1):
>       arm64: dts: imx8mp: Add TechNexion EDM-G-IMX8M-PLUS SOM on WB-EDM-G carrier board

Applied both, thanks!


