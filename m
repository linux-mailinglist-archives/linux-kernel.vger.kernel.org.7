Return-Path: <linux-kernel+bounces-734568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9427B08339
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4786D1C276E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14381DB92C;
	Thu, 17 Jul 2025 03:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX5pypdB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293852E3701
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752721691; cv=none; b=LPyBE6i61v/6nm6ZhYYEqZGRL8GjXlJEZeErucQxv8n/RW8nRSCdUQTDjv+36Re/t/psR12bVZTV+hjt3cb8GIlbfk8aNE/r2Xd1zfS2OwswIzVaTmuhMzWiXgL+mkJ6xL2A4PB2R9hdG1KTxQAM4pr+2z6Raqk5Pj8wSdhs8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752721691; c=relaxed/simple;
	bh=4SbZOGoIxtQo1rGECKFAZdr/6VLyc+7wD892puNo1I0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HPc1EcbXRJ1OjGSK/7QJ+krBYUdn0I0YxsxEKcmHVfI4ahdDfo6YK1DRa6+3gKsXVFt+qmGypdkoUrDJJSx5tXcGqjJOauUR2RIvZ9NuEyAavdh+itmw+HUEJQV05p+K9EoPjeUZqGyb75h6clRuxSNOFMQsmtWej3xomBTY2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX5pypdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9DD0C4CEE7;
	Thu, 17 Jul 2025 03:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752721690;
	bh=4SbZOGoIxtQo1rGECKFAZdr/6VLyc+7wD892puNo1I0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=XX5pypdBtSxAK3cVqbi+5sN9zs8G69RNUKndz5wXo5YuRJd6BwZ6NgY8mqYf74lGi
	 i+GYeT1uYsVcd4H33gvUlcZl8z5ulq4e0f6SJUl1cAv6D5l6+nr+geY4GWmnos1xI1
	 3bvAkSFCaVumYxYQgzETozeSpShr8vXur97YReu6vIqIgGXsQnOK7x8VJfudCpwz4W
	 CBQyOW+bEPspiwb84D5ET6rqW5JHc+IASyiU2aaEsA8NMvv7S5QapJSBaXgauBNO21
	 z/oXza/2ztSa/29EsFvnskupKPeAoTyy2Bu9K9TfpU0KsHVQU8qj8Wq11RLOZ/kLOw
	 OweTlOYraIxIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E4C83F27;
	Thu, 17 Jul 2025 03:08:10 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 17 Jul 2025 11:08:06 +0800
Subject: [PATCH] soc: amlogic: clk-measure: Optimize measurement accuracy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-optimize_clk-measure_accuracy-v1-1-3b82d7ccd743@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABVpeGgC/x3MywqDMBAF0F+RWTeg8QH6K1IkTK52qC8mtbSK/
 25weTbnoAAVBGqSgxRfCbLMEdkjIX65eYARH002tWVa2tws60cm2dHx+DYTXNgUnWPe1PHf1Mg
 qIC8q7y3FY1X08rv/9nmeF2IYvtRvAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752721686; l=5665;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=N/3vlGG77ppUoldRn7mPDqs/Hb4HNtWv9DnFUzoDwtI=;
 b=G3dQuHvUVUhhE01nAgkCx1Jt5YmO8wMiDGj6Wgqen4aLCwVYmY/SBQ+xhKvn1XBhd/zWh9yDz
 qH6T4KFQQTUC/T1P15jA2eUb5E7cUIo9jrtuAttVgOH2m/4UrgN0D1Q
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

Change-Id: If367c013fe2a8d0c8f5f06888bb8f30a1e46b927
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
 drivers/soc/amlogic/meson-clk-measure.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/amlogic/meson-clk-measure.c b/drivers/soc/amlogic/meson-clk-measure.c
index d862e30a244e..82acd8635bf8 100644
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
+	 * HACK: The input clock signal path from gate (Controlled by MSR_RUN)
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
base-commit: 87b480e04af45833deb5af1584694b0077805ea6
change-id: 20250523-optimize_clk-measure_accuracy-9e16ee346dd2

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



