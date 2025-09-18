Return-Path: <linux-kernel+bounces-765366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A7B22F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20957562675
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE62FF17D;
	Tue, 12 Aug 2025 17:37:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E02F83CB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020246; cv=none; b=HLSerY7He6RAnnLVy01X7Ot6ccJAk2VpVNF7SJF3ZoVH6meWMGcYHRY1VPxTzQijnr0VN+0BvcUUaiCODgLdA0Xp1X2vaTmzkYVr5U+86QPEUEAw/bglhK0iFdbrvNtObz/Tz/Zn2uq43msHI39qpoX2FcmZZndT4z1JOziRoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020246; c=relaxed/simple;
	bh=ItqmccYk2DbP884U7uFDE6CPkwudpiKkSRZxWMq/pao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P25unAeOViWfMKTIylomlfSdORqjgfuppjD+2yTUYcfJZEWurLXdwc4n67Tp62VKQKN/ykx8L95rifsdAgiuVjvwslUCd2w9g2w8sFM33hOvv1QIGQNiSUlcKbfJ0qA3cWhvaD6j4doJfvw4T+E5ozzfKqPgRhGCelwsT+BhXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw5-0008E2-Lc
	for linux-kernel@vger.kernel.org; Tue, 12 Aug 2025 19:37:21 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw4-00DEaB-1R
	for linux-kernel@vger.kernel.org;
	Tue, 12 Aug 2025 19:37:20 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1DC5245623C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:20 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E14124561F5;
	Tue, 12 Aug 2025 17:37:16 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ed9da29;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 12 Aug 2025 19:36:52 +0200
Subject: [PATCH 2/7] can: m_can: m_can_rx_handler(): only handle active
 interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-m_can-fix-state-handling-v1-2-b739e06c0a3b@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1185; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=ItqmccYk2DbP884U7uFDE6CPkwudpiKkSRZxWMq/pao=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBom3vAFkF/2bwZJ33yPfZDOKBNXoK6PZSRONnPK
 /gZ27APa1OJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJt7wAAKCRAMdGXf+ZCR
 nHAaCACaMCpP99b2/EkL6j83V1Hcxz7qYoOWbVR2f0FgO+x+HH8J75XsHdVtplxIr/442osiLQy
 5F8Y1izwUxTCtYgc855d9OE6+gMkZxnYyfPzGEQ6eLUlEHKgjIxaBiJqlmvBCwRvLmMvehtfn2f
 xyfgIf+6uhQk6wvNGGAmqmo/w/+45vZLkkFTuN5DhzRO7uUdfU/10eqfgbCHnyMMQIWEn27NXrF
 xNDT07tdDzPiBuBJBJFcmDBFArol6u9S8/KrZKir6ULHbuH5L5LlLETp9nzGOu56l1HZvoeo/bA
 s/OrX6nEC11BC+i6jZpUiGJk0pg8ocGnAZB6V7BrHH3IRrfp
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Among other things, the M_CAN IP core has an Interrupt Register (IR)
and an Interrupt Enable (IE) register. An interrupt is triggered if at
least 1 bit is set in the bitwise and of IR and IE.

Depending on the configuration not all interrupts are enabled in the
IE register. However the m_can_rx_handler() IRQ handler looks at all
interrupts not just the enabled ones. This may lead to handling of not
activated interrupts.

Fix the problem and mask the irqstatus (IR register) with the
active_interrupts (cache value of IE register).

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fe74dbd2c966..a51dc0bb8124 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1006,6 +1006,7 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	int rx_work_or_err;
 	int work_done = 0;
 
+	irqstatus &= cdev->active_interrupts;
 	if (!irqstatus)
 		goto end;
 

-- 
2.50.1



