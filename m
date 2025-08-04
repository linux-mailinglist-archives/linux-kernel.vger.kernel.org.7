Return-Path: <linux-kernel+bounces-754639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCBB19A54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306DC3BA145
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A0212B31;
	Mon,  4 Aug 2025 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="JC/9YR5L"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB84C8F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 03:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754276547; cv=none; b=Y2pkO9XV+Um+Z9aysEZyRXZKPPziHgGQqqZlcyFW1nQEipPOC3Nat+XBQrK38gk9r5AlCvvQN78I5yAaL53gzgHxZbEWesm52aGk29jMTLZbcRnK4kJ2TaKWLrcUej0SjmAWmrCXJOjb3q/8wQY2IyAq052C8S4RGZgYFUKM+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754276547; c=relaxed/simple;
	bh=8XWLSI4sbgHCOIFGVmW8cfrPcnXHmFQdS5gy4Tfs07A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFPZkA6x1dk9hItavjTMl68+cUFQmvdVh6USRiyv8nlbsRxF4CdT42sDLkET/8MIdnrJBPmRSLnwuWdXP5sbCIHZcEqCcTuTnfX0Ll7+waRwOddH0t95Y4N+TWjFCyVWTDvkppQrWFPRdn+IoIPvETCeFXD1HKra9gSBENY0mOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=JC/9YR5L; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754276539;
	bh=aOhZ2C5HaWljkHmO37Lc3NOgUQcSBciisyPkKXjGhIc=;
	h=From:Subject:Date:Message-ID;
	b=JC/9YR5LaJCpd7eIAY4w7n70PgnZX69wCtGeag59NySyCDf2G47btdg0GhSSIUUFF
	 f43Qec/Y+8+6Mgsga+Vr1yGCbptJfNb/5RPVXbyYFEKFmiKYiMrO14BEAg4qfvhrG+
	 QJGGfB4JK+kpPvfjDRquijzpT4O5x5lDyI25nvNw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 6890207100007CC9; Mon, 4 Aug 2025 10:52:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6607066291995
X-SMAIL-UIID: F2F1D8728BAF4654ABED1DA3926BB3EE-20250804-105235-1
From: Hillf Danton <hdanton@sina.com>
To: linux-kernel@vger.kernel.org
Cc: Hillf Danton <hdanton@sina.com>
Subject: Re: some works in 2025
Date: Mon,  4 Aug 2025 10:52:23 +0800
Message-ID: <20250804025224.3838-1-hdanton@sina.com>
In-Reply-To: <20250624112437.1639-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[continued I]

On Tue, 24 Jun 2025 19:24:29 +0800 Hillf Danton wrote:
> 
> 001 Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
> https://lore.kernel.org/lkml/6774a257.050a0220.25abdd.097a.GAE@google.com/
> ...
> 050 Subject: Re: [syzbot] [trace?] KASAN: slab-use-after-free Read in __free_filter
> https://lore.kernel.org/lkml/685a6606.a00a0220.2e5631.0064.GAE@google.com/
> 
051 Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_get_neigh
https://lore.kernel.org/lkml/685bc0ab.a00a0220.2e5631.00c2.GAE@google.com/
052 Subject: Re: [syzbot] [bluetooth?] BUG: corrupted list in _hci_cmd_sync_cancel_entry
https://lore.kernel.org/lkml/685c99ee.050a0220.2303ee.00c5.GAE@google.com/
053 Subject: Re: [syzbot] [hams?] possible deadlock in nr_rt_ioctl (2)
https://lore.kernel.org/lkml/685dc4fe.a00a0220.2e5631.037b.GAE@google.com/
054 Subject: Re: [syzbot] [usb?] WARNING in flush_delayed_work
https://lore.kernel.org/lkml/685f8b74.a70a0220.2f4de1.0008.GAE@google.com/
055 Subject: Re: [syzbot] [smc?] KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
https://lore.kernel.org/lkml/6861e11a.a70a0220.2f4de1.0024.GAE@google.com/
056 Subject: Re: [syzbot] [bluetooth?] general protection fault in bcsp_recv
https://lore.kernel.org/lkml/68624d28.a70a0220.2f4de1.0028.GAE@google.com/
057 Subject: Re: [syzbot] [usb?] INFO: task hung in hub_activate (3)
https://lore.kernel.org/lkml/20250702080515.2160-1-hdanton@sina.com/
058 Subject: Re: [syzbot] [kernel?] general protection fault in __cpa_flush_tlb
https://lore.kernel.org/lkml/6866430e.a70a0220.5d25f.0860.GAE@google.com/
059 Subject: Re: [syzbot] [nfs?] [net?] possible deadlock in rpc_close_pipes
https://lore.kernel.org/lkml/6866461d.a70a0220.2b31f5.0016.GAE@google.com/
060 Subject: Re: [syzbot] [net?] kernel BUG in filemap_fault (2)
https://lore.kernel.org/lkml/686743b3.a70a0220.29cf51.000e.GAE@google.com/

061 Subject: Re: [syzbot] [net?] general protection fault in qdisc_tree_reduce_backlog
https://lore.kernel.org/all/6867885f.a00a0220.c7b3.0018.GAE@google.com/
062 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in force_devcd_write
https://lore.kernel.org/all/6867f034.a70a0220.29cf51.0020.GAE@google.com/
063 Subject: Re: [syzbot] [bluetooth?] [usb?] KASAN: slab-use-after-free Read in btusb_disconnect
https://lore.kernel.org/all/6867fd53.a70a0220.29cf51.0022.GAE@google.com/
064 Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
https://lore.kernel.org/linux-fsdevel/20250704070249.2347-1-hdanton@sina.com/
065 Subject: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in pcl812_attach
https://lore.kernel.org/lkml/68686ec1.a70a0220.29cf51.002a.GAE@google.com/
066 Subject: Re: [syzbot] [kernel?] WARNING in driver_unregister (2)
https://lore.kernel.org/lkml/6868e46d.a00a0220.c7b3.0030.GAE@google.com/
067 Subject: Re: [syzbot] [net?] general protection fault in qdisc_tree_reduce_backlog
https://lore.kernel.org/lkml/6868ec63.a00a0220.c7b3.0031.GAE@google.com/
068 Subject: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in pcl726_attach
https://lore.kernel.org/lkml/68692339.a00a0220.c7b3.0038.GAE@google.com/
069 Subject: Re: [syzbot] [kernel?] general protection fault in pcl818_ai_cancel
https://lore.kernel.org/lkml/6869314b.a00a0220.c7b3.003b.GAE@google.com/
070 Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
https://lore.kernel.org/lkml/20250707005946.2669-1-hdanton@sina.com/

071 Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in waveform_detach
https://lore.kernel.org/lkml/686c7513.050a0220.20334d.0001.GAE@google.com/
072 Subject: Re: [syzbot] [bluetooth?] KASAN: null-ptr-deref Write in l2cap_sock_resume_cb (4)
https://lore.kernel.org/lkml/686c749b.050a0220.20334d.0000.GAE@google.com/
073 Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
https://lore.kernel.org/lkml/686dd7ae.050a0220.1ffab7.002c.GAE@google.com/
074 Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
https://lore.kernel.org/lkml/686dda7e.050a0220.1ffab7.002d.GAE@google.com/
075 Subject: Re: [syzbot] [xfs?] possible deadlock in xfs_ilock_attr_map_shared (2)
https://lore.kernel.org/lkml/20250709215135.3122-1-hdanton@sina.com/
076 Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
https://lore.kernel.org/lkml/686fbf2e.a00a0220.26a83e.0013.GAE@google.com/
077 Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
https://lore.kernel.org/lkml/687092d6.a00a0220.26a83e.0036.GAE@google.com/
078 Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
https://lore.kernel.org/lkml/20250711060000.3413-1-hdanton@sina.com/
079 Subject: Re: [syzbot] [hams?] WARNING: refcount bug in ax25_setsockopt
https://lore.kernel.org/lkml/6871bde2.a00a0220.26a83e.0069.GAE@google.com/
080 Subject: Re: [syzbot] [net?] WARNING in rt_set_nexthop
https://lore.kernel.org/lkml/6871d11a.a00a0220.26a83e.006b.GAE@google.com/

081 Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbhid_raw_request
https://lore.kernel.org/lkml/687490b3.a70a0220.3b380f.0048.GAE@google.com/
082 Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in query_matching_vma
https://lore.kernel.org/lkml/6875a57f.a70a0220.5f69f.0004.GAE@google.com/
083 Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
https://lore.kernel.org/lkml/6875ba5c.a70a0220.18f9d4.0019.GAE@google.com/
084 Subject: Re: [syzbot] [mm?] general protection fault in mas_start
https://lore.kernel.org/lkml/6875b407.a70a0220.18f9d4.0017.GAE@google.com/
085 Subject: Re: [syzbot] [bluetooth?] [bcachefs?] KASAN: slab-use-after-free Read in hci_uart_write_work
https://lore.kernel.org/lkml/68761983.a00a0220.3af5df.0001.GAE@google.com/
086 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tcp_prune_ofo_queue
https://lore.kernel.org/lkml/6876fc27.a70a0220.693ce.001b.GAE@google.com/
087 Subject: Re: [syzbot] [mm?] possible deadlock in lock_next_vma
https://lore.kernel.org/lkml/687881b0.a70a0220.693ce.0038.GAE@google.com/
088 Subject: Re: [PATCH] vhost/net: Replace wait_queue with completion in ubufs reference
https://lore.kernel.org/lkml/20250718090725.2352-1-hdanton@sina.com/
089 Subject: Re: [syzbot] [io-uring?] KASAN: slab-use-after-free Read in io_poll_remove_entries
https://lore.kernel.org/lkml/687c46d7.a70a0220.693ce.00a2.GAE@google.com/
090 Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_iop_getattr
https://lore.kernel.org/lkml/687da320.a70a0220.693ce.00db.GAE@google.com/

091 Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking dependency detected when plugging USB stick after ffa1e7ada456
https://lore.kernel.org/lkml/CABXGCsOwAQuisqpfUvW+1BWtOV+O1GypcQ6mb4SSUgN3YkAZUQ@mail.gmail.com/
092 Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in simple_recursive_removal (5)
https://lore.kernel.org/lkml/68820e72.a00a0220.2f88df.0021.GAE@google.com/
093 Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_new_lci
https://lore.kernel.org/lkml/6882d8b6.a00a0220.2f88df.0039.GAE@google.com/
094 Subject: Re: [syzbot] [input?] possible deadlock in input_ff_flush
https://lore.kernel.org/lkml/6885af82.a00a0220.b12ec.0045.GAE@google.com/
095 Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in exit_to_user_mode_loop
https://lore.kernel.org/lkml/68885247.a00a0220.b12ec.00c8.GAE@google.com/
096 Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_scheduled_works
https://lore.kernel.org/lkml/6889f33b.a00a0220.26d0e1.001b.GAE@google.com/
097 Subject: Re: [syzbot] [dri?] WARNING in __ww_mutex_wound
https://lore.kernel.org/lkml/20250730131345.3530-1-hdanton@sina.com/
098 Subject: Re: [syzbot] [comedi?] KMSAN: kernel-infoleak in do_insnlist_ioctl
https://lore.kernel.org/lkml/688b4d68.a00a0220.26d0e1.003d.GAE@google.com/
099 Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
https://lore.kernel.org/lkml/688e9f03.a70a0220.249f57.000c.GAE@google.com/
100 Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
https://lore.kernel.org/lkml/20250803084924.3785-1-hdanton@sina.com/

[1] Subject: some works in 2025
https://lore.kernel.org/lkml/20250624112437.1639-1-hdanton@sina.com/

