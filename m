Return-Path: <linux-kernel+bounces-725506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD487B00002
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEC691C87543
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C972E7160;
	Thu, 10 Jul 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hOw9ulEH"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AC2E5B3E;
	Thu, 10 Jul 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145305; cv=none; b=Mml0jkm56LfWu4HY7lx+X1L29hbL6pd34mC/4R7w6nsX4fs+l92SValgJPzEQcOG1RoRlOx6VrEdzaZr+QNOnsX5bwvhtJJ6ItQRA8z7ZlCa7jTq/ZDOfaEpsoQE+mYD2m2GScb9bxdxYL5OygjPP+w58+v7sygLOscQeBoBmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145305; c=relaxed/simple;
	bh=XAfxwkl6u/TGKVECzRp8X5Ne/5Z3euGWuMcFH1hLCSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEYMavjmFYk/srDooNWf4uH1RC/D+cWcupZumrLlQrddhf0kjcZ6aosicpfj9080+O4bNwoSJ9t8gIJAyJebtVNEifxzkb8o0jPuJsiReZ/pwLrLdjtsTBHLZR7F1m0QTHYXRT7wyqO2mXcLa20y5OhAp+VZJec1Qd1Vfz/TFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hOw9ulEH; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=u0doyyzVzbvs/veF0uzJJxh1mFAme265poBUR2M8XYM=; b=hOw9ulEHrjSWxSo0zKJNTZBsSQ
	4Z0XyYkdULUrmfkbPiKTxRHoaJ7CB9NSvctEnIjMlSgIaX4xli/Wp4N+n61QHF77mi51gOB8giD1g
	9QxSvev00qreUEiZXcjGMjz7UOedpVZLKv+SIY2wneNFX4PQ3iX5E9LOV8dr+eG4lo3MFyw24Q3L/
	ls+aoBgb5Pg86K6P2+5z1A96cocEfLwHvjQfjT7rHm6HYtI1E1uXUbAF64Z042iksbKzRjEcd76mn
	NRTahwVPf4nhWCv1gcCBrCjvTQQ3SWTLCRL8Vw8MvDRw0yV89bOkPlZSJUPTsS93qFDN3xPaelRwb
	BSyd16zw==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uZp20-0004He-45; Thu, 10 Jul 2025 13:01:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix pinctrl node names for RK3528
Date: Thu, 10 Jul 2025 13:01:32 +0200
Message-ID: <175214509879.1901332.8552512069913088208.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250621113859.2146400-1-jonas@kwiboo.se>
References: <20250621113859.2146400-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 21 Jun 2025 11:38:57 +0000, Jonas Karlman wrote:
> Following warnings can be observed with CHECK_DTBS=y for the RK3528:
> 
>   rk3528-pinctrl.dtsi:101.36-105.5: Warning (node_name_chars_strict):
>     /pinctrl/fephy/fephym0-led_dpx: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:108.38-112.5: Warning (node_name_chars_strict):
>     /pinctrl/fephy/fephym0-led_link: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:115.36-119.5: Warning (node_name_chars_strict):
>     /pinctrl/fephy/fephym0-led_spd: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:122.36-126.5: Warning (node_name_chars_strict):
>    /pinctrl/fephy/fephym1-led_dpx: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:129.38-133.5: Warning (node_name_chars_strict):
>     /pinctrl/fephy/fephym1-led_link: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:136.36-140.5: Warning (node_name_chars_strict):
>     /pinctrl/fephy/fephym1-led_spd: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:782.32-790.5: Warning (node_name_chars_strict):
>     /pinctrl/rgmii/rgmii-rx_bus2: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:793.32-801.5: Warning (node_name_chars_strict):
>     /pinctrl/rgmii/rgmii-tx_bus2: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:804.36-810.5: Warning (node_name_chars_strict):
>     /pinctrl/rgmii/rgmii-rgmii_clk: Character '_' not recommended in node name
>   rk3528-pinctrl.dtsi:813.36-823.5: Warning (node_name_chars_strict):
>     /pinctrl/rgmii/rgmii-rgmii_bus: Character '_' not recommended in node name
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Fix pinctrl node names for RK3528
      commit: d50bd46d387f7f6d2e5aa4ce1aeefd3c9b6776a4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

