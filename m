Return-Path: <linux-kernel+bounces-750281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AEB1597D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30923A6495
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD8287508;
	Wed, 30 Jul 2025 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEthc5gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1F7E1;
	Wed, 30 Jul 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860008; cv=none; b=kbR9hrUqSEk092mbq86gaVRLKa3Z5iaggMxDDRKeE0/vvrhSJ3wPL3cV/hsrL5QjeQARBYpnDEqILtZqXn3HL8zQohKSPW1peYtEYK/DdPaXRi4fqp+m0c/7zgTFYeAFBbmRNOhuuEZgq8g16uOZReWzzuEJgbfGRW8OcIfSyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860008; c=relaxed/simple;
	bh=ZJ5KakVI3HlglpXpnj7PJjouu2V6gLi5SHJJuOLVQJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rblyRj935+IvLekCIGbVZzgcD9CB5a4nucPDK7PVO2oAjVxbVcTI88bUIE3bmaMoWA+m5hihNOzsZxLqQC5RanVyI0tJB4F48qCMCGBcsqzwepM6qKbyRselT0SFe2RmxXBYRT5HzUMGmeimap0SLCRiq97aqpdleYIVSmKR1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEthc5gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCCFC4CEE7;
	Wed, 30 Jul 2025 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753860007;
	bh=ZJ5KakVI3HlglpXpnj7PJjouu2V6gLi5SHJJuOLVQJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEthc5gpAfD5sKwhZzLwp2DAXzt68A8NXzPDqHqtF+WDdNrr5UuDlpPiTKVcl+Drt
	 2NRIy3M9BHDpnr2pk582cvs/3SG7F2X6P+sbu+W32D0yFCpMjMpR4nWX8U0X4A4+AX
	 qFQoSJ83vOMp4Z0JxU8Xt/+/vvLArIhEymHxvPyKUi6WPBK63qsM3HZRkNTM7iU+i5
	 vXDZoDTeJOOAgKNwHT+0eLUJM8FQvTUvpvEOBuwJANBw2Yk5Auas9ShQG2vzg2sq+Q
	 peyUxSycvNfa/E1hS3IRNZRLNVsU+u/LiHa44qbzw3RP56K8I/MmWRk0y9ZmHj8CQC
	 NKokdBISBo4uw==
Date: Wed, 30 Jul 2025 09:20:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Yubing Zhang <yubing.zhang@rock-chips.com>, 
	Frank Wang <frank.wang@rock-chips.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Amit Sunil Dhamne <amitsd@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Chaoyi Chen <chaoyi.chen@rock-chips.com>, Dragan Simic <dsimic@manjaro.org>, 
	Johan Jonker <jbx6244@gmail.com>, Diederik de Haas <didi.debian@cknow.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Peter Robinson <pbrobinson@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: rockchip: rk3399-typec-phy:
 Support mode-switch
Message-ID: <20250730-glistening-fractal-macaque-ff1aaa@kuoka>
References: <20250729090032.97-1-kernel@airkyi.com>
 <20250729090032.97-2-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250729090032.97-2-kernel@airkyi.com>

On Tue, Jul 29, 2025 at 05:00:28PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> The RK3399 SoC integrates two USB/DP combo PHYs, each of which
> supports software-configurable pin mapping and DisplayPort lane
> assignment. These capabilities enable the PHY itself to handle both
> mode switching and orientation switching, based on the Type-C plug
> orientation and USB PD negotiation results.
> 
> While an external Type-C controller is still required to detect cable
> attachment and report USB PD events, the actual mode and orientation
> switching is performed internally by the PHY through software
> configuration. This allows the PHY to act as a Type-C multiplexer for
> both data role and DP altmode configuration.
> 
> To reflect this hardware design, this patch introduces a new
> "mode-switch" property for the dp-port node in the device tree bindings.
> This property indicates that the connected PHY is capable of handling
> Type-C mode switching itself.
> 
> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> - Add more descriptions to clarify the role of the PHY in switching.
> 
> Changes in v2:
> - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
> 
>  .../devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml  | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> index 91c011f68cd0..ccbe1c9cb0bf 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/rockchip,rk3399-typec-phy.yaml
> @@ -51,6 +51,12 @@ properties:
>        '#phy-cells':
>          const: 0
>  
> +      mode-switch:
> +        description: |

Do not need '|' unless you need to preserve formatting.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


