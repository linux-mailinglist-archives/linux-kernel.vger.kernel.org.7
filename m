Return-Path: <linux-kernel+bounces-830572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF6B9A012
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04B47A580F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BE2E763A;
	Wed, 24 Sep 2025 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VpdKojZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FU5wBtC4"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7482FFDE4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719912; cv=none; b=SFnRpoFH7ooM/XNMiJzFzWwb+mXnTVbTgkG5LY4tBR9RGU44UmLQqJG/n5i9rdIfBWfhqI31pd8zvk8/bKi0zuweTb4Ns4vOuqcLhzBRvR1dilntGqY4bqfroyvqZEb72r0PVabwFQDR3eIig9UxjmGMwBuzlgJha0JYjPluSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719912; c=relaxed/simple;
	bh=2dLPJQsAZ06T7HQwEZ5nIr10frY3csj5jrZWxA5UH5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tagtdcqIIDHljYz6bMkpOoZItLWj/HDexJCA8InrDkZ0KkafR/llZKmCuDRfZ7Zx95gFFPhnCstUsbDc28iWxEbJU+qE4ZqEGFKhwte1AdJyVBGB7rkAHrbSRTPdJPr3UJfNnaWAqfMy/ikVsJuLSg8r8pmHKaUwFgXZRyxpOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VpdKojZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FU5wBtC4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CC7C9140013C;
	Wed, 24 Sep 2025 09:18:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Sep 2025 09:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758719909; x=
	1758806309; bh=YZTE+1HoIfy758ZocvG1+0WaCqinIXSMBBaXpX5YQGs=; b=V
	pdKojZM5CyqIwc1iAHP7az1rOh3s0Gw91sk7BkBtU8bHP35Jg31h2aFpAwzcSfcR
	3rlmmC1GalJOuyabRN3VDc402PyuoSjW79ugVEvKImfmybKCIJN7xY6tvw5W7N6P
	SW3WZTh/2LEtvwOgjzCEAKJvA09SNb55D32+197AuIzJ785ZDB1ivv77oLsDl991
	MT0/Y6OOD36xyMNehz1lOB+mSXmUWaEqhEWMQnionGde/yINLj0blpxKAyD4C1rI
	aO99TRJanEJcJ+fCqifYHvkb5p9k1FA1IISuVshuFXhKIMy02bso7/rM+wbZeqf7
	9CoO+2nkL/D3neZj3nW5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758719909; x=1758806309; bh=Y
	ZTE+1HoIfy758ZocvG1+0WaCqinIXSMBBaXpX5YQGs=; b=FU5wBtC48d0SlKa0E
	Y+DYx7p7FXxJGnvBFhAu73+RMwXIzR5kRyf4jmHGwSPexFSk7Y8jH8TX5zh8wwzM
	r1fJL4dgIvlMkA/RjUOaWCvXIwzbU7SNCSn1rMewTHNoojunBEvQi8s/e6LKSKZ/
	yiYjw3hNbvP0EfuvHbULfem7LkxHjkXG/xbh84PG+f6XjcBE63GpsSJpW2nnSuOU
	4Ht1KFmEqLlWzLfjPpEK3ReAqO1AODqKF1Uh7yXL7MXbCrE91Ht+hJooed+7BqtR
	7p+VRkU5C2lZobKHPwguEvBbT4VKd0dxOckrWu4fWGelRpOmq8EoQxaiVpcTav+e
	NAY0w==
X-ME-Sender: <xms:pe_TaAIFXfWj7vAyCpZI9gEOjyaINeSHgy99GlnoO0vIOzrLswp9yA>
    <xme:pe_TaOE2zYzTD_T7-duQE0Zv-qa9VhRd74P2N-At2Vk0dyKco0NEGsV5nz2K0dwzA
    ChhjLFt6eegCPp3pr55LmPv6qfplvGTd3UeEqsa-_X1C2CEB6q04-k>
X-ME-Received: <xmr:pe_TaIQB4fEr62Y4gzPKa8f5U0gAWSnMi5JaufcJcp_fuPArFBIg3U1CrdoyRKYXFwS6pntY2eXnz1fMUno-OdwbMziA5XQ-f6TSK8xhSwQCXg>
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
X-ME-Proxy: <xmx:pe_TaKEocp9ceqDFfhIx6huwMZJOZi5uE7P_lmAE_5CC_KTuodlNcQ>
    <xmx:pe_TaE-lHGLGRLgdasipfmVYqpetmN6saLQTSPbpliQK5jJs0b1QvQ>
    <xmx:pe_TaEJUXRuH-THkd3WsICOq8GpaHFK_FGwffBnNj04jGGsb1FaZ2g>
    <xmx:pe_TaHY0xp1vRuQWMfnPTHBqGmSXIyM0oewvj5W_UEqC9q1UxIyGRg>
    <xmx:pe_TaC9ruU7ggltGTnGeScIaSBpf3Y04Hr8DwJYMuwjJTOkCL5ujwRxH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 09:18:28 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] Revert "firewire: core: disable bus management work temporarily during updating topology"
Date: Wed, 24 Sep 2025 22:18:23 +0900
Message-ID: <20250924131823.262136-3-o-takashi@sakamocchi.jp>
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

This reverts commit abe7159125702c734e851bc0c52b51cd446298a5.

The bus manager work item acquires the spin lock of fw_card again, thus
no need to serialize it against fw_core_handle_bus_reset().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-topology.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
index 90b988035a2a..2f73bcd5696f 100644
--- a/drivers/firewire/core-topology.c
+++ b/drivers/firewire/core-topology.c
@@ -460,14 +460,8 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 {
 	struct fw_node *local_node;
 
-	might_sleep();
-
 	trace_bus_reset_handle(card->index, generation, node_id, bm_abdicate, self_ids, self_id_count);
 
-	// Disable bus management work during updating the cache of bus topology, since the work
-	// accesses to some members of fw_card.
-	disable_delayed_work_sync(&card->bm_work);
-
 	scoped_guard(spinlock, &card->lock) {
 		// If the selfID buffer is not the immediate successor of the
 		// previously processed one, we cannot reliably compare the
@@ -501,8 +495,6 @@ void fw_core_handle_bus_reset(struct fw_card *card, int node_id, int generation,
 		}
 	}
 
-	enable_delayed_work(&card->bm_work);
-
 	fw_schedule_bm_work(card, 0);
 
 	// Just used by transaction layer.
-- 
2.48.1


