Return-Path: <linux-kernel+bounces-774980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9743B2B9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C67B566A08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E02765CC;
	Tue, 19 Aug 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm/NP2yj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124381732;
	Tue, 19 Aug 2025 06:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755586413; cv=none; b=jyp6d8yhdpYNI7vCH2K0j0zqNHR/sreF9NMu27JK92TiAZlm4ogECqdB5HBAaJlOjhozACj2Xp6cHzQvbEBnA9FdJq5brM+jWAjwFBLvVAov7eiEeRssQM1EGK+kj3WPjxhAcV+m7iU3K0WlP7jtRbuuT/mblW9/uHeNiYQ72bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755586413; c=relaxed/simple;
	bh=nNvGWM3qoMMBsmuPBwr8C4k91K4xoltnrESSR01Kk0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMXfz2yDdTGAZ1VZidi3ekFGRJcb3guYpSgDhXXjS4jTOmAmuEY8E8WVrG9gaKlDemBtr7KknY4huE8NXeChXMFvByO3Wa4g1eog5svn+I4YsXT/AdCRvrvk8/edjQ3Kska0wB5mEbXL3FD/2/xf5ia19IxGOpy72433jVXiSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm/NP2yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B86C4CEF1;
	Tue, 19 Aug 2025 06:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755586413;
	bh=nNvGWM3qoMMBsmuPBwr8C4k91K4xoltnrESSR01Kk0Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gm/NP2yj9NkbeGNfmFMAGOYY9+FuGOmMOEw9ynWVlWiMzaztkUqofaaVuxA5eRbM0
	 tPalajFPxSPXwiLHXlGUVsnx7RMYFmjzic0KDEGr0uxlXjI0hJTWEEsxNMyQ3Zfw3V
	 Yjt5/hcv1yEjIuv6LcGwBPHzaBm6FkCShc9SSlkx39IX53vucTgJ/3cDKp4OpSeGCs
	 +lSN+yeMF5mshxwKMRh68F1GEDzK1td2SpbEeA7tzSnJ2xsIUWE6oYnkV7Ovscp3xy
	 FXub+s/U/OpNxdtFB6DXj90Fj/+OUl9Hejtd+NV9CmBOqpwDVChNYT06bK3WcPvZ+r
	 QqhQjuTJTTyww==
Message-ID: <70a41e23-18ce-434e-adca-a44e1d6a90d4@kernel.org>
Date: Tue, 19 Aug 2025 08:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: dts: mediatek: mt8370: add Grinn GenioSBC-510
To: Mateusz Koza <mateusz.koza@grinn-global.com>,
 angelogioacchino.delregno@collabora.com, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com
References: <20250815160837.371592-1-mateusz.koza@grinn-global.com>
 <20250815160837.371592-4-mateusz.koza@grinn-global.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250815160837.371592-4-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 18:08, Mateusz Koza wrote:
> From: Bartosz Bilas <b.bilas@grinn-global.com>
> 
> Add support for Grinn GenioSBC-510. Based on the commit introducing
> support for the Grinn GenioSBC-700, this change adds support for the
> Grinn Genio SBC-510, a single-board computer based on the MediaTek Genio
> 510 SoC.
> 
> The GenioSBC-510 uses the same SoM and SBC base .dtsi files as the
> GenioSBC-700, enabling reuse of the common hardware definitions while
> providing a dedicated DTS for the Genio 510 variant.
> 
> More details about the hardware:
> - https://grinn-global.com/products/grinn-geniosom-510
> - https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc
> 
> Signed-off-by: Mateusz Koza <mateusz.koza@grinn-global.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../mediatek/mt8370-grinn-genio-510-sbc.dts   | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 7383d75d8041..729d786b1236 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk-eth.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk-hdmi.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-grinn-genio-510-sbc.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
> new file mode 100644
> index 000000000000..632e2b35443a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
> @@ -0,0 +1,19 @@
> +/*

We do not take closed source code.

> + * Copyright (C) 2025 Grinn sp. z o.o.
> + * Author: Bartosz Bilas <bartosz.bilas@grinn-global.com>


Best regards,
Krzysztof

