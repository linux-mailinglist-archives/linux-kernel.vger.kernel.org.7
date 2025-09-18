Return-Path: <linux-kernel+bounces-823729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F2B8754C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FC81B22806
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E37313559;
	Thu, 18 Sep 2025 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="TY/JoQQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgMW4giY"
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499A301712
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236953; cv=none; b=EcHoIrUkb9oBgaiofVzH4dJJNSh036LbgFr5Vmxz9p/oknYg6F/PbEP9MecOD7Rz0gYxeBW0BrQRa7mP3FkI3O0jB6GqKjqVisAwBiUyKqMJF/Tkwhu4ouZYwSw/973TYxeIxc1kI5BmJbbX3JMvn80mtI4/DMmsBwTeHuGMKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236953; c=relaxed/simple;
	bh=wXuzmBeHQCbrEXrGHzKM5GsfOsCiIEOjthhJzG1Jgt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppbHoE+Lk1QUr/DaeWZAaI594eyZHuAQEoUyJDhmOpi180nzDqUC+pVFWr0RIS1PPKpr89D/E1uf36qJww4ZlzkUil0LApIcthumFrAODk+kulRW7Ktht4nSIkLXJQQhrdzQOZoYfmiSrIXBYgRfgOISiQKZnQC/UVHgZDEhvCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=TY/JoQQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cgMW4giY; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5A707A02B2;
	Thu, 18 Sep 2025 19:09:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 19:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758236950; x=
	1758323350; bh=VYxaUYksUwdGiqYdR3vXLvnRMCgLcjZN4Q57x7wxBzY=; b=T
	Y/JoQQGcFnCYNJoDErIzH3XZbTaX2nw2A5b/at251+xv6LLYgxBKlTxIpmY1xULG
	j8j36eZsOGBG5DCtNTTZhWxNYfv2EzWmLx6bm8V7IwwH+KcRrPMSLuVf0hTxzVdb
	Rm91+WM8IvoQXJE2bu6emraaNfgly2cO1lpRPCMV+gkfY/eCuQ4bGjct9P5YQofc
	bx+989fldwacmRBMXRnmw44hkRH4fAwr93mSkvLKrGHsujJ1+RNriBysX3RgIkv4
	h2wt1Hq2BqjKBnW8Ouix+6bEXp1xQiaOI0zeAjbse/iRWzcy60tArq5RdtKs6l4F
	xTPgiK6TcUpG4M+pIVLfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758236950; x=1758323350; bh=V
	YxaUYksUwdGiqYdR3vXLvnRMCgLcjZN4Q57x7wxBzY=; b=cgMW4giYZEStddj63
	sq2m3l0Xx2rZOEKqzF5poXuFk8EaEUDRCXFh6v/Uyn50ia4FTKlpjs/qqr/WxgU7
	3TnSOrHDyouQDDjEivKwt8PGjM8dn7aAxvpxutWHIui/fj/Z0SQddXKf59WqiO7x
	HIBXNYOb0Ukj3L7rUHXkxw1JhLKtZLzNtMjCN+AIoRDvZ1tU4U/NDHTJavqqmuWQ
	pEyAVqhp7Id1ziWCB5hzOrW5nhNJ1BjXkEdMvCtHVvh1+6mFvbj4NCaMtjN/qsj+
	EQyWJVRPNMm98xCVyxUdE8Z6InOfF6t+HpfTWFPpiYTZMXNAhdD3ALs6Tsqe9U54
	0TNRA==
X-ME-Sender: <xms:FpHMaGbb5HBOf15hSyL2pJ3E81MXbQx1XFbSQqXQEdcF2qdL0L6YQQ>
    <xme:FpHMaCWMXU4moSOWDMX1HPaAlmLW4fcmLyYtyO1QAofcpK7dOxIbdoD5qpeNfgJuZ
    Iy05OmMFgNP6W4tWaE>
X-ME-Received: <xmr:FpHMaC7VcU_bptRslCzYZGAP5gbdNkSsmoUVRxZPjZ_T-GVU6e5C56EE38185NmCKc0wx6UwQIxeJd6D8uCsBCxoyRbz16IIvf-toB73BYbRUK4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejuedvgf
    duudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FpHMaFjL-15xFrcuoFg-S0MQs-BN4hLZvBiv2cJHkdtFCyev220sIw>
    <xmx:FpHMaBec2CC-VPOBquib0Vp2Gml6nIe5TPqz7TkYZ0gLXpGarZYdnw>
    <xmx:FpHMaCcoKaSa75trga1EA4wdI7sn5vw1O9evEH_zjzsWhI4_-2347Q>
    <xmx:FpHMaD-mV56Qd1_uPW8Hdl6vEOUdAbNeI7zVpV7bKuBrw-189rdCdw>
    <xmx:FpHMaEdyv8f8GATrZ6iAPJhevReYevzeld9mzmLITleTIN483Y5ZB8Xu>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:09:09 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] firewire: core; eliminate pick_me goto label
Date: Fri, 19 Sep 2025 08:08:56 +0900
Message-ID: <20250918230857.127400-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
References: <20250918230857.127400-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit uses condition statements instead of pick_me goto label.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 102 ++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 50 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 6268b595d4fa..b766ce5fdea4 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -388,6 +388,7 @@ static void bm_work(struct work_struct *work)
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation;
 	bool do_reset = false;
+	bool stand_for_root;
 
 	if (card->local_node == NULL)
 		return;
@@ -408,11 +409,11 @@ static void bm_work(struct work_struct *work)
 			fw_schedule_bm_work(card, msecs_to_jiffies(125));
 			return;
 		case BM_CONTENTION_OUTCOME_IRM_HAS_LINK_OFF:
-			new_root_id = local_id;
-			goto pick_me;
+			stand_for_root = true;
+			break;
 		case BM_CONTENTION_OUTCOME_IRM_COMPLIES_1394_1995_ONLY:
-			new_root_id = local_id;
-			goto pick_me;
+			stand_for_root = true;
+			break;
 		case BM_CONTENTION_OUTCOME_AT_NEW_GENERATION:
 			// BM work has been rescheduled.
 			return;
@@ -423,8 +424,8 @@ static void bm_work(struct work_struct *work)
 			return;
 		case BM_CONTENTION_OUTCOME_IRM_IS_NOT_CAPABLE_FOR_IRM:
 			// Let's do a bus reset and pick the local node as root, and thus, IRM.
-			new_root_id = local_id;
-			goto pick_me;
+			stand_for_root = true;
+			break;
 		case BM_CONTENTION_OUTCOME_IRM_HOLDS_ANOTHER_NODE_AS_BM:
 			if (local_id == irm_id) {
 				// Only acts as IRM.
@@ -434,60 +435,61 @@ static void bm_work(struct work_struct *work)
 		case BM_CONTENTION_OUTCOME_IRM_HOLDS_LOCAL_NODE_AS_BM:
 		default:
 			card->bm_generation = generation;
+			stand_for_root = false;
 			break;
 		}
 	}
 
-	/*
-	 * We're bus manager for this generation, so next step is to
-	 * make sure we have an active cycle master and do gap count
-	 * optimization.
-	 */
-	if (card->gap_count == GAP_COUNT_MISMATCHED) {
-		/*
-		 * If self IDs have inconsistent gap counts, do a
-		 * bus reset ASAP. The config rom read might never
-		 * complete, so don't wait for it. However, still
-		 * send a PHY configuration packet prior to the
-		 * bus reset. The PHY configuration packet might
-		 * fail, but 1394-2008 8.4.5.2 explicitly permits
-		 * it in this case, so it should be safe to try.
-		 */
-		new_root_id = local_id;
-		/*
-		 * We must always send a bus reset if the gap count
-		 * is inconsistent, so bypass the 5-reset limit.
-		 */
-		card->bm_retries = 0;
-	} else {
-		// Now investigate root node.
-		struct fw_device *root_device = fw_node_get_device(root_node);
-
-		if (root_device == NULL) {
-			// Either link_on is false, or we failed to read the
-			// config rom.  In either case, pick another root.
-			new_root_id = local_id;
+	// We're bus manager for this generation, so next step is to make sure we have an active
+	// cycle master and do gap count optimization.
+	if (!stand_for_root) {
+		if (card->gap_count == GAP_COUNT_MISMATCHED) {
+			// If self IDs have inconsistent gap counts, do a
+			// bus reset ASAP. The config rom read might never
+			// complete, so don't wait for it. However, still
+			// send a PHY configuration packet prior to the
+			// bus reset. The PHY configuration packet might
+			// fail, but 1394-2008 8.4.5.2 explicitly permits
+			// it in this case, so it should be safe to try.
+			stand_for_root = true;
+
+			// We must always send a bus reset if the gap count
+			// is inconsistent, so bypass the 5-reset limit.
+			card->bm_retries = 0;
 		} else {
-			bool root_device_is_running =
-				atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
+			// Now investigate root node.
+			struct fw_device *root_device = fw_node_get_device(root_node);
 
-			if (!root_device_is_running) {
-				// If we haven't probed this device yet, bail out now
-				// and let's try again once that's done.
-				return;
-			} else if (root_device->cmc) {
-				// We will send out a force root packet for this
-				// node as part of the gap count optimization.
-				new_root_id = root_id;
+			if (root_device == NULL) {
+				// Either link_on is false, or we failed to read the
+				// config rom.  In either case, pick another root.
+				stand_for_root = true;
 			} else {
-				// Current root has an active link layer and we
-				// successfully read the config rom, but it's not
-				// cycle master capable.
-				new_root_id = local_id;
+				bool root_device_is_running =
+					atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
+
+				if (!root_device_is_running) {
+					// If we haven't probed this device yet, bail out now
+					// and let's try again once that's done.
+					return;
+				} else if (!root_device->cmc) {
+					// Current root has an active link layer and we
+					// successfully read the config rom, but it's not
+					// cycle master capable.
+					stand_for_root = true;
+				}
 			}
 		}
 	}
- pick_me:
+
+	if (stand_for_root) {
+		new_root_id = local_id;
+	} else {
+		// We will send out a force root packet for this node as part of the gap count
+		// optimization on behalf of the node.
+		new_root_id = root_id;
+	}
+
 	/*
 	 * Pick a gap count from 1394a table E-1.  The table doesn't cover
 	 * the typically much larger 1394b beta repeater delays though.
-- 
2.48.1


