Return-Path: <linux-kernel+bounces-755820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A514B1AC25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAB189FC74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D2199E94;
	Tue,  5 Aug 2025 01:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="BLx96nCh"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FCE10FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 01:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357961; cv=none; b=FKt5yxlPqphoX4XETr++6LVgOZDTTgxPk3GqxNFQQ6IUVdNbNTx26Fa/n5aS2K7x/Viu7UN35yd33ArE5dAjz2yMjBBnQmQKCe2hY8cfUxdijGd1rUOSEimVFw3R+m9q07KkP8PANeg2tBjf5xwzgzTGmTol/MJJY1KtzO58whk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357961; c=relaxed/simple;
	bh=fMGOPpyGCvojsT7WoNjoyxGaga4HNCrAKDv2136YJCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdWabe9Nj7aRfIL0Qlm5AlSmICdg5LOvliaZRbViG80GWim7eQbNsJTWOQywJVv4Am0MruXIALF6wV/Qo8sifCKqUPzq5j8laSdn4QSE7mF7xVlnVluni7IURfVUMKc9iHzUCg5eGuXo9SsY9hPGWp4F5qjXziGZhWlFmXtK2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=BLx96nCh; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754357952;
	bh=nzJPeJLSMubm99etnFxGppt3ULsBhft8uKnlc2PZWWA=;
	h=From:Subject:Date:Message-ID;
	b=BLx96nChLaKdPLwID2ahE9MY3EcYuOw6tJ3EkKV3vHem4BnFw37Ezsmd+XvUHvG5M
	 vImOOSN8oAUTnYn16Oke5xLLgWfmFLVqcc9tZBnO6eMQAu6GpEqU3xb7LtfaNm/h8c
	 0n1QYgzr8XDH1/SUpy/iY8MTYdb54dsIas6W4u58=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 689160B900005244; Tue, 5 Aug 2025 09:39:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3704676291922
X-SMAIL-UIID: 9CC48675D1244ABCA715D720E5AB31F5-20250805-093907-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2a0d2af125c01db73079@syzkaller.appspotmail.com>
Cc: Aleksandr Nogikh <nogikh@google.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [ntfs3?] kernel BUG in set_page_refcounted
Date: Tue,  5 Aug 2025 09:38:55 +0800
Message-ID: <20250805013856.3890-1-hdanton@sina.com>
In-Reply-To: <68910eae.050a0220.1fc43d.0011.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 04 Aug 2025 12:49:02 -0700
> Hello,
> 
> syzbot tried to test the proposed patch but the build/boot failed:
> 
> l2tp_ip: L2TP IP encapsulation support (L2TPv3)
> [   27.825502][    T1] l2tp_netlink: L2TP netlink interface
> [   27.825920][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
> [   27.825937][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
> [   27.826620][    T1] NET: Registered PF_PHONET protocol family
> [   27.827330][    T1] 8021q: 802.1Q VLAN Support v1.8
> [   27.828378][    T1] sctp: Hash tables configured (bind 16/30)
> [   27.845592][    T1] NET: Registered PF_RDS protocol family
> [   27.857773][    T1] Registered RDS/infiniband transport
> [   27.860770][    T1] Registered RDS/tcp transport
> [   27.860799][    T1] tipc: Activated (version 2.0.0)
> [   27.862127][    T1] NET: Registered PF_TIPC protocol family
> [   28.127730][    T1] tipc: Started in single node mode
> [   28.130531][    T1] NET: Registered PF_SMC protocol family
> [   28.131342][    T1] 9pnet: Installing 9P2000 support
> [   28.134047][    T1] NET: Registered PF_CAIF protocol family
> [   28.146328][    T1] NET: Registered PF_IEEE802154 protocol family
> [   28.147148][    T1] Key type dns_resolver registered
> [   28.147397][    T1] Key type ceph registered
> [   28.148909][    T1] libceph: loaded (mon/osd proto 15/24)
> [   28.151956][    T1] batman_adv: B.A.T.M.A.N. advanced 2025.3 (compatibility version 15) loaded
> [   28.152357][    T1] openvswitch: Open vSwitch switching datapath
> [   28.158678][    T1] NET: Registered PF_VSOCK protocol family
> [   28.159384][    T1] mpls_gso: MPLS GSO support
> [   28.468182][    T1] IPI shorthand broadcast: enabled
> [   30.357628][ T4187] kworker/u8:7 (4187) used greatest stack depth: 25160 bytes left
> [   31.509877][    T1] sched_clock: Marking stable (30902438698, 602418618)->(31510037087, -5179771)
> [   31.530861][    T1] registered taskstats version 1
> [   31.556152][    T1] Loading compiled-in X.509 certificates
> [   31.602333][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 46cd9d46b5c7fa66669dfc53ee62f72ced050d22'
> [   32.275192][    T1] zswap: loaded using pool 842/zsmalloc
> [   32.281063][    T1] Demotion targets for Node 0: null
> [   32.281080][    T1] Demotion targets for Node 1: null
> [   32.281096][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
> [   32.285682][    T1] Key type .fscrypt registered
> [   32.285704][    T1] Key type fscrypt-provisioning registered
> [   32.296150][    T1] kAFS: Red Hat AFS client v0.1 registering.
> [   32.353465][    T1] Btrfs loaded, assert=on, ref-verify=on, zoned=yes, fsverity=yes
> [   32.354863][    T1] Key type big_key registered
> [   32.355022][    T1] Key type encrypted registered
> [   32.355295][    T1] ima: No TPM chip found, activating TPM-bypass!
> [   32.355365][    T1] Loading compiled-in module X.509 certificates
> [   32.404555][    T1] Loaded X.509 cert 'Build time autogenerated kernel key: 46cd9d46b5c7fa66669dfc53ee62f72ced050d22'
> [   32.404611][    T1] ima: Allocated hash algorithm: sha256
> [   32.405041][    T1] ima: No architecture policies found
> [   32.405732][    T1] evm: Initialising EVM extended attributes:
> [   32.405739][    T1] evm: security.selinux (disabled)
> [   32.405746][    T1] evm: security.SMACK64
> [   32.405751][    T1] evm: security.SMACK64EXEC
> [   32.405757][    T1] evm: security.SMACK64TRANSMUTE
> [   32.405763][    T1] evm: security.SMACK64MMAP
> [   32.405768][    T1] evm: security.apparmor (disabled)
> [   32.405774][    T1] evm: security.ima
> [   32.405780][    T1] evm: security.capability
> [   32.405785][    T1] evm: HMAC attrs: 0x1
> [   32.410288][    T1] PM:   Magic number: 5:461:697
> [   32.410412][    T1] video4linux radio12: hash matches
> [   32.410476][    T1] usb usb58-port5: hash matches
> [   32.410614][    T1] usb usb26-port1: hash matches
> [   32.411199][    T1] netconsole: network logging started
> [   32.412165][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
> [   32.435157][    T1] rdma_rxe: loaded
> [   32.440081][    T1] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   32.446570][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   32.450487][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
> [   32.454686][   T31] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
> [   32.454728][   T31] faux_driver regulatory: Falling back to sysfs fallback for: regulatory.db
> [   32.459994][    T1] clk: Disabling unused clocks
> [   32.460415][    T1] ALSA device list:
> [   32.460429][    T1]   #0: Dummy 1
> [   32.460444][    T1]   #1: Loopback 1
> [   32.460456][    T1]   #2: Virtual MIDI Card 1
> [   32.610149][    T1] check access for rdinit=/init failed: -2, ignoring
> [   32.610176][    T1] md: Waiting for all devices to be available before autodetect
> [   32.610183][    T1] md: If you don't use raid, use raid=noautodetect
> [   32.610197][    T1] md: Autodetecting RAID arrays.
> [   32.610316][    T1] md: autorun ...
> [   32.610324][    T1] md: ... autorun DONE.
> [   32.673022][ T5160] dec_stack_record_count: refcount went to 0 for 125436371 handle
> [   32.673441][    T1] dec_stack_record_count: refcount went to 0 for 468 handle
> [   32.676518][    T1] dec_stack_record_count: refcount went to 0 for 96207031 handle
> [   32.677071][    T1] ------------[ cut here ]------------
> [   32.677084][    T1] WARNING: CPU: 0 PID: 1 at lib/stackdepot.c:510 depot_fetch_stack+0x97/0xa0
> [   32.677108][    T1] Modules linked in:
> [   32.677128][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.16.0-syzkaller-11579-g35a813e010b9-dirty #0 PREEMPT_{RT,(full)} 

Testing with RT turned on makes no sense, no?

> [   32.677150][    T1] Tainted: [W]=WARN
> [   32.677155][    T1] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> [   32.677165][    T1] RIP: 0010:depot_fetch_stack+0x97/0xa0
> [   32.677180][    T1] Code: c7 c7 d7 a3 04 8d 89 ee 44 89 f2 89 d9 e8 e1 ca 95 fc 90 0f 0b 90 90 31 c0 5b 41 5e 5d e9 c1 7c 08 06 cc 90 0f 0b 90 eb ee 90 <0f> 0b 90 eb e8 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
> [   32.677192][    T1] RSP: 0000:ffffc90000067480 EFLAGS: 00010246
> [   32.677205][    T1] RAX: ffff88814371c000 RBX: 0000000000002de0 RCX: 00000000000000b6
> [   32.677215][    T1] RDX: 0000000000000000 RSI: ffffffff8d1e65a6 RDI: ffffffff8b61eb00
> [   32.677226][    T1] RBP: 00000000000000b6 R08: 0000000000000000 R09: 0000000000000000
> [   32.677235][    T1] R10: dffffc0000000000 R11: ffffed10035a9b81 R12: 0000000000000000
> [   32.677245][    T1] R13: 0000000000000000 R14: 00000000000001d4 R15: 000000079bacacab
> [   32.677255][    T1] FS:  0000000000000000(0000) GS:ffff888126af6000(0000) knlGS:0000000000000000
> [   32.677267][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   32.677277][    T1] CR2: ffff88823ffff000 CR3: 000000000d5a6000 CR4: 00000000003526f0
> [   32.677290][    T1] Call Trace:
> [   32.677296][    T1]  <TASK>
> [   32.677305][    T1]  __reset_page_owner+0xd0/0x1f0
> [   32.677328][    T1]  free_unref_folios+0x1ebb/0x2280
> [   32.677365][    T1]  folios_put_refs+0x569/0x670
> [   32.677396][    T1]  ? __pfx_folios_put_refs+0x10/0x10
> [   32.677427][    T1]  truncate_inode_pages_range+0x338/0xb90
> [   32.677450][    T1]  ? __pfx_truncate_inode_pages_range+0x10/0x10
> [   32.677485][    T1]  ? has_bh_in_lru+0x307/0x340
> [   32.677507][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
> [   32.677530][    T1]  ? smp_call_function_many_cond+0xda5/0x12d0
> [   32.677572][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
> [   32.677593][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
> [   32.677620][    T1]  blkdev_flush_mapping+0x10b/0x280
> [   32.677641][    T1]  ? bdev_release+0x41a/0x660
> [   32.677662][    T1]  bdev_release+0x422/0x660
> [   32.677687][    T1]  ? __pfx_blkdev_release+0x10/0x10
> [   32.677709][    T1]  blkdev_release+0x15/0x20
> [   32.677729][    T1]  __fput+0x458/0xa80
> [   32.677761][    T1]  task_work_run+0x1d1/0x260
> [   32.677795][    T1]  ? __pfx_task_work_run+0x10/0x10
> [   32.677825][    T1]  mount_root_generic+0x1b0/0x350
> [   32.677851][    T1]  ? __pfx_mount_root_generic+0x10/0x10
> [   32.677869][    T1]  ? getname_kernel+0x20e/0x2f0
> [   32.677893][    T1]  ? kernel_init+0x1d/0x1d0
> [   32.677914][    T1]  prepare_namespace+0x71/0xa0
> [   32.677929][    T1]  kernel_init_freeable+0x373/0x4b0
> [   32.677948][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
> [   32.677963][    T1]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
> [   32.677991][    T1]  ? __pfx_kernel_init+0x10/0x10
> [   32.678012][    T1]  kernel_init+0x1d/0x1d0
> [   32.678031][    T1]  ? __pfx_kernel_init+0x10/0x10
> [   32.678050][    T1]  ret_from_fork+0x3fc/0x770
> [   32.678092][    T1]  ? __pfx_ret_from_fork+0x10/0x10
> [   32.678114][    T1]  ? __switch_to_asm+0x39/0x70
> [   32.678137][    T1]  ? __switch_to_asm+0x33/0x70
> [   32.678158][    T1]  ? __pfx_kernel_init+0x10/0x10
> [   32.678180][    T1]  ret_from_fork_asm+0x1a/0x30
> [   32.678214][    T1]  </TASK>

