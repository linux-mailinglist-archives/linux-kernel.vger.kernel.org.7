Return-Path: <linux-kernel+bounces-727131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F52B0156B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D7D765224
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07C201033;
	Fri, 11 Jul 2025 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bxxLkygm"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43451F7554;
	Fri, 11 Jul 2025 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752221109; cv=none; b=FMV1X3W7LYAV0DNgzDPCzZCXvnTa2TWN7vseTMGv+yIDRVHOx+gfq+fafBo8g1zd5Yq/geEgSWRCSFjLdqaev40lHFwly1/M4ZEmw1SxYwn93Anee8MoOOJcPsmuCYlyygoU17OAUJt7Vinbj3P0oLVBGR1eHYL8W1H0VhrwmRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752221109; c=relaxed/simple;
	bh=Yi/3ncmNYN80pXHGeCRaMiu+4IsrTaflk7tc+t5Ivts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV7V3hpYQxEqEVBCTE+PhmDzV80vm+1GAFo4axKzGwbXw32tkLKKJ92DwYfdXKK3JJJfEJOEa1g9Zyb1fPKf2Mq9uFq1rftlXAXuE0H5sAprug60tIlvXSjn6Xzjs0xgrTuUe+6yQ7yGtjmepwT6RZfyhXuKjnLLGAEaeg+9pUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bxxLkygm; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=GkZoduVqumtiEfQnQGzIJk1vG8qGeS4iGJFAehTc+vM=;
	b=bxxLkygmhvHTXs+MXsZXUX1n4jDPnz24VHGmwURFEn7WNma7xzcYqGLCvFzH1i
	K5Ci5gqr5HLCWaoAb20LyNlqAo9x/6r+JhZc9zYRyisvYYhLMfbUqLZsHfNZTXdx
	hnNIBZ58CxDEdmDEiyQfnmhcK418bsc3xYLVXA9PeYApU=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3_ySIxXBoVFpTAA--.58278S3;
	Fri, 11 Jul 2025 16:04:26 +0800 (CST)
Date: Fri, 11 Jul 2025 16:04:24 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: imx8mm-venice-gw700x: Increase HS400
 USDHC clock speed
Message-ID: <aHDFiN8dn8zVnmZl@dragon>
References: <20250707201702.2930066-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707201702.2930066-1-tharvey@gateworks.com>
X-CM-TRANSID:Ms8vCgD3_ySIxXBoVFpTAA--.58278S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5g4SUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRGHZWhwiwXKEAAAs2

On Mon, Jul 07, 2025 at 01:16:56PM -0700, Tim Harvey wrote:
> The IMX8M reference manuals indicate in the USDHC Clock generator section
> that the clock rate for DDR is 1/2 the input clock therefore HS400 rates
> clocked at 200Mhz require a 400Mhz SDHC clock.
> 
> This showed about a 1.5x improvement in read performance for the eMMC's
> used on the various imx8m{m,n,p}-venice boards.
> 
> Fixes: 6f30b27c5ef5 ("arm64: dts: imx8mm: Add Gateworks i.MX 8M Mini Development Kits")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied all, thanks!


