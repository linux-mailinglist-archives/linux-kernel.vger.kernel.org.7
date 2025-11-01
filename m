Return-Path: <linux-kernel+bounces-881407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A03CC28252
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E01C3BA20E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7031D2571D8;
	Sat,  1 Nov 2025 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiXOOzGJ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE9259CA0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013677; cv=none; b=XPv1+egcfw3C00HkOQFLF5mSNtgpfUCOzAVWds/wfc4OU9H/SI6vEnG797lP/x8u8V8cGvlIF9TQtvHlxrtXP1Sk5d2vDTzZfQr8K9OacnmWeW9ufKCF27mmpcCJ1TABYI6LyyjTQT6dybertJFKFdy1ys0mXrqsaQGXz9EWY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013677; c=relaxed/simple;
	bh=glD9YUK66zNDN5tvFfmpD59vlaJQtT+KazTn/gzq1Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIaLWlHTPIuYnIt+hMQO1NkOQf3yXwD9PJ3zKhBWGiiT10FCqVrbwHgNqE5YJAJhV1dmEEaFn89BYTRiKgX7UxA5nm7pN8UigK9N1FKj0yNmvwsipFewdMEsZMGj/drYw/kA1an5S1eVfs4QcRE6UOTF9w8yS+hRHGCeQGmwMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiXOOzGJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295247a814bso23787395ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762013674; x=1762618474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0VVOPFGNqZxWLjcPxZHY3pwKLOJGpCx2gYYUsTkw98=;
        b=OiXOOzGJasY1MKNN6e5YSpNu4IhBGtHzwBjfp/yy8XZaLs18qg2ynIZRbVNkfYj+Q0
         H0AD/cfFREmkh3p0DhD5MbHbdHB+0ntvArSjqmzSLuKGe+MfnOserk7AMOLJkTuaPr1v
         vhEkODcl0Ief17+H44qHIxR1d0PFLMp7Psv0nU/ODUo08NHhnPGWoAE2o7Q5GQPl7YZD
         aqwk7BQyjlJpHJcGdIOd56D+TxCYTc6eTgZ5spwevbWrGC/nU4ujHA2fnPOu+Rgw0Wil
         rfgCdPjerSYKUBHp/HqVn+8jHjg2roSxUWjyQiTxppGR3kas+ftcLJE6WNvJDSTVyq1I
         aRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762013674; x=1762618474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0VVOPFGNqZxWLjcPxZHY3pwKLOJGpCx2gYYUsTkw98=;
        b=tn+84ObyH4JbpVPOS5eiderOtRGaDGgyz4TMJErZpJXjaKG6ZZfpyWqCE5ccz3d8Xu
         Rgiy3/7XmqXa3vZvqVBSKfeEF68k6/RV428J6CDcjw7fPUX1H3TmL8SqewO/Y+ZIIJKa
         xSBiL+0bzn9xbf3WBojzzeGgMmxezLtYfvi2P7VoIjCFDXi0W+afQ5ecUc0USCorkz6g
         vDpdITcAw+nSZxOH1gXITK9xm7pjrI1OU/GVSRHjn1rfRDIR+o0g50cEhZx+dpKTnySL
         Tv/ZHxleB0+70u56+1u8+ocfyOewPhjV2FhLJSoeWTCHopyuE3PRTtkxma2XEVjuIo5P
         EQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfmzFMw/OL6IOdG8c64M+5TWsYjuPjFPxoRojsq/AJcQoTwsAfd0ACZe4SDbJ8iCm5Kj2HhWQTPC8LFuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqO3wL8K2wCnEnEeK5sdjZ0XKb/mEQvgjvRwfmMz3SZfldDIA
	YLkJIoBBskBdUJRd8U4yHRFZGWYotvOYZEuEvk5hH2bviBQ3yImMcXw2
X-Gm-Gg: ASbGnctk9dzX6b3PPprvDnsoz0iARomF2xBtsAjtaEKp7Q8NX6NU0s4E8lVEENImv2W
	XQea+xC7duT00dTU7IqxvVOr3MyXKF7xpdSHVKbuoajfGG5l9/ihtZdTz/t8gHdU3fUnyEne+W1
	Y81eOqT9c329XweEJgWCqCvyQray0BG+TE4Q4z7sdnRf65N9V3jP0D5L9/opbMrjZwpClQf87x4
	Bs8MkED4T4c6XaRwulV7I9Nt5GeO3vHCkwDzuick7efFIZEj0415+rBv2ZNO7m9F7loFS7ywWd0
	/jlW/oAQTlcuiA4zETC6JMv87aUCWki5e2VuK/PH7dW+ijSrCMr2arpFQPhOUbh8u/eFz8y0a5h
	GJ4D91phjdAjWdUSXHmDjP4ri1N5kPSPIuGELTZidLLYrXWDOxBrniy70BBeWM7vBCQlaoCbj6T
	4PGtrtQUAxv5Nc
X-Google-Smtp-Source: AGHT+IHN0y7sON+faPm48FjlWrhktSmV+dTMcFYFDjkUeKCSzm3MXacCB3qeyREgWewnhdn1tGJ1Qw==
X-Received: by 2002:a17:902:d48f:b0:24c:c8e7:60b5 with SMTP id d9443c01a7336-2951a38ba91mr106200445ad.16.1762013674162;
        Sat, 01 Nov 2025 09:14:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86cdd2sm5626310b3a.58.2025.11.01.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:14:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 1 Nov 2025 09:14:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, will@kernel.org, ryan.roberts@arm.com,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, ardb@kernel.org, dev.jain@arm.com,
	scott@os.amperecomputing.com, cl@gentwo.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 3/5] arm64: mm: support large block mapping when
 rodata=full
Message-ID: <f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-4-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917190323.3828347-4-yang@os.amperecomputing.com>

Hi,

On Wed, Sep 17, 2025 at 12:02:09PM -0700, Yang Shi wrote:
> When rodata=full is specified, kernel linear mapping has to be mapped at
> PTE level since large page table can't be split due to break-before-make
> rule on ARM64.
> 
> This resulted in a couple of problems:
>   - performance degradation
>   - more TLB pressure
>   - memory waste for kernel page table
> 
> With FEAT_BBM level 2 support, splitting large block page table to
> smaller ones doesn't need to make the page table entry invalid anymore.
> This allows kernel split large block mapping on the fly.
> 
> Add kernel page table split support and use large block mapping by
> default when FEAT_BBM level 2 is supported for rodata=full.  When
> changing permissions for kernel linear mapping, the page table will be
> split to smaller size.
> 
> The machine without FEAT_BBM level 2 will fallback to have kernel linear
> mapping PTE-mapped when rodata=full.
> 
> With this we saw significant performance boost with some benchmarks and
> much less memory consumption on my AmpereOne machine (192 cores, 1P)
> with 256GB memory.
> 
> * Memory use after boot
> Before:
> MemTotal:       258988984 kB
> MemFree:        254821700 kB
> 
> After:
> MemTotal:       259505132 kB
> MemFree:        255410264 kB
> 
> Around 500MB more memory are free to use.  The larger the machine, the
> more memory saved.
> 
> * Memcached
> We saw performance degradation when running Memcached benchmark with
> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
> With this patchset we saw ops/sec is increased by around 3.5%, P99
> latency is reduced by around 9.6%.
> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
> MPKI is reduced by 28.5%.
> 
> The benchmark data is now on par with rodata=on too.
> 
> * Disk encryption (dm-crypt) benchmark
> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with
> disk encryption (by dm-crypt).
> fio --directory=/data --random_generator=lfsr --norandommap            \
>     --randrepeat 1 --status-interval=999 --rw=write --bs=4k --loops=1  \
>     --ioengine=sync --iodepth=1 --numjobs=1 --fsync_on_close=1         \
>     --group_reporting --thread --name=iops-test-job --eta-newline=1    \
>     --size 100G
> 
> The IOPS is increased by 90% - 150% (the variance is high, but the worst
> number of good case is around 90% more than the best number of bad
> case). The bandwidth is increased and the avg clat is reduced
> proportionally.
> 
> * Sequential file read
> Read 100G file sequentially on XFS (xfs_io read with page cache
> populated). The bandwidth is increased by 150%.
> 

With lock debugging enabled, we see a large number of "BUG: sleeping
function called from invalid context at kernel/locking/mutex.c:580"
and "BUG: Invalid wait context:" backtraces when running v6.18-rc3.
Please see example below.

Bisect points to this patch.

Please let me know if there is anything I can do to help tracking
down the problem.

Thanks,
Guenter

---
Example log:

[    0.537499] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
[    0.537501] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    0.537502] preempt_count: 1, expected: 0
[    0.537504] 2 locks held by swapper/0/1:
[    0.537505]  #0: ffffb60b01211960 (sched_domains_mutex){+.+.}-{4:4}, at: sched_domains_mutex_lock+0x24/0x38
[    0.537510]  #1: ffffb60b01595838 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x40
[    0.537516] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-dbg-DEV #1 NONE
[    0.537517] Call trace:
[    0.537518]  show_stack+0x20/0x38 (C)
[    0.537520]  __dump_stack+0x28/0x38
[    0.537522]  dump_stack_lvl+0xac/0xf0
[    0.537525]  dump_stack+0x18/0x3c
[    0.537527]  __might_resched+0x248/0x2a0
[    0.537529]  __might_sleep+0x40/0x90
[    0.537531]  __mutex_lock_common+0x70/0x1818
[    0.537533]  mutex_lock_nested+0x34/0x48
[    0.537534]  split_kernel_leaf_mapping+0x74/0x1a0
[    0.537536]  update_range_prot+0x40/0x150
[    0.537537]  __change_memory_common+0x30/0x148
[    0.537538]  __kernel_map_pages+0x70/0x88
[    0.537540]  __free_frozen_pages+0x6e4/0x7b8
[    0.537542]  free_frozen_pages+0x1c/0x30
[    0.537544]  __free_slab+0xf0/0x168
[    0.537547]  free_slab+0x2c/0xf8
[    0.537549]  free_to_partial_list+0x4e0/0x620
[    0.537551]  __slab_free+0x228/0x250
[    0.537553]  kfree+0x3c4/0x4c0
[    0.537555]  destroy_sched_domain+0xf8/0x140
[    0.537557]  cpu_attach_domain+0x17c/0x610
[    0.537558]  build_sched_domains+0x15a4/0x1718
[    0.537560]  sched_init_domains+0xbc/0xf8
[    0.537561]  sched_init_smp+0x30/0x98
[    0.537562]  kernel_init_freeable+0x148/0x230
[    0.537564]  kernel_init+0x28/0x148
[    0.537566]  ret_from_fork+0x10/0x20
[    0.537569] =============================
[    0.537569] [ BUG: Invalid wait context ]
[    0.537571] 6.18.0-dbg-DEV #1 Tainted: G        W
[    0.537572] -----------------------------
[    0.537572] swapper/0/1 is trying to lock:
[    0.537573] ffffb60b011f3830 (pgtable_split_lock){+.+.}-{4:4}, at: split_kernel_leaf_mapping+0x74/0x1a0
[    0.537576] other info that might help us debug this:
[    0.537577] context-{5:5}
[    0.537578] 2 locks held by swapper/0/1:
[    0.537579]  #0: ffffb60b01211960 (sched_domains_mutex){+.+.}-{4:4}, at: sched_domains_mutex_lock+0x24/0x38
[    0.537582]  #1: ffffb60b01595838 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x0/0x40
[    0.537585] stack backtrace:
[    0.537585] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.18.0-dbg-DEV #1 NONE
[    0.537587] Tainted: [W]=WARN
[    0.537588] Call trace:
[    0.537589]  show_stack+0x20/0x38 (C)
[    0.537591]  __dump_stack+0x28/0x38
[    0.537593]  dump_stack_lvl+0xac/0xf0
[    0.537596]  dump_stack+0x18/0x3c
[    0.537598]  __lock_acquire+0x980/0x2a20
[    0.537600]  lock_acquire+0x124/0x2b8
[    0.537602]  __mutex_lock_common+0xd8/0x1818
[    0.537604]  mutex_lock_nested+0x34/0x48
[    0.537605]  split_kernel_leaf_mapping+0x74/0x1a0
[    0.537607]  update_range_prot+0x40/0x150
[    0.537608]  __change_memory_common+0x30/0x148
[    0.537609]  __kernel_map_pages+0x70/0x88
[    0.537610]  __free_frozen_pages+0x6e4/0x7b8
[    0.537613]  free_frozen_pages+0x1c/0x30
[    0.537615]  __free_slab+0xf0/0x168
[    0.537617]  free_slab+0x2c/0xf8
[    0.537619]  free_to_partial_list+0x4e0/0x620
[    0.537621]  __slab_free+0x228/0x250
[    0.537623]  kfree+0x3c4/0x4c0
[    0.537625]  destroy_sched_domain+0xf8/0x140
[    0.537627]  cpu_attach_domain+0x17c/0x610
[    0.537628]  build_sched_domains+0x15a4/0x1718
[    0.537630]  sched_init_domains+0xbc/0xf8
[    0.537631]  sched_init_smp+0x30/0x98
[    0.537632]  kernel_init_freeable+0x148/0x230
[    0.537633]  kernel_init+0x28/0x148
[    0.537635]  ret_from_fork+0x10/0x20

---
bisect:

# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'v6.18-rc1' 'v6.17'
# bad: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect bad 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# bad: [a8253f807760e9c80eada9e5354e1240ccf325f9] Merge tag 'soc-newsoc-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad a8253f807760e9c80eada9e5354e1240ccf325f9
# bad: [4b81e2eb9e4db8f6094c077d0c8b27c264901c1b] Merge tag 'timers-vdso-2025-09-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 4b81e2eb9e4db8f6094c077d0c8b27c264901c1b
# bad: [f1004b2f19d7e9add9d707f64d9fcbc50f67921b] Merge tag 'm68k-for-v6.18-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect bad f1004b2f19d7e9add9d707f64d9fcbc50f67921b
# good: [a9401710a5f5681abd2a6f21f9e76bc9f2e81891] Merge tag 'v6.18-rc-part1-smb3-common' of git://git.samba.org/ksmbd
git bisect good a9401710a5f5681abd2a6f21f9e76bc9f2e81891
# good: [fe68bb2861808ed5c48d399bd7e670ab76829d55] Merge tag 'microblaze-v6.18' of git://git.monstr.eu/linux-2.6-microblaze
git bisect good fe68bb2861808ed5c48d399bd7e670ab76829d55
# bad: [f2d64a22faeeecff385b4c91fab5fe036ab00162] Merge branch 'for-next/perf' into for-next/core
git bisect bad f2d64a22faeeecff385b4c91fab5fe036ab00162
# good: [30f9386820cddbba59b48ae0670c3a1646dd440e] Merge branch 'for-next/misc' into for-next/core
git bisect good 30f9386820cddbba59b48ae0670c3a1646dd440e
# good: [43de0ac332b815cf56dbdce63687de9acfd35d49] drivers/perf: hisi: Relax the event ID check in the framework
git bisect good 43de0ac332b815cf56dbdce63687de9acfd35d49
# good: [5973a62efa34c80c9a4e5eac1fca6f6209b902af] arm64: map [_text, _stext) virtual address range non-executable+read-only
git bisect good 5973a62efa34c80c9a4e5eac1fca6f6209b902af
# good: [b3abb08d6f628a76c36bf7da9508e1a67bf186a0] drivers/perf: hisi: Refactor the event configuration of L3C PMU
git bisect good b3abb08d6f628a76c36bf7da9508e1a67bf186a0
# good: [6d2f913fda5683fbd4c3580262e10386c1263dfb] Documentation: hisi-pmu: Add introduction to HiSilicon V3 PMU
git bisect good 6d2f913fda5683fbd4c3580262e10386c1263dfb
# good: [2084660ad288c998b6f0c885e266deb364f65fba] perf/dwc_pcie: Fix use of uninitialized variable
git bisect good 2084660ad288c998b6f0c885e266deb364f65fba
# bad: [77dfca70baefcb988318a72fe69eb99f6dabbbb1] Merge branch 'for-next/mm' into for-next/core
git bisect bad 77dfca70baefcb988318a72fe69eb99f6dabbbb1
# first bad commit: [77dfca70baefcb988318a72fe69eb99f6dabbbb1] Merge branch 'for-next/mm' into for-next/core

---
bisect into branch:

- git checkout -b testing 77dfca70baefcb988318a72fe69eb99f6dabbbb1
- git rebase 77dfca70baefcb988318a72fe69eb99f6dabbbb1~1
  [ fix minor conflict similar to the conflict resolution in 77dfca70baefc]
- git diff 77dfca70baefcb988318a72fe69eb99f6dabbbb1
  [ confirmed that there are no differences ]
- confirm that the problem is still seen at the tip of the rebase
- git bisect start HEAD 77dfca70baefcb988318a72fe69eb99f6dabbbb1~1
- run bisect

Results:

# bad: [47fc25df1ae3ae8412f1b812fb586c714d04a5e6] arm64: map [_text, _stext) virtual address range non-executable+read-only
# good: [30f9386820cddbba59b48ae0670c3a1646dd440e] Merge branch 'for-next/misc' into for-next/core
git bisect start 'HEAD' '77dfca70baefcb988318a72fe69eb99f6dabbbb1~1'
# good: [805491d19fc21271b5c27f4602f8f66b625c110f] arm64/Kconfig: Remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
git bisect good 805491d19fc21271b5c27f4602f8f66b625c110f
# bad: [13c7d7426232cc4489df7cd2e1f646a22d3f6172] arm64: mm: support large block mapping when rodata=full
git bisect bad 13c7d7426232cc4489df7cd2e1f646a22d3f6172
# good: [a4d9c67e503f2b73c2d89d8e8209dfd241bdc8d8] arm64: Enable permission change on arm64 kernel block mappings
git bisect good a4d9c67e503f2b73c2d89d8e8209dfd241bdc8d8
# first bad commit: [13c7d7426232cc4489df7cd2e1f646a22d3f6172] arm64: mm: support large block mapping when rodata=full

