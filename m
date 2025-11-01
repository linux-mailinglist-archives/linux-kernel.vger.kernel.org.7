Return-Path: <linux-kernel+bounces-881210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217EC27BA3
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 11:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5F61888E53
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 10:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9937C2C158E;
	Sat,  1 Nov 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="VYKbdz+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKlbrhnY"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ED82BD036
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761992501; cv=none; b=SPsvfl02tSZ9XU2+LQuu78FWA3fj3yBmLhvhZpnBmpRiVGu5lB0FjV5oVPohkDZaleeNPP+F62O/LWkB7J7xkYap1Y40qdO8Jun7qv9layK+j5yODoymUlstUcg9VqtXY7hd667LefYJILC+LTJAtHbmSt2EIZ56GzCHY2/Stvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761992501; c=relaxed/simple;
	bh=LzAu6v+8s1WTD9z4jdIwRhHNsNiBTivfpsq38Uy3sWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvsLY4rIhqrD1h973xCEUtVOdOJL3uKReSjcmn9f0llPUZ0pORv1U6a7/Nt3l91TKenumR0Dn/CzTcp8zVXeJBm7ix4ySlfARpkf791M/zneqNkql/W5hf3Enaz//elIp4a5RQ8vnNKHYDKTR5xWYbhWhk/9oLfUbAysbGNL98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=VYKbdz+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKlbrhnY; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49E6414000EA;
	Sat,  1 Nov 2025 06:21:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 01 Nov 2025 06:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1761992497; x=
	1762078897; bh=77kuYOsBRwvBh/7lbhnKnv+0cwuxlXHkbL+er1/2V50=; b=V
	YKbdz+C8UkDbhryRUP5JF93fo1N9oYRBi7BntzgH3EHtf0mawF7LnHEqicGRrJGC
	yrJ1Xy99rwRu1TAmfqTz3MHW56a5dLzGByc7jrcwK8Aq9VMicdDwMziPm8M6Is4H
	yLE0FW/aV0vsTtAciFjvLgsd9yzi5tiM0TQLxhPgZLIYQKzUMXr7u6gOhfzOnuGf
	tWeUitShQ3mGNHZMUKJMIyV9ht5V7QwcYvf8L1+5u3/FOEBMsjGT8c8XWzHjoca0
	jsH9n7/yRvv1rdsA6LBtPykoU75uaZwIA/w2PNUWVHVlXx+c4eo+gg4Cpp6k6o3E
	XnwFx86X7qCpUxz5MxN3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1761992497; x=1762078897; bh=7
	7kuYOsBRwvBh/7lbhnKnv+0cwuxlXHkbL+er1/2V50=; b=UKlbrhnYG48DJ+9gq
	aoUHA6mc3hEdAw6jDv4ZFcwJdaYVjP1Fk34U72rucURQmRYt++bK8ef7FmCeMGX3
	6vX82O+kQLG1fT/zipaFKzlP52QkpaCtNqQZ6X7/P/1mqu4NFMK9yNCuqDXLwncg
	GT/y8B4Ng8yTZWTdVDY2GelEMCMB7d1d+8pXv5p8ZJKDOwlbF0TRgPhEp1mUUR0n
	w6qSCAwWJTu+kt5zWiS+5snef/0/6q/GrYu/rbJH/JMIHNhiXgMu+6Ign1WV64TV
	koy/wPrZWi/cEjXS2DZpT4ZNJHWjbL07g5UoWtwyun6chKl7unHHU3XEHCTqE9pW
	CSdGw==
X-ME-Sender: <xms:MN8FaXzI-yy65P8DSyr4lP8I9E2ZnYDNWcHs-Ca5xC4ZlFzYkRnDzg>
    <xme:MN8FadMNft8Xl5eLZfBkwA9CzrOKmsjK5U0MjLxt9e678grheDNHpAnWdreP7VIG2
    KA08unQO3gidqy98K_rg9rV8qhlDuQNk1VYEm4vhnj6IQF_nk75qzA>
X-ME-Received: <xmr:MN8FaY7yYQt45dTRRRkJ0UQ5NtL14HZa3wnl2vjfFQEwmLLlyo7GUA1db7-0i5DoLdX9YwfT_WMVndlG7k1xqRh7UrXIzqqi3KuwqIyrIPsEcKo>
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
X-ME-Proxy: <xmx:MN8FaePFHzXGvT17wBh0oXdDKhnk_npk5u4V9WJ1rVbSyY7kqgmnSw>
    <xmx:MN8FaWnmKU24JgME8yaR0Aoue8YzYL98dobEXsyLppgXtOs-XRT_ig>
    <xmx:MN8FaVRod6g_h9KObabGYhLJJJ4jArRj46MrXu6bHnHXBf_G4SSGDA>
    <xmx:MN8FaSDsgDxBxfkIKuioqM5Tm3mEmbRFJE5EJGHJSIrYtRE3ic9XZQ>
    <xmx:Md8FaflZKrpXiT9OtrUViQW6IINAx3E84ZoRjRdg2trhYSPLBuH4Q0rU>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Nov 2025 06:21:36 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: core: code refactoring to remove transaction entry
Date: Sat,  1 Nov 2025 19:21:30 +0900
Message-ID: <20251101102131.925071-2-o-takashi@sakamocchi.jp>
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

The list operation to remove transaction entry appears several times in
transaction implementation and can be replaced with a helper function.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index dd3656a0c1ff..8bd79c3f97f2 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -44,6 +44,13 @@ static int try_cancel_split_timeout(struct fw_transaction *t)
 		return 1;
 }
 
+// card->transactions.lock must be acquired in advance.
+static void remove_transaction_entry(struct fw_card *card, struct fw_transaction *entry)
+{
+	list_del_init(&entry->link);
+	card->transactions.tlabel_mask &= ~(1ULL << entry->tlabel);
+}
+
 static int close_transaction(struct fw_transaction *transaction, struct fw_card *card, int rcode,
 			     u32 response_tstamp)
 {
@@ -55,8 +62,7 @@ static int close_transaction(struct fw_transaction *transaction, struct fw_card
 		list_for_each_entry(iter, &card->transactions.list, link) {
 			if (iter == transaction) {
 				if (try_cancel_split_timeout(iter)) {
-					list_del_init(&iter->link);
-					card->transactions.tlabel_mask &= ~(1ULL << iter->tlabel);
+					remove_transaction_entry(card, iter);
 					t = iter;
 				}
 				break;
@@ -122,8 +128,7 @@ static void split_transaction_timeout_callback(struct timer_list *timer)
 	scoped_guard(spinlock_irqsave, &card->transactions.lock) {
 		if (list_empty(&t->link))
 			return;
-		list_del(&t->link);
-		card->transactions.tlabel_mask &= ~(1ULL << t->tlabel);
+		remove_transaction_entry(card, t);
 	}
 
 	if (!t->with_tstamp) {
@@ -1142,8 +1147,7 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 		list_for_each_entry(iter, &card->transactions.list, link) {
 			if (iter->node_id == source && iter->tlabel == tlabel) {
 				if (try_cancel_split_timeout(iter)) {
-					list_del_init(&iter->link);
-					card->transactions.tlabel_mask &= ~(1ULL << iter->tlabel);
+					remove_transaction_entry(card, iter);
 					t = iter;
 				}
 				break;
-- 
2.51.0


