Return-Path: <linux-kernel+bounces-795727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD0B3F722
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8602066D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8172E7F00;
	Tue,  2 Sep 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOkBWf+s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FD2E7BCE;
	Tue,  2 Sep 2025 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799752; cv=none; b=KLUTlIiEi8IV2RuvOlqSdIZgC4QrQPtTN4d4BMhVRY45/kWVWDfg7EWtdrzPuxRH7rh9vsIf5Fo0GtbCLklc+y1gFSiwFaJEx/qc79PBRRjwb0nXfwD2QWba9YSBtYGaDuvZ3gf9ySAbIES3yvYdnJZT8SBmfHL4L5iyTd8/6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799752; c=relaxed/simple;
	bh=fGhLLwdCedmb+/WPqlL245TpagpYHJiGJoMQWGa2fHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggwQ3MTbE8tflqqhlTMEoSdgG9QODZ1yS/pGjRjelPaGZqvmqilP0slhBp8ObEVhBiHndyXc0FqPi6dw4lkaSXFOrLpOrW8ge3d1gnE2cLDmgDM+9rpkt1txoRuSqyx38THeQzUl1aFD6Ctws5XT4lOcq6r/xo1GX/Q8LZcOvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOkBWf+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9FAC4CEF8;
	Tue,  2 Sep 2025 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756799750;
	bh=fGhLLwdCedmb+/WPqlL245TpagpYHJiGJoMQWGa2fHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOkBWf+syJfTDnMKxIgzan3/kkMFxM1aVMv+RSJbTkuKOZIQrMSiMiSz7TNzb/W9r
	 HklilaSAMpDzzfPhjsillI34OGFmDeV+RAL8efOr2wJJYSfu2jXKWl5htarNBHL/i8
	 RV+l08rI8yY6hbZL+0QU9j/8HQ8+cyDlmm7zSiXXJ6S0//PPfEANm9aPmyi9a1k8rz
	 j85gpapJ606lRIKboiz5GA/OrCpHWFNABLCPLxpnY5o/AsiONvChZqXbwSHh8XVwgd
	 yCSoy3Zgf1vl20t0JGqxGkVNwFFik/6KZW/Cv2Cj+PQC57uT93Nk9UlqE8wkikQolg
	 vFZycSq/3NOxw==
Date: Tue, 2 Sep 2025 09:55:47 +0200
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
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 3/7] dt-bindings: phy: rockchip-inno-csi-dphy: add
 rk3588 variant
Message-ID: <20250902-piquant-secret-moose-06c4b6@kuoka>
References: <20250616-rk3588-csi-dphy-v3-0-a5ccd5f1f438@collabora.com>
 <20250616-rk3588-csi-dphy-v3-3-a5ccd5f1f438@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616-rk3588-csi-dphy-v3-3-a5ccd5f1f438@collabora.com>

On Mon, Sep 01, 2025 at 10:47:44PM +0200, Michael Riesch wrote:
> The Rockchip RK3588 variant of the CSI-2 DPHY features two reset lines.
> Add the variant and allow for the additional reset.
> 
> Signed-off-by: Michael Riesch <michael.riesch@collabora.com>
> ---
>  .../bindings/phy/rockchip-inno-csi-dphy.yaml       | 50 +++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> index 9ad72518e6da..e37c9fd74788 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> @@ -21,6 +21,7 @@ properties:
>        - rockchip,rk3326-csi-dphy
>        - rockchip,rk3368-csi-dphy
>        - rockchip,rk3568-csi-dphy
> +      - rockchip,rk3588-csi-dphy
>  
>    reg:
>      maxItems: 1
> @@ -40,11 +41,15 @@ properties:
>  
>    resets:
>      items:
> -      - description: exclusive PHY reset line
> +      - description: APB reset line
> +      - description: PHY reset line

That's changing the order, before first was the phy....

> +    minItems: 1
>  
>    reset-names:
>      items:
>        - const: apb
> +      - const: phy

Although here first was apb? Quite confusing.

Anyway "phy" reset for "phy" is pretty non-informative, please give some
useful name.

> +    minItems: 1

Best regards,
Krzysztof


