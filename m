Return-Path: <linux-kernel+bounces-774291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B008B2B0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071BA684334
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6256D272E41;
	Mon, 18 Aug 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="j95NDIOa"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A321D9663
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543224; cv=none; b=aNlKX60bqTY1mABzn2YzGed0P842f0TV8nRpi09Fj92aU9onyxgA+H5xWFQ35+vSsobVnrp/FAMOtEJckfe6Ffk03eZ6wSscQdgHX+BXymBFZ7L99IEMe7ScBH/Yv0oq11Y6VvcNqiFrjtlD2ESpqFGTEJTCjZtkFzjqlB7Birk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543224; c=relaxed/simple;
	bh=mL2MyruYHzSNLfEDksFH+ASX0WWW3O6Vdh9J4O9okL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB9Upm/gXbrkpPEt5NsaZhXX43I/y4pLpNJUKbJEK3F05vM9ocjRuwbylWRjo//Uvln40t8zHhZ9Ok+XK5SFZ7Ymd/hW7LJlTcVHnzHIVu1wSv8aCqbM4RQMWN3Ln9c0CQNoUamZrEeDw2ScHbhs69jfxCfdvUZimh6LY7qpzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=j95NDIOa; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=ZxfW0g9X+oPT/UxlWtvFfsT3/2mtKXs3JrOxnk3I7Ek=; b=j95NDIOa/mCgLPoh+oZgvtNCpO
	FNHgTTgvGFcOxID5a45wUS9lzXuGAh4+NlPHyOdHhegSCSPnppJC9+lMtREVWrQfR6m4whLO0sINc
	54ruiewHgQ8lSbE5EUPKvmD4qM/JlZKoR7N1kL/EExcjD4FtrZ7QniO1xc1rTb12s2Lla27EJETYt
	7B60p7L/GTLtB4R7tImLvdhHNSAsbq6B9/xBXo87o/Bq5cHVvZopaFUiExBTEba7GFfMrSRHE5f6z
	0+fDLseIsALw/nOslqEIut3gT7n3XeIQcaQitMwbKcr+wPujJdMHsgCvM3ZBlj/+cOw6kXKEIVbIb
	C+oH0gKQ==;
Received: from i53875ad4.versanet.de ([83.135.90.212] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uo4zF-0000jH-30; Mon, 18 Aug 2025 20:53:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
Date: Mon, 18 Aug 2025 20:53:37 +0200
Message-ID: <20250818185337.2584590-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818185337.2584590-1-heiko@sntech.de>
References: <20250818185337.2584590-1-heiko@sntech.de>
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


