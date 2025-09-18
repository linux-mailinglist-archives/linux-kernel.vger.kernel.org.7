Return-Path: <linux-kernel+bounces-823001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E11B85441
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70372188F6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EAB30BF71;
	Thu, 18 Sep 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9QCy94D"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C830C60C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205825; cv=none; b=Qax2wLIXIBDQ387IjmoDjN0EPp1URLbf/zX10VKhyf/mYQVsT1MfJFXUzZYb/8AkugqGRFFYWW6tZdSFdvUCfQJAC+uEuwPCmvSzAwZ1FI2gG+e+d0TSXP6L508AKxZI8mmtKEX9c6s8HDC6p5QZeGhNaVW8Z8nsXBXLCwv7hKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205825; c=relaxed/simple;
	bh=GeaYUd1ph4vSEBD35eRX1HG2ODoim8Vu8j+apB+JjIw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iy9lknsd2dT94g3qXzYByMV3qXkVjgN5Uf0HLWg2zBlmuuu9zxhZosp6vgPjLiESYQiJk8TyUamwKXm7ggKnxKOkVKEgzJwJLn3q2NGwQjY03KvLSX0FoOta7F/VrpCPuMeTKwDRorJ7VXRJ3cV9YFmwoAn4hLmoPYqrRsNHUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9QCy94D; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-76b8fd4ba2cso8593406d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758205822; x=1758810622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/l9erxsdcSr9+0YzCbf1buRKP1JbKApLHH5RwRYulY=;
        b=I9QCy94Do+SLBCbmzIqhAhzI529VxWZDoxPtIuSsb189yr3Ac+UR+SA8EpeRx7nxYL
         57jxXcNMUHlUiHIjxkRQIfjcjM5gOOogoG8HHYh1zwVWuyx/6s5CQHkyn5itU4mhwu2B
         wi2q+ptE61l++Xy3kveXF2FrjaQJ7f798+8WxQwe6Jqa/VvWLDGSJlJDGBXBth6OR/r0
         cVlsVK1T2zKipgJfbceHHWQQqRkjwEgPSUr5KAyPi3D6psLBHNTfPLyNkRKQrUOl2l/U
         rYm2dZxi3/T54Fix2zbhAbqnhOizBMv6P7qdSfuq+2ey6Ykw22g1j/5hPmUkTA2hnUA/
         KmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205822; x=1758810622;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8/l9erxsdcSr9+0YzCbf1buRKP1JbKApLHH5RwRYulY=;
        b=TZWn9IV0ZH8TbaisDbzlXk2PMmBV2u7T9bPRXKjUFt90A9B40PT8SWE/9dXjKXN/A/
         ftUCoaR2bqzZw2/6MZLAn7dLShXZdQZwjhGlu005FXZaJeMDYEm8N+GqYyoU6RmpvsuL
         iu2iu7DnPsjLll1h2FbL/xC+MIRcE3F0HQyLcncjRP47G4quvWVvMWDjTOMwIFD0IdkL
         Z0OJy5FbLoiWa0baFQ3sEqeRKqhR0kVxrkNTvvXNbMCfERuzJJV/of1qOjjzK/vrjV8v
         uvjiZQRNqRO5P8zgfB3VwY8/liyI/ntrFAgqL0gYnbAL85LG5chs4MeWZef9cRYVuy/E
         IntQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6QaNMew8qOw/qVG6qCinhNpUKvjEhagczbQaY9WgCGVZE8j4rlNsEi1YccIz8HsARH7KsMR0YSHtS0C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNswgVi3DW0ruBtSB/qWFVR7/noXy/BnyeF1WmsKYVph3UV5Dr
	PGNcMGHWem4MXU5z4NDSqHQkGDQsmVSN7KGpXkLUuYai2+MKW20uvRDt
X-Gm-Gg: ASbGncuiKgvAHjbjtjfXaCDo4V2vpl/doancaXZuzYSrpS1kYxKSOrc6/tsiq2Hefij
	SgNu3iByeVqdbbkUL6m7IiAf7raFYGX82ymCWDLJEVSCbIKeq/gt025iIJyEWDe7Bai9PPoAbOU
	nLMzyvNHoGryjDJnq8ioLSuPP0gXOhEkbn9yqXzDgqt9emY5kuxlNAEILdsOkJFcAzbkhrz1uNm
	U52HrnDy3vdtqeqOYSqMwfk8KsBUN8XUTGmXRl1GvkwqRDSiDVbedT3H/2e0lOCS0O3IdAmTY+q
	QKJtovUJ/0OWGiIQJYrcU89mIcHzhhqpB7paKjDRqXqDjKmU4EzKl5ydkFAwEiWIHgKSQ364dBg
	FdRxQUioajfWCtKPFrmLudHP8OvG6oCWE2a4RkoiaBGUr+QxQQfJoZBSY4wYEK7nPPO+pSHmPmW
	zmrgYOkOddGQop4zGTrLrm
X-Google-Smtp-Source: AGHT+IH6EN6B/8RH3mnO//gU+5krVawcCPmxHp5vIUrs67A6otL45HQmsf8S2szBQGwJ3sINej20ag==
X-Received: by 2002:a05:6214:f23:b0:783:f54f:4187 with SMTP id 6a1803df08f44-78ecd6daa90mr71087456d6.28.1758205820473;
        Thu, 18 Sep 2025 07:30:20 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-79356b3e5cesm13504216d6.73.2025.09.18.07.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:30:19 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:30:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Liang <wangliang74@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 sdf@fomichev.me, 
 lorenzo@kernel.org, 
 toke@redhat.com
Cc: yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, 
 wangliang74@huawei.com, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1aca4aa96eb20@gmail.com>
In-Reply-To: <20250917113919.3991267-1-wangliang74@huawei.com>
References: <20250917113919.3991267-1-wangliang74@huawei.com>
Subject: Re: [PATCH net] net: tun: Update napi->skb after XDP process
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Liang wrote:
> The syzbot report a UAF issue:
> 
>   BUG: KASAN: slab-use-after-free in skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>   BUG: KASAN: slab-use-after-free in napi_frags_skb net/core/gro.c:723 [inline]
>   BUG: KASAN: slab-use-after-free in napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>   Read of size 8 at addr ffff88802ef22c18 by task syz.0.17/6079
>   CPU: 0 UID: 0 PID: 6079 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>    print_address_description mm/kasan/report.c:378 [inline]
>    print_report+0xca/0x240 mm/kasan/report.c:482
>    kasan_report+0x118/0x150 mm/kasan/report.c:595
>    skb_reset_mac_header include/linux/skbuff.h:3150 [inline]
>    napi_frags_skb net/core/gro.c:723 [inline]
>    napi_gro_frags+0x6e/0x1030 net/core/gro.c:758
>    tun_get_user+0x28cb/0x3e20 drivers/net/tun.c:1920
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
>   Allocated by task 6079:
>    kasan_save_stack mm/kasan/common.c:47 [inline]
>    kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>    unpoison_slab_object mm/kasan/common.c:330 [inline]
>    __kasan_mempool_unpoison_object+0xa0/0x170 mm/kasan/common.c:558
>    kasan_mempool_unpoison_object include/linux/kasan.h:388 [inline]
>    napi_skb_cache_get+0x37b/0x6d0 net/core/skbuff.c:295
>    __alloc_skb+0x11e/0x2d0 net/core/skbuff.c:657
>    napi_alloc_skb+0x84/0x7d0 net/core/skbuff.c:811
>    napi_get_frags+0x69/0x140 net/core/gro.c:673
>    tun_napi_alloc_frags drivers/net/tun.c:1404 [inline]
>    tun_get_user+0x77c/0x3e20 drivers/net/tun.c:1784
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>   Freed by task 6079:
>    kasan_save_stack mm/kasan/common.c:47 [inline]
>    kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
>    kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:576
>    poison_slab_object mm/kasan/common.c:243 [inline]
>    __kasan_slab_free+0x5b/0x80 mm/kasan/common.c:275
>    kasan_slab_free include/linux/kasan.h:233 [inline]
>    slab_free_hook mm/slub.c:2422 [inline]
>    slab_free mm/slub.c:4695 [inline]
>    kmem_cache_free+0x18f/0x400 mm/slub.c:4797
>    skb_pp_cow_data+0xdd8/0x13e0 net/core/skbuff.c:969
>    netif_skb_check_for_xdp net/core/dev.c:5390 [inline]
>    netif_receive_generic_xdp net/core/dev.c:5431 [inline]
>    do_xdp_generic+0x699/0x11a0 net/core/dev.c:5499
>    tun_get_user+0x2523/0x3e20 drivers/net/tun.c:1872
>    tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1996
>    new_sync_write fs/read_write.c:593 [inline]
>    vfs_write+0x5c9/0xb30 fs/read_write.c:686
>    ksys_write+0x145/0x250 fs/read_write.c:738
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> After commit e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in
> generic mode"), the original skb may be freed in skb_pp_cow_data() when
> XDP program was attached, which was allocated in tun_napi_alloc_frags().
> However, the napi->skb still point to the original skb, update it after
> XDP process.
> 
> Reported-by: syzbot+64e24275ad95a915a313@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=64e24275ad95a915a313
> Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/net/tun.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index cc6c50180663..47ddcb4b9a78 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1875,6 +1875,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  				local_bh_enable();
>  				goto unlock_frags;
>  			}
> +
> +			if (frags && skb != tfile->napi.skb)
> +				tfile->napi.skb = skb;

This is observed with tun because syzkaller can fuzz napi with that.
That unfortunately added fuzz test coverage to a combination that is
not intended for real use: XDP generic before napi frags.

Tun is the only driver that calls do_xdp_generic on a napi.skb and
later passes this napi to napi_gro_frags.

But this is no longer a napi frags skb on which napi_gro_frags
(and napi_frags_skb and gro_pull_from_frag0) should be called? As the
skb now has a linear part. Not sure that the frag0 is still correct.



