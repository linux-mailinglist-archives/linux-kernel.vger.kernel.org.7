Return-Path: <linux-kernel+bounces-830530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D31B99E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3592A7AD9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F778306B12;
	Wed, 24 Sep 2025 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AgJ44/lN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5YS8ZOy"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D0F302CAA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717741; cv=none; b=dqr37dH/vCugcOwwCLkmv8MVowBgEfIOgBBCzSJLb77EoQkaNlIGDmyJ6aZlqKx4AP34k/4HLUh64GZH8c5b55vzQYtA+emV+x9FxahhSZegSo9whQ4cSKAXEfU9IxFx7gjRImEVb1A4Wwky4ritDiCDtjdbT5fNv/SzlBkqRt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717741; c=relaxed/simple;
	bh=2dLPJQsAZ06T7HQwEZ5nIr10frY3csj5jrZWxA5UH5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5fTdqaLWYdG3mTR6nzH/zNoMBgfMIVN+XgZOdCJLG4gu2q7zrpukchKJbSRF34uN9B3aQEWd/qsofDGgQae0I8rhIvk0X87oMHCfPBW/TXx4kaqEYnCsMkaW2oNCnZW2yicytJLkuUtBC/VjRyyBB98HQQ4Wea3WUfG83juk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AgJ44/lN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5YS8ZOy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 932CEEC00C5;
	Wed, 24 Sep 2025 08:42:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 24 Sep 2025 08:42:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758717738; x=
	1758804138; bh=YZTE+1HoIfy758ZocvG1+0WaCqinIXSMBBaXpX5YQGs=; b=A
	gJ44/lNxqEoTfG7Q427T97GekBFqFmkRhZYz7tGIOOJdb3N3fFg6R08UGF7gT0eB
	Wtp6OdUA2/SKfXUgPDhnPm6Q+iSjTWvzL5PRTNfBXvpDcflt9cvCRhHBydNpwXog
	gtRMKV5ZdLkTToysgzW99J1TJoKXYjEhyX1if42KVWInfEVQ0n+YeBfbYBJIEkRC
	13HrKB3Isn+q+seoyCWWFA4WFnFJbzAowwCnzi6kv1UPuK995Dz0QpN7zAzt6KBQ
	ZfORzmbrDORAJrgRbu48AXhhMFBB5PdVhRJ8+S96bkKc6v9JwzPdJxdIGzncZ0pl
	10uylcnHX1IGyfCt9lA+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758717738; x=1758804138; bh=Y
	ZTE+1HoIfy758ZocvG1+0WaCqinIXSMBBaXpX5YQGs=; b=Y5YS8ZOyLfisl9D7N
	rtupkpOEOfR/opLOikqAs3QrQvDh+iS8b4HxIOlIhVFxRvGtb2ktdEXaLkphZEP0
	uEIuvEBc7lkmoYA4bx3tB9cLQktHOT/GqRtoItY2/ZcLFfttYH1xskfVj8iDhb/Q
	pFQJHBRzyYJ8qAyiavtCPmcc5hE9iKaZtAhqsZsmkqoon/6AikxGkZRhL76sRz4C
	3UBzWvxChoQMB+3MDw5O5gKcwso6069euliXnalnzjt/aD8PqG2ESTpush8/GcOQ
	iN76D5sgVzHpc37pONWpvh8XBRdknupHyOADBw7+K3wSB9HfI4w8V5ErvfmoA8iy
	OsMsQ==
X-ME-Sender: <xms:KufTaGvLn4dayuvXzJgosSlTyBUjBnFgCOZafscyrGSpTzL6qq16Zg>
    <xme:KufTaJYHSsgPiho4IJZ6-ZkpevCPWxjyfUkvriKLuz1FAQSGU3LWINCbGkEDwo57m
    tppZh0k_ycUE75MQwzIWNFAL_vt27F4uyotI_9iD8D4CI6oQ5U8KiCA>
X-ME-Received: <xmr:KufTaJV8ZMZjj7bziULZwi7NkJk3SArqRC-Ukw4zGuaDA0pJH0-nUR_xzT7q-1ggeq_G2L7sgapWJlba6kecYmcy5XsB4dTXBNFiugsoXZJw8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeeigecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:KufTaN7Uqm08PI-45FvV3bjFmeppT7v1zuKTcAj0RFrRIprfci729w>
    <xmx:KufTaEjJOMmCvXF8Z7_30vtvOjphNh56q018bBeTkSymqOEXr44w7A>
    <xmx:KufTaEdbNmKcDsKUva4tEdr_UfLKZ1ruwnhBrfBj3uEZHuTz7D4ocw>
    <xmx:KufTaJevGJO0cfRiaTjs_vfMi3O6AX53pHUGpr6hcYO7F5m8y1LRDQ>
    <xmx:KufTaKBFeIConiydQ0QjDH28zP4h6hvpB2pbQdRRRyUOppJK115bWTBp>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 08:42:17 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "firewire: core: disable bus management work temporarily during updating topology"
Date: Wed, 24 Sep 2025 21:42:12 +0900
Message-ID: <20250924124212.231080-3-o-takashi@sakamocchi.jp>
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


