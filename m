Return-Path: <linux-kernel+bounces-782897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B6B32699
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73573685293
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FED2264C4;
	Sat, 23 Aug 2025 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="WdqF83WY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPGwl4Ty"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BE9221FA8
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755918607; cv=none; b=X7B2K4/BKwIkvzN2mlgGlosgbawpMezQ/95wWDd8ZNv4SVRYWTxaAGyL7NdKeSjs0N4NHiZ5WbCDQDf7FyXK2kAJ2cNOtnJcMx5PzRhPxajzKp8rReLCqe8+KkxbDfpFk6xZP4PDOeJab/88fideOBSUZo7TJ71+5KssySWSj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755918607; c=relaxed/simple;
	bh=la1nhYEMWtyPRbgkwvt2StkNx/jLA6+yUilmu8b9U1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmpmOFmB+y1vpSEuZwFhNKOCiX6Rn/bBjInJoBzzORgy8cdpgOOfDo9+zCRZsDuDDT4ZszxQ2eIVKjhAfHpvaGnl3VISPLQykjJpmzVfvovjT7RCy2KpFYgROkZHwtx0GnYC245Tjg0hV+fX8rAM8BuvIr14iORo+gV3JNr0UEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=WdqF83WY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPGwl4Ty; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 401F014000BE;
	Fri, 22 Aug 2025 23:10:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 22 Aug 2025 23:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1755918604; x=
	1756005004; bh=8Aeil4IxTwnNb4l2xQs001wJqzMLlOVlrN2kqxgWY4Y=; b=W
	dqF83WYSquIoG+n5SP8MGMNA4v9DfAZXoQy+3JQhiB02v6TtRMmFgcHSAhn2orl1
	K6fV3wEbKTjzuCIoEXoVVKOF8FUrnAaKEAiaBtNUktbjfzMjSdTWJ0O6o2wMxcrB
	OHIFinagmanlPK1En+VxnoNiMeIhGzWXRGxv+5UhaMzmfgTJL7KW/X0wxB9M7Kzl
	fMGwZt1+zBSaLOFw+a4XmIoqUWakixrj3qVdFkAcl+lmhn7GiOqQyWggA3Qx+7Q3
	sYM4ZkEIbXb1fqE2KBW4OlrigxWhuTDPB0fdb6JV9vbE1/EVhvXB/SQXJZXPkudd
	lGp6J2MJGn1h7hrjWUdZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755918604; x=1756005004; bh=8
	Aeil4IxTwnNb4l2xQs001wJqzMLlOVlrN2kqxgWY4Y=; b=gPGwl4TyvkGP9VpD4
	9KVq3GQM5nEyG1TEierybuAzlBtD+y+BFDFw3SdzZDNWN3Dn+75ajGJq5kiNa/3B
	zZWPIE3j59Bg7SGm4IhYNt7jv0x5cDWDDGxoGTgcy1XGQNuo+2qoC1x9cW2Ez8th
	ub9UznE3qQHfRHiTl5vpk3LUtMPyPH2SoFc2SfVpR71Du5soj84D9jRfI5n9T8SF
	Bc4sDfEAA1as7MOf+GRymVr5GtTGXUvIhkN1/0vs/d/W8TvLKYPVsfkS8FDgjbgs
	XHyte6IRJPk+Ml2epPHd7kpqnbUtsKc+Ia7MX/qSlPkgW9axTunChF8kDLzUwR/T
	OPr5g==
X-ME-Sender: <xms:DDGpaAJV34PY6M-9EThmx6oxYmy9YMa_g1UILqbyXfIVBv4FmyvW9Q>
    <xme:DDGpaJF7FdCOZwsmb8Kk7-IAANveK3MNiQ8tsqUL_smiHjmdCOLqyyBXNI4077Dcf
    UzdoAkFm43BKirtnrg>
X-ME-Received: <xmr:DDGpaCrObSuSzFfXcT2qJNN5Y7pNbGuF7KgcZN21ut54Jx5EQT08x80ccsFVP9V1TvH0AYHZZaIMElUoxZ4vnBqD_W2Luaiv8-2jE1KMWZ9JUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgjeeuvd
    fguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurh
    gtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DDGpaKQ2R3szyrhFD8ec6mKkdyKXJfJNxhPeoNEyPOi3haowVEzIOA>
    <xmx:DDGpaHOTa8HIYtxDv2EZg23jw-g0Owi5aNK-BMMwMHYl5YwrnmD_CQ>
    <xmx:DDGpaFMiyd0CsoEFmUNozlkPd0jeDcDpRyQjouqoGfVKTJE9eIyFlw>
    <xmx:DDGpaPuyyKr2I1x7B8ILGp0HAAXuMpBosYNbJFSjAFIA5wFV0mcjdg>
    <xmx:DDGpaMMlm4V5Q_AEDbP8TECATIYcVd5_2gr7SQp7cWsrf-JDHsAVoQeo>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 23:10:02 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] firewire: ohci: remove module-local workqueue
Date: Sat, 23 Aug 2025 12:09:54 +0900
Message-ID: <20250823030954.268412-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823030954.268412-1-o-takashi@sakamocchi.jp>
References: <20250823030954.268412-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now module-local workqueue has been replaced by a threaded IRQ handler.

This commit removes the workqueue and the associated work item
accordingly.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 5b16286280e0..40851b120615 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -228,13 +228,10 @@ struct fw_ohci {
 
 	__le32    *self_id;
 	dma_addr_t self_id_bus;
-	struct work_struct bus_reset_work;
 
 	u32 self_id_buffer[512];
 };
 
-static struct workqueue_struct *selfid_workqueue;
-
 static inline struct fw_ohci *fw_ohci(struct fw_card *card)
 {
 	return container_of(card, struct fw_ohci, card);
@@ -3512,8 +3509,6 @@ static int pci_probe(struct pci_dev *dev,
 	spin_lock_init(&ohci->lock);
 	mutex_init(&ohci->phy_reg_mutex);
 
-	INIT_WORK(&ohci->bus_reset_work, bus_reset_work);
-
 	if (!(pci_resource_flags(dev, 0) & IORESOURCE_MEM) ||
 	    pci_resource_len(dev, 0) < OHCI1394_REGISTER_SIZE) {
 		ohci_err(ohci, "invalid MMIO resource\n");
@@ -3668,7 +3663,6 @@ static void pci_remove(struct pci_dev *dev)
 		reg_write(ohci, OHCI1394_IntMaskClear, ~0);
 		flush_writes(ohci);
 	}
-	cancel_work_sync(&ohci->bus_reset_work);
 	fw_core_remove_card(&ohci->card);
 
 	/*
@@ -3741,17 +3735,12 @@ static struct pci_driver fw_ohci_pci_driver = {
 
 static int __init fw_ohci_init(void)
 {
-	selfid_workqueue = alloc_workqueue(KBUILD_MODNAME, WQ_MEM_RECLAIM, 0);
-	if (!selfid_workqueue)
-		return -ENOMEM;
-
 	return pci_register_driver(&fw_ohci_pci_driver);
 }
 
 static void __exit fw_ohci_cleanup(void)
 {
 	pci_unregister_driver(&fw_ohci_pci_driver);
-	destroy_workqueue(selfid_workqueue);
 }
 
 module_init(fw_ohci_init);
-- 
2.48.1


