Return-Path: <linux-kernel+bounces-741783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E3B0E8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5FF1CC1599
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36B184;
	Wed, 23 Jul 2025 02:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tK6G5Bhd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA111F12E0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753239502; cv=none; b=RjAkX4EhlkYKXKCkSK2GdPknsyJ64gbHl5D1d+boOgXw5P9TZQ3SYy1RgOiET+1Nmwgd9Kgp7EhPWBvhj0qlmtcf5+TFUNYejyN3gj7YO7KQmJjcJ/Txhc3xkJdkkp/FQh4bBVp5g2oaYvUMO3JV7J57J+ghkhWWVPTLgfsRDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753239502; c=relaxed/simple;
	bh=ZIWrT6BRLKphQtnh3Uhpob2LwoYBYO0WXJVd9NLPwhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ouwFFk+SCX5z7tY7bVfuszdlGRDTtOdTVhilf7dCJ7PUFJ/5h/QO23RvJ/GT4YV/RGy7GXHsJAJmX8mttqaBWEBFLKejnrCtj7TLOfi5xWNHWbKTkDaEvDN+Mb44Hn/Xmi/kUQ4CXRwP/n8ny/nkiUw7JgPm7Tl8TGhmDT6HhIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tK6G5Bhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E79FC4CEF6;
	Wed, 23 Jul 2025 02:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753239501;
	bh=ZIWrT6BRLKphQtnh3Uhpob2LwoYBYO0WXJVd9NLPwhg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=tK6G5BhdD7QFycWPPHmjBBRxEBTvxZNXwoMs9PnlmIwb2qn77DtfGaXtVyWI8l0OU
	 S7RfsBTIH3gy1ec1QUEzV9PaPcYHGfhd1Dtu6p5hREbXYKat0KoRkXZFNga3A0O/WA
	 s5OrGecKyjlEY54aM7tirOQoVAAh3Hx718xu3oYv2IPdwzDDiuyLzt0buL79EZNNbl
	 u3TKHoq8/Ojv6a66ox4a0r2LXBO6WIBhBY8QxeYpvivd8O4FbC/MJksygM29Flu6NT
	 FdIWxFNBs0B2UqXiiF1XcrEK2WLOoeY2x8Hrrs3J502pcqiQ8PxjMQeweENaZe5uGo
	 Dh7M1fsgaNkQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7AC83F25;
	Wed, 23 Jul 2025 02:58:21 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Wed, 23 Jul 2025 10:57:49 +0800
Subject: [PATCH v3] soc: amlogic: clk-measure: Optimize measurement
 accuracy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250723-optimize_clk-measure_accuracy-v3-1-d56269de7335@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKxPgGgC/4XNQQ6CMBCF4auYrq2xU6HqynsYQ+p0kIlATQtEN
 Nzdqhtdsfzf4ntPESkwRbFfPEWggSP7NoVeLgRWtr2QZJdawBqydQZa+lvHDT+owPoqG7KxD1R
 YxD5YHOWOVE6kN7lzIJJxC1Ty/eMfT6krjp0P4+duUO/1KxtlZuRBSSX1eQvOIDqz0Qfb1P7Cu
 ELfiLc9wI8HMOdB8vCsQJUuM5S7f2+aphcesulAHAEAAA==
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753239500; l=6160;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=vJWmpNtcOXlkoFv9Cp1Rrilgfgh79zA1b26tZqiToCY=;
 b=NW5FxwYhv/eaTWUj1TZji3jsNq8VPlkJB6UliYLm+8DKq+3FuGYafUU/9m9VpBoomKPSVPUhP
 nVZoQQM0k/HBA2aQNRl9acUNw4S+UB9iPmUeNXiDHI+uleYj5J9PwzV
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The cycle count register has a 20-bit effective width, but the driver
only utilizes 16 bits. This reduces the sampling window when measuring
high-frequency clocks, resulting in (slightly) degraded measurement
accuracy.

The input clock signal path from gate (Controlled by MSR_RUN) to internal
sampling circuit in clk-measure has a propagation delay requirement: 24
clock cycles must elapse after mux selection before sampling.

The measurement circuit employs single-edge sampling for clock frequency
detection, resulting in a ±1 cycle count error within the measurement window.

+1 cycle: 3 rising edges captured in 2-cycle measurement window.
    __    __    __
 __↑  |__↑  |__↑  |__
  ^             ^

-1 cycle: 2 rising edges captured in 3-cycle measurement window.
    __    __    __
 __↑  |__↑  |__↑  |__↑
    ^               ^

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Improve measurement accuracy by increasing the bit width of the cycle
counter register and adding delay during measurement.

The 800μs delay between enabling the input clock gate and activating
sampling is determined by the minimum sampling frequency of 30kHz (the
lowest commonly used frequency in applications is 32.768kHz).

Here are the test comparisons based on C3:

Pre-optimization:
cat /sys/kernel/debug/meson-clk-msr/measure_summary 
  clock                     rate    precision
---------------------------------------------
 sys_clk               166664063    +/-5208Hz
 axi_clk               499968750    +/-15625Hz
 rtc_clk                23982813    +/-3125Hz
 p20_usb2_ckout        479968750    +/-15625Hz
 eth_mpll_test         499992188    +/-15625Hz
 sys_pll              1919875000    +/-62500Hz
 cpu_clk_div16         119998162    +/-3676Hz
 ts_pll                        0    +/-3125Hz
 fclk_div2             999843750    +/-31250Hz
 fclk_div2p5           799953125    +/-31250Hz
 fclk_div3             666625000    +/-20833Hz
 fclk_div4             499914063    +/-15625Hz
 fclk_div5             399987500    +/-12500Hz
 fclk_div7             285709821    +/-8928Hz
 fclk_50m               49982813    +/-3125Hz
 sys_oscin32k_i            26563    +/-3125Hz

Post-optimization:
cat /sys/kernel/debug/meson-clk-msr/measure_summary 
  clock                     rate    precision
---------------------------------------------
 sys_clk               166665625    +/-1562Hz
 axi_clk               499996875    +/-1562Hz
 rtc_clk                24000000    +/-1562Hz
 p20_usb2_ckout        479996875    +/-1562Hz
 eth_mpll_test         499996875    +/-1562Hz
 sys_pll              1919987132    +/-1838Hz
 cpu_clk_div16         119998438    +/-1562Hz
 ts_pll                        0    +/-1562Hz
 fclk_div2             999993750    +/-1562Hz
 fclk_div2p5           799995313    +/-1562Hz
 fclk_div3             666656250    +/-1562Hz
 fclk_div4             499996875    +/-1562Hz
 fclk_div5             399993750    +/-1562Hz
 fclk_div7             285712500    +/-1562Hz
 fclk_50m               49998438    +/-1562Hz
 sys_oscin32k_i            32813    +/-1562Hz
---
Changes in v3:
- Drop Change-Id. 
- Link to v2: https://lore.kernel.org/r/20250722-optimize_clk-measure_accuracy-v2-1-cb121fd57e6d@amlogic.com

Changes in v2:
- Change "HACK" in comments to "NOTE" according to Martin's suggestion.
- Link to v1: https://lore.kernel.org/r/20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com
---
 drivers/soc/amlogic/meson-clk-measure.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index d862e30a244e..df395e015f26 100644
--- a/drivers/soc/amlogic/meson-clk-measure.c
+++ b/drivers/soc/amlogic/meson-clk-measure.c
@@ -22,7 +22,7 @@ static DEFINE_MUTEX(measure_lock);
 #define MSR_CLK_SRC		GENMASK(26, 20)
 #define MSR_BUSY		BIT(31)
 
-#define MSR_VAL_MASK		GENMASK(15, 0)
+#define MSR_VAL_MASK		GENMASK(19, 0)
 
 #define DIV_MIN			32
 #define DIV_STEP		32
@@ -805,14 +805,23 @@ static int meson_measure_id(struct meson_msr_id *clk_msr_id,
 	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_DURATION,
 			   FIELD_PREP(MSR_DURATION, duration - 1));
 
-	/* Set ID */
-	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_CLK_SRC,
-			   FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id));
+	/* Set the clock channel ID and enable the input clock gate. */
+	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_CLK_SRC | MSR_RUN,
+			   FIELD_PREP(MSR_CLK_SRC, clk_msr_id->id) | MSR_RUN);
 
-	/* Enable & Start */
-	regmap_update_bits(priv->regmap, reg->freq_ctrl,
-			   MSR_RUN | MSR_ENABLE,
-			   MSR_RUN | MSR_ENABLE);
+	/*
+	 * NOTE: The input clock signal path from gate (Controlled by MSR_RUN)
+	 * to internal sampling circuit in clk-measure has a propagation delay
+	 * requirement: 24 clock cycles must elapse after mux selection before
+	 * sampling.
+	 *
+	 * For a 30kHz measurement clock, this translates to an 800μs delay:
+	 * 800us = 24 / 30000Hz.
+	 */
+	fsleep(800);
+
+	/* Enable the internal sampling circuit and start clock measurement. */
+	regmap_update_bits(priv->regmap, reg->freq_ctrl, MSR_ENABLE, MSR_ENABLE);
 
 	ret = regmap_read_poll_timeout(priv->regmap, reg->freq_ctrl,
 				       val, !(val & MSR_BUSY), 10, 10000);
@@ -846,7 +855,7 @@ static int meson_measure_best_id(struct meson_msr_id *clk_msr_id,
 	do {
 		ret = meson_measure_id(clk_msr_id, duration);
 		if (ret >= 0)
-			*precision = (2 * 1000000) / duration;
+			*precision = 1000000 / duration;
 		else
 			duration -= DIV_STEP;
 	} while (duration >= DIV_MIN && ret == -EINVAL);

---
base-commit: 58abdca0eb653c1a2e755ba9ba406ee475d87636
change-id: 20250523-optimize_clk-measure_accuracy-9e16ee346dd2

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



