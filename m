Return-Path: <linux-kernel+bounces-816031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199A8B56E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 04:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C0C1899EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52491229B18;
	Mon, 15 Sep 2025 02:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="hXyEE6uU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eK/uq/e/"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA02135D7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757904162; cv=none; b=I6mK1NX978dHvYMYRE6Un9q5onutR5fqGkSIbSt4vfz8ZnapRKhdH1OotYyuPAGLAMDep0zPYbPYlV3LZ9Kx9t3hiLJoDkpYSjvRbgZWmm7AhFSLRReawF3QQp4zurRg3lDL0OP7Cp4OMsFUtKqW3gXbmprHz2GVVDb3zYXyHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757904162; c=relaxed/simple;
	bh=Ho5UJC2hsjz61eJM1tcK+RtY5/qUrc+U5k+EQw7ixxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOOXyFImF2WXXN16F1d/9vqLbwOYIqEQJFIzdvsBsy69ab3PgrXIc94escRF8fjjQmQfKDuCTZ610Hs2HS9/OARt+V5NYoL1HdVNurFQGGK8s5tzQYayCkqtTN6EnwrOr8jPJEHPypLyvJ1AtLcWOvq25nIp54PtEDGhJmAOfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=hXyEE6uU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eK/uq/e/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BBFF91D0008A;
	Sun, 14 Sep 2025 22:42:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 22:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757904159; x=
	1757990559; bh=k+1xFx1bqcSZnjU5LG3bHBbaKfjqK+CEGtY+X0biaxM=; b=h
	XyEE6uU2fDkbHtpEbrH/F6TaG9tSdecQ4fB/e31kidDiR1VaqcsMRfwIrdfV9jb7
	SfCbrZUrlFDWmI3DErKNq6PiI4ZnZpaJzkNSkiLaMOJWv9dgqNkmFqFCeYhnp826
	teMG+wLOg1ioyurqjDuTzQRiCDqKT4UzGVzgB5ipu3OAD7hgBL4lM1cDbnqyv/gT
	sxHM83bxTmpntM5ydAR/zA4AWIfm7HGncR8RmdfUNqXnIysf+iUNPc44l7mP7Umd
	He62BhxTITbZ+gIQ0jrBF35u+FU1bv0eGfCbe2fAawsoBeiE0cVLACH/Bm4H1YNw
	z2WThQWWDg5jGJtkQOLRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757904159; x=1757990559; bh=k
	+1xFx1bqcSZnjU5LG3bHBbaKfjqK+CEGtY+X0biaxM=; b=eK/uq/e/FOepIoZGo
	5JUxvpmnMqLVqpCgvWn1VHSxgbr7nXfP7RXr9lYTfBL9f/AyQYPlX8gKY2IxxoLt
	WUO3ifyiibgrX/v3JeyY8DhxNFYqcHC24VbmyQNQGPacuy7wZz8QxTbSuxzwbr5l
	ocZ0ruf0ij14hsnMZT6y7MzhY2wtKt9Gg00rRRuFxZyNl6ZyDYELlivIZrmp9I+A
	wIFWIXZcbxj0VwiEdnFIQzsNKIhd410zw3Z10D2asi32meP3SMZVBasPEuZDj3yV
	BzfdzU3gZIG00+Zz8WztXL79otJDXJjNY47eYMe7OwS0UYiLcKkpmvGflwLybfy0
	T4PDg==
X-ME-Sender: <xms:H33HaN7itsyfQarjCqUzbRX1GmZ1mS7FxdptH1fIKkTyKCPP-ioFzg>
    <xme:H33HaD2KIAxPNx5iit58ElHXnC1fnhjyQ5R-a21urZ5Yp9WdvSKnir4Daz8_w5jrH
    -0FxlVlUWzvd0wGeHU>
X-ME-Received: <xmr:H33HaGaV4Vk37wH5E31PexkfnHEqe_g6qP0N4-cBEZSSMFdLqsru3b79Qa5JeKqJDL0ffyj5ykqWekXJuisPrpRM6uQjPBJN1KXJw8-VEvhxp9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieehvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:H33HaDDz4voQURn3JTiLWaHOxR9UW2dlkhle1WAnlmspNEUynBtOTw>
    <xmx:H33HaA-jMDu8YCmLjjsP7wjd9_-MXxsOQ7TLz5KfOMBrsCuaBtsDmg>
    <xmx:H33HaL_vhm4EoD4hYAnbDAyOCYcUrDBHbXnHsPPRVPo_Dsp4EcS9Ww>
    <xmx:H33HaPcxuNmQNDHraVVk_oSEp_AuY_Z7uOBjN-dxQKU4ZQLmHiV1ug>
    <xmx:H33HaH8_xPt9KiUWxm6Wa9tvbxJKKByefxZl09KOUmgVCxy0B8jMSyHw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:42:38 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: use helper macro to compare against current jiffies
Date: Mon, 15 Sep 2025 11:42:32 +0900
Message-ID: <20250915024232.851955-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915024232.851955-1-o-takashi@sakamocchi.jp>
References: <20250915024232.851955-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern of calling either time_before64() or time_after64() with
get_jiffies_64() can be replaced with the corresponding helper macros.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c   | 4 ++--
 drivers/firewire/core-cdev.c   | 2 +-
 drivers/firewire/core-device.c | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 2541e8bb4b75..b5e01a711145 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -240,7 +240,7 @@ static void br_work(struct work_struct *work)
 
 	/* Delay for 2s after last reset per IEEE 1394 clause 8.2.1. */
 	if (card->reset_jiffies != 0 &&
-	    time_before64(get_jiffies_64(), card->reset_jiffies + secs_to_jiffies(2))) {
+	    time_is_after_jiffies64(card->reset_jiffies + secs_to_jiffies(2))) {
 		trace_bus_reset_postpone(card->index, card->generation, card->br_short);
 
 		if (!queue_delayed_work(fw_workqueue, &card->br_work, secs_to_jiffies(2)))
@@ -308,7 +308,7 @@ static void bm_work(struct work_struct *work)
 	irm_id   = card->irm_node->node_id;
 	local_id = card->local_node->node_id;
 
-	grace = time_after64(get_jiffies_64(), card->reset_jiffies + msecs_to_jiffies(125));
+	grace = time_is_before_jiffies64(card->reset_jiffies + msecs_to_jiffies(125));
 
 	if ((is_next_generation(generation, card->bm_generation) &&
 	     !card->bm_abdicate) ||
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 9e90c79becdb..1be8f5eb3e17 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -1324,7 +1324,7 @@ static void iso_resource_work(struct work_struct *work)
 		todo = r->todo;
 		// Allow 1000ms grace period for other reallocations.
 		if (todo == ISO_RES_ALLOC &&
-		    time_before64(get_jiffies_64(), client->device->card->reset_jiffies + secs_to_jiffies(1))) {
+		    time_is_after_jiffies64(client->device->card->reset_jiffies + secs_to_jiffies(1))) {
 			schedule_iso_resource(r, msecs_to_jiffies(333));
 			skip = true;
 		} else {
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 7d5821cd9b37..457a0da024a7 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -855,8 +855,7 @@ static void fw_device_shutdown(struct work_struct *work)
 {
 	struct fw_device *device = from_work(device, work, work.work);
 
-	if (time_before64(get_jiffies_64(),
-			  device->card->reset_jiffies + SHUTDOWN_DELAY)
+	if (time_is_after_jiffies64(device->card->reset_jiffies + SHUTDOWN_DELAY)
 	    && !list_empty(&device->card->link)) {
 		fw_schedule_device_work(device, SHUTDOWN_DELAY);
 		return;
-- 
2.48.1


