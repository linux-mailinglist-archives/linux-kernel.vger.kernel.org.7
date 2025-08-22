Return-Path: <linux-kernel+bounces-781535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A30B313CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF06F625F03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB94D2EFD8E;
	Fri, 22 Aug 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW8Dkhm5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C8291C3F;
	Fri, 22 Aug 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855234; cv=none; b=cnQGx6VvZHHJQ/aOHakgqx5LMGoJXBP2NSF86gPSbPXaa0hgCAHTrIKDmJeXnH3d02oFU/wz3K00IB5OHaK5X322m+s+Aw7mh/u1sPt0zmy263AkIZVQHzqPPMvBd+kT0+TTzGSQNlbEtVPEl6FXo/3ZL3G77ION9AYAhHv0I18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855234; c=relaxed/simple;
	bh=l/Mx1B8W3cmAkQuq0/d3MKrqsLFHRjyPr8nhD/OLtq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvJVP9CfayRj+OXDjh7Jm8WV2P+Tf8xaFrnQlZ3S3z5gnPikpF2s1Y+sfgfsAEHnTzxb/eenwm3qZ4vuPyruPndsZv01rooWtfamXWZ48zvjpwbOSWQTP2lr42y9Q+vngNuiH2B0FuywBjXGigmqU9xLYWSEa2bAP4p4ntL6QJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW8Dkhm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281C9C113D0;
	Fri, 22 Aug 2025 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755855233;
	bh=l/Mx1B8W3cmAkQuq0/d3MKrqsLFHRjyPr8nhD/OLtq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qW8Dkhm50XyxlTPMvx55jL4RnR3x8r5pj34wFRwmGzkdty04mftV1GHHALpktBWG2
	 JvRyRTQOGAAJlDnm0MPFfbM7RMiPv/E7bfGMlNFGqumhPqqYrOkG3Own1BOmnKdmhg
	 jAKbQqlaOvj3kuJPTgubvk5Rm/pjYd5LOk7TP0fypKuRb20WXtHLkj7lyizx4n5Y/2
	 jUUe29woLYmRD5K1NytUiu/O6GLVLwNQuoBlFqkqCguypfotlahlckKJiTTWac1XJX
	 wcNXXq2KmnsXJjkSZx59ji1v+aaDLbwghzDGLD4vI/nxZKeM4CiCB9D18IUcxx9Yc1
	 7GRLI4UbKJfJg==
Date: Fri, 22 Aug 2025 11:33:51 +0200
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
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: rockchip-inno-csi-dphy: make
 power-domains non-required
Message-ID: <20250822-chirpy-capuchin-of-apotheosis-1133fc@kuoka>
References: <20250616-rk3588-csi-dphy-v2-0-7a94f079b712@collabora.com>
 <20250616-rk3588-csi-dphy-v2-2-7a94f079b712@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250616-rk3588-csi-dphy-v2-2-7a94f079b712@collabora.com>

On Tue, Aug 19, 2025 at 01:00:36AM +0200, Michael Riesch wrote:
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
>  Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> index 5ac994b3c0aa..42da616ae2e3 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip-inno-csi-dphy.yaml
> @@ -57,7 +57,6 @@ required:
>    - clocks
>    - clock-names
>    - '#phy-cells'
> -  - power-domains

This could then be restricted per each variant in if:then:.

Best regards,
Krzysztof


