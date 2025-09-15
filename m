Return-Path: <linux-kernel+bounces-817915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B22B5888F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40051AA8618
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747402DEA98;
	Mon, 15 Sep 2025 23:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Y13EsDhw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2/z/z+P"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A521A420
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980076; cv=none; b=MDVh5zDrrUCini83trE90CaMzUl6NqrkjUTcXjzWTcErm9DoexYeaUbf9uVM3xGtrzgjgSDOCLjJPZ/N2DOCjtU5PSkKwHFumgo42iMD3CbzAkFjKaQKtmB2ht47VbYOC2v1KxsTEBOdEPQiKm2bS2XlHV+huCTutUNmPx9hLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980076; c=relaxed/simple;
	bh=YMLVPxZRJjHSwpacs4Y/4zxs9XOK0x8s3Jy3zIPcHAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ4GGnADHBuHmb29Kic2MbFvqgqponP8L3fsxGRxBvFqKkWdC5SXDx/LoAqEV38wz56qCA6zd6b6Oo2+vQYd4qBIwv8h/9HP66jRyh+P61+c54DyceoiuaGF797mtO/11QQruGerxShyN/Q5tljK4DqX/P6ujJxzqDViN0Aelxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Y13EsDhw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k2/z/z+P; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DF3FD1D001C2;
	Mon, 15 Sep 2025 19:47:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 15 Sep 2025 19:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757980072; x=
	1758066472; bh=TVLAZiE8S6oLCOMyBp6Z+AOI4tSEx9bMWEKSAF910Rk=; b=Y
	13EsDhwWYzR3WvMUFORzFdbSUpAFPTq38GWvryOV0e3ULJuPshh8fZnUzUnZaA95
	CQDGz+A9YmsoELOLhLNi5W0QYzSx03lK4ijM+C6BerTbLfFDgnSwoGGcRjw0pv5o
	wA6iDgFsZd1lAxoIAn7Pauc04iGoXM2PNi5jnm4+liI7LF6W86qGpVE9iaIJrnh7
	euyY05AO83R0Wk2F5pmHCFRjK6SQpvxonUd+w9oUGVBIVoBItGR8kzof4PRPOShR
	touc8bt48VVY7pu22qyKLMB2L8IExB/NNroIDUJEEqzuzEVCkYwRAwWzPlH6KTJM
	Nm6BWPL78l9CNTdPGITOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757980072; x=1758066472; bh=T
	VLAZiE8S6oLCOMyBp6Z+AOI4tSEx9bMWEKSAF910Rk=; b=k2/z/z+PhPie740iq
	U1dk0p9DF/ztMps4i5q24wuTqDhLBzOTZ4CFimP79zbvsltJJxCnWEBzNTYIs69s
	VamGpUqHmL0zDiTNF0xEqVnzuslT7wKsT33V5JOtvxtqK9XscSC3U6e6z/yMUvdr
	ZOsBQBYOTotRFPfLaSuAlCsQwCRiDsQtsQKYXRdYRtOtjFdlwsMv32tgOREDjQCB
	x6MYbp4GlQE5Q+eikt6tXqEgZ74JYFglhskGKVcGOhNCT2z3UpudoDk+tDL4kp/o
	xWQ7icPaeJNuvnRFcLht3tA/Bzs23J3KO166KBov0u0GY7/7dgh7IS4WiTKrpFR5
	uzHYA==
X-ME-Sender: <xms:qKXIaHcI4AuFCR0w96bB9F8TgnQIn445HAeEp_GDkgnY5sqACxxPFw>
    <xme:qKXIaGICeT9uMp60r0EPtuCPbhCDz0ujZP4nmuTQvs2Uq23jsG3vOfJOlrsNuYExG
    2J9vEgcoGOXbPyrKXs>
X-ME-Received: <xmr:qKXIaCf7mYowNCfpjBqejQnl3cXQLxP31aFcwdn-wXcVIIG6T7BK8YbavfpgADcUBzyCdFAJVlQnLeRCEXgbJDaKgyYrBsF4DLUEz4gHaAFlxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledtgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:qKXIaF2svZBnz2GzxtBXo7yyWPlHYLb1sV_keVJboZkXeCRSa88x1A>
    <xmx:qKXIaDjpK0eYMxnFZFnk2NRv97gpFFQ7YMcAZjbmGHlZoN5Ab6HF4A>
    <xmx:qKXIaDSlWIXpe34Hu3SpukZAKfM89iIJggLm5QTLUCjwxxRS_zMSvA>
    <xmx:qKXIaMiS5belhL3x3pivEEwcI_wrIE23EDHmk57RHmZsVM13VAyoIg>
    <xmx:qKXIaKA2zsVjPj01D63RFcKRG-L4gUFPBPsgWOQ5UTIIZEmAng115WUi>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:47:51 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] firewire: core: use scoped_guard() to manage critical section to update topology
Date: Tue, 16 Sep 2025 08:47:42 +0900
Message-ID: <20250915234747.915922-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915234747.915922-1-o-takashi@sakamocchi.jp>
References: <20250915234747.915922-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At present, guard() macro is used for the critical section to update
topology. It is inconvenient to add the other critical sections into
the function.

This commit uses scoped_guard() macro instead.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 74 +++++++++++++++-----------------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 5f8fb1201d80..17aaf14cab0b 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -458,46 +458,40 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 
 	trace_bus_reset_handle(card->index, generation, node_id, bm_abdicate, self_ids, self_id_count);
 
-	guard(spinlock_irqsave)(&card->lock);
-
-	/*
-	 * If the selfID buffer is not the immediate successor of the
-	 * previously processed one, we cannot reliably compare the
-	 * old and new topologies.
-	 */
-	if (!is_next_generation(generation, card->generation) &&
-	    card->local_node != NULL) {
-		fw_destroy_nodes(card);
-		card->bm_retries = 0;
-	}
-
-	card->broadcast_channel_allocated = card->broadcast_channel_auto_allocated;
-	card->node_id = node_id;
-	/*
-	 * Update node_id before generation to prevent anybody from using
-	 * a stale node_id together with a current generation.
-	 */
-	smp_wmb();
-	card->generation = generation;
-	card->reset_jiffies = get_jiffies_64();
-	card->bm_node_id  = 0xffff;
-	card->bm_abdicate = bm_abdicate;
-	fw_schedule_bm_work(card, 0);
-
-	local_node = build_tree(card, self_ids, self_id_count, generation);
-
-	update_topology_map(card, self_ids, self_id_count);
-
-	card->color++;
-
-	if (local_node == NULL) {
-		fw_err(card, "topology build failed\n");
-		/* FIXME: We need to issue a bus reset in this case. */
-	} else if (card->local_node == NULL) {
-		card->local_node = local_node;
-		for_each_fw_node(card, local_node, report_found_node);
-	} else {
-		update_tree(card, local_node);
+	scoped_guard(spinlock, &card->lock) {
+		// If the selfID buffer is not the immediate successor of the
+		// previously processed one, we cannot reliably compare the
+		// old and new topologies.
+		if (!is_next_generation(generation, card->generation) && card->local_node != NULL) {
+			fw_destroy_nodes(card);
+			card->bm_retries = 0;
+		}
+		card->broadcast_channel_allocated = card->broadcast_channel_auto_allocated;
+		card->node_id = node_id;
+		// Update node_id before generation to prevent anybody from using
+		// a stale node_id together with a current generation.
+		smp_wmb();
+		card->generation = generation;
+		card->reset_jiffies = get_jiffies_64();
+		card->bm_node_id  = 0xffff;
+		card->bm_abdicate = bm_abdicate;
+		fw_schedule_bm_work(card, 0);
+
+		local_node = build_tree(card, self_ids, self_id_count, generation);
+
+		update_topology_map(card, self_ids, self_id_count);
+
+		card->color++;
+
+		if (local_node == NULL) {
+			fw_err(card, "topology build failed\n");
+			// FIXME: We need to issue a bus reset in this case.
+		} else if (card->local_node == NULL) {
+			card->local_node = local_node;
+			for_each_fw_node(card, local_node, report_found_node);
+		} else {
+			update_tree(card, local_node);
+		}
 	}
 }
 EXPORT_SYMBOL(fw_core_handle_bus_reset);
-- 
2.48.1


