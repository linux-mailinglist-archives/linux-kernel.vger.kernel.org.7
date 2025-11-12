Return-Path: <linux-kernel+bounces-898232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D948DC54A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AEB0345DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEB22E370C;
	Wed, 12 Nov 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bvLW06TP"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2A2E4247;
	Wed, 12 Nov 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983744; cv=none; b=UIScNyfx3yYlUnwYgsOTjt9AmccZx2Zt080ILrUpHdGgWTmSM1UPVtxd9FNV6Gj9w84hecaAbYmrRDIe5nfmmfq9WGuLHATiMB9o1/ejt05GdDVTIImz4IXZ+g6FZMNyKGr3X+qsh0JLH/W0m5LaREhR4MlFsmQIeqPZLpExccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983744; c=relaxed/simple;
	bh=mL2MyruYHzSNLfEDksFH+ASX0WWW3O6Vdh9J4O9okL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWgwkyibRiMCkzip36O61e8V1VK85eaodmXE4evu1CTIc82B4LKU2w4mj4HykF/Bx6P9X4Voj3+AkDSwrF3P2p79CZoFdym+jAJrmZUO+FctcVqc+ODCSGNygHyTZo+XcriUMQTtw/AWeYJOw4oiX1Cdln0B8Usq4w9EA6h31wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bvLW06TP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=ZxfW0g9X+oPT/UxlWtvFfsT3/2mtKXs3JrOxnk3I7Ek=; b=bvLW06TPY8VsfHgk0w8oJZy0iD
	YN/ITpOgjVsxsyWyP/oPNchL8FMZEX3zjy/0cFmdESUEVxhyeXGumH8v8AfFlMpPD2C/I22xI7h2r
	6MsMmKDxH4PlVRRXy4tz/KwTOjduKisIbVbIyFJK80RQMzn6NOksBZB37CZ606D92/smr9IpgvTP1
	13Wjzdc7oeqONb5bis5j+g/mQ+oj5caL787034SeoSGdTcfiYkV85LxWMW78KCTEQCxptlqW5JYnN
	TTfwCYmGZ3A9avUBREvCDr5dCl+xPOnOY+WKZKfxUtUTGr6Dg+PAgAxP0/buVwhYb+lzCBmiAUTNk
	/dKggsoA==;
Received: from i53875b63.versanet.de ([83.135.91.99] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJIbZ-0003tg-0g; Wed, 12 Nov 2025 22:42:17 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/5] arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
Date: Wed, 12 Nov 2025 22:42:03 +0100
Message-ID: <20251112214206.423244-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251112214206.423244-1-heiko@sntech.de>
References: <20251112214206.423244-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCU's eeprom contains the unit's serial and a number of slots for
mac-addresses. As the MCU seems to be used in different devices, up to
8 mac addresses can live there and the unused slots are actually
initialized with empty mac-address strings like 00:00:00:00:05:09 .

Interestingly on the TS-433, the PCIe ethernet adapter brings its own
memory to hold its mac, and the gmac0 is supposed to get its mac from
the second mac-slot, while the first one stays empty.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3568-qnap-ts433.dts   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 5656554ca284..224db87973b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -655,6 +655,68 @@ fan: fan-0 {
 			#cooling-cells = <2>;
 			cooling-levels = <0 64 89 128 166 204 221 238>;
 		};
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			serial-number@0 {
+				reg = <0x0 0x13>;
+			};
+
+			ext-port@22 {
+				reg = <0x22 0x2>;
+			};
+
+			mac0: mac@24 {
+				compatible = "mac-base";
+				reg = <0x24 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac1: mac@35 {
+				compatible = "mac-base";
+				reg = <0x35 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac2: mac@46 {
+				compatible = "mac-base";
+				reg = <0x46 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac3: mac@57 {
+				compatible = "mac-base";
+				reg = <0x57 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac4: mac@68 {
+				compatible = "mac-base";
+				reg = <0x68 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac5: mac@79 {
+				compatible = "mac-base";
+				reg = <0x79 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac6: mac@8a {
+				compatible = "mac-base";
+				reg = <0x8a 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+
+			mac7: mac@9b {
+				compatible = "mac-base";
+				reg = <0x9b 0x11>;
+				#nvmem-cell-cells = <1>;
+			};
+		};
 	};
 };
 
-- 
2.47.2


