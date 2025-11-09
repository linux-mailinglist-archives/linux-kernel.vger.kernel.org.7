Return-Path: <linux-kernel+bounces-892053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F92C4434C
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6123B1CCB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0069430506D;
	Sun,  9 Nov 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="UcpRSje6"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8333303C85
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 17:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707970; cv=none; b=nTtw0AFU/42qWYz8uH8X74O+v5QtodRyiPk65QL6MWdTFM6btvpsuAQgXiizKq7xOyyj8ZuGUt2M/uMqzDl1CcIjCBuMJEvxk69l8DYW7Cv0eOUCCNBlT/OIHc7IuQBOrnRnOAhIjp7UDL9zLFgaK0DUmCuH0RUSMoVZVixSD08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707970; c=relaxed/simple;
	bh=BqSH1sGgWhPw1gfWfRVD15p+7RBCWiB0kCRAPxIY/aE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZWlCwr6+erdGGoCksz1xBzWlxIwH9RPC7S9ku3fSw43n/QSBmQ3WssneWpav1KOmFHWO7XHDhws6LMELs1B6M9+lsdqHiuizOzl6KvZaXtUxhlG+gfReEr31fHwriezsRuc8Z/uIjS5fx958qBjjOIG+tOoocuTkN8goIhyM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=UcpRSje6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1762707964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aDs8kbwCuzv3Qb5BmYXwYP5JldsXD1hYrMKIH0qG1uI=;
	b=UcpRSje6/RzpyOYo4IZVlmL2TUgeeFWnCvceLyMfVeHIEb4eBlwaR4CcWlVCWGoU5zu5AP
	lWuWl/4+f8LkTxjsEXbKksxigl1NBB4uwVnjcrkbqn+RTZLiBdOxrk6lrzauFKc4UizPWV
	FjTkOq0ruslJRee4zAL2oZIqjFYKEN4IKoL0O9GtL6mUvilEMEorHZ7siId2w1rf54CRA2
	6zlFDjEDDuiNaqi9gaw5YaZRZis4jswAhpo7lK6PnLAw/RYNhPJ+KfkuiIvEMtACcPrGRE
	ajwH+X7r3SPagdcLBbucKChCCcUjslodsqliwqcqD07DCVAwVF1A3sf0p+wjEQ==
From: Diederik de Haas <diederik@cknow-tech.com>
Date: Sun, 09 Nov 2025 18:05:26 +0100
Subject: [PATCH 1/2] arm64: dts: rockchip: Simplify usb-c-connector port on
 rk3566-pinenote
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-1-ed38d200cc04@cknow-tech.com>
References: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
In-Reply-To: <20251109-rk3566-pinenote-dt-fixes-upstream-v1-0-ed38d200cc04@cknow-tech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Samuel Holland <samuel@sholland.org>
Cc: hrdl <git@hrdl.eu>, phantomas <phantomas@phantomas.xyz>, 
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
X-Migadu-Flow: FLOW_OUT

The USB-C connector on the PineNote has only 1 port, so there's no need
for a 'ports' node with address-/size-cells properties as a single
'port' node suffices.

This fixes the following DT validation issue:

  Warning (graph_child_address): /i2c@fe5c0000/tcpc@60/connector/ports:
    graph node has single child node 'port@0',
    #address-cells/#size-cells are not necessary

Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
index 5c6f8cc401c9..7c65fe4900be 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
@@ -485,16 +485,9 @@ connector {
 			typec-power-opmode = "default";
 			pd-disable;
 
-			ports {
-				#address-cells = <0x1>;
-				#size-cells = <0x0>;
-
-				port@0 {
-					reg = <0x0>;
-
-					typec_hs_usb2phy0: endpoint {
-						remote-endpoint = <&usb2phy0_typec_hs>;
-					};
+			port {
+				typec_hs_usb2phy0: endpoint {
+					remote-endpoint = <&usb2phy0_typec_hs>;
 				};
 			};
 		};

-- 
2.51.0


