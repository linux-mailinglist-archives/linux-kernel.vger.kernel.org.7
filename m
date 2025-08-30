Return-Path: <linux-kernel+bounces-793117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A2B3CECF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8AE2083A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B92DA77D;
	Sat, 30 Aug 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="hw1b2B+F"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A762C236D;
	Sat, 30 Aug 2025 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756579430; cv=none; b=Dwg/7Oami4nVYMC8mnNnuILB6gvFC/WfiZfJ45bwqAnrll7T1ywqMzm0uwJ/5BqAn2lObeTPF9CqcjaHecbJAbICRaQhptNDoemVMPBYzB5WNNjy4dNKG91a08GkAsyyx5OhtwE4YIMntcB7DgYKP2JaRnlvxJS7hTRSZBDEk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756579430; c=relaxed/simple;
	bh=2VuAPwuoA1GXUFa+VxaLe7tmOSJ68HP5ugx/V7/naH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spDY8egKZ1YcrAXfudUVVyJlk1gyEfjXCT1++pQSz++nZXF2PF4pwxlDUQFRVnS5vQk6XUFGx7fxXlbM8v/xd6JN38CKAALa3beC2QIeQ1g6gXEbVzwaFAy25t6r+SbfRIUesgOkxIKciWrTMQi+T52f7KYU1ogLhntA/YJw5Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hw1b2B+F; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=z7dRJ0YqV0TfQ8NQVDQWPuDNydvgZBcIbL2hEeK72Lo=; b=hw1b2B+F3Y6HZoHS6mJC3qs6fR
	MAmlBhUjB32I4aDktTwAJ9Mb4pYIT4dPjeQKsrMjn4nAQNMPsjVgHCSYsCCB4H8cs9LmtYGzJWluk
	sNdYTls8VrTke8CHzxIuxXCNmFWRxNiQSCy18DiWA9b8ZR/kVMzXlHlBWy4gPosN/9IeT5c22CfO9
	rY71/vvGewXDM/NMN8IrdDCnefkVi3vU71lFhMGAdBPJ6K7lhgrHMvFbPAn25iSziSu8SrnPIxG6y
	rqNXzbmck9/vt9xsyVrugpUmSPNgxyrLBkxPZtOA0RkTz3dCdZH8ZRf/P64hRfhCLH+sd2SCLqB7u
	3uGdbJvg==;
Received: from [88.128.88.73] (helo=phil.t-mobile.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1usQY4-0001uA-26; Sat, 30 Aug 2025 20:43:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and NanoPi Zero2
Date: Sat, 30 Aug 2025 20:43:33 +0200
Message-ID: <175657940688.3587027.2905487705008313025.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250717103720.2853031-1-jonas@kwiboo.se>
References: <20250717103720.2853031-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Jul 2025 10:37:02 +0000, Jonas Karlman wrote:
> This series adds dt-bindings and initial device tree for the following
> Rockchip RK3528A boards:
> - Radxa ROCK 2A/2F
> - ArmSoM Sige1
> - FriendlyElec NanoPi Zero2
> 
> The bt/wifi_reg_on pins are described in the device tree using
> rfkill-gpio nodes.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
      commit: ba9d9ac745b110e937619d0379456f4906700d2f
[2/6] arm64: dts: rockchip: Add Radxa ROCK 2A/2F
      commit: dc16a221c07b5336d4efb1cfc0bfd7089eea1fce
[3/6] dt-bindings: arm: rockchip: Add ArmSoM Sige1
      commit: 5e1f607a05d848ee7e8fd161c966af5877a5721c
[4/6] arm64: dts: rockchip: Add ArmSoM Sige1
      commit: 7cedc908a877d7c003aa0c205fb088bb6c15f5d4
[5/6] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
      commit: f4159921a4f51779680026fd923d59186916412b
[6/6] arm64: dts: rockchip: Add FriendlyElec NanoPi Zero2
      commit: cf9a5be7cb3f93d384531abcd5256b04e5650370

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

