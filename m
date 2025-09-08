Return-Path: <linux-kernel+bounces-804925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF6B48207
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A3016A55F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040111E990E;
	Mon,  8 Sep 2025 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LUbNN6nY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NrAEHOZG"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD601C3C11
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294482; cv=none; b=YbEBpJwi2QcAtzmXTTx5wYXydVtaTJi315M0SIuY3PA+zoDNhZjJ6EVM3PtNvX95j0rx4MCFtBg2F60QWGaBE4C7dmclmvSqOjM6lGLhaKxwvY9cI32jVbFhXcjntii8szJPYYgqyc1WgLSJJdViSrnZ9Y1ulu3vFSIylaxf45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294482; c=relaxed/simple;
	bh=c4HtsegVi3uw9RorKzEf9C5EDnAVZTi4VD9ITXs7jYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2bv0sgVo+T3mB68Z8Jev+b+TXwR5gKUSaRclprant8Y0jpKMA5lIf52Ua5ZuZjSCEUoRYFdp5su6SNvfRwJatbbR8/U7t/8poo4r3k7FCCbC4vS2dtfD3nNF3CFiJuNUusGE2z9H5udgdBDee5L9HxvX2QojRNBazLKRXd5M00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LUbNN6nY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NrAEHOZG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A0E1EC007B;
	Sun,  7 Sep 2025 21:21:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 07 Sep 2025 21:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294479; x=
	1757380879; bh=VnQqzEe4MIZzE9rsM4hqaAJTPrsvj4NXRFbWU+fyj6g=; b=L
	UbNN6nYXHbf8e8gxRWAsbkmQJhBC1+f/l21su8w4hWVoTfF88WMwgKFxHMiN+ns0
	LXcTq1/oOgR3YEBpZZ8Hquu/+XfL+l26EWV9rKSkOdM3ZZlMcUQvcG90z7B/ES2m
	AxEuFK+pZaVAIE1pL7+U2qGuDnSTQswUe01KbZcj1dWtqpJBVapxA5xh0IZCc5kM
	GNiANm/4ezkVLX7DXlAuqs5ZIlwXYbCd3z3RyISDJTjtmGi39TDoKGSeJQRDeSsn
	suyUgyzBmS6SR9DpWk7RMDvk4S9oQZKW2rzgZ/2gk4yIHdv5vkqR9iphghKkpalM
	p3P4QDb1ECrcrJKNW4mXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294479; x=1757380879; bh=V
	nQqzEe4MIZzE9rsM4hqaAJTPrsvj4NXRFbWU+fyj6g=; b=NrAEHOZGBrACcP2ji
	i/S/QWBzQrlw+Tbb5tlHvGeV4qTmovOSINBFqbo/4h+ubcDhoq/Pw4O9h9KocsGZ
	RqRor/VxLh6No6QOvmI47RO+QioxGeXGvnq9bHpJ6ZDrOI5NXonAi7jvL78S2VPD
	UHMUN65M4TAcBhsdTImCFpzoBuiTRzMDTRvAYczd6mGnGpdegxTr5xw0gzaOjbtd
	H9C81GrzLrCEnV45I3pDgRpMREQpBi+5xidt8cTAfIOHTtr32Y63FtdBHgPBSatx
	RCRzdv2nzLKQBpLO729JmWQZsAPXiK0ZuW2q2vdDOAD+W3OAdma9BX/KHgS4uwLU
	HsIWg==
X-ME-Sender: <xms:jy--aCya6PGMMwKLrbrLGJyQj2eIggqXdcVxtBsJOkYQ6uxaTtEHMA>
    <xme:jy--aHOq4yxWymP1ybzb5VzxC8AgnTfThXoGBMelV4By1ZKueUfHN3aTN5FEcI5NQ
    VbGe7-iMK8q05BvO10>
X-ME-Received: <xmr:jy--aGTQriEd4LweV8uribvlJSVXCnqebFzUuoJFB6oHVKeSj9uGkNRApJLxv6U2ZSOKN6K2EGW8YUB9hwUlQRB_b5EQLP-hnO-PB5kLtd8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:jy--aFZFbRYXy6xFLUcsLKE2QRLO5QoVAF1Nw1Y1ehu-Bo9oYZjt7Q>
    <xmx:jy--aD3B6-lBxCZ3PSMI5q04Ysehz5Sq-6IbhXIXXCy3GM6BR49Sfw>
    <xmx:jy--aFUduKdIX3pqogj-VIyNeH6JeqsbgHMtDSeQvKkmyDH6zqIoNw>
    <xmx:jy--aNVe5XxawolN7UqXJsWY113kVZ1m2VavWkNkXeExLBTDyj0k2w>
    <xmx:jy--aL1H-9PEEO24ySkQGXcCR87MByYgyhKMMWlzoUPpq46zMQxDoxnv>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:18 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] firewire: core: add helper functions to access to fw_device data in fw_node structure
Date: Mon,  8 Sep 2025 10:21:01 +0900
Message-ID: <20250908012108.514698-5-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
References: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data mbmer in fw_node structure is an opaque pointer, while nowadays
it is just used to refer to fw_device associated with the fw_node.

This commit redefines the opaque pointer to a pointer to fw_device
structure, and adds some helper functions to set/get it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c   |  4 ++--
 drivers/firewire/core-device.c | 18 +++++++++---------
 drivers/firewire/core.h        | 14 ++++++++++++--
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 41902dcc10a0..4a4210cda571 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -307,12 +307,12 @@ static void bm_work(struct work_struct *work)
 	generation = card->generation;
 
 	root_node = fw_node_get(card->root_node);
-	root_device = root_node->data;
+	root_device = fw_node_get_device(root_node);
 	root_device_is_running = root_device &&
 			atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
 	root_device_is_cmc = root_device && root_device->cmc;
 
-	irm_device = card->irm_node->data;
+	irm_device = fw_node_get_device(card->irm_node);
 	irm_is_1394_1995_only = irm_device && irm_device->config_rom &&
 			(irm_device->config_rom[2] & 0x000000f0) == 0;
 
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aeacd4cfd694..6a04a0014694 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -887,7 +887,7 @@ static void fw_device_release(struct device *dev)
 	 * bus manager work looks at this node.
 	 */
 	scoped_guard(spinlock_irqsave, &card->lock)
-		device->node->data = NULL;
+		fw_node_set_device(device->node, NULL);
 
 	fw_node_put(device->node);
 	kfree(device->config_rom);
@@ -1007,7 +1007,7 @@ static void fw_device_init(struct work_struct *work)
 	int ret;
 
 	/*
-	 * All failure paths here set node->data to NULL, so that we
+	 * All failure paths here call fw_node_set_device(node, NULL), so that we
 	 * don't try to do device_for_each_child() on a kfree()'d
 	 * device.
 	 */
@@ -1051,9 +1051,9 @@ static void fw_device_init(struct work_struct *work)
 				struct fw_node *obsolete_node = reused->node;
 
 				device->node = obsolete_node;
-				device->node->data = device;
+				fw_node_set_device(device->node, device);
 				reused->node = current_node;
-				reused->node->data = reused;
+				fw_node_set_device(reused->node, reused);
 
 				reused->max_speed = device->max_speed;
 				reused->node_id = current_node->node_id;
@@ -1292,7 +1292,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		 * FW_NODE_UPDATED callbacks can update the node_id
 		 * and generation for the device.
 		 */
-		node->data = device;
+		fw_node_set_device(node, device);
 
 		/*
 		 * Many devices are slow to respond after bus resets,
@@ -1307,7 +1307,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 
 	case FW_NODE_INITIATED_RESET:
 	case FW_NODE_LINK_ON:
-		device = node->data;
+		device = fw_node_get_device(node);
 		if (device == NULL)
 			goto create;
 
@@ -1324,7 +1324,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		break;
 
 	case FW_NODE_UPDATED:
-		device = node->data;
+		device = fw_node_get_device(node);
 		if (device == NULL)
 			break;
 
@@ -1339,7 +1339,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 
 	case FW_NODE_DESTROYED:
 	case FW_NODE_LINK_OFF:
-		if (!node->data)
+		if (!fw_node_get_device(node))
 			break;
 
 		/*
@@ -1354,7 +1354,7 @@ void fw_node_event(struct fw_card *card, struct fw_node *node, int event)
 		 * the device in shutdown state to have that code fail
 		 * to create the device.
 		 */
-		device = node->data;
+		device = fw_node_get_device(node);
 		if (atomic_xchg(&device->state,
 				FW_DEVICE_GONE) == FW_DEVICE_RUNNING) {
 			device->workfn = fw_device_shutdown;
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 9b298af1cac0..083e39034c37 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -194,8 +194,8 @@ struct fw_node {
 	/* For serializing node topology into a list. */
 	struct list_head link;
 
-	/* Upper layer specific data. */
-	void *data;
+	// The device when already associated, else NULL.
+	struct fw_device *device;
 
 	struct fw_node *ports[] __counted_by(port_count);
 };
@@ -219,6 +219,16 @@ static inline void fw_node_put(struct fw_node *node)
 	kref_put(&node->kref, release_node);
 }
 
+static inline struct fw_device *fw_node_get_device(struct fw_node *node)
+{
+	return node->device;
+}
+
+static inline void fw_node_set_device(struct fw_node *node, struct fw_device *device)
+{
+	node->device = device;
+}
+
 void fw_core_handle_bus_reset(struct fw_card *card, int node_id,
 	int generation, int self_id_count, u32 *self_ids, bool bm_abdicate);
 void fw_destroy_nodes(struct fw_card *card);
-- 
2.48.1


