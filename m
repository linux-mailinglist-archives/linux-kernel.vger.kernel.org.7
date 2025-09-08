Return-Path: <linux-kernel+bounces-804923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70172B481F9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BDD3BB5C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349F1D63D8;
	Mon,  8 Sep 2025 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="sjs+Rkr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dga+qsR3"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4B219F13F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294479; cv=none; b=QaeWiPA1VKsYsy/JhmbEU/neKclw8sgkZYqCtib1sKwUPut7fFIXa2gp2ctI4irG06ocr+Mm3B7uk/X9CaSeNgTXnJUkyHUvV8NR+k7lpwAEevVIatOZZV1CBUOSFdt1QwTxvJEs5WwGYS9NQ/EkY1Wo3SDZ6IZFbA2fSZPqhHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294479; c=relaxed/simple;
	bh=WAQYN5+cHgOSWk2CN7pDhjYQd0Ix42e4/wJ2L5ZVpyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er9x9Nxfxm8KhbL3gCIqcnjBf34hDtDFzqy87RzaoXkH1R+Ul+kea0/6RD/NqY3T20GW+uZGkM6KxJJZdJhT0FEMisnfRxbrJw7Saoz1VQejbgX5G5D+uarKW2EZJbTSj2dvvm768kMNuWTG3ZqeUP/pEdr/86Jqj0yS1SrAO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=sjs+Rkr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dga+qsR3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8C761400013;
	Sun,  7 Sep 2025 21:21:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 07 Sep 2025 21:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294476; x=
	1757380876; bh=ORliYewnYZlo6BK2CHJ6vPurP1L4VVoWaqONrnniiRY=; b=s
	js+Rkr8KpUnKs2CXhaBwSbjFNt8Bkl/WIl2TxNMgQIsyPBWvNIDXRmlPvG7ZEKMH
	CCSLAt3dTaCpXOyXySo8SFAI82bmgOoKQmY1RbCNqyh+7GA9xu8NNTMUUQe8i8Ru
	ylNfJKrHFWQ6wczhlT8iE2IK0KAlwNS+z/3t+FwzRQUwV+4gi0ZKkjw4rQaXujz1
	7eDwTvwDMDu7+7vAC8C1evvRk1h/14e/9kAcSVnScHP2cR8cp8QbzwW39/D4AUEM
	ToGqXPch4WQq6dg5KjsylYDtHCLGYlGvogh1Qa/JS4AtcvA/QMax8U9jZtKh3GQh
	ryuSMUcimFXR5rBxYNfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294476; x=1757380876; bh=O
	RliYewnYZlo6BK2CHJ6vPurP1L4VVoWaqONrnniiRY=; b=dga+qsR3Op+h47ujO
	JY77MDX269onrIQo3h7HDSnuaErlhWZwjWTmqZ5v00ypGWClNtPmPN4MKc3EvvmJ
	94xWjMFKAE3zsI1zwDZlMwFo+djgOKNS0oJg/E/ttmqFDBGvr5+CPOBHvjt0u0kb
	C5VAAMLhJgDJzk8oDkvfFKdKyBsV/LWl90mwkjMOqwXjO8aStorU8zgFlvrEkFkQ
	0LhYNiR531Jgsy21wvCvm3o7iNeJzfxdgeEFcl4L2Ngz7fn4jYCKNr7wlxlIQXFJ
	y1GMfaT1bnaasWhslnhiFR2B7JzgBCCB5h8f+xNIp7OgxPZo+mx2g6vKTWdspnwh
	Qi9dQ==
X-ME-Sender: <xms:jC--aOv58rvl02N-OQ5FU-ueD9DxB3gYon37DiOF28__skhJ69Q74Q>
    <xme:jC--aMYIaGuVB_ldHG5GKO65Ktz_VqPmFdJKu0vCLl8isTXE4bmh47BeNKle-0yDI
    KZtOX6GImRGCHtLLeo>
X-ME-Received: <xmr:jC--aLuLTZsvrFFxfAmX6WmSvCs3v5pw7AInyOFLbAUfn9TTJE_0UKoL_ReQL-vUIB7DrUMSklbv_T1fbzP-68lglSAV-mZ-QOC1GH56RkU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedulecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:jC--aGEzh6G7ScRWCBtW4zvjiaIsqOfCfdtz-V5PyMWWkg_fcY2dug>
    <xmx:jC--aOz992s_f_BDyz0gN6iqX1X8_Pd4sZ0kjcKiYJ4N5SVHO6Jezg>
    <xmx:jC--aNgtx7jIsD5txFMhZmTvCfAyR1LS558iaTwor7fs6vIJ5ahZUA>
    <xmx:jC--aJwY6RuKFr40t7J3SjktE7NmOVDh4skhJlN4-rUmNASh0B7USw>
    <xmx:jC--aLSytRqsPntMcSdR_5cQPyc1XHEDCHa2MiIfHRymjyA2AeUx8UcE>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:15 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] firewire: core: utilize cleanup function to release workqueue in error path
Date: Mon,  8 Sep 2025 10:20:59 +0900
Message-ID: <20250908012108.514698-3-o-takashi@sakamocchi.jp>
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

The helper macro, retain_and_null_ptr(), introduced by a commit
092d00ead733 ("cleanup: Provide retain_and_null_ptr()") in v6.16 kernel,
is useful in the error path to release the part of structure member.

This commit uses the relatively new function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c | 40 ++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index aae774e7a5c3..d128c7a8bf5f 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -570,9 +570,13 @@ void fw_card_initialize(struct fw_card *card,
 }
 EXPORT_SYMBOL(fw_card_initialize);
 
+DEFINE_FREE(workqueue_destroy, struct workqueue_struct *, if (_T) destroy_workqueue(_T))
+
 int fw_card_add(struct fw_card *card, u32 max_receive, u32 link_speed, u64 guid,
 		unsigned int supported_isoc_contexts)
 {
+	struct workqueue_struct *isoc_wq __free(workqueue_destroy) = NULL;
+	struct workqueue_struct *async_wq __free(workqueue_destroy) = NULL;
 	int ret;
 
 	// This workqueue should be:
@@ -587,10 +591,10 @@ int fw_card_add(struct fw_card *card, u32 max_receive, u32 link_speed, u64 guid,
 	//  * == WQ_SYSFS		Parameters are available via sysfs.
 	//  * max_active == n_it + n_ir	A hardIRQ could notify events for multiple isochronous
 	//				contexts if they are scheduled to the same cycle.
-	card->isoc_wq = alloc_workqueue("firewire-isoc-card%u",
-					WQ_UNBOUND | WQ_FREEZABLE | WQ_HIGHPRI | WQ_SYSFS,
-					supported_isoc_contexts, card->index);
-	if (!card->isoc_wq)
+	isoc_wq = alloc_workqueue("firewire-isoc-card%u",
+				  WQ_UNBOUND | WQ_FREEZABLE | WQ_HIGHPRI | WQ_SYSFS,
+				  supported_isoc_contexts, card->index);
+	if (!isoc_wq)
 		return -ENOMEM;
 
 	// This workqueue should be:
@@ -602,14 +606,14 @@ int fw_card_add(struct fw_card *card, u32 max_receive, u32 link_speed, u64 guid,
 	//  * == WQ_SYSFS		Parameters are available via sysfs.
 	//  * max_active == 4		A hardIRQ could notify events for a pair of requests and
 	//				response AR/AT contexts.
-	card->async_wq = alloc_workqueue("firewire-async-card%u",
-					 WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_HIGHPRI | WQ_SYSFS,
-					 4, card->index);
-	if (!card->async_wq) {
-		ret = -ENOMEM;
-		goto err_isoc;
-	}
+	async_wq = alloc_workqueue("firewire-async-card%u",
+				   WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_HIGHPRI | WQ_SYSFS,
+				   4, card->index);
+	if (!async_wq)
+		return -ENOMEM;
 
+	card->isoc_wq = isoc_wq;
+	card->async_wq = async_wq;
 	card->max_receive = max_receive;
 	card->link_speed = link_speed;
 	card->guid = guid;
@@ -617,18 +621,18 @@ int fw_card_add(struct fw_card *card, u32 max_receive, u32 link_speed, u64 guid,
 	scoped_guard(mutex, &card_mutex) {
 		generate_config_rom(card, tmp_config_rom);
 		ret = card->driver->enable(card, tmp_config_rom, config_rom_length);
-		if (ret < 0)
-			goto err_async;
+		if (ret < 0) {
+			card->isoc_wq = NULL;
+			card->async_wq = NULL;
+			return ret;
+		}
+		retain_and_null_ptr(isoc_wq);
+		retain_and_null_ptr(async_wq);
 
 		list_add_tail(&card->link, &card_list);
 	}
 
 	return 0;
-err_async:
-	destroy_workqueue(card->async_wq);
-err_isoc:
-	destroy_workqueue(card->isoc_wq);
-	return ret;
 }
 EXPORT_SYMBOL(fw_card_add);
 
-- 
2.48.1


