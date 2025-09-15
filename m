Return-Path: <linux-kernel+bounces-817917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFB7B58892
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74061AA86A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C902DF6FA;
	Mon, 15 Sep 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RlJMaXh8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JIRyxcBF"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34822DCF62
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980079; cv=none; b=XDTtqBbX2K0o9s3LEH6HG9pKwBLFPqgHB5NJyZA6dHW3H+cpbMBNxMrtnhy1qR+fIRW4YH7hFW8UEELgVAMJubIcTmK3LFXPaL0cvDzMoq0F2PM5ljTjjcw5j9JUfE0FgAlG6Wyjkjnv+2B0+Z4fMvys5gCx5ONstJFfhIHxsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980079; c=relaxed/simple;
	bh=K0UcjUZYEl+Kv8ubuBGOj04ZWNBPfcbzKPW+heC6t40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=opAAwky6xk9mWqI7LxjzLjEp+pEqQrO2YuaD/5R5gSy9KdyCnA2GrAPvkhNDL0oZjxcBrDupBU36wgm6dahmkBeHoqqz+wWiYrM7wLm2EHXqHHFtexBpU8N7Asd+w2DldV2FEgI1GrozxugaTW5PHOmaz8/J1Tv5/VQBCn4S9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RlJMaXh8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JIRyxcBF; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BC8F1D001C9;
	Mon, 15 Sep 2025 19:47:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 15 Sep 2025 19:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757980075; x=
	1758066475; bh=Dol20McAHmsGe7jZI4Cf8OSI5NXIOjVDQY+keMjSiAg=; b=R
	lJMaXh86BW7g0l/TLxN/QBxVVUrOHTFGOfLoS0qWY8sEeizOatGqeyYtwOPEWaFc
	ecCQ5AnIKpi/e5d58mEg2bUlVh8CICRnQapCKkmkKGi/6tmunjwYiFh7RfjgMMlR
	hr6uyr+f76Dzj+HcTANFbUBUxHXXtuRCpVF0+/kuMI5ueGG7vNtGO0SJ9Vpan8TT
	7ksxPzx/D1KjRcGLQu6PvsM61QuaOMQWEZPWox3hHeEPjWktfu8LibsRig0NxsZ+
	MUt6gECzf0+Mq0EFCVxfFbKY5CAimvXeqBhmA1g2hj0G1HLAcM53BgdWqfdH/NTp
	M1cZV7OLWkuL6F7598nsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757980075; x=1758066475; bh=D
	ol20McAHmsGe7jZI4Cf8OSI5NXIOjVDQY+keMjSiAg=; b=JIRyxcBFkpKooUjeH
	wYAS52CJbcSVp8H0INJzI6vYSvNzXDgkjtSfDqxll7IOSirdVpuMwhsByMHroD4p
	OyACMyXUNeGMovbyTs0kTQVxbZX058L22WXbpKyqOdHgAeF3SFoVHvxsUmYh6iYy
	dX0Nc5JlMnc1RWjzCj3tM+0TzVu6O48VcZ/sFmlJ7VTOvcMMy3mQvOfaQJazTR7X
	P92ILkB5p0a4xri8xVOkZl4o5rBUmAQAadCU0cyhMz4LQaSSOVxiT53deQ+R9odL
	1fpxpi+L1uCyKP4e+xHd/GJT6Zh4jYB2/Yo4+N2ljuO84TUuerYjg5qqZE15NZ0F
	LnCKQ==
X-ME-Sender: <xms:q6XIaOZns_v1vxALG_Bqtzq7i2ofFwc8IQYDtxdnEpzUx-ojPS-BXg>
    <xme:q6XIaKVeioCs54SAdqI0NrmbKBJk1dxR-yJuhV_1IQKsyb33AGAja-Bw0M8xkhM66
    nQH1u8WZeG_UJshuzo>
X-ME-Received: <xmr:q6XIaK51pv9b_zGUtCd5n0Kxvnim8t48S7BuinAIwYy9UfC9qSh2Dt0SAlFAxbJDW4ILHkIf3wrvfMQNAwIFRHcXZZt2sfo0WFEqhfrhgQzkxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledthecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:q6XIaNghl6M5lNf0RSCCVit3O69Tflzpw4Q1TZFXmezPlMMmLJ95eg>
    <xmx:q6XIaJdws6RMLyInWSJJVSM5nVIvJproxRJ_ghb66kuM3NOZdCIQ3Q>
    <xmx:q6XIaKeiQEk_Abwra1-CrIk6EgN67n94fh1Gu-xGmrI4hjvQj0df_g>
    <xmx:q6XIaL_OZe8xj2HT6k1kF9awO_FS3KbaP6pLnDS-l6Pf1Te_VDUpEw>
    <xmx:q6XIaMfCJAnrlknp1S6DQHBpmYqeHJlnMiGWWYHXhTmxJJztjc665S0F>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:47:54 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] firewire: core: use spin lock specific to topology map
Date: Tue, 16 Sep 2025 08:47:44 +0900
Message-ID: <20250915234747.915922-4-o-takashi@sakamocchi.jp>
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

At present, the operation for read transaction to topology map register is
not protected by any kind of lock primitives. This causes a potential
problem to result in the mixed content of topology map.

This commit adds and uses spin lock specific to topology map.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c    | 22 ++++++++++++++--------
 drivers/firewire/core-transaction.c |  6 +++++-
 include/linux/firewire.h            |  6 +++++-
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 17aaf14cab0b..c62cf93f3f65 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -435,20 +435,22 @@ static void update_tree(struct fw_card *card, struct fw_node *root)
 	}
 }
 
-static void update_topology_map(struct fw_card *card,
-				u32 *self_ids, int self_id_count)
+static void update_topology_map(__be32 *buffer, size_t buffer_size, int root_node_id,
+				const u32 *self_ids, int self_id_count)
 {
-	int node_count = (card->root_node->node_id & 0x3f) + 1;
-	__be32 *map = card->topology_map;
+	__be32 *map = buffer;
+	int node_count = (root_node_id & 0x3f) + 1;
+
+	memset(map, 0, buffer_size);
 
 	*map++ = cpu_to_be32((self_id_count + 2) << 16);
-	*map++ = cpu_to_be32(be32_to_cpu(card->topology_map[1]) + 1);
+	*map++ = cpu_to_be32(be32_to_cpu(buffer[1]) + 1);
 	*map++ = cpu_to_be32((node_count << 16) | self_id_count);
 
 	while (self_id_count--)
 		*map++ = cpu_to_be32p(self_ids++);
 
-	fw_compute_block_crc(card->topology_map);
+	fw_compute_block_crc(buffer);
 }
 
 void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
@@ -479,8 +481,6 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 
 		local_node = build_tree(card, self_ids, self_id_count, generation);
 
-		update_topology_map(card, self_ids, self_id_count);
-
 		card->color++;
 
 		if (local_node == NULL) {
@@ -493,5 +493,11 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 			update_tree(card, local_node);
 		}
 	}
+
+	// Just used by transaction layer.
+	scoped_guard(spinlock, &card->topology_map.lock) {
+		update_topology_map(card->topology_map.buffer, sizeof(card->topology_map.buffer),
+				    card->root_node->node_id, self_ids, self_id_count);
+	}
 }
 EXPORT_SYMBOL(fw_core_handle_bus_reset);
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 623e1d9bd107..8edffafd21c1 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -1196,7 +1196,11 @@ static void handle_topology_map(struct fw_card *card, struct fw_request *request
 	}
 
 	start = (offset - topology_map_region.start) / 4;
-	memcpy(payload, &card->topology_map[start], length);
+
+	// NOTE: This can be without irqsave when we can guarantee that fw_send_request() for local
+	// destination never runs in any type of IRQ context.
+	scoped_guard(spinlock_irqsave, &card->topology_map.lock)
+		memcpy(payload, &card->topology_map.buffer[start], length);
 
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index f3260aacf730..aeb71c39e57e 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -129,7 +129,11 @@ struct fw_card {
 
 	bool broadcast_channel_allocated;
 	u32 broadcast_channel;
-	__be32 topology_map[(CSR_TOPOLOGY_MAP_END - CSR_TOPOLOGY_MAP) / 4];
+
+	struct {
+		__be32 buffer[(CSR_TOPOLOGY_MAP_END - CSR_TOPOLOGY_MAP) / 4];
+		spinlock_t lock;
+	} topology_map;
 
 	__be32 maint_utility_register;
 
-- 
2.48.1


