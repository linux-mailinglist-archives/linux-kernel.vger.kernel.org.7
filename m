Return-Path: <linux-kernel+bounces-830529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E1BB99EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D211B262D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52FD3064A4;
	Wed, 24 Sep 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RoxrR8PD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaMvDc+5"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB9C1F3BBB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717740; cv=none; b=CUfZBFjfu+LfDeLpN9qA+pC9FyjNtW4TVKqRidhpQWujXXXnsbau6zeVQo8OzYTKjuAlPszHQ6R0K8E4ACTw7T4QZmTwpK8zlgPq72DhctA7kDC/TNrFAsoREhAd8u9MuvGSzy7txMHkunnJIyBy4URRT++VRLPIybttH+ysHrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717740; c=relaxed/simple;
	bh=mqsGxS9Bc5rOalsZsBWArfAMRPvcdsFugBeK+zvT0U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNGB/d3EqfDe5inyhLnu9766Hyu+++IYCZZxZvQ3J+DdP5AF1N/L/4WBH0zDzJ7p2rBlOZ1BFeU2Aj6wg0Inl+0ro6oRP5q8z3W/ODOaaUUWvwpJzSTKIw8M2C97qMHLtzh8HQrKkwPtBoHt5iQEApwwck3/OXdFft8ay08ce34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RoxrR8PD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaMvDc+5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 58A4CEC00D1;
	Wed, 24 Sep 2025 08:42:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 08:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758717737; x=
	1758804137; bh=tJZJL2f/Wgzff+5H3R1DLPBavYXVUM/ckHpNqpwJYA8=; b=R
	oxrR8PDaSB83rmiB7GdcNA+Jpj5WOY3TvtPgwqVxBCWq96bajLIEKiNdldVSNKBe
	7pDhoibSnyUNNnvszJHK6hUPENbl/CW02RO2UDGiGzKdU4XIhY5++z12yVTGkAam
	F08fDanDAxcn16GygYXIB2Ex4GYOnXAdCKtVrO2hb1DXMQqTp6myso0yqdMjfhtF
	MksxVEAryvwwGtNSGHE935p3godPzCmPs/ZPnp9aTT4Kd6mHCCgg9OJQL7TjMMx/
	hV5iQAiQkEX4Krn/y5YDxOPIY1e+ImROQ1dGsPqpIr64JBmUGYy4Plk2NQaLL4Tq
	HBThXRJuQxizHbC+XhKhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758717737; x=1758804137; bh=t
	JZJL2f/Wgzff+5H3R1DLPBavYXVUM/ckHpNqpwJYA8=; b=HaMvDc+5R5bpxN4R1
	TRVAzfH6c8OGcAeD9dBv2TcdTnzQhLKr0br3tRC4IuN1rEjwefcn8+WC1SX87pX2
	h1cXd5DprMFOXXeBkKUyFreUdVNDWlGtsQnKN/R8/eAz0zNDHqnx/a+cDj8dXLSu
	PpFzOKIeUcBQ5ilF1deURrqNGrR3Wo6B3tq6jjJ0N8VbATzW80IFrg0YQrBgbVJv
	D8vtkmtupQfJJeieR67pU4Ow1yg7CtOym1caZTj0V+PTa/5Kc4RUngLzyP9FQb6B
	gOMLibN35fsFdL4kkIe92Dhr9kgEIK3Li0hSI3v6SyN7MC/HZrmu/wzxrhB+tHXP
	C70/w==
X-ME-Sender: <xms:KefTaFWhfu0v60FXBw83P8nqjX2hg0r3287Eok_lJX9JjZBvhrvxhw>
    <xme:KefTaDhYE3y0Lr_Jg1Oo--yWHKG29NjUL_JO3EYXV33hoflARVbG32H8096pa5B3O
    v2mTcEOANTgWRtVIz1H9k-PJnXKCKsqHw9AYBLvdJatasgMLSIKg2bC>
X-ME-Received: <xmr:KefTaI9d5QKm0IkGwy2yWEwqVCHOZYdQX8SJpUPG3HaakI9ktuwIVT6KDQDkYgFX6NMvwOQXjPq4rw2mla0yjG8PawY1eXXZRLjsSGATV-ny2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeigecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KefTaFA7Iy0w-bxPnPFEsa-zSHfhYiWeNpBwLitJ5fdZq51cHX6SEQ>
    <xmx:KefTaNLTnshhcc_X8wVQ9CptHqbLAbuYAMtfjowYaCfyJS2wR5lXHw>
    <xmx:KefTaAnUWDEcAfMJnnJ_nB02nMbId2oIrPrdmdHknKImaQjzHZe5kA>
    <xmx:KefTaDFmHEzhZfL1FuASUuw2jYUI48mBvVFQ2cbSI2eo0b57Razc_g>
    <xmx:KefTaFqOWEj2ShjMA6Ryit4bvt_EeK3V5UwtgskKu1bT-n4w6D7bnFIf>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 08:42:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Revert "firewire: core: shrink critical section of fw_card spinlock in bm_work"
Date: Wed, 24 Sep 2025 21:42:11 +0900
Message-ID: <20250924124212.231080-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924124212.231080-1-o-takashi@sakamocchi.jp>
References: <20250924124212.231080-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 582310376d6e9a8d261b682178713cdc4b251af6.

The bus manager work has the race condition against fw_destroy_nodes()
called by fw_core_remove_card(). The acquisition of spin lock of fw_card
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


