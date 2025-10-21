Return-Path: <linux-kernel+bounces-862337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A4BF5080
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EBE18C48E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FBC28DB56;
	Tue, 21 Oct 2025 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="o3JiK/qO"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA4281356;
	Tue, 21 Oct 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032613; cv=none; b=sdRKwpHuQq81zEnfJIX7Ns0Ub5c+ZaTTaFxYD6/zu3ShEHM211u8o0ySa2bFqSRggrg9PSx6INyPnQiWvilC0Tglv1GlaA/9UZkdLzKLwPEDvyaEdcxUGtinxS8122V9sUlUQ6GoZA24T5wOfzjB5MwRy83wLPwNwjq0DxDdGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032613; c=relaxed/simple;
	bh=e1PwJ4bzI7YJDCEyLHU66rcxl7aC6DVUx7j4bhy+xHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3Vz4N3dmxEYbfDXwScnOAJh4oHD4ElVOdKJMVtvh6OF+tZ+aTroohxTnjeNyga+RhR/ohPky3GuMzSK1t9AKBowybZOBHjXNXH2GnvG10ANWfQVnVSIV2DdcarpRaHcLY6bYsRpN2NlekZXqB0+J/g/Iu02xdJS9lPGKSos9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=o3JiK/qO; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=eRts01yY6wbXoZJiKV8EilNEez97RUtFkZlyQpaiO4k=; b=o3JiK/qO0Q1QURZtQaMB92OVLg
	KcQi0S6p76uT0t7rrAqusF7W6eDq3ykTRx0KvDUS4QKZFHliSmQtCizSAq0hyER6kPZ//8tuQCjBr
	C6SEHhEdr3NW30ccK+RexkPd2SteNu86isiZi7OC4iCKN7LHCf0T+6RsKswlpLLkAVs8crd99U/we
	26UUU0ScevKW0l84TnFae557F8GV5W8FzLY9fhza2GRgODxucHkUVpbFSqtJ2GuN08mNmpO5YVi2Z
	KRzCizW1diu9kFScYxZttCUAu/FjfVQceAnizjykbuALdMyaIaiPEvSSHkFPGWwa9BIyK9v334Wp2
	hIkidzNw==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71O-0000uy-Uj; Tue, 21 Oct 2025 09:43:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 6/9] arm64: dts: rockchip: Use phandle for i2c_lvds_blc on rk3368-lion haikou
Date: Tue, 21 Oct 2025 09:42:51 +0200
Message-ID: <20251021074254.87065-7-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

i2c@0 on i2cmux2 does already have a phandle i2c_lvds_blc defined.

Use this one instead of replicating the hierarchy again, as this might
result in strange errors if the lion dtsi is changed at some point
in the future.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../boot/dts/rockchip/rk3368-lion-haikou.dts   | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
index ab70ee5f561a..abd1af97456a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
@@ -18,16 +18,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	i2cmux2 {
-		i2c@0 {
-			eeprom: eeprom@50 {
-				compatible = "atmel,24c01";
-				pagesize = <8>;
-				reg = <0x50>;
-			};
-		};
-	};
-
 	leds {
 		pinctrl-0 = <&module_led_pins>, <&sd_card_led_pin>;
 
@@ -68,6 +58,14 @@ vcc5v0_otg: regulator-vcc5v0-otg {
 	};
 };
 
+&i2c_lvds_blc {
+	eeprom: eeprom@50 {
+		compatible = "atmel,24c01";
+		pagesize = <8>;
+		reg = <0x50>;
+	};
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
-- 
2.47.2


