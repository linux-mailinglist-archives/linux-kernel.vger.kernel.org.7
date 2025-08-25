Return-Path: <linux-kernel+bounces-784918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D04B34394
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F0820650B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D943019DA;
	Mon, 25 Aug 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WA1BJRIc"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0E30146D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131538; cv=none; b=d+dbe3yiYHxmzMvF/+Ld1rb+z06Oy2PnOLljPZt13jt0Pwz85Kzaf9jLF2IUboMNHcyCNKKlb5sgl63XfSAIUERv/VjduzUv2rPOs5b3uzHRkB3tz4oaQJECI+kWiZQMFdytzvwJV4vTs+czZFmE79xtEkrU1xtG8IQOacjygxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131538; c=relaxed/simple;
	bh=jOfg/Y1SQiSgE9mDzqKKcsPOX6RmDmlQCtjdNfhHXKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyyrP/CM0rI0Uvb4GcVEWoAEsxXA4DUVGINRJjveeYftUM3u2VkSQmENuS5T+9ZRfgcFPrWruS4iu3r6YFzqxsN7fdIW4UpZuR1V02MjVcN1Yoc61470O3C5LieN4Ij6qEm0S7yZF/aW4R3wvgOlHSM/a4ZUSOytI/QQjRTbAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WA1BJRIc; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e870316b79so505527785a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1756131535; x=1756736335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lOEWufe9UzzaHtBmn1+xpK/4JhyHrg/d+7GlDI7l5Y=;
        b=WA1BJRIcqIg7wZMMeA6VP2qTl1KcuNfDYlgg+40TWTtlMJiISRN+Y/pzhd7XSOMoEW
         vZO8TdcjggpjdxNGSlBr+zkxLzTQy/17pqyhoOQ378iZcp16t6r/XqXSKchuoZvoJy5W
         3mKXPDLV4VWhVzphAKKj8MzisA18D05LnaHoVzIqKZ4Dq7HyJ5H2vH9VCpRFS91kiig7
         7lZ+VuUf4ghU7DmRBLKg6F7AhvkjL8zw4w0ftXOEUBMIjtdW7SzYqqj4tEa3PeYHAhad
         hjuh2pOFFX3tpMCLch4ZnHIkwD7IjonIeBdFP+UiIq+tigZ1FKNAt6G1W6Zcn6wuhJ0O
         2HDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131535; x=1756736335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lOEWufe9UzzaHtBmn1+xpK/4JhyHrg/d+7GlDI7l5Y=;
        b=e4ZcWYHWqVsPPfRECuyy6rHPnyBFECr5DLWWMrlzqnCWjLdHLQR5kghutCtMCTpThn
         gn92zfGMGKR36csUknPVNUG4k4FrbKGagxCjB3oBRJM9934EdX5Moc2HjtKYQMuiPdZf
         hd44xXTzxYHlOfR28IxB+KusYwf0IKhgCpgzcXByGgVBaFXKSFFCG+hbLKHE+SqvavA5
         YVUtmMOZZ1D1GMIaSxMHLj56L4RFS1nH+nuOw7ziaYwP0JZwKz52Mlgac7vtrAV19CIR
         fxbiPZqoSgO5iGo6u7zuB0hIMno2kHFKu30e5o9ph40BvlWgcUkRt9njRmClBVnc1riy
         /1dg==
X-Forwarded-Encrypted: i=1; AJvYcCUmvLM/w1dwL8cMuQ0wwgPeZtcDFt4jmecqG5sIxecqLP1/vK4wV1Egzerx0At+Ln0Kmpjy1o5TX+qA6gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHhyJL2xN1gyr4MDz+9UorNVKnZ4xKW9otUDPtn01fq71RCyX
	U9XzJnEhKimqMu4nN9tisBzNcTB2Jx9LlcfKvKhDJr4nKMVXe4wcVHWgqZi/YytyWA==
X-Gm-Gg: ASbGncuimZ2RRBTHk9qEUsQvGko1OM0qt6h+s8FS48YFgDn8GudLJckc9g0Y6Cj2rl3
	ZpmY5afTOznbjN4BHRueCZAKp2ewxTuo4g+ts3NVaY6TQKWgkvZxO9BR/uhGxmbQMptMGSUVmfW
	gdIuj9A+cLFoGx9XB3ZEO7DOCKDQ+A52NZdGLS+g/FDKURohpBNw5W+qOf+VDE30XQIjLQ0g4cP
	yx5L5fItJNm7sndLqOHQLHKB3qxjaaGRqKG3Ztw3HgjDRx7JahkwPswVaHhT0dSMw7tpL7b+7TL
	rM5x+FUoZTJvKmVrCbPytoXGgbm/mpMEHJaxljpJWE5Gh/QkJ9OQ3QpBY2tKMuEB6BnRXKrgoot
	JwVELqWd968ttXA0SGo4Xz3tb
X-Google-Smtp-Source: AGHT+IGqROVRvsJFr2NJxQIz7E6a+HuEAlH9ebDBpqEq2it7LlxSmnRPCnHBYHexFhRqMNlgYWZSvw==
X-Received: by 2002:a05:620a:4621:b0:7e3:33e9:9d36 with SMTP id af79cd13be357-7ea1101be0amr1518331885a.50.1756131535422;
        Mon, 25 Aug 2025 07:18:55 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:156:8000:24f0::eb06])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebeca23e05sm496905585a.1.2025.08.25.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:18:54 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:18:52 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: syzbot <syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Yunseong Kim <ysk@kzalloc.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid
 context in dummy_dequeue
Message-ID: <0d6d8778-a45e-498f-9e31-1d926f582d7e@rowland.harvard.edu>
References: <68ac2411.050a0220.37038e.0087.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ac2411.050a0220.37038e.0087.GAE@google.com>

On Mon, Aug 25, 2025 at 01:51:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d245acc1e88 Merge tag 'char-misc-6.17-rc3' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e42062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> dashboard link: https://syzkaller.appspot.com/bug?extid=8baacc4139f12fa77909
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13317062580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d5ea34580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/096739d8f0ec/disk-8d245acc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/83a21aa9b978/vmlinux-8d245acc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7e7f165a3b29/bzImage-8d245acc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8baacc4139f12fa77909@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 6118, name: syz.0.17
> preempt_count: 0, expected: 0
> RCU nest depth: 0, expected: 0
> 1 lock held by syz.0.17/6118:
>  #0: ffff888144724058 (&dum_hcd->dum->lock){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
>  #0: ffff888144724058 (&dum_hcd->dum->lock){+.+.}-{3:3}, at: dummy_dequeue+0x164/0x480 drivers/usb/gadget/udc/dummy_hcd.c:769

Here's the solution that we settled on.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ 8d245acc1e88

Index: usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/dummy_hcd.c
+++ usb-devel/drivers/usb/gadget/udc/dummy_hcd.c
@@ -765,8 +765,7 @@ static int dummy_dequeue(struct usb_ep *
 	if (!dum->driver)
 		return -ESHUTDOWN;
 
-	local_irq_save(flags);
-	spin_lock(&dum->lock);
+	spin_lock_irqsave(&dum->lock, flags);
 	list_for_each_entry(iter, &ep->queue, queue) {
 		if (&iter->req != _req)
 			continue;
@@ -776,15 +775,16 @@ static int dummy_dequeue(struct usb_ep *
 		retval = 0;
 		break;
 	}
-	spin_unlock(&dum->lock);
 
 	if (retval == 0) {
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
+		spin_unlock(&dum->lock);
 		usb_gadget_giveback_request(_ep, _req);
+		spin_lock(&dum->lock);
 	}
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&dum->lock, flags);
 	return retval;
 }
 


