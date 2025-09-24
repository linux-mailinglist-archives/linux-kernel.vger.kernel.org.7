Return-Path: <linux-kernel+bounces-830571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D36B9A00F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4878D3A6BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336FA303CB2;
	Wed, 24 Sep 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GBi2dQtW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mb9kwKPl"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DD2E613C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719912; cv=none; b=otWRhWnzY/F3DaBXuOPIeEi41rQ1KQhGE9TFHIakKH2kRXRZKOdI5ERUNmxfFok0d6jfNFCbeD/hYq4tC2dzHBgW7TfFEtR1Le0j7iUb1NbeELWA82Q61gJ6xxe2CbMUKAZ4vNV0XkauC281Hvf4sP6XStACnAqB1B9HS/2FPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719912; c=relaxed/simple;
	bh=olmXmDBxtLIFnmU2LjzKk7iKer4QA63qtGIrHhE3rpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOGbwgiVJLwR7jr1b8oO7IYLo8rdXE3O3gV6luQpIhzwGXSfbVrZFWZRCu3JGefOHh+XTEnV9KCcUcZN5NUHCU4B4zXmDOjvzfmG+UBdP82bEhN3ezeD3ETFd0Fb4VQlZS5JqFiBBgwnWLN0L8PHb4Ar+uPAtDlFOXi+ZFtVZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GBi2dQtW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mb9kwKPl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B057EC018E;
	Wed, 24 Sep 2025 09:18:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 09:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758719908; x=
	1758806308; bh=yztnsZNz/Ql9CaSufGVYpt4NZipaq0Pnwdmnfv9ujsM=; b=G
	Bi2dQtWdwuAP9x1fmcj4ISgUIj+7jaM+yDl92s0OKXyZrSWTZ0NchodA+T+pUO2k
	gpAFaUmmpJ0l9sFULVeikt3+3AJsch19X6BnivBpy1AUP9Zo/prDvtJ8Sj7yP4p7
	I2Fw7v0xAgFOVHlDzk+iCdQxmjXzDthokiBQcLzaPV0YZOKufa+Jgywa7iv5/6x0
	nYTUVNxyvQwgpII3NOZLd6u4+wu9JU5dqAreqiHMhcYtsS8VOIfk3rnie/01U3PJ
	uIuOcquFWgk511xIg83bUZEVDyv56dIJlYT7KZGUNe4FpmoZ4uh2sdowvilSzVaq
	puZa5ESmOO8aoMFVeDIGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758719908; x=1758806308; bh=y
	ztnsZNz/Ql9CaSufGVYpt4NZipaq0Pnwdmnfv9ujsM=; b=mb9kwKPlht1HIuZ6g
	VIXXxf2leaIMfW/vZvWlW8KjHoGnhcl5Nkq1OKc2Tt28lhbBqQMvhPR9+v+Vz+cD
	+roZpe/8KrxMQ9Z1Zc4DLvuIwSvBrcoWbMwXxLbYrUYG8mYZBRSszmYlnS/nS+Jp
	uTRxK5R2sEfGz45AE2cPPEqg67gtdVRWWkaZd+7ZYzDogaCzi0PyXgy0vqwqUDo7
	uaYoAramyD8pqI/n7JeDVJxtBlIlmKK15fWyhdgjzT8+Zq7KZzJkEG+/mfDyXMYu
	hVatCLk78r23jRN3K7mXuA0OmhiLMn+Zpzja36RskJFDUm5a1iGobDNRpVxuSjDW
	MfBAw==
X-ME-Sender: <xms:pO_TaJ3FvgU6bfRvAzU-2IdQAx3U5ENNXGa-uI3A-T68UD28aOaFKg>
    <xme:pO_TaOB6W1L9pPuxwmRFYPUpTwXVWafbdXzhFsHiA5kGt9oYdTMqeFV36zqW4j9Io
    LEey3yd2Kt7WBf79WXcr93a5JgN-swjC4GgufAUErGAoP2Of2s9bIM>
X-ME-Received: <xmr:pO_TaBcPn7FNTIdJAGyKG5M89DxjZF7wC8aKAtcEfBzkQbiMkxvA_2wGcSLQgMvxAVIQU9fiNcyB10wIsMs-feoVZSnDa6gA3DB6JeRiV4xb2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeejudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pO_TaDgCFAEzIM0tN8aE9f8rIoOo1GIBPNUmMOis9cGJVWzKQDO-nA>
    <xmx:pO_TaJr0t-Y6n_gI-HFiRpKenExTQSNpONf3UDg74aA463CS0fMguw>
    <xmx:pO_TaDF53z0zJo393X_0XTmolp1daFF8YzMujwvq-qeRvwNDdlk2eg>
    <xmx:pO_TaDmosorclzh9qoc9CrbKjIRkx0dlq4hOivevToKdpIBc4PWYMA>
    <xmx:pO_TaOKaX_dfJH6WXkn3Ts7tD4r9q1BmF9M3xJ-S3NNP6Bnxl2__rLyB>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 09:18:27 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] Revert "firewire: core: shrink critical section of fw_card spinlock in bm_work"
Date: Wed, 24 Sep 2025 22:18:22 +0900
Message-ID: <20250924131823.262136-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924131823.262136-1-o-takashi@sakamocchi.jp>
References: <20250924131823.262136-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 582310376d6e9a8d261b682178713cdc4b251af6.

The bus manager work has the race condition against fw_destroy_nodes()
called by fw_core_remove_card(). The acquition of spin lock of fw_card
is left as is again.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 38 ++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 4a5459696093..e5e0174a0335 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -299,6 +299,7 @@ enum bm_contention_outcome {
 };
 
 static enum bm_contention_outcome contend_for_bm(struct fw_card *card)
+__must_hold(&card->lock)
 {
 	int generation = card->generation;
 	int local_id = card->local_node->node_id;
@@ -311,8 +312,11 @@ static enum bm_contention_outcome contend_for_bm(struct fw_card *card)
 	bool keep_this_irm = false;
 	struct fw_node *irm_node;
 	struct fw_device *irm_device;
+	int irm_node_id;
 	int rcode;
 
+	lockdep_assert_held(&card->lock);
+
 	if (!grace) {
 		if (!is_next_generation(generation, card->bm_generation) || card->bm_abdicate)
 			return BM_CONTENTION_OUTCOME_WITHIN_WINDOW;
@@ -338,10 +342,16 @@ static enum bm_contention_outcome contend_for_bm(struct fw_card *card)
 		return BM_CONTENTION_OUTCOME_IRM_COMPLIES_1394_1995_ONLY;
 	}
 
-	rcode = fw_run_transaction(card, TCODE_LOCK_COMPARE_SWAP, irm_node->node_id, generation,
+	irm_node_id = irm_node->node_id;
+
+	spin_unlock_irq(&card->lock);
+
+	rcode = fw_run_transaction(card, TCODE_LOCK_COMPARE_SWAP, irm_node_id, generation,
 				   SCODE_100, CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID, data,
 				   sizeof(data));
 
+	spin_lock_irq(&card->lock);
+
 	switch (rcode) {
 	case RCODE_GENERATION:
 		return BM_CONTENTION_OUTCOME_AT_NEW_GENERATION;
@@ -352,12 +362,10 @@ static enum bm_contention_outcome contend_for_bm(struct fw_card *card)
 		int bm_id = be32_to_cpu(data[0]);
 
 		// Used by cdev layer for "struct fw_cdev_event_bus_reset".
-		scoped_guard(spinlock, &card->lock) {
-			if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
-				card->bm_node_id = 0xffc0 & bm_id;
-			else
-				card->bm_node_id = local_id;
-		}
+		if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
+			card->bm_node_id = 0xffc0 & bm_id;
+		else
+			card->bm_node_id = local_id;
 
 		if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
 			return BM_CONTENTION_OUTCOME_IRM_HOLDS_ANOTHER_NODE_AS_BM;
@@ -389,8 +397,12 @@ static void bm_work(struct work_struct *work)
 	int expected_gap_count, generation;
 	bool stand_for_root = false;
 
-	if (card->local_node == NULL)
+	spin_lock_irq(&card->lock);
+
+	if (card->local_node == NULL) {
+		spin_unlock_irq(&card->lock);
 		return;
+	}
 
 	generation = card->generation;
 
@@ -405,6 +417,7 @@ static void bm_work(struct work_struct *work)
 
 		switch (result) {
 		case BM_CONTENTION_OUTCOME_WITHIN_WINDOW:
+			spin_unlock_irq(&card->lock);
 			fw_schedule_bm_work(card, msecs_to_jiffies(125));
 			return;
 		case BM_CONTENTION_OUTCOME_IRM_HAS_LINK_OFF:
@@ -415,10 +428,12 @@ static void bm_work(struct work_struct *work)
 			break;
 		case BM_CONTENTION_OUTCOME_AT_NEW_GENERATION:
 			// BM work has been rescheduled.
+			spin_unlock_irq(&card->lock);
 			return;
 		case BM_CONTENTION_OUTCOME_LOCAL_PROBLEM_AT_TRANSACTION:
 			// Let's try again later and hope that the local problem has gone away by
 			// then.
+			spin_unlock_irq(&card->lock);
 			fw_schedule_bm_work(card, msecs_to_jiffies(125));
 			return;
 		case BM_CONTENTION_OUTCOME_IRM_IS_NOT_CAPABLE_FOR_IRM:
@@ -428,7 +443,9 @@ static void bm_work(struct work_struct *work)
 		case BM_CONTENTION_OUTCOME_IRM_HOLDS_ANOTHER_NODE_AS_BM:
 			if (local_id == irm_id) {
 				// Only acts as IRM.
+				spin_unlock_irq(&card->lock);
 				allocate_broadcast_channel(card, generation);
+				spin_lock_irq(&card->lock);
 			}
 			fallthrough;
 		case BM_CONTENTION_OUTCOME_IRM_HOLDS_LOCAL_NODE_AS_BM:
@@ -469,6 +486,7 @@ static void bm_work(struct work_struct *work)
 				if (!root_device_is_running) {
 					// If we haven't probed this device yet, bail out now
 					// and let's try again once that's done.
+					spin_unlock_irq(&card->lock);
 					return;
 				} else if (!root_device->cmc) {
 					// Current root has an active link layer and we
@@ -504,6 +522,8 @@ static void bm_work(struct work_struct *work)
 	if (card->bm_retries++ < 5 && (card->gap_count != expected_gap_count || new_root_id != root_id)) {
 		int card_gap_count = card->gap_count;
 
+		spin_unlock_irq(&card->lock);
+
 		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
 			  new_root_id, expected_gap_count);
 		fw_send_phy_config(card, new_root_id, generation, expected_gap_count);
@@ -524,6 +544,8 @@ static void bm_work(struct work_struct *work)
 	} else {
 		struct fw_device *root_device = fw_node_get_device(root_node);
 
+		spin_unlock_irq(&card->lock);
+
 		if (root_device && root_device->cmc) {
 			// Make sure that the cycle master sends cycle start packets.
 			__be32 data = cpu_to_be32(CSR_STATE_BIT_CMSTR);
-- 
2.48.1


