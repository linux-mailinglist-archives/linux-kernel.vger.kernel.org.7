Return-Path: <linux-kernel+bounces-723698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2660AAFEA12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B57482794
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8092E172E;
	Wed,  9 Jul 2025 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="XmaZB6XJ"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3A2E0B6E;
	Wed,  9 Jul 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067422; cv=none; b=oWxxYOSjaolqOL2q/EqqQUpUtQHtCx8RUuQdTceO2CEGnwWsOEeuIQGtjaAzslvR3GJ+88PDjKn8jNPQdJtNwyqRADgbCCpHu9g/2gthKarnjFspNAb6gfnNSaLv7ncH2i8FQ/Ab9KoGWRfHRvrMOqSp6YEU4sYUaT0hyoIIChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067422; c=relaxed/simple;
	bh=KvdRiVzd9y8bYqaEqQtCdCidc7FyB9JJR7/moClKn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMkYbJFrMo/XSilNwzkL7uxS+qWxShvGIzww/l5EsLvgMyfekJcmsugC9EKxsnJdRhqtT6o7xuTyW2hPeFJIR06jRrYMuMauxh0DOjJkPJlmTnk/KTTOZ6Y8iQtxV7xHnIFLQ1uhzrF949q2zYOFJDPTjqD1E3cu+Lxt0a1cN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=XmaZB6XJ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1752067418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaiBlNQO0f338PUKKeTaAyF8Owpl4mcYk0JrGqHmrxo=;
	b=XmaZB6XJ1P2GHWPYaL9mf0HQnu87zeJl/QveWabRDaIlavDcgdSKOWErsAL8dD7RUNEH0G
	xTpLZ36nEA5vgMdoDxpIpbUUdymacJByRWS3NHinvifacPrehEHbJ9Iw/HBv1VqfbYulIb
	Y4aYRuYWS0br56qGWC9kYt9Cme+GD84N/4yByH50EsrpYHFEZbLV1O78SoD7zFoupHCilI
	YNfKV7fTUt207Vt9LTXt3TVNUDQCaTFcZa1h08OX+aixbG4DPjpeuuN+E6LNrNqZDyZGsM
	sOdRahQv+Euis85S7R6y0+rIvhg33SwNXXEpro0uq2YleanAc5Wi2sJ5z8toKA==
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
Subject: [PATCH v4 06/10] arm64: dts: rockchip: Simplify mipi_out endpoint on rk3399 RP64 dtso
Date: Wed,  9 Jul 2025 15:15:19 +0200
Message-ID: <20250709132323.128757-7-didi.debian@cknow.org>
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

The only thing actually added here is a single endpoint on mipi_out,
which is already defined in rk3399-base.dtsi, so it's simpler to just
reference that phandle, which allows the removal of several properties.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 .../dts/rockchip/rk3399-rockpro64-screen.dtso | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso
index a26c8e05c13b..dabe535f2111 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64-screen.dtso
@@ -52,19 +52,6 @@ &mipi_dsi {
 	#size-cells = <0>;
 	status = "okay";
 
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		mipi_out: port@1 {
-			reg = <1>;
-
-			mipi_out_panel: endpoint {
-				remote-endpoint = <&mipi_in_panel>;
-			};
-		};
-	};
-
 	mipi_panel: panel@0 {
 		compatible = "feiyang,fy07024di26a30d";
 		reg = <0>;
@@ -80,6 +67,12 @@ mipi_in_panel: endpoint {
 	};
 };
 
+&mipi_out {
+	mipi_out_panel: endpoint {
+		remote-endpoint = <&mipi_in_panel>;
+	};
+};
+
 &pwm0 {
 	status = "okay";
 };
-- 
2.50.0


