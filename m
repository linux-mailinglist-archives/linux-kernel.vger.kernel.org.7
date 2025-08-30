Return-Path: <linux-kernel+bounces-792764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA73B3C89D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E85FA22942
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 07:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2B1241CA2;
	Sat, 30 Aug 2025 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="vWxd68Vi"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4139D2AD0D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756537849; cv=none; b=cFbmRAiSneHNRmTdkDoTqKL30sWOWSoVeK0fmoxmVrzpMBTtLXLX1NbU+20uWY0WvS1gxI9CKPv3PLmWoaDFNuZ+c3XADmn/1QwK2XKGO8v6zwXKKw/1YBkSP0q1tpJdmTErkJMjn0aBUBOJmbbuyc65n5XXHDCYRi3ifDI2ADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756537849; c=relaxed/simple;
	bh=Zp6MZeyNkWiOseqMpZzQFCQ9e4UIbyb/6sPKs9TGY+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH2lUQ92vDO94BnxNn0jIcgHJCSpgSTmopf0gp/oqomUZ/kBWB/2KxDrm6HozRJQvcVfFx2txf5vygLeDO2x7mn7dZR0SsxvQs6HkldfK2xDeGh9YVq1O9sQ12QAxqZ3Tj9YChqTiN/fybnrSV67xrlaFBfEvl6WanKHlbJPnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=vWxd68Vi; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756537841;
	bh=hqYo/uOEBNKANojVQ/7ww0FRzT55fAf4CZ7fzFUkysU=;
	h=From:Subject:Date:Message-ID;
	b=vWxd68VigP49Os8tvtESfKlIrCKLMHgR6FdE7PRaibRe9UNt+xRC+9FU70tV3KwcX
	 ONai2evvT/jptWMfd0osaawi6c9SULX2I9w1YieE0VYcf6V7eCJeUtpcIAn88NWHNA
	 s+dZSZj0NPYGE54iz/TMojDOjbJ6FrUBiLUgDDxo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68B2A3E60000683E; Sat, 30 Aug 2025 15:10:32 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1591206685310
X-SMAIL-UIID: 454A894BC4674A14A264E61B3B958C7A-20250830-151032-1
From: Hillf Danton <hdanton@sina.com>
To: linux-kernel@vger.kernel.org
Cc: Hillf Danton <hdanton@sina.com>
Subject: Re: some works in 2025
Date: Sat, 30 Aug 2025 15:10:20 +0800
Message-ID: <20250830071021.6131-1-hdanton@sina.com>
In-Reply-To: <20250804025224.3838-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[continued II]

> On Mon,  4 Aug 2025 10:52:23 +0800 Hillf Danton wrote:
> [continued I]
> 
> On Tue, 24 Jun 2025 19:24:29 +0800 Hillf Danton wrote:
> > 
> > 001 Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
> > https://lore.kernel.org/lkml/6774a257.050a0220.25abdd.097a.GAE@google.com/
> > ...
> > 050 Subject: Re: [syzbot] [trace?] KASAN: slab-use-after-free Read in __free_filter
> > https://lore.kernel.org/lkml/685a6606.a00a0220.2e5631.0064.GAE@google.com/
> > 
> 051 Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in rose_get_neigh
> https://lore.kernel.org/lkml/685bc0ab.a00a0220.2e5631.00c2.GAE@google.com/
> ...
> 100 Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path on PREEMPT_RT
> https://lore.kernel.org/lkml/20250803084924.3785-1-hdanton@sina.com/
> 
101 Subject: Re: [syzbot] [trace?] [bpf?] possible deadlock in down_trylock (3)
https://lore.kernel.org/lkml/20250805031314.3958-1-hdanton@sina.com/
102 Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
https://lore.kernel.org/lkml/20250805120001.3990-1-hdanton@sina.com/
103 Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in __sk_destruct (3)
https://lore.kernel.org/lkml/6896d86a.050a0220.7f033.00a4.GAE@google.com/
104 Subject: Re: [syzbot] [wireless?] KASAN: slab-use-after-free Read in cmp_bss
https://lore.kernel.org/lkml/689ad195.050a0220.7f033.010d.GAE@google.com/
105 Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
https://lore.kernel.org/lkml/689bec7e.050a0220.7f033.013f.GAE@google.com/
106 Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
https://lore.kernel.org/lkml/689bfb3f.a70a0220.7865.0044.GAE@google.com/
107 Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
https://lore.kernel.org/lkml/689c8d08.050a0220.7f033.014a.GAE@google.com/
108 Subject: Re: [syzbot] [nfc?] [net?] WARNING in nfc_rfkill_set_block
https://lore.kernel.org/lkml/20250815001123.4558-1-hdanton@sina.com/
109 Subject: Re: [PATCH v2 -next] cgroup: remove offline draining in root destruction to avoid hung_tasks
https://lore.kernel.org/lkml/20250815024020.4579-1-hdanton@sina.com/
110 Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
https://lore.kernel.org/lkml/68a17d02.050a0220.e29e5.005e.GAE@google.com/

111 Subject: Re: [syzbot] [overlayfs?] WARNING in shmem_unlink
https://lore.kernel.org/lkml/68a2f697.050a0220.e29e5.009e.GAE@google.com/
112 Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context in vfree (2)
https://lore.kernel.org/lkml/68a3118b.050a0220.e29e5.00a2.GAE@google.com/
113 Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
https://lore.kernel.org/lkml/68a3dc0b.050a0220.e29e5.00b8.GAE@google.com/
114 Subject: Re: [syzbot] [atm?] general protection fault in atmtcp_c_send
https://lore.kernel.org/lkml/68a6a143.050a0220.3d78fd.0017.GAE@google.com/
115 Subject: Re: [syzbot] [media?] [usb?] KASAN: slab-use-after-free Read in v4l2_release (2)
https://lore.kernel.org/lkml/68aacf2e.050a0220.37038e.0070.GAE@google.com/
116 Subject: Re: [syzbot] [usb?] BUG: sleeping function called from invalid context in dummy_dequeue
https://lore.kernel.org/lkml/68ad267d.050a0220.37038e.00a2.GAE@google.com/
117 Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_truncate (2)
https://lore.kernel.org/lkml/68ad1ca1.050a0220.37038e.009e.GAE@google.com/
118 Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
https://lore.kernel.org/lkml/68aee0bf.a70a0220.3cafd4.001c.GAE@google.com/
119 Subject: Re: [syzbot] [block?] [ext4?] [btrfs?] INFO: rcu detected stall in sys_mount (8)
https://lore.kernel.org/lkml/68af814d.050a0220.8762d.0000.GAE@google.com/
120 Subject: Re: [syzbot] [mm?] WARNING in copy_process
https://lore.kernel.org/lkml/68b048fb.a00a0220.1337b0.0007.GAE@google.com/

121 Subject: Re: [syzbot] [net?] WARNING in est_timer
https://lore.kernel.org/lkml/68b2703c.050a0220.3db4df.01a2.GAE@google.com/


[1] Subject: some works in 2025
https://lore.kernel.org/lkml/20250624112437.1639-1-hdanton@sina.com/
[2] Subject: some works in 2025 (continued I)
https://lore.kernel.org/lkml/20250804025224.3838-1-hdanton@sina.com/


