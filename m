Return-Path: <linux-kernel+bounces-797528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587DFB4119E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF667AB598
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F252C1DE2D8;
	Wed,  3 Sep 2025 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HF8AGVbi"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582B145FE0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756861567; cv=none; b=qiL6QpTrXHvU5NoNa3IBzDOqj2KTmNYTcpYr2lx9gZzKVrPVQUlOppl0pK5JiTkJb0vU5LLFjO8BZgtzDua/jwOzuAcshidGKJkELvGmYo2PUOM6zt9xvcixqumU85FxoP3+ZuxNjJTwWuvDWiKH5V1pLprpVo7nr4rW8BkAWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756861567; c=relaxed/simple;
	bh=ra+p6TZQcgZZ2E99PhvDOuVVhvsPJd84Yxww2xvwCwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkuwhJ5XhxgjXPmVE1IRXccbYGXTu6//P3XbaU3M2mQLzcUqpA3tqTSo2sqhbt+wZ5dsTqj/kSIoqrOUTf5Wck8Y19NvZc1AX5iJV1r2kZmqsSO8nmRR0KadmX+aj31Efququob60avliZSamW5aRuvWgVj9L04xWpRVohUmsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HF8AGVbi; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-327f8726b95so454174a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1756861561; x=1757466361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jB3dP3b8cnCoPrbFfvd9yJTcJBoQKWrnu2BmXh0t59g=;
        b=HF8AGVbidmZ8JCh4Kl3jXhzs1FSfU+OofgOvxtVHSLAT7XKFfWahnlcuDTGbV4eH0R
         cNYHNoquVqd8DDJSXH+F211ZKca0v0ScOxJnH+KMWR0DRLF2ETpOz/yseoDFcdm7fOsO
         wlSfvMIXOFpbYQjB239afWkGn6N86nZg+tZcymCaa1rnsKqX/0DSCIRyQZRncp4mFKrY
         KqUzM4+Vua5rO4ZQqwo1FOvjLPQk3eDnJko2XEyfntxXAwJsaJxmie6z588Oa0/ZTTcq
         ZtOE7yjmSJhbz5JJ/d1o6/h8xasdyka6Dj80BAiSb82LIpUnOZB4AcCMzY2SLDZMYkmF
         yWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756861561; x=1757466361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB3dP3b8cnCoPrbFfvd9yJTcJBoQKWrnu2BmXh0t59g=;
        b=j7z55eWl0wZZZcxlY142MFdWxgMwulSg3/q1EUVC2qAs3rF+/pfCM8zCWakrkITsiG
         WVk7D10IufMIxvTjpXg6guy9AO6tEjeljgBX3zwIlldxDSElEH6zA7AhJW0GAU3W5tfY
         fgYXgc/KT9I+Bd5danXSNoi+UHNPHsNkam5A1SbM1NVTCIa8Y71fgzNtEp4xxm89EjET
         xb5NmEjQ11ckpJObPTjsggSAyqgv2mG7qSNo7WLzW74t0YgZ2LlxgO1bScuim+uPmnwg
         VPJvcCUZtDFftSPmzkMwvtYgM47JW8QzY9rCzIyl6Y9G7FoPGHzLHxV80z2V21xfL6oU
         V1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA+034U3OpseYqVZppgktPMRaiWDO2p9KlDNeLAWgjJK6MoggnRwzehhmjdbB3VQx+Jm+InJXYuNrTG7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRjZoMur+HfANZQkW/+ysLOLAwuyEw8X4+3mbHorRrcH2b1RT
	bNuBL0yy02oDNvai4UjyKFgrCiczLZfMAwG3NaUEJMw5JE/Gu6pwMOLo2r+eqG+Dgu8=
X-Gm-Gg: ASbGncv9NEVQV1BPB7qlAknGfEkosVAyk+Yh+G9aaxpAlzbfLplJ+ndup3eCnACS8SJ
	akRY2G8rTnEgAIg2UPn9U0nIiQBuLid79iZYYJwtY8XzYFXbCb3BGE1zXTC9qrE4OopbOGaB7cq
	tClms3MT878Ya+RGoDe3Lmmff79CFCSTmRHszPlG8miui7jVSw1gMJOdKpwMe/NxQPoV9VYJAxa
	HSKGrGiQc+l6uMxYc4io9mjlrF9vbZ8ibm3bQYUkwYW6lUEEg7p/CmfqMkJu4iarw7ACkH+Acu9
	xRYSR5EoybiYePtWmTV/fZgF9KrehmHkVLTDH9ZDs1NBdTZAmVYA+9BZW7rheeTbkff3ExenY8+
	tNbq4KX5uGd4M5+jH5ttvF/X1jTjQ8l/BPXtbsrbTAN+5NsZzU2XJcLD47wU6njXE0JzpwmhwUZ
	0kqNiEPEcK9CUbKoH3Dx4=
X-Google-Smtp-Source: AGHT+IH7qFSy9CRuOGFciXJqW2uagqsYumdoYQ8sE8e4irHIEAmkKUeQvnAkSRw1h802rttC7S+fkw==
X-Received: by 2002:a17:90a:e70e:b0:329:8520:cee7 with SMTP id 98e67ed59e1d1-3298520d10bmr12612210a91.14.1756861561180;
        Tue, 02 Sep 2025 18:06:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fce1160sm21087803a91.22.2025.09.02.18.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:06:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1utbwj-0000000EWeZ-1hw0;
	Wed, 03 Sep 2025 11:05:57 +1000
Date: Wed, 3 Sep 2025 11:05:57 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+0391d34e801643e2809b@syzkaller.appspotmail.com>
Cc: cem@kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-use-after-free Read in xfs_buf_rele
 (4)
Message-ID: <aLeUdemAZ5wmtZel@dread.disaster.area>
References: <68b6d7b3.050a0220.3db4df.01cf.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b6d7b3.050a0220.3db4df.01cf.GAE@google.com>

On Tue, Sep 02, 2025 at 04:40:35AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=144aca42580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=0391d34e801643e2809b
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17161662580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124aca42580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b51a434c3e2c/mount_1.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=104aca42580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0391d34e801643e2809b@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in rht_key_hashfn include/linux/rhashtable.h:159 [inline]
> BUG: KASAN: slab-use-after-free in rht_head_hashfn include/linux/rhashtable.h:174 [inline]
> BUG: KASAN: slab-use-after-free in __rhashtable_remove_fast_one include/linux/rhashtable.h:1007 [inline]
> BUG: KASAN: slab-use-after-free in __rhashtable_remove_fast include/linux/rhashtable.h:1093 [inline]
> BUG: KASAN: slab-use-after-free in rhashtable_remove_fast include/linux/rhashtable.h:1122 [inline]
> BUG: KASAN: slab-use-after-free in xfs_buf_rele_cached fs/xfs/xfs_buf.c:926 [inline]
> BUG: KASAN: slab-use-after-free in xfs_buf_rele+0x79c/0xcfc fs/xfs/xfs_buf.c:951
> Read of size 4 at addr ffff0000ce9fe008 by task syz.2.1678/16850
> 
> CPU: 0 UID: 0 PID: 16850 Comm: syz.2.1678 Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0 PREEMPT 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
>  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>  dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
>  print_address_description+0xa8/0x238 mm/kasan/report.c:378
>  print_report+0x68/0x84 mm/kasan/report.c:482
>  kasan_report+0xb0/0x110 mm/kasan/report.c:595
>  __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
>  rht_key_hashfn include/linux/rhashtable.h:159 [inline]
>  rht_head_hashfn include/linux/rhashtable.h:174 [inline]
>  __rhashtable_remove_fast_one include/linux/rhashtable.h:1007 [inline]
>  __rhashtable_remove_fast include/linux/rhashtable.h:1093 [inline]
>  rhashtable_remove_fast include/linux/rhashtable.h:1122 [inline]
>  xfs_buf_rele_cached fs/xfs/xfs_buf.c:926 [inline]
>  xfs_buf_rele+0x79c/0xcfc fs/xfs/xfs_buf.c:951
>  xfs_buftarg_shrink_scan+0x1d8/0x270 fs/xfs/xfs_buf.c:1653
>  do_shrink_slab+0x650/0x11b0 mm/shrinker.c:437
>  shrink_slab+0xc68/0xfb8 mm/shrinker.c:664
>  drop_slab_node mm/vmscan.c:441 [inline]
>  drop_slab+0x120/0x248 mm/vmscan.c:459
>  drop_caches_sysctl_handler+0x170/0x300 fs/drop_caches.c:68

Yup, that's a real bug.

> Freed by task 6692:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x40/0x78 mm/kasan/common.c:68
>  kasan_save_free_info+0x58/0x70 mm/kasan/generic.c:576
>  poison_slab_object mm/kasan/common.c:243 [inline]
>  __kasan_slab_free+0x74/0x98 mm/kasan/common.c:275
>  kasan_slab_free include/linux/kasan.h:233 [inline]
>  slab_free_hook mm/slub.c:2417 [inline]
>  slab_free mm/slub.c:4680 [inline]
>  kfree+0x17c/0x474 mm/slub.c:4879
>  kvfree+0x30/0x40 mm/slub.c:5095
>  bucket_table_free+0xec/0x1a4 lib/rhashtable.c:114
>  rhashtable_free_and_destroy+0x70c/0x87c lib/rhashtable.c:1173
>  rhashtable_destroy+0x28/0x38 lib/rhashtable.c:1184
>  xfs_buf_cache_destroy+0x20/0x30 fs/xfs/xfs_buf.c:382
>  xfs_perag_uninit+0x28/0x38 fs/xfs/libxfs/xfs_ag.c:116
>  xfs_group_free+0x144/0x32c fs/xfs/libxfs/xfs_group.c:171
>  xfs_free_perag_range+0x58/0x8c fs/xfs/libxfs/xfs_ag.c:133
>  xfs_unmountfs+0x29c/0x310 fs/xfs/xfs_mount.c:1354
>  xfs_fs_put_super+0x6c/0x144 fs/xfs/xfs_super.c:1247
>  generic_shutdown_super+0x12c/0x2b8 fs/super.c:643
>  kill_block_super+0x44/0x90 fs/super.c:1766
>  xfs_kill_sb+0x20/0x58 fs/xfs/xfs_super.c:2317

And this is it - we can't tear down the buffer cache hash table
until the buftarg shrinker has been shut down. This doesn't happen
until xfs_mount_free() is called from the VFS. Hence freeing the
rhashtable from xfs_perag_uninit() can race with the shrinker
processing a dispose list and removing items from the rhashtable
whilst unmount is "uninitialising" the perag structures and killing
the buffer cache rhashtable.

It is worth noting that xfs_buftarg_drain() does not guarantee that
the shrinker is not running - all it does is run until the LRU is
empty. If the shrinker is also running and is processing a dispose
list (i.e. buffers it has already removed from the LRU), then
xfs_buftarg_drain() will return whilst those buffers are still in
the buffer hash table and being processed by the shrinker.

Hence the unmount process can free the buftarg rhashtable whilst the
shrinker is still processing buffers during unmount. The buffers
still ahve passive refs to the perag whilst they are on the dispose
list, so this should have thrown refcount warnings in the log before
KASAN threw the UAF.

Yup, there it is:

[  256.307175][ T6692] XFS (loop3): Internal error atomic_read(&xg->xg_ref) != 0 at line 162 of file fs/xfs/libxfs/xfs_group.c.  Caller xfs_group_free+0x1d8/0x32c

I'm not sure when this got broken - it might even be a zero-day
rhashtable conversion bug.

I think that the buftarg rhashtable needs to initialised before the
shrinker is registered, then freed from xfs_destroy_buftarg() after
the shrinker has been shut down as it must live longer than the
buftarg shrinker instance. i.e. the buftarg rhashtable needs to have
the same life cycle as the buftarg LRU list....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

