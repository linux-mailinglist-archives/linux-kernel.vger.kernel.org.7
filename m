Return-Path: <linux-kernel+bounces-852722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E2BD9BB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF06188BB81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A93148D8;
	Tue, 14 Oct 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0subUQT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467313148A2;
	Tue, 14 Oct 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448430; cv=none; b=ChbnQ4tffTzr47a+M/y6jO99t81kjU/GBU5ICga5xu6jTOvRlxEL3xCsYPZz7QnwgJzM9ScjbY4s17GQw1VRcNHKFJBZsKGXb+u88X6ppx4AXgjL+JjDM/VyUDkt7tM29JpyuwCvpRkQodDEIZrpyg5ifIsM1Z0wMlpujMlkH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448430; c=relaxed/simple;
	bh=URTgDDEhtyvhh20SZd95qIetjf6RT09dnrFHc1mT5yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFmtdvL5douRLmcp6QyIsvfnivQVi1BGz5t3JqjsvOuq8vP7ILWGhoFp2d3y19uBU+wiEbBOhv0OVmkYmm6Z+A9cTUBDH2ey3CBv2PJupw16IX+LNZrHHIbykpoYyxCVfAY/Vt2wp0kuIvCB97sokGW4p6aeVY8wyP7R6L2/tIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R0subUQT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760448426;
	bh=URTgDDEhtyvhh20SZd95qIetjf6RT09dnrFHc1mT5yY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R0subUQTKkUjsYFUrp4t9i7bjvtPMdoSjRRftGhYs4pDdiLtrzSdydUFADaj6iRQg
	 Jx5aGaobFBEk5a82pwyyfUmMAxeVKGZk1zFj06FxkpTTGYbxTtqy+LTS3VIv26DYe5
	 UNrP4QKwD96LFbyrljtNX+kSoP3LESCK5qCaY3D/8r3SPRvrZfakj+5gvh3/vpBMsZ
	 nyX2JSvj5t1uPF+OssXbdwtZ6DA1aivsWC+SbimzN06wKhA7ltbGe4b+xUxSBvcsB0
	 VFzifRvqTsLzpZ4NMoDLOG/qE6rLi1nvGh9ePTh6oVrz5HR6NWIDrgSq36StT1LFqk
	 J3o3rNaBxnXZQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3230017E129E;
	Tue, 14 Oct 2025 15:27:06 +0200 (CEST)
Message-ID: <b20a1c7d-0da5-433b-987c-f55a5a229bed@collabora.com>
Date: Tue, 14 Oct 2025 15:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8188-geralt: Enable first SCP
 core
To: Chen-Yu Tsai <wenst@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Fei Shao <fshao@chromium.org>
References: <20250814092510.211672-1-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250814092510.211672-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/08/25 11:25, Chen-Yu Tsai ha scritto:
> The first SCP core is used to drive the video decoder and encoders.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Added SCP vreq pin
> ---
>   .../boot/dts/mediatek/mt8188-geralt.dtsi      | 25 +++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> index c5254ae0bb99..7fedbacdac44 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
> @@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
>   		#size-cells = <2>;
>   		ranges;
>   
> +		scp_mem_reserved: memory@50000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x800000>;
> +			no-map;
> +		};
> +
>   		apu_mem: memory@55000000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0 0x55000000 0 0x1400000>;
> @@ -1077,6 +1083,13 @@ pins-bus {
>   		};
>   	};
>   
> +	scp_pins: scp-pins {
> +		pins-scp-vreq {
> +			pinmux = <PINMUX_GPIO98__FUNC_O_SCP_VREQ_VAO>;
> +			bias-disable;
> +		};
> +	};
> +
>   	spi0_pins: spi0-pins {
>   		pins-bus {
>   			pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
> @@ -1146,6 +1159,18 @@ &postmask0_out {
>   	remote-endpoint = <&dither0_in>;
>   };
>   
> +&scp_cluster {
> +	status = "okay";
> +};
> +
> +&scp_c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&scp_pins>;
> +	firmware-name = "mediatek/mt8188/scp.img";

After a (very brief) discussion with Arnd last time, turns out we decided to avoid
using the firmware-name property, including for mtk-scp.

Please resend without firmware-name.

P.S.: there's a patch to construct the firmware name from compatible...
https://lore.kernel.org/r/20250911140043.190801-1-angelogioacchino.delregno@collabora.com

Cheers,
Angelo

> +	memory-region = <&scp_mem_reserved>;
> +	status = "okay";
> +};
> +
>   &sound {
>   	pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
>   			"aud_etdm_spk_on", "aud_etdm_spk_off",



