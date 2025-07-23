Return-Path: <linux-kernel+bounces-742761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D96B0F662
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27F77BA648
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705F2FD5A4;
	Wed, 23 Jul 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jASIwfBk"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6472FD596
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282355; cv=none; b=YRPkTD9sJ7VUGnCaS1twO9+uftuEwnhv79ISdC/mN0tpr+1ufHYkvKA0BTexFg9RponjAJ5YqRjB3qfUP0ml2ugi+boTU9pkERDYkkHVOxWa1nliK7rJejSoQywJ3jam7fvbiXeU60Jaq3QrlysjTYGvErwhIhbT5kvHHwz7WJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282355; c=relaxed/simple;
	bh=Y5mV7Iw85fbp5EoomigTRjr705g6yNBWr1FkXK0GWKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+6oMszC1Eh+XT/OdgefvRtGJC/htxrhRiw3QZGa8PNYCrynuGBozrjHHrgj4S1oYlUonVIKuMdWSErrViAv+/WQqos040iMZn1vp+3pRhY2Md5USpgCvzYcH5PsudUz2KRY8YluKK4XjlEj3aUfnuxaT1j4Pv16Uf3wmPC0hMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=jASIwfBk; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753282323;
 bh=i8rKZEkFrLRFaYQBc3BIIxI8WYrqNMHpEOrc29zdPS4=;
 b=jASIwfBkSb9pscpRseVuj3FkBqOO88QJSyfKXetLEiffxytX94js/4etg0Hm7+1TmOqdtNhNY
 xc0/TDZ64O8lSLLhT3tVwvhwy7jpGoxVts3/62x5Fg5R3taVW8zacVZoWqIOMIryv5LM4f+NYXq
 DwlH8nnA1+p636zjZcc8Zu028Uw9DCfySX5Gn4qMwjRqNKEKmRRAkmLOt3jwFRLXtGz32pff1kW
 IPivuNx0raRwdTUaHUyW6jndePy/7w1rE7x7nvUdb6ZIlQwVW0+s3TdvURVAuvaePqib5K/knNs
 ugn+IBycVsGLlFwspWU60IUxBRS4d/lg3yKFJZeRgcFA==
X-Forward-Email-ID: 6880f6eacb0ee86f9731d64d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <eb7c9e40-3c17-488f-98a2-17b972f61e75@kwiboo.se>
Date: Wed, 23 Jul 2025 16:51:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] phy: rockchip: naneng-combphy: Add RK3528 support
To: Yao Zi <ziyao@disroot.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Frank Wang <frank.wang@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Detlev Casanova <detlev.casanova@collabora.com>,
 Shresth Prasad <shresthprasad7@gmail.com>, Chukun Pan <amadeus@jmu.edu.cn>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
References: <20250624033733.50197-1-ziyao@disroot.org>
 <20250624033733.50197-6-ziyao@disroot.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250624033733.50197-6-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yao Zi,

On 6/24/2025 5:37 AM, Yao Zi wrote:
> Rockchip RK3528 integrates one naneng-combphy that is able to operate in
> PCIe and USB3 mode. The control logic is similar to previous variants of
> naneng-combphy but the register layout is apperantly different from the
> RK3568 one.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 186 +++++++++++++++++-
>  1 file changed, 185 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 1d1c7723584b..bf00a85a113b 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -20,7 +20,46 @@
>  #define REF_CLOCK_25MHz			(25 * HZ_PER_MHZ)
>  #define REF_CLOCK_100MHz		(100 * HZ_PER_MHZ)
>  
> -/* COMBO PHY REG */
> +/* RK3528 COMBO PHY REG */
> +#define RK3528_PHYREG6				0x18
> +#define RK3528_PHYREG6_PLL_KVCO			GENMASK(12, 10)
> +#define RK3528_PHYREG6_PLL_KVCO_VALUE		0x2
> +#define RK3528_PHYREG6_SSC_DIR			GENMASK(5, 4)
> +#define RK3528_PHYREG6_SSC_UPWARD		0
> +#define RK3528_PHYREG6_SSC_DOWNWARD		1
> +
> +#define RK3528_PHYREG40				0x100
> +#define RK3528_PHYREG40_SSC_EN			BIT(20)
> +#define RK3528_PHYREG40_SSC_CNT			GENMASK(10, 0)
> +#define RK3528_PHYREG40_SSC_CNT_VALUE		0x17d
> +
> +#define RK3528_PHYREG42				0x108
> +#define RK3528_PHYREG42_CKDRV_CLK_SEL		BIT(29)
> +#define RK3528_PHYREG42_CKDRV_CLK_PLL		0
> +#define RK3528_PHYREG42_CKDRV_CLK_CKRCV		1
> +#define RK3528_PHYREG42_PLL_LPF_R1_ADJ		GENMASK(10, 7)
> +#define RK3528_PHYREG42_PLL_LPF_R1_ADJ_VALUE	0x9
> +#define RK3528_PHYREG42_PLL_CHGPUMP_CUR_ADJ	GENMASK(6, 4)
> +#define RK3528_PHYREG42_PLL_CHGPUMP_CUR_ADJ_VALUE 0x7
> +#define RK3528_PHYREG42_PLL_KVCO_ADJ		GENMASK(2, 0)
> +#define RK3528_PHYREG42_PLL_KVCO_ADJ_VALUE	0x0
> +
> +#define RK3528_PHYREG80				0x200
> +#define RK3528_PHYREG80_CTLE_EN			BIT(17)
> +
> +#define RK3528_PHYREG81				0x204
> +#define RK3528_PHYREG81_CDR_PHASE_PATH_GAIN_2X	BIT(5)
> +#define RK3528_PHYREG81_SLEW_RATE_CTRL		GENMASK(2, 0)
> +#define RK3528_PHYREG81_SLEW_RATE_CTRL_SLOW	0x7
> +
> +#define RK3528_PHYREG83				0x20c
> +#define RK3528_PHYREG83_RX_SQUELCH		GENMASK(2, 0)
> +#define RK3528_PHYREG83_RX_SQUELCH_VALUE	0x6
> +
> +#define RK3528_PHYREG86				0x218
> +#define RK3528_PHYREG86_RTERM_DET_CLK_EN	BIT(14)
> +
> +/* RK3568 COMBO PHY REG */
>  #define RK3568_PHYREG6				0x14
>  #define RK3568_PHYREG6_PLL_DIV_MASK		GENMASK(7, 6)
>  #define RK3568_PHYREG6_PLL_DIV_SHIFT		6
> @@ -398,6 +437,147 @@ static int rockchip_combphy_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> +static int rk3528_combphy_cfg(struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> +	unsigned long rate;
> +	u32 val;
> +
> +	/* Set SSC downward spread spectrum */
> +	val = FIELD_PREP(RK3528_PHYREG6_SSC_DIR, RK3528_PHYREG6_SSC_DOWNWARD);
> +	rockchip_combphy_updatel(priv, RK3528_PHYREG6_SSC_DIR, val, RK3528_PHYREG6);
> +
> +	switch (priv->type) {
> +	case PHY_TYPE_PCIE:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
> +		break;
> +	case PHY_TYPE_USB3:
> +		/* Enable adaptive CTLE for USB3.0 Rx */
> +		rockchip_combphy_updatel(priv, RK3528_PHYREG80_CTLE_EN, RK3528_PHYREG80_CTLE_EN,
> +					 RK3528_PHYREG80);
> +
> +		/* Set slow slew rate control for PI */
> +		val = FIELD_PREP(RK3528_PHYREG81_SLEW_RATE_CTRL,
> +				 RK3528_PHYREG81_SLEW_RATE_CTRL_SLOW);
> +		rockchip_combphy_updatel(priv, RK3528_PHYREG81_SLEW_RATE_CTRL, val,
> +					 RK3528_PHYREG81);
> +
> +		/* Set CDR phase path with 2x gain */
> +		rockchip_combphy_updatel(priv, RK3528_PHYREG81_CDR_PHASE_PATH_GAIN_2X,
> +					 RK3528_PHYREG81_CDR_PHASE_PATH_GAIN_2X, RK3528_PHYREG81);
> +
> +		/* Set Rx squelch input filler bandwidth */
> +		val = FIELD_PREP(RK3528_PHYREG83_RX_SQUELCH, RK3528_PHYREG83_RX_SQUELCH_VALUE);
> +		rockchip_combphy_updatel(priv, RK3528_PHYREG83_RX_SQUELCH, val, RK3528_PHYREG83);
> +
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);

I suggest we add something like following here:

		rockchip_combphy_param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);

to ensure that U3 is enabled in case boot firmware disable the U3 port.

> +		break;
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	rate = clk_get_rate(priv->refclk);
> +
> +	switch (rate) {
> +	case REF_CLOCK_24MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_24m, true);
> +		if (priv->type == PHY_TYPE_USB3) {
> +			/* Set ssc_cnt[10:0]=00101111101 & 31.5KHz */
> +			val = FIELD_PREP(RK3528_PHYREG40_SSC_CNT, RK3528_PHYREG40_SSC_CNT_VALUE);
> +			rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_CNT, val,
> +						 RK3528_PHYREG40);
> +		} else if (priv->type == PHY_TYPE_PCIE) {
> +			/* tx_trim[14]=1, Enable the counting clock of the rterm detect */
> +			rockchip_combphy_updatel(priv, RK3528_PHYREG86_RTERM_DET_CLK_EN,
> +						 RK3528_PHYREG86_RTERM_DET_CLK_EN, RK3528_PHYREG86);
> +		}
> +		break;
> +	case REF_CLOCK_100MHz:
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
> +		if (priv->type == PHY_TYPE_PCIE) {
> +			/* PLL KVCO tuning fine */
> +			val = FIELD_PREP(RK3528_PHYREG6_PLL_KVCO, RK3528_PHYREG6_PLL_KVCO_VALUE);
> +			rockchip_combphy_updatel(priv, RK3528_PHYREG6_PLL_KVCO, val,
> +						 RK3528_PHYREG6);
> +
> +			/* su_trim[6:4]=111, [10:7]=1001, [2:0]=000, swing 650mv */
> +			writel(0x570804f0, priv->mmio + RK3528_PHYREG42);
> +		}
> +		break;
> +	default:
> +		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	if (device_property_read_bool(priv->dev, "rockchip,ext-refclk")) {
> +		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
> +
> +		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
> +			val = FIELD_PREP(RK3528_PHYREG42_CKDRV_CLK_SEL,
> +					 RK3528_PHYREG42_CKDRV_CLK_CKRCV);
> +			val |= FIELD_PREP(RK3528_PHYREG42_PLL_LPF_R1_ADJ,
> +					  RK3528_PHYREG42_PLL_LPF_R1_ADJ_VALUE);
> +			val |= FIELD_PREP(RK3528_PHYREG42_PLL_CHGPUMP_CUR_ADJ,
> +					  RK3528_PHYREG42_PLL_CHGPUMP_CUR_ADJ_VALUE);
> +			val |= FIELD_PREP(RK3528_PHYREG42_PLL_KVCO_ADJ,
> +					  RK3528_PHYREG42_PLL_KVCO_ADJ_VALUE);
> +			rockchip_combphy_updatel(priv,
> +						 RK3528_PHYREG42_CKDRV_CLK_SEL		|
> +						 RK3528_PHYREG42_PLL_LPF_R1_ADJ		|
> +						 RK3528_PHYREG42_PLL_CHGPUMP_CUR_ADJ	|
> +						 RK3528_PHYREG42_PLL_KVCO_ADJ,
> +						 val, RK3528_PHYREG42);
> +
> +			val = FIELD_PREP(RK3528_PHYREG6_PLL_KVCO, RK3528_PHYREG6_PLL_KVCO_VALUE);
> +			rockchip_combphy_updatel(priv, RK3528_PHYREG6_PLL_KVCO, val,
> +						 RK3528_PHYREG6);
> +		}
> +	}
> +
> +	if (priv->type == PHY_TYPE_PCIE) {
> +		if (device_property_read_bool(priv->dev, "rockchip,enable-ssc"))
> +			rockchip_combphy_updatel(priv, RK3528_PHYREG40_SSC_EN,
> +						 RK3528_PHYREG40_SSC_EN, RK3528_PHYREG40);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct rockchip_combphy_grfcfg rk3528_combphy_grfcfgs = {
> +	/* pipe-phy-grf */
> +	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
> +	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
> +	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
> +	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
> +	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
> +	.pipe_clk_24m		= { 0x0004, 14, 13, 0x00, 0x00 },
> +	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
> +	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
> +	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
> +	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
> +	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
> +	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
> +	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x110 },
> +	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x00 },
> +	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x101 },
> +	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },

And adding something like this:

	/* pipe-grf */
	.u3otg0_port_en		= { 0x0044, 15, 0, 0x0181, 0x1100 },

Should be possible with ("phy: rockchip: naneng-combphy: Enable U3 OTG
port for RK3568") [1].

Most RK3528 boards I have come across this far seem to use PCIe instead
of USB3, so having boot firmware disable U3 early (to help support USB
gadget in boot firmware) and instead having this PHY driver re-enable U3
when needed seem most logical to me.

I will push an updated U-Boot rk3528 branch [2] where I include such
early U3 port disable once source.denx.de is back online again.

[1] https://lore.kernel.org/r/20250723072324.2246498-1-jonas@kwiboo.se
[2] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

Regards,
Jonas

> +};
> +
> +static const struct rockchip_combphy_cfg rk3528_combphy_cfgs = {
> +	.num_phys	= 1,
> +	.phy_ids	= {
> +		0xffdc0000,
> +	},
> +	.grfcfg		= &rk3528_combphy_grfcfgs,
> +	.combphy_cfg	= rk3528_combphy_cfg,
> +};
> +
>  static int rk3562_combphy_cfg(struct rockchip_combphy_priv *priv)
>  {
>  	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
> @@ -1213,6 +1393,10 @@ static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
>  };
>  
>  static const struct of_device_id rockchip_combphy_of_match[] = {
> +	{
> +		.compatible = "rockchip,rk3528-naneng-combphy",
> +		.data = &rk3528_combphy_cfgs,
> +	},
>  	{
>  		.compatible = "rockchip,rk3562-naneng-combphy",
>  		.data = &rk3562_combphy_cfgs,


