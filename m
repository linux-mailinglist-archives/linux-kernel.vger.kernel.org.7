Return-Path: <linux-kernel+bounces-695329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A28AE186F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419754A21AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17E52882AD;
	Fri, 20 Jun 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LqzfNiej"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937E9284B25
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413629; cv=none; b=jqmvKYqD39KKdCYDyKzPigiHf5zzWIM6p75C5w2oXKtk2n969W2uiwq2uXYHID9vj/0GZoIyIBJAkFG5yMJkM+PEj4KhbtL8zYs08CNO7/EqsGP8+WMdpxtWUdmyEDLBdDCrM7gpMmxAqgQ54mhXljJUsRkF9jDlTQOf5rmD9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413629; c=relaxed/simple;
	bh=Qh0eD56oexLNcnFsB7QSFehrHbHv1+nlKA8RT+W0iFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aqTPGpPtymGfEOT7xXrIFjzJcwd+nNCNO097SWglLRYVBHw2BFn45r8S9qEneHBgMEtIUoTQvWIR5tf5TZ8gK19AahI1j39aF2F5VO9Zw1qgw1mby8MUHtk6BGnMHqedANdnmn5YdCao/h+eLI2FUjElBB3bfBWRftC+GCEnuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LqzfNiej; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1750413608; x=1750672808;
	bh=JRde0elAJvrisH+EQ4PUJFqG0VzLpDnXSpexrfj9oto=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=LqzfNiejijEGbtNsFio1k8cHAhcJZF8Z2mhpSXfjw9UQD9mBlKHU/vbSkixCUQ0xz
	 ibpYtxodon3ROWj7ef1QtEMn2pnGqnZ9T8Ixnag9fZGbb+IJKSNsrOulrjSWD76GfB
	 vPNrngBztZQqGTyvgfoiL+Cuj05oM22ZLJ0W7aRlP1nI6NCq0W10JRnwD2yniDlbth
	 lTx5E2IG2MYphZ4Z5/zam/o5Z1ykPJKpTlnhUCTuzox+TPuuaq4eVJ23+2zG5ArB+z
	 U2fIoQznrnOKB3kf2UEXpUdpipQnzrttoW9MWGFDZ6slxMLfcQjbP35Fho/PmBK4G/
	 4LU2aFP88P0sw==
X-Pm-Submission-Id: 4bNtJ74Mnwz1DDr8
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 20 Jun 2025 12:00:01 +0200
Subject: [PATCH] can: m_can: apply rate-limiting to lost msg in rx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-mcan_ratelimit-v1-1-e747ee30f71f@geanix.com>
X-B4-Tracking: v=1; b=H4sIACAxVWgC/x3MTQqAIBBA4avIrBNU6MeuEhFiYw2khUYE4t2Tl
 t/ivQwJI2GCkWWI+FCiM1TIhoHdTdiQ01oNSqhWdEpwb01YornxIE83xx6l0+vgjLZQoyuio/c
 fTnMpHz+PyQ1gAAAA
X-Change-ID: 20250620-mcan_ratelimit-e7e1f9d8fa9c
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

Wrap the "msg lost in rxf0" error in m_can_handle_lost_msg() with
a call to net_ratelimit() to prevent flooding the kernel log
with repeated error messages.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6c656bfdb3235e1f5d6405c49b07b821ddacc1b9..b0638d23879cf4257b8f4555d1123f45f9595ad7 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -665,7 +665,8 @@ static int m_can_handle_lost_msg(struct net_device *dev)
 	struct can_frame *frame;
 	u32 timestamp = 0;
 
-	netdev_err(dev, "msg lost in rxf0\n");
+	if (net_ratelimit())
+		netdev_err(dev, "msg lost in rxf0\n");
 
 	stats->rx_errors++;
 	stats->rx_over_errors++;

---
base-commit: db22720545207f734aaa9d9f71637bfc8b0155e0
change-id: 20250620-mcan_ratelimit-e7e1f9d8fa9c

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


