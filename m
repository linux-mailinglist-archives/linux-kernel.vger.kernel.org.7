Return-Path: <linux-kernel+bounces-823783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B100DB876F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2563B89DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DC2F6562;
	Thu, 18 Sep 2025 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WCoWV3fS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oCSmXMRa"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63032F2607
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239702; cv=none; b=h0Sa2GhoH+u+QxtzGp4yilEnPHSEkW+rvRuM3iEfKzpeU1DehYbKE4TaD1ioOCfOZH1LLkuB+kT3wZkAND955Kb+tMssGIvZOViVcu+si80I14VIi4J7s21xBIWZXVx+oBJw1b87r/4GKBWQ/cUuMoDmXRoGwDaKbrbrV352awE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239702; c=relaxed/simple;
	bh=AG53UB01dVOFG9V/HAVXW8WT5VX9S3k64bpboHkrOP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov8UVnmlAZEofoZs2KGdABY1hJqwcIRojNusnYiQ8Be0S2zpaMOipQC4JMp1+B2uujCVH6y9HS4LJLIhNcvZ0emggV8F1UxCoBZqyOLNjA7doqJbLkNRYJPSPRoqfyb2fj9UQnavJK2WUxjFnZ+d01CvY0C+9dj+AC4uBBvu7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=WCoWV3fS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oCSmXMRa; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id F36F11D002E3;
	Thu, 18 Sep 2025 19:54:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 18 Sep 2025 19:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239699; x=
	1758326099; bh=KwzQEGG89WT38SZTNrp7a2zR3gJWlAZ5vWCncLkwR5U=; b=W
	CoWV3fShymqkFuvj1wCyOSoVGox9RzVhXbOhcIOz6ffqsbhMs14NPqbOp5Qb5JRp
	fjOR2ULjmTSftspNwKsQOOAwBmpG32cxg0oEamLzN+YKMtQUjP6q0yGvjc5UTV2s
	FqGQXJO8cm67eTe2u5WAOzeUs4hZ/p525AHhMDOlnXJyBtp00xxmNwJgIQtIPQAT
	FKhg0u1fbSDiz4sV6TvaBALZyIE9DPGzciKpZu0peBiuGkUC5IAakb+nnIaRocIV
	dyWH13rRikUucY8rNmcICyue078A5XVcnT0AkSdxQefQFqA2jq9UnDvLzx09FOzh
	RMCbw43lgwVGjE5gHCndQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758239699; x=1758326099; bh=K
	wzQEGG89WT38SZTNrp7a2zR3gJWlAZ5vWCncLkwR5U=; b=oCSmXMRadCOYmXESJ
	fi50+2H1zwYXT+G2kzm/8GkZs9dsLvlRiCArG1LwtMiDjlw/UXg/dBGQpc7w5v60
	Bu3lo55zKMgfB8kwkRNlYMm9kyRHUBs2UnmZ38vTjt49yTe/MuOPRBM2rcTn3O8L
	gH1IbadPOOdhgJ5JvDYGBJP//HtXC6nqgCkRBsY073PEpflZXxkNq68dxIaZdeTm
	+/o7gxWH70EGBcbCOU+X8s8r9tpQbZg5OJt+ldr7ec4PWJNj6d5dytmtbJk/XgcQ
	NN93ucfm03/Zwtw4Jlp00S7D/dNH8WTYcjJIPF9ZDOOBuw/9utXdpaP6BTvGf5CA
	wv9nQ==
X-ME-Sender: <xms:05vMaOzD89A6vcVBEO3lVecJ5KIP7f7VfeFv40h8Ujig1VepGNBxWw>
    <xme:05vMaDPxJikP6z2humCcY7uutwcLu1Fr5YG3rsmjnbuDGuxJDjCH5lBF3HXGqlXL0
    GqxtV_YM0gX1VGTYHU>
X-ME-Received: <xmr:05vMaCRw5LT1IxgrGmAi9FBxVM2cVoC0yzU6vACsBfmP_aesph5QUJcgYpL4K7sw3Qv9rUrYJW6TOL4s9_97PEWkA5T_bDleU3XaUwGpWjt1bBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:05vMaBbKyLZAnrsl2cPWnjeC5IxVJuxWVzivwfBH2C61xAAz-TtbOg>
    <xmx:05vMaP3GJ0svQD34ccmjHwBtGCN-l7IElAa9J0my9PLm7rn_E9ukgg>
    <xmx:05vMaBUQccieqa9Eb2GcdwCPCeCEiObcIrp9MJIn_BSGGlmEsZjgWw>
    <xmx:05vMaJU6vd4bCUkOrwfQN8vNriHQe5qPI7If_2vFA4TRg_DnVsKo6Q>
    <xmx:05vMaH2PArIWI6LULOfDg8fRvDG8VWQ7Ss1_HO58KetPoBSLaM3aJ3SR>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:54:58 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] firewire: core; eliminate pick_me goto label
Date: Fri, 19 Sep 2025 08:54:47 +0900
Message-ID: <20250918235448.129705-6-o-takashi@sakamocchi.jp>
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
 drivers/firewire/core-card.c | 101 ++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 50 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 6268b595d4fa..58d1f58a4a0f 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -388,6 +388,7 @@ static void bm_work(struct work_struct *work)
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation;
 	bool do_reset = false;
+	bool stand_for_root = false;
 
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
@@ -438,56 +439,56 @@ static void bm_work(struct work_struct *work)
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


