Return-Path: <linux-kernel+bounces-806682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B799B49A56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DF21B24A71
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D992D3A9E;
	Mon,  8 Sep 2025 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTzG4AlD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A41C07C4;
	Mon,  8 Sep 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361027; cv=none; b=S5Ju4KjdCVrkpoiPj0TPRiJXFtS0gN8uHoO5Ein8ymnjrtqTusYfyGkTdTDx1UZOs4Y/wA83tizb3oZff6UqgF5ip+OhEYAanoYa7LU7M++ZpzNarn1Z0Dq7yd8UWNLZ0PXrOuSWTyFcmOjtKaEy05zlyclSfV5adb1GpQL/02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361027; c=relaxed/simple;
	bh=Xa2A8wUs8DU/Qpi2eBoE6S8SjRM3jIuTJh0HvFOCRxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ms1FhqPyKlknzog3/ys9GoLbAHmbn5ZyXhTzt/ZBVO4oz3vXw0v5OKZzoQYjYsIh5LsQkVAKGTOE40uWlp6kxkMYxRxbPvVx3/1tnnTwN1jHYDQ41ke7XzbH5/g/x7Z2nY3GuUWhXn6Vdny10HrQsxLqJwzA1/rbHYQXsWkD3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTzG4AlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97FBCC4CEF1;
	Mon,  8 Sep 2025 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757361026;
	bh=Xa2A8wUs8DU/Qpi2eBoE6S8SjRM3jIuTJh0HvFOCRxg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oTzG4AlDbpncPrHEebeStdQ+k/OZYSVISXsp0J8Ti0XyTpL8mYdFX7GqqOTijrHnj
	 PC7zEqRFkWk+SCisRBfiue6QvyXrr+EAFA3oLof3us3TFPjReLHjO38YW9xKyZM3b3
	 1FCw1pZ8v5dcbU3kNuiwNY7jPCAPaIQMtG3okicuHft5Us1vQ7EQ+rzpsrwzji3Onn
	 Lr7qa2YwlQHQzF6gAolmL6p+IMdP2m4bF0Hjz7vG12HcMhMgjtme9JWQsnxx1JjyL4
	 FgT5QHTfEiixv/qoY6NqrNaDhG6ikTr1xb+cTHOtZQ/Ul+ryhtI81kHKRAA+WHmDGG
	 nWChdMTLZ+v1Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F232CAC582;
	Mon,  8 Sep 2025 19:50:26 +0000 (UTC)
From: Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org>
Date: Mon, 08 Sep 2025 21:50:03 +0200
Subject: [PATCH v2] arm64: dts: amlogic: gxbb-odroidc2: remove UHS
 capability for SD card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-fix-reboot-v2-1-354d0e57c855@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGozv2gC/23MTQqDMBCG4avIrDtlEvwhXfUe4iKmYx1oTUkkV
 CR3b3Td5TvD9+wQOQhHuFU7BE4SxS8l9KUCN9vlySiP0qBJN2Sow0m+GHj0fkWqmSZnlLFMUAa
 fwOV7Yv1Qepa4+rCddlLH9S+TFCrsWmoPSzc130e7vWQMfHX+DUPO+QcGgIQ9pwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045;
 i=vsetti@baylibre.com; h=from:subject:message-id;
 bh=BJc4SXxGYBhMfaPaAFk61MykLFrvMDIrqRdHH0rt9IY=;
 b=owGbwMvMwCF2z3ty7kUrRgbG02pJDBn7jRuDXn3+sOHcgT2cDKu9ThrvSJgZ9VuAP9956mm9K
 rNPfIqNHaUsDGIcDLJiiiws0+/9LihVe2iccLIAZg4rE8gQBi5OAZiIdhUjQ8eu7/dYbVV89FJ8
 JDoFqtsmSq7tVWzIrV2loFGjF6IjzvDfZ97m1ZYLFvRJ2yT5vAq8z7zmp3f339s5Zzv4zBP3y/5
 jAQA=
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

Therefore this commit removes all UHS modes which would cause
"vqmmc-summply" to switch from 3.3V to 1.8V.

In terms of performance the main drawback of this commit is limiting the
SD card bus speed to HS (25 MB/s) instead of UHS DDR50 (50 MB/s). However
this comes with the benefit of being able to reboot the board, so it
sounds like a reasonable compromise.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Valerio Setti <vsetti@baylibre.com>
---
Changes in v2:
- Re-added vqmmc-supply to sd_emmc_b node.
- Link to v1: https://lore.kernel.org/r/20250907-fix-reboot-v1-1-7606fc91254e@baylibre.com
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 959bd8d77a82ebc78c5e0592d7613e692e4ede4e..12e26f99d4f080a216e305981dc4291a49063b60 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -348,10 +348,6 @@ &sd_emmc_b {
 
 	bus-width = <4>;
 	cap-sd-highspeed;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
-	sd-uhs-ddr50;
 	max-frequency = <100000000>;
 	disable-wp;
 

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250907-fix-reboot-04e0fc919ae0

Best regards,
-- 
Valerio Setti <vsetti@baylibre.com>



