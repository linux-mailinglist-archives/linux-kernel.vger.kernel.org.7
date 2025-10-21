Return-Path: <linux-kernel+bounces-862872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544CBF6688
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6200A503002
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115D1B3937;
	Tue, 21 Oct 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqI6yB9L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFF78F20
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049101; cv=none; b=W93KPg9AZtg2rmoTw0nWAu9M3DJM87Igv+DRVzq18dC43P+Yv+JPTt+rd7UtFkQPo/TJ2kizgpP5ZgypDR6I3AzLTPFOyF4FsQBSqPWlCM4UoJkpkGgZn0VHyBhzrgJfo3eAO7LzQGcPYQScGpClLGmljCzAp6Z/qFyTsvRuw9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049101; c=relaxed/simple;
	bh=7Lgoiwjl/od68osOpTtq5J0RcJeY1CiHKuIYbISCEz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfwENV63DKj3fZ4TNJGC7tzVkeElvjgnn0DuQieVyY9S0BANPqaAVDkW5t3FAzqZrnre4+lIBrHaBtlut9gLNgEuHpYzRjWTpifSb2Fw/n7zxe2KodASl4A2ph/sCtwJ40NTD9r/apyUakAA5RbBVXlipN5LhjZK3M574mI98qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqI6yB9L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k+LZadQHcc5lPuQgV1/qH071R/fgxqRR9HkFuoRLpvc=;
	b=JqI6yB9Lj5kcAoVircGEi3a/5nve4FkG94FS3eb5GE/lp+pF8WuSCcKnM5IN2APSvp3cjf
	4537dxK/T+cDtqS7cvjlnNqxszlP6ueSuLPmYbj/arrJ7K4QO4XwGfLQHG2fQ8w2x663Sp
	uZWfD8AArHVdMFo4i84X1dBgX4VFqOE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-EhEyAQBjNBSbPdO-_BE2DQ-1; Tue, 21 Oct 2025 08:18:16 -0400
X-MC-Unique: EhEyAQBjNBSbPdO-_BE2DQ-1
X-Mimecast-MFC-AGG-ID: EhEyAQBjNBSbPdO-_BE2DQ_1761049095
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3152904f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049095; x=1761653895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+LZadQHcc5lPuQgV1/qH071R/fgxqRR9HkFuoRLpvc=;
        b=aKEbl1aPPNjpjPYtXgIYm26ITTQdn84n8mTEMVuVpeFmZCoJcUkwIfIYEBdXxaAb7+
         zKHFZ+z/wekAbh51VLDUTNxE/P14Om3KBnitzRFoK7Y2wHumDKR+eJx5L2srIUQgOeD7
         VvwlJ7TmJmE/XqUSIRnGrq1Hl0q9jdkgIAenjqQAok5PaRtIsQK1xKMK9V69PQSjRu1s
         uv+LQCMHB+BZOc2sJsPKTf6M5bGSrkC0UpXGl9CJhhzVebuxGauK6B4hOj/Z3cA24oY/
         HF0mODxQDAO0H5N3oFG+pVL1XnwTRD8QuP6J2VCzABrEfzhPrftg+KVN+y/bdWnsrzJw
         zP0A==
X-Forwarded-Encrypted: i=1; AJvYcCUepVVtIoOGQqW9+f3NfN+21O3cSxeZ7ZGCQ/SYoIxLWS6e/Lpc/Zh6dhP5byjcjJB3kedfnb48OhrZsaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNO/oT5hHL6oET/0F9ChQj5szt9dEXL3ZTd5Rh3bSKOItVFZC1
	xkNgfdNOfL+ji03NS5Jj3OisLqkwWtrYA4+ZAhuigCrJyF2TEZ/SS5uj2b9/VZMyuuxL8RMv/jS
	R/YNqaZVqnjY5oUSneng0CEhPw7Wd8eoJzeUgNdKxO5mlwGZLM9LXIvqCN4t75O2A2Q==
X-Gm-Gg: ASbGncuDMEu66rnaKOqRW9QVjg54LHyQPTYGW3Fwoge79UvgUuwK6RPP7P/Lws4cUy0
	bi/S8WFcm4FXXkB56ZR+GxUL9wX6d8Wqt/xMqbIbBafa06vqo4kZtHOIWMrfJnxgoNF9Sj0fDx+
	QiCX7eOzHKyJPbVDGTc4kZKZc5yNCOeEsuwJMGTKeCnpGQZMnayRLeDxTdUp0GeaWtJIAHGKEFw
	nJkw5Umj0hNoOYZYXtnK3miWi/latNfOKY1A9K4xP97D9iuTKW1jC7/KRhAwcFIrIRzyNYibj13
	iKfC9EM7/ulsGGJ31KR6sdIWVfsGsP3loYVxU/sfPbu8N2NmL5PuPkqgwWdrnEy6uA5D8IPXv7J
	n/uFfhu+Rn0VaDDmil3LqzPljYb9iHw==
X-Received: by 2002:a05:6000:40db:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-426fb6ac2abmr13518346f8f.13.1761049094874;
        Tue, 21 Oct 2025 05:18:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjFO/rF2wdbnoCBoQsPLOfZMrzxv/k/AesKe32HDnF2jRvrsH8qe+KuQfAqfKY4yy/zEiPag==
X-Received: by 2002:a05:6000:40db:b0:401:8707:8a4b with SMTP id ffacd0b85a97d-426fb6ac2abmr13518316f8f.13.1761049094344;
        Tue, 21 Oct 2025 05:18:14 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.131.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3e2sm20122476f8f.47.2025.10.21.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:18:13 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:18:11 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	syzbot <syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com>,
	anna-maria@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <jlelli@redhat.com>
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (4)
Message-ID: <aPd6A7Gj3lg-EDzq@jlelli-thinkpadt14gen4.remote.csb>
References: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
 <87qzwers0e.ffs@tglx>
 <aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb>
 <17915467-06de-46f1-9032-3af258ff1aee@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17915467-06de-46f1-9032-3af258ff1aee@linux.ibm.com>

On 21/10/25 10:12, Shrikanth Hegde wrote:
> 
> 
> On 9/11/25 2:45 PM, Juri Lelli wrote:
> > On 10/09/25 22:07, Thomas Gleixner wrote:
> > > On Fri, Aug 29 2025 at 19:00, syzbot wrote:
> > > 
> > > > HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1130eef0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=8b3a2e23253b50098164
> > > > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > > 
> > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > 
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/102656909b6f/disk-b6add54b.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/fa30d1d80a47/vmlinux-b6add54b.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/c25ee8abf30a/bzImage-b6add54b.xz
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com
> > > > 
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 1 PID: 1186 at kernel/time/hrtimer.c:1052 hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> > > > Modules linked in:
> > > > CPU: 1 UID: 0 PID: 1186 Comm: irq/33-virtio1- Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> > > > RIP: 0010:hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> > > 
> > > It compains that the timer is enqueued when it is attempted to be forwarded
> > > 
> > > > Code: 4c 89 33 48 8b 04 24 eb 07 e8 86 34 12 00 31 c0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 d8 4d 09 cc e8 6b 34 12 00 90 <0f> 0b 90 eb df 48 89 e8 4c 09 f8 48 c1 e8 20 74 0a 48 89 e8 31 d2
> > > > RSP: 0018:ffffc90000a78bd0 EFLAGS: 00010006
> > > > RAX: ffffffff81ac27e5 RBX: ffff8880b883b508 RCX: ffff888026c19dc0
> > > > RDX: 0000000000000100 RSI: 0000000000010000 RDI: 0000000000010100
> > > > RBP: 000000000009d057 R08: 0000000000010000 R09: 0000000000010100
> > > > R10: dffffc0000000000 R11: ffffffff8167a890 R12: ffff8880b883b520
> > > > R13: 0000000000184487 R14: 1ffff110171076a4 R15: 0000000000000001
> > > > FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f95323cbf98 CR3: 0000000064088000 CR4: 00000000003526f0
> > > > Call Trace:
> > > >   <IRQ>
> > > >   hrtimer_forward_now include/linux/hrtimer.h:366 [inline]
> > > >   dl_server_timer kernel/sched/deadline.c:1193 [inline]
> > > 
> > > which is strange as this is with the timer callback itself, so it
> > > shouldn't be enqueued, unless there is a possiblilty to have:
> > > 
> > >     CPU0                       CPU1
> > >     timer_expires()
> > >        callback()              ????
> > >          dl_task_timer()       rq_lock()
> > >            rq_lock()             hrtimer_start()
> > >                                rq_unlock()
> > >             hrtimer_forward()
> > > 
> > > No idea whether that's possible, but that's the only sensible
> > > explanation.
> > 
> > So, a dl_server_start() could be your ????, but it should see
> > dl_server_active and just return if the dl_server callback is running.
> > Unless a dl_server_stop() somehow interleaved as well and cleared it.
> > 
> 
> isn't dl_server timer per CPU?

Indeed you have a point. Also dl-server timers handling has changed
recently with several fixes from Peter.


