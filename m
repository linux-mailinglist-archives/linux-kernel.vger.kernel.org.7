Return-Path: <linux-kernel+bounces-723700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AFAFEA17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9C444E4B7A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3062E5B0D;
	Wed,  9 Jul 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="J83Rg085"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F922E174A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067424; cv=none; b=diHpk7QKTlt50c8N/UxA+L5Akh6hIYMdnrvqd3SnAns+wBPvHpTgKOiEOoFanq+8Fp6SxIPqfqWRP85MBP8botnUyovftSnxft3Z4NjBc/RlePIATKIg6+t3+JCDaTzADHyWNQaGCTxHjORk4ssGUoJ1Mo2AcnUsdlz/tP3qOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067424; c=relaxed/simple;
	bh=QDduJvC/5cNs1aCofqNCkLX2UcDB8NxT18fZG9lmPDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkfZyVSCfDb7Nh7DGZinHvLxijn+Y0U6mN00KyUh9hQNPblOxL5xaSXtMJMztmHyc2MfY49ZDQlpxIAKqQ+HnjuolUjuseZLIDUXjW7Zuow6VU8/pyhhUG/xGANZ0k4lHmCGClUI+AqbbRq/TGRTBWDZttQdC+9pRdXvtdiRF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=J83Rg085; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752067421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYtxvQntJrQzDe3coaU4yovvxAekHNN2pEKLjqZB3iA=;
	b=J83Rg0853eudvxnf9NiHH5SXvgmplIlEz6jQFGT5erQWarfMlMWJSsVoSHKcYMcGXSmaWj
	nbEyMuNlMMun6XRsHbdZqYS0fVq24MirXh6ZMw0VDF+Abd/3bir6NWTFYPKY2MseM3FIXz
	1MTJ2sosgHACtA0Sguw6Ibf0LKdwMT1PwWrI49nYWC4NRqGatvHwYxAQ+QCl9pKZR/X0Xa
	oQGav8vmZnFtNdPaC8gEGUZDS5yJoQswWCmIZjUGL+G8iojPdus5RMrDLFUrOEoMLNWkpe
	6cUc0yotOjjagtnTmMdv5PPLDrVqxNf0Ra6SLIJliIOh1aD9puqjcAsKdCi7+A==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Johan Jonker <jbx6244@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH v4 08/10] arm64: dts: rockchip: Fix LCD panel port on rk3566-pinetab2
Date: Wed,  9 Jul 2025 15:15:21 +0200
Message-ID: <20250709132323.128757-9-didi.debian@cknow.org>
In-Reply-To: <20250709132323.128757-1-didi.debian@cknow.org>
References: <20250709132323.128757-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The MIPI DSI connector on the PineTab2 only has 1 port with 1 endpoint,
so drop the unit-address properties.

While at it, move 'rotation' property to its proper sorting position.

This fixes the following DTB validation warnings:

  node has a unit name, but no reg or ranges property

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
index 3473b1eef5cd..d0e38412d56a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
@@ -282,11 +282,11 @@ lcd: panel@0 {
 		reg = <0>;
 		backlight = <&backlight>;
 		enable-gpios = <&gpio0 RK_PC7 GPIO_ACTIVE_HIGH>;
-		rotation = <90>;
 		power-supply = <&vcc_3v3>;
+		rotation = <90>;
 
-		port@0 {
-			panel_in_dsi: endpoint@0 {
+		port {
+			panel_in_dsi: endpoint {
 				remote-endpoint = <&dsi0_out_con>;
 			};
 		};
-- 
2.50.0


