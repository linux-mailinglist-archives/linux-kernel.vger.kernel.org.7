Return-Path: <linux-kernel+bounces-804931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B95B4820D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F8E189CAC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43982221F03;
	Mon,  8 Sep 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fI3hC+9G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUBM5r+8"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75BC21C19E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294490; cv=none; b=ftGjaqDZHNHBntGq9p6nZd+w8cw0OoHJ0HOZYUrreixPyGEOReMnQ9rVIIfbv4P1lXFPWlNJgfyFC+0Mev5AfClXLOUdi+u9X0fYEXZenpHU8sbfkjMhgsXbNSxVleSr3FZZBPyXS6BYfdvwgiX8yG8mqQT3lXKmJME5RT4yR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294490; c=relaxed/simple;
	bh=PQQtFBgT54vCCIwCV7Eck4GoIN5bf9W23kR7uRuXUWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz5hxcskLs5Ay6NRm1CjsWKowbDYsOc9jpXXBwkj6GtoixX9BTl6DGHzYvOypaEgdgrmFpX8rgfamcujNhTK7u1hP7/cBNbx91lFZBEfDnFpXSZs7/DKf/x/HylJPCKpJwmSsakXoDZZ2T5e51JwblmOr34YusCnEXr4VIqtBss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fI3hC+9G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUBM5r+8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F0CD9EC00A6;
	Sun,  7 Sep 2025 21:21:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 07 Sep 2025 21:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294487; x=
	1757380887; bh=UQnp+k+Zo5z2StVUHwUJPpMC87ruLHT+ma6kU7RfeZs=; b=f
	I3hC+9Gie2KnUrH3MNouwnweFat5ZaeaPTnbe7K3BOw2Ce8699YFahZ9spBWOHAp
	oIqmgiGHa/2ulr47ix7doP1/qY7YTBB3PIii4zlHm131vsEZUDMQTAIDaVweEXsb
	2aY5svVE684TZ63ZVmrYUDXf0l7OGv9m1CLdgK0ksGfrC9SoWrlltNGS6Kjtn+yB
	Ea6BfMV8AERck/5iG3cbMcsLRw73hiaihIojpqDu5A9UZY7xJ2BWUgvywHtX+hEV
	54pXxqvJXYcep6znKzNVPmPxjvrJcnpIxidl2hbV3JnW9TFHebQdWYDT5U3Zmpfz
	/58HPMzLP6f/r2KZoopfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294487; x=1757380887; bh=U
	Qnp+k+Zo5z2StVUHwUJPpMC87ruLHT+ma6kU7RfeZs=; b=MUBM5r+86MmeexnXr
	HSgMMi4QjGvfZMB6qKnyqqjeF7yJMTh9+mCmYhR8xJXX0wVcS+ZaQgNNfzRxLiVD
	tXIG6Awhy4jedF53OdCt6slj4ylTHvAf6p+0Y4fOsD/89G+e70SzEUP1eTfIPn8+
	3HdxRIe/aZ5VcrEwyIno0EYx3zQHD6WdWB/iyMuGv4xOkwsCixwcU0ruxB5JtuQa
	gjz+qCemlaWeWHaNOQsoyP/9p8jDHHu4m1es6qrNYFT+xZrUDG0dLJE8dW2r5v3q
	tgxPohyV+M7oKSkUmHL+zechz/7Eqo4FnZO2v7RdJDcA6hEMgQQOTYF6Q0S82z+t
	4VkaA==
X-ME-Sender: <xms:ly--aGzssJVj1Ro6HhiEQCSVBJfTOOaUyLD_bSd2HlDQYUS64GzxSQ>
    <xme:ly--aLMvFDahnBVElsDaeZuNsrxMHBFOgFjM5ZGA0zQP6EruAvE1uL_BpdjoPWB3f
    WPeUj_x0Pw-OXPCUTc>
X-ME-Received: <xmr:ly--aKQMD_paYnwAkL-U9KMJh-lP6zn9qxCFsuYSU8DnrI5XEtfR2bqd3YBCMqTKDMFDlrBfHjdhTEy1T1HWvjq1bNuPSHRTldJxPBGqADg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ly--aJZsiLiLi1gHimwdyGHGtRGIWoVEjLf6-075TvzS2dymCDyoDQ>
    <xmx:ly--aH33vgOSLYWjvq81Bhgbqqdl_yMjavGMhqlUHKfS8WG5sdbDEw>
    <xmx:ly--aJW2Y-yVWObGLnWhI0yu6jvAX7Wi6qY5bELUC5bNwGwkAlz1gQ>
    <xmx:ly--aBUfpaxna5LBybd2LYCNvJSWsYyYC0Zp5oky8Pf2Co4Uqfw7GQ>
    <xmx:ly--aP1b-Mt9MffGSSRamGpatMtEqaqpvds2vGZmFqo3RZA6guT1VdqX>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:26 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] firewire: core: code refactoring to investigate root node for bus manager
Date: Mon,  8 Sep 2025 10:21:07 +0900
Message-ID: <20250908012108.514698-11-o-takashi@sakamocchi.jp>
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

In the middle of bm_work function, both the value of gap_count and the
state of root node are investigated. Current implementation is not a good
shape since the investigation is aligned to be flat.

This commit refactors the investigation with two large branches.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 56 +++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 99aa98f195ba..b430a70a7eeb 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -294,7 +294,6 @@ static void bm_work(struct work_struct *work)
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation, grace;
 	bool do_reset = false;
-	bool root_device_is_running;
 	bool root_device_is_cmc;
 
 	lockdep_assert_held(&card->lock);
@@ -310,8 +309,6 @@ static void bm_work(struct work_struct *work)
 
 	root_node = fw_node_get(card->root_node);
 	root_device = fw_node_get_device(root_node);
-	root_device_is_running = root_device &&
-			atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
 	root_device_is_cmc = root_device && root_device->cmc;
 
 	root_id  = root_node->node_id;
@@ -450,34 +447,35 @@ static void bm_work(struct work_struct *work)
 		 * is inconsistent, so bypass the 5-reset limit.
 		 */
 		card->bm_retries = 0;
-	} else if (root_device == NULL) {
-		/*
-		 * Either link_on is false, or we failed to read the
-		 * config rom.  In either case, pick another root.
-		 */
-		new_root_id = local_id;
-	} else if (!root_device_is_running) {
-		/*
-		 * If we haven't probed this device yet, bail out now
-		 * and let's try again once that's done.
-		 */
-		spin_unlock_irq(&card->lock);
-		return;
-	} else if (root_device_is_cmc) {
-		/*
-		 * We will send out a force root packet for this
-		 * node as part of the gap count optimization.
-		 */
-		new_root_id = root_id;
 	} else {
-		/*
-		 * Current root has an active link layer and we
-		 * successfully read the config rom, but it's not
-		 * cycle master capable.
-		 */
-		new_root_id = local_id;
-	}
+		// Now investigate root node.
+		struct fw_device *root_device = fw_node_get_device(root_node);
+
+		if (root_device == NULL) {
+			// Either link_on is false, or we failed to read the
+			// config rom.  In either case, pick another root.
+			new_root_id = local_id;
+		} else {
+			bool root_device_is_running =
+				atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
 
+			if (!root_device_is_running) {
+				// If we haven't probed this device yet, bail out now
+				// and let's try again once that's done.
+				spin_unlock_irq(&card->lock);
+				return;
+			} else if (root_device->cmc) {
+				// We will send out a force root packet for this
+				// node as part of the gap count optimization.
+				new_root_id = root_id;
+			} else {
+				// Current root has an active link layer and we
+				// successfully read the config rom, but it's not
+				// cycle master capable.
+				new_root_id = local_id;
+			}
+		}
+	}
  pick_me:
 	/*
 	 * Pick a gap count from 1394a table E-1.  The table doesn't cover
-- 
2.48.1


