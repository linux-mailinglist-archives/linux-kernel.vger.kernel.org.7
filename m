Return-Path: <linux-kernel+bounces-896260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C1DC4FFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE96134D368
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965002BFC73;
	Tue, 11 Nov 2025 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="MoI7HoCT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MtoCyJI5"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B1525D527
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762900722; cv=none; b=nD8hGTmUALq4oXCzKBe5y7rRy+qCDt1z0p6yV+KfE7+WN+/3kV07ICtIVIGQni+rckcBic2VCiz1CN2SBS4QqjUEXRErh4nLzjJhy//rWc6/ijkfC9Ix2LSeaPKc6xQhIKyIgsqz/F0nk+/HIcaZNd2TfU645qY29fGiZN5x1yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762900722; c=relaxed/simple;
	bh=YYCfSsE259vSkdsYGJYf8k7hP/aHFxs4DXAxcpUfxYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtmkHgCUVsdcUmJnckhm+kfYVQCm+mHuIjMBJq+oJQhfSgNcMOCFfmpuWk/njdRLkbN1ai7k9vUqfSC5C5GbjYMRLK6siyg115eihEPAg4sXsWx7eldy5+BlB4piCAf4x1yPzSAhWooJmRnMKgoUV4dZb2pw13kiT/m0nluMLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=MoI7HoCT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MtoCyJI5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2D514EC0196;
	Tue, 11 Nov 2025 17:38:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 11 Nov 2025 17:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1762900718; x=1762987118; bh=kxyRhG8c4D
	QThr/aSewpp16TI6ayZhIqP+Sg2TBU4pk=; b=MoI7HoCTyNmtmsoGfgshL+et6l
	98l4F6dlQC7YWu/qWoM0vL2KKO6vk3dPo/b+oel7AKDBDRrNTcqW8OszpIRU90EU
	bUqtYcqBDIhEXbnJTJbTM7V/c1gXegXrkWwl5kUKX/zCt8v/2aI6GR8mPpgT6rck
	uq9BReFf6UIdk9LFfQP5yH/rG49FTL7rd5VSB2D7QlZZpWjyVoGqs/xgM4/i3+l4
	6JG+5LN2t5cvUf1w04NvpaMc2MOTdNr7Rv8b6iAimE+zK5dggU8R2JgZ5dTLbW4x
	DFh5QX3Qiz8XVR4XKRF1eZemCTAKFskZvgdN12GsrzEfmrSCwT6HKZQKiJ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762900718; x=1762987118; bh=kxyRhG8c4DQThr/aSewpp16TI6ayZhIqP+S
	g2TBU4pk=; b=MtoCyJI5G3ZQzcD0fPvKDcy0hgvjOJ5CGEer40iLoEdMp2NoidD
	PZsLHuUqHsnNCBI/6YsGRY/CRm4IOjnFxa/I8glRgdjQS2WQTomYJJny8Rb0rBOS
	Go9YJ3kK/afKGp1pTxcQvxnSC6pQE15YkCKU6wpBe8xhiHk3RZ07DzIIJTJW9dtu
	ro94Szd69oU+EaQJZKJAEW/H83oIIPJ0Wl7og0obuT1lV/qx9SDPqJRNOvrLgXMY
	cuK476khkynl/OctZIalqvS4y8DEGKIYF6qoH2ZMJGpbkOHTFsINT2zIdG4rFs7t
	/kI8ywZDXnDXDwbYlURNK29jlEXeg13ekBw==
X-ME-Sender: <xms:7boTaRcvYts56s8SdHel3I4hBfyw6UqVrM7Gri9oVzZTBAlQtfK91w>
    <xme:7boTadL_KiKrw9I7Yrk7geifiv3GJOeijdm6f11_nCF1rif5CT-C-VDEypToFCikl
    8k0DDFRuzE85IMbX1ks-LmakGEY-0uPOWkPDBz2JUNWCKx6fy0nULc>
X-ME-Received: <xmr:7boTaSEWhAnzgbqrgOGyq0yJyUzJoUglnEUf03oenUCpRMY9x5Gg1poiazbe2TgZPSLLFPQ4WNrYLvynzlecY552wACr2x8OLlmONTSw3vj5MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffveekud
    fhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrg
    hmohgttghhihdrjhhppdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvg
    hfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7boTaXr9Ilskyo6FCxB-KgauiTCImU6Tbb4rlZFca9_kvnpGUakvZg>
    <xmx:7boTabQ7rpEKZTSRej4vJHxJ-e0626joCTiU0-TW9cdyOQ3OeJ86fQ>
    <xmx:7boTaUMblWQD6od3CyAoVZ17DK9f-0HQDOWRSTcpnu-4AqIqGm7APQ>
    <xmx:7boTaePVPDoQhkZEGg2aNq1scxRsUeQLU6vtWGBXZkhjjjjcynuZaw>
    <xmx:7roTaazfQoMoIx6VQloXenXQ6D_BQbHLjaS15hVKZBy_XNRTJu9yVAHT>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 17:38:37 -0500 (EST)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: abort pending transactions at card removal
Date: Wed, 12 Nov 2025 07:38:34 +0900
Message-ID: <20251111223834.311287-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IEEE 1394 defines the split, concatenated, and unified transaction.
To support the split transaction, core function uses linked list to
maintain the transactions waiting for acknowledge packet. After clearing
sources of hardware interrupts, the acknowledge packet is no longer
handled, therefore it is required to abort the pending transactions.

This commit executes callback with RCODE_CANCELLED for the pending
transactions at card removal.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-card.c        |  1 +
 drivers/firewire/core-transaction.c | 28 ++++++++++++++++++++++++++++
 drivers/firewire/core.h             |  2 ++
 drivers/firewire/ohci.c             |  5 -----
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/core-card.c b/drivers/firewire/core-card.c
index 65bd9db996c0..9869ea3fd9fc 100644
--- a/drivers/firewire/core-card.c
+++ b/drivers/firewire/core-card.c
@@ -790,6 +790,7 @@ void fw_core_remove_card(struct fw_card *card)
 	drain_workqueue(card->isoc_wq);
 	drain_workqueue(card->async_wq);
 	card->driver->disable(card);
+	fw_cancel_pending_transactions(card);
 
 	scoped_guard(spinlock_irqsave, &card->lock)
 		fw_destroy_nodes(card);
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index e80791d6d46b..fe96429ba395 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -51,6 +51,34 @@ static void remove_transaction_entry(struct fw_card *card, struct fw_transaction
 	card->transactions.tlabel_mask &= ~(1ULL << entry->tlabel);
 }
 
+// Must be called without holding card->transactions.lock.
+void fw_cancel_pending_transactions(struct fw_card *card)
+{
+	struct fw_transaction *t, *tmp;
+	LIST_HEAD(pending_list);
+
+	// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
+	// local destination never runs in any type of IRQ context.
+	scoped_guard(spinlock_irqsave, &card->transactions.lock) {
+		list_for_each_entry_safe(t, tmp, &card->transactions.list, link) {
+			if (try_cancel_split_timeout(t))
+				list_move(&t->link, &pending_list);
+		}
+	}
+
+	list_for_each_entry_safe(t, tmp, &pending_list, link) {
+		list_del(&t->link);
+
+		if (!t->with_tstamp) {
+			t->callback.without_tstamp(card, RCODE_CANCELLED, NULL, 0,
+						   t->callback_data);
+		} else {
+			t->callback.with_tstamp(card, RCODE_CANCELLED, t->packet.timestamp, 0,
+						NULL, 0, t->callback_data);
+		}
+	}
+}
+
 // card->transactions.lock must be acquired in advance.
 #define find_and_pop_transaction_entry(card, condition)			\
 ({									\
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 903812b6bb3f..41fb39d9a4e6 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -287,6 +287,8 @@ void fw_fill_response(struct fw_packet *response, u32 *request_header,
 void fw_request_get(struct fw_request *request);
 void fw_request_put(struct fw_request *request);
 
+void fw_cancel_pending_transactions(struct fw_card *card);
+
 // Convert the value of IEEE 1394 CYCLE_TIME register to the format of timeStamp field in
 // descriptors of 1394 OHCI.
 static inline u32 cycle_time_to_ohci_tstamp(u32 tstamp)
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 0625d11dbd74..e3e78dc42530 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3719,11 +3719,6 @@ static void pci_remove(struct pci_dev *dev)
 
 	fw_core_remove_card(&ohci->card);
 
-	/*
-	 * FIXME: Fail all pending packets here, now that the upper
-	 * layers can't queue any more.
-	 */
-
 	software_reset(ohci);
 
 	irq = pci_irq_vector(dev, 0);
-- 
2.51.0


