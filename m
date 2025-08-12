Return-Path: <linux-kernel+bounces-764314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AFDB22150
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4177B8073
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2282E425B;
	Tue, 12 Aug 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZUFI4Ubw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E102E2665;
	Tue, 12 Aug 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987554; cv=none; b=nlmbEI5vdmYQb9eJllEZU42pIXlCdO2jQIPmwpQMBIKqPnmFEXdvsz6zOvhZxGD4Yns4uI0A6Vg4FpKWY9cmuctrENexk5rxc4aYHTvyj4nN2aXa5kPrdIJKNT+v2I3HhLMcRtA5WGgEHIQDOpfxAUfDwAJ++Dmhlp/qlM0VooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987554; c=relaxed/simple;
	bh=yhEB5IEIXi8cGIHPwe/C42JhYdoMVx7oFeqpUUUk2FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhCxZjShSdfJyrHrVoVeaYgh+TMQNyTM3c9wGu82nG/+vrz1J/U9BsXsEZIgxMuk1Sq2dp7JEdf3+dOE1/OdVvwWiz8FcxleX0+30e/iR8VZXTXLzpT8nl2QTxLUdZB5UgCSWoD24xBx6OPYXC2ze4O/XIbRmDXVzEtGUwbNSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZUFI4Ubw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=u/GlA9c7JgMPGjQHtJLx36RU8AROSBuEm27xFuxdPGc=; b=ZUFI4UbwukBnQD7k4OWO4J0FIE
	/raIVD61SLVJKasvghVF86zTGeNQCVjNhlyNTiv/9Jqbba62vQGQE32XWahOtf8qaRPU4aJT/gGGf
	5+d432p3iRPyNszwjTpKDYcClRKtINJFZbNI1cTd8qxWaIzNBH8WPUE0jytseXSUl2nGxlwHbrjlt
	p4IsnIc+eu3t5Y34UAFkaRYrwMUx9A1XolOw0LEhT1KUyeTj/oddTMLPdkEQJJQNovU7RQa+3DLMB
	HMVmSvarD8DqF8Vk+eeHoJuMrYjD3aqKhTooqSN/iCzf1bkNAT1zdeXxo7hog0zUOIr2WW/fofzUv
	8g+JyznA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulkQe-0001tw-TI; Tue, 12 Aug 2025 10:32:20 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma Systems
Date: Tue, 12 Aug 2025 10:32:16 +0200
Message-ID: <20250812083217.1064185-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250812083217.1064185-1-heiko@sntech.de>
References: <20250812083217.1064185-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The DisplayPort carrier is a very simple baseboard only providing serial,
ethernet and a displayport output.

But its main functionality is that it routes the Analogix eDP controller
to this DisplayPort output, which allows to test that controller simply
by hooking it up to a suitable monitor.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..4a64434ad6ea 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1192,9 +1192,11 @@ properties:
           - const: tsd,rk3588-jaguar
           - const: rockchip,rk3588
 
-      - description: Theobroma Systems RK3588-Q7 with Haikou baseboard
+      - description: Theobroma Systems RK3588-Q7 with baseboards
         items:
-          - const: tsd,rk3588-tiger-haikou
+          - enum:
+              - tsd,rk3588-tiger-displayport-carrier
+              - tsd,rk3588-tiger-haikou
           - const: tsd,rk3588-tiger
           - const: rockchip,rk3588
 
-- 
2.47.2


