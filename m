Return-Path: <linux-kernel+bounces-795342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37944B3F04F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9E41A88646
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD9258CF8;
	Mon,  1 Sep 2025 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NTP8AcTY"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC232F75A;
	Mon,  1 Sep 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760869; cv=none; b=X22owJYL4XQW2GE8g792ThbJZMsOVhudI22chY1A2uilGLRJVf/ukn3rhVCWJ+BOKirnv/4Lnbu+0kASJPFniy4arS+183BTo1QlZSY/W6cRR+vPxNuj8h3TSlhzBNKHUz4xXg+HSJUy8WP3HKpO3Xd6obD5gKegun/RLtWkfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760869; c=relaxed/simple;
	bh=qPRtxQcOv7SHEQCFT+3OtO4MS+BAFz/O7B1+yNl/PBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLgR6X5NYnyGm1WSXHnbe7HS8urd6CWwPVXn5avaRuFVEI1DrqBQBkcJJ4lVQa/f2IG96wc794CPcyD6Wlnow8gE/tZPQ8HurrbYGmRwBGhRCIzkCYoN3eYENNQpT+eM6DYt5SJJ204eeMkIRsljy5L1Jlfxa3r32M83bFW7URc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NTP8AcTY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756760865;
	bh=qPRtxQcOv7SHEQCFT+3OtO4MS+BAFz/O7B1+yNl/PBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NTP8AcTYCe4f720CUB9THkJ3CHAoqNADaCIFvZV0cN5fz4XyViYe2PWquQeeGMW2R
	 cW6PnJZRbbOiYL29NlULlXS/t9/1SHDmrpKWnFJ3SDcYn6mOX48sr0Rx9g2/ivyUuQ
	 Y0Zm1szOCQ5yruo8DJ5temI/TLLORwXWHvwtUit0A2qa6ZxeotXSd4bDT4AviNAXMr
	 NgPQBU9DkwijHL4W6dCdCPcOck8wzEV8kgbvk4F+3tlk9t6wUle11QknE8v9Z/MP4M
	 pbkzMsdiJOKwzVRwbwvz4srmcGuTY+ot2X2C73QYd7C/E+0hTotUFqRTv7g7Bny/uo
	 FDW7zWQ0xq52A==
Received: from [10.40.0.100] (185-251-200-65.lampert.tv [185.251.200.65])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mriesch)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A3F2717E1062;
	Mon,  1 Sep 2025 23:07:44 +0200 (CEST)
Message-ID: <f7ab5662-b813-4d60-80f0-d5bfc91b107f@collabora.com>
Date: Mon, 1 Sep 2025 23:07:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make
 power-domains non-required
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Collabora Kernel Team <kernel@collabora.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, stable@kernel.org
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
 <20250616-rk3588-csi-dphy-v3-2-a5ccd5f1f438@collabora.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@collabora.com>
In-Reply-To: <20250616-rk3588-csi-dphy-v3-2-a5ccd5f1f438@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

On 9/1/25 22:47, Michael Riesch via B4 Relay wrote:
> From: Michael Riesch <michael.riesch@collabora.com>
> 
> There are variants of the Rockchip Innosilicon CSI DPHY (e.g., the RK3568
> variant) that are powered on by default as they are part of the ALIVE power
> domain.
> Remove 'power-domains' from the required properties in order to avoid false
> negatives.

Grmbl, forgot to fix that for the second time. Should be "false
positives", of course *facepalm*.

Just a note to myself for any v4.

Best regards,
Michael


> 
> Fixes: 22c8e0a69b7f ("dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy")
> Cc: stable@kernel.org
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>  .../devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml   | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> index 5ac994b3c0aa..9ad72518e6da 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> @@ -51,13 +51,26 @@ properties:
>      description:
>        Some additional phy settings are access through GRF regs.
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rockchip,px30-csi-dphy
> +              - rockchip,rk1808-csi-dphy
> +              - rockchip,rk3326-csi-dphy
> +              - rockchip,rk3368-csi-dphy
> +    then:
> +      required:
> +        - power-domains
> +
>  required:
>    - compatible
>    - reg
>    - clocks
>    - clock-names
>    - '#phy-cells'
> -  - power-domains
>    - resets
>    - reset-names
>    - rockchip,grf
> 


