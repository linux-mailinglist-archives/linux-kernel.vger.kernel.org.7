Return-Path: <linux-kernel+bounces-854051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B1BDD6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BA7E356ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42573016EA;
	Wed, 15 Oct 2025 08:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jY0a7noL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A97301702;
	Wed, 15 Oct 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517120; cv=none; b=UVbtYeM3WwkUZnVe/5If7fBaVWtJJ4wzw5I4PIZNt2W9mOjADWLjmzNT7cr2fcnGxXR3aYYmfyeBd00UnvZxGxI4RI3WHWGFaKdApXZ/gmRn664uhAp2u0ZulIVWV3cDlAjLlnTvfIAzTD5aFhsIhzJMPx+uwLssiT9ojxvEOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517120; c=relaxed/simple;
	bh=LHvokEjTG+iDmfz8a8WfH/PVU55uP938bDrAF617h6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLX7Bg9evAspKbroWMg7z0ATJsRPLImEOrQGpXb1lGLSYnFUwguK2O+zHaYlOVFARO6VsQXasvZCghBO9KFUGXfUossRDN/OtZkB0pFNc0nMvT16U81/EDEGgXMxM/aT5f8SSI0SxA975TyHMsCHzsgQUvV97iVnqqBUNErV3c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jY0a7noL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760517116;
	bh=LHvokEjTG+iDmfz8a8WfH/PVU55uP938bDrAF617h6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jY0a7noLy0Ijmfc07CX9yvvjDHr2vYhPF3q8f6Aha3qmLYOxBY6vIrMInS8LyZeES
	 izl/cj/MvnDWiStvIciy/WJhbwNmZ6XqpiRQkfF94+/V7AieqHP0BuhI0BYzMbTdZz
	 8a/D/cCkjP3L5dHAI265xVfDYQI/6L7f2qsPzV/je7U8jNe5Rkk3D1202aygwPA4X5
	 M4E2/DEuZgpXL6Qj4tbxFfjH2hTG9CfenYzj/7dpzjHQhirDz5WZJoKToToEXn3ZJ2
	 hBcXz6xssGykPw6nhIPtNRuRjsl/209YZLJrk0rzKuTH7GIyR/wS2M9+FG/XJXpy8w
	 pCNlIVNOtiUGA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 076EE17E00A3;
	Wed, 15 Oct 2025 10:31:55 +0200 (CEST)
Message-ID: <f613c223-a2ae-4092-8361-0396ace8df99@collabora.com>
Date: Wed, 15 Oct 2025 10:31:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8188-geralt: Enable first SCP
 core
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Fei Shao <fshao@chromium.org>
References: <20250814092510.211672-1-wenst@chromium.org>
 <b20a1c7d-0da5-433b-987c-f55a5a229bed@collabora.com>
 <CAGXv+5EPd5hLSNTFYkBWPCL1Bq4CJN4R7v5ZWtoRMYSi9+TeCA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGXv+5EPd5hLSNTFYkBWPCL1Bq4CJN4R7v5ZWtoRMYSi9+TeCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 15/10/25 09:31, Chen-Yu Tsai ha scritto:
> On Tue, Oct 14, 2025 at 9:27 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 14/08/25 11:25, Chen-Yu Tsai ha scritto:
>>> The first SCP core is used to drive the video decoder and encoders.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>> Changes since v1:
>>> - Added SCP vreq pin
>>> ---
>>>    .../boot/dts/mediatek/mt8188-geralt.dtsi      | 25 +++++++++++++++++++
>>>    1 file changed, 25 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
>>> index c5254ae0bb99..7fedbacdac44 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8188-geralt.dtsi
>>> @@ -164,6 +164,12 @@ reserved_memory: reserved-memory {
>>>                #size-cells = <2>;
>>>                ranges;
>>>
>>> +             scp_mem_reserved: memory@50000000 {
>>> +                     compatible = "shared-dma-pool";
>>> +                     reg = <0 0x50000000 0 0x800000>;
>>> +                     no-map;
>>> +             };
>>> +
>>>                apu_mem: memory@55000000 {
>>>                        compatible = "shared-dma-pool";
>>>                        reg = <0 0x55000000 0 0x1400000>;
>>> @@ -1077,6 +1083,13 @@ pins-bus {
>>>                };
>>>        };
>>>
>>> +     scp_pins: scp-pins {
>>> +             pins-scp-vreq {
>>> +                     pinmux = <PINMUX_GPIO98__FUNC_O_SCP_VREQ_VAO>;
>>> +                     bias-disable;
>>> +             };
>>> +     };
>>> +
>>>        spi0_pins: spi0-pins {
>>>                pins-bus {
>>>                        pinmux = <PINMUX_GPIO69__FUNC_O_SPIM0_CSB>,
>>> @@ -1146,6 +1159,18 @@ &postmask0_out {
>>>        remote-endpoint = <&dither0_in>;
>>>    };
>>>
>>> +&scp_cluster {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&scp_c0 {
>>> +     pinctrl-names = "default";
>>> +     pinctrl-0 = <&scp_pins>;
>>> +     firmware-name = "mediatek/mt8188/scp.img";
>>
>> After a (very brief) discussion with Arnd last time, turns out we decided to avoid
>> using the firmware-name property, including for mtk-scp.
>>
>> Please resend without firmware-name.
>>
>> P.S.: there's a patch to construct the firmware name from compatible...
>> https://lore.kernel.org/r/20250911140043.190801-1-angelogioacchino.delregno@collabora.com
> 
> I'm aware of the patch, but did that get merged?

Not yet.

 >> If not then this would
> cause it to default to just /lib/firmware/scp.img?

Yes... but there's no way around it, we can't add firmware-name to devicetrees.

> 
> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> +     memory-region = <&scp_mem_reserved>;
>>> +     status = "okay";
>>> +};
>>> +
>>>    &sound {
>>>        pinctrl-names = "aud_etdm_hp_on", "aud_etdm_hp_off",
>>>                        "aud_etdm_spk_on", "aud_etdm_spk_off",
>>
>>



