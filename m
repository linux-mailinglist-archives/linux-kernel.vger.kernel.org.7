Return-Path: <linux-kernel+bounces-845891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC5BC66BE
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 083BD4F0FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDF62D0617;
	Wed,  8 Oct 2025 19:08:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9462C11D0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950493; cv=none; b=Wld1Z+khrBNsPLqqnZCXbjDUZmYx7IBunH/2Hg9VwzQa378EbIVbdanlYwiUguDQBLbI4pm3awtxddrm0q2wYqsIW1PdmUTNnoBygYOkvhgShIfc9nDfHZbZHUViyaISvVaH+ID5LbcOHrKUmh5/edl6sUwLV/KZKLp7GuV6BHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950493; c=relaxed/simple;
	bh=QBGzxRQ1kuWEuxxcTY9fXeD4sD1cfK6LM5d4L2J0Cc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fo/rthvQp9aLVbcS8zIy6qv3Go+U4E4AEkmi3zUePhxO+ByVANovI3N0iwP09ztZAAzYYar/knO7/YDfrAiQ+pOq/GM9tTpwJKEaLay8EYRwwaDnSuDNRvRbe3giNGrw+B2jvbOdXaoTtUf0fn8+RVOrWkrd9FXIYLbG6T+tres=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RP-3Q; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDI-15;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E49324821F8;
	Wed, 08 Oct 2025 19:07:58 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:39 +0200
Subject: [PATCH 4/7] can: m_can: m_can_interrupt_enable(): use
 m_can_write() instead of open coding it
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-4-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=QBGzxRQ1kuWEuxxcTY9fXeD4sD1cfK6LM5d4L2J0Cc8=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raHCjOtH30KrpSIx3wMjdkOYa6Cc3BMiz8XR
 67qrDimY5CJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2hwAKCRAMdGXf+ZCR
 nM34B/9Kc1JXb6+rle+Ey9GsFUBnfzrZ6DLQo9QsafynnD5FO5CdVZ8qaF/R/Y6j4/mF7/fAenH
 O8FA4GKT7SvCEX1A95BAQrsim32BPhtyI8FmYWSC2DGa7MhbqRUzsq9OVSWuJ1znQRNEtQf7lCm
 1V3hq+RQZ9IDpxTHXzNrM1/0cAVpRe02w1i7OiS4uB2kLrPT/kgx8Ci2ASUwW+IwT+gOPp2lTSy
 9IwKnR0onKLpS6Ch0C247suP37u1BvDNh/VdrDW7QEI/hcfwdaEjx7pUhXZ1oKTmSFohDY/i9iK
 Yxajb5eDu02hzYT8P/Nt3RQLPekptjkdkODQ1T572sHehPID
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As everywhere else in the driver, use m_can_write() instead of open coding
it.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 4ca84f9a2734..4cb4eee3602a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -451,7 +451,7 @@ static void m_can_interrupt_enable(struct m_can_classdev *cdev, u32 interrupts)
 {
 	if (cdev->active_interrupts == interrupts)
 		return;
-	cdev->ops->write_reg(cdev, M_CAN_IE, interrupts);
+	m_can_write(cdev, M_CAN_IE, interrupts);
 	cdev->active_interrupts = interrupts;
 }
 

-- 
2.51.0


