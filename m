Return-Path: <linux-kernel+bounces-828838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB8BB95972
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94EE7A44B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C4732142E;
	Tue, 23 Sep 2025 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="int40/Ke"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285619D8BC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626051; cv=none; b=eVPneNjstiIM2nqF+AbA8ctRi11JoSQX+y/u/Sw/UJbtf2uZaYSxgpS+dFLFgI3Sr7RwUP28XcRCNepR6E5bUdr2ysPlUVK/wGpKGuPN8ikC6i4//w6JQmLDujx0LETHN3PVI1jK8M3wVgj6XMnoaixPSwpP7zdTx7MeWrtX9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626051; c=relaxed/simple;
	bh=NtBg6lVGLD23m8ViCHQxEao+WhxkvUxMWdUudUvBUEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAAgfQsEB+HAmUdqJpfZYk4gRhkr9Jv4n7ACAropw/dIql7YV4a/0F7FB2tS395IoGBfl9GFoO4CWdSey2QUkIMO6pY/29YTrk6xaq8vQ2E9VE6tWgogECrcmxkEONB63ESRxrnISSlt6tcwSfIEDnb+ykonCbfxLMjjPJbXFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=int40/Ke; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758626048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQMQG8fWhRjQm9CiQMxIb6RaemQpq6cgNt3hXJ9KhWI=;
	b=int40/KexSfW4jYJAffLolF5x8+PcsAaz+L9HSzZnKn/cabG90jdpynaw8BgBg3ZfyD+RT
	oEbYbBU82RjBpU+XpIfCA1xw1BN+YbHoUbTZuFW9gpDqowBeyFiWMmJ8KdNG8fs/GNdaEn
	evVQyuJS44ASApfOaV2F8dwik6Ufcg4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-L7rU29FRP1-cG0sQRxu0AQ-1; Tue, 23 Sep 2025 07:14:01 -0400
X-MC-Unique: L7rU29FRP1-cG0sQRxu0AQ-1
X-Mimecast-MFC-AGG-ID: L7rU29FRP1-cG0sQRxu0AQ_1758626040
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-89021b2593aso5486387241.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626040; x=1759230840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQMQG8fWhRjQm9CiQMxIb6RaemQpq6cgNt3hXJ9KhWI=;
        b=T1TNiBnVEbm3REwE5ZBp6SKxZ0z/ZwBH2znEjQa/jZbsOjITiSPm6IPPWh0HTA1vKL
         FqreBvHxmj1lwAjhPfYj6nJgkQNDlPBsTj85OMDZV7xrQ2UNob1JDCBvuAvsTfCPzgZy
         OwwTsyL363DpmSDLXfLvVkxSj89OOE8cGZCSZaKHf/bnEo0OCfGmOke4JU66n2H9qyIc
         VkCWGkWUpcOgZTTITd5dvWD3QqDtd9WuZA+pXsOL0loM66Ws8kKpYYh18Jej55er3vpq
         vZlfPLdaSONpUUe5B+uBm3b4wnucDuzL/mzidzmXvbZM34AsKqW7l0gFs7yoCcSVGSkH
         ZLcA==
X-Forwarded-Encrypted: i=1; AJvYcCWyHN6I23EQIMwgHAyAXJwr7qtwYsbwMNQ/qddteQNLFa/DTYhGgdoXL3cjk4+I+U0ZLh0ilKIEAZNqcsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsG81BM+L+OsrMf5f5yiYWgJf/O75Iki5bpv0TzE0RcEfypMo
	1ydMx1tuOU/80M1WgjlDrNbr6db7oAiqnZn4wC+m+W049LWv9d/5yJ6l2NCMg7Pb64rLC6wSACB
	oRRuxtq3ZbzWJfmlbwRjcIQu0X/6JXN8nuQEHbb87OvXTuI6XYsS60HLNpZjMVIxRhveLyMJM1u
	KyoWJlHOt4Uuak9Uk8XvriKu8+J+mkYNkiF12YLBZX
X-Gm-Gg: ASbGncur9oFj9UY8NMKi5bHX6oatcqJTWRbWUyaQF1KjzkTqXOZGrO5i6GYdVx0OtjA
	JSVJZFTC9NvgZLLQHsomKliRrVYVWnXBPMEceFU2I4rZ5RhhifnfkRHE6mc6LXITqgt/M1ZRGJ0
	1cwtUdpWi+mAZtQzvB3LGxiA==
X-Received: by 2002:a05:6102:3912:b0:5a4:69bc:a9e with SMTP id ada2fe7eead31-5a5787acc29mr789849137.22.1758626040512;
        Tue, 23 Sep 2025 04:14:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9LLX5hlEF0Z4AJHVhdXDkLKWR1JC7ys5Jmy2COBIfd1gqCWZCD6mtxIA76KkRRZI1BuSPkt7G2DegWJT/mUM=
X-Received: by 2002:a05:6102:3912:b0:5a4:69bc:a9e with SMTP id
 ada2fe7eead31-5a5787acc29mr789841137.22.1758626040139; Tue, 23 Sep 2025
 04:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com> <20250923075520.3746244-3-yukuai1@huaweicloud.com>
In-Reply-To: <20250923075520.3746244-3-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 19:13:48 +0800
X-Gm-Features: AS18NWClSAsndd4eLRRx4vZjiAuXo_RH3DcRyAhNh0wbnCTkNfVKC19V8nGzT6Y
Message-ID: <CAFj5m9Jjwcurm-EuM177ermySQEctDgwOFh8vHiczEfz_xtrmg@mail.gmail.com>
Subject: Re: [PATCH for-6.18/block 2/2] blk-cgroup: fix possible deadlock
 while configuring policy
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Following deadlock can be triggered easily by lockdep:
>
> WARNING: possible circular locking dependency detected
> 6.17.0-rc3-00124-ga12c2658ced0 #1665 Not tainted
> ------------------------------------------------------
> check/1334 is trying to acquire lock:
> ff1100011d9d0678 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0=
x53/0x180
>
> but task is already holding lock:
> ff1100011d9d00e0 (&q->q_usage_counter(queue)#3){++++}-{0:0}, at: del_gend=
isk+0xba/0x110
>
> which lock already depends on the new lock.
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&q->q_usage_counter(queue)#3){++++}-{0:0}:
>        blk_queue_enter+0x40b/0x470
>        blkg_conf_prep+0x7b/0x3c0
>        tg_set_limit+0x10a/0x3e0
>        cgroup_file_write+0xc6/0x420
>        kernfs_fop_write_iter+0x189/0x280
>        vfs_write+0x256/0x490
>        ksys_write+0x83/0x190
>        __x64_sys_write+0x21/0x30
>        x64_sys_call+0x4608/0x4630
>        do_syscall_64+0xdb/0x6b0
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> -> #1 (&q->rq_qos_mutex){+.+.}-{4:4}:
>        __mutex_lock+0xd8/0xf50
>        mutex_lock_nested+0x2b/0x40
>        wbt_init+0x17e/0x280
>        wbt_enable_default+0xe9/0x140
>        blk_register_queue+0x1da/0x2e0
>        __add_disk+0x38c/0x5d0
>        add_disk_fwnode+0x89/0x250
>        device_add_disk+0x18/0x30
>        virtblk_probe+0x13a3/0x1800
>        virtio_dev_probe+0x389/0x610
>        really_probe+0x136/0x620
>        __driver_probe_device+0xb3/0x230
>        driver_probe_device+0x2f/0xe0
>        __driver_attach+0x158/0x250
>        bus_for_each_dev+0xa9/0x130
>        driver_attach+0x26/0x40
>        bus_add_driver+0x178/0x3d0
>        driver_register+0x7d/0x1c0
>        __register_virtio_driver+0x2c/0x60
>        virtio_blk_init+0x6f/0xe0
>        do_one_initcall+0x94/0x540
>        kernel_init_freeable+0x56a/0x7b0
>        kernel_init+0x2b/0x270
>        ret_from_fork+0x268/0x4c0
>        ret_from_fork_asm+0x1a/0x30
>
> -> #0 (&q->sysfs_lock){+.+.}-{4:4}:
>        __lock_acquire+0x1835/0x2940
>        lock_acquire+0xf9/0x450
>        __mutex_lock+0xd8/0xf50
>        mutex_lock_nested+0x2b/0x40
>        blk_unregister_queue+0x53/0x180
>        __del_gendisk+0x226/0x690
>        del_gendisk+0xba/0x110
>        sd_remove+0x49/0xb0 [sd_mod]
>        device_remove+0x87/0xb0
>        device_release_driver_internal+0x11e/0x230
>        device_release_driver+0x1a/0x30
>        bus_remove_device+0x14d/0x220
>        device_del+0x1e1/0x5a0
>        __scsi_remove_device+0x1ff/0x2f0
>        scsi_remove_device+0x37/0x60
>        sdev_store_delete+0x77/0x100
>        dev_attr_store+0x1f/0x40
>        sysfs_kf_write+0x65/0x90
>        kernfs_fop_write_iter+0x189/0x280
>        vfs_write+0x256/0x490
>        ksys_write+0x83/0x190
>        __x64_sys_write+0x21/0x30
>        x64_sys_call+0x4608/0x4630
>        do_syscall_64+0xdb/0x6b0
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> other info that might help us debug this:
>
> Chain exists of:
>   &q->sysfs_lock --> &q->rq_qos_mutex --> &q->q_usage_counter(queue)#3
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&q->q_usage_counter(queue)#3);
>                                lock(&q->rq_qos_mutex);
>                                lock(&q->q_usage_counter(queue)#3);
>   lock(&q->sysfs_lock);
>
> Root cause is that queue_usage_counter is grabbed with rq_qos_mutex
> held in blkg_conf_prep(), while queue should be freezed before
> rq_qos_mutex from other context.
>
> The blk_queue_enter() from blkg_conf_prep() is used to protect against
> policy deactivation, which is already protected with blkcg_mutex, hence
> convert blk_queue_enter() to blkcg_mutex to fix this problem. Meanwhile,
> consider that blkcg_mutex is held after queue is freezed from policy
> deactivation, also convert blkg_alloc() to use GFP_NOIO.

Looks good, and seems one example of abusing blk_queue_enter():

Reviewed-by: Ming Lei <ming.lei@redhat.com>


