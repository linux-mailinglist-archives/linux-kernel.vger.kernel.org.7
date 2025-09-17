Return-Path: <linux-kernel+bounces-820316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47EB7E57A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D3B4E5E54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087B3074BA;
	Wed, 17 Sep 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HuBjnmo5"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B1306B09;
	Wed, 17 Sep 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099978; cv=none; b=DG2d+DYgIFv5Dj63FXJ1w+y51WYnhFrFKw6Rg/VxV1DVQ7b8Y61OM2lgrGAFmPqArgxgvlvAKy3huJhuL17HKHAA7zUljgCz8b4BX9r/wgRAQLsI/3n6LEfb8+GaPHDn9W6sqKEAJifprQiwDM4KyN0ZyJ0zU+7iKEoY0luyKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099978; c=relaxed/simple;
	bh=uysw1dHCz2WslwLQVyxUkMNdtoTDG8ekcBjPK/8bbwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bjHAHnRMrB8RZiuxJaWWKiz/nEPgNL+bo6XmD3VpDe74vhS0nZVpG7VsV8IExefKxlaLU7HUpAS8LiIJuEaj5xi/GPgvttQUJtD6RiSgCp53RAIAvRMQ6RUvJarurz0vqi5MJBvJb00CkBa/Kdhw9t1mU37K+WRpqENjUIHWroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HuBjnmo5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758099974;
	bh=uysw1dHCz2WslwLQVyxUkMNdtoTDG8ekcBjPK/8bbwU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=HuBjnmo5S5KOiTh4tR8/9rfTE7/gh2nfoH91h2NwGzJCfJwBUE1Jz6zRUhljdJjA0
	 yUNLVn0wL0+hM68nwAbRUVyeA6ORBMJKcEV8oyHt7FBxGYUsBzrzRrSQB+6IZS4LYX
	 guY94nP+L4oovufloOu6nT+ArGQVBbTwtjPiY7xvYKzfwqn2L64VLH7K6ggN0N7SHR
	 KcpeUY5d3VtdmDB+79+HNCtFip33Vv+HRdDpt5cmJ4WARce7JgthF621vq2q8Q527J
	 iS3Yv8TOsGH2t30qlt/KVZ3zFcBNJ6hE0pDCqejZ856ZfIZ428u7eE/W4DMf9o8/W9
	 9inEpA0MNHK5A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A6E0D17E124A;
	Wed, 17 Sep 2025 11:06:13 +0200 (CEST)
Message-ID: <87179c9f-cc7f-446f-9e8d-c84bddb48660@collabora.com>
Date: Wed, 17 Sep 2025 11:06:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt7622: add 'serial' cell to
 efuse
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <18af6977cc34de75e64279141dee69dcbc81c420.1758063737.git.daniel@makrotopia.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <18af6977cc34de75e64279141dee69dcbc81c420.1758063737.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 01:05, Daniel Golle ha scritto:
> The efuse of the MediaTek MT7622 contains an 8-byte unique identifier.
> Add a 'serial' cell covering those 8 bytes to the nvmem defininition of
> the efuse to allow easy access from userspace, eg. to generate a
> persistent random MAC address on boards like the BananaPi R64 which
> doesn't have any factory-assigned addresses.

Sorry, but I don't get why this is named "serial" and not "soc-uuid".

Care to explain?

Cheers,
Angelo

> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 917fa39a74f8..0b9803a183b9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -278,6 +278,10 @@ efuse: efuse@10206000 {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   
> +		serial@140 {
> +			reg = <0x140 0x8>;
> +		};
> +
>   		thermal_calibration: calib@198 {
>   			reg = <0x198 0xc>;
>   		};



