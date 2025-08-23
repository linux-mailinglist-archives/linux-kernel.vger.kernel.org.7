Return-Path: <linux-kernel+bounces-782895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73A3B32693
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04C9189E8DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25F222581;
	Sat, 23 Aug 2025 03:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="EOKhf6UU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGLkJikB"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAA1F03D5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755918604; cv=none; b=TSI3ISi6cPU8RoCM/1gwCwXgIE984XMVjZBh7PsQ9EYoGKeFcnJuZ1AIi3PbYMajayfjoYNT/EgDYRz7a6KQ1f68J8NEO6unM+OfV5XO+a8QoEFqZoi0KRwosBxTX+u0NTPViF11J/XB1JCvwm96sBdRDtQjVquH7k4NUzv9hKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755918604; c=relaxed/simple;
	bh=86N9WEt2GNRJbOmsJBgqLPrBWgteO9boS4qD/cglaZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E53PyQtD5FL5UKKLbytD54OlQQxwJuDpVuNFgqrhR8LdOV+ygT5FISh7sskpLcsQbWsFE1bmXJJI1IeSVBVEYdYrFJPCbW+u5cXz5zCZZlT6d/pCSMTeSYohXPg/hDsMk/NUqrWYvnFRENRpPMwS99KYSWO3U/CGrf2hjXvp+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=EOKhf6UU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XGLkJikB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F146B14000BB;
	Fri, 22 Aug 2025 23:10:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 22 Aug 2025 23:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1755918600; x=
	1756005000; bh=UyCmahf95MEvBkiDdBnddD8J0Aqng1u+S79mqWwTmJo=; b=E
	OKhf6UUL+49WWz0n/HAaw/a5Cm2eNGmh10JmFNgvzwqzXNw916suuHVpJXX5FGYT
	XQs7Evw9+EoSXc5nfdNSgMZYeUKG/Es/iR0wfFtCNCb64vYzz9LjVs51JSFYKY00
	/vaJp3QQIkL97bgdRYM6FT/OalC+aXZSbXVlxnqNL1K6y7reF2eK/GFhsNE2zx81
	tGCj4GziOr469Sf3+D5yEP6oxT3JDv8rHziEM7/ytmBx2/sW3Zm8YADnneaez0ov
	UbbJZiX7P2BZOg++I0hth6U5E6GyXON3m+LAhEDE4vMpuABioHo976L5YfSZZiom
	KeRsWTUX5SMUX0IR6FNew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1755918600; x=1756005000; bh=U
	yCmahf95MEvBkiDdBnddD8J0Aqng1u+S79mqWwTmJo=; b=XGLkJikBJp+9B/rmv
	SD/kShU2tZGxIaLLx1nIIpIiCwk4Pv7gRzcMhHTwsVgaLcf9EmPfqO9WSBO8NNbN
	Qj/h+35zrqTstEOhgYf8cCwUidJNkQ8qDOIhxbutwrwHxpIMBfKS6UacQa+ZeOQD
	m6Nq3F1hMymqfAFK8EYzH7FazEBiSUPHlRDFNnHG/8oZqwCXDWe0BPGD88eVtfcj
	YUWsQH2PJY7Q/z6OKTJL696W8qruOvlwvMPdyKk5yji92Vw1NFgshYHndKoWk21n
	Vjm89U6h3lZMDgr9PHWrYIK5X+FqdwFwA+AyQmaWHFFMEDOrg5WNZw7uzaFp8kUw
	1i7ww==
X-ME-Sender: <xms:CDGpaERDIP_7OwPo67LcH2gMG7VG6ymA8TJShVNsEg5YLxEY9IFozQ>
    <xme:CDGpaKs5ooG9kzNUa8IDbFmwKM9aGC8f-U8uUpqJvChCClZmMDQnkEZNQciGjz1hA
    2eH6lSIPu8a1oNbZCY>
X-ME-Received: <xmr:CDGpaDwbHgO5atUqyzo7t5XnyVrcXykYVAKdxGMvT6V856QCSKwdheIm4P5WjQY-ikqaV1F68UF0mMT68rj8AE7DhH430Ot8V33acLSim3WrRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieehhedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:CDGpaE4zLl-qEA8ovSINRR5zffgEivPPN6or140QbO2DQ_3TwgH6dA>
    <xmx:CDGpaNXjfapXWWHH8WPXz0oEQjmS7Hz61MAvORh9xkvjTPz-uZ5O6w>
    <xmx:CDGpaA1oJaXnp3BnRJ1n4nJNTozc6enrI5j99YLMNND4nYPxxYy49A>
    <xmx:CDGpaC1_Lwdrp7hvg7lOLneSJZQrc1kkYEekcwKpjZ4NYyjig-V1Jg>
    <xmx:CDGpaJU7t179NFgTAVEavUmR1euwkPPuNsqQzAlefX83LlPtG5mgqgPa>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 23:09:59 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] firewire: ohci: move self_id_complete tracepoint after validating register
Date: Sat, 23 Aug 2025 12:09:52 +0900
Message-ID: <20250823030954.268412-2-o-takashi@sakamocchi.jp>
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

The value of OHCI1394_SelfIDCount register includes an error-indicating
bit. It is safer to place the tracepoint probe after validating the
register value.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index c8c5d598e3c8..b3a187e4cba7 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1863,6 +1863,9 @@ static void bus_reset_work(struct work_struct *work)
 		ohci_notice(ohci, "self ID receive error\n");
 		return;
 	}
+
+	trace_self_id_complete(ohci->card.index, reg, ohci->self_id, has_be_header_quirk(ohci));
+
 	/*
 	 * The count in the SelfIDCount register is the number of
 	 * bytes in the self ID receive buffer.  Since we also receive
@@ -2024,15 +2027,8 @@ static irqreturn_t irq_handler(int irq, void *data)
 	if (event & OHCI1394_busReset)
 		reg_write(ohci, OHCI1394_IntMaskClear, OHCI1394_busReset);
 
-	if (event & OHCI1394_selfIDComplete) {
-		if (trace_self_id_complete_enabled()) {
-			u32 reg = reg_read(ohci, OHCI1394_SelfIDCount);
-
-			trace_self_id_complete(ohci->card.index, reg, ohci->self_id,
-					       has_be_header_quirk(ohci));
-		}
+	if (event & OHCI1394_selfIDComplete)
 		queue_work(selfid_workqueue, &ohci->bus_reset_work);
-	}
 
 	if (event & OHCI1394_RQPkt)
 		queue_work(ohci->card.async_wq, &ohci->ar_request_ctx.work);
-- 
2.48.1


