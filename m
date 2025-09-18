Return-Path: <linux-kernel+bounces-823781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624D3B876F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5CB3AA5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AC2F25E8;
	Thu, 18 Sep 2025 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RcRmmUk1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0wzDAh3"
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF82D0C63
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239699; cv=none; b=UyyfK0F9uoUIUJHNodu9Iqdhx+s6J2v6CeDHaS1kOkuIQKFWQ5QvU71O67SJIBhK32YE/1NwLirgaoMxwwrAYvCcRN/ol18/4Lqvb1rkFn66CrkVnjoqb/Yy00o8q6qDi/RxKBVc8JZohZdHDXodrkBuCOy5+C+bV5UpxOBiu58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239699; c=relaxed/simple;
	bh=/PhBDFPm5QIB03v215EWrLH/3rZfVE+oUVn1KB+R0sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4+v5V9qXWNySK3wKbMpFK8i8aTQwikjtQfXOtArkMJD0wJwEozGBwEadDGoyGM4oWV0Y4aPW7dvGBirLgfkoj4G4sC3kKbr36qoGJtONEmTP6uvOc4748yl6BtNCRFG9RwY3C5xM5D6Ddr/qAf2XdOI7MslWpDJ575ZO+3nML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RcRmmUk1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0wzDAh3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6B067A02F7;
	Thu, 18 Sep 2025 19:54:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 18 Sep 2025 19:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758239696; x=
	1758326096; bh=01wtiLF2Oli5HjGiFiR6KWpbzIl+tdOyk62gIR53vS4=; b=R
	cRmmUk1NuF7IrfD5v6j8/246XNoCqqwL41T+QLulC9i1aUGqWEu4ccNXYDX/GGCK
	w/DBMRbIUEGxukdsG1ToVzj9waVwjbL9ckvFNVmAdKW/Vp5R9X12xiXJNruuDc5Y
	QvymhNIZxojaGAtiQAcnAAogxWh5tx+54i3fZUV8KoYL2JclqSFbNncqsuJs4C70
	pl67l3UT24KyI7cWjkKKdRgOPMAysNtINBTko50bAyJLz8UGTvewfrIpGa8db/rZ
	wz4/3dvzRGNPwq06oiO2FWWcCMuoIgvXAZtfjLjjZ4yElrcW2xz4yCpriG9TxFMG
	9JacFbZxrQ3qDeRdHMX9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758239696; x=1758326096; bh=0
	1wtiLF2Oli5HjGiFiR6KWpbzIl+tdOyk62gIR53vS4=; b=g0wzDAh3A9VkA8f+N
	85gIllPmXsLACl/xceihPqAAKxeieqpFTFfXLZ1qArQrxrRtyA0tzqvBglRxfeb9
	40R313Yq+OBe41J5MQOO213+nCBu96jpNbcS4uYX2LFfl1lXnHPuXRjGfdw1f9KN
	FV8KbOogAMmazSvfhfraWWd6TGnKCcTGWOHHnVLBW5lZx96dc6guGTEmuflQkx3b
	hYAqcpYhr46t1Khpk7csA8attkPUJR1V8q3aFN4e5qfDCsp2TGvEKc/ahBSXaaAf
	8dPYX63WLQ20gIRbmXLnw7ANvow9VJ0mlf9z9V5VXBgvTt69KwbCgOlp9JHKS2od
	WYeSw==
X-ME-Sender: <xms:0JvMaKy4CXf95Yud5ojW9u7v84jDxbxlhmfNLYS3z31tLZT__xzFiA>
    <xme:0JvMaPOmZLtdbywDsqxpbIVkGWN-Urw6wtSYjWT9EwRYGjU8wru4f0GSejGPM4CjJ
    Jhjjsa7iVjo7_mjwUQ>
X-ME-Received: <xmr:0JvMaORSdXdduBqssrYWxYZdT-MgUq1DMie1qKXnDLc9wsYJcoAPGTsjru9rClVeL6mD7vGfrzOLxtu0m8yFM-0Eh5dKNMgafTOs6r7y54fGJGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:0JvMaNbVMUN6PunV6iMUMG2I9e6KmIRQlbcAfQfVJX3BamME6i0ldQ>
    <xmx:0JvMaL1HcMl6PP_e4LG2fl-XD5CK5zqrQUcZRL8UAkhNoSQcQNRPmQ>
    <xmx:0JvMaNVh_OEc-Wz7jRO7GAYBKYVs6TGoWxYxnQbaOs7DtkxZbFgi7A>
    <xmx:0JvMaFWJgceEjEqY7NzpecFossIthog8mz-Wmeyxukzh64tIfQNijg>
    <xmx:0JvMaD062b27Dc1rX_31x_D-xVvoIB0-7idOUdFxvnczdLC69GpoXGC3>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 19:54:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] firewire: core: code refactoring for the case of generation mismatch
Date: Fri, 19 Sep 2025 08:54:45 +0900
Message-ID: <20250918235448.129705-4-o-takashi@sakamocchi.jp>
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


