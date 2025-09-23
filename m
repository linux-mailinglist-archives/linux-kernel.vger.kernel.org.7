Return-Path: <linux-kernel+bounces-828020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395CB93BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8515019080A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281B1A9FB5;
	Tue, 23 Sep 2025 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="l/CjFlM8"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAB0156C6A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588517; cv=none; b=CUCQ0m4c33RFp2iYtzv7/PjZEkC6fmckXpqrVvkibB/z/QODWpOhza45f0P5tjgXNt9vRWxRuSqvv90SsLQFohr5ifDLqNoNJxsduZ7kdMSlMrSy9BlNePyfOcxKiRDhCt5j3gNb+6hPYSFfvmsUoo5J1YXDdQjhvAeszoS7xTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588517; c=relaxed/simple;
	bh=G8g5TfVmCr3shUBF0boJLj9xVB7gyAxC/52Z+eC+IUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsEyX00fg+IkJgY+9YNj21xIZeD5ROaid0DUDlCZyiJ3CqAzlVFqdk0uDbIDcC2jMei9HBVeckieo1G3/ZGevWpQZz23f98hqgS9XM25rATklZkZbXrDPqw5BdyyfYp6/pBRD87ZDmQZoIbp/Js//IU5YmFtfo6z2etE/RrzwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=l/CjFlM8; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758588511;
	bh=InQZsUU2QYmgNFTlyEjA4iU49/w+oZXp0lwWXHciktE=;
	h=From:Subject:Date:Message-ID;
	b=l/CjFlM8Fe200d/7gdiUpSMndOOV/DIS2VKx7xoS9BwwTSNsc6a9CvB9OCsS9SXyd
	 qOXH8u8WYVUZ5D/vB+LxEiIdEhK9gO6WYj+jo6uB/iIuplQ/i1aEJU2ujJ1N+W+jzp
	 repaTWRd9T49JMiFAOs53ImD6dfKO2/ClsRzNVv0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68D1EE5400004D4A; Tue, 23 Sep 2025 08:48:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9375326816287
X-SMAIL-UIID: 0F53FA2409A44E03BC4B48A853B3038D-20250923-084821-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
Date: Tue, 23 Sep 2025 08:48:09 +0800
Message-ID: <20250923004810.7419-1-hdanton@sina.com>
In-Reply-To: <68d17f44.050a0220.13cd81.05b7.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 22 Sep 2025 09:54:28 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=176950e2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=927198eca77e75d9
> dashboard link: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14006712580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e950e2580000

#syz test upstream master

--- x/sound/usb/midi.c
+++ y/sound/usb/midi.c
@@ -307,6 +307,8 @@ static void snd_usbmidi_do_output(struct
 	for (;;) {
 		if (!(ep->active_urbs & (1 << urb_index))) {
 			urb = ep->urbs[urb_index].urb;
+			if (!urb)
+				goto next;
 			urb->transfer_buffer_length = 0;
 			ep->umidi->usb_protocol_ops->output(ep, urb);
 			if (urb->transfer_buffer_length == 0)
@@ -319,6 +321,7 @@ static void snd_usbmidi_do_output(struct
 				break;
 			ep->active_urbs |= 1 << urb_index;
 		}
+	next:
 		if (++urb_index >= OUTPUT_URBS)
 			urb_index = 0;
 		if (urb_index == ep->next_urb)
@@ -1396,13 +1399,19 @@ static int snd_usbmidi_in_endpoint_creat
 static void snd_usbmidi_out_endpoint_clear(struct snd_usb_midi_out_endpoint *ep)
 {
 	unsigned int i;
+	unsigned long flags;
 
+	spin_lock_irqsave(&ep->buffer_lock, flags);
 	for (i = 0; i < OUTPUT_URBS; ++i)
 		if (ep->urbs[i].urb) {
-			free_urb_and_buffer(ep->umidi, ep->urbs[i].urb,
-					    ep->max_transfer);
+			struct urb *urb = ep->urbs[i].urb;
+
 			ep->urbs[i].urb = NULL;
+			spin_unlock_irqrestore(&ep->buffer_lock, flags);
+			free_urb_and_buffer(ep->umidi, urb, ep->max_transfer);
+			spin_lock_irqsave(&ep->buffer_lock, flags);
 		}
+	spin_unlock_irqrestore(&ep->buffer_lock, flags);
 }
 
 static void snd_usbmidi_out_endpoint_delete(struct snd_usb_midi_out_endpoint *ep)
--

