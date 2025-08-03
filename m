Return-Path: <linux-kernel+bounces-754413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F413B19401
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E362F1895627
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 12:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26A263C75;
	Sun,  3 Aug 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="SqJN1Ovc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUvDXZI9"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922823817D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754223626; cv=none; b=Wv1r35CJiv2FZRClJoX3MZsytIKNqi/LtlIfX8pGxlbn6CPp3xQ+MZs5mpXvEh/keVVvpRPA17tILWryEDHFH34zi9U8UqIZQeWYp7OqmQgRZWtZ7H6oI86RotRG8SpGUhfrsDpvHJQd3Crs7bsIGodtE/SDZsR0p/Tj+98Ghp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754223626; c=relaxed/simple;
	bh=Crow//sR4jZMyLwRLIxXSbgM7Qxpr2ZEaEHMdpqjOEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad8lZiu31gVbquTeAQVsinFO7+lU+gD6SHyyJTRWNPGiLudVptsTwuZLZ8hoDlUVZQVzX2qToii0VhAZaHRdPh4lIumrvfCBnVDjoOw24WWeSu8GOAO77txyvX/gBD9K8IhAeBRhZK0N2L998HyQqYOsnaF0AbIJKmkiUKkOFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=SqJN1Ovc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUvDXZI9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A35F01D0004E;
	Sun,  3 Aug 2025 08:20:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 03 Aug 2025 08:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1754223623; x=
	1754310023; bh=b2fyZFzRWVmgOWs4mun/1WkdQS/q7qojuVcYuOgaoDg=; b=S
	qJN1OvcFMlMwBV21lwkixIW4D1GSXL44Wqlmlq1OfHMCJUSZFbD08m71Oe+CYwPX
	SFVVyitY1OVVJiZ3tUoJ+wbMls+bywvT3o1XIzLDAZs14T5L/kkF/d4GcU0UJkgG
	w7lTsTapRHFzYpSArIy/Cl+SH0mEtzdTVmlz//MkJZhtJTHuhOH2l7NWQsT1Exo+
	1lJ8tEb/b2iQqXLuwQUjSmP/vS0nwiFyrRxVLgVW6v0LlEuhOcBuIR6YzoHW1vW/
	1Uyv3uOtBN07fQHw8L4MwT6DdKty1ydYHdsR0yish7BaLJnuJVVm0FUc/edO7ivS
	5NE3SFF32nKQ+4dFVxgiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1754223623; x=1754310023; bh=b
	2fyZFzRWVmgOWs4mun/1WkdQS/q7qojuVcYuOgaoDg=; b=SUvDXZI9IT9kzXlJc
	G2e0QapDA08pKPXriDP3wjgr4+tlHC+QZhByvuU6dlcPfIOTh4tdrk2sjWLzralB
	nRj24BDPkHxvhl2TXnpAkf1X98hssSIOO28kyW9xC8cConKE+OaXspv9NyGjiRj4
	6Jzt9OCsMNDe9gGQLRtUTEyT1r2AxyORxbvgQ1FBG/I+GmB4m05kE7+56baHP/4K
	B7nEbGFgCfa5aiSGKpJijyjPlSaMeHoE2G8SIHlexiGDL7bTYa9vGME8yKxzuuu6
	K1zUiN0+o8H3HS/F52EMhsmfmZGf8tb0A0qEqXUivIbFg7vDunnxmS3S4aVQAXfg
	vTIIw==
X-ME-Sender: <xms:B1SPaBzUA-sObdltYyN9ptCXx7VTr_axiHllT8wP7aHYgmOHLecraA>
    <xme:B1SPaKP1yDwt3EucO8UVXOZVmU1UL23kv7m-ogiQTVTT7lfUeEYj-tnZwkKRl4Wpf
    ZlvFMb5rGcYkdkz9MM>
X-ME-Received: <xmr:B1SPaNTzHNhQNP4gmee3wBCzb6Gtpw4DfIjOvMhkqH3gXeqZUvUgJ1r56UE98AkfAGyWUSE9k3SUyduT2-ulbGh7-KBV1uUiTRyGzioX4YN1>
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
X-ME-Proxy: <xmx:B1SPaAb8aIIWKIdv3o3aXqlQt8N6j_BTOinMbSNHJm5q3hCN6rnzbw>
    <xmx:B1SPaC2qehSqc9T4Qq7Hkoaq4yvzcZzMMb4ixgYmXB7UEYhcLASMug>
    <xmx:B1SPaIXrGAlHOFoKiGEN-ktbRXNQSbfZD7TE6L06Dk-Sa9g-HI2X7Q>
    <xmx:B1SPaEVJnKDLsROMPTYkMl1XyqgKEqhlcCR1vaaY7pSCuTQ1M7qdyw>
    <xmx:B1SPaC2lqznvNXfK4efS31NHz1w-k8F92dX1BKlczux5LTQJqQoqaKis>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 08:20:22 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] firewire: core: call handler for exclusive regions outside RCU read-side critical section
Date: Sun,  3 Aug 2025 21:20:13 +0900
Message-ID: <20250803122015.236493-3-o-takashi@sakamocchi.jp>
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

The previous commit added reference counting to ensure safe invocations of
address handlers.

This commit moves the invocation of handlers for exclusive regions outside
of the RCU read-side critical section. The address handler for the
requested region is selected within the critical section, then invoked
outside of it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 29ca9f3f14ce..a742971c65fa 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -935,17 +935,19 @@ static void handle_exclusive_region_request(struct fw_card *card,
 	scoped_guard(rcu) {
 		handler = lookup_enclosing_address_handler(&address_handler_list, offset,
 							   request->length);
-		if (handler) {
+		if (handler)
 			get_address_handler(handler);
-			handler->address_callback(card, request, tcode, destination, source,
-						  p->generation, offset, request->data,
-						  request->length, handler->callback_data);
-			put_address_handler(handler);
-		}
 	}
 
-	if (!handler)
+	if (!handler) {
 		fw_send_response(card, request, RCODE_ADDRESS_ERROR);
+		return;
+	}
+
+	// Outside the RCU read-side critical section. Without spinlock. With reference count.
+	handler->address_callback(card, request, tcode, destination, source, p->generation, offset,
+				  request->data, request->length, handler->callback_data);
+	put_address_handler(handler);
 }
 
 static void handle_fcp_region_request(struct fw_card *card,
-- 
2.48.1


