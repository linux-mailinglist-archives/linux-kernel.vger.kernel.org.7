Return-Path: <linux-kernel+bounces-754412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F43B19400
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C6B7A7923
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3338260566;
	Sun,  3 Aug 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EFjJa2WK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UloJUCq1"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33448223DDA
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223625; cv=none; b=OPHSFpJSZLlrIephUAyyOtpPwENWEAhgZnCbd8NJxBnGHG3PyJDOlSZ9ci18JaNH72al8mb3eGkn5U/VvcsikHJxkRYtPxg1oPYkpSu1Q8lvzxjRO5UpJCm4bNdZNPU4WCU0rmsPNmlkO9fhgtteZtxtg9GxWLcJ7ePXcv3To0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223625; c=relaxed/simple;
	bh=vCtpcf9wAnIGcpwLMOhPlHW12IOrK3my2L75fundcPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh0G1miKJR5g0871q5DUrt+WDaCydiFkACooLq9OQrYF0azuDV3sPiDXFAT2Fk+9dquac2rKCPrXWFlbltli4mTryeDUaifD9DiPM7iMLjIHChvGnK5jcomAavbLOAkNfju2gkzBaw2u0gR1djxvSvhBhL0yxVo1FDCVXmbIaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=EFjJa2WK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UloJUCq1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F3B61D0004C;
	Sun,  3 Aug 2025 08:20:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 03 Aug 2025 08:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1754223621; x=
	1754310021; bh=+8FHm5cpc8lKA672iypagCkCcR1rLrfb6Rvi70Ol9DI=; b=E
	FjJa2WKC2efYXAsmUbJpRK1PHDrnQEHbEv5Mul2lZsGasTbJEwElpWagTqULd9B3
	JdCR7QmLotJyMLtguCCsxWBweoj87llVV3NMHl+tsZpp8QcaXp/CqFIOCAdXJq1P
	hGUeCgmCF9WA/NHinsJF6/SAhxRdQ/vz7EYjpM20BNF2p9/3lEVmCgvD95a38oZK
	3Bm9AkASeD6omywJZYK5xUmaHEn1quNm+bdD1/a76BhPji0qAiDB3EeUec6ORFN1
	HmkYGcGNx1wCnrxamM/iNeQmOGzlaRc/kiwmUon/n9nBTvYMLS5aMjVI/yHMkgJ2
	RiRJJx/bXhkEfK8fsDshg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754223621; x=1754310021; bh=+
	8FHm5cpc8lKA672iypagCkCcR1rLrfb6Rvi70Ol9DI=; b=UloJUCq12LQQy46f5
	nhHhgaAiQ/fy5dMsZIae1FbI3nyhGA1uLv3rs73L3hDi4qsl+juzo/9njanVaWf0
	qKFEViQag0b+bYIBr84At4tJbNFnCz5CVq+5q46W6EPZ80XfTZp+KLNEdC6b3RB4
	alsHFVaSpkm/sqUVzVvYgk3x0MdJr4+nNHlclKWrx3MVzSrLelobnLkHA+dQhHRS
	+6JVmY3jwyxRG2AxkWlwd4iK5H3hod666/CxXiASUWb75GXyUee5Gab6QJgsl2CY
	1POtQvDwTDu13DGRaQrUDT/hgZZJ2TFCidPM4XhGrcjG86TB/ruKkJ0No+/yOxmi
	3zcTQ==
X-ME-Sender: <xms:BVSPaGgdks8Ara4jZGXZzoHJ7NzpykhMHCPLFoA5lp-YXjF9TxVE1A>
    <xme:BVSPaP9ySN0GFuCDavJGLIyXOm_aEBkGWhDTgN2tfrw4nN2H86iTNnDrsYl0G3nUl
    mBqdpsFg8-2u4MmLVU>
X-ME-Received: <xmr:BVSPaAD81RFHAFLI9bSAQPeSTaE4dCl84FHqISTg66iBja5sMxaRV7tCjr2aSPlllRo-ow0dLEq90I5gdYAFwzg6oWdvOjNFFZIuNR5lQSkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelgeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BVSPaML-GATCtVYT6LnuLKVBAq6BUEUaqtoeYwwLYC2ZtWz64L55Uw>
    <xmx:BVSPaDm8MPxLQhUkEuak-kLa84TyOBDxxE3q19ljFmDpDUAwqVcMeg>
    <xmx:BVSPaKFi5VDpEqpy4GHHvSnT8kmiIK8CibKcm6b05ZyWscbzqBbzXQ>
    <xmx:BVSPaDEofvtO5F1x9b32D8qZxHxuaDksILFytht2z7txFerHzNfReA>
    <xmx:BVSPaNnJAEA1h8WCB38_vOvC1LQMgNF0VRtUIdPkZQ1URBC2VDsYVdzR>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 08:20:20 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] firewire: core: use reference counting to invoke address handlers safely
Date: Sun,  3 Aug 2025 21:20:12 +0900
Message-ID: <20250803122015.236493-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803122015.236493-1-o-takashi@sakamocchi.jp>
References: <20250803122015.236493-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lifetime of address handler has been managed by linked list and RCU.
This approach was introduced in commit 35202f7d8420 ("firewire: remove
global lock around address handlers, convert to RCU"). The invocations of
address handler are performed within RCU read-side critical sections.

In commit 57e6d9f85fff ("firewire: ohci: use workqueue to handle events
of AR request/response contexts"), the invocations are in a workqueue
context. The approach still imposes limitation that sleeping is not
allowed within RCU read-side critical sections. However, since sleeping
is not permitted within RCU read-side critical sections, this approach
still has a limitation.

This commit adds reference counting to decouple handler invocation from
handler discovery. The linked list and RCU is used to discover the
handlers, while the reference counting is used to invoke them safely.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 32 +++++++++++++++++++++++++++--
 include/linux/firewire.h            |  4 ++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index d28477d84697..29ca9f3f14ce 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -550,6 +550,23 @@ const struct fw_address_region fw_unit_space_region =
 	{ .start = 0xfffff0000900ULL, .end = 0x1000000000000ULL, };
 #endif  /*  0  */
 
+static void complete_address_handler(struct kref *kref)
+{
+	struct fw_address_handler *handler = container_of(kref, struct fw_address_handler, kref);
+
+	complete(&handler->done);
+}
+
+static void get_address_handler(struct fw_address_handler *handler)
+{
+	kref_get(&handler->kref);
+}
+
+static int put_address_handler(struct fw_address_handler *handler)
+{
+	return kref_put(&handler->kref, complete_address_handler);
+}
+
 /**
  * fw_core_add_address_handler() - register for incoming requests
  * @handler:	callback
@@ -596,6 +613,8 @@ int fw_core_add_address_handler(struct fw_address_handler *handler,
 		if (other != NULL) {
 			handler->offset += other->length;
 		} else {
+			init_completion(&handler->done);
+			kref_init(&handler->kref);
 			list_add_tail_rcu(&handler->link, &address_handler_list);
 			ret = 0;
 			break;
@@ -621,6 +640,9 @@ void fw_core_remove_address_handler(struct fw_address_handler *handler)
 		list_del_rcu(&handler->link);
 
 	synchronize_rcu();
+
+	if (!put_address_handler(handler))
+		wait_for_completion(&handler->done);
 }
 EXPORT_SYMBOL(fw_core_remove_address_handler);
 
@@ -913,10 +935,13 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	scoped_guard(rcu) {
 		handler = lookup_enclosing_address_handler(&address_handler_list, offset,
 							   request->length);
-		if (handler)
+		if (handler) {
+			get_address_handler(handler);
 			handler->address_callback(card, request, tcode, destination, source,
 						  p->generation, offset, request->data,
 						  request->length, handler->callback_data);
+			put_address_handler(handler);
+		}
 	}
 
 	if (!handler)
@@ -952,10 +977,13 @@ static void handle_fcp_region_request(struct fw_card *card,
 
 	scoped_guard(rcu) {
 		list_for_each_entry_rcu(handler, &address_handler_list, link) {
-			if (is_enclosing_handler(handler, offset, request->length))
+			if (is_enclosing_handler(handler, offset, request->length)) {
+				get_address_handler(handler);
 				handler->address_callback(card, request, tcode, destination, source,
 							  p->generation, offset, request->data,
 							  request->length, handler->callback_data);
+				put_address_handler(handler);
+			}
 		}
 	}
 
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index cceb70415ed2..d38c6e538e5c 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -341,7 +341,11 @@ struct fw_address_handler {
 	u64 length;
 	fw_address_callback_t address_callback;
 	void *callback_data;
+
+	// Only for core functions.
 	struct list_head link;
+	struct kref kref;
+	struct completion done;
 };
 
 struct fw_address_region {
-- 
2.48.1


