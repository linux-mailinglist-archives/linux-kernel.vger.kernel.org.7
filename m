Return-Path: <linux-kernel+bounces-862441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B014BF54CC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56EF466557
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69ED304BA0;
	Tue, 21 Oct 2025 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="j+3sVkH7"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B8302766;
	Tue, 21 Oct 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035788; cv=none; b=KWQNdNjB+joTjkd8kz0xdVxG4WvRS8LrdhDpiuK/CUG6K/3SFc4I/Nq1MsrN0oHAjcyVUynwv+TL6NvxBAbzdmh21byRe/qU8t7V78/Ydd6AxpvHbLrGDLhaBErauUwx7uGlAgg3cc1srSf2awcNXCMeTtJBX6zEBW015XXS/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035788; c=relaxed/simple;
	bh=z0EChtbTRbAgKVGMYygnvZxX+CLrEvNftM16zQ/G+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv3b2cmsK3Frcrzz2VxJz7Y/c+YD4NnZE1d2raUK3XFfCASx67EAsKfN1rhpBOqc7yTsDhQ1WFEwPxdJIFgNsjg7Z8lHW9ixuyzSTCiKtOc6pkN0mBqsplB+F5yDaSV6xhevEtR/I16gsYNjdB/W8hwMGN5MowrrDlhrq8SXnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=j+3sVkH7; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=stZPJ4M5bQxptRayTgT6RtHDQjZgxyXiEdqip2m/sjE=;
	b=j+3sVkH7/mAopbBYTH6PAu7sSTkSJr1IQPilH/1KWstydxQt5nMQ+nOgDLjt8I
	8y4azlN1xpwgyxcEBIOIyUbIvmU+tTQP5NgzSp0QBW/urQ5w7d60DqSpayCm5JZl
	U6gdlw77C4sR7aWUP8yMJUipBVEArrQ022eLTm0G6L9PY=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDnB5LjRfdoaIdeAA--.44314S3;
	Tue, 21 Oct 2025 16:35:49 +0800 (CST)
Date: Tue, 21 Oct 2025 16:35:47 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Walle <michael@walle.cc>, Peng Fan <peng.fan@nxp.com>,
	Frank Li <frank.li@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>,
	Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: imx: correct the flexspi compatible
 string to match with yaml
Message-ID: <aPdF4yR9iGFInJeV@dragon>
References: <20251017-flexspi-dts-v4-1-330fc467f489@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-flexspi-dts-v4-1-330fc467f489@nxp.com>
X-CM-TRANSID:Mc8vCgDnB5LjRfdoaIdeAA--.44314S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7Z2-UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIQaiCGj3ReamqQAA3+

On Fri, Oct 17, 2025 at 05:25:41PM +0800, Haibo Chen wrote:
> According to Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml,
> imx93/imx95 should use it's own compatible string and fallback
> compatible with imx8mm.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied, thanks!


