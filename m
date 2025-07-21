Return-Path: <linux-kernel+bounces-739796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D8CB0CB11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B3E4E7663
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8022FE10;
	Mon, 21 Jul 2025 19:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="ALmF0Q5R"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632622579E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126719; cv=none; b=i9SO4IG/zPR0E4lGZEVxUuGUTSalwW9+h5Oanmx8FJiIHSF93sVrP8NXD/VIuezHmtxNRrzT/kiZszlvMNNItDBwwBXu7Bj6phJgpLzyOpvjEHwV1WDyIrl2m51KWvjACmcnEyi2TABQ+GRf7LWVj3qMxDWtptKvh7LNbDryUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126719; c=relaxed/simple;
	bh=eW6uMrYnoIZtzJ2yB57lCiBdnZbYU7iDn4Kv3bpDms4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zg//nm8Bw4Ol5y027lzhKnpV51AOA217ac0QrXalQ7f40h6BXpD1Y6q3oWy5lUneJvfuOJdqtHuvyPE8vAuk5tp4EKy4EGaG8zCa3RaCJdgP7Zb1QM6dYoLUeI5W9JKcHCiaD7emdmTjBRAI5dmFit4ZXCW4HtGLzNrX3vSbwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=ALmF0Q5R; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 24661 invoked from network); 21 Jul 2025 21:38:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1753126709; bh=hpMtOqZiSLiIGO8kc1mIrDBucAWcsR8PwKegbblgEpc=;
          h=From:To:Cc:Subject;
          b=ALmF0Q5REAESnZClzcSPXbk7RPTkysq8AN1uN+U+CuuuzhZjZPdZKVqhnjGqkwmco
           DANvb/2IhVZTafk+n8HJPoO1PnNDAzF4MNiYLSGMNU3kmkWAWk3yn8Fm4T1YdwNIkT
           JVdQHkTTnib7D+y0LzZNqPnklsqUCDoCEKPGvPi5OTOj5F/SXcNtReuSQznqWEqVW0
           rciqdOefhpL9/qmk2ZgQ4/BgRz1gOF6QPDsElx+qh+rY5YU6huVOLEkPH8AccWPdty
           79uDgaWOQYAhqWcO6FxGiFqJZZ3zgYomi31SKCjJwDj31uPvfE1qPPQHy/YEiNgZaE
           9GiI3vq4RD1CA==
Received: from 83.24.129.157.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.129.157])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <robh@kernel.org>; 21 Jul 2025 21:38:29 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH] arm64: dts: mediatek: add LED and key support on Xiaomi AX3000T
Date: Mon, 21 Jul 2025 21:38:19 +0200
Message-Id: <20250721193819.2465981-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 80b19409167d9e40770cbfef1a4bc0d4
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [4UM0]                               

This patch adds support for keys and LEDs on the XIaomi AX3000T.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../dts/mediatek/mt7981b-xiaomi-ax3000t.dts   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
index a314c3e05e50..db399cb3ead7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7981b-xiaomi-ax3000t.dts
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only OR MIT
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 #include "mt7981b.dtsi"
 
@@ -12,4 +15,37 @@ memory@40000000 {
 		reg = <0 0x40000000 0 0x10000000>;
 		device_type = "memory";
 	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		key-mesh {
+			label = "MESH";
+			gpios = <&pio 0 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_9>;
+			linux,input-type = <EV_SW>;
+		};
+
+		key-reset {
+			label = "RESET";
+			gpios = <&pio 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 9 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_YELLOW>;
+			function = LED_FUNCTION_STATUS;
+			gpios = <&pio 10 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
-- 
2.39.5


