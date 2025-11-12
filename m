Return-Path: <linux-kernel+bounces-898287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6AC54C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53FAF4E075A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FC62E6CA0;
	Wed, 12 Nov 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="g449YFJy"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770792BF017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988377; cv=none; b=dcaDS5WG5rXC86gV0IQSimw3b0BbGbI6ej6EhPZwW9eP7X8D+9CmBZTEOvLsCBsA9NO18OZZEc+fF8LOFBLtO4f7Shlj550NSv7mIC9deQ+NwUpw1Fdh7IKFGB2pkI+ATPiPV4hGwPLJPdIZAnCP3CUn37SduHrUGE90UuU0P0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988377; c=relaxed/simple;
	bh=boBN4RQ8eNqzYs+xUtkUkIFpTZIANwxYq2NCC8EjZ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5drbFjpRa/N7YZsqAB40JD9jZ3FnYrRTeN+UTdA/1hKWgZSiaCNAZ+bBUNh5DSMY9VZ6R/v5yW6pGnS5v9dFP0fH8bH8fAtdDwgrbA+qSG2MmBXoTpGwAZbjP2VMdL4o1Da9Q6NVMOO1XZWkQ07fQVjdBrG3VSFWKox1aGdbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=g449YFJy; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762988369;
	bh=aVwybilAiQlDrK/nywGafilBgOrovrprY34VpGnZCQE=;
	h=From:Subject:Date:Message-ID;
	b=g449YFJyDFCUlXTw6dB53ORPCij0NDpQbVrnsMYkHR8YyODfk3DHyNI8Bj2eEYdYs
	 sdJh5ky1bLcQdH4cJmC0LcffoR7pKGwlgjFau9drPCG3zeCjqEkmUWT4BDvmscyiJB
	 L7qKYhzJr42iZxELajhoOwOcVMTfoR9BPRDNSAf4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.32) with ESMTP
	id 691510BC00007752; Wed, 13 Nov 2025 06:57:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2422304456687
X-SMAIL-UIID: 73BD44BFAC7342938648B58B350AAABF-20251113-065702-1
From: Hillf Danton <hdanton@sina.com>
To: linux-kernel@vger.kernel.org
Cc: Hillf Danton <hdanton@sina.com>
Subject: Re: some works in 2025
Date: Thu, 13 Nov 2025 06:56:48 +0800
Message-ID: <20251112225650.9224-1-hdanton@sina.com>
In-Reply-To: <20250830071021.6131-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[continued III]

> On Sat, 30 Aug 2025 15:10:20 +0800 Hillf Danton wrote:
> [continued II]
> 
> > On Mon,  4 Aug 2025 10:52:23 +0800 Hillf Danton wrote:
> > [continued I]
> > 
> > On Tue, 24 Jun 2025 19:24:29 +0800 Hillf Danton wrote:
> > > 
> > > 001 Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
> > > https://lore.kernel.org/lkml/6774a257.050a0220.25abdd.097a.GAE@google.com/
> > > ...
> > > 050 Subject: Re: [syzbot] [trace?] KASAN: slab-use-after-free Read in __free_filter
> > > https://lore.kernel.org/lkml/685a6606.a00a0220.2e5631.0064.GAE@google.com/
> > > 
> > 051 Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_get_neigh
> > https://lore.kernel.org/lkml/685bc0ab.a00a0220.2e5631.00c2.GAE@google.com/
> > ...
> > 100 Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
> > https://lore.kernel.org/lkml/20250803084924.3785-1-hdanton@sina.com/
> > 
> 101 Subject: Re: [syzbot] [trace?] [bpf?] possible deadlock in down_trylock (3)
> https://lore.kernel.org/lkml/20250805031314.3958-1-hdanton@sina.com/
> ...
> 121 Subject: Re: [syzbot] [net?] WARNING in est_timer
> https://lore.kernel.org/lkml/68b2703c.050a0220.3db4df.01a2.GAE@google.com/
> 
122 Subject: Re: [syzbot] [kvm?] [net?] [virt?] INFO: task hung in __vhost_worker_flush
https://lore.kernel.org/lkml/20250901103043.6331-1-hdanton@sina.com/
123 Subject: Re: [syzbot] [net?] BUG: soft lockup in sys_sendmsg (2)
https://lore.kernel.org/lkml/20250902064651.6359-1-hdanton@sina.com/
124 Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
https://lore.kernel.org/lkml/20250905030430.6482-1-hdanton@sina.com/
125 Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling tasklets via polling
https://lore.kernel.org/lkml/20250905101502.6525-1-hdanton@sina.com/
126 Subject: Re: [syzbot] [hfs?] INFO: task hung in deactivate_super (3)
https://lore.kernel.org/lkml/20250907020310.6559-1-hdanton@sina.com/
127 Subject: Re: [syzbot] [block?] general protection fault in bio_iov_iter_get_pages
https://lore.kernel.org/lkml/68bd5115.050a0220.192772.01d2.GAE@google.com/
128 Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown
https://lore.kernel.org/lkml/20250908130303.6609-1-hdanton@sina.com/
129 Subject: Re: [syzbot] [net?] BUG: corrupted list in flow_block_cb_setup_simple
https://lore.kernel.org/lkml/68c415ce.050a0220.2ff435.035b.GAE@google.com/
130 Subject: Re: [syzbot] [bluetooth?] KASAN: wild-memory-access Read in l2cap_connect_cfm
https://lore.kernel.org/lkml/68c4f2d5.050a0220.3c6139.04bc.GAE@google.com/

131 Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
https://lore.kernel.org/lkml/68c525eb.050a0220.2ff435.0371.GAE@google.com/
132 Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
https://lore.kernel.org/lkml/68ccc372.050a0220.28a605.0016.GAE@google.com/
133 Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
https://lore.kernel.org/lkml/68ce3203.050a0220.13cd81.0010.GAE@google.com/
134 Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
https://lore.kernel.org/lkml/68cff83a.050a0220.13cd81.0035.GAE@google.com/
135 Subject: Re: [syzbot] [block?] general protection fault in blk_mq_free_tags_callback
https://lore.kernel.org/lkml/68d25f78.a70a0220.1b52b.02a3.GAE@google.com/
136 Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
https://lore.kernel.org/lkml/68d26cd3.a70a0220.1b52b.02a7.GAE@google.com/
137 Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in hook_sb_delete
https://lore.kernel.org/lkml/68d341a6.a70a0220.4f78.0015.GAE@google.com/
138 Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
https://lore.kernel.org/lkml/20250924224238.7592-1-hdanton@sina.com/
139 Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in drain_pages_zone
https://lore.kernel.org/lkml/20250927004617.7667-1-hdanton@sina.com/
140 Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
https://lore.kernel.org/lkml/68ddc8f2.a00a0220.102ee.006f.GAE@google.com/

141 Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in afs_dynroot_readdir (2)
https://lore.kernel.org/lkml/68e2567f.050a0220.2c17c1.0036.GAE@google.com/
142 Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
https://lore.kernel.org/lkml/20251006131543.8283-1-hdanton@sina.com/
143 Subject: Re: [syzbot] [fuse?] possible deadlock in __folio_end_writeback
https://lore.kernel.org/lkml/68e5bf12.050a0220.256323.0030.GAE@google.com/
144 Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid context in __set_page_owner
https://lore.kernel.org/lkml/68e8b494.050a0220.1186a4.0007.GAE@google.com/
145 Subject: Re: [syzbot] [kvm?] KASAN: slab-use-after-free Write in kvm_gmem_release
https://lore.kernel.org/lkml/68fc470c.a00a0220.9662e.0012.GAE@google.com/
146 Subject: Re: [syzbot] [io-uring?] INFO: task hung in io_uring_del_tctx_node (5)
https://lore.kernel.org/lkml/69000b07.050a0220.32483.00cb.GAE@google.com/
147 Subject: Re: [PATCH v5] PM: Support aborting sleep during filesystem sync
https://lore.kernel.org/lkml/CAG2Kcto4XPWMqf_ALZht9wivKki7bNKgCwijLruTsj8CDHaCgA@mail.gmail.com/
148 Subject: Re: [syzbot] [sound?] [usb?] KASAN: slab-out-of-bounds Write in copy_to_urb
https://lore.kernel.org/lkml/690c08a3.050a0220.3d0d33.00cf.GAE@google.com/
149 Subject: Re: [syzbot] [sctp?] BUG: corrupted list in sctp_destroy_sock
https://lore.kernel.org/lkml/690d5536.a70a0220.22f260.0016.GAE@google.com/
150 Subject: Re: [syzbot] [block?] general protection fault in rtlock_slowlock_locked
https://lore.kernel.org/lkml/690efb16.a70a0220.22f260.0077.GAE@google.com/

151 Subject: Re: [syzbot] [hams?] WARNING: ODEBUG bug in handle_softirqs
https://lore.kernel.org/lkml/69147776.a70a0220.3124cb.0000.GAE@google.com/

[1] Subject: some works in 2025
https://lore.kernel.org/lkml/20250624112437.1639-1-hdanton@sina.com/
[2] Subject: Re: some works in 2025 (continued I)
https://lore.kernel.org/lkml/20250804025224.3838-1-hdanton@sina.com/
[3] Subject: Re: some works in 2025 (continued II)
https://lore.kernel.org/lkml/20250830071021.6131-1-hdanton@sina.com/

