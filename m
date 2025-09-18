Return-Path: <linux-kernel+bounces-823727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772AB87546
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75D4172C79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F64306B0C;
	Thu, 18 Sep 2025 23:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Bwo9qiLZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A2G+or9t"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C32EB868
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236951; cv=none; b=UAQ/+DD6mc3HtS1e0r1cN0x6vKAgqNqNmdqMMfdjILbHrZd+A1hTD4cScdkQW0zndb8tzeTr+I5N6onXVBbZLXcFmNjCmWUryIr2wck8FtuC14q2EZkpKRGELavOKxOdSnBr9aogKoA+/iAje9HjE3kpsonE9mF2dDnlhiHMUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236951; c=relaxed/simple;
	bh=/PhBDFPm5QIB03v215EWrLH/3rZfVE+oUVn1KB+R0sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnazEBNB/E3zKATxRa+qb07wVowBYtc35+BlP0X0bdq+JrQxTZMwKc9IvGm885uxWyP5OEp442s0rAKrhjByhYdK+jfYdUYzb9zZdhPJm/vBvU880J+mNmmH2xWFq8blIuK5nDrOoqexdbo0BBGsI5jFLdWpkBGpitiR2RMYXck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Bwo9qiLZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A2G+or9t; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BB68D1D002E9;
	Thu, 18 Sep 2025 19:09:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 18 Sep 2025 19:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758236947; x=
	1758323347; bh=01wtiLF2Oli5HjGiFiR6KWpbzIl+tdOyk62gIR53vS4=; b=B
	wo9qiLZZxzkylcwlDeAwXThVQ5LG63aWr7wUZ0jxrduKmkEb6ngf4vDrEcsMAPEP
	7S1jL4e6Hn4iYhPnT5CVQ0UTeiDRd+hHrfiP/LSwFAu2bj3PG+jISch0mTkpQ+N9
	IluVw5PFJsj0ATIoWxV8Nw13F6w/kPzhNaLk5ZUyBhtvb6Ie3KJXoOQMihHG/jFu
	4MlCRb6ExbyLK5FL71BVdC5id/rTMfyDu/G1xOlIUwjv7C8rgtFI+aw5BHa4th8U
	cBafgbatA9xNqJq+XMXgnYL9+O5jgx9VnW4lKRhKI1RDDVPNiP5pdBen/9Ns5hsJ
	giKfqfFZwtAagQZRQrblQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758236947; x=1758323347; bh=0
	1wtiLF2Oli5HjGiFiR6KWpbzIl+tdOyk62gIR53vS4=; b=A2G+or9tX+Xmw+aDg
	VtA9OceD5DHW/IQMqENax8fFsVdFNlr584nBJjwVLkEftNfQYYJ+PS2Q84DRNsr5
	1Iox9RHVJas5fq1mHj6wGxq39hryAvOAd+X7xOQxPzUclNmYaW5kGcRccv9HvFrD
	i5C8yGaFqvGXz48AarEJXFyk7DGoyqWvzErP7CPzJqeVGqQNQ2vPtwawUXXPhvs4
	o3N5OFawsx5mWSZ7UymXK4+tqtIiwM3Pcpdm6A+7OHy9va0Jw58etUMsZdSb/ADI
	g//Wp6x0zvG5MA4JtGdea9sisXRx2+ywO+ZnrRnwRJK+I4ik3M89LpuJfPfLPYTU
	Kj+7w==
X-ME-Sender: <xms:E5HMaPLEv0abmARZ5DEeDr39toLOl5BHY2-sU1dPkT_TiKEOvE6lrg>
    <xme:E5HMaMHEdr-zhpaVjtuICb4_4XpMiJqUoUwX30oMTpjJrHuDFZPi7lF9T3LqmpMBD
    LFJdIqwi0zPJwlfw4k>
X-ME-Received: <xmr:E5HMaJoX25fHEE7uvHCs7JTbfS1WGCaPGITmGSmCKKz4KeylMjG52d64UHhbRfFZV-6eSHGK5d5Eyz6IzHoH2ehr1mAEURciPgUjN4zCmhKgCGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:E5HMaFQbCqmWed_tsBWrX0Rs8Y3mk9ugBFN0SQjNmX-Vps7ZPDcUwg>
    <xmx:E5HMaGMSHck1S-V1BA9rjzXoYAF0M7xP0JpktzBxM34MWuZh8F2eag>
    <xmx:E5HMaIPOp8GLqjL_SFLPv4yUFKjaSUWl6YScC37HLNXtyAHJuUsb8Q>
    <xmx:E5HMaGsjixsk92cJ_vzi_wcQai8dX1BelTGq1YvM9K9Q0xGi9i0KzA>
    <xmx:E5HMaDPpDqtGthjV9w0SS6vC-Nig7E8sLqGpPi6jIB31eWX4T9TpD6v7>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:09:06 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] firewire: core: code refactoring for the case of generation mismatch
Date: Fri, 19 Sep 2025 08:08:54 +0900
Message-ID: <20250918230857.127400-4-o-takashi@sakamocchi.jp>
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

Current implementation stores the bus generation at which the bus manager
contending procedure finishes. The condition for the procedure is the
mismatch of the stored generation against current bus generation.

This commit refactors the code for the contending procedure. Two existing
branches are put into a new branch to detect the generation mismatch, thus
the most of change is indentation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 188 +++++++++++++++++------------------
 1 file changed, 93 insertions(+), 95 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index e9bf8d93f5b7..02058af705cc 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -290,7 +290,7 @@ static void bm_work(struct work_struct *work)
 	struct fw_card *card __free(card_unref) = from_work(card, work, bm_work.work);
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, local_id;
-	int expected_gap_count, generation, grace;
+	int expected_gap_count, generation;
 	bool do_reset = false;
 
 	if (card->local_node == NULL)
@@ -304,107 +304,107 @@ static void bm_work(struct work_struct *work)
 	irm_id   = card->irm_node->node_id;
 	local_id = card->local_node->node_id;
 
-	grace = time_is_before_jiffies64(card->reset_jiffies + msecs_to_jiffies(125));
-
-	if ((is_next_generation(generation, card->bm_generation) &&
-	     !card->bm_abdicate) ||
-	    (card->bm_generation != generation && grace)) {
-		/*
-		 * This first step is to figure out who is IRM and
-		 * then try to become bus manager.  If the IRM is not
-		 * well defined (e.g. does not have an active link
-		 * layer or does not responds to our lock request, we
-		 * will have to do a little vigilante bus management.
-		 * In that case, we do a goto into the gap count logic
-		 * so that when we do the reset, we still optimize the
-		 * gap count.  That could well save a reset in the
-		 * next generation.
-		 */
-		__be32 data[2] = {
-			cpu_to_be32(BUS_MANAGER_ID_NOT_REGISTERED),
-			cpu_to_be32(local_id),
-		};
-		struct fw_device *irm_device = fw_node_get_device(card->irm_node);
-		bool irm_is_1394_1995_only = false;
-		bool keep_this_irm = false;
-		int rcode;
-
-		if (!card->irm_node->link_on) {
-			new_root_id = local_id;
-			fw_notice(card, "%s, making local node (%02x) root\n",
-				  "IRM has link off", new_root_id);
-			goto pick_me;
-		}
-
-		if (irm_device && irm_device->config_rom) {
-			irm_is_1394_1995_only = (irm_device->config_rom[2] & 0x000000f0) == 0;
-
-			// Canon MV5i works unreliably if it is not root node.
-			keep_this_irm = irm_device->config_rom[3] >> 8 == CANON_OUI;
-		}
+	if (card->bm_generation != generation) {
+		bool grace = time_is_before_jiffies64(card->reset_jiffies + msecs_to_jiffies(125));
+
+		if (grace ||
+		    (is_next_generation(generation, card->bm_generation) && !card->bm_abdicate)) {
+			// This first step is to figure out who is IRM and
+			// then try to become bus manager.  If the IRM is not
+			// well defined (e.g. does not have an active link
+			// layer or does not responds to our lock request, we
+			// will have to do a little vigilante bus management.
+			// In that case, we do a goto into the gap count logic
+			// so that when we do the reset, we still optimize the
+			// gap count.  That could well save a reset in the
+			// next generation.
+			__be32 data[2] = {
+				cpu_to_be32(BUS_MANAGER_ID_NOT_REGISTERED),
+				cpu_to_be32(local_id),
+			};
+			struct fw_device *irm_device = fw_node_get_device(card->irm_node);
+			bool irm_is_1394_1995_only = false;
+			bool keep_this_irm = false;
+			int rcode;
+
+			if (!card->irm_node->link_on) {
+				new_root_id = local_id;
+				fw_notice(card, "%s, making local node (%02x) root\n",
+					  "IRM has link off", new_root_id);
+				goto pick_me;
+			}
 
-		if (irm_is_1394_1995_only && !keep_this_irm) {
-			new_root_id = local_id;
-			fw_notice(card, "%s, making local node (%02x) root\n",
-				  "IRM is not 1394a compliant", new_root_id);
-			goto pick_me;
-		}
+			if (irm_device && irm_device->config_rom) {
+				irm_is_1394_1995_only = (irm_device->config_rom[2] & 0x000000f0) == 0;
 
-		rcode = fw_run_transaction(card, TCODE_LOCK_COMPARE_SWAP,
-				irm_id, generation, SCODE_100,
-				CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID,
-				data, sizeof(data));
+				// Canon MV5i works unreliably if it is not root node.
+				keep_this_irm = irm_device->config_rom[3] >> 8 == CANON_OUI;
+			}
 
-		switch (rcode) {
-		case RCODE_GENERATION:
-			// Another bus reset, BM work has been rescheduled.
-			return;
-		case RCODE_SEND_ERROR:
-			// We have been unable to send the lock request due to
-			// some local problem.  Let's try again later and hope
-			// that the problem has gone away by then.
-			fw_schedule_bm_work(card, msecs_to_jiffies(125));
-			return;
-		case RCODE_COMPLETE:
-		{
-			int bm_id = be32_to_cpu(data[0]);
-
-			// Used by cdev layer for "struct fw_cdev_event_bus_reset".
-			scoped_guard(spinlock, &card->lock) {
-				if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
-					card->bm_node_id = 0xffc0 & bm_id;
-				else
-					card->bm_node_id = local_id;
+			if (irm_is_1394_1995_only && !keep_this_irm) {
+				new_root_id = local_id;
+				fw_notice(card, "%s, making local node (%02x) root\n",
+					  "IRM is not 1394a compliant", new_root_id);
+				goto pick_me;
 			}
 
-			if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED) {
-				// Somebody else is BM.  Only act as IRM.
-				if (local_id == irm_id)
-					allocate_broadcast_channel(card, generation);
+			rcode = fw_run_transaction(card, TCODE_LOCK_COMPARE_SWAP,
+					irm_id, generation, SCODE_100,
+					CSR_REGISTER_BASE + CSR_BUS_MANAGER_ID,
+					data, sizeof(data));
+
+			switch (rcode) {
+			case RCODE_GENERATION:
+				// Another bus reset, BM work has been rescheduled.
 				return;
+			case RCODE_SEND_ERROR:
+				// We have been unable to send the lock request due to
+				// some local problem.  Let's try again later and hope
+				// that the problem has gone away by then.
+				fw_schedule_bm_work(card, msecs_to_jiffies(125));
+				return;
+			case RCODE_COMPLETE:
+			{
+				int bm_id = be32_to_cpu(data[0]);
+
+				// Used by cdev layer for "struct fw_cdev_event_bus_reset".
+				scoped_guard(spinlock, &card->lock) {
+					if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
+						card->bm_node_id = 0xffc0 & bm_id;
+					else
+						card->bm_node_id = local_id;
+				}
+
+				if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED) {
+					// Somebody else is BM.  Only act as IRM.
+					if (local_id == irm_id)
+						allocate_broadcast_channel(card, generation);
+					return;
+				}
+				break;
 			}
-			break;
-		}
-		default:
-			if (!keep_this_irm) {
-				// The lock request failed, maybe the IRM
-				// isn't really IRM capable after all. Let's
-				// do a bus reset and pick the local node as
-				// root, and thus, IRM.
-				new_root_id = local_id;
-				fw_notice(card, "BM lock failed (%s), making local node (%02x) root\n",
-					  fw_rcode_string(rcode), new_root_id);
-				goto pick_me;
+			default:
+				if (!keep_this_irm) {
+					// The lock request failed, maybe the IRM
+					// isn't really IRM capable after all. Let's
+					// do a bus reset and pick the local node as
+					// root, and thus, IRM.
+					new_root_id = local_id;
+					fw_notice(card, "BM lock failed (%s), making local node (%02x) root\n",
+						  fw_rcode_string(rcode), new_root_id);
+					goto pick_me;
+				}
+				break;
 			}
-			break;
+
+			// A node contends for bus manager in this generation.
+			card->bm_generation = generation;
+		} else {
+			// We weren't BM in the last generation, and the last
+			// bus reset is less than 125ms ago.  Reschedule this job.
+			fw_schedule_bm_work(card, msecs_to_jiffies(125));
+			return;
 		}
-	} else if (card->bm_generation != generation) {
-		/*
-		 * We weren't BM in the last generation, and the last
-		 * bus reset is less than 125ms ago.  Reschedule this job.
-		 */
-		fw_schedule_bm_work(card, msecs_to_jiffies(125));
-		return;
 	}
 
 	/*
@@ -412,8 +412,6 @@ static void bm_work(struct work_struct *work)
 	 * make sure we have an active cycle master and do gap count
 	 * optimization.
 	 */
-	card->bm_generation = generation;
-
 	if (card->gap_count == GAP_COUNT_MISMATCHED) {
 		/*
 		 * If self IDs have inconsistent gap counts, do a
-- 
2.48.1


