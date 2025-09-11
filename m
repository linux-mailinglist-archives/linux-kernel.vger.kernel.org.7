Return-Path: <linux-kernel+bounces-811296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F1EB5271C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0604D1C84100
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179023A994;
	Thu, 11 Sep 2025 03:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="BgHRdRcg"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43423183A;
	Thu, 11 Sep 2025 03:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757561707; cv=none; b=IJ5HL/SMFcHh0/UUyb3fxbshLsbjGulOpBjE5ub83AzFbloAuesrgLMD5KV+G7aKeO6SxJkh1svqfiz26NaPnvukRscO1/0/OYGIHGu99zLGu64Hnl9jxnzGFD9r26LU+cCY+QlviXnGDvZs4qgwAgZtz6q6q2pKKYjQGjA1H4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757561707; c=relaxed/simple;
	bh=5K+fzwbWX432QtirHOzxhrMZ6T8493VGbop9fUkROb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGmMAOoJxb6VcoEo0p4ryXJWE3Cm8KMyzQc6lNM2fnvOKtt92mAxF/XKpwuNJj+btCkeIZYxJJvoyUqdmmqkdq/C4ZgwRyKRuUqkAhtXh5cyBJQhEqEPhzT5z8Yq2HTg0hG/UX6NMzhnVsSXYaf6RraBLLsbnrte4ZFXsQvbGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=BgHRdRcg; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9lfbb59Z653T2kjJpk8QzXlXjSD55hbRo8AmzH45kE8=;
	b=BgHRdRcgS4ePFTe3iK+gqw0Bx/wuh6tIqL+9EY5lyDoskjqNv3S9ifbHaXqkJX
	ETu66++yDjNGbkm5UmOqL9YfRuo7V0DnnwdIKzrufBEN/YRWnaA6J/S09HOSpe7S
	ARMo73gN7biOrc+xBtZfiVZGcVSs/ZU3W19jzz9trzhfY=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAXhtsaQ8JoCKRgBA--.51790S3;
	Thu, 11 Sep 2025 11:33:48 +0800 (CST)
Date: Thu, 11 Sep 2025 11:33:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH] arm64: dts: freescale: imx93-phycore-som: Remove
 "fsl,magic-packet"
Message-ID: <aMJDGigkz986YC0M@dragon>
References: <20250908111705.2956825-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908111705.2956825-1-primoz.fiser@norik.com>
X-CM-TRANSID:Ms8vCgAXhtsaQ8JoCKRgBA--.51790S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzSoGUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIhyiCGjCQxzcSQAA30

On Mon, Sep 08, 2025 at 01:17:05PM +0200, Primoz Fiser wrote:
> FEC WoL (Wake-on-Lan) functionality depends on using Ethernet PHY in IRQ
> mode. However, on phyCORE-i.MX93 SoM, polling mode is used instead for
> the FEC Ethernet PHY. Consequently, WoL is non-functional. Thus disable
> it by removing "fsl,magic-packet" property. This allows us to save some
> power during device suspend as PHY is not kept awake.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Applied, thanks!


