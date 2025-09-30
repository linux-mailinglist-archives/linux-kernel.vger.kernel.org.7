Return-Path: <linux-kernel+bounces-836854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243BBAABC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 01:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C41F189DF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB3261B67;
	Mon, 29 Sep 2025 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EceHNRAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E3B2144CF;
	Mon, 29 Sep 2025 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759187384; cv=none; b=ejNfYoE9C8Xxt9ACSI0Osic2FpICtoojUCpnbitgsFHs7xBOFu3rFZVZ5705ZRnnmxRP3ODbe7uIFDh/udSWtfrWjTaHmslUsEkYSA77JIcYZhS91NtriltOnhaKDZZB687dSYEFjFsak7sGejo5kWAw4gOzc/yy+kbNMSV6fxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759187384; c=relaxed/simple;
	bh=5Rp2VObYx0kEH2t4ldIcpsZPRf8/0EU63/7BOj/9Wz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1MFZF+B/YASqF/f8sAbyULxOj1GrJIB7iSVinZoudnwIa0qyGys/cLTD/AYSBvkRsgqMhJg88V3u9dWwEtmMyFrVJX3HeuOrKQYxocsleyaP963ED8+0O7ocsE8Sjose6EQJB5/WQOY3VqKFUZnJt8H3C5ZQKfD5VsplMFuaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EceHNRAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E096EC4CEF4;
	Mon, 29 Sep 2025 23:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759187383;
	bh=5Rp2VObYx0kEH2t4ldIcpsZPRf8/0EU63/7BOj/9Wz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EceHNRAQYNcooHNFJ5IyFSS6Ah4RSXMIzynDyUZmOmKYre2figdqh1O7yKV6cKZpv
	 GDYZ/X68E9ErCxMNwkpXOcZ7v110Sbqi4YVYmSt201Go77HYeV14McEp7T/pnBqR5t
	 pxa2n88TLQX/t6DT7mcavsjrh0THKXLoVJaDoYgn3znJvEgTvY0VDbnBDdx09A5PsV
	 4Kd/0aBwrzEzMIOmJzwLijumPEJw/y39R/TIz5kgOLFoJAyzDV0TzEtbC84S1sYEgz
	 SK0OPSkk/WXvXVprocMxWsomKZztQiBsztCEu4svC+WXUT4dhzzy0rbagiagIdqA3y
	 JaLQV+KlG32CQ==
Date: Mon, 29 Sep 2025 19:09:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: syzbot <syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [trace?] possible deadlock in ring_buffer_map
Message-ID: <20250929190201.244d5b0d@batman.local.home>
In-Reply-To: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
References: <68dafe35.a00a0220.102ee.003f.GAE@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 14:46:29 -0700
syzbot <syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    bf40f4b87761 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11161142580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
> dashboard link: https://syzkaller.appspot.com/bug?extid=c530b4d95ec5cd4f33a7
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Of course not, as I believe it has to do with another fault injection.

Just before this triggered, there's this:


[  494.628607][T14281] mmap: syz.4.2040 (14281) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.
[  494.897085][T14287] block nbd9: NBD_DISCONNECT
[  494.915292][T14285] CIFS: VFS: Invalid SecurityFlags: 
[  495.594680][T14300] ima: policy update failed
[  495.617068][   T30] audit: type=1802 audit(1758836743.046:78): pid=14300 uid=0 auid=4294967295 ses=4294967295 subj=unconfined op=policy_update cause=failed comm="syz.3.2043" res=0 errno=0
[  496.169087][T14325] ICMPv6: process `syz.3.2057' is using deprecated sysctl (syscall) net.ipv6.neigh.ipvlan1.retrans_time - use net.ipv6.neigh.ipvlan1.retrans_time_ms instead
[  496.275995][T14330] FAULT_INJECTION: forcing a failure.
[  496.275995][T14330] name failslab, interval 1, probability 0, space 0, times 0
[  496.330968][T14330] CPU: 1 UID: 0 PID: 14330 Comm: syz.2.2059 Tainted: G     U              syzkaller #0 PREEMPT(full) 
[  496.331008][T14330] Tainted: [U]=USER
[  496.331015][T14330] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
[  496.331027][T14330] Call Trace:
[  496.331035][T14330]  <TASK>
[  496.331043][T14330]  dump_stack_lvl+0x16c/0x1f0
[  496.331081][T14330]  should_fail_ex+0x512/0x640
[  496.331113][T14330]  ? kmem_cache_alloc_noprof+0x5a/0x3b0
[  496.331143][T14330]  should_failslab+0xc2/0x120
[  496.331173][T14330]  kmem_cache_alloc_noprof+0x6d/0x3b0
[  496.331202][T14330]  ? vma_merge_new_range+0x3ae/0xa50
[  496.331227][T14330]  ? vm_area_alloc+0x1f/0x160
[  496.331256][T14330]  vm_area_alloc+0x1f/0x160
[  496.331278][T14330]  __mmap_region+0xf90/0x27b0
[  496.331305][T14330]  ? __pfx___mmap_region+0x10/0x10
[  496.331340][T14330]  ? is_bpf_text_address+0x8a/0x1a0
[  496.331368][T14330]  ? bpf_ksym_find+0x124/0x1c0
[  496.331391][T14330]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  496.331420][T14330]  ? is_bpf_text_address+0x94/0x1a0
[  496.331448][T14330]  ? kernel_text_address+0x8d/0x100
[  496.331470][T14330]  ? __kernel_text_address+0xd/0x40
[  496.331557][T14330]  ? trace_cap_capable+0x18d/0x200
[  496.331596][T14330]  mmap_region+0x1ab/0x3f0
[  496.331625][T14330]  ? __get_unmapped_area+0x267/0x440
[  496.331662][T14330]  do_mmap+0xa3e/0x1210
[  496.331701][T14330]  ? __pfx_do_mmap+0x10/0x10
[  496.331733][T14330]  ? __pfx_down_write_killable+0x10/0x10
[  496.331763][T14330]  vm_mmap_pgoff+0x29e/0x470
[  496.331801][T14330]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  496.331833][T14330]  ? __fget_files+0x20e/0x3c0
[  496.331868][T14330]  ksys_mmap_pgoff+0x7d/0x5c0
[  496.331899][T14330]  ? __pfx_ksys_write+0x10/0x10
[  496.331931][T14330]  __x64_sys_mmap+0x125/0x190
[  496.331974][T14333] block nbd9: NBD_DISCONNECT
[  496.331967][T14330]  do_syscall_64+0xcd/0x4c0
[  496.332004][T14330]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I wonder if this leaked a cpu read lock or something to trigger the
lockdep bug later on?

-- Steve


> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/14d0f00fdd13/disk-bf40f4b8.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/28a0a02e6595/vmlinux-bf40f4b8.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5cd55b81a693/bzImage-bf40f4b8.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c530b4d95ec5cd4f33a7@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Tainted: G     U             
> ------------------------------------------------------
> syz.0.2065/14355 is trying to acquire lock:
> ffff88801b880488 (&buffer->mutex#2){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:228 [inline]
> ffff88801b880488 (&buffer->mutex#2){+.+.}-{4:4}, at: ring_buffer_map+0x145/0xcc0 kernel/trace/ring_buffer.c:7238
> 
> but task is already holding lock:
> ffff88801b8889f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:228 [inline]
> ffff88801b8889f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: ring_buffer_map+0xdf/0xcc0 kernel/trace/ring_buffer.c:7228
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #9 (&cpu_buffer->mapping_lock){+.+.}-{4:4}:  
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        class_mutex_constructor include/linux/mutex.h:228 [inline]
>        ring_buffer_map+0xdf/0xcc0 kernel/trace/ring_buffer.c:7228
>        tracing_buffers_mmap+0x120/0x1c0 kernel/trace/trace.c:8626
>        vfs_mmap include/linux/fs.h:2290 [inline]
>        mmap_file mm/internal.h:167 [inline]
>        __mmap_new_file_vma mm/vma.c:2413 [inline]
>        __mmap_new_vma mm/vma.c:2476 [inline]
>        __mmap_region+0x1314/0x27b0 mm/vma.c:2669
>        mmap_region+0x1ab/0x3f0 mm/vma.c:2739
>        do_mmap+0xa3e/0x1210 mm/mmap.c:558
>        vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
>        ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:604
>        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>        __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #8 (&mm->mmap_lock){++++}-{4:4}:  
>        __might_fault mm/memory.c:6958 [inline]
>        __might_fault+0x113/0x190 mm/memory.c:6952
>        _inline_copy_from_user include/linux/uaccess.h:162 [inline]
>        _copy_from_user+0x29/0xd0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:212 [inline]
>        csum_and_copy_from_user include/net/checksum.h:31 [inline]
>        copy_from_user_iter_csum net/core/skbuff.c:7323 [inline]
>        iterate_ubuf include/linux/iov_iter.h:30 [inline]
>        iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
>        csum_and_copy_from_iter_full+0x21a/0x1f90 net/core/skbuff.c:7335
>        ip_generic_getfrag+0x170/0x270 net/ipv4/ip_output.c:940
>        raw6_getfrag+0x22d/0x2a0 net/ipv6/raw.c:737
>        __ip6_append_data+0x3e1b/0x4750 net/ipv6/ip6_output.c:1706
>        ip6_append_data+0x1bd/0x4c0 net/ipv6/ip6_output.c:1860
>        rawv6_sendmsg+0x163d/0x4820 net/ipv6/raw.c:911
>        inet_sendmsg+0x11c/0x140 net/ipv4/af_inet.c:851
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg net/socket.c:729 [inline]
>        ____sys_sendmsg+0x973/0xc70 net/socket.c:2614
>        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>        __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #7 (sk_lock-AF_INET6){+.+.}-{0:0}:  
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3711
>        lock_sock include/net/sock.h:1669 [inline]
>        inet_autobind+0x1a/0x1a0 net/ipv4/af_inet.c:178
>        inet_send_prepare+0x31b/0x530 net/ipv4/af_inet.c:837
>        inet_sendmsg+0x43/0x140 net/ipv4/af_inet.c:848
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg net/socket.c:729 [inline]
>        sock_sendmsg+0x37f/0x470 net/socket.c:752
>        __sock_xmit+0x1e7/0x4f0 drivers/block/nbd.c:574
>        sock_xmit drivers/block/nbd.c:602 [inline]
>        send_disconnects drivers/block/nbd.c:1395 [inline]
>        nbd_disconnect+0x392/0x550 drivers/block/nbd.c:1410
>        nbd_disconnect_and_put+0x2e/0x1c0 drivers/block/nbd.c:2245
>        nbd_genl_disconnect+0x396/0x570 drivers/block/nbd.c:2291
>        genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
>        genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>        genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
>        netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>        netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>        netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>        netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>        sock_sendmsg_nosec net/socket.c:714 [inline]
>        __sock_sendmsg net/socket.c:729 [inline]
>        ____sys_sendmsg+0xa98/0xc70 net/socket.c:2614
>        ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>        __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #6 (&nsock->tx_lock){+.+.}-{4:4}:  
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
>        nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1204
>        blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
>        blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
>        blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1220
>        blk_finish_plug block/blk-core.c:1247 [inline]
>        blk_finish_plug block/blk-core.c:1244 [inline]
>        __submit_bio+0x545/0x690 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
>        submit_bio_noacct+0xc20/0x1ed0 block/blk-core.c:874
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
>        filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2413
>        do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
>        read_mapping_folio include/linux/pagemap.h:991 [inline]
>        read_part_sector+0xd4/0x370 block/partitions/core.c:722
>        adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
>        blkdev_get_whole+0x187/0x290 block/bdev.c:748
>        bdev_open+0x2c7/0xe40 block/bdev.c:957
>        blkdev_open+0x34e/0x4f0 block/fops.c:694
>        do_dentry_open+0x982/0x1530 fs/open.c:965
>        vfs_open+0x82/0x3f0 fs/open.c:1095
>        do_open fs/namei.c:3887 [inline]
>        path_openat+0x1de4/0x2cb0 fs/namei.c:4046
>        do_filp_open+0x20b/0x470 fs/namei.c:4073
>        do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
>        do_sys_open fs/open.c:1450 [inline]
>        __do_sys_openat fs/open.c:1466 [inline]
>        __se_sys_openat fs/open.c:1461 [inline]
>        __x64_sys_openat+0x174/0x210 fs/open.c:1461
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #5 (&cmd->lock){+.+.}-{4:4}:  
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1196
>        blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2120
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2358
>        blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2919
>        blk_mq_flush_plug_list block/blk-mq.c:2967 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2939
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1220
>        blk_finish_plug block/blk-core.c:1247 [inline]
>        blk_finish_plug block/blk-core.c:1244 [inline]
>        __submit_bio+0x545/0x690 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x660/0xd30 block/blk-core.c:751
>        submit_bio_noacct+0xc20/0x1ed0 block/blk-core.c:874
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
>        filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2413
>        do_read_cache_folio+0x263/0x5c0 mm/filemap.c:3957
>        read_mapping_folio include/linux/pagemap.h:991 [inline]
>        read_part_sector+0xd4/0x370 block/partitions/core.c:722
>        adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
>        blkdev_get_whole+0x187/0x290 block/bdev.c:748
>        bdev_open+0x2c7/0xe40 block/bdev.c:957
>        blkdev_open+0x34e/0x4f0 block/fops.c:694
>        do_dentry_open+0x982/0x1530 fs/open.c:965
>        vfs_open+0x82/0x3f0 fs/open.c:1095
>        do_open fs/namei.c:3887 [inline]
>        path_openat+0x1de4/0x2cb0 fs/namei.c:4046
>        do_filp_open+0x20b/0x470 fs/namei.c:4073
>        do_sys_openat2+0x11b/0x1d0 fs/open.c:1435
>        do_sys_open fs/open.c:1450 [inline]
>        __do_sys_openat fs/open.c:1466 [inline]
>        __se_sys_openat fs/open.c:1461 [inline]
>        __x64_sys_openat+0x174/0x210 fs/open.c:1461
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (set->srcu){.+.+}-{0:0}:  
>        srcu_lock_sync include/linux/srcu.h:173 [inline]
>        __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1429
>        blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
>        blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
>        blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
>        blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
>        elevator_switch+0x17d/0x810 block/elevator.c:588
>        elevator_change+0x391/0x580 block/elevator.c:690
>        elevator_set_default+0x2e9/0x380 block/elevator.c:766
>        blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:904
>        __add_disk+0x74a/0xf00 block/genhd.c:528
>        add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
>        add_disk include/linux/blkdev.h:774 [inline]
>        nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1973
>        nbd_init+0x181/0x320 drivers/block/nbd.c:2680
>        do_one_initcall+0x120/0x6e0 init/main.c:1269
>        do_initcall_level init/main.c:1331 [inline]
>        do_initcalls init/main.c:1347 [inline]
>        do_basic_setup init/main.c:1366 [inline]
>        kernel_init_freeable+0x5c2/0x910 init/main.c:1579
>        kernel_init+0x1c/0x2b0 init/main.c:1469
>        ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #3 (&q->elevator_lock){+.+.}-{4:4}:  
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        queue_requests_store+0x1c7/0x310 block/blk-sysfs.c:80
>        queue_attr_store+0x26b/0x310 block/blk-sysfs.c:831
>        sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>        kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
>        new_sync_write fs/read_write.c:593 [inline]
>        vfs_write+0x7d0/0x11d0 fs/read_write.c:686
>        ksys_write+0x12a/0x250 fs/read_write.c:738
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #2 (&q->q_usage_counter(io)#61){++++}-{0:0}:  
>        blk_alloc_queue+0x619/0x760 block/blk-core.c:461
>        blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4400
>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4447
>        nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1943
>        nbd_init+0x181/0x320 drivers/block/nbd.c:2680
>        do_one_initcall+0x120/0x6e0 init/main.c:1269
>        do_initcall_level init/main.c:1331 [inline]
>        do_initcalls init/main.c:1347 [inline]
>        do_basic_setup init/main.c:1366 [inline]
>        kernel_init_freeable+0x5c2/0x910 init/main.c:1579
>        kernel_init+0x1c/0x2b0 init/main.c:1469
>        ret_from_fork+0x56d/0x730 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:  
>        __fs_reclaim_acquire mm/page_alloc.c:4234 [inline]
>        fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4248
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4142 [inline]
>        slab_alloc_node mm/slub.c:4220 [inline]
>        __do_kmalloc_node mm/slub.c:4375 [inline]
>        __kmalloc_node_noprof+0xbe/0x500 mm/slub.c:4382
>        kmalloc_node_noprof include/linux/slab.h:932 [inline]
>        __rb_allocate_pages+0x4b8/0xeb0 kernel/trace/ring_buffer.c:2246
>        ring_buffer_resize+0x71a/0x15c0 kernel/trace/ring_buffer.c:2986
>        __tracing_resize_ring_buffer kernel/trace/trace.c:5987 [inline]
>        __tracing_resize_ring_buffer kernel/trace/trace.c:5968 [inline]
>        tracing_update_buffers+0x15e/0x1f0 kernel/trace/trace.c:6219
>        ftrace_event_write+0x14a/0x2c0 kernel/trace/trace_events.c:1506
>        vfs_write+0x2a0/0x11d0 fs/read_write.c:684
>        ksys_write+0x12a/0x250 fs/read_write.c:738
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (&buffer->mutex#2){+.+.}-{4:4}:  
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        class_mutex_constructor include/linux/mutex.h:228 [inline]
>        ring_buffer_map+0x145/0xcc0 kernel/trace/ring_buffer.c:7238
>        tracing_buffers_mmap+0x120/0x1c0 kernel/trace/trace.c:8626
>        vfs_mmap include/linux/fs.h:2290 [inline]
>        mmap_file mm/internal.h:167 [inline]
>        __mmap_new_file_vma mm/vma.c:2413 [inline]
>        __mmap_new_vma mm/vma.c:2476 [inline]
>        __mmap_region+0x1314/0x27b0 mm/vma.c:2669
>        mmap_region+0x1ab/0x3f0 mm/vma.c:2739
>        do_mmap+0xa3e/0x1210 mm/mmap.c:558
>        vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
>        ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:604
>        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>        __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &buffer->mutex#2 --> &mm->mmap_lock --> &cpu_buffer->mapping_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&cpu_buffer->mapping_lock);
>                                lock(&mm->mmap_lock);
>                                lock(&cpu_buffer->mapping_lock);
>   lock(&buffer->mutex#2);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by syz.0.2065/14355:
>  #0: ffff88802cc2c260 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:415 [inline]
>  #0: ffff88802cc2c260 (&mm->mmap_lock){++++}-{4:4}, at: vm_mmap_pgoff+0x1f5/0x470 mm/util.c:578
>  #1: ffff88801b8889f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:228 [inline]
>  #1: ffff88801b8889f8 (&cpu_buffer->mapping_lock){+.+.}-{4:4}, at: ring_buffer_map+0xdf/0xcc0 kernel/trace/ring_buffer.c:7228
> 
> stack backtrace:
> CPU: 0 UID: 0 PID: 14355 Comm: syz.0.2065 Tainted: G     U              syzkaller #0 PREEMPT(full) 
> Tainted: [U]=USER
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
>  check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain kernel/locking/lockdep.c:3908 [inline]
>  __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
>  lock_acquire kernel/locking/lockdep.c:5868 [inline]
>  lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
>  __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>  __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>  class_mutex_constructor include/linux/mutex.h:228 [inline]
>  ring_buffer_map+0x145/0xcc0 kernel/trace/ring_buffer.c:7238
>  tracing_buffers_mmap+0x120/0x1c0 kernel/trace/trace.c:8626
>  vfs_mmap include/linux/fs.h:2290 [inline]
>  mmap_file mm/internal.h:167 [inline]
>  __mmap_new_file_vma mm/vma.c:2413 [inline]
>  __mmap_new_vma mm/vma.c:2476 [inline]
>  __mmap_region+0x1314/0x27b0 mm/vma.c:2669
>  mmap_region+0x1ab/0x3f0 mm/vma.c:2739
>  do_mmap+0xa3e/0x1210 mm/mmap.c:558
>  vm_mmap_pgoff+0x29e/0x470 mm/util.c:580
>  ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:604
>  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
>  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
>  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2640f8eec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f2641d8d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> RAX: ffffffffffffffda RBX: 00007f26411e5fa0 RCX: 00007f2640f8eec9
> RDX: 0000000000000001 RSI: 0000000000004000 RDI: 0000200000ffc000
> RBP: 00007f2641011f91 R08: 0000000000000003 R09: 0000000000000000
> R10: 000000000008e051 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f26411e6038 R14: 00007f26411e5fa0 R15: 00007ffd415f2788
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


