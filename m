Return-Path: <linux-kernel+bounces-887666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A349CC38D75
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102AB188357A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA751D61A3;
	Thu,  6 Nov 2025 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="ByUDlhhL"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F629A1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395386; cv=none; b=Xy/1JuWAAZlsmVNkVe9UJEjhy224SfnZaFRPPlMlLWCRsUxsnlzBhkfpicm6H4FNM5GKeyLBtGdI4VdwpsxR9As9Cc6AviKKn4SQCMlFdy8kkwNPT2IyjWVXWI9Xg4AjW2F9hucFCPZzRXlc0Gj8QJx9FRzSpgq0h8ffZh9Mo0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395386; c=relaxed/simple;
	bh=8b6ZVtmjdfwHqqripVHysOYjeiYRLQedxptvJ8Gs8ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmblliafF/kKCk4eErhtKfmr2s1ZmqOwBFxQHgycn6uPWZ6YyLNtOG0viwm5upMuiXeCXhO1aHV4p39zTX65y+03Ifxltkx9g9iRsBU/Na73tMheilAFZ4+4bfJ8vHtwoL7TotzpeNjY1y2015BmbR5760FJkEs3zO84XU2Js6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=ByUDlhhL; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762395377;
	bh=GtC0iH5sWMVmdYCbBu/YjfG+/vRiPwjsySKIMir874k=;
	h=From:Subject:Date:Message-ID;
	b=ByUDlhhLBHE03Dh1OYDhtAbTZsNXkbEm14GmTShle1ZIFqMhgP1eDAUIPZmjG7DAI
	 +GzF6cvFxMzCaWuoQmVXtVwhB9SYC2YQBg1r6Zn4LamREzELqCWjPeh0X3Q1GOdWK2
	 AuKMzu/sqgV4g1/BytPKjuGuNSpFyhlYCAyObIW4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 690C03A700002076; Thu, 6 Nov 2025 10:10:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4762776292212
X-SMAIL-UIID: ED1AA25D3DDB430BA2E549C9090DC073-20251106-101049-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
Date: Thu,  6 Nov 2025 10:10:38 +0800
Message-ID: <20251106021039.8866-1-hdanton@sina.com>
In-Reply-To: <690b6b46.050a0220.3d0d33.0054.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

> Date: Wed, 05 Nov 2025 07:20:38 -0800
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ba36dd5ee6fd Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1759afe2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c74292580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107bffe2580000

#syz test

--- x/sound/usb/pcm.c
+++ y/sound/usb/pcm.c
@@ -1470,6 +1470,21 @@ static void fill_playback_urb_dsd_bitrev
 	urb_ctx_queue_advance(subs, urb, bytes);
 }
 
+static int copy_to_urb_prepare(struct snd_usb_substream *subs, struct urb *urb,
+			int offset, int stride, unsigned int bytes)
+{
+	if (subs->hwptr_done + bytes > subs->buffer_bytes) {
+		;
+	} else {
+		struct snd_urb_ctx *ctx = urb->context;
+
+		if (bytes > ctx->buffer_size ||
+		    offset > ctx->buffer_size - bytes)
+			return -EAGAIN;
+	}
+	return 0;
+}
+
 static void copy_to_urb(struct snd_usb_substream *subs, struct urb *urb,
 			int offset, int stride, unsigned int bytes)
 {
@@ -1607,9 +1622,12 @@ static int prepare_playback_urb(struct s
 			fill_playback_urb_dsd_bitrev(subs, urb, bytes);
 		} else {
 			/* usual PCM */
-			if (!subs->tx_length_quirk)
+			if (!subs->tx_length_quirk) {
+				int ret = copy_to_urb_prepare(subs, urb, 0, stride, bytes);
+				if (ret)
+					return ret;
 				copy_to_urb(subs, urb, 0, stride, bytes);
-			else
+			} else
 				bytes = copy_to_urb_quirk(subs, urb, stride, bytes);
 			/* bytes is now amount of outgoing data */
 		}
--

