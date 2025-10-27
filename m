Return-Path: <linux-kernel+bounces-870937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614E8C0C05B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E553BBAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FF2D7DC3;
	Mon, 27 Oct 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="IaT5bG8/"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05F2D8376;
	Mon, 27 Oct 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761548356; cv=none; b=PzE7LZMaZqWk+tM+2yA9IMwBYrkdHcLHLybPJbVdmREnjKkC99OOtbge75VJEx6vQc22s5p5TeB3ZmZhspx2+DjWKLhpM8fSXnyGLceFJ20WL4U5yYv43UxUYr6fwnKOdy05XigSCYsNDxnDDWmGj8+G7knVqHns1E307r1O/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761548356; c=relaxed/simple;
	bh=OB1Cik7udfraEKjwtubanodFIkXelNdkrRiK/NPvAOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9I9ZIlBo0T6XE/Mr19Nsmoc+0apAwcgCrSfk2CaiswUE1tj6AXUOuwvHb5CGEK6q8AOQY56l0ohRajL83kjklejw9Plimi4JdF5CXqUNgzcU59dqve5bWzGU6nmKWH57hoY6jLYJ/MAATwwgHSpLJFhW7b0TLuoIFJWwkuHMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=IaT5bG8/; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=izvswgULjVKnMNc8RRs/u+xF9sef1u7J/UdDKN2xSwA=;
	b=IaT5bG8/Npswm9/cwt+6r5pTKpEdnOb/4ZzS398oWoPIqr8N1ljh55/QnVLNpd
	pq+47fW2DbALWK59ineCZBUfjecluVRrZ921mmhVO4QH4MCsyqEsjDZbwLHnxyl0
	Pf+s/j0hJSuiSPxEMrPMwe0gD830HgAT3KbNZByG9fKjI=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with UTF8SMTPSA id Mc8vCgD3N58gGP9o0rg_AA--.50610S3;
	Mon, 27 Oct 2025 14:58:42 +0800 (CST)
Date: Mon, 27 Oct 2025 14:58:40 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: fsl-ls1028a: fix USB node compatible
Message-ID: <aP8YIIQG6uT7bLEA@dragon>
References: <20251020133754.304387-1-alexander.stein@ew.tq-group.com>
 <aPaXaFigEh50sdZC@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPaXaFigEh50sdZC@lizhi-Precision-Tower-5810>
X-CM-TRANSID:Mc8vCgD3N58gGP9o0rg_AA--.50610S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2b18DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNwIojWj-GCKfngAA38

On Mon, Oct 20, 2025 at 04:11:20PM -0400, Frank Li wrote:
> On Mon, Oct 20, 2025 at 03:37:53PM +0200, Alexander Stein wrote:
> > usb/fsl,ls1028a.yaml says the compatible is just a simple
> > 'fsl,ls1028a-dwc3'
> >
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> 
> Thanks, but it is similar with last patches of
> 
> https://lore.kernel.org/imx/20250929-ls_dma_coherence-v5-4-2ebee578eb7e@nxp.com/
> 
> Waiting for shanw pick dts part.

I'm waiting for the usb binding change in the series to be applied first.

Shawn


