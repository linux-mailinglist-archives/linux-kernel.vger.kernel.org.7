Return-Path: <linux-kernel+bounces-804932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77818B4820E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3340F3C00E1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FF223DDF;
	Mon,  8 Sep 2025 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Fb/14rQt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f/KFz+JV"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFF22068F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294491; cv=none; b=BUh08CYhUTUlopHtl8PAQ7WL7LUwAEA12zjVnvSaV+RYQS3j5lxbBUNYuKrAL4TGXocigi6/IIk9GIEo8t/M7wIbdXTtCF+YmAvhK9LZwRmCXIkUZAToRcb/fVeQbrxP/DoJmcEz0YOvp1asg509XrX+Kxm4f9tYmS5BhXPeo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294491; c=relaxed/simple;
	bh=a1AyLT7I4XXLIPIgADTKrxLpHqie4VNbgm3DilVFebM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DoJmoUPPpRrgcwNKT3msCQwVEtnJ6c3jpc+dWqY4PKuBQptEXWuxrxEgrKur57cX6+V8xR4SPwrGJLZhVe6NYBZ9UST5Rjh31riwXf7Nm6SSALoG+LCuoRd2FIbVJAK/6m6B6X4WExK8f/KY4HX63ZHJkTsQuATikk+vRe6EtK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Fb/14rQt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f/KFz+JV; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 46959EC004E;
	Sun,  7 Sep 2025 21:21:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 07 Sep 2025 21:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294489; x=
	1757380889; bh=tDcax/H5j3jJmh1j7DVnANT3twhs5JmjfUedN9rNnbE=; b=F
	b/14rQtFpCxKN91ZDbhRnW6H4tGR2/oHlbjoiCYvM06Tqpa/O0fvkrHSOcKW+EJL
	a6FhylUvzzTklWx1kW5+nl+14sP7r4xvty6tXfY3II8EK2lSTAxAoqcWpF9DsDJt
	1zClwHMd3lAxEXCASIvJ7wwiKh9PraEVCp+lD24N6QW56l9/lW+/C4O9tMaZyqYj
	K3Kbsd8ocPlAY6cYZALzOPAj2hcWLZxjnyN9m/o1oMpWI2Rc/KNLnv5ZzZpPu6y6
	gLUs0c/+z377tpYMfpg+CZ44Z/uz650TLa316iC4aU4R57no7bgC98j3JYZ/1P03
	jQ7PJhDKQmLQjOvvMiTsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294489; x=1757380889; bh=t
	Dcax/H5j3jJmh1j7DVnANT3twhs5JmjfUedN9rNnbE=; b=f/KFz+JVF6X8XZDYm
	UFcLLfu/c+X2LPenQUM+/fbA2mvB8J/sd+zr6yxJHUbRoNP3NIL0bi5Hggsncv9R
	vkqr7KComwyk318ugz0qoJDFPGVW/O3MG1naX55b5cEmUufP37vuzTW93ZoN9PrE
	GHLR6bePEznp8qp9iwLSZYvr4ivqezxnI0P4YQ8W3MnRNToj8MlrDHQ5shmn1z1d
	tJeNIIOZhnNdm2jWzWKH1vO3q82lxLtGRbd33Sz9y3e1Cftkz065bkGlPC7VWE+B
	fyNEk9emF0h0k5TJXsEGfUjzG3d1puldSSy8UKo/QUY2P5fXYpG90fCDgPa7a9OD
	cRn2g==
X-ME-Sender: <xms:mS--aJ42iuuTvMP0mVQr_bV3SG5sXWV19Fq1MKvSifzSyyfz8CkCZA>
    <xme:mS--aP2yWb5_2Yhre5bHVE701Pg2uyFp3tRzicQ0z5oWP3-PaeOCkSc5rGZYMHVw7
    xcuNRCwb6EtKunZZi8>
X-ME-Received: <xmr:mS--aCZv1KecHYXHxp38sek_WaO3jvzBHFn8c5I7x8bfOyB2-25-w5R8x4vXPzEsP1BjWC9A6Vbwlh22tPjYRfq5L6jIwSA0VB7WlSbuDWM>
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
X-ME-Proxy: <xmx:mS--aPAp7Jdd-O1VCWz2Pxvyzd0dPjh88xsdkkZ48OtGe2M64PItGA>
    <xmx:mS--aM9yTVjKued0NiHhC_uClcS6KLxy_iN7iIcRvfJcJUdM3ojqcw>
    <xmx:mS--aH_kcbuKbhFn38uvsdnplPOnx0T8g8F0gwUJMeUSLk2QY9Vkbg>
    <xmx:mS--aLfnptIzRzPoVPeMuSFMGmYR4BP5a5XDcwwzRH0RCUscwDm3LQ>
    <xmx:mS--aD-ByMyeYoKilfkSud2GpMFo5bI2ghiAV8eyu2M1X7eF67-zV5Un>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:28 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] firewire: core: code refactoring whether root node is cycle master capable
Date: Mon,  8 Sep 2025 10:21:08 +0900
Message-ID: <20250908012108.514698-12-o-takashi@sakamocchi.jp>
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

The check of cycle master capability in root node is currently just in a
condition branch. In this case, the required variable should be within the
branch.

This commit is just for the purpose.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index b430a70a7eeb..474d8066e090 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -289,12 +289,10 @@ static void bm_work(struct work_struct *work)
 		63, 5, 7, 8, 10, 13, 16, 18, 21, 24, 26, 29, 32, 35, 37, 40
 	};
 	struct fw_card *card __free(card_unref) = from_work(card, work, bm_work.work);
-	struct fw_device *root_device;
 	struct fw_node *root_node __free(node_unref) = NULL;
 	int root_id, new_root_id, irm_id, local_id;
 	int expected_gap_count, generation, grace;
 	bool do_reset = false;
-	bool root_device_is_cmc;
 
 	lockdep_assert_held(&card->lock);
 
@@ -308,8 +306,6 @@ static void bm_work(struct work_struct *work)
 	generation = card->generation;
 
 	root_node = fw_node_get(card->root_node);
-	root_device = fw_node_get_device(root_node);
-	root_device_is_cmc = root_device && root_device->cmc;
 
 	root_id  = root_node->node_id;
 	irm_id   = card->irm_node->node_id;
@@ -519,9 +515,11 @@ static void bm_work(struct work_struct *work)
 		reset_bus(card, card_gap_count != 0);
 		/* Will allocate broadcast channel after the reset. */
 	} else {
+		struct fw_device *root_device = fw_node_get_device(root_node);
+
 		spin_unlock_irq(&card->lock);
 
-		if (root_device_is_cmc) {
+		if (root_device && root_device->cmc) {
 			// Make sure that the cycle master sends cycle start packets.
 			__be32 data = cpu_to_be32(CSR_STATE_BIT_CMSTR);
 			int rcode = fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
-- 
2.48.1


