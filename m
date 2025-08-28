Return-Path: <linux-kernel+bounces-789677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CDAB398F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73E31B288E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51575301017;
	Thu, 28 Aug 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Jpl9V0En"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE52F7477;
	Thu, 28 Aug 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375196; cv=none; b=d0tf8Dc7VAvCg4hnO0Ds1eFU5VgO9aK8q5aQV+UIerGXCzQdccSI8xa4PfEWjXCno19tEYbmhkCjFvYjaQYrF2fEukSCcJDlX4NkUH1Va5T2AGQ+68YZ0hdC3041JJf/e2/ZP18XAzz+UA32/A5SMWjoYwZvXJ15wnA97Qj8jsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375196; c=relaxed/simple;
	bh=9xSK5wQebA1aqy7LgKNxVsJm9NVimwKAsxwFdofUyZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHZy96nPasVFbNkIBs0GNkduS1SbWaoISdBtoaG8LT2RS9XLKGqmbyvaaAuLDTIva2vhCcH2XtztxfENLR1/haH4rSaB+mgHHgQ0oeJ/l+y7leBDGyt8F9Ep6KuLbGrW2ter/iRBERLiY3dUpTrND4jfKpvuWEWKd/k1bxP6imM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Jpl9V0En; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1756375184; bh=9xSK5wQebA1aqy7LgKNxVsJm9NVimwKAsxwFdofUyZo=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Jpl9V0EnXS0hooV4AW2thMQ/BJNtdjxOk3uvnXwwmT4pP1pGH6nas3SOnUVQhucE1
	 tjLA7D1ah1ADClJAPAK5fJfTPdDSf69icB7ShRkI1tJ5/VSREk24HjyIW961hLQhCD
	 6n3CXMohR8IjNRfBFw0bii9/JAIwOvm9CVIDMsYs=
Date: Thu, 28 Aug 2025 11:59:44 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Diederik de Haas <didi.debian@cknow.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH] arm64: dts: rockchip: Add vcc-supply to SPI flash on
 Pinephone Pro
Message-ID: <s4pqhvg542k4d3m4sosnugy5sdnqpw3dabv7cw4o33imvfyxje@yao7oufrhxn6>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Peter Robinson <pbrobinson@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Diederik de Haas <didi.debian@cknow.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250827143501.1646163-1-pbrobinson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827143501.1646163-1-pbrobinson@gmail.com>

On Wed, Aug 27, 2025 at 03:34:58PM +0100, Peter Robinson wrote:
> As documented in the PinephonePro-Schematic-V1.0-20211127.pdf,
> page 11, the SPI Flash's VCC pin is connected to VCC_1V8 power
> source. This fixes the following warning:
> 
>   spi-nor spi1.0: supply vcc not found, using dummy regulator
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Ondřej Jirman <megi@xff.cz>

Thank you,
	o.

> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> index be90e049a302c..24e4365a2e588 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -772,6 +772,7 @@ flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
>  		spi-max-frequency = <10000000>;
> +		vcc-supply = <&vcc_1v8>;
>  	};
>  };
>  
> -- 
> 2.51.0
> 

