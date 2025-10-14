Return-Path: <linux-kernel+bounces-852706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2E1BD9B36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C536F189E30A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0225E314A8E;
	Tue, 14 Oct 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="epsDhhe/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4632FF143;
	Tue, 14 Oct 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447917; cv=none; b=tyXhg5dLV0+tUG2RJf+2lB+wfKpr53azaaYjMDXIY4dTbXlF535pnB2+UkU/+Tarbya+0PJBA+svpphuj30Ww6jX0dy3fZaqjJLFxvzvTxLftA3/W4jSOg6kaoCg5bUbNr5LZJWWVuOZqSrYZMJEc9X9ZJRrCBdTtzkBffTYtiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447917; c=relaxed/simple;
	bh=N9CPJhNcpyyh4sczYatDI6/r/7qpIp3TR5G111HRq78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZtxx8jhRhkWrEWpT6yixvq4/Jmds0mToAM2aMCTRVbTlCfM7mEAdeRYNiBJncJxAlsg5T9jIJn4TE9ziWkYOEE69C04TW7tGsS0dF795tqH8DNIB05670UxutMveSe3hp4qAwkatxE1xMpLNxv/x8mwRtdHlQ2zcq98V61VkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=epsDhhe/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760447913;
	bh=N9CPJhNcpyyh4sczYatDI6/r/7qpIp3TR5G111HRq78=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=epsDhhe/mwkwONk0kXV9Zj2RKIc2TCEiXIkdiwvQx+ULEB69paBU3kQDB2yujqJpk
	 1zGXChqrS+4IpngqHl2POYI9O6e6qOtzyVanhODNoEUaOIoYPYrtiDO/vWTHEPdOkg
	 4wfqYLjlbDo4+Yud8dQn/pxbkQjw/fBWZ01ekg2e2eWgWovoXCtqh3kigNuy+wtiBR
	 pFkoiTfF3iNFz6tmEsLI0L6z14oejco+dCYPRIQYcFBWjNAmwWZ2f2YZvJqFoYbrwI
	 66b1hy7ZlsC2Ubn9TrfsjA5ZVUNbI1UjUZkiCtiL+4Eu3sswJZ5lzeXrUru3iLITge
	 2k0jF7MfNstfw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3496117E12DF;
	Tue, 14 Oct 2025 15:18:33 +0200 (CEST)
Message-ID: <c29a4ea7-34fd-44bf-bb32-a7a96bf0e04e@collabora.com>
Date: Tue, 14 Oct 2025 15:18:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: mediatek: mt8365: Add GPU support
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20250813-mt8365-enable-gpu-v1-0-46c44c6c1566@collabora.com>
 <20250813-mt8365-enable-gpu-v1-2-46c44c6c1566@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250813-mt8365-enable-gpu-v1-2-46c44c6c1566@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/08/25 11:25, Louis-Alexis Eyraud ha scritto:
> The Mediatek MT8365 SoC has an integrated Arm Mali G52 MC1 GPU
> (Bifrost).
> Add gpu, OPP table, and MFG clock driver nodes in mt8365.dtsi to support
> it using the Panfrost driver.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 41 +++++++++++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index e6d2b3221a3b7a855129258b379ae4bc2fd05449..6a7b4f58918b22f51b792f3a99bd777acf72df9d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -267,6 +267,24 @@ clk26m: oscillator {
>   		clock-output-names = "clk26m";
>   	};
>   
> +	gpu_opp_table: opp-table-gpu {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-450000000 {
> +			opp-hz = /bits/ 64 <450000000>;
> +			opp-microvolt = <650000>;
> +		};

Blank line between OPP nodes, please.

};

opp-560000000 {
	...
};

opp-800000000

otherwise,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +		opp-560000000 {
> +			opp-hz = /bits/ 64 <560000000>;
> +			opp-microvolt = <700000>;
> +		};
> +		opp-800000000 {
> +			opp-hz = /bits/ 64 <800000000>;
> +			opp-microvolt = <800000>;
> +		};
> +	};
> +

