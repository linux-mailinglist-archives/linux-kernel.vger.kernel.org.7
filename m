Return-Path: <linux-kernel+bounces-811188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA9B525AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02C517B64C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB54119258E;
	Thu, 11 Sep 2025 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="g1xf8/Kk"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606646BF;
	Thu, 11 Sep 2025 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757553557; cv=none; b=pjMDv1STZZv3kKuJsa7IyuBFafYiOO8Z06SBkMpsQnnxCKTiypvRmOqp0k79beKyt2Yb6HwNPyOVq49t/rWPMUXsLjdDHY/DY8DZvvLZ2Ixb7d0cwcTTYA1CSoTlm+T46sjYY3i1xGk+ZHy2Ngt+ArTPyxjW7TFrEag36FwA55Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757553557; c=relaxed/simple;
	bh=qvhgtC2h3ETUIgnFRZFbzu/JYAKwAWMBnSFugUc679g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EppGde8BpL9rCJzmQEkgCsONJO2rfJ0ZHcXDmnkD+P6yGqyArHjxFhLGiGEPTsNqXQCc+t4TlYs3CUOI30B5ASRoOxPGtl4qvoOCtWML39isFrwQxfwLR5y2n2he8cVBgy8hpKoq9JLNg3Zpxo6Lhf+K4MADEccJZMxwpBFQ3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=g1xf8/Kk; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=3RmRZf9ZN1qFLW6+btemuGyf7rW4veZ9+qaLWx/0nFc=;
	b=g1xf8/Kk96D+nhvpAAMglx6bg62mJo7C01X9Baabluk5kI8Vhew44CTTCE2gPS
	Gug2mn1yubXbDZZMks/F3HTMSpLKDeFglg0rT3XbrW1OhlEaQcamSwdP0/gESPo8
	PUEbunxNocZP2AJLxOIuKTveghzGMDjh6wF3x3o9O+psY=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgA3ZdlvI8JoJilfBA--.45492S3;
	Thu, 11 Sep 2025 09:18:41 +0800 (CST)
Date: Thu, 11 Sep 2025 09:18:38 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux@ew.tq-group.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: tqma8mpql-mba8mpxl: Add MicIn routing
Message-ID: <aMIjbtfLTzCMZZjV@dragon>
References: <20250822140742.3352401-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822140742.3352401-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgA3ZdlvI8JoJilfBA--.45492S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWkWr1DGr15AFyxWF4kWFg_yoWDtrb_Aw
	4xua1qyan5tFnFqan0qrWkWr9IgrWUCr13Jr13Wr4kJF97Zr4DtryDtF93WrZrCa9rKrW3
	Awn8XryFy34akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbRBTUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNRGvFWjCI3FnMgAA3z

On Fri, Aug 22, 2025 at 04:07:41PM +0200, Alexander Stein wrote:
> MicIn is connected to IN3_L. Add routing including the Mic Bias.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

It doesn't apply to imx/dt64 branch.

Shawn

> ---
>  .../arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> index 2d4eaf9c02b88..1924d51bcbcd8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
> @@ -245,6 +245,13 @@ sound {
>  		audio-asrc = <&easrc>;
>  		audio-cpu = <&sai3>;
>  		audio-codec = <&tlv320aic3x04>;
> +		audio-routing =
> +			"IN3_L", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"IN1_L", "Line In Jack",
> +			"IN1_R", "Line In Jack",
> +			"Line Out Jack", "LOL",
> +			"Line Out Jack", "LOR";
>  	};
>  
>  	sound-xcvr {
> -- 
> 2.43.0
> 


