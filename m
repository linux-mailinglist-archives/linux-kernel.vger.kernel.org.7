Return-Path: <linux-kernel+bounces-865877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2921BFE3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A11019C776E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571530103C;
	Wed, 22 Oct 2025 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="p2yos3Nf"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DDD2F4A19
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166457; cv=none; b=uNYPzNk3FKOtTBEr8UnfgG2YA+JJrDqSMD08clhRsYTnAZqko6wHZbnN/FdSiAl6EwyHQAc2YSLAVo+JFflZiwWkhWsG9Kc1tZfac2wcswoyxoyuYDjROdW3El/Q9/T2mSAqqkRuzKp5wjST6tm6COmh/1qXSj5qcAu/NcpsmYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166457; c=relaxed/simple;
	bh=XuoRQpGu85uToua5aCbvckIW16Pk6aE3sHCJvIzxZIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDNbAaG4KUYn4eoTlCcAPc7q+GgYhh5eDoqzBZdKaRZlbdASX61ql7AMkj7Hn11LC7n9tXl/7zs/Tni7CYmK2zv05Bk8dXEmeGNKlPLOZgtuCiACoKRfPX3own0dYVp77V3x1fTtOp9eZCy9tPrEhSO5Y5LdiWU/yCajk69RDVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=p2yos3Nf; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1761166454;
 bh=6By88Zpn3m6uq4P5zQ8yb72SxI9R7gfGj/HM/rNU4uY=;
 b=p2yos3NfqiRj77gGHMWV9fn4tyyltj4MxIca5FvX6Yf0laIC9h2aFJRqhRDVkHR9i6W7KqxLO
 lP65HcezySG1vAZNrjjodkkUsgunqw48sbdwoaethLWQSXn9iMwxliwQyA9nIzDZOVLuK6r69LK
 IU45JEL+SxhjGKHwUk+nMCzbQKYdqOYaF6ZdbdTwtfIOp1uoXIuAILZdZOIyelVCkJ7TurLik7U
 vJZyGZ14lMgxf+mRJaUmqItejqcORIs9s/ms2uWebQ93rn3tKgTUfTAGeLf5jPPVa4bma575eeL
 waFWmp9damENvyNUn2MoU5fKzIU9WxfEjdtjMEAj6eGw==
X-Forward-Email-ID: 68f94203b0b13797a645472d
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.3.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <fe54009a-ee39-43a0-a337-93c46cd7dabe@kwiboo.se>
Date: Wed, 22 Oct 2025 22:43:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ethernet: stmmac: dwmac-rk: Add RK3506 GMAC support
To: Heiko Stuebner <heiko@sntech.de>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Wu <david.wu@rock-chips.com>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-5-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20251021224357.195015-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Heiko,

On 10/22/2025 12:43 AM, Heiko Stuebner wrote:
> From: David Wu <david.wu@rock-chips.com>
> 
> Add the needed glue blocks for the RK3506-specific setup.
> 
> The RK3506 dwmac only supports up to 100MBit with a RMII PHY,
> but no RGMII.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 51ea0caf16c1..e1e036e7163c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -827,6 +827,84 @@ static const struct rk_gmac_ops rk3399_ops = {
>  	.set_speed = rk3399_set_speed,
>  };
>  
> +#define RK3506_GRF_SOC_CON8		0X0020
> +#define RK3506_GRF_SOC_CON11		0X002c

Maybe 0x0020 and 0x002c (lower case x) ?

> +
> +#define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
> +
> +#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
> +#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
> +
> +#define RK3506_GMAC_CLK_SELET_CRU	GRF_CLR_BIT(5)
> +#define RK3506_GMAC_CLK_SELET_IO	GRF_BIT(5)

s/SELET/SELECT/

> +
> +#define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
> +#define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
> +
> +static void rk3506_set_to_rmii(struct rk_priv_data *bsp_priv)
> +{
> +	struct device *dev = bsp_priv->dev;
> +	unsigned int id = bsp_priv->id, offset;
> +
> +	if (IS_ERR(bsp_priv->grf)) {
> +		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
> +		return;
> +	}

Please drop this, it is already checked in rk_gmac_setup().

> +
> +	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
> +	regmap_write(bsp_priv->grf, offset, RK3506_GMAC_RMII_MODE);
> +}
> +
> +static int rk3506_set_speed(struct rk_priv_data *bsp_priv,
> +			    phy_interface_t interface, int speed)
> +{
> +	struct device *dev = bsp_priv->dev;
> +	unsigned int val, offset, id = bsp_priv->id;
> +
> +	switch (speed) {
> +	case 10:
> +		val = RK3506_GMAC_CLK_RMII_DIV20;
> +		break;
> +	case 100:
> +		val = RK3506_GMAC_CLK_RMII_DIV2;
> +		break;
> +	default:
> +		dev_err(dev, "unknown speed value for RMII! speed=%d", speed);
> +		return -EINVAL;
> +	}
> +
> +	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
> +	regmap_write(bsp_priv->grf, offset, val);
> +
> +	return 0;

This should probably be converted to use rk_reg_speed_data with
something like:

static const struct rk_reg_speed_data rk3506_reg_speed_data = {
	.rmii_10 = RK3506_GMAC_CLK_RMII_DIV20,
	.rmii_100 = RK3506_GMAC_CLK_RMII_DIV2,
};

and:

	return rk_set_reg_speed(bsp_priv, &rk3506_reg_speed_data,
				offset, interface, speed);

> +}
> +
> +static void rk3506_set_clock_selection(struct rk_priv_data *bsp_priv,
> +				       bool input, bool enable)
> +{
> +	unsigned int value, offset, id = bsp_priv->id;
> +
> +	offset = (id == 1) ? RK3506_GRF_SOC_CON11 : RK3506_GRF_SOC_CON8;
> +
> +	value = input ? RK3506_GMAC_CLK_SELET_IO :
> +			RK3506_GMAC_CLK_SELET_CRU;

s/SELET/SELECT/

Regards,
Jonas

> +	value |= enable ? RK3506_GMAC_CLK_RMII_NOGATE :
> +			  RK3506_GMAC_CLK_RMII_GATE;
> +	regmap_write(bsp_priv->grf, offset, value);
> +}
> +
> +static const struct rk_gmac_ops rk3506_ops = {
> +	.set_to_rmii = rk3506_set_to_rmii,
> +	.set_speed = rk3506_set_speed,
> +	.set_clock_selection = rk3506_set_clock_selection,
> +	.regs_valid = true,
> +	.regs = {
> +		0xff4c8000, /* gmac0 */
> +		0xff4d0000, /* gmac1 */
> +		0x0, /* sentinel */
> +	},
> +};
> +
>  #define RK3528_VO_GRF_GMAC_CON		0x0018
>  #define RK3528_VO_GRF_MACPHY_CON0	0x001c
>  #define RK3528_VO_GRF_MACPHY_CON1	0x0020
> @@ -1808,6 +1886,7 @@ static const struct of_device_id rk_gmac_dwmac_match[] = {
>  	{ .compatible = "rockchip,rk3366-gmac", .data = &rk3366_ops },
>  	{ .compatible = "rockchip,rk3368-gmac", .data = &rk3368_ops },
>  	{ .compatible = "rockchip,rk3399-gmac", .data = &rk3399_ops },
> +	{ .compatible = "rockchip,rk3506-gmac", .data = &rk3506_ops },
>  	{ .compatible = "rockchip,rk3528-gmac", .data = &rk3528_ops },
>  	{ .compatible = "rockchip,rk3568-gmac", .data = &rk3568_ops },
>  	{ .compatible = "rockchip,rk3576-gmac", .data = &rk3576_ops },


