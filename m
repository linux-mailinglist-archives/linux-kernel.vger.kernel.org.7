Return-Path: <linux-kernel+bounces-730986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AABD0B04D35
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019A2165B83
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C01A83F8;
	Tue, 15 Jul 2025 01:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="dlVJAYmh"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A022083
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752541782; cv=none; b=X4800oSM9m/W4PhA5zpYMGZy7o7e4pv3AuOAdaWMHqWIWiURz2nuSAhw8HUaZDPIcWjxtqgun21jwqO3Ny4tZJSuQqtkwq6i+lR/EW3uJG58qNWqefj/7hiu7vWc371MtjM/hSiLQ5vAnfemDiF0vgM/8sipBBIne72pQ7fWbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752541782; c=relaxed/simple;
	bh=PGlEYxwgv2rtInCLTo1w/lgNgstzN7WabOujKrHt+pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo1L8DAHbnH12dPJXhEOUiTb3KL3Br7JFxhEvgHdurnglO/HI2AT1ajOrakzrimnYXmS+09Elq8OmbqPimNBZXU8T2iycQcL9X7IA0JIl9ewi003wriUOWM+RfqGct8jdVIJEXQzP5m94ymAKe7qp6DbrV6RsL/NbAmDFtK/ujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=dlVJAYmh; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752541777;
	bh=QAiMzgJ21Eitzv6jzSmPWnPDYWM6piL2Il7vFeR5bj8=;
	h=From:Subject:Date:Message-ID;
	b=dlVJAYmhrT5heqqi914vyKDrmRfyVCaRfwIVWGIhimbdUejfcw3Zw6NOZ3W8hN62h
	 x8z8qBVhoh1CkbW4jT+OKLDcmYfXw3eHbY0cJyFPdD2knnFBSMgo+qAnjHM5mt74St
	 xAFnI2oEn6tftESeclxiDVPy60wS+E2KYpJWsLOE=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 6875AA4B000011D5; Tue, 15 Jul 2025 09:09:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5650976685335
X-SMAIL-UIID: 2A6E96229BE34251B5CDF4057FBF1E60-20250715-090933-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fde6bd779f78e6e0992e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read in hci_uart_write_work
Date: Tue, 15 Jul 2025 09:09:22 +0800
Message-ID: <20250715010923.4075-1-hdanton@sina.com>
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

--- x/drivers/bluetooth/hci_uart.h
+++ y/drivers/bluetooth/hci_uart.h
@@ -69,6 +69,7 @@ struct hci_uart {
 	unsigned long		hdev_flags;
 
 	struct work_struct	init_ready;
+	struct mutex 		write_mutex;
 	struct work_struct	write_work;
 
 	const struct hci_uart_proto *proto;
--- x/drivers/bluetooth/hci_ldisc.c
+++ y/drivers/bluetooth/hci_ldisc.c
@@ -154,6 +154,7 @@ static void hci_uart_write_work(struct w
 	/* REVISIT: should we cope with bad skbs or ->write() returning
 	 * and error value ?
 	 */
+	mutex_lock(&hu->write_mutex);
 
 restart:
 	clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
@@ -180,6 +181,7 @@ restart:
 		goto restart;
 
 	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
+	mutex_unlock(&hu->write_mutex);
 }
 
 void hci_uart_init_work(struct work_struct *work)
@@ -515,6 +517,7 @@ static int hci_uart_tty_open(struct tty_
 
 	INIT_WORK(&hu->init_ready, hci_uart_init_work);
 	INIT_WORK(&hu->write_work, hci_uart_write_work);
+	mutex_init(&hu->write_mutex);
 
 	/* Flush any pending characters in the driver */
 	tty_driver_flush_buffer(tty);
--

