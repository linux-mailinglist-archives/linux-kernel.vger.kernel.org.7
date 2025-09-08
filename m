Return-Path: <linux-kernel+bounces-804926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA2AB48208
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA4189C447
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C01FE44A;
	Mon,  8 Sep 2025 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="gZJHO4D0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iscf8s9u"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6D51DF246
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294483; cv=none; b=LGxv4+KYq3RfnYthMZT12+/EgHnFkX7GXmeDp8+yCrUU0vCHcjZBz5Qxcg7uBPGMmAMDUHwIrahXubWzMVM5KSa6OVzG+ISX8h0/dO01Hn2+p1nXTLlG4+P5DmkfLECPOEuESifs5MSuXiFdSNg+VbiHcm3KqEAOycz3MNtkdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294483; c=relaxed/simple;
	bh=3QvAJWGv1gPQ3eJSGXr06KRvz10xtfAcuAZOZKEKQMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFQ7uRTzQetstc7AkYSc11zjgzI4BqNFpBI9Lo0KRDWcw1OxrfJajYA/jfawGLhkJgVtQm524+UqnkR86x2XBi1GttPQurDqULkC6leMLjILePhWmGimW9iTaXoo7a63ou3MsXApBXjs7t270Lt0Z6eloARCEAk7lM5uxpb1+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=gZJHO4D0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iscf8s9u; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA0301400031;
	Sun,  7 Sep 2025 21:21:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 07 Sep 2025 21:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294480; x=
	1757380880; bh=H7DOpTJkIKamZnnlkDD1SFk3tG3wPCtz+PxOLCk1rJA=; b=g
	ZJHO4D0taD6mqOFuMbyNxqUv3ayiE4OGADR1Zl79iNhuahUTtiFSn2pgX5O5+C10
	WVubXjw02/hbyh3kZihjTnqH9Jz800bpAOHyoseoM30U1ylIAI26LNnADfSCYGkh
	ece6k/pZRXkOktfexQZWXuMFDr3Etm+KXS5Tk7IBWZXSnkv/H//AjdPkzECfQ1Hf
	5mJDkHJObzA4KM32JrbA/DN9eR2g12+LM2F170MhSjwmY3e3zsiWavJi/8XaW/T0
	yOAfElZx4Vp6BFE3bCJUDpbOi910sgzBqLSfoMmKO/9aAULeV43QrORa4tCE66xf
	qu6UsjTN6qWX8XCJc752A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294480; x=1757380880; bh=H
	7DOpTJkIKamZnnlkDD1SFk3tG3wPCtz+PxOLCk1rJA=; b=Iscf8s9ugpTeE2bIo
	Mr+nk6pxOKJF+PshEI92Til+A5+QvU7R2t8eOQQnNp5z3GNTjXJizfpUPI+BNOBc
	vZnLdzQrXu47toE4X3b+hiLsKCYDBAfgAttZeIM7ut7RCQGBKV9OzE+5Wt5DKZMZ
	sVWPFMOoJzwAm641M4C7doggo2FiwaZbXkQyRx1Suqgd7hbBcjRkt4ywN3y9+uDQ
	0ulTG6t72FHFPC0eS6hLXNyllDK+Ynqp61lJT8Sg27Y1YvMHmnrKIBt4aCvIX7h3
	JjxoZy0s9GPDDbjA6vMFI3sFw2nC2pvesDm3h7IMewBhFhgkh0W+WYn8h998NrCK
	s3oIw==
X-ME-Sender: <xms:kC--aNudcNueJvJQ3lZkptwGmdoKoQmDBGBvcYQCv2_eDbWcyMnrBA>
    <xme:kC--aPZ1cPbOHMvPIEVU26nYNjSrAa3Ea6wlKBnEu0k_a2-d7wNPxaNn6NVKhqnsq
    L5eHTciAdDq8IMr1jo>
X-ME-Received: <xmr:kC--aCspPahR5kIwNC7zcdGImEGPWdIBbMoMj4LuFR_uVDlZ0u0NeEk7hYBrVEW6lQaw1MsPyrn-5tshj0oAf0IzkTNoDVM1Nm0M9mKcQ-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejuedvgf
    duudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kC--aBHcP65zhaAFLALZjAeHR6Qh1Y2_YsPb1ib1leeuzIpgca35AQ>
    <xmx:kC--aNzwZeDor2aqyF0q1cuVCZ6obFK6BR45s2abmuJkhctKYRNNTA>
    <xmx:kC--aAg-Gym3NZNiXnVEyeAZk6qIu61lP_9yILCul_XGxwu54B3IBA>
    <xmx:kC--aAwdfwKwu6RQnbh1VLNvasykuU4g6OKg3QCz40i2HnyTzpkMAQ>
    <xmx:kC--aCRK_8Zs3MtUY-M7pCc5YMi5ttth149UcA8gi5-_SycUP4OcfSPl>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:19 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] firewire: core: use cleanup function in bm_work
Date: Mon,  8 Sep 2025 10:21:02 +0900
Message-ID: <20250908012108.514698-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
References: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "bm_work" function, the references to fw_card and fw_node are
released at last. This is achieved by using goto statements. For this
case, the kernel cleanup framework is available.

This commit uses the framework to remove these statements.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 4a4210cda571..5bd89ddf5018 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -280,14 +280,17 @@ void fw_schedule_bm_work(struct fw_card *card, unsigned long delay)
 		fw_card_put(card);
 }
 
+DEFINE_FREE(node_unref, struct fw_node *, if (_T) fw_node_put(_T))
+DEFINE_FREE(card_unref, struct fw_card *, if (_T) fw_card_put(_T))
+
 static void bm_work(struct work_struct *work)
 {
 	static const char gap_count_table[] = {
 		63, 5, 7, 8, 10, 13, 16, 18, 21, 24, 26, 29, 32, 35, 37, 40
 	};
-	struct fw_card *card = from_work(card, work, bm_work.work);
+	struct fw_card *card __free(card_unref) = from_work(card, work, bm_work.work);
 	struct fw_device *root_device, *irm_device;
-	struct fw_node *root_node;
+	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, bm_id, local_id;
 	int gap_count, generation, grace, rcode;
 	bool do_reset = false;
@@ -297,11 +300,13 @@ static void bm_work(struct work_struct *work)
 	bool keep_this_irm;
 	__be32 transaction_data[2];
 
+	lockdep_assert_held(&card->lock);
+
 	spin_lock_irq(&card->lock);
 
 	if (card->local_node == NULL) {
 		spin_unlock_irq(&card->lock);
-		goto out_put_card;
+		return;
 	}
 
 	generation = card->generation;
@@ -366,9 +371,9 @@ static void bm_work(struct work_struct *work)
 				CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID,
 				transaction_data, 8);
 
+		// Another bus reset, BM work has been rescheduled.
 		if (rcode == RCODE_GENERATION)
-			/* Another bus reset, BM work has been rescheduled. */
-			goto out;
+			return;
 
 		bm_id = be32_to_cpu(transaction_data[0]);
 
@@ -382,8 +387,7 @@ static void bm_work(struct work_struct *work)
 			/* Somebody else is BM.  Only act as IRM. */
 			if (local_id == irm_id)
 				allocate_broadcast_channel(card, generation);
-
-			goto out;
+			return;
 		}
 
 		if (rcode == RCODE_SEND_ERROR) {
@@ -393,7 +397,7 @@ static void bm_work(struct work_struct *work)
 			 * that the problem has gone away by then.
 			 */
 			fw_schedule_bm_work(card, DIV_ROUND_UP(HZ, 8));
-			goto out;
+			return;
 		}
 
 		spin_lock_irq(&card->lock);
@@ -417,7 +421,7 @@ static void bm_work(struct work_struct *work)
 		 */
 		spin_unlock_irq(&card->lock);
 		fw_schedule_bm_work(card, DIV_ROUND_UP(HZ, 8));
-		goto out;
+		return;
 	}
 
 	/*
@@ -455,7 +459,7 @@ static void bm_work(struct work_struct *work)
 		 * and let's try again once that's done.
 		 */
 		spin_unlock_irq(&card->lock);
-		goto out;
+		return;
 	} else if (root_device_is_cmc) {
 		/*
 		 * We will send out a force root packet for this
@@ -512,7 +516,7 @@ static void bm_work(struct work_struct *work)
 		 */
 		reset_bus(card, card->gap_count != 0);
 		/* Will allocate broadcast channel after the reset. */
-		goto out;
+		return;
 	}
 
 	if (root_device_is_cmc) {
@@ -525,16 +529,11 @@ static void bm_work(struct work_struct *work)
 				CSR_REGISTER_BASE + CSR_STATE_SET,
 				transaction_data, 4);
 		if (rcode == RCODE_GENERATION)
-			goto out;
+			return;
 	}
 
 	if (local_id == irm_id)
 		allocate_broadcast_channel(card, generation);
-
- out:
-	fw_node_put(root_node);
- out_put_card:
-	fw_card_put(card);
 }
 
 void fw_card_initialize(struct fw_card *card,
-- 
2.48.1


