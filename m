Return-Path: <linux-kernel+bounces-893144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C345C46A13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1397D189138D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D3130E0F1;
	Mon, 10 Nov 2025 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORTBrvd8"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39345305064
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778132; cv=none; b=hNSH5qqvuCcpqw7CvsPB2a6UwRzl2OnlIEBr4526+iFpzXwYfNRXcBUUVch6+MPUeZGtBM0HxoxRjHjjED+A/MUuOZhnkCuk1XZmGctb+lnpNcaY+kbz56wuA50hVVopjKiCVGg87nhD/8WZq4ZtVy2DjAZaFjynO0cvhQ+5xG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778132; c=relaxed/simple;
	bh=BVknF2oRF/mNhXFgJE6mnfXaZzrQ/K9wGZbA5rfzGmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGikjfvjc4cbIrF+u4AqrlcKhjaXFFHZN5Sv1F0BKXgdt20f4PeujEA2jLyUJ4xXrzYRObl2cDySTFz5M1zTexiQwF1VEVJyhW1zdAnIZ6xNBd1IF27o3jBjAgvd4yZf0PZCd23Ze1Iqzpxm6aFMGya4l8Uen49H15dlSabzS9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORTBrvd8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso4421681a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762778128; x=1763382928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9yuBGJK7ItWgGt5SCLQHjsgMyP28LPonF6RXSUDMaw=;
        b=ORTBrvd8OIcTDq4ZZM2NNjh7AARiwNTGLFhpTaSFUj2euK0RRXYIJG2sYYodA8/RSR
         kMpOhamKsdVL4SvX5UA9L+f6LLvLzGrMo60SXMkN1gXdiNyfTGffwYu3g/ZbUXhg5MPI
         CUdRv29ATg3Mtj7WkdmKEgciyYwGeZdpmV0CsAQzKnqAECifcLXqrDxCDM8lQXSiEoEh
         Q76bTQ0P6jbGvN6G/RawlvC5ICFH2WldEOXe4Sn33gxunrFCA53mygPjaPhgIcnq9eBi
         /K2btZFjT4lkIv7YMeocLtqSoLDpEgRjsA/I/xE/QDrBOGUzzvLUN7uZZt8jHUBoUqBG
         VnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778128; x=1763382928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9yuBGJK7ItWgGt5SCLQHjsgMyP28LPonF6RXSUDMaw=;
        b=h8SOwRMMpg2cjRe93bRus+6+oAj57BXhGeKUCj22Pe3c7b7WNDoOPEkdjpSXUYiQli
         eLA4lD0hFU/PDKyhfU/uRL9LzkVieMd9VF6aATz4rauxtftvQOi6MhYDZY2amHo3oGzI
         mPBQuNv/1PCxyvtZoLqcREV6YEHo5XTnm6ZWeIkBlYCvh7afF46vOJp02PwZaiyxR5k3
         DtWn9g92FtpvJ1EA1nVcnAeQTgmMj458gCpHkDKSlqRxo5MuHp7ZRHP3KDw8a6YN6zIZ
         UtB+YPivhI8BGtfvN9b5Vk/cABOpdEF2n7AHN51k9cEAh1rZAnP1zLWTY28JzyX9kBWZ
         otgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWd+fi0s1BQItz91XvtkaxRQkCyBTo5e40xR3np3RmuVJzJ3uJewbYrWqANUrMsUJOIEcHg7spn4S5YT5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6SequuDN2bMa0XSoT0/Bbr+F/VrZ9/q5Kwv0nodpGKlCf5tpu
	i2yZ2EwJmIlftwpv163SCNblCq9WxUDJmNnN/zEYiiw2bDtcDDEw6m4=
X-Gm-Gg: ASbGncsLzBXrB5TA22Ckrag8Wra5CRCBVDowxyt7LLT1knmZUII/E4euaNx1o97+tPm
	cFEq1J9rwaf10YV17KjzMyGSjR8IuWuaqr0ZlSBCFTktjTdwSK8woIjxVTH0Dd3SXwXxpuGB/xP
	itA8ph1r/LILwcizV1wtpnw9P5ykov2c4MNtmKu8yMZyuZ7MdE0CgangN8phWlPA0OxXDi0bLJ8
	8bBTxMBnxfhsqCisSs+nYjm6kxMnLDwY6CrGncCrvSAGFo1JJOB3kYICI+k38PlketeZQCiGmVj
	WB3iQimZXbHz5duUmsNS9QmXhj38a7GHoDDnoTsjn4qyPMthEooxY6N29kqv385oDGuy8zkCKqD
	VpAuk9hS+qA9VQ0H7vtSK7/YtNnIlzI4R+pIuCkQirw7fXwCI6mY5jkbOwWJXvMkIaB0BtWJnVS
	78fOaSwrpQiK07zz9q43jkJYezaB/M5pN+tP5XP29ghKLFisJTFxeGZYSuIA==
X-Google-Smtp-Source: AGHT+IEpiarrykSHgarbY66mp2ewInXdQS9oj/GI/fOZRk6M3rULM73l5HZ28Hq1eYhWA54E7K5p2A==
X-Received: by 2002:aa7:cfc3:0:b0:641:997e:d53a with SMTP id 4fb4d7f45d1cf-641997edc9bmr1574561a12.2.1762778128212;
        Mon, 10 Nov 2025 04:35:28 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:bca7:1050:d604:3b82])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6411f86e0cesm11390383a12.33.2025.11.10.04.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 04:35:27 -0800 (PST)
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
	fuchsfl@gmail.com
Subject: [PATCH net] net: ps3_gelic_net: handle skb allocation failures
Date: Mon, 10 Nov 2025 12:45:23 +0100
Message-ID: <20251110114523.3099559-1-fuchsfl@gmail.com>
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
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 54 +++++++++++++++-----
 drivers/net/ethernet/toshiba/ps3_gelic_net.h |  1 +
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 5ee8e8980393..a8121f7583f9 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -259,6 +259,7 @@ void gelic_card_down(struct gelic_card *card)
 	mutex_lock(&card->updown_lock);
 	if (atomic_dec_if_positive(&card->users) == 0) {
 		pr_debug("%s: real do\n", __func__);
+		timer_delete_sync(&card->rx_oom_timer);
 		napi_disable(&card->napi);
 		/*
 		 * Disable irq. Wireless interrupts will
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
@@ -981,16 +983,17 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	struct gelic_descr_chain *chain = &card->rx_chain;
 	struct gelic_descr *descr = chain->head;
 	struct net_device *netdev = NULL;
-	int dmac_chain_ended;
+	int dmac_chain_ended = 0;
 
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
@@ -1048,9 +1051,10 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
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
@@ -1062,10 +1066,12 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 
 	/*
-	 * this call can fail, but for now, just leave this
-	 * descriptor without skb
+	 * this call can fail, propagate the error
 	 */
-	gelic_descr_prepare_rx(card, descr);
+	int ret = gelic_descr_prepare_rx(card, descr);
+
+	if (ret)
+		return ret;
 
 	chain->tail = descr;
 	chain->head = descr->next;
@@ -1087,6 +1093,17 @@ static int gelic_card_decode_one_descr(struct gelic_card *card)
 	return 1;
 }
 
+/**
+ *  gelic_rx_oom_timer - Restart napi poll if oom occurred
+ *  @t: timer list
+ */
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
@@ -1099,12 +1116,21 @@ static int gelic_net_poll(struct napi_struct *napi, int budget)
 {
 	struct gelic_card *card = container_of(napi, struct gelic_card, napi);
 	int packets_done = 0;
+	int work_result = 0;
 
 	while (packets_done < budget) {
-		if (!gelic_card_decode_one_descr(card))
-			break;
+		work_result = gelic_card_decode_one_descr(card);
+		if (work_result == 1) {
+			packets_done++;
+			continue;
+		}
+		break;
+	}
 
-		packets_done++;
+	if (work_result == -ENOMEM) {
+		napi_complete_done(napi, packets_done);
+		mod_timer(&card->rx_oom_timer, jiffies + 1);
+		return packets_done;
 	}
 
 	if (packets_done < budget) {
@@ -1576,6 +1602,8 @@ static struct gelic_card *gelic_alloc_card_net(struct net_device **netdev)
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

base-commit: 96a9178a29a6b84bb632ebeb4e84cf61191c73d5
-- 
2.43.0


