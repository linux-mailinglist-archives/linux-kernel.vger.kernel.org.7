Return-Path: <linux-kernel+bounces-765148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3CB22C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3759621EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5895B23D7F4;
	Tue, 12 Aug 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pf523yqH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446D23D7DB;
	Tue, 12 Aug 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013803; cv=none; b=R4ogHVkKdP8ayJKxaUx4DZ7ZhoqCcmQ1CnLTk64d4Gn3ZdKf5/sRFor8dv9nfxLO4zEyrzdz8YTnZEl1cW/GIY+pZSTr/Pbj393E7dE6Czsh0dodAv/411ioUcb0gpk3wMjECoWqRtTgO1ZaOfQ5fA5Z/ua9r7tjZ8/ijYULUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013803; c=relaxed/simple;
	bh=HwhqQwzGO1qGIgkNPS0Hm6Pz/bIg4cXLfWxME1eW6DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp9NYRffAPtkbBCj8PTLDAZdSfDBg39ZdA3aB7LvoB4lt0Unp5OaNanw0GJQiWdUw0QHFBmRcNahFoAXKzyw7K9cN11JtDoGJBAj9zVeJmJUgPDy4NG3XWXspIagXT3Tph8Vl9ONfeOMJ3uTYbAb9DaoZ5Gwl3KYUepDy1DkOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pf523yqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9241C4CEF0;
	Tue, 12 Aug 2025 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013803;
	bh=HwhqQwzGO1qGIgkNPS0Hm6Pz/bIg4cXLfWxME1eW6DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pf523yqH3E1fYrrsu7V7bVhWKcl8DBUAGY2Oh3RRT7n3TYiqLyvX8fX2SL9Vvmm5S
	 vXZ50h8aiGUoKva2uQeg9ieO5OyD+bviuXljW8VQfnqVkBZspiTW9I5+NfL0xlx2Bw
	 sJ7tF/ILi5PJ+JcVynjjoxF/icPstfohU033kbp+YUeNY12jipFVuOvMJr1pD8+ACF
	 A3lg9NDH7pQxFkf4hS6tIOR82PPZsRHDF1dHF+K/rZVwTXIyjuh8swiDH5qWj1R7P5
	 FZK6CK8PS8jLwYNWDq9itSB4yFnthozpx29Ob4FIVwcPpB9LB4JtWA8zM3PLTl69ZL
	 /qhst9utTf9uw==
Date: Tue, 12 Aug 2025 21:19:59 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jianwei Zheng <jianwei.zheng@rock-chips.com>
Subject: Re: [PATCH 05/11] phy: rockchip: inno-usb2: Add support for RK3528
Message-ID: <aJtip49r8R3-2XXi@vaman>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
 <20250723122323.2344916-6-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723122323.2344916-6-jonas@kwiboo.se>

On 23-07-25, 12:23, Jonas Karlman wrote:
> From: Jianwei Zheng <jianwei.zheng@rock-chips.com>

Please do not send encrypted emails over public mail lists

> 
> The RK3528 has a single USB2PHY with a otg and host port.
> 
> Add support for the RK3528 variant of USB2PHY.
> 
> PHY tuning for RK3528:
> 
> - Turn off differential receiver in suspend mode to save power
>   consumption.
> 
> - Set HS eye-height to 400mV instead of default 450mV.
> 
> - Choose the Tx fs/ls data as linestate from TX driver for otg port
>   which uses dwc3 controller to improve fs/ls devices compatibility with
>   long cables.
> 
> This is based on vendor kernel linux-stan-6.1-rkr5 tag.
> 
> Signed-off-by: Jianwei Zheng <jianwei.zheng@rock-chips.com>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index cd1a02b990ef..b8950d9f9e97 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -1507,6 +1507,28 @@ static int rk3128_usb2phy_tuning(struct rockchip_usb2phy *rphy)
>  				BIT(2) << BIT_WRITEABLE_SHIFT | 0);
>  }
>  
> +static int rk3528_usb2phy_tuning(struct rockchip_usb2phy *rphy)
> +{
> +	int ret = 0;

Superfluous init

> +
> +	/* Turn off otg port differential receiver in suspend mode */
> +	ret |= regmap_write(rphy->phy_base, 0x30, BIT(18) | 0x0000);
> +
> +	/* Turn off host port differential receiver in suspend mode */
> +	ret |= regmap_write(rphy->phy_base, 0x430, BIT(18) | 0x0000);
> +
> +	/* Set otg port HS eye height to 400mv (default is 450mv) */
> +	ret |= regmap_write(rphy->phy_base, 0x30, GENMASK(22, 20) | 0x0000);
> +
> +	/* Set host port HS eye height to 400mv (default is 450mv) */
> +	ret |= regmap_write(rphy->phy_base, 0x430, GENMASK(22, 20) | 0x0000);
> +
> +	/* Choose the Tx fs/ls data as linestate from TX driver for otg port */
> +	ret |= regmap_write(rphy->phy_base, 0x94, GENMASK(22, 19) | 0x0018);

No error checking?

-- 
~Vinod

