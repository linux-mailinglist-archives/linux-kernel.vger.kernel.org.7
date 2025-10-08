Return-Path: <linux-kernel+bounces-845892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C3BC66B8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED2619E45D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FB2D0625;
	Wed,  8 Oct 2025 19:08:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942D2C08C4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950493; cv=none; b=dagBYM4g40BTZ3keZZIWg3GiTUJmE1evVqleoflaeHWXmv5ZqmnQk89sitlc4It8eA3oJzhXPomEpJ0lXgygpPFvJ+sj1u+nquP8dnF7lsJhyA5oKiLrwpo+5wOXDrQSg/lxOwlmTUM6m20laksYxVyOJAtSTtyLeyC9WOddBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950493; c=relaxed/simple;
	bh=vP4s1Ig2LIoMVqDjv/SxxsVEZ/CtWQv643jJiKhNioU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FohEhWWTrwIkZcnRKOMJXs1+DzYnDdmart8XN93yCByshLVCXag052W4NYROzqRXxDuLIp/O6/FA37ImJI30iU43hMdv0sIgf82Aal25FtU10uf9/B9l46LPncq53YAWTTUNHSm+l4Q2HJiZyp5uHtWEeXwhBfV0nDE26HI5Gys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RM-3P; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDD-0P;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C06BB4821F5;
	Wed, 08 Oct 2025 19:07:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:36 +0200
Subject: [PATCH 1/7] can: m_can: m_can_init_ram(): make static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-1-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=vP4s1Ig2LIoMVqDjv/SxxsVEZ/CtWQv643jJiKhNioU=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raBb5T2wvfQ1oCBqI0RfW+fUyS8pY6lV7ltb
 fRAAHfW4yqJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2gQAKCRAMdGXf+ZCR
 nB79B/4rLZrI/61hb2gupzZRRmrliKS6LhPg5KEwq2qDewIb5ZM6JDXVGwdHM2hkvcYoPEG4lFm
 8iMxOzBtCLswHuGb8qrfj4BBf7RZvxRANBPFs6vKKrUW/fOT3+rAQMpzeS0uSwV7I8PnRFAumYo
 uMBn/+UmGM+i3BLYh8BiX4vQf9LxHeDyPMBQc2MbP0pAsXMojbKs1eRrPvly2ArTOTHx8UgCYSe
 6fBdZ11mg/6nJBez0SzP4qSdkmOBJc5zLQGj2xsoWrjETX/ZX6gZtF1R/UebkXzWfhzQYapjjwr
 0sVB2jouLTuY4sj0vZVg7AoM7oleVB3LV5fKl4Ebus79PYxP
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Since commit eaacfeaca7ad ("can: m_can: Call the RAM init directly from
m_can_chip_config") m_can_init_ram() is not used outside of m_can.c.

Mark as static and remove the EXPORT_SYMBOL_GPL().

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 43 +++++++++++++++++++++----------------------
 drivers/net/can/m_can/m_can.h |  1 -
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e1d725979685..03e2c431ffab 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1368,6 +1368,27 @@ static const struct can_bittiming_const m_can_data_bittiming_const_31X = {
 	.brp_inc = 1,
 };
 
+static int m_can_init_ram(struct m_can_classdev *cdev)
+{
+	int end, i, start;
+	int err = 0;
+
+	/* initialize the entire Message RAM in use to avoid possible
+	 * ECC/parity checksum errors when reading an uninitialized buffer
+	 */
+	start = cdev->mcfg[MRAM_SIDF].off;
+	end = cdev->mcfg[MRAM_TXB].off +
+		cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
+
+	for (i = start; i < end; i += 4) {
+		err = m_can_fifo_write_no_off(cdev, i, 0x0);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 static int m_can_set_bittiming(struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
@@ -2303,28 +2324,6 @@ static void m_can_of_parse_mram(struct m_can_classdev *cdev,
 		cdev->mcfg[MRAM_TXB].off, cdev->mcfg[MRAM_TXB].num);
 }
 
-int m_can_init_ram(struct m_can_classdev *cdev)
-{
-	int end, i, start;
-	int err = 0;
-
-	/* initialize the entire Message RAM in use to avoid possible
-	 * ECC/parity checksum errors when reading an uninitialized buffer
-	 */
-	start = cdev->mcfg[MRAM_SIDF].off;
-	end = cdev->mcfg[MRAM_TXB].off +
-		cdev->mcfg[MRAM_TXB].num * TXB_ELEMENT_SIZE;
-
-	for (i = start; i < end; i += 4) {
-		err = m_can_fifo_write_no_off(cdev, i, 0x0);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(m_can_init_ram);
-
 int m_can_class_get_clocks(struct m_can_classdev *cdev)
 {
 	int ret = 0;
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index bd4746c63af3..46948c46d980 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -135,7 +135,6 @@ void m_can_class_free_dev(struct net_device *net);
 int m_can_class_register(struct m_can_classdev *cdev);
 void m_can_class_unregister(struct m_can_classdev *cdev);
 int m_can_class_get_clocks(struct m_can_classdev *cdev);
-int m_can_init_ram(struct m_can_classdev *priv);
 int m_can_check_mram_cfg(struct m_can_classdev *cdev, u32 mram_max_size);
 
 int m_can_class_suspend(struct device *dev);

-- 
2.51.0


