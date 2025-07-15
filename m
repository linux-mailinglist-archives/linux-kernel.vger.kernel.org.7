Return-Path: <linux-kernel+bounces-731480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF7B054FD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2EB4A6CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486C2275B07;
	Tue, 15 Jul 2025 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JbZT+DzJ"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E61231A30
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568343; cv=none; b=ks/k9iBchCV9TnKws8SVB9PiforMtY90+MW4pb3oUplaurxXUoZCNm1jSFTq1ZXKube3LmQpKHRAHoGmd1uDZh5QEkRbLNe8S7xjQ5nNFAE2ycnbg6TTpQjscwtuFRFv7m2iATVeM5uuhA9UfF/p9BsIbVAnSq4o4DG5inshap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568343; c=relaxed/simple;
	bh=tmiGnu0O8rYD6Z496eKDdB/Wlu16erEn+MOul+XC1T4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7e0NATVn+3IhnmAUSekPQxO4+AhHho+TjQIqSnmvmhEtBeMUKIQPel7mUfbcgtpc57guve18k6zVDCda+NMPbHCiYHhZL+TTTpk/KWuIZ03hF6pbuTHzFdScjxk1/wX6WGdbgBKcdGxPC/REaY8iaNW6DlWpUa8It8aEqYaUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JbZT+DzJ; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752568337;
	bh=TY7vP3lmomv//3V00HDQytvYzTOMjfQoAAeS1EExswY=;
	h=From:Subject:Date:Message-ID;
	b=JbZT+DzJSlCpxrJWOpKXC0Q0Ab2tK6Cy8RcuJsCDHsn07ZXnaWuWZaGWSPB/X65lz
	 D41OEoOYnY8qfVBAN+vZonq0ZOLxGzMJNmxiPx9nzsdP9/f5K5KISMCzH0MhX5cPi4
	 /Tr0rzJlX+G9VRXSg1cPRXUnyo2U8LCQpQ2OzLiE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6876120600003B88; Tue, 15 Jul 2025 16:32:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1967206292042
X-SMAIL-UIID: DB56772CB597499F8EF1BEF8389F31AF-20250715-163208-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read in hci_uart_write_work
Date: Tue, 15 Jul 2025 16:31:56 +0800
Message-ID: <20250715083157.2117-1-hdanton@sina.com>
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
 
@@ -231,9 +233,12 @@ static int hci_uart_flush(struct hci_dev
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
+	percpu_down_write(&hu->proto_lock);
 	if (hu->tx_skb) {
-		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
+		kfree_skb(hu->tx_skb);
+		hu->tx_skb = NULL;
 	}
+	percpu_up_write(&hu->proto_lock);
 
 	/* Flush any pending characters in the driver and discipline. */
 	tty_ldisc_flush(tty);
--

