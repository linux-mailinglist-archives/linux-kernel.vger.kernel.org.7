Return-Path: <linux-kernel+bounces-804928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEB0B4820A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0034B1690E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB3B214A93;
	Mon,  8 Sep 2025 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="YMvdIEpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnfghvmP"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC31FCF41
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294486; cv=none; b=XkvVTSj7IfRDNyMwWFYVZAlOq9T8CI8H+jWD5Ref4hFaNMTkBTkAxtGqKkpKd1n1g8i1k/NuCEwAw1dL7TC0pJ1Xt5qq2TComnp2B6GqW6Yg5QYhbkRTfxzefrLaMUiKp0bcx0ZgeqMaqc1wcDXO3pEWjR/HST26JSvM731+vwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294486; c=relaxed/simple;
	bh=cjOUV30BSaxnY+cJZFkMewTeK9ZEwIEEIzAbj78kSus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHtLMpv+4K30sd8qAeJTz+iL+FwVg5VYYDhCLYa3RP3TtDwLzQcz5XI/hvccOo0MdmhYWXAyHG7qp3x3LrEV11vzBrKyl8CreMpISAw+U/H139bmB6UfuWBhn2U4LfbheCuWgE3hp3kh/uYNOUq/qYU7JAkTYcugzbF6rrbaq2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=YMvdIEpz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnfghvmP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D53CFEC0093;
	Sun,  7 Sep 2025 21:21:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 07 Sep 2025 21:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294483; x=
	1757380883; bh=0N90Rbsw2sPw8qtfBi7whVAKvBSkffqx0sYFg+fnBGA=; b=Y
	MvdIEpzb3KFvEP8Urb7tXDkwlq4JaDP5cGQWHoDLdCW08oVaS3mFkwFceVah55wU
	s1QTGmLi1Qiza7vxl5D4Cmx40Wp1gOZqP4rGCaP5O/6w+AnV/O6llNOybhImIR/U
	+HsJr6mrXv6YK/MC/Odr8B8cLsKqZZUlR6OdNy0Zf1U5osEwPncI/k8593vvBmJ6
	Tg89qf1q+kR/mOuTinqjW+u/CzEeYe/DOk5bJbGbY1I0O+JjLOqedVS7RVLUOj2Z
	c8cSevT4VQBAlvU48IUb4cgoaop39NhJJTWsGlHMYtgNAHZnFoeCTl5dZ9bmRO9k
	WGXS6TIv57kQPGWIfa9GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294483; x=1757380883; bh=0
	N90Rbsw2sPw8qtfBi7whVAKvBSkffqx0sYFg+fnBGA=; b=EnfghvmPediAiD8IG
	1s6PQ9Y/qePC05SIUf22/IMezFGu5BBf2nhUcPol0qU0hnAOQ/zr9sko73QKw0UD
	jTtC9WEIcrgRSZQt3gQydz194BobSHDu9LpXjjmzrM+aveTJG54x7PDlThJti+wp
	yOxVwbkiSboF/g7YqjWLvPqLiYPOvT5VMWndFuPwcdh3XZwu6SNwsr3Q/Gh46KD3
	TBHFRg4JRe7oFD/5/cOGcBd4D3vm9PWozYtUACTXJN26NLtrX6eIgfKH+pnInZUR
	FSwmFunytCvzPiSX+vytBYwS/3pnvSBt9jopxn6IpBx0koQikX0ciKpF38f5Pzlz
	DMk9w==
X-ME-Sender: <xms:ky--aKDx8xdFc87jWamkdulC7bKKwy9HWMyDgyQ8fj67HE35BqVhgQ>
    <xme:ky--aNceOsdR-DTd6nQOutajq2aOp3uDKNOPxnhuh0OF2AHX6tOMS8yo6vJgAec4Z
    GdIiVlINOQHSQAqJ-U>
X-ME-Received: <xmr:ky--aPg2QImeVzyk3G0_sXvP91mdiOIVrMaPzuJiYNoZaOH2wvCVEsbg_qCgCzYZkNRRrfuNv_i48HIkb53zbKrbEgmnQZT5TRPa8NPwjWo>
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
X-ME-Proxy: <xmx:ky--aFrq7rmULkWk_Q8fM-_O8Mss2R3TtXSbozOYY2RlbM-lqrzK7g>
    <xmx:ky--aPGbEJpudtyLqHQCk_Q2TTpr7MyiqGr9jFIi0XSoBu7T88I1bg>
    <xmx:ky--aPnz1nmZ5BJvSdk2JhnBpnZ6z1bvz0QYuRW3XccmQpJvPYo4Pw>
    <xmx:ky--aKkaDsAC2IMi8l6ADUoxsWqUmp_Qo5j2WORQA-lnR5IT4TLvfA>
    <xmx:ky--aNHZNi9eef4lNplN-eOg1WStHbktw_ZfB7JIJtdsMSFJ_7G5Ye7k>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] firewire: core: code refactoring to evaluate transaction result to CSR_BUS_MANAGER_ID
Date: Mon,  8 Sep 2025 10:21:04 +0900
Message-ID: <20250908012108.514698-8-o-takashi@sakamocchi.jp>
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

The call of bm_work should be done after acquiring spin lock of fw_card.
For asynchronous transaction, the lock should be released temporarily
due to event waiting.

A commit 27310d561622 ("firewire: core: use guard macro to maintain
properties of fw_card") applied scoped_guard() to the bm_work function,
however it looks hard to follow to the control flow.

This commit refactors the spin lock acquisition after the transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index b98797e4f1d4..e1a7a151b109 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -291,7 +291,7 @@ static void bm_work(struct work_struct *work)
 	struct fw_card *card __free(card_unref) = from_work(card, work, bm_work.work);
 	struct fw_device *root_device, *irm_device;
 	struct fw_node *root_node __free(node_unref) = NULL;
-	int root_id, new_root_id, irm_id, bm_id, local_id;
+	int root_id, new_root_id, irm_id, local_id;
 	int gap_count, generation, grace;
 	bool do_reset = false;
 	bool root_device_is_running;
@@ -376,19 +376,22 @@ static void bm_work(struct work_struct *work)
 		if (rcode == RCODE_GENERATION)
 			return;
 
-		bm_id = be32_to_cpu(data[0]);
+		spin_lock_irq(&card->lock);
 
-		scoped_guard(spinlock_irq, &card->lock) {
-			if (rcode == RCODE_COMPLETE && generation == card->generation)
-				card->bm_node_id =
-				    bm_id == 0x3f ? local_id : 0xffc0 | bm_id;
-		}
+		if (rcode == RCODE_COMPLETE) {
+			int bm_id = be32_to_cpu(data[0]);
 
-		if (rcode == RCODE_COMPLETE && bm_id != 0x3f) {
-			/* Somebody else is BM.  Only act as IRM. */
-			if (local_id == irm_id)
-				allocate_broadcast_channel(card, generation);
-			return;
+			if (generation == card->generation)
+				card->bm_node_id = bm_id == 0x3f ? local_id : 0xffc0 | bm_id;
+
+			if (bm_id != 0x3f) {
+				spin_unlock_irq(&card->lock);
+
+				// Somebody else is BM.  Only act as IRM.
+				if (local_id == irm_id)
+					allocate_broadcast_channel(card, generation);
+				return;
+			}
 		}
 
 		if (rcode == RCODE_SEND_ERROR) {
@@ -397,12 +400,11 @@ static void bm_work(struct work_struct *work)
 			 * some local problem.  Let's try again later and hope
 			 * that the problem has gone away by then.
 			 */
+			spin_unlock_irq(&card->lock);
 			fw_schedule_bm_work(card, DIV_ROUND_UP(HZ, 8));
 			return;
 		}
 
-		spin_lock_irq(&card->lock);
-
 		if (rcode != RCODE_COMPLETE && !keep_this_irm) {
 			/*
 			 * The lock request failed, maybe the IRM
-- 
2.48.1


