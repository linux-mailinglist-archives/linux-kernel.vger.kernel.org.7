Return-Path: <linux-kernel+bounces-727386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B20B01970
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8485D3AEDC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A088279DC6;
	Fri, 11 Jul 2025 10:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="pTDSpAMf"
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50327055F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228754; cv=none; b=mJgWO4xnwkydzfejLvEyZWcn9xbg2R9KvbXnR9972oRqfMKRg/DQWv9sJkaT9zGEpEaXDtEmVtPovHIf6pbaFCP2fGXd8OCEK0RBr+KtnVbhsAc0HtsekIGaCgfOkszdLVf4WC84DD4rZNlAtqvOxumsiaVRgZjXVePnDQA6YLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228754; c=relaxed/simple;
	bh=GsJAktsLzBSkUqKxmNyIud2QtPzK59Ps032nisqaXu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T4MINLzpAd22JkJV6Vk1bzvNARkdpY0qL2ef11ya/84a+hpawVAODfeW+kIqvWjSAF4JRvf5K8a/9o1ur29TT4tXw10i+dhUtUlLJKjgGq+8gPhuz+R7XhJS2feSM8qJMtXocIbZrYXy2WUafgwimkfJYSHQ3D79a5tZsqUythY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=pTDSpAMf; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752228744; x=1752487944;
	bh=gMuCuy0ZhjOIihQTRLQbxSG+m/8hn34n3LWqYdrlNPk=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=pTDSpAMfodAxao3eYwYXrRQoLzPvdrajvr+A08h8oVD5ntwzcEm5t9bjgHW0Py8oZ
	 E5DC2dTisyoPyOGgkUe5DH17Ks+L+6FwMrPJmE/jshsQ5YnyLrQcxSeOfjm/qEJo0S
	 0SDP7V0GmVvH0HBDrGCCVVzE9PtoJx4M9APMcYbmkzVrI1Q1eAyX6a/2bKRljZd/j8
	 sdsoBjspcPO5mjanH1nWNSVG8V0p+O8u5tcwazSHRFIPElPRfP/ZVRAMtudilxhShu
	 WsfTbjuF1iXk6zV754N+NWWSesvLLntGTILcxYvgSc7KDRXqZobJmVrQyeCbNPZnz1
	 xUfXv3NvyX5Rw==
X-Pm-Submission-Id: 4bdnZY6dcxz1DDX1
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 11 Jul 2025 12:12:02 +0200
Subject: [PATCH v3] can: m_can: downgrade msg lost in rx to debug level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-mcan_ratelimit-v3-1-7413e8e21b84@geanix.com>
X-B4-Tracking: v=1; b=H4sIAHHjcGgC/3XM0QqCMBTG8VeRXbfY2cxlV71HRKx5pgdyxibDE
 N+96VURXX4f/H8zixgIIzsVMwuYKNLg81C7gtnO+BY5NXkzKeRBVFLw3hp/C2bEB/U0ctQIrm6
 OztSW5egZ0NG0gZdr3h3FcQivzU+wvn+pBByyV2pEJZwGd27ReJr2dujZaiX50avfXua+umsjQ
 JWApv7ql2V5AxL9yxTtAAAA
X-Change-ID: 20250620-mcan_ratelimit-e7e1f9d8fa9c
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Prevent flooding the kernel log with error messages.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes in v3:
- Removed ratelimit as it still would output  "... output lines suppressed
  due to ratelimiting", but no message is shown.
- Link to v2: https://lore.kernel.org/r/20250630-mcan_ratelimit-v2-1-6b7a01341ea9@geanix.com

Changes in v2:
- Changed to dbg msg
- Link to v1: https://lore.kernel.org/r/20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com
---
 drivers/net/can/m_can/m_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6c656bfdb3235e1f5d6405c49b07b821ddacc1b9..fe74dbd2c9663b7090678ab78318698d50ffb481 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -665,7 +665,7 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct can_frame *frame;
 	u32 timestamp = 0;
 
-	netdev_err(dev, "msg lost in rxf0\n");
+	netdev_dbg(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
 	stats->rx_over_errors++;

---
base-commit: db22720545207f734aaa9d9f71637bfc8b0155e0
change-id: 20250620-mcan_ratelimit-e7e1f9d8fa9c

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


