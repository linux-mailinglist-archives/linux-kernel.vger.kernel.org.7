Return-Path: <linux-kernel+bounces-834906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2DBA5CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB574C70E3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2752D6E7E;
	Sat, 27 Sep 2025 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="OJIGcH/P"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D392D6E77
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966128; cv=none; b=gZ2U/e+Cyveqeju68OuYO4cwnrqSWGCTRY7IXEhPBK9rL+zrKUH5EXCgcALThjQl6QX3q/Rs4OBqMqdiC6S2qirouRKhqK6Jx9hppgDjRTz0mEgJW/ALxT+d5hGo13GRt3HvjPA++FuKmgwbh67iSr2XFPl9gkblgFxXxl2ur3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966128; c=relaxed/simple;
	bh=hj9SQaZQ+NV1jo8qCsoqhEp+uAha3FzKkF1vJ4yct8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVx5kn4QURLVdOdgz6EU/7Jpy9WqQvw1etlHqVskSOq1XuNvENwJGnh5n1nNX91p2PZebJxV5Oj8lUbHL9drIBUWyNBXklwbEFU43VdKRX9vZZS6yiYCnSx4muaqplDRKv6fBXp58b65eouVBksPAUtinv/mUeAsgj250zn7Mig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=OJIGcH/P; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1758966123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJjBFBfPE6u5zLZVPpTcas9pDk+d/zRNn1H+l1sjsiA=;
	b=OJIGcH/PqeyTMTwxhWqadvm8TobreeF1C3abUHlNXW2fRXMwuXFdXLZvfkdgCWiICjQ0gl
	VG7wkJwnLvxPU5cHeINO7ZpCK84wcy1B+pj3yYt7Buj3KM6evQOVGgHmWkjK88lWNp39Sr
	ngpDLGVwIGOE76oiylVnXynxMGvclwtCTz6BdZqQGT7eeOLYFam8shN2+7FAdKxes8NCG6
	l/Ut/f2ofL03QjYzuV2YTaIj45llSrotjcocaFxgVVgo8OEhoGObLv2LWj5Q9Mqh9L2zUF
	K6xX0l0nhUEI0P4+AuJOJNdluUu25ODIlLSwHUhsQjRKjCERIcRzhc0eO/6JCg==
From: Val Packett <val@packett.cool>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Val Packett <val@packett.cool>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: qcom: qmp-combo: Move pipe_clk on/off to common
Date: Sat, 27 Sep 2025 06:17:32 -0300
Message-ID: <20250927093915.45124-2-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Keep the USB pipe clock working when the phy is in DP-only mode, because
the dwc controller still needs it for USB 2.0 over the same Type-C port.

Tested with the BenQ RD280UA monitor which has a downstream-facing port
for data passthrough that's manually switchable between USB 2 and 3,
corresponding to 4-lane and 2-lane DP respectively.

Note: the suspend/resume callbacks were already gating the enable/disable
of this clock only on init_count and not usb_init_count!

Signed-off-by: Val Packett <val@packett.cool>
---
o/

Just got my hands on a perfect test device for DP alt mode: a monitor with an
on-demand toggle between 2 and 4 lanes. (Started digging because I thought
I needed 4 lanes to use its full resolution and refresh rate, even though
it turned out to be the dpu adjusted mode clock check rejecting the modes,
patches for which are already posted.)

In [1] Konrad mentioned that "the hardware disagrees" with keeping the USB
PLL always on. I'm not sure what exactly was meant by disagreement there,
and I didn't find any specific code that touches that PLL in the driver,
so I decided to just try it anyway.

Before the changes, 4-lane mode would actually kill the USB 2.0 functionality
on the port, no recovery until reboot.

With this patch, I can switch the monitor between 4-lane and 2-lane modes
(with an unplug-replug cycle..) and the USB 2.0 devices attached through
the monitor keep working! (I verified the number of lanes used via dp_debug).

I'm sure it might not be that simple but from my limited and uninformed
understanding without any internal knowledge, the "sneaky workaround"
might actually be the intended way to do things?

Thanks,
~val

P.S. if I'm actually wrong and this is not acceptable for $reasons, the suspend
and resume callbacks would need to be changed to match the logic of having the
clk on depending on usb_init_count, not just the overall init_count.

[1]: https://lore.kernel.org/all/f21b7d52-4c3f-4e5b-bee7-f8b2945b5b02@oss.qualcomm.com/

---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 7b5af30f1d02..c4bbd738eba1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3035,6 +3035,13 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
 	if (ret)
 		goto err_assert_reset;
 
+	/* In DP-only mode, the pipe clk is still required for USB2 */
+	ret = clk_prepare_enable(qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
 	qphy_setbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
 
 	/* override hardware control for reset of qmp phy */
@@ -3103,6 +3110,7 @@ static int qmp_combo_com_exit(struct qmp_combo *qmp, bool force)
 	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
 
 	clk_bulk_disable_unprepare(qmp->num_clks, qmp->clks);
+	clk_disable_unprepare(qmp->pipe_clk);
 
 	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
 
@@ -3205,12 +3213,6 @@ static int qmp_combo_usb_power_on(struct phy *phy)
 
 	qmp_configure(qmp->dev, serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
 
-	ret = clk_prepare_enable(qmp->pipe_clk);
-	if (ret) {
-		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
-		return ret;
-	}
-
 	/* Tx, Rx, and PCS configurations */
 	qmp_configure_lane(qmp->dev, tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
 	qmp_configure_lane(qmp->dev, tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
@@ -3254,8 +3256,6 @@ static int qmp_combo_usb_power_off(struct phy *phy)
 	struct qmp_combo *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 
-	clk_disable_unprepare(qmp->pipe_clk);
-
 	/* PHY reset */
 	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
 
-- 
2.51.0


