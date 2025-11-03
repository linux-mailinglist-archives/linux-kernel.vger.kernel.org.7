Return-Path: <linux-kernel+bounces-883807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AEFC2E7A9
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 225C134C2E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A2530F53E;
	Mon,  3 Nov 2025 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="p4nkQcsx"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B44428FA9A;
	Mon,  3 Nov 2025 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213776; cv=none; b=i7vCw80pLFFKWo1l4UFIVuX3uF4kOdL5sGnyozoEs7t6bgjbAPyEkkLWfrdbOi/UZQ/zMpKmMYSGTk6DIDFCbP+aFFiJTI16rbujMhqrLQGbWtuO4j28/c5YN54wLjt9ZD4a57RNyjVw0Di7cDpj4U2yrKfDRqMTtbXgOd3Ig/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213776; c=relaxed/simple;
	bh=0BAi38JYOc640PJLMNDNtN2DkEA549h4b/Ah6eVKFQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpxzA+v53k1UVVFwDZVa4a/I2xyD4FpqOHHwy7A5gx7KcB2pN7QydpqJRmjy2FP1XU5xNQKzZro+CchtUAH4ZefvAtb2DPySbkfkkc72HoXzbSD++1yMBGdc8+JH3eTf8twGeeplTQ6wRO027SwhKG6HCeG19kKPshmJSiwN5L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=p4nkQcsx; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=heldHUcl5JSmStuy/oLAzwUEGebnwog1OLKO7g7jQRY=; b=p4nkQcsxCqYrDeiWxYWcJxCuuf
	g0CJIfxxPOV/bMzw5Z9uPnklZnvhlb/YCSvQV+idVkRcBJlf8cdiW/Y6yBYVs5VZK5LuNHGWCIlox
	hEemb/P9SbTKaVlk/jqBuZfJAJCCe4c2+qTYY6/Mr2tw5XSVxPnSxLTqULOStLn/fl3Q5O9fsIE7b
	q7l4BQ9NxXDxhiEFBW/d4uMKO/RgBU75mebMRqzfwe/Iz+mk0LSew/rtz2gRYkfPfvrMHKHzhjCFm
	uyznYXliIqKuRchBVDzwvOMuXMLVkhEzHmRF36dvZmjOQ4TMdE96XeWF59P/JnImlKOeGZwuJefRW
	1wm1+7PQ==;
Received: from i53875a3a.versanet.de ([83.135.90.58] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vG4Ik-0007vT-Ba; Tue, 04 Nov 2025 00:49:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	michael.riesch@collabora.com
Subject: [PATCH 2/3] arm64: dts: rockchip: use SCMI clock id for cpu clock on rk356x
Date: Tue,  4 Nov 2025 00:49:25 +0100
Message-ID: <20251103234926.416137-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251103234926.416137-1-heiko@sntech.de>
References: <20251103234926.416137-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of hard-coding 0, use the more descriptive ID from the binding
to reference the SCMI clock for the cpu on rk356x.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index a3361527d4fe..d0c76401b45e 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -53,7 +53,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
-			clocks = <&scmi_clk 0>;
+			clocks = <&scmi_clk SCMI_CLK_CPU>;
 			#cooling-cells = <2>;
 			enable-method = "psci";
 			i-cache-size = <0x8000>;
-- 
2.47.2


