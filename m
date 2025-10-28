Return-Path: <linux-kernel+bounces-873319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A07F3C13ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C3334FC521
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEAE2DAFD5;
	Tue, 28 Oct 2025 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="V+lOghLh"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC25201278;
	Tue, 28 Oct 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641945; cv=none; b=rZwjm8Wtk4zgufHYoyZRRW0/IM16wDZiYPDcU6ixevCwEUn870olzT5ZSGAiVSSEckJnppdDL1VEXPrqL/TtTUodn7XhaJZ35qHThuN3xgvNB/oyc3LqSpXd3VJaB2xxYFDDUU+orHeN46X4cU5rSNT5nzYyzi/c9GBDMW1vZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641945; c=relaxed/simple;
	bh=YBe5bROSGpZ12p06h/UvpBqwWi3bXnQ9j9Vl7E3IFUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCstMK6c6uZl4UZJ5nx0bAdFWu86auXa3VUm1aSPL8NNJILer2tvCbnMeU1+lTaqUbatwiFeDLLOEL6NfKGGNC+HE2bU5P6CFEO8dKQarTk0LzW+Z3iZ8JFHGfaQuoe6oTxlNxI9+iB8EpRyKftqUa8QL5lS8bazM1KnLFmJSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=V+lOghLh; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9bK3jiDst9EuMzVRY6Pg60RWEks+MLAKHwEmu72HbS8=;
	b=V+lOghLh5Yppr8qc0mSRZOKZ/ACHLi4IuqKbExuzl9Euk3xTKOmGEdldK0M7lu
	7lLVWkzbx9XPna/o4nWCjlG7aEMKoALvpEO7pqlNUu1Dv+VwnYzr+MTe4E1MtEKV
	38HN1frJ2LhoMN+jqTx6aTL29+urqAUHP6feEeSUrRGXQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgB3zxWOhQBpGivTAA--.44629S3;
	Tue, 28 Oct 2025 16:57:52 +0800 (CST)
Date: Tue, 28 Oct 2025 16:57:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev,
	Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v5 4/4] arm64: dts: layerscape: add dma-coherent for usb
 node
Message-ID: <aQCFjuyMCTM9qQcd@dragon>
References: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
 <20250929-ls_dma_coherence-v5-4-2ebee578eb7e@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-ls_dma_coherence-v5-4-2ebee578eb7e@nxp.com>
X-CM-TRANSID:Ms8vCgB3zxWOhQBpGivTAA--.44629S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwmiiUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNBDfRWkAhZCs7wAA3B

On Mon, Sep 29, 2025 at 10:24:17AM -0400, Frank Li wrote:
> Add SOC special compatible string, remove fallback snps,dwc3 to let flatten
> dwc3-layerscape driver to be probed and enable dma-coherence for usb node
> since commit add layerscape dwc3 support, which set correct gsbustcfg0
> value.
> 
> Add iommus property to run at old uboot, which use fixup add iommus by
> check compatible string snsp,dwc3 compatible string.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


