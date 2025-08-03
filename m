Return-Path: <linux-kernel+bounces-754414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BAB19407
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1878B3B8A26
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEFD265CBE;
	Sun,  3 Aug 2025 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kxWMbMr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOsdxfbR"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353A25EFB6
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223628; cv=none; b=TDY5cm597GHGENeV2HG96aSD96RY+nL3SslGP32CxZcOs0buezeIIeJAJ+liAXo5l99jciaDF+oFPQ77kqsCdFjmt3YuuI+Qxrl87bFvk1zfMO6LRWxrUgGjirdwPpGJvmdhhBtJ1hF/2Frj3HfIDdgy5oD23fZmSkiiFPwjE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223628; c=relaxed/simple;
	bh=N5GNr3BSkDRhNbjGVD7LY6BlO/NfsKqkpiVTw1h9o5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXtkZYlmQIWYSZn6z0Ug1R60RbXmr5KCvaM8AJh4JjwNNT4Wdq+SxYULFN2n3kINUaF/qqL+n/Ql01yl/yoquSmgi6tNBe7CkH/8jDkZ9kAqb1lHwzo+SJzo2QdFlY4x6obn2pWO1jhbTw6fTOuK2x2KWpHNdtCE9rZ72Hd2fyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kxWMbMr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOsdxfbR; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DEE27A0065;
	Sun,  3 Aug 2025 08:20:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 03 Aug 2025 08:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1754223625; x=
	1754310025; bh=pp+pwOmICXcqQR9UclsW6KRuxHBE1pvoqo0FGtllvWg=; b=k
	xWMbMr4WmqTmxbR+Qjd0fPSNzL52yXGFwkcd09RULOkrxFycZ/8mUvODcrEAiCHu
	W7rNOPR4dLDiHPe3TBMBXmSJCcxhIExTzY9PN7X0Sq/Lnn3EINZ4t71w+2UfJ4qs
	i123x1i3nG7liUbwzqBZvi2RcgTYnOlvIBovcZwUkehgKXhysWvPPDWPHtkgME6h
	ZRdiUm3m/FGa97x4I7P+6T5bXBP8hT+OmuKevP7P3drMss6zZI1mnPyughWwhhrG
	eBFi1ax5wAAUSUAJEhRmIdm+7YAVz6PVEJtUk5CMZcUkzEuInP/gxbZnAo9F2hEG
	e5+w1ZvLvfuTAAX1rW2fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754223625; x=1754310025; bh=p
	p+pwOmICXcqQR9UclsW6KRuxHBE1pvoqo0FGtllvWg=; b=NOsdxfbRuHiHu0Jhp
	4slm2ARVjwwhDzA/SvZ29z720tH4s7r2uBtawORftzWKlK6NlWfP1cs7muUwRw8I
	g+4Cf21XyPZoavKqPBgQl08gn2RIyg4hatTFdn2qecNJ6CN9d4Kzzt1fks0g03Zu
	ZUqyzEq73S4F+AQnWmaYwNAQJquwYjOtYi3XPLLmzLAGfixTPREpISp2K0CyjNLU
	NG1x41X8+eOuDHrdfRWf3Hnxls5oWJZ3vXWw0LknlBYmje3SBT7GMoEVvBOoqsr9
	bk+/eGeO2Rw4pNqfX3iMH1YodfU/fi/7uqnapH8/WnWDhjnpnae4rLIHq960K96E
	W+8aQ==
X-ME-Sender: <xms:CFSPaIIGGk8Vr-mdxAGp4-ixh_YRItuhDn8UGNDU4x_b5KhMsAZOmg>
    <xme:CFSPaBEPjLVJjD4xledXkcZq-OW60JTy3obAacgJqj5u4XGk6_Q37NaXwmIdt9Zdj
    DLR7gpthNE38sshdvI>
X-ME-Received: <xmr:CFSPaKqbb2FpO3uvQYCoL_D8GsyS5vU9rR0i7qD7xzQv7H7-pfYNL8eUsygcHbBzDAElVeBbbLjwwbKVBbJDSoIm8dQyS_kLX8XMmyzsbEme>
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
X-ME-Proxy: <xmx:CFSPaCS2rIrB9vF3N3I_9FPRTgLdUGFBWO6o_wolfltrbv48MHXEcQ>
    <xmx:CFSPaPPcLwo9FhqpGeibpyMo5X-vHFhXiHjjx8JZR2zTuPo31sonFg>
    <xmx:CFSPaNNtZfV2rHNpxAxnQEVI4XQ12tE-OP4653bM4TJgvW5cRUfKwA>
    <xmx:CFSPaHvYKb7E5u4MJveR-dH2gbRp3VwjdJ4nyYSuz4gRzUnVC6aSnQ>
    <xmx:CVSPaEODc3-JudJ1hAIjbUO_APDzdAnN0zdUTX_6UVV92hTVmcmSJww2>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 08:20:23 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] firewire: core: call FCP address handlers outside RCU read-side critical section
Date: Sun,  3 Aug 2025 21:20:14 +0900
Message-ID: <20250803122015.236493-4-o-takashi@sakamocchi.jp>
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

The former commit added reference counting to ensure safe invocations of
address handlers. Unlike the exclusive-region address handlers, all FCP
address handlers should be called on receiving an FCP request.

This commit uses the part of kernel stack to collect address handlers up
to 4 within the section, then invoke them outside of the section.
Reference counting ensures that each handler remains valid and safe to
call.

Lifting the limitation of supporting only 4 handlers is left for future
work.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a742971c65fa..7a62c660e912 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -950,13 +950,17 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	put_address_handler(handler);
 }
 
+// To use kmalloc allocator efficiently, this should be power of two.
+#define BUFFER_ON_KERNEL_STACK_SIZE	4
+
 static void handle_fcp_region_request(struct fw_card *card,
 				      struct fw_packet *p,
 				      struct fw_request *request,
 				      unsigned long long offset)
 {
-	struct fw_address_handler *handler;
-	int tcode, destination, source;
+	struct fw_address_handler *buffer_on_kernel_stack[BUFFER_ON_KERNEL_STACK_SIZE];
+	struct fw_address_handler *handler, **handlers;
+	int tcode, destination, source, i, count;
 
 	if ((offset != (CSR_REGISTER_BASE | CSR_FCP_COMMAND) &&
 	     offset != (CSR_REGISTER_BASE | CSR_FCP_RESPONSE)) ||
@@ -977,18 +981,27 @@ static void handle_fcp_region_request(struct fw_card *card,
 		return;
 	}
 
+	count = 0;
+	handlers = buffer_on_kernel_stack;
 	scoped_guard(rcu) {
 		list_for_each_entry_rcu(handler, &address_handler_list, link) {
 			if (is_enclosing_handler(handler, offset, request->length)) {
 				get_address_handler(handler);
-				handler->address_callback(card, request, tcode, destination, source,
-							  p->generation, offset, request->data,
-							  request->length, handler->callback_data);
-				put_address_handler(handler);
+				handlers[count] = handler;
+				if (++count >= ARRAY_SIZE(buffer_on_kernel_stack))
+					break;
 			}
 		}
 	}
 
+	for (i = 0; i < count; ++i) {
+		handler = handlers[i];
+		handler->address_callback(card, request, tcode, destination, source,
+					  p->generation, offset, request->data,
+					  request->length, handler->callback_data);
+		put_address_handler(handler);
+	}
+
 	fw_send_response(card, request, RCODE_COMPLETE);
 }
 
-- 
2.48.1


