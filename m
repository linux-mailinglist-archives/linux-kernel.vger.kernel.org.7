Return-Path: <linux-kernel+bounces-742681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4345B0F54E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D590A1897817
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B3B2F2C50;
	Wed, 23 Jul 2025 14:30:22 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111E24BC09;
	Wed, 23 Jul 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281022; cv=none; b=U4XoWdLHn4u1ZOrrK+sbhcyKv9tIND0W/mSEL0BB29UtNeN9vm/PRr6+1eOpF3RL0VWDK6K3gWf5KKpyiYBA04tnCz9/CT8AX0uf+j7QvbrWkji7vj343jaF90mJ3FobO1MIuOAun6GC3TmDUEGlR6Y6BfnIbmHocJ7s7vYq2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281022; c=relaxed/simple;
	bh=AbZb5rI/gYo+qTcf+dpPtDgq68HPZ9t6Qo1QO26okX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=petap0gwBhMPRuX9HWI05kVJtPx28p3msVl69a1IyDOgnf6agK8HLrzIFUHa/bNlc29bu6/ZJLqgoeYXvY+ntbKvr/DevPaMv2bVF7YpTLowaUitlkXC4AEGhmTK80eqAi32vXH7CaiOHsu2Sz/YqFGqv02GbciIQsP/i43UOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.181])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1d03a2599;
	Wed, 23 Jul 2025 22:30:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	vkoul@kernel.org,
	ziyao@disroot.org
Subject: Re: [PATCH 07/11] arm64: dts: rockchip: Add USB nodes for RK3528
Date: Wed, 23 Jul 2025 22:30:06 +0800
Message-Id: <20250723143006.1083489-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250723122323.2344916-8-jonas@kwiboo.se>
References: <20250723122323.2344916-8-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaThpCVh1JGRlKGU0dSx5LTlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VKQ0pZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0tVSktLVU
	tZBg++
X-HM-Tid: 0a9837b12a7003a2kunm2a36e8dcff846
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6P006STo4ODEpCDEODBk3HUIt
	CQhPChpVSlVKTE5ISUNKS0pOTkhMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUpDSllXWQgBWUFJTENJNwY+

Hi,

> The DWC3 node does not contain any default phys because out of current
> and pending supported boards only one board, ROCK 2A, can use USB3.
> Remaining boards use the Naneng Combo PHY for PCIe instead of USB3.

I have other RK3528 boards with USB3 and can test this in a few days.
Or do you think that usb3-phy should be added in the dts of the device?

> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> index 85bc3f5aa2c7..3e51a3f51e05 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> @@ -243,6 +243,29 @@ soc {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> 
> +		usb_host0_xhci: usb@fe500000 {
> +			compatible = "rockchip,rk3528-dwc3", "snps,dwc3";
> +			reg = <0x0 0xfe500000 0x0 0x400000>;
> +			clocks = <&cru CLK_REF_USB3OTG>,
> +				 <&cru CLK_SUSPEND_USB3OTG>,
> +				 <&cru ACLK_USB3OTG>;
> +			clock-names = "ref_clk", "suspend_clk", "bus_clk";
> +			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> +			power-domains = <&power RK3528_PD_VPU>;
> +			resets = <&cru SRST_A_USB3OTG>;
> +			dr_mode = "otg";
> +			phy_type = "utmi_wide";
> +			snps,dis_enblslpm_quirk;
> +			snps,dis-del-phy-power-chg-quirk;
> +			snps,dis-tx-ipgap-linecheck-quirk;
> +			snps,dis-u1-entry-quirk;
> +			snps,dis-u2-entry-quirk;
> +			snps,dis-u2-freeclk-exists-quirk;
> +			snps,parkmode-disable-hs-quirk;
> +			snps,parkmode-disable-ss-quirk;

Maybe "snps,dis_u2_susphy_quirk" is needed?
Downstream kernels add this on USB2.0 only devices:
https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/boot/dts/rockchip/rk3528-demo.dtsi#L474

> +		u2phy: usb2phy@ffdf0000 {
> +			u2phy_otg: otg-port {
> +			u2phy_host: host-port {

I think it would be better to call it usb2phy, usb2phy0_otg and usb2phy0_host?
In this way, we can put these USB nodes close together in the device's dts.

--
2.25.1



