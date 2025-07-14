Return-Path: <linux-kernel+bounces-729699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A51A6B03A86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612854A0AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC1424111D;
	Mon, 14 Jul 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B5bbabNS"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F52405FD;
	Mon, 14 Jul 2025 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484287; cv=none; b=FMRpTrDOP3JgaftzeSYUznwHi3N2FqYOdK2KbbjI5ohc1yWVvqbRy+lE5zROQtBBegpoF+hT2lqChjgDYKG+IIQh+qaiTheiPoPaRZznmiok2LtScjfoQwTKrKr5gydFkte+6WR4e6A1lQRtLjhSa1ueRFcPz8Q1mRrw/xHwKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484287; c=relaxed/simple;
	bh=TcXuSKCzrCCwa2pmT8ZHf1Y2DIXZfwVMWsiDggJctoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhwDvUc6xxSLnAnuBK5TuiAIvcD6xkxHXLLKggpY7aRgmQUXfa+U/v25CitJFlyRsXIAlKcZkSokkQSqqmQQeJQz/xZ/ZWOla3MYDkeRTmZBcjcv4+duxaVrUCdvXidEvqqM4DIXaq3tbCDJK0VY+EGvBzLiaOxrGkaYES2sbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B5bbabNS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752484282;
	bh=TcXuSKCzrCCwa2pmT8ZHf1Y2DIXZfwVMWsiDggJctoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B5bbabNSKmfNjM9++JQ90q4tsvfZkUqd0NHtfw2dUAe7hIS3PaXzD7HksVYxhHNab
	 wKmWXPRAWP00WwEUhjUURuoDXv7oP88Owx7G6axYcInakd5jvBrnwGh+5B5wZA4vej
	 FNTQKY3beSXG+GhSo/assdVNtSQFqiyBf7htZu5HnMZ+a2Z7wS8ybeJW6BFMohb2dA
	 gHU6GVhnlXLprKdYC8dD/uEoGkRf5Whwgh5nyLswGC1suMHvCJSzMMjnx79TXdKaIw
	 73Aiuly5kWcvTP7AT6Jt21nMD/o/UlNg/whhB+786BLG3fTUndHJbCWCU3b63x2Ttj
	 mUJscYPAujZRQ==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57A9F17E0FFA;
	Mon, 14 Jul 2025 11:11:22 +0200 (CEST)
Message-ID: <751975b2-c9dc-4f89-9537-475773b16883@collabora.com>
Date: Mon, 14 Jul 2025 12:11:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] phy: rockchip: phy-rockchip-samsung-hdptx: convert
 from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
 <20250710-phy-clk-round-rate-v1-8-0ff274055e42@redhat.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250710-phy-clk-round-rate-v1-8-0ff274055e42@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Brian,

On 7/10/25 7:07 PM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 79db57ee90d1487b51f4ddadde870a275dd7b17b..f027d2caa4c2ebfc0fdec08bcebf3f415ff1a064 100644
> --- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> +++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> @@ -1869,8 +1869,8 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
>  	return hdptx->hw_rate;
>  }
>  
> -static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> -					unsigned long *parent_rate)
> +static int rk_hdptx_phy_clk_determine_rate(struct clk_hw *hw,
> +					   struct clk_rate_request *req)
>  {
>  	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
>  
> @@ -1879,14 +1879,17 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>  	 * To be dropped as soon as the RK DW HDMI QP bridge driver
>  	 * switches to make use of phy_configure().
>  	 */
> -	if (!hdptx->restrict_rate_change && rate != hdptx->hdmi_cfg.tmds_char_rate) {
> +	if (!hdptx->restrict_rate_change && req->rate != hdptx->hdmi_cfg.tmds_char_rate) {
>  		struct phy_configure_opts_hdmi hdmi = {
> -			.tmds_char_rate = rate,
> +			.tmds_char_rate = req->rate,
>  		};
>  		int ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &hdmi);
>  
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			req->rate = ret;

This is not quite right, since "ret" is expected to contain an error number,
typically -EINVAL.

> +
> +			return 0;

We shall continue returning the error code here.

Regards,
Cristian

> +		}
>  
>  		hdptx->hdmi_cfg = hdmi;
>  	}
> @@ -1896,7 +1899,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>  	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
>  	 * a different rate argument.
>  	 */
> -	return hdptx->hdmi_cfg.tmds_char_rate;
> +	req->rate = hdptx->hdmi_cfg.tmds_char_rate;
> +
> +	return 0;
>  }
>  
>  static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> @@ -1925,7 +1930,7 @@ static const struct clk_ops hdptx_phy_clk_ops = {
>  	.prepare = rk_hdptx_phy_clk_prepare,
>  	.unprepare = rk_hdptx_phy_clk_unprepare,
>  	.recalc_rate = rk_hdptx_phy_clk_recalc_rate,
> -	.round_rate = rk_hdptx_phy_clk_round_rate,
> +	.determine_rate = rk_hdptx_phy_clk_determine_rate,
>  	.set_rate = rk_hdptx_phy_clk_set_rate,
>  };
>  
> 

