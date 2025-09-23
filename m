Return-Path: <linux-kernel+bounces-828537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D7B94D36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 885127B381E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ECA3164C6;
	Tue, 23 Sep 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ET2oQpnq"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553473164B5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613239; cv=none; b=XiD1CkMFiMfY5JyEPD2zStzYxN4rUslKe5D3V87eRAGL4kOXmtij7+LVOFhVFJBOYuTUrQHHxPRRJwNBnCYeckgfl7JJRyV657UtzTxQjmGWrxm5t8KovHfrCDAcmQIE8fRlU89eS/3M+R61ka3y70q1nL4iVtBZAVjR0l5RPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613239; c=relaxed/simple;
	bh=kWme69oaIgDqEmYO0BWtyTZcU3k7uABN4wDrg4YKr60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2+dyV3hi/ZjXBvlslPe/E4re7lGBu/Wrcllyegrb0XyxrTI3+DdxiWtN+UJz4qmRVZKAEbmk4ghiorHTCA0III76BhGz5rmjfkEnPryDrrPG0snKZPbDcP0cYk+eDp4zJQi3nkYNMfql3T8+X6pqp77ppdi9yQmEE1lBthCupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ET2oQpnq; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758613233;
	bh=EZRAaOb0DRP7MFgJaaji7yQuVjvlpKct24/ueX2RLE0=;
	h=From:Subject:Date:Message-ID;
	b=ET2oQpnqSlPyi6Q4D3t4su4mar5IFOaMBKeQsAyfRk8k9ChhLgTbOpXTpD8bMcHEl
	 YY/LL69R2gZt43+Z10gJVzlW1H2pXvaquiNNG3nMkFuQ+6X6Hdj29CmnV8FZ4pVVx2
	 4CXYjgoRLPsq5LezpH3iikgXrwkZdgDJO3tu6NLM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68D24EC0000029B1; Tue, 23 Sep 2025 15:39:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5380006816016
X-SMAIL-UIID: 3D55CF71BFE3481ABB62F14C557B5DE3-20250923-153948-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
Date: Tue, 23 Sep 2025 15:39:34 +0800
Message-ID: <20250923073935.7486-1-hdanton@sina.com>
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
@@ -1522,15 +1531,23 @@ static void snd_usbmidi_free(struct snd_
 {
 	int i;
 
+	timer_shutdown_sync(&umidi->error_timer);
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
+		int j;
+
+		if (ep->out) {
+			for (j = 0; j < OUTPUT_URBS; ++j)
+				usb_kill_urb(ep->out->urbs[j].urb);
 			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
+		}
+		if (ep->in) {
+			for (j = 0; j < INPUT_URBS; ++j)
+				usb_kill_urb(ep->in->urbs[j]);
 			snd_usbmidi_in_endpoint_delete(ep->in);
+		}
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

