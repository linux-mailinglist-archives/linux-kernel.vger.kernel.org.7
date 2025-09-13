Return-Path: <linux-kernel+bounces-815157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E06B56060
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD34482531
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E782EC564;
	Sat, 13 Sep 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="UCW+UtA8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O80pICcH"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF242EC54D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757761066; cv=none; b=UZ++z5/7bFIAi4422345+zTZaiAgORIR23eHF9Y1MuSEIYFwh5OSS3oOUVlQQG7asYjzMyRDnfLT3uJQXhDQcj3B4rl1SPYkHs6YdNb9IC0+YMPWDYVkKMgmGiWDbvLHE+BCqGhWAEoUY+TOKTcleDKA+welCVHW4Ac8FT5VfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757761066; c=relaxed/simple;
	bh=N3K2z0lFSmLL2EDPTJw7HX4T0OR1Jvhhsdq1KQtG1sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYKwvLgADCXahUMyhe+CufAz55nZvcobTmgJoCbDeLFc2w/nAJ+Czr7It2rfRY1Kwh5NhSsPlDqg3BLjx2Wq5IG4BkrE8R35IGuMMQ0woFwKZDZj8TQEP+UWQvBx7UMDTT99pFTeREqSr6GBI+IIbLQB//fI/uPUQRocXTMrhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=UCW+UtA8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O80pICcH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 84BD1EC018B;
	Sat, 13 Sep 2025 06:57:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 13 Sep 2025 06:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757761063; x=
	1757847463; bh=6WxZ6ngxHySIOsCplz04PSONOpKSebdtsflfhWY8CVQ=; b=U
	CW+UtA8Xau9Z2ohr/uEdv08MoqPh216jo8/PsX2WG771BNanrUQyolIcqq4UT2uY
	tgCZKkHUtNRqYwRHh0B8S42aFTKIyWROgpweXmirLe3Pq/7+qcenxph75AZax+Da
	sZH15T0Qv53bZeAs6GpKSI1epH+/IurECD9rIHEkYEEUcDpQn/1tXj6epYSKOgYN
	hTrUdH4TE0+lk00plKG61AUVK6yd2HUPo85DEtNh5oPX/uwbA5NodmVv5WCsww4k
	yMPHErdU4dsdPOsyEsE2udSRsYkKhi/VZEaibyG1AkAX1ruEUUCJmZYhwRtIoMJ+
	gS7mzdVOxOrXbA3Ht4wtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757761063; x=1757847463; bh=6
	WxZ6ngxHySIOsCplz04PSONOpKSebdtsflfhWY8CVQ=; b=O80pICcHt4K9ooklN
	UWLQ5UqJJC+/lDvu2CFyttdXJaKV5eLopND92uFmOuYq1jyxiQzdpKb6rr8CI4CW
	YpZyrhOYmSAuRBLKHfH3fMhEbQAM3npEdcku5e68gcqWFDPSfYIwWDIvl1QJRhyj
	y1AwhuwMTQ2QD/3jI2e0Scr9pHr97/gFqYos75dw2KY79l6bs5EZioHSrgn6stWr
	Mr0QeeapTIwz3aBclOZ7z0NRwoI+XK5AADfnkSCxI+6+KCqTtnyuOmSgamHK9CcZ
	SRzxbd+SExvEmHXtDAxyBkhSHZb0AI/bca/IzQhxWkH1nB9rO/tpKmYADJO65q25
	DMbqg==
X-ME-Sender: <xms:J07FaEBxina8NXFmoZ7bac8XYvY-57Ig0bZJblGjApwzps-p0AtDMg>
    <xme:J07FaPc1eKv08xxJfEqQTnJtQC7OhC12Ehk0LwXZJ-Zx5hYP71su12RDcQV9U75eP
    CNGKn3sqtXHx8HarUA>
X-ME-Received: <xmr:J07FaJjP9pEd1eDgMMMPfVBD8P42o8nw_28PIsPwHsi0pWx8ZZ4JuLMeX6SAWa6akUTQWroZOSd1WVNPM9CAlJf9OHRdoIE1kQ0tdP6k3ecECQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefudejgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:J07FaHqmTfBkqBsh4La49tCLtAg4nKehnoTCbdsLsBkoqYpqHG7vIw>
    <xmx:J07FaJF16woWZbvF4L_hfiYmMQtDSTCzNNhYpn1JrL5C5B6d4GS6-g>
    <xmx:J07FaBldC4YfyFj_6W1EdOGZW0Od_Yy_6lBZF-dUtzm4jxqwEi_J2A>
    <xmx:J07FaEmdUbIjOu1jiZn6TSPCR0YrxhKDKPC1FEesgEbdiP1ILTmJyw>
    <xmx:J07FaHFOiKZkQ6MrW9Zt32lOOM1bEnkY2NJi8RwaDwpkElSPHZXniO-j>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Sep 2025 06:57:42 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: use macro expression for not-registered state of BUS_MANAGER_ID
Date: Sat, 13 Sep 2025 19:57:37 +0900
Message-ID: <20250913105737.778038-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250913105737.778038-1-o-takashi@sakamocchi.jp>
References: <20250913105737.778038-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of BUS_MANAGER_ID register has 0x3f when no node_id is
registered. Current implementation uses hard-coded numeric literal but
in the case the macro expression is preferable since it is easy to
distinguish the state from node ID mask.

This commit applies the idea.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 12 ++++++++----
 drivers/firewire/core.h      |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index bf2e7f55b83e..adb90161c4c6 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -327,7 +327,7 @@ static void bm_work(struct work_struct *work)
 		 * next generation.
 		 */
 		__be32 data[2] = {
-			cpu_to_be32(0x3f),
+			cpu_to_be32(BUS_MANAGER_ID_NOT_REGISTERED),
 			cpu_to_be32(local_id),
 		};
 		struct fw_device *irm_device = fw_node_get_device(card->irm_node);
@@ -372,10 +372,14 @@ static void bm_work(struct work_struct *work)
 		if (rcode == RCODE_COMPLETE) {
 			int bm_id = be32_to_cpu(data[0]);
 
-			if (generation == card->generation)
-				card->bm_node_id = bm_id == 0x3f ? local_id : 0xffc0 | bm_id;
+			if (generation == card->generation) {
+				if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED)
+					card->bm_node_id = 0xffc0 & bm_id;
+				else
+					card->bm_node_id = local_id;
+			}
 
-			if (bm_id != 0x3f) {
+			if (bm_id != BUS_MANAGER_ID_NOT_REGISTERED) {
 				spin_unlock_irq(&card->lock);
 
 				// Somebody else is BM.  Only act as IRM.
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 79eb57fd5812..9e68ebf0673d 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -170,6 +170,9 @@ static inline void fw_iso_context_init_work(struct fw_iso_context *ctx, work_fun
 
 /* -topology */
 
+// The initial value of BUS_MANAGER_ID register, to express nothing registered.
+#define BUS_MANAGER_ID_NOT_REGISTERED	0x3f
+
 enum {
 	FW_NODE_CREATED,
 	FW_NODE_UPDATED,
-- 
2.48.1


