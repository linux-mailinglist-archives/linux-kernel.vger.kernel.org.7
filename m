Return-Path: <linux-kernel+bounces-778182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE0B2E24B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C74171D95
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0632C323;
	Wed, 20 Aug 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbgkpQOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718E732BF4D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707370; cv=none; b=mdZdtsqZkKjTuJuPACkEtcp7rnNOt2SJ9SFyxXKNv/ycHKpEo9tG+L4Hl/5pstoU9dNltClKCdnbVmH8vwhWMG96uGZGv/JWoUO1kxC7xV1j6h8vmrd69ceXsXZYOxrupGreIh/vYWiE5AzfV7xW4G2cUfHOu2Ur2048SEbUPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707370; c=relaxed/simple;
	bh=Qzu3sAyj5y1ZHEYtAgX6Nl+Q7wQ4tl5rXdQK2r2hq9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZE4IhXvpmSEq9MxH7NsLj68vo3wb1QFoRvHk/604y3RB64CcZ0lrYjU/gqXMo6fkFJL0K7i9RZk7bwiddLGRK5BuSQ7bslWj2UFb1bc5RJg6zIwZ4KIfVVAJL4Zj01zZfdP9xMRzQ6ji8KsrAISP80SR8LDAbtVcb8SFJD090I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbgkpQOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF51C4CEE7;
	Wed, 20 Aug 2025 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755707370;
	bh=Qzu3sAyj5y1ZHEYtAgX6Nl+Q7wQ4tl5rXdQK2r2hq9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbgkpQOOkJMnf7YOfm3L+2WNCbvN5KEBLTDdwMgR39opZMxwb3V5MK73vcbQHirnK
	 WevPSToBA1Z2Bd1BJLSfJUjYuaTPfwrbFLBngxvVkBwusojgB7i28p0pf2CAjQGOTI
	 OWGI4RYaIQWxIe4yHc/B2L9MU3Oc48+TlxaqVGOJ28GF/EveSvbMI88t5jJUz/4gdL
	 nf1y1c9dXmjFaPj6ZVW4UfP4MnM2Kun7XmhFDsJkrQBpw2OmE8LzrNOto2vNhkkKLu
	 UZiKOWNEGnG9LzNAeH6ukYhQHtK47/+VD6Z4TrSDqQmwMgcGIcapZ+oEPd9Sevi3CG
	 OMAOYwUjQ3ETg==
Date: Wed, 20 Aug 2025 21:59:25 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/9] phy: mediatek: phy-mtk-hdmi-mt2701: convert from
 round_rate() to determine_rate()
Message-ID: <aKX35U4jX55W3W61@vaman>
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
 <20250810-phy-clk-round-rate-v2-2-9162470bb9f2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-phy-clk-round-rate-v2-2-9162470bb9f2@redhat.com>

On 10-08-25, 18:45, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> index e51b2d13eab473dddace48c75c2a8d73c8c65635..b0b6497e7eedcb6867541b573d22156ded29a4d5 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c
> @@ -90,10 +90,10 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
>  	usleep_range(80, 100);
>  }
>  
> -static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> -				    unsigned long *parent_rate)
> +static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
> +				       struct clk_rate_request *req)
>  {
> -	return rate;
> +	return 0;

This does not sound correct to me? should this not check the requested
rate?

>  }
>  
>  static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -170,7 +170,7 @@ static const struct clk_ops mtk_hdmi_phy_pll_ops = {
>  	.prepare = mtk_hdmi_pll_prepare,
>  	.unprepare = mtk_hdmi_pll_unprepare,
>  	.set_rate = mtk_hdmi_pll_set_rate,
> -	.round_rate = mtk_hdmi_pll_round_rate,
> +	.determine_rate = mtk_hdmi_pll_determine_rate,
>  	.recalc_rate = mtk_hdmi_pll_recalc_rate,
>  };
>  
> 
> -- 
> 2.50.1

-- 
~Vinod

