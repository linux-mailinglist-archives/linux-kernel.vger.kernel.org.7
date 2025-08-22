Return-Path: <linux-kernel+bounces-781578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DECB31442
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03DD1B0385E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862DE2F2908;
	Fri, 22 Aug 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="lfBTSx1k"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1A32C0267;
	Fri, 22 Aug 2025 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855761; cv=none; b=o0gZMn9hgm6l/9MeXcwTqvnEV9/leGOsUVnzkVAQxM9zI0VGaVqCu1vvD0I4+fXywT1Qz9Dm0P8/bbF/o5qnP0g7NYAQoFxOXTFAJwrQyoeLl3QAqQWaFIH87l7HbT6Kg/T/C61rj4/9NMbHdZm8VSeSQRv0s4wz5EuZ6FzBHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855761; c=relaxed/simple;
	bh=5J7ZDWHJOw3DHrTYKkEr3SjzAieYCayrmzq1eWzPVvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRdFtCYsc7b7ddtFvYGLPAfFtQb0NJknueBqD/ztCf0vVWmCYeq6SJDZALr6H6wV706TugPuL/90aXN8we91h5604oAsMALBhkJMn0I0SF8e7PMxRkgY5d0pmdlG5QbKyqon4jk6OggGZl1wI3Nw/OjfKaMnzOIs6gmIi3cdwtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=lfBTSx1k; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=ihFpZK8Kweu8myYJpFk/JCzFIlJuPsYFn1vhCIEfLGM=;
	b=lfBTSx1kHGgbahgmu7uyxhXzEjK2ENgY0l2K9oOt/sRitUvMIAOaMjPc762zAg
	38N0PZDK8KP5tAU2sme1f1qaB+WCp/3AVLk1/fNlKH4iZ/VfCI49wvamYLnPyZg8
	gj38z2SxqvD+LGtpOHwCUZDDrdev56xaSDij0LlCogecI=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBXd5JjO6hoMRQWAw--.62618S3;
	Fri, 22 Aug 2025 17:41:57 +0800 (CST)
Date: Fri, 22 Aug 2025 17:41:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Agner <stefan@agner.ch>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/4] ARM: dts: vfxxx: add arm,num-irq-priority-bits for
 nvic
Message-ID: <aKg7Y0sjZtJpYLT_@dragon>
References: <20250819-vfxxx_warning-v1-0-080930d8e1ea@nxp.com>
 <20250819-vfxxx_warning-v1-4-080930d8e1ea@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-vfxxx_warning-v1-4-080930d8e1ea@nxp.com>
X-CM-TRANSID:M88vCgBXd5JjO6hoMRQWAw--.62618S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWrCw1UXFyrKryxWw4kJFb_yoWkGrcEvw
	4Ig3WrGF4kCFnIqr1UKwn3J3sayw1rArZ7G3409r1UJFyaqayrJ3ZrKayfJrn8CF4UKFZ8
	t3ySqr4Yka4a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbzwZ5UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNwUskWioO2WmGQAA3u

On Tue, Aug 19, 2025 at 03:44:09PM -0400, Frank Li wrote:
> Add arm,num-irq-priority-bits(4) for nvic to fix below CHECK_DTB warnings:
>   arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dtb: interrupt-controller@e000e100 (arm,armv7m-nvic): 'arm,num-irq-priority-bits' is a required property
> 	from schema $id: http://devicetree.org/schemas/interrupt-controller/arm,nvic.yaml#
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm/boot/dts/nxp/vf/vf610m4.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi b/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
> index 2bb331a87721000880cebeb81dd3c00febfbed3c..ccb5deb4e9528fe005a5691347d4a3852fa52ca3 100644
> --- a/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
> +++ b/arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
> @@ -52,6 +52,10 @@ / {
>  	aliases { };
>  };
>  
> +&nvic {
> +	arm,num-irq-priority-bits = <4>;
> +};
> +
>  &mscm_ir {
>  	interrupt-parent = <&nvic>;
>  };

Should probably add it here in name of order.  Fixed it up and applied.

Shawn

> 
> -- 
> 2.34.1
> 


