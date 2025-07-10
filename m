Return-Path: <linux-kernel+bounces-725743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C9B00329
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3931C44CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7A2253AE;
	Thu, 10 Jul 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VlGGixNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kHDJpjAT"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA417993
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153563; cv=none; b=PnzTidqFm67sVfbeXn3vYdliKffkqmQ3qUIJWSiPmQWqb+pVZ6wcsSv2Gq1X3V/bYZes3xic4akJgk7Y8VcwOufp75ITApAw/snDKAEbMcazl1LRAkHa6BAiAMDLFKNLHJlX54DH6vKZCBOyHHkUlMSoIPrxOATCtH93bXtaQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153563; c=relaxed/simple;
	bh=WkW+/GpbK2frK/3CMmGvbUfGsg4fwOlV3E6sToSFpbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OToY3oYOOP3YRCSLRA6R3Asz2J7nsFSSLSQZfpYMFOr1UV4cp3TFSc8fo6E2z46wKerxDEeouWhYIIoBuEwKELAAPGjOrFb+VD/1VwQwIqBdco1oL26LaIr/uSm9h9nDoc6dC7sOQYzJ+nm515wDbCXDTcuXTRzenAAoByE1qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VlGGixNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kHDJpjAT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id F07B51D0026E;
	Thu, 10 Jul 2025 09:19:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 10 Jul 2025 09:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1752153559; x=1752239959; bh=PyUu/IKm/w
	V4pY4tq4U/UXKUwJeiNHteUFkfF7pys2E=; b=VlGGixNyELFIVzU2TDytSJRY9L
	d7PRhlW+RiXJmHy0h6c2IDUqMw+CyYGPJ9eO7wnnh7HDjULASxCkHmxJZt+C4r95
	Lab9w8rWigS087CthNjJe1xZyjZX6NzHTjnnYQu0L8jQAUv58r8SETK3QJ9KSK7+
	5qQA/I4n6C8UdgcU89biU8aJRqpM9Mm9H7pwGyRs+xF4aATGiwCStmwuaWXpV3yf
	V94YKsa+b8opNSwvZZ3H85aWLa9trpttaXyE1Q78XYyzCroRI9qtAdV3hpiFWOkD
	irKeTZA3iNgFzlxsFnU7knDmPTXzJdf3AeK8sWSq0i65yOYzLClgvjSXyBxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752153559; x=1752239959; bh=PyUu/IKm/wV4pY4tq4U/UXKUwJeiNHteUFk
	fF7pys2E=; b=kHDJpjATvupCSOYwF318C6fuKJ/tbo9hm1Mj3udhtgVkywijPOZ
	hKa0xMO75UqfV57b2hC0nuvelbBETZXFHExJCoRMx7okLANaCI8+aKa96fU+7H0m
	i2uJgMkaHbsY0q0G+Y4S9EDzASNvUi5iZAfQQ73wlwMf0DsUC6ydVNJ2fb4Kd7Xi
	fS53Sfxu2mPZBQ2UmCpdY0I0pjcc5n59JXZLrl84K8jxHSxXlg3QXe1HNILWDnLM
	f9HpIHtsn5sIAEKfAp1TLu8xtwdOFu3fG7newIudXov2FK0WJBYK4HNMCt7hNq6n
	25VBYzMULzsTYZlBn04BSo5z2Ao99RnbyXw==
X-ME-Sender: <xms:171vaNNEppOlwi7id05OyRl_dcN-W7BxaPMLLTb5BGPqs8-9Q0-r9g>
    <xme:171vaI5d65VnrdblYr54MkGCroxq8q6zNvEiS1f4J0T8v2ka_LaSr0ABIDVC8GkQK
    dPZ3shsyynFqgi7FX4>
X-ME-Received: <xmr:171vaONUxEv0pCelmln8lNvk26AYOt52s1wiPPiEQ3QiFGvUwsbdfRbVIK3COri4ARTEEVOf_PZ6xtbLSnMhID1jg7scSXL6GBxqVUl88BME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttd
    enucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihes
    shgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhf
    etjeduffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmh
    hotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfh
    horhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:171vaGnJtJ0IgRdU8IHxGpIVNn7Apl3Q1kQ4yQNRzRNSgaoohLDfHA>
    <xmx:171vaFQPjP-8lrMXhRTPxZDepjxJiIB1u7LvzThwWauOEyZe4tbdxg>
    <xmx:171vaCAHVtKkY3WK01ItoQdiu5kGVqhlgbXMO657q_H0ld_CZl7Nbg>
    <xmx:171vaERMUhPjJeYPH_J7uY1OiF8uIGTDrZe4tU3wp-R74043ZRAUoQ>
    <xmx:171vaNxSW6fNA7uBdxSWRc-LQZPkSAq47Dvphn7elPPnRve_U0Jy3xK1>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 09:19:18 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: ohci: reduce the size of common context structure by extracting members into AT structure
Date: Thu, 10 Jul 2025 22:19:16 +0900
Message-ID: <20250710131916.31289-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 386a4153a2c1 ("firewire: ohci: cache the context run bit"), a
running member was added to the context structure to cache the running
state of a given DMA context. Although this member is accessible from IR,
IT, and AT contexts, it is currently used only by the AT context.

Additionally, the context structure includes a work item, which is also
used by the AT context. Both members are unnecessary for IR and IT
contexts.

This commit refactors the code by moving these two members into a new
structure specific to AT context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 92 ++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 43 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 709a714fd5c8..5d8301b0f3aa 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -128,7 +128,6 @@ struct context {
 	int total_allocation;
 	u32 current_bus;
 	bool running;
-	bool flushing;
 
 	/*
 	 * List of page-sized buffers for storing DMA descriptors.
@@ -157,8 +156,12 @@ struct context {
 	int prev_z;
 
 	descriptor_callback_t callback;
+};
 
+struct at_context {
+	struct context context;
 	struct work_struct work;
+	bool flushing;
 };
 
 struct iso_context {
@@ -204,8 +207,8 @@ struct fw_ohci {
 
 	struct ar_context ar_request_ctx;
 	struct ar_context ar_response_ctx;
-	struct context at_request_ctx;
-	struct context at_response_ctx;
+	struct at_context at_request_ctx;
+	struct at_context at_response_ctx;
 
 	u32 it_context_support;
 	u32 it_context_mask;     /* unoccupied IT contexts */
@@ -1178,9 +1181,9 @@ static void context_retire_descriptors(struct context *ctx)
 
 static void ohci_at_context_work(struct work_struct *work)
 {
-	struct context *ctx = from_work(ctx, work, work);
+	struct at_context *ctx = from_work(ctx, work, work);
 
-	context_retire_descriptors(ctx);
+	context_retire_descriptors(&ctx->context);
 }
 
 static void ohci_isoc_context_work(struct work_struct *work)
@@ -1382,17 +1385,17 @@ struct driver_data {
  * Must always be called with the ochi->lock held to ensure proper
  * generation handling and locking around packet queue manipulation.
  */
-static int at_context_queue_packet(struct context *ctx,
-				   struct fw_packet *packet)
+static int at_context_queue_packet(struct at_context *ctx, struct fw_packet *packet)
 {
-	struct fw_ohci *ohci = ctx->ohci;
+	struct context *context = &ctx->context;
+	struct fw_ohci *ohci = context->ohci;
 	dma_addr_t d_bus, payload_bus;
 	struct driver_data *driver_data;
 	struct descriptor *d, *last;
 	__le32 *header;
 	int z, tcode;
 
-	d = context_get_descriptors(ctx, 4, &d_bus);
+	d = context_get_descriptors(context, 4, &d_bus);
 	if (d == NULL) {
 		packet->ack = RCODE_SEND_ERROR;
 		return -1;
@@ -1422,7 +1425,7 @@ static int at_context_queue_packet(struct context *ctx,
 		ohci1394_at_data_set_destination_id(header,
 						    async_header_get_destination(packet->header));
 
-		if (ctx == &ctx->ohci->at_response_ctx) {
+		if (ctx == &ohci->at_response_ctx) {
 			ohci1394_at_data_set_rcode(header, async_header_get_rcode(packet->header));
 		} else {
 			ohci1394_at_data_set_destination_offset(header,
@@ -1511,17 +1514,17 @@ static int at_context_queue_packet(struct context *ctx,
 		return -1;
 	}
 
-	context_append(ctx, d, z, 4 - z);
+	context_append(context, d, z, 4 - z);
 
-	if (ctx->running)
-		reg_write(ohci, CONTROL_SET(ctx->regs), CONTEXT_WAKE);
+	if (context->running)
+		reg_write(ohci, CONTROL_SET(context->regs), CONTEXT_WAKE);
 	else
-		context_run(ctx, 0);
+		context_run(context, 0);
 
 	return 0;
 }
 
-static void at_context_flush(struct context *ctx)
+static void at_context_flush(struct at_context *ctx)
 {
 	// Avoid dead lock due to programming mistake.
 	if (WARN_ON_ONCE(current_work() == &ctx->work))
@@ -1540,12 +1543,13 @@ static int handle_at_packet(struct context *context,
 			    struct descriptor *d,
 			    struct descriptor *last)
 {
+	struct at_context *ctx = container_of(context, struct at_context, context);
+	struct fw_ohci *ohci = ctx->context.ohci;
 	struct driver_data *driver_data;
 	struct fw_packet *packet;
-	struct fw_ohci *ohci = context->ohci;
 	int evt;
 
-	if (last->transfer_status == 0 && !READ_ONCE(context->flushing))
+	if (last->transfer_status == 0 && !READ_ONCE(ctx->flushing))
 		/* This descriptor isn't done yet, stop iteration. */
 		return 0;
 
@@ -1579,7 +1583,7 @@ static int handle_at_packet(struct context *context,
 		break;
 
 	case OHCI1394_evt_missing_ack:
-		if (READ_ONCE(context->flushing))
+		if (READ_ONCE(ctx->flushing))
 			packet->ack = RCODE_GENERATION;
 		else {
 			/*
@@ -1601,7 +1605,7 @@ static int handle_at_packet(struct context *context,
 		break;
 
 	case OHCI1394_evt_no_status:
-		if (READ_ONCE(context->flushing)) {
+		if (READ_ONCE(ctx->flushing)) {
 			packet->ack = RCODE_GENERATION;
 			break;
 		}
@@ -1698,13 +1702,14 @@ static void handle_local_lock(struct fw_ohci *ohci,
 	fw_core_handle_response(&ohci->card, &response);
 }
 
-static void handle_local_request(struct context *ctx, struct fw_packet *packet)
+static void handle_local_request(struct at_context *ctx, struct fw_packet *packet)
 {
+	struct fw_ohci *ohci = ctx->context.ohci;
 	u64 offset, csr;
 
-	if (ctx == &ctx->ohci->at_request_ctx) {
+	if (ctx == &ohci->at_request_ctx) {
 		packet->ack = ACK_PENDING;
-		packet->callback(packet, &ctx->ohci->card, packet->ack);
+		packet->callback(packet, &ohci->card, packet->ack);
 	}
 
 	offset = async_header_get_offset(packet->header);
@@ -1712,54 +1717,55 @@ static void handle_local_request(struct context *ctx, struct fw_packet *packet)
 
 	/* Handle config rom reads. */
 	if (csr >= CSR_CONFIG_ROM && csr < CSR_CONFIG_ROM_END)
-		handle_local_rom(ctx->ohci, packet, csr);
+		handle_local_rom(ohci, packet, csr);
 	else switch (csr) {
 	case CSR_BUS_MANAGER_ID:
 	case CSR_BANDWIDTH_AVAILABLE:
 	case CSR_CHANNELS_AVAILABLE_HI:
 	case CSR_CHANNELS_AVAILABLE_LO:
-		handle_local_lock(ctx->ohci, packet, csr);
+		handle_local_lock(ohci, packet, csr);
 		break;
 	default:
-		if (ctx == &ctx->ohci->at_request_ctx)
-			fw_core_handle_request(&ctx->ohci->card, packet);
+		if (ctx == &ohci->at_request_ctx)
+			fw_core_handle_request(&ohci->card, packet);
 		else
-			fw_core_handle_response(&ctx->ohci->card, packet);
+			fw_core_handle_response(&ohci->card, packet);
 		break;
 	}
 
-	if (ctx == &ctx->ohci->at_response_ctx) {
+	if (ctx == &ohci->at_response_ctx) {
 		packet->ack = ACK_COMPLETE;
-		packet->callback(packet, &ctx->ohci->card, packet->ack);
+		packet->callback(packet, &ohci->card, packet->ack);
 	}
 }
 
-static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
+static void at_context_transmit(struct at_context *ctx, struct fw_packet *packet)
 {
+	struct fw_ohci *ohci = ctx->context.ohci;
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&ctx->ohci->lock, flags);
+	spin_lock_irqsave(&ohci->lock, flags);
 
-	if (async_header_get_destination(packet->header) == ctx->ohci->node_id &&
-	    ctx->ohci->generation == packet->generation) {
-		spin_unlock_irqrestore(&ctx->ohci->lock, flags);
+	if (async_header_get_destination(packet->header) == ohci->node_id &&
+	    ohci->generation == packet->generation) {
+		spin_unlock_irqrestore(&ohci->lock, flags);
 
 		// Timestamping on behalf of the hardware.
-		packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ctx->ohci));
+		packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ohci));
 
 		handle_local_request(ctx, packet);
 		return;
 	}
 
 	ret = at_context_queue_packet(ctx, packet);
-	spin_unlock_irqrestore(&ctx->ohci->lock, flags);
+	spin_unlock_irqrestore(&ohci->lock, flags);
 
 	if (ret < 0) {
 		// Timestamping on behalf of the hardware.
-		packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ctx->ohci));
+		packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ohci));
 
-		packet->callback(packet, &ctx->ohci->card, packet->ack);
+		packet->callback(packet, &ohci->card, packet->ack);
 	}
 }
 
@@ -2138,8 +2144,8 @@ static void bus_reset_work(struct work_struct *work)
 	// FIXME: Document how the locking works.
 	scoped_guard(spinlock_irq, &ohci->lock) {
 		ohci->generation = -1; // prevent AT packet queueing
-		context_stop(&ohci->at_request_ctx);
-		context_stop(&ohci->at_response_ctx);
+		context_stop(&ohci->at_request_ctx.context);
+		context_stop(&ohci->at_response_ctx.context);
 	}
 
 	/*
@@ -2683,7 +2689,7 @@ static void ohci_send_response(struct fw_card *card, struct fw_packet *packet)
 static int ohci_cancel_packet(struct fw_card *card, struct fw_packet *packet)
 {
 	struct fw_ohci *ohci = fw_ohci(card);
-	struct context *ctx = &ohci->at_request_ctx;
+	struct at_context *ctx = &ohci->at_request_ctx;
 	struct driver_data *driver_data = packet->driver_data;
 	int ret = -ENOENT;
 
@@ -3767,13 +3773,13 @@ static int pci_probe(struct pci_dev *dev,
 	if (err < 0)
 		return err;
 
-	err = context_init(&ohci->at_request_ctx, ohci,
+	err = context_init(&ohci->at_request_ctx.context, ohci,
 			   OHCI1394_AsReqTrContextControlSet, handle_at_packet);
 	if (err < 0)
 		return err;
 	INIT_WORK(&ohci->at_request_ctx.work, ohci_at_context_work);
 
-	err = context_init(&ohci->at_response_ctx, ohci,
+	err = context_init(&ohci->at_response_ctx.context, ohci,
 			   OHCI1394_AsRspTrContextControlSet, handle_at_packet);
 	if (err < 0)
 		return err;
-- 
2.48.1


