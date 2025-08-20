Return-Path: <linux-kernel+bounces-778170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33361B2E22D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB36B17089D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8824326D66;
	Wed, 20 Aug 2025 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMW9dXlD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68C32277C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706642; cv=none; b=n1HBNAp7QWlgvDmNTtkkwi03VKRNUttYykQZZ+tXVdn6chk9suwn+6BTZiQOD7bX8oFvwbRrJu361DqMbVnhsU15tfiofcrvI/Q3HYtdQG+qbWH8henkrZqSJfMrTCMcrSttgpizDvxXdrvE3tRwj8fePGLOEWW7kwkwwYJTkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706642; c=relaxed/simple;
	bh=fONdSSWLD4ciYiiYXbL5hX7jHz6dYO1YgPzjDtd1z2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/h9pzAwf8VK7f7HAlSSQ7TosyaVIxIJm6nrCoCBAYqMCJ0STfYwQIwoPbUt2zh3ju+SepJw7x+NFWgIivtCNM688nDi2vvaQEi7PnYLzyhStjPTEM03z29gtVRgSzwV1ZK1wXbyGA8ELF2zNfbQn4W+SW3TFvMYTwfBajBz9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMW9dXlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0149BC4CEEB;
	Wed, 20 Aug 2025 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755706640;
	bh=fONdSSWLD4ciYiiYXbL5hX7jHz6dYO1YgPzjDtd1z2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMW9dXlDZPJXeW4+QXLmySJuT9NWSD5weVPY9F1YR2z7W7y861mVHF9PbtkN6u+Rt
	 QHEreW6gwrcrYFhPaxFDZwrMuOiMykNohoQpBMmB/OLplJoMF2AOwMWIrbPLubn7p0
	 vdhDjuZCTxFXgmWsNR5hVb6N7fg76n6FaiglEh87wRYpoBzMh4qOZ697eZVPw3Op34
	 Kc18qXW8Be16tw2WkEkHjGU6BITglxm5iIqU7qJUtVFoySwAp6qbBM5XOF2Pw7E2y6
	 shyD3n6WygFBUZrOk038tn+Gm66qQhDMElBc/6xtFy/9p6J1zEwPV5mWhBrXqisTdM
	 9uB594EVlImYQ==
Date: Wed, 20 Aug 2025 21:47:15 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "payne.lin" <payne.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com, Bincai Liu <bincai.liu@mediatek.com>
Subject: Re: [PATCH] phy: mediatek: Modify mipi clk upper bound to 2.5Gbps
Message-ID: <aKX1CxD_2mlOwYn-@vaman>
References: <20250814125406.4161220-1-payne.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814125406.4161220-1-payne.lin@mediatek.com>

On 14-08-25, 20:54, payne.lin wrote:
> From: Bincai Liu <bincai.liu@mediatek.com>
> 
> Mipi dphy can support up to 4k30 without dsc.

Good, how does that translate to below value change, can you please
explain?

> 
> Signed-off-by: Bincai Liu <bincai.liu@mediatek.com>
> Signed-off-by: Payne Lin <payne.lin@mediatek.com>
> ---
>  drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> index 553725e1269c..b8233c496070 100644
> --- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> +++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
> @@ -100,7 +100,7 @@ static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
>  static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>  				       unsigned long *prate)
>  {
> -	return clamp_val(rate, 125000000, 1600000000);
> +	return clamp_val(rate, 125000000, 2500000000);
>  }
>  
>  static const struct clk_ops mtk_mipi_tx_pll_ops = {
> -- 
> 2.45.2

-- 
~Vinod

