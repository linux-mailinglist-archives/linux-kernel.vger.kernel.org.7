Return-Path: <linux-kernel+bounces-807490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F24B4A50E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427E517F86D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF62571B0;
	Tue,  9 Sep 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nfw/gdGm"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC94125228D;
	Tue,  9 Sep 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757405993; cv=none; b=g/W1WByBoAhB7Gm7nLOWYACfVz8QnSx22u/fIWazy3hc8oMF/bL/iZblAUbZOT6naJDPKy4AQcxQl/rhfMjxhWV/fEDUvluXluXdn4XGPfREBEdfTGg3f648eskHpGc8DuC4Wrc/KEw+2weaT2j/XFNrrljFqZfN0uA1A2ilB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757405993; c=relaxed/simple;
	bh=HVUELbkcCN9P76zTicA7v/0JvpS5yYl/jJytu3IqKGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnymSsyfLYCkGMCHOCwB+Mw3aQyxQNRsRxbSlpjOuhXXKpRS64IKsH0fqEKFa+Pp5mE6JE3pqWkQtJ56otyjNRwePFq6G9LmcuFSIMsSNJzypLqvyQRO81BokD4dZTtYP/PjDQRLiENqdBtChkgw6yKcb3znV0K/FDxW8e+d2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nfw/gdGm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757405990;
	bh=HVUELbkcCN9P76zTicA7v/0JvpS5yYl/jJytu3IqKGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfw/gdGmjD8WdJvetZCa7Vffpn6q7fwX1qeKa8BkDI4k+NJ1l84oDzlT9wsw8sLAz
	 chURDmMq/NIkvKZlPh6hhmb6bEIlWw+7t/iqpQyz8Bebt9F3uUq95x1h2xUjD7ujR6
	 yDg2eiQmM75dCpGCBmw1NWkS37pnoFrx14isPlUHfS2PlHRpU0OWuGB9XSVcIqBR07
	 Xa2M+aEdqJW3tbf577hC3X2xyYwEvNFtNg1hbjxAwZtmmM8Q2Wzi0f9J+2tFBf1S8x
	 EilPHWMrFM2063KX84yWS6AxhBhktCmhjmz38NnVV0rzbOlbovOhZtpkpFE3+6WJSd
	 LaT5fRL3/v3gA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86B6717E1273;
	Tue,  9 Sep 2025 10:19:49 +0200 (CEST)
Message-ID: <124530e7-0b6a-488f-93f1-14505a1bfae8@collabora.com>
Date: Tue, 9 Sep 2025 10:19:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm64: dts: mediatek: mt8370-grinn-genio-510-sbc:
 Add Grinn GenioSBC-510
To: Mateusz Koza <mateusz.koza@grinn-global.com>, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 marcin.czarnecki@grinn-global.com, b.bilas@grinn-global.com, andrew@lunn.ch
References: <20250908130620.2309399-1-mateusz.koza@grinn-global.com>
 <20250908130620.2309399-4-mateusz.koza@grinn-global.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250908130620.2309399-4-mateusz.koza@grinn-global.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/09/25 15:05, Mateusz Koza ha scritto:
> From: Bartosz Bilas <b.bilas@grinn-global.com>
> 
> Add support for Grinn GenioSBC-510. Based on the commit introducing
> support for the Grinn GenioSBC-700, this change adds support for the
> Grinn GenioSBC-510, a single-board computer based on the MediaTek Genio
> 510 SoC.
> 
> More details about the hardware:
> - https://grinn-global.com/products/grinn-geniosom-510
> - https://grinn-global.com/products/grinn-genioboard-edge-ai-sbc
> 
> Signed-off-by: Bartosz Bilas <b.bilas@grinn-global.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>   .../mediatek/mt8370-grinn-genio-510-sbc.dts   | 19 +++++++++++++++++++
>   2 files changed, 20 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index b37a8c65e724..4b8ee6970f40 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -99,6 +99,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-grinn-genio-510-sbc.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-grinn-genio-700-sbc.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
> new file mode 100644
> index 000000000000..117ea694cda3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8370-grinn-genio-510-sbc.dts
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2025 Grinn sp. z o.o.
> + * Author: Bartosz Bilas <bartosz.bilas@grinn-global.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8370.dtsi"
> +#include "mt8390-grinn-genio-som.dtsi"
> +#include "mt8390-grinn-genio-sbc.dtsi"
> +
> +/ {
> +	model = "Grinn GenioSBC-510";
> +	compatible = "grinn,genio-510-sbc", "mediatek,mt8370", "mediatek,mt8188";

only because you have to anyway send a v5.... blank line here please

after which
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 1 0x00000000>;
> +	};
> +};



