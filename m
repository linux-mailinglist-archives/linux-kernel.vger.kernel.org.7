Return-Path: <linux-kernel+bounces-888550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD2FC3B1F0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F49423B3A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641B32F77D;
	Thu,  6 Nov 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UU23+Tkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2785232E751
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434160; cv=none; b=QiDryMeUr6xnqjnoXNSJLMuCgc8Hp6iKUxax3QfyfJ/nFGHLYQOtoUCezQ4qXtpMrdfge1FAtvQ8tt3tAkDlZgKbq1GFdN4PRfGNB9+CqpyS/Q2JGA2IoOZAVxei1Hz+c+TE2FaaQu2pGWrzfCpm1o6bD9qoBP2CrmM8kCPyYoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434160; c=relaxed/simple;
	bh=lPkW7VunzQTWdZlBYd5uE68H7anD0Qk+0LUNZisKswM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSRok0ldYcDzwx8aDX2J+RKgrUp7lLBWmjO6GYsvQNzGczG4TF6xbx65Pb6QhIdyhvVeFKl6JF6w2RUS6wxjBx8k/6NZ824wv3M0R6A8yQaiNFBv9Wh750L4sshsTlhGzUfA0mMsIDaGuN644/AakKXOd6BIFyRNTGm+Fo7qTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UU23+Tkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33C4C4CEFB;
	Thu,  6 Nov 2025 13:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762434159;
	bh=lPkW7VunzQTWdZlBYd5uE68H7anD0Qk+0LUNZisKswM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UU23+Tkm7dkn1sE0/4NeaCjEccKPw6GU2oWcIgcSIJL4uTqPK/F1CGZTUW3HSla1n
	 r2Jms4SG2gWNgTIt4DS88ToamV9Pw6Yt8sd3cqtiLYeNPCY8di7FHa+ZlOWiORkDKa
	 nzM610QiBVZ7E7GS3xoIcLxuapn/C1V3KXF1LBXGPxSgsDvtAUFBJteVnbumdQyHfC
	 4OLeQUw5Lxe4/Bic3P3HP6MK5kfjlUyz7GvuJJ14M9VDFSNyFzj0PkqmW3Ok6nRCOI
	 nhQ6/lrgZiOl9R06Vcudepnz1+fFZItufqtsoMLkeLZMJ1jhQSVN4vKXrfup0qbwNZ
	 QRP5oagVmLGUg==
Date: Thu, 6 Nov 2025 13:02:33 +0000
From: Lee Jones <lee@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dharma.b@microchip.com
Subject: Re: [PATCH v2 RESEND 2/3] mfd: atmel-hlcdc: fetch LVDS PLL clock for
 LVDS display
Message-ID: <20251106130233.GK8064@google.com>
References: <20251022091351.472331-1-manikandan.m@microchip.com>
 <20251022091351.472331-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022091351.472331-3-manikandan.m@microchip.com>

On Wed, 22 Oct 2025, Manikandan Muralidharan wrote:

> The XLCDC IP supports parallel RGB, MIPI DSI and LVDS Display.
> The LCD Generic clock (sys_clk) is used for Parallel RGB and MIPI
> displays, while the LVDS PLL clock (lvds_pll_clk) is used for LVDS
> displays.Since both the clocks cannot co-exist together in the DT
> for a given display, this patch first attempts to retrieve sys_clk
> If that fails,it then tries to acquire lvds_pll_clk.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changes in v2:
> - Rephrase the comments, commit message and err logs
> - Replace dev_err wwith dev_warn
> - Remove Initializing sys_clk and lvds_pll_clk to NULL post
> devm_kzalloc() call
> 
> ---
>  drivers/mfd/atmel-hlcdc.c       | 16 ++++++++++++++--
>  include/linux/mfd/atmel-hlcdc.h |  1 +
>  2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> index 4c4e35d404f3..f680392b01ba 100644
> --- a/drivers/mfd/atmel-hlcdc.c
> +++ b/drivers/mfd/atmel-hlcdc.c
> @@ -108,10 +108,22 @@ static int atmel_hlcdc_probe(struct platform_device *pdev)
>  		return PTR_ERR(hlcdc->periph_clk);
>  	}
>  
> +	/*
> +	 * Retrieve any one of the Main clk required by the LCD to operate:
> +	 *
> +	 * LCDC Generic Clock (sys_clk) - Parallel RGB and MIPI displays,
> +	 * LVDS PLL (lvds_pll_clk)      - LVDS display
> +	 */
>  	hlcdc->sys_clk = devm_clk_get(dev, "sys_clk");
>  	if (IS_ERR(hlcdc->sys_clk)) {
> -		dev_err(dev, "failed to get system clock\n");
> -		return PTR_ERR(hlcdc->sys_clk);
> +		dev_warn(dev,
> +			 "failed to get LCDC generic clock, trying for LVDS PLL clock instead\n");

Does the user really care which clock they use?

Can this just happen silently instead?

> +		hlcdc->lvds_pll_clk = devm_clk_get(dev, "lvds_pll_clk");
> +		if (IS_ERR(hlcdc->lvds_pll_clk)) {
> +			dev_err(dev, "failed to get LVDS PLL clock\n");

Failed to obtain both the LCDC (generic) and LVDS PLL clocks

> +			return PTR_ERR(hlcdc->lvds_pll_clk);
> +		}
>  	}
>  
>  	hlcdc->slow_clk = devm_clk_get(dev, "slow_clk");
> diff --git a/include/linux/mfd/atmel-hlcdc.h b/include/linux/mfd/atmel-hlcdc.h
> index 80d675a03b39..07c2081867fd 100644
> --- a/include/linux/mfd/atmel-hlcdc.h
> +++ b/include/linux/mfd/atmel-hlcdc.h
> @@ -75,6 +75,7 @@
>   */
>  struct atmel_hlcdc {
>  	struct regmap *regmap;
> +	struct clk *lvds_pll_clk;
>  	struct clk *periph_clk;
>  	struct clk *sys_clk;
>  	struct clk *slow_clk;
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

