Return-Path: <linux-kernel+bounces-804662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA24B47B55
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 14:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C41017B245
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927626E143;
	Sun,  7 Sep 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3MmJAWF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1D310E3;
	Sun,  7 Sep 2025 12:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757248179; cv=none; b=dvsPMEsd4/rIBy2I3fZeWFDa5T5M5xUBUt3u4J5noehJXulb9a8TCpaYVMElrw0i9CD+5jgWkdzS4+am1xyRxXcEge4trlxXB0QIv/d8ww/kowO6YUtjus6erlNJMTjir6T+UtU6AqsjnbuNuYgKneBmozTlBqQUkN34mMVBkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757248179; c=relaxed/simple;
	bh=qDpX76/Rz1kCBhaI70kE6hYmSdNLUblzUjGz0/M4d0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=piFvKaCmb5o/FF72iHuicr2YPo86y2lrmDmUDj5meB1mKYbYJ0LDj5egPGlDa8OPZJyk07AkOX/NhuDS2NVipH0nz7kk/CkADq4BTxqEtTBHSBT9czU0ED/k23XnlQHNd1SXu2GeoHD9igo8zKhD++InMlRJlDlQxdvOZ30moIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3MmJAWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B09EEC4CEF0;
	Sun,  7 Sep 2025 12:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757248178;
	bh=qDpX76/Rz1kCBhaI70kE6hYmSdNLUblzUjGz0/M4d0o=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=B3MmJAWFs+3gyy0sUGgqX+Zi3uCoR9eHU8tjULNNucAHMIDieSQ4DBAobqY5gDsi3
	 /WV8VrFmWhiY4XIwQXbPo3bjvS+cKmMuMABOBVWbEzr42+7OQYl6OT+AJ+R59h2AcZ
	 x73JDkJnj8mfmi8fQt8dbx/JMSXMneIhvqnccFzktChkES+tf3pyrfSqn4UdUSUFOD
	 M9Dj93EnIiVlZ06AATosjgfAf+Mbq+3wOZjWIGCY5/RVxZnR+H8c/HFveH+2vVVNxs
	 xJjLZKS46kzd+XdSSTTS6Xr4Rpl/1eHjg1hnkX0hDA0bXzN+maPp8ByIHqtR2L36NG
	 IkriQ8GHzzoYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1729CAC581;
	Sun,  7 Sep 2025 12:29:38 +0000 (UTC)
From: Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org>
Date: Sun, 07 Sep 2025 14:29:21 +0200
Subject: [PATCH] arm64: dts: amlogic: gxbb-odroidc2: remove UHS capability
 for SD card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-fix-reboot-v1-1-7606fc91254e@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKB6vWgC/x2MQQqAIBAAvyJ7bmGVIuwr0cFsrb1oaEQg/T3pO
 AwzFQpn4QKTqpD5liIpNtCdAn+4uDPK1hgMmYEsjRjkwcxrShdSzxS81dYxQQvOzM3+s3l53w+
 6d6OLXAAAAA==
X-Change-ID: 20250907-fix-reboot-04e0fc919ae0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Valerio Setti <vsetti@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226;
 i=vsetti@baylibre.com; h=from:subject:message-id;
 bh=8EBu8xBycRGsUBCELcsXSIlLy471WBn+C9oMzb171Ho=;
 b=owGbwMvMwCF2z3ty7kUrRgbG02pJDBl7qzZ+EotTzK5mWfxPQoD3/DQxnkX1aVs1a1Z1aVvlx
 HUkbd7ZUcrCIMbBICumyMIy/d7vglK1h8YJJwtg5rAygQxh4OIUgIkcFWD4X21T+C1i+zvvZQeO
 e5zqsmt76n9o+7IXy1Z+TO1bva5APYbhD4dH72EDe83XX45zHOD27/+wJdz7NJfMPtPW+jXLO05
 vYgIA
X-Developer-Key: i=vsetti@baylibre.com; a=openpgp;
 fpr=0497DEFB707526E13360C970DE4B936DD13A0100
X-Endpoint-Received: by B4 Relay for vsetti@baylibre.com/default with
 auth_id=515
X-Original-From: Valerio Setti <vsetti@baylibre.com>
Reply-To: vsetti@baylibre.com

From: Valerio Setti <vsetti@baylibre.com>

This is meant to resolve reboot not working on this board.

The problem is as follows. In order to be able to switch from HS to UHS
mode the bus voltage needs to be reduced from 3.3V down to 1.8V and this
is achieved by the "vqmmc-supply" regulator. The ROM bootloader is only
able to manage the card in HS mode (3.3V) and the switch HS->UHS happen
at boottime in the kernel. The problem appears when the reboot command
is issued or watchdog expires because in this case the "vqmmc-supply"
voltage is not returned back at 3.3V before rebooting the board so the
ROM bootloader will be completely stuck.

Therefore this commit removes both "vqmmc-supply" property, which is the
one causing the reboot problem, as well as all the UHS modes which would
now became unreachable due to this regulator control removal.

In terms of performance the main drawback of this commit is limiting the
SD card bus speed to HS (25 MB/s) instead of UHS DDR50 (50 MB/s). However
this comes with the benefit of being able to reboot the board, so it
sounds like a reasonable compromise.

Signed-off-by: Valerio Setti <vsetti@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 959bd8d77a82ebc78c5e0592d7613e692e4ede4e..331a0a62b884389b4e0d4d157fff7f9c8738c89d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -348,17 +348,16 @@ &sd_emmc_b {
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-ddr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
 	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
 
 	vmmc-supply = <&tflash_vdd>;
-	vqmmc-supply = <&tf_io>;
+	/*
+	 * Control of vqmmc-supply is intentionally omitted because it would
+	 * prevent the board from rebooting properly.
+	 */
 };
 
 /* eMMC */

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250907-fix-reboot-04e0fc919ae0

Best regards,
-- 
Valerio Setti <vsetti@baylibre.com>



