Return-Path: <linux-kernel+bounces-900033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931C1C596A5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9FC3A625B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39823358D34;
	Thu, 13 Nov 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFezV8W+"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7A22A7E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057438; cv=none; b=XR1l4ETTIpKEXVrVY52rcA27deRspdaSvnDCHOtxaD0UzoNlTwMdIe21u4G6s+fVQ25zrmI3NJKN4bSEzcCi9+wcuqVT04yA5UwQOYIX+awtTtE8Ct6+MHNaqfUsoUluUzJw9yDNKW7dAR81AXnxaMpjVF/5ML/L5PvYhCZu+Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057438; c=relaxed/simple;
	bh=0QgMRtdD83RcFucBfkLS2hJinG0DlPzvPLvSV5Q4piU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbBl39v5hbkGifeSIr4HsVc+qZz79M95sphdbij6JKSY7Q0eMC2D2DQRr2rUypXH7STTuufwrjng/HK5w0S0ChaC3cxJLGHUlOxnXsLw4l15hZGczaYfKT71tQ9nR+FeakO2mGsrYJLRRf/ankpIylnjbwRQDEJbER3hT+hAQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFezV8W+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b710601e659so178991266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057434; x=1763662234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87BEAOUBPph3TzBH1vV5g7Ztob9f0IjgY5bWUM5E6Ww=;
        b=MFezV8W+pt5tBxIuK/g45V+RUbRWbVTPNBLg0Ne5jnSJuOkLBbdksx0FCKLRfbExx1
         VQ/v1VB1DRXebpofFXevV/mhJubLCJtuD15EATFBK5i/oGa5712pwTAey6Y9OdUPbQO6
         RNmvysTfbIXdceE9dvzSyjZLLIQJQnLJ/6RXTNm2/l11qknZbfV/6My4MIk7qK36HfnB
         +PAANYBZ0sANaIt8dRhHNh3LbqhQMdht4/U2L+fX6W1igZIK44PSPOaBHz/Or7XpGHVJ
         gWKJ+AJZzfE1ZGwHMOj0o+2l9Ams8xDCi/1WhsY3brgXVbv85e2tXwXssS42io/BXT9H
         QTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057434; x=1763662234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87BEAOUBPph3TzBH1vV5g7Ztob9f0IjgY5bWUM5E6Ww=;
        b=JyoIv69Ruw7YqzlKAsYswYxkdOMypghnZDyOyGFUqtOl/4o9CmqYIFjNgrsiMwq2cL
         jobsmHwXpL/lT+vB6XELyBV6QikMuUCUIxnXhxpfi5VB/itFtuSPlaXvHi0on1Vhf86S
         nagpfWPM18o1k6PTVmnyWkks0FS6T1cA8k1v1IL6dveJFNyJIUB0zlmEZ+DoKOu8MoQA
         Ef2fKVKE+2baHKT39GECG9xdab0ice+ktldRZAi2QBqoi3Hy6IIhaJnVFp8KwQHXU+u0
         YOo4i6rhww0DTKvTgjQwZGjmo6BDubwAr6YRyzh8jeMYat1hSItd17SemqGMES+1BL9t
         F2nw==
X-Forwarded-Encrypted: i=1; AJvYcCWWaPmlA3AbT2a0mxTfbOLULEbiNPKj6iFgTeoMzStebRquLVJy/ZIptWUdUahLdoyLqhj0HJNCyYVXpBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzork4jjspce6dpA93C5l9LvcuqVEM0jQfUjtyzWL3u4VM/2q4o
	m+T486nBNfT5cQEJC8HVIVvwyaRResAiTK3gDCY5E7Zc811Xtoamlp0=
X-Gm-Gg: ASbGncsrrCeKtL+hrkBUTeNMrOmAsR4Ot+UQTgfk2R9SsyVKuX3ioZmWMrDAGq0Aa7N
	71rMSzQYwBMiVS9kBuGLvZRdBXOOPrWVz9nhfmlNm6GuDHdAgAqwXS/8XPnJrWYZ4/r+3n+fL9p
	0kUbyTClJXVooVvqqKiN4+X2rjBGqTkbBcndHaFM4Ls+N3rFcKV+0I9EXOGqKiYxS+hazMW6bPb
	7EwhAaiqW64L4k7mBVIHA8QbZHl+886hAg7FGt7gFssvwc95nxkPjgre8V9whn6C6PYmfKycK2w
	B1vOt1Sf5ThYeg/OJr7Y1IvcIBJYOhU7CbUb4lO1AAvGD/e8bGAhzAPZiQ8HLYnJJXah7g3Avk9
	wamRJTgiM07kIR4ndrX7uqkVu2r13Yv4znTetw/7AATtT9l7Ivo62rdYQeWYgfffdAZ58gZfwjS
	5L3hNzx+Ppfwcjplz5SebbUO0eC00zCi8OoXSXC3GEuhY1BGaMo+5jmsuVI6MWno3Qnh7l
X-Google-Smtp-Source: AGHT+IGz29WAKXKe+U4nMt5douwl+2MqO7amrWJcnBL9iYqpI8wTmeKa4ANLVfbfh8GHVmaNVscELw==
X-Received: by 2002:a17:907:78d:b0:b71:cec2:d54 with SMTP id a640c23a62f3a-b736796a61amr13099066b.57.1763057433996;
        Thu, 13 Nov 2025 10:10:33 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:bb0e:996a:397f:d689])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b734fd809fasm211020266b.45.2025.11.13.10.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 10:10:33 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Geoff Levand <geoff@infradead.org>,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Masakazu Mokuno <mokuno@sm.sony.co.jp>,
	Jeff Garzik <jeff@garzik.org>,
	fuchsfl@gmail.com
Subject: [PATCH net v2] net: ps3_gelic_net: handle skb allocation failures
Date: Thu, 13 Nov 2025 19:10:00 +0100
Message-ID: <20251113181000.3914980-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle skb allocation failures in RX path, to avoid NULL pointer
dereference and RX stalls under memory pressure. If the refill fails
with -ENOMEM, complete napi polling and wake up later to retry via timer.
Also explicitly re-enable RX DMA after oom, so the dmac doesn't remain
stopped in this situation.

Previously, memory pressure could lead to skb allocation failures and
subsequent Oops like:

	Oops: Kernel access of bad area, sig: 11 [#2]
	Hardware name: SonyPS3 Cell Broadband Engine 0x701000 PS3
	NIP [c0003d0000065900] gelic_net_poll+0x6c/0x2d0 [ps3_gelic] (unreliable)
	LR [c0003d00000659c4] gelic_net_poll+0x130/0x2d0 [ps3_gelic]
	Call Trace:
	  gelic_net_poll+0x130/0x2d0 [ps3_gelic] (unreliable)
	  __napi_poll+0x44/0x168
	  net_rx_action+0x178/0x290

Steps to reproduce the issue:
	1. Start a continuous network traffic, like scp of a 20GB file
	2. Inject failslab errors using the kernel fault injection:
	    echo -1 > /sys/kernel/debug/failslab/times
	    echo 30 > /sys/kernel/debug/failslab/interval
	    echo 100 > /sys/kernel/debug/failslab/probability
	3. After some time, traces start to appear, kernel Oopses
	   and the system stops

Step 2 is not always necessary, as it is usually already triggered by
the transfer of a big enough file.

Fixes: 02c1889166b4 ("ps3: gigabit ethernet driver for PS3, take3")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Changes v1->v2:
- Rename and declare return value of gelic_descr_prepare_rx() in the top
  of gelic_card_decode_one_descr() ret -> prepare_rx_ret
- Invert the order of calls in gelic_card_down() run napi_disable()
  first, then timer_delete_sync()
- Remove useless kdoc from gelic_rx_oom_timer()
- Fix gelic_net_poll() to reduce indentation level of success path

v1: https://lore.kernel.org/linuxppc-dev/20251110114523.3099559-1-fuchsfl@gmail.com/

Note: This change has been tested on real hardware Sony PS3 (CECHL04 PAL),
the patch was tested for many hours, with continuous system load, high
network transfer load and injected failslab errors.

 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 45 +++++++++++++++-----
 drivers/net/ethernet/toshiba/ps3_gelic_net.h |  1 +
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 5ee8e8980393..591866fc9055 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -260,6 +260,7 @@ void gelic_card_down(struct gelic_card *card)
 	if (atomic_dec_if_positive(&card->users) == 0) {
 		pr_debug("%s: real do\n", __func__);
 		napi_disable(&card->napi);
+		timer_delete_sync(&card->rx_oom_timer);
 		/*
 		 * Disable irq. Wireless interrupts will
 		 * be disabled later if any
@@ -970,7 +971,8 @@ static void gelic_net_pass_skb_up(struct gelic_descr *descr,
  * gelic_card_decode_one_descr - processes an rx descriptor
  * @card: card structure
  *
- * returns 1 if a packet has been sent to the stack, otherwise 0
+ * returns 1 if a packet has been sent to the stack, -ENOMEM on skb alloc
+ * failure, otherwise 0
  *
  * processes an rx descriptor by iommu-unmapping the data buffer and passing
  * the packet up to the stack
@@ -981,16 +983,18 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	struct gelic_descr_chain *chain = &card->rx_chain;
 	struct gelic_descr *descr = chain->head;
 	struct net_device *netdev = NULL;
-	int dmac_chain_ended;
+	int dmac_chain_ended = 0;
+	int prepare_rx_ret;
 
 	status = gelic_descr_get_status(descr);
 
 	if (status == GELIC_DESCR_DMA_CARDOWNED)
 		return 0;
 
-	if (status == GELIC_DESCR_DMA_NOT_IN_USE) {
+	if (status == GELIC_DESCR_DMA_NOT_IN_USE || !descr->skb) {
 		dev_dbg(ctodev(card), "dormant descr? %p\n", descr);
-		return 0;
+		dmac_chain_ended = 1;
+		goto refill;
 	}
 
 	/* netdevice select */
@@ -1048,9 +1052,10 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 refill:
 
 	/* is the current descriptor terminated with next_descr == NULL? */
-	dmac_chain_ended =
-		be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
-		GELIC_DESCR_RX_DMA_CHAIN_END;
+	if (!dmac_chain_ended)
+		dmac_chain_ended =
+			be32_to_cpu(descr->hw_regs.dmac_cmd_status) &
+			GELIC_DESCR_RX_DMA_CHAIN_END;
 	/*
 	 * So that always DMAC can see the end
 	 * of the descriptor chain to avoid
@@ -1062,10 +1067,11 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 
 	/*
-	 * this call can fail, but for now, just leave this
-	 * descriptor without skb
+	 * this call can fail, propagate the error
 	 */
-	gelic_descr_prepare_rx(card, descr);
+	prepare_rx_ret = gelic_descr_prepare_rx(card, descr);
+	if (prepare_rx_ret)
+		return prepare_rx_ret;
 
 	chain->tail = descr;
 	chain->head = descr->next;
@@ -1087,6 +1093,13 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	return 1;
 }
 
+static void gelic_rx_oom_timer(struct timer_list *t)
+{
+	struct gelic_card *card = timer_container_of(card, t, rx_oom_timer);
+
+	napi_schedule(&card->napi);
+}
+
 /**
  * gelic_net_poll - NAPI poll function called by the stack to return packets
  * @napi: napi structure
@@ -1099,14 +1112,22 @@ static int gelic_net_poll(struct napi_struct *napi, int budget)
 {
 	struct gelic_card *card = container_of(napi, struct gelic_card, napi);
 	int packets_done = 0;
+	int work_result = 0;
 
 	while (packets_done < budget) {
-		if (!gelic_card_decode_one_descr(card))
+		work_result = gelic_card_decode_one_descr(card);
+		if (work_result != 1)
 			break;
 
 		packets_done++;
 	}
 
+	if (work_result == -ENOMEM) {
+		napi_complete_done(napi, packets_done);
+		mod_timer(&card->rx_oom_timer, jiffies + 1);
+		return packets_done;
+	}
+
 	if (packets_done < budget) {
 		napi_complete_done(napi, packets_done);
 		gelic_card_rx_irq_on(card);
@@ -1576,6 +1597,8 @@ static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
 	mutex_init(&card->updown_lock);
 	atomic_set(&card->users, 0);
 
+	timer_setup(&card->rx_oom_timer, gelic_rx_oom_timer, 0);
+
 	return card;
 }
 
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
index f7d7931e51b7..c10f1984a5a1 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
@@ -268,6 +268,7 @@ struct gelic_vlan_id {
 struct gelic_card {
 	struct napi_struct napi;
 	struct net_device *netdev[GELIC_PORT_MAX];
+	struct timer_list rx_oom_timer;
 	/*
 	 * hypervisor requires irq_status should be
 	 * 8 bytes aligned, but u64 member is

base-commit: fe82c4f8a228d3b3ec2462ea2d43fa532a20ac67
-- 
2.43.0


