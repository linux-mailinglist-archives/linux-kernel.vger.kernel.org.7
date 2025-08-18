Return-Path: <linux-kernel+bounces-774155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ACB2AF36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB12A3FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B8532C30B;
	Mon, 18 Aug 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lGTMioqs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7B1F91C8;
	Mon, 18 Aug 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537531; cv=none; b=eKnYSPDtu8/OJTga5QxBqJzdXYaFWh+04P2R5eQOwyuRG0Ap7UecfojuHTMDjvZ39Qp67fm7q5MPe38/12jAttkb/Qm2s3K1Vl5QCbPVY5k9zyF+S4C8aUj6DGIjBM6FMMfFshZSXJtn0rBjp/0kK/fsQqbsNB/Gdr/+I7JyN/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537531; c=relaxed/simple;
	bh=tG75RaA58L/LbFXL/IjWTkyLvWG0PIm7lTQ07gOgyks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=drSHzA3vSzWlwVnJa0SIvC1SRnPAduT45GxDld40T91jD8wh6lKo/K1ZR2NNy/glcvYK2fbPdYohueB9TYIhBz05PRglD9FYe20QswIILdsdTikBd5Jl+IfWZH/fm7zyCn10fnIcsWWe3fwgfCZqOt1AZlNQU9+Ym/5wO1D1XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lGTMioqs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755537527;
	bh=tG75RaA58L/LbFXL/IjWTkyLvWG0PIm7lTQ07gOgyks=;
	h=From:Date:Subject:To:Cc:From;
	b=lGTMioqsaBVhRC4NA/nukTupkmMEdAZeL0x9eWRd+v0qKfz29PDNWEmu+xO+Ss5rC
	 xvgg/ImvpXzSI2xf6Lge6DXD/li0DH0VG51txmUpNLFYCY4SKQyNCXQYY2Ov+UzfS6
	 SlPV3CTYVHZGWDuJrQKuHBT2bAS1rMi6mPIIj0UiaX8B7PZx6TjHDbWAY1j6efNQuJ
	 uGZC+b95LyRdIwhFsRzkZFOcz0mrJPous9NdSLVWDCHDI0VVY4YfPRKlGfALqGMcLJ
	 0uSf6SLrYt8vp6aeXB32Yw7FbujPdVZlwzZAaCpGeFQky8nuRsuktH8UVkIQx981PL
	 DGuH4SCqnek8g==
Received: from jupiter.universe (dyndsl-091-248-210-167.ewe-ip-backbone.de [91.248.210.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CE23A17E0237;
	Mon, 18 Aug 2025 19:18:47 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 89697480044; Mon, 18 Aug 2025 19:18:47 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 18 Aug 2025 19:18:40 +0200
Subject: [PATCH] arm64: dts: rockchip: Enable RK3576 watchdog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-rk3576-watchdog-v1-1-28f82e01029c@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG9go2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ML3aJsY1NzM93yxJLkjJT8dF0zSxPjNEtDI9NUEyMloK6CotS0zAq
 widGxtbUA9CCZE2EAAAA=
X-Change-ID: 20250818-rk3576-watchdog-6943f9125e42
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; i=sre@kernel.org;
 h=from:subject:message-id; bh=tG75RaA58L/LbFXL/IjWTkyLvWG0PIm7lTQ07gOgyks=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGijYHceec+cj0s2bKOj3NvdMhql0msA/UW6T
 iYDN9l6MKIk0IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoo2B3AAoJENju1/PI
 O/qaDvUP/3x2qieJs/eT58aqP4wqmebgzmOIfe4kGht0vvoveETDxQrQOtnXnZVbyE1HmpLq9Ix
 LXrzmOgFPl6hFjunDUVBi0iDvtjx6V/3K4M+B56p2iCIp1Y1RCu3zbbK25zAifSNc9oKkZdXHnK
 3LWQoZpaNcVB/pTOjwj/9VTz1dUAwq7LReBdWDc8r2U7T7AN2JtrEe1ZtirR5dFzOfuyZ67WESF
 X9wTYBRrtSojoI8mVv0AHJSIbvwUGPD1vfcq5qK9hZyzdG51DMYXrXKEHnTVW92NlDlxtraiLb5
 8rVwFn+icLVS6jllwXFyagfeh+dvJ63IlKUBDuqlF7gWkIIHOCe+u7xljTbXpyrbCgI4wlVbqc8
 5jUqbTsozyjdlArhBRFeu2GkI7eUIKHSWboxeUynANkDcGuseB8AZzPz55QoWzF3/YPphjIJIud
 TbdH41GbgN6sz6tLN/3Miv3hcFzzpZS1AYRfpJrgcEaGpesO8yBk5dFqScvkdIPD3jvVw9CahKc
 r20sOEdgzGQdR0Nn1zO0mWIvpVSx7De9GSgAlsKBuThKD/xU8KUGIaukxRJlNfzAoQOiSC/iKNk
 Ej0uH/DfSlLWXb6soXhtZ/L5LjCDH89acZsAh/BU34gVss55EqLKoIYhl3+CkAYerE2rhFafVpJ
 BGb8zxN0nvcc/hWup+aAxZQ==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

The RK3576 watchdog does not need any board specific resources, so
let's enable it by default just like we do for RK3588.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index c3cdae8a54941a75821aa6a642c535ced66a116a..1bffed162c307d3981a540d5727d477f0e6f47aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -2073,7 +2073,6 @@ wdt: watchdog@2ace0000 {
 			clocks = <&cru TCLK_WDT0>, <&cru PCLK_WDT0>;
 			clock-names = "tclk", "pclk";
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
 		};
 
 		spi0: spi@2acf0000 {

---
base-commit: e05818ef75bee755fc56811cb54febf4174d7cf2
change-id: 20250818-rk3576-watchdog-6943f9125e42

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


