Return-Path: <linux-kernel+bounces-758463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC0B1CF7E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804FD18C4B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B4277CB8;
	Wed,  6 Aug 2025 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6FbtGLu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4976277C98;
	Wed,  6 Aug 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754523740; cv=none; b=CxcKQbFz/ZQLxFyqhZFtFZ0bhzbERiHFmP9olCyPHWY+omacwev3pPmoL+HPG3slPAdkynUgTPYH1XomanGf51C1P1etmnrbrt0KLFV2QxqGpBVm1ElZDXBUsKhedQr5OtYjoVx+Se3fpFsJZb8Grrd/gDm7JEN6RH4VsahRZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754523740; c=relaxed/simple;
	bh=fT+0nxGaI/I9WVL1BF+SKc8auvCNd+sDv/v6lTZlbh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIoCcrgMjnNKdUL8tLvsXXfiaMVzf2CNsRs4tg/Iu8iyVt8Mk/30I4PkrOta4tmLjBX/DJPmW2hOGeng0SbGcX4tgCZbXlYI6t0Hxqal4GsKN3lidGbVpY6jrv2C50k+sDvsvi8924XN5f+b2IRXEHl5a0n2FAmPRLLL5wvr9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6FbtGLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E403C4CEE7;
	Wed,  6 Aug 2025 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754523738;
	bh=fT+0nxGaI/I9WVL1BF+SKc8auvCNd+sDv/v6lTZlbh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6FbtGLuBIsaxm9rAcCORBKES0EYWoX6s/2EZ0HirwpLVzAoXocRpQ7Wf6KdRSriA
	 paPcxDCTqwVX91F3IYgz53wtrEfOW9z/IW7PzbesLbolDRUsuYhMVB5CDklCpG5EYT
	 1JJqcebLBRAwgfPtG6Y4LmxEsT967vKr7bcxp6f1jyAebMl8rBSZD6x2BTBlM9cFv6
	 o20FyeacpZ5sefYTkdcs1EsoW3BjaS0h6KB4D71epHNNQmI9t5cALb2QXrHygOTL4V
	 9axVKctbXg3sUkmkYvSPEOHDN4zZWg6nnuoQmhntZR/1skJXXtVJyl1tuzJvUZuv9x
	 VyUtl+vl/G0DQ==
Date: Wed, 6 Aug 2025 18:42:17 -0500
From: Rob Herring <robh@kernel.org>
To: Pritam Manohar Sutar <pritam.sutar@samsung.com>
Cc: vkoul@kernel.org, kishon@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com,
	andre.draszik@linaro.org, peter.griffin@linaro.org,
	kauschluss@disroot.org, ivo.ivanov.ivanov1@gmail.com,
	igor.belwon@mentallysanemainliners.org, m.szyprowski@samsung.com,
	s.nawrocki@samsung.com, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rosa.pila@samsung.com,
	dev.tailor@samsung.com, faraz.ata@samsung.com,
	muhammed.ali@samsung.com, selvarasu.g@samsung.com
Subject: Re: [PATCH v5 1/6] dt-bindings: phy: samsung,usb3-drd-phy: add
 ExynosAutov920 HS phy compatible
Message-ID: <20250806234217.GA2030512-robh@kernel.org>
References: <20250805115216.3798121-1-pritam.sutar@samsung.com>
 <CGME20250805114306epcas5p37782c02ae0ddc6b77094786c90af247a@epcas5p3.samsung.com>
 <20250805115216.3798121-2-pritam.sutar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805115216.3798121-2-pritam.sutar@samsung.com>

On Tue, Aug 05, 2025 at 05:22:11PM +0530, Pritam Manohar Sutar wrote:
> This SoC has USB2.0 phy and supports only UTMI+ interface. This phy
> requires two clocks, named as "phy" and "ref". The required supplies for
> this phy are vdd075_usb20(0.75v), vdd18_usb20(1.8v), vdd33_usb20(3.3v).
> 
> Add a dedicated compatible string for USB HS phy found in this SoC.
> 
> Signed-off-by: Pritam Manohar Sutar <pritam.sutar@samsung.com>
> ---
>  .../bindings/phy/samsung,usb3-drd-phy.yaml    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> index e906403208c0..1932a2272ef9 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> @@ -34,6 +34,7 @@ properties:
>        - samsung,exynos7870-usbdrd-phy
>        - samsung,exynos850-usbdrd-phy
>        - samsung,exynos990-usbdrd-phy
> +      - samsung,exynosautov920-usbdrd-phy
>  
>    clocks:
>      minItems: 1
> @@ -110,6 +111,12 @@ properties:
>    vddh-usbdp-supply:
>      description: VDDh power supply for the USB DP phy.
>  
> +  dvdd075-usb20-supply:
> +    description: 0.75V power supply for the USB 2.0 phy.
> +
> +  vdd18-usb20-supply:
> +    description: 1.8V power supply for the USB 2.0 phy.
> +
>  required:
>    - compatible
>    - clocks
> @@ -219,6 +226,7 @@ allOf:
>                - samsung,exynos7870-usbdrd-phy
>                - samsung,exynos850-usbdrd-phy
>                - samsung,exynos990-usbdrd-phy
> +              - samsung,exynosautov920-usbdrd-phy
>      then:
>        properties:
>          clocks:
> @@ -235,6 +243,17 @@ allOf:
>  
>          reg-names:
>            maxItems: 1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,exynosautov920-usbdrd-phy
> +    then:
> +      required:
> +        - dvdd075-usb20-supply
> +        - vdd18-usb20-supply
> +        - vdd33-usb20-supply

Presumably the existing devices don't have these new supplies, so:

else:
  properties:
    dvdd075-usb20-supply: false
    vdd18-usb20-supply: false


