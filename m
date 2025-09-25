Return-Path: <linux-kernel+bounces-832904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E3BA0B74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54EAD1BC4F05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D550307AF9;
	Thu, 25 Sep 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="U7aAdhsn"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF719F40B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819509; cv=none; b=BGKvI4r33HOlrhQXtgo5GN9Ske5mHPhVwfoGP8Onbp4h7fzT1vpJyyCl5GE1jkQitS7/tOjjl5HYrHqRzlO2e5ONelMM3azhExpUiPwG4tsQHDnzugj5QA4eFxmbBHDwb3wMWI4z59L1/TuPZUPtP2X4Fy7ukiIC4lL6MZydims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819509; c=relaxed/simple;
	bh=+yHaFHvXClIDnXnv3QL0b/flkdlelcna8Kjpvqu6Iwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX3wZN+prWy0EQcrbIx/y7RLBPc+YA89k+dV+/wOJXlHR51WIns21JA4mIeMZdTsJcIi35SnnHQMX9s0QqLHybWDM5+OJWN6lVDYHGokP3s5QhkLX6hqOpO9/a9PVRU/M9VuAuEByeXZH8cTBrEqxVyud9ZiDE9to0NV5yc0qE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=U7aAdhsn; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1758819500;
 bh=dO7rc3cmOaRYh8vW051GrFKq6chUM5fRR/SwUUFClf4=;
 b=U7aAdhsn/xeYG8Yk5Lj3BYUgR7p1Sx/688hAhRU6WXr9GzbW4vzYZIxM9GWQAbhGwSq4gaw/d
 ChNfJrQ2F8wmXovqY+9zYcdWpEzdKWsPqEPsOSWDXiuexIZyK6xiKPv9Yg52P3YStLZ6o+WGYSH
 9c5LocqPfPaZ830Ah6QlawpQFFLVnGshsrm5gZ+XKPoxylHDtH6dwh5z3u174cPwbAyUJUa/xAw
 CG/xCAvAZlsFeVUltoxAd30t+YupF0Hl1ces8VKbnAxASywUWtMr2Sxyn94LX1bgE28sbFZ1sPB
 Mjk6HjkQANSfqk3jUwmwbRF/dO2fRZIW60YFWAfAQA/w==
X-Forward-Email-ID: 68d574a2af9b5343f17d00e7
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.14
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <da752790-da17-4d26-b9b2-8240b38b3276@kwiboo.se>
Date: Thu, 25 Sep 2025 18:58:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] arm64: dts: rockchip: Fix the 1Ghz ethernet on Qnap
 TS433
To: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "ukleinek@debian.org" <ukleinek@debian.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>
References: <20250925092923.2184187-1-heiko@sntech.de>
 <20250925092923.2184187-3-heiko@sntech.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20250925092923.2184187-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Heiko,

On 9/25/2025 11:29 AM, Heiko Stuebner wrote:
> While I want to remember that the dwmac on the TS433 was working at some
> point, it seems I had my network always connected to the 2.5G nic after
> that "point". And testing now revealed that the gmac does not actually
> manages to transfer data.
> 
> Currently the gmac is set to rgmii-id with no rx-/tx-delay values set
> which makes the driver use default values. Setting the delays to 0
> also does not provide a working interface.
> 
> The vendor kernel is running with phy-mode set to rgmii and delays of
>     tx_delay = 0x3c, rx_delay = 0x2f
> 
> As Andrew points out often, those delay values "are magic" and rgmii-id
> should definitly be used "with small values" for delays, if really needed.
> 
> The Rockchip vendor-kernel actually contains additional code in the dwmac
> driver to use the loopback function of a phy to find a window of usable
> delay values. Code can be found for example on [0] and the process is
> described in a document called "Rockchip GMAC RGMII Delayline Guide"
> which has made its way onto the internet in a lot of places [1].
> 
> So I used this process, with the interface set to rgmii-id to get values
> for this mode, which are in face lower than the ones for rgmii with
>     tx_delay = 0x21, rx_delay = 0x15
> and results in a working interface on the dwmac.
> 
> [0] https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr6.1/drivers/net/ethernet/stmicro/stmmac/dwmac-rk-tool.c
> [1] https://gitlab.com/firefly-linux/docs/-/blob/rk356x/firefly/Common/GMAC/Rockchip_Developer_Guide_Linux_GMAC_RGMII_Delayline_EN.pdf
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> index 5656554ca284..e8af92a011d6 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
> @@ -257,6 +257,8 @@ &gmac0_tx_bus2
>  		     &gmac0_rx_bus2
>  		     &gmac0_rgmii_clk
>  		     &gmac0_rgmii_bus>;
> +	rx_delay = <0x15>;
> +	tx_delay = <0x21>;

I do not understand why defining rx/tx_delay would change anything.

Setting these should currently not have any effect on the driver code
when phy-mode=rgmii-id is used, see below (next-20250924, dwmac-rk.c):


	switch (bsp_priv->phy_iface) {
	case PHY_INTERFACE_MODE_RGMII:
		dev_info(dev, "init for RGMII\n");
		bsp_priv->ops->set_to_rgmii(bsp_priv, bsp_priv->tx_delay,
					    bsp_priv->rx_delay);
		break;
	case PHY_INTERFACE_MODE_RGMII_ID:
		dev_info(dev, "init for RGMII_ID\n");
		bsp_priv->ops->set_to_rgmii(bsp_priv, 0, 0);
		break;


I have played around with a few patches that changes this and apply the
rx/tx_delay for rgmii-id modes (both Linux and U-Boot), see top of [2]
for Linux patches. Will try to get them on ML in a few days.

Currently, rk3588-firefly-itx-3588j.dts is the only RK board that define
rx/tx_delay and use rgmii-id mode, would be good to not define any more
rgmii-id + rx/tx_delay combo to reduce impact of a possible future
driver change.

[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20250924-rk3528/

Regards,
Jonas

>  	status = "okay";
>  };
>  


