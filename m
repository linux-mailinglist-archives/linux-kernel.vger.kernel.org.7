Return-Path: <linux-kernel+bounces-756042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA79B1AF10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF1E7A8141
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208D221FDC;
	Tue,  5 Aug 2025 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nz1Wy/tN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CC1C1F13;
	Tue,  5 Aug 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377330; cv=none; b=rv+3CB4MyKDWHL+shKcQk16cAT0Zw+QClW+nY+REeAO2VYHi0DP013hLR+qUlDRiiLg9vdqoyZeBIxT8MqC5m7mFKSqllPhdLdnZ+Yf7luduKp4hFwMyrWUuPnzFlVocPhY8k66iXzJlVCTuQ+YAizl04ZZArjvvEg4HmQYjkbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377330; c=relaxed/simple;
	bh=WHyNbaTrvEEeFJm2Eyr27RbpKKVKpcYMFIZPyY6uqME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsoZISRaC1YJQG9Yz0kFllb5YYlFc0NuUefTJFBk1SU8xz83SkZVtAEcX/oHoRFOe4dCAendUPSYEu7trJr44qz3VZy7D9dCA4nAu+ufaEnSU7ukYqPW01gNAE0LhJhY2NnMAl9rBOCcwYBPh8B/9v3SrlmTwIGqiXa4KivO3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nz1Wy/tN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697F9C4CEF4;
	Tue,  5 Aug 2025 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377330;
	bh=WHyNbaTrvEEeFJm2Eyr27RbpKKVKpcYMFIZPyY6uqME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nz1Wy/tNdmSLGGe3aRRxM4HIvUDlcBHqOIlhzbdt3gXdgVTbEcS08oU0FC2XvHMSy
	 rD8IVkUMVELmCu+CQOAeyFVHsx5Qt5/1SK4Bx3khPc9zOJYggBsm0oKE3jMZKmXHzp
	 G19JTT3LLPOxvbO4FigHNeQF2fRsilDtQ6fJVPFUbNEce/AYxGkYOiE0oOS5yxR5jQ
	 T0vWNXgyoyT1XCwpeXS858QyMs5S7jbAzMFjpJy8AGOwQ2uB+wxCyvHAX7ZR9d7GZ/
	 Cd56Ha0JtINKPN7kf01psqFwdHqs4Qkir6QNViO8xQtFwtq/fWFzfxZ6PB/tupx+tW
	 n9RDnWxQPUDlw==
Date: Tue, 5 Aug 2025 09:02:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 2/7] dt-bindings: clock: imx8ulp: add SIM LPAV clock gate
 ID definitions
Message-ID: <20250805-natural-vulture-of-glamour-5fac8d@kuoka>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
 <20250804155407.285353-3-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804155407.285353-3-laurentiumihalcea111@gmail.com>

On Mon, Aug 04, 2025 at 11:54:02AM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add ID definitions for the clock gates managed by the SIM LPAV module.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  include/dt-bindings/clock/imx8ulp-clock.h | 7 +++++++
>  1 file changed, 7 insertions(+)

This is part of bindings patch.


> 
> diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
> index 827404fadf5c..ebebb4831761 100644
> --- a/include/dt-bindings/clock/imx8ulp-clock.h
> +++ b/include/dt-bindings/clock/imx8ulp-clock.h
> @@ -255,4 +255,11 @@
>  
>  #define IMX8ULP_CLK_PCC5_END		56
>  
> +/* LPAV SIM */
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_CORE		0
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PBCLK		1
> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PLAT		2
> +
> +#define IMX8ULP_CLK_SIM_LPAV_END		3

Drop. Not a binding (see other discussions for many SoCs why).

Best regards,
Krzysztof


