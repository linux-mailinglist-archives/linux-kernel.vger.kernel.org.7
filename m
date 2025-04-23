Return-Path: <linux-kernel+bounces-616201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B5A9890D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 14:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32EA188EA97
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1C1FAC48;
	Wed, 23 Apr 2025 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BicpC+SW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC231C5D59;
	Wed, 23 Apr 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409729; cv=none; b=SRC0Z0Q2bg+SBmtDLaiNAzieBt9Yew5RS6RO4IBTdVYSUUocbGXcRLakH2O447/cr0yTLTGoSto8AjU52qYlyQ29BjR+VbLHCVtokiA9XKzejJXYnPl/N3fsSHKPDNXsgLawPn2/Ylg6AQMIQjyNO3owmWME5CLhAWvpf8sygaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409729; c=relaxed/simple;
	bh=0nzwQLtEHyNu/7/CKM0ZVwpRTIEm+zb35CC9woF3LVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrX4937h35VAqGYzboOLpwjL47O4nKfyjPO0ao7x647QS9Nrj8oeARe9lSKUKOGm8IbZb7nL0nfForaEkC8UaBdYFhs3VMctJF4Yx/GjZ/rwRO9iMIkh29jl2AbcR3Mk4j15gBzspbY0+5FvYaWoiwGNqtr2sKHRqWyUc6cAa/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BicpC+SW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1161C4CEE2;
	Wed, 23 Apr 2025 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745409728;
	bh=0nzwQLtEHyNu/7/CKM0ZVwpRTIEm+zb35CC9woF3LVg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BicpC+SW6jsQVvZDY4P3/K1ZYD9yv3Nb4aVjxvOzhdalNeiPLXe1GYUMz2cUW4V/z
	 nEMLfVF1MhN8J28ogaxUKxwp1hJobsFpeXE8PptO5g/8OdWTYmJnf5HTeeRfLb0klY
	 C/rJBtHzMZLdpuW3XBFM7c7rfA5ZQpG30CpBZAjBcRayerhFPHdCN3imsND1POPALU
	 iQLy75pwgeThzmanfZ4fApIjkefjJa3zaNh92R84awnvCkPpIcw2sJ4apntKN+BzMc
	 MuB2kONuwsMuHgJfnV58GfXyh6g1Fv7enE1Uw5Ia8e2NAD9qrdUIqs7wwhg6O73VZM
	 c66Xk24JswzBg==
Message-ID: <7988146f-cbc0-465b-af3b-b16562e163ce@kernel.org>
Date: Wed, 23 Apr 2025 14:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] arm64: dts: mediatek: Add MT8186 Ponyta
 Chromebooks
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>,
 sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
 dianders@google.com, hsinyi@google.com,
 angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 knoxchiou@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20250423093647.4074135-1-cengjianeng@huaqin.corp-partner.google.com>
 <20250423093647.4074135-3-cengjianeng@huaqin.corp-partner.google.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@kernel.org>
In-Reply-To: <20250423093647.4074135-3-cengjianeng@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2025 11:36, Jianeng Ceng wrote:
> MT8186 ponyta, known as huaqin custom label, is a
> MT8186 based laptop. It is based on the "corsola" design.
> It includes LTE, touchpad combinations.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> Changes in v10:
> - No change.
> 
> Changes in v9:
> - PATCH 2/2: Add sound model to fix the warning.
> - Link to v8:https://lore.kernel.org/all/20240914063122.1622196-3-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v8:
> - PATCH 2/2: Change the commit about ponyta.
> - Link to v7:https://lore.kernel.org/all/20240913031505.372868-3-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v7:
> - PATCH 2/2: Remove prototype sku.
> - PATCH 2/2: Disable the other trackpad to enable one of them.
> - Link to v5:https://lore.kernel.org/all/20240909023148.1677936-3-cengjianeng@huaqin.corp-partner.google.com/
> 
> Changes in v6:
> - No change.
> 
> Changes in v5:
> - PATCH 2/2: Remove sku2147483647.
> - Link to v4:https://lore.kernel.org/all/20240906085739.1322676-3-cengjianeng@huaqin.corp-partner.google.com/
> 
> Chage since v3:
> - No change.
> 
> Changes in v2:
> - PATCH 2/2: Modify the dtb name without rev2.
> - Link to v1:https://lore.kernel.org/all/20240902125502.1844374-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |  2 +
>   .../mediatek/mt8186-corsola-ponyta-sku0.dts   | 18 +++++++
>   .../mediatek/mt8186-corsola-ponyta-sku1.dts   | 22 +++++++++
>   .../dts/mediatek/mt8186-corsola-ponyta.dtsi   | 49 +++++++++++++++++++
>   4 files changed, 91 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 58484e830063..3aa06476c6c0 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -64,6 +64,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-chinchou-sku16.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393216.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393217.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-magneton-sku393218.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-ponyta-sku0.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-ponyta-sku1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-rusty-sku196608.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-starmie-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-starmie-sku1.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
> new file mode 100644
> index 000000000000..986498af4c70
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku0.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-ponyta.dtsi"
> +
> +/ {
> +	model = "Google Ponyta sku0 board";
> +	compatible = "google,ponyta-sku0", "google,ponyta", "mediatek,mt8186";
> +};
> +
> +&i2c2 {
> +	trackpad@15 {
> +		status = "disabled";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
> new file mode 100644
> index 000000000000..ff5eea0ddeb4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-sku1.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-ponyta.dtsi"
> +
> +/ {
> +	model = "Google Ponyta sku1 board";
> +	compatible = "google,ponyta-sku1", "google,ponyta", "mediatek,mt8186";
> +};
> +
> +&i2c2 {
> +	trackpad@2c {
> +		status = "disabled";
> +	};
> +};
> +
> +&usb_c1 {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
> new file mode 100644
> index 000000000000..0abf69077089
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta.dtsi
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-steelix.dtsi"
> +
> +&keyboard_controller {
> +	function-row-physmap = <
> +		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
> +		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
> +		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
> +		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
> +		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
> +		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
> +		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
> +		MATRIX_KEY(0x00, 0x04, 0)	/* T8 */
> +		MATRIX_KEY(0x00, 0x01, 0)	/* T9 */
> +		MATRIX_KEY(0x02, 0x09, 0)	/* T10 */
> +		MATRIX_KEY(0x01, 0x09, 0)	/* T11 */
> +		MATRIX_KEY(0x01, 0x05, 0)	/* T12 */
> +	>;
> +
> +	linux,keymap = <
> +		CROS_STD_MAIN_KEYMAP
> +		MATRIX_KEY(0x00, 0x02, KEY_BACK)
> +		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> +		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> +		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> +		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> +		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> +		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> +		MATRIX_KEY(0x00, 0x04, KEY_PLAYPAUSE)
> +		MATRIX_KEY(0x00, 0x01, KEY_MICMUTE)
> +		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x01, 0x05, KEY_VOLUMEUP)
> +	>;
> +};
> +
> +&mt6366codec {
> +	mediatek,dmic-mode = <1>; /* one-wire */
> +};
> +
> +&sound {
> +	model = "mt8186_rt1019_rt5682s";
> +};
> +


