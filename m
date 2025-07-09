Return-Path: <linux-kernel+bounces-724573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3981FAFF47C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7462E587077
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88FF2405E5;
	Wed,  9 Jul 2025 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ORGtRIHC"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4223B619
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099204; cv=none; b=OubXioRtIdNSy9yWq2pCsRDBq0titruS50iTHyeDwkFY/DEugw4g3FmoTyg3K0ymCCtIEEFTFxyImy5z33FfC4sjGTf+hKyoygx5ex+CcpbjjEbMRzp28wzaZ3U5PQ5k+4jvsfzy47J4SVkonGcNIWH0CJiDKehvoHLCm9SrMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099204; c=relaxed/simple;
	bh=F/aBzL5MxypW67sm3TXJiNfH2DEbXqW0GNJIMAGNYDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5ZW0y1sNYySXNcFoUqK06kcsiQrT2vB954HNepDPHqYwY1GOO96dlZkulLvQR/thTQT1QQ7gDJifaAgY16QvxB3aw0VV+XERbDbx3GTKlBtR1n9eAqg0gTloLfunAYpZKxLbf5UVPygzfnVIRM99dFZTAW6zqqz3T5Mv2ubeWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ORGtRIHC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23649faf69fso3667975ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1752099202; x=1752704002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VvzjCdSx7v9OBBUQT8jW0h+9h79cJsKqx6rjxsmuCE8=;
        b=ORGtRIHCet0y2nTFWy3bwhuaT0K+/GpjEXxMdp8vHjRwWCFmEVUCHYK0fGqvRzDxH2
         1Gt9s8qIs5W+asUMuKRNLDBRdsSGWqNDS8HaWF+5NG0Mlwv5pTeNFJ7178mrduXht7uP
         kI4on8AOkaCVIG4njxBHcPTqEQK25CLHp1NxUjlcipnXmyxNfMgmqb6gyCpOnPMEKdm8
         GAd9O9BFZjvHO/PdPomb+T3M2u/sW0PCovaLL9eS6s5scI3As87JxfI64fljFd+dL4EI
         yHqxaNO8bKA8oyGFXpAgps/p+nee3TDvVs8v2EX+OCBk95zXDLwW9Z/rqhch/38a4fBm
         1rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752099202; x=1752704002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvzjCdSx7v9OBBUQT8jW0h+9h79cJsKqx6rjxsmuCE8=;
        b=t4ROHErtfth6jhV/wTBn2ER1oDtxVPxR1zhGEc2mNIzUjvolCKMrzhh9JDujTqGbbR
         Fhnl7jA1+LBdtaO1vF1TWoiY4+meqOBkSWgKCje4vnYcmh+gFzvjGpitg7AoMFu3c7TV
         bwFrI01xBz8SvN3/DG2adtUq2vbD0eJzKAKly3EzLHSYbkok0nRq3gvBkk4EQDgpAH/g
         MKKGLfC7LgPjQCxnYjnden/cWwjDe8+KZnwhi+FBIZ5KqfiLbvAv5BOeylOBjcY6KWTx
         G6ThuFIixH6BRWHr5oSmhtaUg7yIG/R1aHFqOdBWuYmWIvITC9tVvZtW8QxR0TuZUeq0
         fSXw==
X-Forwarded-Encrypted: i=1; AJvYcCW20g5WoFXqGFlf7OtVc6ctLV7xINsfCnEBnD/6n3mzcyynba9qL8YjhNBsTu/Gh+WplcbMc2189BZBop8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1D49FscGQiBkuk20znj20AApsm3BhPZj/2Yw//WEbTgwsBDHt
	/XvznsgDF6APcMq0lrWuypdH+XDi4M3fPkP2SUoY/ezc7oQ2Vm/4etBjM4o/7oas+gM=
X-Gm-Gg: ASbGncthDakB3TKsI+ZYVoSSA5gI3IAAQTXOUGLkE9mPxBrVAJfX9vmVoFZW41tKiPo
	p+oBaUc9AFBNsmaUPSNbAcdMvbHJIhlpAGbAonE7mqyuoNBshsifEAS1uPOfBm1P/td4dDE0CKv
	g/JmEd7gg0GDUtnxa8RmUaqdbaRO7PjC3NY6aOpNqkeX0QuRSe0ilTev2lAL/kAJUJPwfZTyzht
	xvsWMsaB5v9yhBAjxX7riIj6RLCRJtghkluIg/6jHxDI6xCuP0Hs4Z9YdUl4kDkmofUWw0ZAGE4
	bZzny0lEPQqG/LCqpnoCXflVGx3Mc0j8M8Awy889QNKdzjY3Jwy56iU3ykvvvHsGC9qnejKFepT
	6UhPEsxSdqdpLbYaMJbrpxDBUBd2bniGDpB3Cgw==
X-Google-Smtp-Source: AGHT+IHQpQaKHvKBIlU8wVAu7+lWu9Hnji74A2TlYBwB4JAiauLUrIYpFw6DibPiQ/Wh4eFdfoRuPA==
X-Received: by 2002:a17:902:c94b:b0:234:d431:ec6e with SMTP id d9443c01a7336-23de480ae21mr1986975ad.3.1752099201653;
        Wed, 09 Jul 2025 15:13:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad2f1sm2498805ad.63.2025.07.09.15.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:13:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uZd2U-000000091Hj-1wkr;
	Thu, 10 Jul 2025 08:13:18 +1000
Date: Thu, 10 Jul 2025 08:13:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+3470c9ffee63e4abafeb@syzkaller.appspotmail.com>
Cc: cem@kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_ilock_attr_map_shared
 (2)
Message-ID: <aG7pfqqhk47YXFNz@dread.disaster.area>
References: <686ea951.050a0220.385921.0016.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686ea951.050a0220.385921.0016.GAE@google.com>

On Wed, Jul 09, 2025 at 10:39:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    733923397fd9 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f53582580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
> dashboard link: https://syzkaller.appspot.com/bug?extid=3470c9ffee63e4abafeb
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-73392339.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/be7feaa77b8c/vmlinux-73392339.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a663b3e31463/bzImage-73392339.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3470c9ffee63e4abafeb@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.16.0-rc5-syzkaller-00038-g733923397fd9 #0 Not tainted
> ------------------------------------------------------
> syz.0.0/5339 is trying to acquire lock:
> ffffffff8e247500 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:318 [inline]
> ffffffff8e247500 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages+0x153/0x610 mm/page_alloc.c:4727
> 
> but task is already holding lock:
> ffff888053415098 (&xfs_nondir_ilock_class){++++}-{4:4}, at: xfs_ilock_attr_map_shared+0x92/0xd0 fs/xfs/xfs_inode.c:85
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (&xfs_nondir_ilock_class){++++}-{4:4}:
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>        down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
>        xfs_reclaim_inode fs/xfs/xfs_icache.c:1045 [inline]
>        xfs_icwalk_process_inode fs/xfs/xfs_icache.c:1737 [inline]
>        xfs_icwalk_ag+0x12c5/0x1ab0 fs/xfs/xfs_icache.c:1819
>        xfs_icwalk fs/xfs/xfs_icache.c:1867 [inline]
>        xfs_reclaim_inodes_nr+0x1e3/0x260 fs/xfs/xfs_icache.c:1111
>        super_cache_scan+0x41b/0x4b0 fs/super.c:228
>        do_shrink_slab+0x6ec/0x1110 mm/shrinker.c:437
>        shrink_slab+0xd74/0x10d0 mm/shrinker.c:664
>        shrink_one+0x28a/0x7c0 mm/vmscan.c:4939
>        shrink_many mm/vmscan.c:5000 [inline]
>        lru_gen_shrink_node mm/vmscan.c:5078 [inline]
>        shrink_node+0x314e/0x3760 mm/vmscan.c:6060
>        kswapd_shrink_node mm/vmscan.c:6911 [inline]
>        balance_pgdat mm/vmscan.c:7094 [inline]
>        kswapd+0x147c/0x2830 mm/vmscan.c:7359
>        kthread+0x70e/0x8a0 kernel/kthread.c:464
>        ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3168 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>        validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>        __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>        lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>        __fs_reclaim_acquire mm/page_alloc.c:4045 [inline]
>        fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4059
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        prepare_alloc_pages+0x153/0x610 mm/page_alloc.c:4727
>        __alloc_frozen_pages_noprof+0x123/0x370 mm/page_alloc.c:4948
>        alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2419
>        alloc_frozen_pages_noprof mm/mempolicy.c:2490 [inline]
>        alloc_pages_noprof+0xa9/0x190 mm/mempolicy.c:2510
>        get_free_pages_noprof+0xf/0x80 mm/page_alloc.c:5018
>        __kasan_populate_vmalloc mm/kasan/shadow.c:362 [inline]
>        kasan_populate_vmalloc+0x33/0x1a0 mm/kasan/shadow.c:417
>        alloc_vmap_area+0xd51/0x1490 mm/vmalloc.c:2084
>        __get_vm_area_node+0x1f8/0x300 mm/vmalloc.c:3179
>        __vmalloc_node_range_noprof+0x301/0x12f0 mm/vmalloc.c:3845
>        __vmalloc_node_noprof mm/vmalloc.c:3948 [inline]
>        __vmalloc_noprof+0xb1/0xf0 mm/vmalloc.c:3962
>        xfs_buf_alloc_backing_mem fs/xfs/xfs_buf.c:239 [inline]

KASAN is still failing to pass through __GFP_NOLOCKDEP allocation
context flags. It's also failing to pass through other important
context restrictions like GFP_NOFS, GFP_NOIO, __GFP_NOFAIL, etc.

Fundamentally, it's a bug to be doing nested GFP_KERNEL allocations
inside an allocation context that has a more restricted allocation
context...

#syz set subsystems: kasan

-- 
Dave Chinner
david@fromorbit.com

