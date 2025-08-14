Return-Path: <linux-kernel+bounces-769303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ADDB26CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463A53A1308
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9626FA60;
	Thu, 14 Aug 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kyVwDXgV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18324EAB1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189415; cv=none; b=imUPwPOerjr/RzypY0NluWRitJf0vVfQtnY3q031fZ2mh5yBTyZAr6izZk22aZM3AnuWJZ5gqBWLdw/sV1rCysrGMlLD5AgMWomtW3OxhhFjw4FXsLy3znecvqjwh7oY3BSOsuq0eO6k3nSBI6k3nK5MFdzbicW4x/ilutFqUKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189415; c=relaxed/simple;
	bh=d+QXGdRD+AohxHQ66KXmOAFqY41YYQSeMyLGgADIGUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a70UncWvqP7p0dbN0KdXGp6yiuoJ6u4bbRwwfmlY0ixaXG1ztIc5sNaJm60SJiETnwzH4TctazDL7N89axWAWsY3L1VUvoO0QiobGsHo1w4D1q0j/Lkl9jK6md91F1AGra1UCsOyJiUvF1F64WrT+rMQxfilDMavyHRuWPm3FDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kyVwDXgV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755189406;
	bh=d+QXGdRD+AohxHQ66KXmOAFqY41YYQSeMyLGgADIGUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kyVwDXgVko4JOin5YkL6hLrpr6jRMeA+k/1VgK+3YzB+LJc9nw+7qYXy86fTHYP9x
	 CGM8VKsljNOmQN8intxPr4xZMxuRZAFZXrFnxddZHvDI2pEJWvGUNqit4AYiYbi24s
	 GjEUdWxMw8bxxFVeFjnu5I6sMOZZswD1medpe9mbVwqXPJhpBXbaUKdLUJMekiTI5Z
	 GEnCWexFI/Ev5agsYlCHwK56ZEMaR7I5euO1GyX33FKxVHotVbnsZyA8NTdU1c5+OM
	 GD9BZcTIs5wpPt+NVQNNSermb+zmFPBCgbIHFO7e0T6RBfzE2K9Pb09wplSWjMCXhI
	 2wlsEyPR86v+w==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 68C8B17E1273;
	Thu, 14 Aug 2025 18:36:45 +0200 (CEST)
Message-ID: <708d3814-f414-4174-95b3-d3450e9780ec@collabora.com>
Date: Thu, 14 Aug 2025 19:36:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] phy: rockchip: phy-rockchip-samsung-hdptx: convert
 from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250810-phy-clk-round-rate-v2-0-9162470bb9f2@redhat.com>
 <20250810-phy-clk-round-rate-v2-8-9162470bb9f2@redhat.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20250810-phy-clk-round-rate-v2-8-9162470bb9f2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 1:45 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> index 79db57ee90d1487b51f4ddadde870a275dd7b17b..0d4e578c8c6a08aad355aa8aa5a1cf75c7d354ed 100644
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
> @@ -1879,9 +1879,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
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
> @@ -1896,7 +1896,9 @@ static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,
>  	 * hence ensure rk_hdptx_phy_clk_set_rate() won't be invoked with
>  	 * a different rate argument.
>  	 */
> -	return hdptx->hdmi_cfg.tmds_char_rate;
> +	req->rate = hdptx->hdmi_cfg.tmds_char_rate;
> +
> +	return 0;
>  }

This LGTM now, hence

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


