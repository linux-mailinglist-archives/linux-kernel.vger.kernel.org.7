Return-Path: <linux-kernel+bounces-721012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63478AFC343
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435FC7AB43E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4B22370D;
	Tue,  8 Jul 2025 06:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="LBCwjU1S"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8D5215F5C;
	Tue,  8 Jul 2025 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957459; cv=none; b=BmJxXKOu9eyvSsT9mv7nmJeW971xie3XAH+hgrNErQx38VNjGe8mDZPwQCg+V1LuTworuCDGaNfluYP2kXOHSJcnmVzmnAANsnlJ4dpxBAPIxQpiAxdIwkYgpX6LgM5N2ECE0wH4kRUuiJrOEzsK4QYRR52aUU7p3BJvgX3Sc1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957459; c=relaxed/simple;
	bh=NszIzPfg+J7mLUyhSZUBtCIxa0lA1Mn/+DBmH6nBQDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uH8EyWexcCk3VNRUIZtfTggmSrFoSulC495AW/iLQhwe9lK1i6HeJf4r5AYatlDyfIYMKzPgOpb/eNb7d+b1gZWQX13scvzZkydk0zob787XWT08kTvfAMx3vEWtxO7GpjOir0CpgeC4SNkda3NZHXe+F1sUgdhdsfEmZbtbCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=LBCwjU1S; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=TKk5nHWGdylz6lko9xpOMyn5Y/E4mXiwt9y3ZARKnPw=;
	b=LBCwjU1SrEDmdsfnssxd18SMkm1w7CgeCoKxoloj46sCrGbsdmPmv0qiMjUMmL
	m8SUe6TLOW1piGGAyb39dletwHqrfVBkvNdjYF1kgrNR8bKkvKsNKHjs1c0FbDlm
	0yiyDPQ1McLPGQcGQvr7oyQfCfAC1QrqBnn1b1V/eFGVo=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDXX_aKv2xo1nBMAA--.64566S3;
	Tue, 08 Jul 2025 14:49:48 +0800 (CST)
Date: Tue, 8 Jul 2025 14:49:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 0/4] Initial PHYTEC i.MX93 overlays
Message-ID: <aGy_ivfclZ_YXYui@dragon>
References: <20250708042206.329208-1-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708042206.329208-1-primoz.fiser@norik.com>
X-CM-TRANSID:Mc8vCgDXX_aKv2xo1nBMAA--.64566S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUOmhFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxOEZWhskC2smAAAs0

On Tue, Jul 08, 2025 at 06:22:02AM +0200, Primoz Fiser wrote:
> Primoz Fiser (4):
>   arm64: dts: imx93-phycore-som: Add RPMsg overlay
>   arm64: dts: imx93-phyboard-segin: Add PEB-EVAL-01 overlay
>   arm64: dts: imx93-phyboard-segin: Add PEB-WLBT-05 overlay
>   arm64: dts: imx93-phyboard-nash: Add PEB-WLBT-07 overlay

Applied all, thanks!


