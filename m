Return-Path: <linux-kernel+bounces-765364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84926B22F50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA151A27A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFC92FE579;
	Tue, 12 Aug 2025 17:37:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410EE2F90F9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020246; cv=none; b=tvX8MeJncy0il6VKlA+l3t1l8k7t6Qb9ZJ0gqvRJ7pxD10d7GIhzHHt+JpfhXxgW0j8rK8w7EZgRzcEqbiMCjLQuY1FzRe7eJleuEIARvDCuhh0z6Co2kNgSN27LkVGpRYJDp03kjq/GWNO2MB9I1XvNrGSRt8mD506zrwivras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020246; c=relaxed/simple;
	bh=LYj7+cw7SUdqJLM3S/LbDR3XePgovU5/Y93e7D5jugg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgn8v9uqG3RWM2Do+anbl7n46cUV4LkoXxGG66r2ZhqJWAd8KAQ/aVwwkofndbc5J7ZPL1Ntd0AzHPd0hAqwhgVXHLmGORQ+ZPn05yUZKcsdQAcIPVYs+OJmReOVZhQxSALq3/vB0xIn3xb+qRMQYTP/E0WZ3uXbSUhcbjLBWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw6-0008FK-6I
	for linux-kernel@vger.kernel.org; Tue, 12 Aug 2025 19:37:22 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw4-00DEao-2f
	for linux-kernel@vger.kernel.org;
	Tue, 12 Aug 2025 19:37:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 83404456248
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7738B4561FE;
	Tue, 12 Aug 2025 17:37:17 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id bfad522c;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 12 Aug 2025 19:36:55 +0200
Subject: [PATCH 5/7] can: m_can: fix CAN state in system PM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-m_can-fix-state-handling-v1-5-b739e06c0a3b@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LYj7+cw7SUdqJLM3S/LbDR3XePgovU5/Y93e7D5jugg=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBom3vGs5ftwxHIXOsYT+TB/LasWtsg/WFiA+IIm
 xlwh7WxGQaJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJt7xgAKCRAMdGXf+ZCR
 nDZuCACcjVWaap0xsdwmsPXefW+Dpui/kbwjJDkupLZ3t6QuqETXchx3RFx28w9HbMcAn4/cs6X
 n6FTkK6vgvRlYiwV8erJUEGrhh3ARjh+f70v6aHOhRnn0OYn1K5PnHkA8HhvaBz5Ljasc/JHKP6
 uyh/mR1RlWn7BKmeNgdR2rD+rQuSYLYIDhZGVAarH8OGvROR9Dn7Am08y1/rSAcB7P2SvShkeCc
 IVQdSrvdzvYhama6QJjFE1D7FZxtjRyjVYy6iGszkq0vHY9d4+QVBx3WvggEeid02KOr8WOV6/f
 gIoOJHbPkSXOQS8DzvpugpJym3UX4RQYEeGRpHwqBXrGqS3p
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

A suspend/resume cycle on a down interface results in the interface
coming up in Error Active state. A suspend/resume cycle on an Up
interface will always result in Error Active state, regardless of the
actual CAN state.

During suspend, only set running interfaces to CAN_STATE_SLEEPING.
During resume only touch the CAN state of running interfaces. For
wakeup sources, set the CAN state depending on the Protocol Status
Regitser (PSR), for non wakeup source interfaces m_can_start() will do
the same.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 310a907cbb7e..149f3a8b5f7e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2507,12 +2507,11 @@ int m_can_class_suspend(struct device *dev)
 		}
 
 		m_can_clk_stop(cdev);
+		cdev->can.state = CAN_STATE_SLEEPING;
 	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	cdev->can.state = CAN_STATE_SLEEPING;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(m_can_class_suspend);
@@ -2525,14 +2524,14 @@ int m_can_class_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	cdev->can.state = CAN_STATE_ERROR_ACTIVE;
-
 	if (netif_running(ndev)) {
 		ret = m_can_clk_start(cdev);
 		if (ret)
 			return ret;
 
 		if (cdev->pm_wake_source) {
+			u32 reg_psr;
+
 			/* Restore active interrupts but disable coalescing as
 			 * we may have missed important waterlevel interrupts
 			 * between suspend and resume. Timers are already
@@ -2544,6 +2543,9 @@ int m_can_class_resume(struct device *dev)
 			if (cdev->ops->init)
 				ret = cdev->ops->init(cdev);
 
+			reg_psr = m_can_read(cdev, M_CAN_PSR);
+			cdev->can.state = m_can_can_state_get_by_psr(reg_psr);
+
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);

-- 
2.50.1



