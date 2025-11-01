Return-Path: <linux-kernel+bounces-881211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0CC27BA6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02CA188C064
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A342D060B;
	Sat,  1 Nov 2025 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="dpRB9xT/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3OGk3Fwt"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11D2C11DB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761992502; cv=none; b=Frl53rcf7igilTFuTTip5M7NyF/1OxtOagJzxitFi/kGsHW3b18EUpEJCQbs5qrIiiC6mtBUBemrqcZ4jsGl7ofhJEodTRMsvxqY4zpCpX0IrA76TJhKl2M1qmMAWz4S+o8zbrUcWMt6kjCfvJrZkIOCWRxoP/HHreC+ioYd+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761992502; c=relaxed/simple;
	bh=VXvhdCtIF94jIUy9sZM5HOnX/S1loA6RO4drU2W4ZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1V2qThtTm6UxT3vq3+HYXabDh6rImfnShFP4j6BU/OnPGkPI5TSFipXz7qenq91KnisUo//joR/gBBeCkjqXa9nhkaJdf9LpTQo2aFdXlMrObs7eykDCaIhDTXncWO0t80Q6RIrpt39WM952qDpYZXa2D7TYj3tk3uL+9EMAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=dpRB9xT/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3OGk3Fwt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CC33EC00DA;
	Sat,  1 Nov 2025 06:21:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 01 Nov 2025 06:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761992498; x=
	1762078898; bh=VDehe93yxTJXuOHBmVVwaEhZloz0X+dnzSOWWU6PpS0=; b=d
	pRB9xT/th3Z6KGq5FNgfkfDwJ3WHxkIt7OhcjRU15s7Fpchf3iyDXD+VSnJVbizU
	co/SeFl7eG5u7N0IskowZYp5WLBFvdwJvSr8U1ODR9GfUH/ROXluE4t+WfZYxNk8
	pYppYckAb65PL5HBz/4QzBwy4j1C9i9AsGCbJ4nWJj0/otcuwL67XkeVAHkbp9mx
	5OltfhCIAwhGPFNILM8hbg6A52AQss33QGv2V8LMkJxLtbcndTIVp2ZmUiAOD5mE
	BbtHsfQCyTt4s2lkeqMq+Fz0+dBSO0HiHwtbuiM31KRxxojjJragoWc4Jo1ekfrM
	2NITtTE2xFpVfjwJAVSbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761992498; x=1762078898; bh=V
	Dehe93yxTJXuOHBmVVwaEhZloz0X+dnzSOWWU6PpS0=; b=3OGk3FwtFXjnGr/w+
	zxx4x8lHuoJR9EDRb9VOqWqscWa7yuvG60Zl4cbufXgAtatInHkV954PV0ggH0UF
	q6A5fb9Jqgo03AOkJYkXpmjkCn1/viNMlFngw9nYXqzc0cVKKN7jGsfiY1eppJve
	9oWNkqzpkpEe9x9/NKf5J1uBTqLsP9k5lR1tBskvqAU67zCh2z6/WFmT3j/jo7e+
	Yef8VnC1IpGB3G7OLvxQfyKEx4W03UFLYtX4gbHLrDw1v8OM5dtItVGnYjD4e0uE
	T+hamhZxhrj9Px8pEvkyVhy0ajcXDV5aklcIkFMl7N4xKrB6SgaG5VufhnuQ1rXG
	pvVVw==
X-ME-Sender: <xms:Mt8FaZ7sCbtqHB1xpkHUsN-owZnC8_0dOagWNlmEPdDJqF5syOmYhA>
    <xme:Mt8FaU38UdsKQYTdRcYHmfPRrYgyhr2RXHsRkgaZwE774g_ECo6wxOmNfpCMwZ1Os
    1GyqVZa19yvsfgGTOrHBx1S0HPI1LAxhAQJg5Z_r3uNn0ujSWme-_E>
X-ME-Received: <xmr:Mt8FaYAYWFGJR5jz8yGn0Mm2eUcWpBMkm3fhpPtI4PXFs2GMGaZRMrtxWiFSk9nuiUnKUyC4JGpqqxGUKh6MXp4wV7WBCvPOiPt4v4DLcJQMrLI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedvuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Mt8Fae1ZHfxfqSR6I-BIcZuwQAMTOuH2veVvLfM8d2HQAB1rVo_Quw>
    <xmx:Mt8FaavqWv9Fz3Yxxa54fOLEJuQu-d_3Fx3wDkmUX2t-9IolQ5_5TA>
    <xmx:Mt8FaW6EAbr3pkffNGN0-aqOrP8yEA9GDFK7eXURSjI6hIHHBz6A-g>
    <xmx:Mt8FaTI_hj3j0oZJjj_l9btdD8Gm9-WWSGOi8zYDEWn-wrFV_cFEvA>
    <xmx:Mt8Faat8CYe-5aBVKv5dprVZiT_NrgrqoYwh4lmGGsw0rlhOo4DTYPiV>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 06:21:37 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: code refactoring to find and pop transaction entry
Date: Sat,  1 Nov 2025 19:21:31 +0900
Message-ID: <20251101102131.925071-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101102131.925071-1-o-takashi@sakamocchi.jp>
References: <20251101102131.925071-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list operation to find and pop transaction entry appears several
times in transaction implementation, and can be replaced with a helper
functional macro.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 45 ++++++++++++++---------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 8bd79c3f97f2..e80791d6d46b 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -51,28 +51,34 @@ static void remove_transaction_entry(struct fw_card *card, struct fw_transaction
 	card->transactions.tlabel_mask &= ~(1ULL << entry->tlabel);
 }
 
+// card->transactions.lock must be acquired in advance.
+#define find_and_pop_transaction_entry(card, condition)			\
+({									\
+	struct fw_transaction *iter, *t = NULL;				\
+	list_for_each_entry(iter, &card->transactions.list, link) {	\
+		if (condition) {					\
+			t = iter;					\
+			break;						\
+		}							\
+	}								\
+	if (t && try_cancel_split_timeout(t))				\
+		remove_transaction_entry(card, t);			\
+	t;								\
+})
+
 static int close_transaction(struct fw_transaction *transaction, struct fw_card *card, int rcode,
 			     u32 response_tstamp)
 {
-	struct fw_transaction *t = NULL, *iter;
+	struct fw_transaction *t;
 
 	// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
 	// local destination never runs in any type of IRQ context.
 	scoped_guard(spinlock_irqsave, &card->transactions.lock) {
-		list_for_each_entry(iter, &card->transactions.list, link) {
-			if (iter == transaction) {
-				if (try_cancel_split_timeout(iter)) {
-					remove_transaction_entry(card, iter);
-					t = iter;
-				}
-				break;
-			}
-		}
+		t = find_and_pop_transaction_entry(card, iter == transaction);
+		if (!t)
+			return -ENOENT;
 	}
 
-	if (!t)
-		return -ENOENT;
-
 	if (!t->with_tstamp) {
 		t->callback.without_tstamp(card, rcode, NULL, 0, t->callback_data);
 	} else {
@@ -1102,7 +1108,7 @@ EXPORT_SYMBOL(fw_core_handle_request);
 
 void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 {
-	struct fw_transaction *t = NULL, *iter;
+	struct fw_transaction *t = NULL;
 	u32 *data;
 	size_t data_length;
 	int tcode, tlabel, source, rcode;
@@ -1144,15 +1150,8 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	// NOTE: This can be without irqsave when we can guarantee that __fw_send_request() for
 	// local destination never runs in any type of IRQ context.
 	scoped_guard(spinlock_irqsave, &card->transactions.lock) {
-		list_for_each_entry(iter, &card->transactions.list, link) {
-			if (iter->node_id == source && iter->tlabel == tlabel) {
-				if (try_cancel_split_timeout(iter)) {
-					remove_transaction_entry(card, iter);
-					t = iter;
-				}
-				break;
-			}
-		}
+		t = find_and_pop_transaction_entry(card,
+				iter->node_id == source && iter->tlabel == tlabel);
 	}
 
 	trace_async_response_inbound((uintptr_t)t, card->index, p->generation, p->speed, p->ack,
-- 
2.51.0


