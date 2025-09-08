Return-Path: <linux-kernel+bounces-804930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A473B4820C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD62173E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9841EF363;
	Mon,  8 Sep 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="m7B31nOY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ckb0ObfG"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34637215075
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294489; cv=none; b=hJnu+1I4sTfzaF4F7ltbbDOuVm8ihrUOqtab1Z1/l1x149b8OegpgB7KKkIBGIEZip4lNMz60xRy4OKT1/7IjJYtjEvT3P22Q4UNklO68kPH/xO1aDPmE43tlw9jsVdeNlnHATR6vfWbbT1T4ysChJ5MnLlC7GDCASwIbJ3hRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294489; c=relaxed/simple;
	bh=o043vB0nEdY6KeO3hY529DM5oKPHJ7yYdHTHN0FTD4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0ViJ5SSMwcN1AG2LGeDGzKa7mU3WfHBHwCUeqdZ21w56vvyZnQys45/76EiCMccySiwndJSPmADsSpSUip0U1cwrSPWmOoMNJl1AMzb018EXuJVrq9Tr97kBdqSg0KrPZM6C1GdbPoVIFshl/4nEOwyT+1yce9PVdDLOSImovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=m7B31nOY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ckb0ObfG; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 919CC140002E;
	Sun,  7 Sep 2025 21:21:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 07 Sep 2025 21:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294486; x=
	1757380886; bh=i2fSL7FZl4IrRcqRg9Av1sKqTFCfIV6J8l4HksJ8U3I=; b=m
	7B31nOYiGpUueddbEtaTbBFbav6qNI4LO8rTRAPctjaBOruSjKdb6Uch0oSoxDuA
	qSV/QhqA73b5IOxp8cdER7mYZFcm7bGMxkUNSX25nhwtaQjG+cbm+d7UyntpU123
	rC2ML1WVeIZVgCC4ln/COqb3KwJUijHEFFvBCQ3F2bk3UN7AC62STbzwFG0Bv+l3
	o1NfpQTZU80MG3vk63J36WUQGc0Lyw5gFymgIUYH95DS8zS+8WPCtebkXvsGFHNH
	ET48Gx45AzgIggf8QN88iHEMT4/s/GClxEDbX9qOAvPJZEI31gOCzS70Ls877Ru1
	trvDiAzlN25QiSYkh2Kew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294486; x=1757380886; bh=i
	2fSL7FZl4IrRcqRg9Av1sKqTFCfIV6J8l4HksJ8U3I=; b=ckb0ObfG0jxnwcpAO
	17wFfCOoKMKMpM5kPaPo9RTNs4FVDdh/Ppf1LEXxgq12t16yMaN1m63w3QcPLisB
	55/hGWvRZrgUFkw6avSQ1F1FXFzJ8I0s5ozcK5MadU4p0Ef7rx6FcNeS7a2eSiZL
	N+dGvX91GjgAVyQUSDsM1jaW/fY+dbfJcD1lafhOh7M+gWec4GC9l/ZGQJBLc3uG
	g55h8yhk3uKFiL8MAapyJ5Fdi8wICsDUNHlmrbTVdHCB15AKPG3homDB2IxXcGl5
	zgPAt4pOApT9NoUK6mwLiEJ//YxKFKA+egDWbKGCdooZCoHF00D8LQaf1Y96H9UD
	ovzdA==
X-ME-Sender: <xms:li--aFh5edcEcl6J1FxQgdM86cbH1TFahKDqa7HV2MLbyL0DYgcq4Q>
    <xme:li--aC84pPjRg-M5Mi8JiX5wINrQDIgqZYsejUvtLr-Zp7AvNjk_T5lIgHNqfLLA-
    YUXYP30NQW_vs2hmEs>
X-ME-Received: <xmr:li--aHARUpNPcclhXjREc7XEy-p1yJ3bRwiOpmZY-i6_VHtZ6CqWvw6bqGx-f8cXk_2_6NPhmCZhjYQDOgp67sA7nEaIIfAgS7-vS8_dcb8>
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
X-ME-Proxy: <xmx:li--aHK_cISkLtKfONbd3lA5uIrgiyThLY2XhexF9usqneCLKJjZZQ>
    <xmx:li--aCnn67ptyjNSr6BuhZQfCeCmC2R7MMqgcK_EZ2gw13g-UILLeg>
    <xmx:li--aNFKamR1UqzcZMF0w4xug0gGF9B3l5GC1ykb8fCRKj4GjOl6ng>
    <xmx:li--aKEk8F-q3UJ4bh5CPoI661EqN_UHJ05m2uEnO91oqFt0_55uRA>
    <xmx:li--aEnZu1iGT5mgKDNO12By4lvUe4izyruc1Q34hmRi6RYg8QwAc07X>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:25 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] firewire: core: code refactoring to detect both IEEE 1394:1995 IRM and Canon MV5i
Date: Mon,  8 Sep 2025 10:21:06 +0900
Message-ID: <20250908012108.514698-10-o-takashi@sakamocchi.jp>
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

The detection of IEEE 1394:1995 and Canon MV5i is just required within
some of the condition branches. In this case, these check can be
capsulated within these branches.

This commit refactors the checks.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 630e229c9cc2..99aa98f195ba 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -289,15 +289,13 @@ static void bm_work(struct work_struct *work)
 		63, 5, 7, 8, 10, 13, 16, 18, 21, 24, 26, 29, 32, 35, 37, 40
 	};
 	struct fw_card *card __free(card_unref) = from_work(card, work, bm_work.work);
-	struct fw_device *root_device, *irm_device;
+	struct fw_device *root_device;
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation, grace;
 	bool do_reset = false;
 	bool root_device_is_running;
 	bool root_device_is_cmc;
-	bool irm_is_1394_1995_only;
-	bool keep_this_irm;
 
 	lockdep_assert_held(&card->lock);
 
@@ -316,14 +314,6 @@ static void bm_work(struct work_struct *work)
 			atomic_read(&root_device->state) == FW_DEVICE_RUNNING;
 	root_device_is_cmc = root_device && root_device->cmc;
 
-	irm_device = fw_node_get_device(card->irm_node);
-	irm_is_1394_1995_only = irm_device && irm_device->config_rom &&
-			(irm_device->config_rom[2] & 0x000000f0) == 0;
-
-	/* Canon MV5i works unreliably if it is not root node. */
-	keep_this_irm = irm_device && irm_device->config_rom &&
-			irm_device->config_rom[3] >> 8 == CANON_OUI;
-
 	root_id  = root_node->node_id;
 	irm_id   = card->irm_node->node_id;
 	local_id = card->local_node->node_id;
@@ -349,6 +339,9 @@ static void bm_work(struct work_struct *work)
 			cpu_to_be32(0x3f),
 			cpu_to_be32(local_id),
 		};
+		struct fw_device *irm_device = fw_node_get_device(card->irm_node);
+		bool irm_is_1394_1995_only = false;
+		bool keep_this_irm = false;
 		int rcode;
 
 		if (!card->irm_node->link_on) {
@@ -358,6 +351,13 @@ static void bm_work(struct work_struct *work)
 			goto pick_me;
 		}
 
+		if (irm_device && irm_device->config_rom) {
+			irm_is_1394_1995_only = (irm_device->config_rom[2] & 0x000000f0) == 0;
+
+			// Canon MV5i works unreliably if it is not root node.
+			keep_this_irm = irm_device->config_rom[3] >> 8 == CANON_OUI;
+		}
+
 		if (irm_is_1394_1995_only && !keep_this_irm) {
 			new_root_id = local_id;
 			fw_notice(card, "%s, making local node (%02x) root\n",
-- 
2.48.1


