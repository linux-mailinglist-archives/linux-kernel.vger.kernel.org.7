Return-Path: <linux-kernel+bounces-747350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E0B132D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C851756DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AA1DE2AD;
	Mon, 28 Jul 2025 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fW6QzVKw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaS1lKkl"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD47198851
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753667495; cv=none; b=DPIXWPa6hv7f+8AdOd6HYJEXn5WDdVr7fdThPj6l8CX+wzja/6pivlALB1mcmWqKN59bqcLZcC8NZ2+u663ObytFd8+sfo+proKOONQXik5C6xmRGXDy0kFsSskMBpo4krdzHzv8yNFotmmJFZxZqNMKuz+DiD5HKRg0QlsH07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753667495; c=relaxed/simple;
	bh=q9otTa9NZdOiCJNQl4OD6xqn9lIKwfmzJlUv8Z4LWuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIIjAf4gb8HSRuscqm0TPg26rHtdrPUzQloLNz9grntsoezl8Dt9j3sQX3Pfm1CeHegHPj55LeSX0JcLuuHgvblCkY+BFT6q4Mqy+udysjS2lyh6IRGeuU+h8AsmxuUEYiwoZpRI9Va0JtT/dQEHc59Lbjw/2+1inaEPa4MVjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=fW6QzVKw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaS1lKkl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F063EEC00DC;
	Sun, 27 Jul 2025 21:51:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 27 Jul 2025 21:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1753667492; x=
	1753753892; bh=D0BMPfPajXGaC45vmNs+dIanSxJ+Y1IlpOlvP9lpPHg=; b=f
	W6QzVKwaobJ7GUPv3Bp9aaIhJD1rnAem5FFGu2NLmYSEIR3biPmDk+UHFXtkpwYI
	Y6DP+1ro+l4Ur7zF9YMxYCeNoMr8+5eYGPT6OQB+XF5hb5ibsCytJkJNDzO7c236
	fciYzMa8SiGGqbMsltPpl+Xq4dOWxa0DaC4MFpFKwkVMFuAGMXzfTxbCoRRbsoxh
	5goqytBsGHCylB+d/lgZtyKwI1bZyScYM4ixWog8iKFQ5XdTsCMeuTZL64DTQSJK
	32Zz8Jcc5SRzjPHT+XwkBA8Cs+3u5vD2wDdBl4z3w8wF+OL2153v3+GHSF1TOTWl
	AunalhuLiUlsKAb7/sZfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1753667492; x=1753753892; bh=D
	0BMPfPajXGaC45vmNs+dIanSxJ+Y1IlpOlvP9lpPHg=; b=IaS1lKklM6lBm2WBJ
	hwQWhfHDqlgA2cfI5r+I+4NuSffHBbcypb6XENoy9LkbmLYVwf8arlWH50gcwUNA
	kLYKVM+YwMXLxxmUapwr+WbTblh148Z5+SiJe6yXNRvmwR+y0Deysz5iUh8N78yP
	zUAyA9jy9yM08lxi0nGoiBhf6WCOTRTTleUimsSIe5jxB2qfr4m9KgLVWcZ/KdtI
	gRxnNHdZNF0cZIf4C4iGiO1uRLHn99AAPyyfTfIvqwMpmaGaCDbOtphOvwxKt8J5
	aesS4FgKjAS3KXMR7VgRjpsN4Cepv1AEy3PKpwxpsIk/FVdNMuHO6Yh0qhk4YsaK
	QyBfQ==
X-ME-Sender: <xms:pNeGaFu7LdoW9J8jaWDBxsnGMo-NRSlcPECInVWVIsrsgp3t2B6NKA>
    <xme:pNeGaHYFd4d6iEkNDWNbwiig0o6B82J2_mPttD4E2iDaITl52gAXemJ_-29YWnUwx
    q5g4MEzeDBQQKPTj5k>
X-ME-Received: <xmr:pNeGaKtC9Zawni8YhlfD3mexF50ZBBNC6dB_swTm6FFrv97oar0Ngx3SVzauLZUohB_03pCvQBKPkuQAMTC31iQilY4rzshhSCeT0f-fU51Mrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeltdeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:pNeGaJG3izv8ACGkLIpc-ZhVECiBw2cncfShMLjOASQ8wTR_2dAWIA>
    <xmx:pNeGaFxm54qq2DfI0ssYSkK02Ac-UetW1s1QjA2ZAhoZ-acu6-BM5Q>
    <xmx:pNeGaIhFy2ODx5flvAd2dFElYBiENCQkyH1qRqTyspLgQLxjSIHE0g>
    <xmx:pNeGaIxOLxBZk3BVj-eESLuOBP4GkiVXpM7KUySVgCW9tRsg_IJljA>
    <xmx:pNeGaKRzFspz13kw9qCmMQvwBLjrkPKTXKGTJuztqssyj1FnYefy4PLu>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jul 2025 21:51:31 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] firewire: core: call handler for exclusive regions outside RCU read-side critical section
Date: Mon, 28 Jul 2025 10:51:24 +0900
Message-ID: <20250728015125.17825-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728015125.17825-1-o-takashi@sakamocchi.jp>
References: <20250728015125.17825-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit added reference counting to ensure safe invocations of
address handlers.

This commit moves the invocation of handlers for exclusive regins outside
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


