Return-Path: <linux-kernel+bounces-872052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A558C0F2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC08A4FE5B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812EB3081AC;
	Mon, 27 Oct 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="NsxXLJec"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482A1E1C22
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580669; cv=none; b=mwdfZSqpd9HzjxPN6bo2IgxBTi6yv3brwAzmDteI1BW/02kHxDqpRHlURoE8/M2SOMBPGGXxnE1hRvpAZ/yJgNfjbxCHzcmSYqGxBtIzvzeZBqtEiUxvHrNmt9FRLRqpp57N+/ySzgDgx/34sphxq2TrkmGuuJ1jGy1ZGtdFO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580669; c=relaxed/simple;
	bh=cNeEoNZMNjs7g8eJeKWktT8oOWjoRNKkmyvCV4rbGdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUcNhQ/tRH+7LCvHXa5rtiGaE1o25v5t3pRMQfF720mkbFqraoLMEl0Qjbaz2EVkj6BkKvwu4itvMET6VfDZjGyaf6XdiJvaXrHu+ZcGo/TpFL751gwt6EmgbBXg5Kci2ES0CUQh/lEmzOYnZqmCSSdRUy+2GS1oAOtbpDQDPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=NsxXLJec; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1761580664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7DktUCNizUthk/eVYWcphe4sD34yOq87O4J/7ILxNWI=;
	b=NsxXLJecBlL5+cyKyvFiI6hida+cTbMcscYIDDa4jS3yYGcrOfZXzB2o/c4EGF/VFrf8PB
	bKQNj9HmzilsHCag2fRU+g6lVGv519KVy4+QcBPsO8hIReP20iDjiVBC4qVtGKvOgAq7zA
	VzlG45KebSh6HL5QLDqD2pjnofyLBr6hTW/DslhwLyxrgK5TgEgBC05eKNAuj5NWuRZ6BB
	TdXrukHsYWbyaCJE2rCJi9AkS4343Q9Lec/GXs/N9YOjXdJe5GOw0XOURI1fhQCqt7FfvC
	4UKvRaZ2p3K4H2bV+KfaNN8R1GMa16fMEVwhkhRLjVOKqTYbGPLzFGTpX0lP/A==
From: Diederik de Haas <diederik@cknow-tech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Fix vccio4-supply on rk3566-pinetab2
Date: Mon, 27 Oct 2025 16:54:28 +0100
Message-ID: <20251027155724.138096-1-diederik@cknow-tech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Page 13 of the PineTab2 v2 schematic dd 20230417 shows VCCIO4's power
source is VCCIO_WL. Page 19 shows that VCCIO_WL is connected to
VCCA1V8_PMU, so fix the PineTab2 dtsi to reflect that.

Fixes: 1b7e19448f8f ("arm64: dts: rockchip: Add devicetree for Pine64 PineTab2")
Cc: stable@vger.kernel.org
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Diederik de Haas <diederik@cknow-tech.com>
---
Changes since v1:
- Added Fixes tag (Dragan)
- Added R-b tag

 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
index d0e38412d56a..08bf40de17ea 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
@@ -789,7 +789,7 @@ &pmu_io_domains {
 	vccio1-supply = <&vccio_acodec>;
 	vccio2-supply = <&vcc_1v8>;
 	vccio3-supply = <&vccio_sd>;
-	vccio4-supply = <&vcc_1v8>;
+	vccio4-supply = <&vcca1v8_pmu>;
 	vccio5-supply = <&vcc_1v8>;
 	vccio6-supply = <&vcc1v8_dvp>;
 	vccio7-supply = <&vcc_3v3>;
-- 
2.51.0


