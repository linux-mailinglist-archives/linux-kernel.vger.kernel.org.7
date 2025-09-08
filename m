Return-Path: <linux-kernel+bounces-804929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE51BB4820B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B0E3BFFEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9A21C195;
	Mon,  8 Sep 2025 01:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="OgQPv7Ax";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOfliCo+"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE33204583
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294487; cv=none; b=PxkFctEfd15hm8WPgiaYvp1jFkD0nBNzIZVcbLD8+Bu6jWMQC3XLkUnzhu4eAVYVtqWWxiNrMK359bCtTvb8Mzq506yW/W4wOyfK7Yt6WIqXoRt4ncTe2MDg9t13imcvPjscUjn4e9NqDAMuouBSQ9/ApkjDTydEjqlDwZgCCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294487; c=relaxed/simple;
	bh=o60qmQF5po3Njkng1yM+IUo0Nvd7xga7cXxWjTwFSvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a43YdP9Z9zROm6JsPmKrSoh9Ai0dY5vOdoQz2C+LNBOKZ5o+jY2Yw7zVd2e1ed6o8PEjinC/lnIIxAj9d/4k2Rbffm5wU+qONV48Isz0q2owSN3DogGLRvHlZ1ItbX8CeElNFADHiJCLI0ZpiFZyEmUxA/ueMhvfzvQKWHVKC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=OgQPv7Ax; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOfliCo+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3D752EC003B;
	Sun,  7 Sep 2025 21:21:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 07 Sep 2025 21:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294485; x=
	1757380885; bh=mSnUVpxCiJr1+TG9UdtbcF0qEHQfcBsU1XskFAkRnUI=; b=O
	gQPv7Axo6GC5o+5fd6uXfDkTbODAwvx2Juq2+WctbytnEsN9ULYnoLNER6Qjld0k
	MVU76TGmKfSiu17hl+Ogh4CV/IaOdLIKjoDB9V/iC4uODJV3er+WzbCZZJ97p58l
	1vX05D86G9ioIfWuOow/wKN+B/Pt3P8uOxRPkx+eB1jLmOxl90J0wE/dn7n732tm
	2nRlOhKr1dli333m9GKrz6wUyZrmaDoXe4HKPvgf2S9dAZ3+s4qOInSuuKh9xApk
	c9AvhqK0/fGeQoTP7/W/yktNp1KzewyoghLhe85bywKfRdW9rUxmdKnC5ITFK/w1
	YlHF3KUpQNQC3O5wX4NjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294485; x=1757380885; bh=m
	SnUVpxCiJr1+TG9UdtbcF0qEHQfcBsU1XskFAkRnUI=; b=hOfliCo+TS2DbMB1N
	fYjbtoVbwSmv1HcJBKEN59B/7Wy8Ywm2ADJ9d5cWxIJy60MKGo4tQ/RidELTry1t
	D4oIhGEB0qa01Q9GdbHEBXCezCbaWdpDljvi9ASzHlcqjXfpEs1AQwLLUh50kqo7
	EgdoZO87lQYuLDnDeVBe/bvvTRkoUgsJ9pBCjsHXeeHpW9z+Hj2ld96CZFpzziT5
	8ob3G/Za9i3jiXcsKCaAupUFEAi1iGV45JZKppFpT4HCIXPZtbQueKBBqnKZrl1d
	dvOkx5IfWpFsdX7SlUBwJ5g2VVl4e9GPHwc1n/WPJbZq4X0lRBxYSRRfV5NB8i4f
	BYVMA==
X-ME-Sender: <xms:lS--aBR4AbKfTwsJM22jZgl0zQuyAn9T3lSF5rajplEZpGK9S1ETlQ>
    <xme:lS--aDuWuBDBR8bVlgjciRZSYF8CsPrqRDG6uV_qkq5hTiNXAuAZBl6eACrg7yAj_
    GSNovknmVKEN81it6g>
X-ME-Received: <xmr:lS--aIzkjDt60Oq5PzinwdEledmOu5Q1x5ctYcONIvbyAQM3_0-TxybDDgCARiu9uTOip8fMFKdbanRzff5HG7jD8mYzpeV2lRgCIrPCCwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:lS--aF7K9-SC3t5B7UzS9QFZg-9lXjOGPdtR6JN1C-Xt8vJLOHSiNg>
    <xmx:lS--aKWVy-GSbCVh03VZTQKKzv_K6pT4BC2hHSNppRSlDp-bSbAA3Q>
    <xmx:lS--aJ39ukpsuEwR4sE_sN7eCVVfv_vAueRzpqnT7hTT9ZHMLlOi-g>
    <xmx:lS--aH2N_6ysL4KDmvvUl2tQfT29SevFpvOAJeXrIOXR-H2q8u-DxQ>
    <xmx:lS--aOVSR3bTmS2Z6JNN4ff8VLfOnhdi7LGZDIZG9hXc71hjZ5kBSHsH>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:24 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] firewire: core: refer fw_card member to initiate bus reset under acquiring lock
Date: Mon,  8 Sep 2025 10:21:05 +0900
Message-ID: <20250908012108.514698-9-o-takashi@sakamocchi.jp>
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

The gap_count member of fw_card structure is referred when initiate bus
reset. This reference is done out of acquiring lock. This is not good.

This commit takes the reference within the acquiring lock, with
additional code refactoring.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 52 ++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index e1a7a151b109..630e229c9cc2 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -292,7 +292,7 @@ static void bm_work(struct work_struct *work)
 	struct fw_device *root_device, *irm_device;
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, local_id;
-	int gap_count, generation, grace;
+	int expected_gap_count, generation, grace;
 	bool do_reset = false;
 	bool root_device_is_running;
 	bool root_device_is_cmc;
@@ -485,9 +485,9 @@ static void bm_work(struct work_struct *work)
 	 */
 	if (!card->beta_repeaters_present &&
 	    root_node->max_hops < ARRAY_SIZE(gap_count_table))
-		gap_count = gap_count_table[root_node->max_hops];
+		expected_gap_count = gap_count_table[root_node->max_hops];
 	else
-		gap_count = 63;
+		expected_gap_count = 63;
 
 	/*
 	 * Finally, figure out if we should do a reset or not.  If we have
@@ -495,16 +495,17 @@ static void bm_work(struct work_struct *work)
 	 * have either a new root or a new gap count setting, let's do it.
 	 */
 
-	if (card->bm_retries++ < 5 &&
-	    (card->gap_count != gap_count || new_root_id != root_id))
+	if (card->bm_retries++ < 5 && (card->gap_count != expected_gap_count || new_root_id != root_id))
 		do_reset = true;
 
-	spin_unlock_irq(&card->lock);
-
 	if (do_reset) {
+		int card_gap_count = card->gap_count;
+
+		spin_unlock_irq(&card->lock);
+
 		fw_notice(card, "phy config: new root=%x, gap_count=%d\n",
-			  new_root_id, gap_count);
-		fw_send_phy_config(card, new_root_id, generation, gap_count);
+			  new_root_id, expected_gap_count);
+		fw_send_phy_config(card, new_root_id, generation, expected_gap_count);
 		/*
 		 * Where possible, use a short bus reset to minimize
 		 * disruption to isochronous transfers. But in the event
@@ -517,26 +518,25 @@ static void bm_work(struct work_struct *work)
 		 * may treat it as two, causing a gap count inconsistency
 		 * again. Using a long bus reset prevents this.
 		 */
-		reset_bus(card, card->gap_count != 0);
+		reset_bus(card, card_gap_count != 0);
 		/* Will allocate broadcast channel after the reset. */
-		return;
-	}
+	} else {
+		spin_unlock_irq(&card->lock);
 
-	if (root_device_is_cmc) {
-		/*
-		 * Make sure that the cycle master sends cycle start packets.
-		 */
-		__be32 data = cpu_to_be32(CSR_STATE_BIT_CMSTR);
-		int rcode = fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
-				root_id, generation, SCODE_100,
-				CSR_REGISTER_BASE + CSR_STATE_SET,
-				&data, sizeof(data));
-		if (rcode == RCODE_GENERATION)
-			return;
-	}
+		if (root_device_is_cmc) {
+			// Make sure that the cycle master sends cycle start packets.
+			__be32 data = cpu_to_be32(CSR_STATE_BIT_CMSTR);
+			int rcode = fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
+					root_id, generation, SCODE_100,
+					CSR_REGISTER_BASE + CSR_STATE_SET,
+					&data, sizeof(data));
+			if (rcode == RCODE_GENERATION)
+				return;
+		}
 
-	if (local_id == irm_id)
-		allocate_broadcast_channel(card, generation);
+		if (local_id == irm_id)
+			allocate_broadcast_channel(card, generation);
+	}
 }
 
 void fw_card_initialize(struct fw_card *card,
-- 
2.48.1


