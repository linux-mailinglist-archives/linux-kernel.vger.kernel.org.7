Return-Path: <linux-kernel+bounces-811705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF04B52CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936F93A7730
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB1E2E92CF;
	Thu, 11 Sep 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anJB7vuo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E432E7F17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582119; cv=none; b=RU9fJE6Fbnm5z7Axoi0sELXaY85BY++u6hoL6DNOaZDDQejU/EGggecDjJ/Gi8SvCONvCT/0D3CkuPtWx6D6T/qpH05vd0Pc6n2GygpRntL8JZzzIbCK0ZE3mjbeKCpByTIqTeWQkCLRkuxASID1Vg1QNhx8be5qocWrDh9Jaso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582119; c=relaxed/simple;
	bh=V5wp4QWYHpbQWy7pxBoDWQrz8xt8CSDc1gGgg6V8ly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoAwYMdibFhwrGTvHcIl9icnvgqDUXcta2CGXzmYV/rF7bK/P1VQn0g38tDkmTmv+ou1zwgyoH3DmfeR7qvtmpXjR5vhM7eAbnyVlCtyYG+BRvkunDNA100ZqEFFvLXu4sZh+IP6DP5bGtPxYZ3XBPa/S5nCpB7FU0O51+w+B+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=anJB7vuo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757582115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bP363C4IBBUloP659PPbtwb4g+1ZSQS3yHRiIdffHac=;
	b=anJB7vuof8JxkZ0VPJY6HGfz7x8eYBNHBIbLkAUtTZiLyghWfcP4AnEgY/png6+eryPkb+
	EXlGv8Lu/75kxt0zlVl3/4w4Mpt8sxI+9+cnnK3xDZW8jSAvTUClYALi3JgA8eehjyIGoi
	gn5rZmCl91CVyj7wR9CdVj8lAWF3iEY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-zKx7x8msM-O0raJDw_6HMw-1; Thu, 11 Sep 2025 05:15:14 -0400
X-MC-Unique: zKx7x8msM-O0raJDw_6HMw-1
X-Mimecast-MFC-AGG-ID: zKx7x8msM-O0raJDw_6HMw_1757582113
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3df2f4aedd1so403231f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582113; x=1758186913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP363C4IBBUloP659PPbtwb4g+1ZSQS3yHRiIdffHac=;
        b=F0s75DNJ2FF4oOzI5I6ijg/RPBImNH8U6pPE4TeHOR4m6EiheOahAdcLANkzTGeRKc
         pE5MfksR4DJwLrjf5yjO473cnk3jXp12Vj+BNr1tzt7eImNw3PJYt1AOGaFld0fXfOnu
         p5x8W1Qd/krLFlyLCvXDxRMDxnH1ajpIxM7yX+3s9mZ+CgZ5WUVrSNbA9WTycwC7ersj
         kj5zs7mWsnlcbpUvOnR+M+kjET88EEs6UIbmXdUnzLmK92XzrisW2P+/MlHe2/qR5PFG
         X9RdQ7fOb89kSUztZOaJbvxvjOxls5fsPQoBEbkpQ7F2xsSitmJK+NuKXsv4/Mu7kilU
         2RoA==
X-Forwarded-Encrypted: i=1; AJvYcCXBmu/bCvRovE8F0hZpoFt12QG6zjw/mH3qsrOpTKmi7+VZ8pNXHQhITD5mrXoVaaFRhKkLUU1C6It/iQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0F8gqOXT90hOe84NAjE5ox6JlMQ4YpTVjCvl8Yuvju+rDKejg
	s08N1n8Lf2fchABio/+uu2/Fk+zu9pvshHMQdSfFN3DrqaEvBiBtEdSf7oEFhczWSBzieRyUwJ+
	J/bM/QONc5n/kQrhjEv3VphS8mqGldRt6WGAFQmTl+SagqlqkOmLEiuO6Cm7e3YU3bA==
X-Gm-Gg: ASbGncu8c/ZJ1wwNloBxO+Obxjaw7O2hPHFHNuItf/DsLKfYfg+RxmOlNDcwSiZ2uc2
	djc0U+nC+8Aa8sxPi5RhznVrRbVkKx7Vn+FQ4YFrN4GpJ91jkpASUfVceX/ka4TO+SsRUsjyw7P
	54w6YvVnf381RAH2F1pt0C/yQau+xOFQJFJFEfiEC6aKCi/yBDQFR1VUIsGuPOoJVLI5T60zMjS
	7uCZLpBORL4LtIDO5nnpc90mCyQhUaP1e+XjBF6tPy+inscrxgZWc+qtpy9IxmK/OLard5cI0jM
	4UercN2mTAJzL/Vgw5MtLLiuCzHFCGmiQohjlkVJGJALv7x2Rz1YVfnVUy0IrYu1V+0pi60=
X-Received: by 2002:a5d:5f82:0:b0:3e7:4271:8c6d with SMTP id ffacd0b85a97d-3e742718faemr13364611f8f.34.1757582113147;
        Thu, 11 Sep 2025 02:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo3X6W4SKrx3s/9NhBkGMLV8zs65vUtFUzNHLfTLLO0iFLUsOceX53P//veXSkvqoiE83q0A==
X-Received: by 2002:a5d:5f82:0:b0:3e7:4271:8c6d with SMTP id ffacd0b85a97d-3e742718faemr13364587f8f.34.1757582112668;
        Thu, 11 Sep 2025 02:15:12 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76077584esm1722290f8f.11.2025.09.11.02.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:15:11 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:15:08 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com>,
	anna-maria@linutronix.de, frederic@kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <jlelli@redhat.com>
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (4)
Message-ID: <aMKTHKfegBk4DgjA@jlelli-thinkpadt14gen4.remote.csb>
References: <68b25b42.a70a0220.1c57d1.00f6.GAE@google.com>
 <87qzwers0e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzwers0e.ffs@tglx>

On 10/09/25 22:07, Thomas Gleixner wrote:
> On Fri, Aug 29 2025 at 19:00, syzbot wrote:
> 
> > HEAD commit:    b6add54ba618 Merge tag 'pinctrl-v6.17-2' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1130eef0580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=8b3a2e23253b50098164
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/102656909b6f/disk-b6add54b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/fa30d1d80a47/vmlinux-b6add54b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c25ee8abf30a/bzImage-b6add54b.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+8b3a2e23253b50098164@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 1186 at kernel/time/hrtimer.c:1052 hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 1186 Comm: irq/33-virtio1- Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> > RIP: 0010:hrtimer_forward+0x1d6/0x2b0 kernel/time/hrtimer.c:1052
> 
> It compains that the timer is enqueued when it is attempted to be forwarded
> 
> > Code: 4c 89 33 48 8b 04 24 eb 07 e8 86 34 12 00 31 c0 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 01 d8 4d 09 cc e8 6b 34 12 00 90 <0f> 0b 90 eb df 48 89 e8 4c 09 f8 48 c1 e8 20 74 0a 48 89 e8 31 d2
> > RSP: 0018:ffffc90000a78bd0 EFLAGS: 00010006
> > RAX: ffffffff81ac27e5 RBX: ffff8880b883b508 RCX: ffff888026c19dc0
> > RDX: 0000000000000100 RSI: 0000000000010000 RDI: 0000000000010100
> > RBP: 000000000009d057 R08: 0000000000010000 R09: 0000000000010100
> > R10: dffffc0000000000 R11: ffffffff8167a890 R12: ffff8880b883b520
> > R13: 0000000000184487 R14: 1ffff110171076a4 R15: 0000000000000001
> > FS:  0000000000000000(0000) GS:ffff8881269c2000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f95323cbf98 CR3: 0000000064088000 CR4: 00000000003526f0
> > Call Trace:
> >  <IRQ>
> >  hrtimer_forward_now include/linux/hrtimer.h:366 [inline]
> >  dl_server_timer kernel/sched/deadline.c:1193 [inline]
> 
> which is strange as this is with the timer callback itself, so it
> shouldn't be enqueued, unless there is a possiblilty to have:
> 
>    CPU0                       CPU1
>                                 
>    timer_expires()
>       callback()              ????
>         dl_task_timer()       rq_lock()
>           rq_lock()             hrtimer_start()
>                               rq_unlock()
>            hrtimer_forward()
> 
> No idea whether that's possible, but that's the only sensible
> explanation.

So, a dl_server_start() could be your ????, but it should see
dl_server_active and just return if the dl_server callback is running.
Unless a dl_server_stop() somehow interleaved as well and cleared it.

If we had a reproducer maybe some tracing would help reducing the
guessing. :)

Thanks,
Juri


