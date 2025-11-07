Return-Path: <linux-kernel+bounces-890480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D68C40275
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E931A4E3E6B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F22F12A3;
	Fri,  7 Nov 2025 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsHHdmHG"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E32D63F2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522730; cv=none; b=NGIJgTjpDixH/uuWhZQjV7H+J+M7GbrhRhJna15E6SOxJom6lcrg4UC7W6fVT3CBwJ//7yetgV5U/umV2tK/m7aYB8vZGZN6nqhPKBKtv+kUQiidy6m5hYANVcGe1WDXmubWCzc2HB+7Ryxf7g3fG8rjJxIqqCtyB3HzlRoAR+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522730; c=relaxed/simple;
	bh=BoF2sC78NUVtU68avJid61Dvbiv2tfr1Ba5wKGszNg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=juV3V6q0rpsjMvyM8yhnf2VukM2fu/tKJ6mmbX4KqfhcoxvetaWwcGQm895pxClTIZwOeiY0b/4jpItpXBT81AWp4ZT8h4oII5zhzWgvJ7Vvpi22jDLZ/UGflSDBN+QRFYpYs50O9X4+h2NrwxZFB25FjEBkHl9HZxhf0yd7V/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsHHdmHG; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-33292adb180so731973a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762522728; x=1763127528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ6i5QFZLIXUsCrEe0mdSHfsDvzDf4P+mBRrC8poWsg=;
        b=NsHHdmHGjGiWmBfWziAj0lTl698Nbc1tJQUK6EMiGOrUatooKfdwuuJciKmXD8s4MT
         YFCInu0ZEg4IcLlF+Sc7+2uJNxbRR5B+VUmMlxNVeDRfagR2LZ+U7Cgf1eI3RU5VxixE
         CeXCEvM+fUcjF3H1O4aCT8FjBcOOmR2fyK2ID5YdPtOBeUVL9ZL1OZIKP25ntSEYrPTm
         g2/mB5lzMHVPmbIlIa7TBa8c4+w+P1hpuN60VYz4ux1WFXFsNqA/aBABgawpxr9wZU7I
         yronsNiL6LHo/7h1NY8h8qDjXm3MPkIYeY+dx5Av6nETlGLztO1PlSfapOa9JDdUmRC+
         aSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522728; x=1763127528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ6i5QFZLIXUsCrEe0mdSHfsDvzDf4P+mBRrC8poWsg=;
        b=tmoa2TNBtataFAK4No1K0AnHmdqhWVXhIA9ZdTYiJ1r9scTtrRuFV1ZrZSzIaOZ0HG
         ke8/m1hrKqRUx6AnMojM64f5yYMjieKTLS3/xaY8AosL5LzxxlOipqsTnmPbmcJSn0B2
         eXsfOmatT2fPTMsjfM1rUT+sDjpFQeY5JyXk92C2YzHvQPuwGzqDqNp4G97oaZOfn7a4
         YktV5M0fwmkAIg2CU4laXOgY+a8B/HVZSiIPx7gNBMhY2EfS6zBx7WQ7SBBjGxj/sgjE
         hcF3dqKd1DtPhIDnvZ/VxruuuOG3VG/g45rBusi1b0sBmje6qGX5TJMQraRUTUOSYDxS
         LtGA==
X-Forwarded-Encrypted: i=1; AJvYcCWXHGmzDP3mTwwPJjcTuVNeDrbXNjEcM83jeGCsksf0Cy1oZSjhT86bxT51iY5iBZNYA3h5HFP9Wm8PzAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzsfR7D7SgFTdYR9g0EfBU3gnd+dbbdikvm/IZvpSSvgftLjPt
	/ULLeI6V2/cZPldvNFhSpQ57+U+5lQr9UKnnBfnwe4XEcZ5fDG0FIA4M
X-Gm-Gg: ASbGncvN6GXcEKsodurw775SZRB08mzSUjrytklw7sW1Ntu3/OFW6hpnxATKSi+iL+a
	C/jXnhrARxf7XewYrI7VLxlg0oaeFpe5mR6Zqm57oLdyW/qjUDLKxrKOuXwZxKUWn6/Rx5FVz0f
	ArTz1U5ykYKfnBxkALTinj9d436jfnYcWXtSpxPGnt+WxCUCIObmp/FenM0m8Kll7aiuVegzWxp
	woOYyoo4JiB+TXWpz0V9gVpGDA5Hw0w/xK8AbR1bBAIjnabShNg3EDNEZsZ9i0WcaOx44da74gg
	1zZI9e3++crhaoTfeJaGXMQ0PIgoT2Q9OOc0nn8UYQuUZ+UGXazEZC4ZMiJHdsXBRjiZEN+0Q26
	JmU3/XXhKJCIHZfWD5Rm+4lnHRwMW32HAUN5WVprpIdhuGxRSpWytjTbthXJowswjgrrXe68GXg
	ppe7YIiQ==
X-Google-Smtp-Source: AGHT+IG4l7HicS3Le3aL0YFeQkU4o+7MNbGUnvh1G+o7pBk4WXRTmpELgxnyrfcV0IqYR/is61rOeQ==
X-Received: by 2002:a17:90b:17cb:b0:339:ec9c:b275 with SMTP id 98e67ed59e1d1-3434c4efc0amr3789493a91.6.1762522727993;
        Fri, 07 Nov 2025 05:38:47 -0800 (PST)
Received: from server.lan ([103.213.4.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c343107sm2705259a91.14.2025.11.07.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:38:47 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: clean up devicetree for 9Tripod X3568 v4
Date: Fri,  7 Nov 2025 21:38:38 +0800
Message-ID: <20251107133839.300252-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix indentation, remove unused SDIO properties, and drop the GMAC clock
that was used for input direction. The board uses the clock as
output, so the input clock is not needed.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../dts/rockchip/rk3568-9tripod-x3568-v4.dts  | 25 +++++++------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4.dts b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4.dts
index 443ed7d4b..ad4d62060 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-9tripod-x3568-v4.dts
@@ -273,11 +273,10 @@ &gmac0 {
 	clock_in_out = "output";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac0_miim
-			&gmac0_tx_bus2
-			&gmac0_rx_bus2
-			&gmac0_rgmii_clk
-			&gmac0_rgmii_bus
-			&gmac0_clkinout>;
+		     &gmac0_tx_bus2
+		     &gmac0_rx_bus2
+		     &gmac0_rgmii_clk
+		     &gmac0_rgmii_bus>;
 	phy-handle = <&rgmii_phy0>;
 	phy-mode = "rgmii-id";
 	status = "okay";
@@ -290,11 +289,10 @@ &gmac1 {
 	clock_in_out = "output";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac1m1_miim
-			&gmac1m1_tx_bus2
-			&gmac1m1_rx_bus2
-			&gmac1m1_rgmii_clk
-			&gmac1m1_rgmii_bus
-			&gmac1m1_clkinout>;
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
 	phy-handle = <&rgmii_phy1>;
 	phy-mode = "rgmii-id";
 	status = "okay";
@@ -674,8 +672,7 @@ led_work_en: led_work_en {
 
 	pmic {
 		pmic_int: pmic_int {
-			rockchip,pins =
-				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
@@ -763,7 +760,6 @@ &sdmmc0 {
 /* used for AP6275S WiFi */
 &sdmmc2 {
 	bus-width = <4>;
-	disable-wp;
 	cap-sd-highspeed;
 	cap-sdio-irq;
 	keep-power-in-suspend;
@@ -771,9 +767,6 @@ &sdmmc2 {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc2m0_bus4 &sdmmc2m0_cmd &sdmmc2m0_clk>;
-	sd-uhs-sdr12;
-	sd-uhs-sdr25;
-	sd-uhs-sdr50;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc3v3_sys>;
 	vqmmc-supply = <&vcc_1v8>;
-- 
2.47.3


