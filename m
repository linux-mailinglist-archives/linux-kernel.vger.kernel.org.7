Return-Path: <linux-kernel+bounces-832116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B78B9E621
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAA386804
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887ED2ED163;
	Thu, 25 Sep 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="sbWa0Qnp"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F42EC569;
	Thu, 25 Sep 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792648; cv=none; b=f5aP4CUQOCUygcuYbnJFzAcmPI4rRdWTdAR+0Y5nYmDJq2KWNd8n3enb8MUqxbNQwAcNDOJyV9GrkK4mo5b0mHkSBcEFVnjx8dc1FXUHkT5EHjYr4imqxkZuNfuu7AVr7tRdM4uQz5IiGYdc7lvx0ClEdw35s46An3ZsKcflWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792648; c=relaxed/simple;
	bh=LIS7TV3Dgr+coa1+dKNzj4b6fL8TaLXsvBTnojgurIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3pJlCeuF/kM7sfrF6gcpfGwd6Gj8rsU4/pddHbwisDik09p1JigLnbzOOzcmSq2EsN0avkHUnX/YzFsSDsT5oP1pTr9tlDFhk1rSIDTobqLheHaW+K82Pgix7fFIpq01d/9k+dpqH5P8rY0cSaLfSYKysdZuv2166otREmcqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=sbWa0Qnp; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=oUTbmpjBOShPC8uA5CjLrDc20jsp+a9pwSfjX2/Egfk=; b=sbWa0Qnp9XqhVE5c4gcCWMZm/0
	rR8D46smRyVdxiR2dxKWrqvi11fYICL6gSvKGlh+Gz5n8pY2v5ZQCo2+5cuwf3VdWlX4ZVPufcWCm
	9goDQaiqHGJkBlLA9FvBiGB2IrUE5Q7jZQqvhr/yoHYgnimXPR2gdT3y0dgGbRmC/xV1utmCHLb1X
	+yYNPk/ezT//B/3DuETNhenXjMA3LBMDaIxkFoMASmsOc1WyG/JXqqwtEV1ahP+7JZIZ+o8AXguq4
	uCt5mucbVsUm3k306PuPhiCibgJTmNxIIOSLTPazOd0xjqpLUnEwy9ua1kMGs9sWSCKoNNLjLTagn
	0ucMYuvg==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v1iJG-0001Nz-HV; Thu, 25 Sep 2025 11:30:42 +0200
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
Subject: [PATCH 3/6] arm64: dts: rockchip: describe mcu eeprom cells on rk3568-ts433
Date: Thu, 25 Sep 2025 11:29:20 +0200
Message-ID: <20250925092923.2184187-4-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250925092923.2184187-1-heiko@sntech.de>
References: <20250925092923.2184187-1-heiko@sntech.de>
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
index e8af92a011d6..3fe9a7fce73e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -657,6 +657,68 @@ fan: fan-0 {
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


