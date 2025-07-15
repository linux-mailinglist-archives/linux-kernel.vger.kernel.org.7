Return-Path: <linux-kernel+bounces-731163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A17B0503E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996174A34B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007423E350;
	Tue, 15 Jul 2025 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dGTQ1iCE"
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175EBE4A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752553861; cv=none; b=Z70DMyXss1Pr58WH7zpPWhv/oq69KM5s7WcGOOSqjBDAHBw6FXKZcy0zVKxGn8ptmzrNSEpY87OPsCBIoYlc9gKkbLVaRoDRptY/JZsIcZa8/u+9hdW5uyP6DDWeZSZESpLTcOMG7HC4pRY3qTUDpNNaGN4ib+2X2oTiCcaRo9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752553861; c=relaxed/simple;
	bh=sh/63tDjESgj6s4X5Dx4BQXOyuBjAPHP4BG8lUeYnHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a81hB96HwLBwKGhNBPgaV/AmbtigsPBjusfBtxXQDsFsfpd81pdxdD/VRHwXDd2RABxnVZhzysKEkGsaG5mD1XhBKwt0RutxTz1OFq1MUSeNSJBoj6I5/jLrfG4aUUXOPFeg575m/Pb3dfp3WlJDCL+ktr0zg1WboXozIBvKreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dGTQ1iCE; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752553853;
	bh=assH/MpcF1THdmZ0hstOP1P43rOFwRYjl2A4lpGKY2U=;
	h=From:Subject:Date:Message-ID;
	b=dGTQ1iCEtnft8VscWBrl8YSVoDeWMk0AU+0+8G4CjGiis95aRtD/WizwOYuMzUu9a
	 AZu7EiEy8pNFNlQbszw5JlGl8bYAoOy5mpWBvP3GAxoRn4hwzGlKv2FIazZaHIh2h9
	 +zdDSCsRC2NUIOb0Z7gPO5ugnYX5efxhb0Rl4Q9Y=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6875D950000016F8; Tue, 15 Jul 2025 12:30:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7378426816487
X-SMAIL-UIID: FF41ACEFBB804087A7E08772A8E31723-20250715-123009-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read in hci_uart_write_work
Date: Tue, 15 Jul 2025 12:29:58 +0800
Message-ID: <20250715042959.2087-1-hdanton@sina.com>
In-Reply-To: <687539cb.a70a0220.18f9d4.0005.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 14 Jul 2025 10:09:31 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3f31a806a62e Merge tag 'mm-hotfixes-stable-2025-07-11-16-1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=174b07d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
> dashboard link: https://syzkaller.appspot.com/bug?extid=fde6bd779f78e6e0992e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127ece8c580000

#syz test

--- x/drivers/bluetooth/hci_ldisc.c
+++ y/drivers/bluetooth/hci_ldisc.c
@@ -100,13 +100,9 @@ static inline struct sk_buff *hci_uart_d
 	struct sk_buff *skb = hu->tx_skb;
 
 	if (!skb) {
-		percpu_down_read(&hu->proto_lock);
-
 		if (test_bit(HCI_UART_PROTO_READY, &hu->flags) ||
 		    test_bit(HCI_UART_PROTO_INIT, &hu->flags))
 			skb = hu->proto->dequeue(hu);
-
-		percpu_up_read(&hu->proto_lock);
 	} else {
 		hu->tx_skb = NULL;
 	}
@@ -154,6 +150,11 @@ static void hci_uart_write_work(struct w
 	/* REVISIT: should we cope with bad skbs or ->write() returning
 	 * and error value ?
 	 */
+	percpu_down_read(&hu->proto_lock);
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
+		percpu_up_read(&hu->proto_lock);
+		return;
+	}
 
 restart:
 	clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -179,6 +180,7 @@ restart:
 	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
 		goto restart;
 
+	percpu_up_read(&hu->proto_lock);
 	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
 }
 
--

