Return-Path: <linux-kernel+bounces-795725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55CB3F71A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858D81A86124
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA462E7BAD;
	Tue,  2 Sep 2025 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+9aQw9u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F002DF158;
	Tue,  2 Sep 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799657; cv=none; b=T3MFVPL27VBhDxtev4pZ0CCb3Kcg8/h76Y3cYC4ZWIR1p4n65GLkyHV9GCItjFgkAZlXpO0ZJJaNUCw+K8oyq8ZwaOtpmn1QFXKwrTsbcmPpn7LspaCwjtfRKEnll3C62OzT6W7VwUbYEgI3TU1DgUyE3cBT6VzxqUjh8OCMLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799657; c=relaxed/simple;
	bh=3nc/wkBY2bIc1bkSOsEmjMvNtgdGFa44cp61YSHyt68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sn+cxgaP8vQH1pRRlNdq05JGfT2HyjXcMAyMnkyP5VlLqPxtJ9zYJnc5DwRmin5vLbUnHjLztleE5KadZvlYFVpevHvHVdwNkBk7kNdLysWXAgw5h3EwHNxbxbHzbOZQWnW9SzrCn8FBA2amPLi9FrRH/XGgbAxdlXH+/f6eVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+9aQw9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDD7C4CEF7;
	Tue,  2 Sep 2025 07:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756799654;
	bh=3nc/wkBY2bIc1bkSOsEmjMvNtgdGFa44cp61YSHyt68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+9aQw9ulXkFfxweHD0usIU9tUka6m/saOX7lfURvNS73/s+vZUjXpPiwvIF0aPs9
	 kMLLegURfcv+TrpfzoGri1z3EELyoDPZTwLlumruzT4Fg+71EWCh3/KqtjQM+nO+5O
	 WA39kPdE4IiGiY/L1BCXWnJ6etZuDIqW3nZ27GXvyUGBAjbKtYmDWY02Lj+OteWC/+
	 UTmSurQWJz12coiGLFdRx21aeS1Zu61/y8B5sgauy4bW/kXhH6rf5GliYRFALACxP7
	 gWN+LYta+UqsP667bGMEMOzWMGDIofIa1g12JVsHTsdlx2kpD/IO9C6Ps14ZUVIiSC
	 UztVm3kqf4aCA==
Date: Tue, 2 Sep 2025 09:54:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michael Riesch <michael.riesch@collabora.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@amarulasolutions.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Collabora Kernel Team <kernel@collabora.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	stable@kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make
 power-domains non-required
Message-ID: <20250902-diligent-satisfied-oxpecker-10ea0e@kuoka>
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
 <20250616-rk3588-csi-dphy-v3-2-a5ccd5f1f438@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616-rk3588-csi-dphy-v3-2-a5ccd5f1f438@collabora.com>

On Mon, Sep 01, 2025 at 10:47:43PM +0200, Michael Riesch wrote:
> There are variants of the Rockchip Innosilicon CSI DPHY (e.g., the RK3568
> variant) that are powered on by default as they are part of the ALIVE power
> domain.
> Remove 'power-domains' from the required properties in order to avoid false
> negatives.
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

Please move it after required: block.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


