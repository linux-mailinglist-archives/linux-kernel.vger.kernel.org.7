Return-Path: <linux-kernel+bounces-755646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9589CB1A9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DECC77A22F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7A8235364;
	Mon,  4 Aug 2025 19:49:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44869232386
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336945; cv=none; b=U4s/ynoIjRJx9RihnRTg96v+UM8mQ6jWdjNYIHG4h50Rmwt2K/Bekm2aHEYq+2kWKzD9SlapmhmSS4Gzs7f+iuIp8Yoh8g2zFmIyxUtTX3RKRWTUXORwVbulqrkL338CabptoRzRi+DDi2sAP7iqlKa77mIVHvACmGf2T4YINFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336945; c=relaxed/simple;
	bh=n0W12fSKmeRdNA1vtR+Z5mc5lam16mNn0Kz1KSmWGzk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gpqxekosw33xSWKe66nYfPupjpqUCstXFKTnUO9d5hJkTuVOViIlYL9KfdnlMQx8NE/HxqfZKY6s9bjswj/5hF+3YO0XDKuKQI1paLHk7TKk8v2LkHQ+C9H1LsNs4cXZ8nXrmeavj3V59rR3SzWVzP6M2X5hY5IKGL/sGRblawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8817d15cad2so125198139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336942; x=1754941742;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m05kOjPa6YnY9UaewIka7tnT4lxnc4BSWRcVXaIfL68=;
        b=xQD3BkO+FSs+D489g3FlsZnpOkZt13B/ohFZG+PUsKwFTM5GlZ9VotKcShA4RX2KDt
         SbQaafprDnUzA6gG64BRUOFjGq4CVQl8UBZbQSjgeewlvwu3ex7sbXqDDfBku50UBIM6
         d5trn4WxQMX9/gWdv2ct+S89B48LsTHzn15SzD4u/GKmN5sW4CO2AdtDid2goKbyql+m
         9OYh9kN7VK3Ue+GqEobrGJ11sW5zUTpHgJx347Oe6svxb//rtaF5GQz1X9FMiK3gygdk
         +9lAxsUoH0UUi4C0s0M9mJvjdh98V751ZM2sdAkDrssuOATy3Xj08KQb3YVFx2QcNjC0
         ej6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+TCTjxHESa8AVnYkMLxrDUWKI/dE8/ZsR+yYsAzshKQFHTCs7oGSHirce0CgYE4PgmDnVYOZhQJUhPUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbAy/EYVpT7lnuo/iF5kjhtJSbDMB9B9vsDa9uQMq2jQ78H8S
	0GnDxoCyHs3Xdn0iBl41NliBbbBEIHgrlHebFQzyRVdPtykXwBVgv0MCQfohybMLqymp/Jrn1os
	h/pGaSuG2przCz3lhRvqeEbw7l9acWB5EHe0RN1yCAqXILcTm1lXgQRl9uKs=
X-Google-Smtp-Source: AGHT+IE5+JmcYLCs3e3HKV+5CAeQ9RVbydsnTI3+0aJ5c4CRW4L2slfvgYuiJbqFMLkuzCjzvdrESYUCj8D+2vg4+tSpiGzqME6K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7404:b0:876:1c5e:8c50 with SMTP id
 ca18e2360f4ac-8816834dfe7mr2011977439f.7.1754336942225; Mon, 04 Aug 2025
 12:49:02 -0700 (PDT)
Date: Mon, 04 Aug 2025 12:49:02 -0700
In-Reply-To: <20250804094046.3872-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68910eae.050a0220.1fc43d.0011.GAE@google.com>
Subject: Re: [syzbot] [mm?] [ntfs3?] kernel BUG in set_page_refcounted
From: syzbot <syzbot+2a0d2af125c01db73079@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

l2tp_ip: L2TP IP encapsulation support (L2TPv3)
[   27.825502][    T1] l2tp_netlink: L2TP netlink interface
[   27.825920][    T1] l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
[   27.825937][    T1] l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2=
TPv3)
[   27.826620][    T1] NET: Registered PF_PHONET protocol family
[   27.827330][    T1] 8021q: 802.1Q VLAN Support v1.8
[   27.828378][    T1] sctp: Hash tables configured (bind 16/30)
[   27.845592][    T1] NET: Registered PF_RDS protocol family
[   27.857773][    T1] Registered RDS/infiniband transport
[   27.860770][    T1] Registered RDS/tcp transport
[   27.860799][    T1] tipc: Activated (version 2.0.0)
[   27.862127][    T1] NET: Registered PF_TIPC protocol family
[   28.127730][    T1] tipc: Started in single node mode
[   28.130531][    T1] NET: Registered PF_SMC protocol family
[   28.131342][    T1] 9pnet: Installing 9P2000 support
[   28.134047][    T1] NET: Registered PF_CAIF protocol family
[   28.146328][    T1] NET: Registered PF_IEEE802154 protocol family
[   28.147148][    T1] Key type dns_resolver registered
[   28.147397][    T1] Key type ceph registered
[   28.148909][    T1] libceph: loaded (mon/osd proto 15/24)
[   28.151956][    T1] batman_adv: B.A.T.M.A.N. advanced 2025.3 (compatibil=
ity version 15) loaded
[   28.152357][    T1] openvswitch: Open vSwitch switching datapath
[   28.158678][    T1] NET: Registered PF_VSOCK protocol family
[   28.159384][    T1] mpls_gso: MPLS GSO support
[   28.468182][    T1] IPI shorthand broadcast: enabled
[   30.357628][ T4187] kworker/u8:7 (4187) used greatest stack depth: 25160=
 bytes left
[   31.509877][    T1] sched_clock: Marking stable (30902438698, 602418618)=
->(31510037087, -5179771)
[   31.530861][    T1] registered taskstats version 1
[   31.556152][    T1] Loading compiled-in X.509 certificates
[   31.602333][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 46cd9d46b5c7fa66669dfc53ee62f72ced050d22'
[   32.275192][    T1] zswap: loaded using pool 842/zsmalloc
[   32.281063][    T1] Demotion targets for Node 0: null
[   32.281080][    T1] Demotion targets for Node 1: null
[   32.281096][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   32.285682][    T1] Key type .fscrypt registered
[   32.285704][    T1] Key type fscrypt-provisioning registered
[   32.296150][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   32.353465][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   32.354863][    T1] Key type big_key registered
[   32.355022][    T1] Key type encrypted registered
[   32.355295][    T1] ima: No TPM chip found, activating TPM-bypass!
[   32.355365][    T1] Loading compiled-in module X.509 certificates
[   32.404555][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 46cd9d46b5c7fa66669dfc53ee62f72ced050d22'
[   32.404611][    T1] ima: Allocated hash algorithm: sha256
[   32.405041][    T1] ima: No architecture policies found
[   32.405732][    T1] evm: Initialising EVM extended attributes:
[   32.405739][    T1] evm: security.selinux (disabled)
[   32.405746][    T1] evm: security.SMACK64
[   32.405751][    T1] evm: security.SMACK64EXEC
[   32.405757][    T1] evm: security.SMACK64TRANSMUTE
[   32.405763][    T1] evm: security.SMACK64MMAP
[   32.405768][    T1] evm: security.apparmor (disabled)
[   32.405774][    T1] evm: security.ima
[   32.405780][    T1] evm: security.capability
[   32.405785][    T1] evm: HMAC attrs: 0x1
[   32.410288][    T1] PM:   Magic number: 5:461:697
[   32.410412][    T1] video4linux radio12: hash matches
[   32.410476][    T1] usb usb58-port5: hash matches
[   32.410614][    T1] usb usb26-port1: hash matches
[   32.411199][    T1] netconsole: network logging started
[   32.412165][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   32.435157][    T1] rdma_rxe: loaded
[   32.440081][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   32.446570][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   32.450487][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   32.454686][   T31] faux_driver regulatory: Direct firmware load for reg=
ulatory.db failed with error -2
[   32.454728][   T31] faux_driver regulatory: Falling back to sysfs fallba=
ck for: regulatory.db
[   32.459994][    T1] clk: Disabling unused clocks
[   32.460415][    T1] ALSA device list:
[   32.460429][    T1]   #0: Dummy 1
[   32.460444][    T1]   #1: Loopback 1
[   32.460456][    T1]   #2: Virtual MIDI Card 1
[   32.610149][    T1] check access for rdinit=3D/init failed: -2, ignoring
[   32.610176][    T1] md: Waiting for all devices to be available before a=
utodetect
[   32.610183][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   32.610197][    T1] md: Autodetecting RAID arrays.
[   32.610316][    T1] md: autorun ...
[   32.610324][    T1] md: ... autorun DONE.
[   32.673022][ T5160] dec_stack_record_count: refcount went to 0 for 12543=
6371 handle
[   32.673441][    T1] dec_stack_record_count: refcount went to 0 for 468 h=
andle
[   32.676518][    T1] dec_stack_record_count: refcount went to 0 for 96207=
031 handle
[   32.677071][    T1] ------------[ cut here ]------------
[   32.677084][    T1] WARNING: CPU: 0 PID: 1 at lib/stackdepot.c:510 depot=
_fetch_stack+0x97/0xa0
[   32.677108][    T1] Modules linked in:
[   32.677128][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     =
   W           6.16.0-syzkaller-11579-g35a813e010b9-dirty #0 PREEMPT_{RT,(f=
ull)}=20
[   32.677150][    T1] Tainted: [W]=3DWARN
[   32.677155][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 07/12/2025
[   32.677165][    T1] RIP: 0010:depot_fetch_stack+0x97/0xa0
[   32.677180][    T1] Code: c7 c7 d7 a3 04 8d 89 ee 44 89 f2 89 d9 e8 e1 c=
a 95 fc 90 0f 0b 90 90 31 c0 5b 41 5e 5d e9 c1 7c 08 06 cc 90 0f 0b 90 eb e=
e 90 <0f> 0b 90 eb e8 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
[   32.677192][    T1] RSP: 0000:ffffc90000067480 EFLAGS: 00010246
[   32.677205][    T1] RAX: ffff88814371c000 RBX: 0000000000002de0 RCX: 000=
00000000000b6
[   32.677215][    T1] RDX: 0000000000000000 RSI: ffffffff8d1e65a6 RDI: fff=
fffff8b61eb00
[   32.677226][    T1] RBP: 00000000000000b6 R08: 0000000000000000 R09: 000=
0000000000000
[   32.677235][    T1] R10: dffffc0000000000 R11: ffffed10035a9b81 R12: 000=
0000000000000
[   32.677245][    T1] R13: 0000000000000000 R14: 00000000000001d4 R15: 000=
000079bacacab
[   32.677255][    T1] FS:  0000000000000000(0000) GS:ffff888126af6000(0000=
) knlGS:0000000000000000
[   32.677267][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   32.677277][    T1] CR2: ffff88823ffff000 CR3: 000000000d5a6000 CR4: 000=
00000003526f0
[   32.677290][    T1] Call Trace:
[   32.677296][    T1]  <TASK>
[   32.677305][    T1]  __reset_page_owner+0xd0/0x1f0
[   32.677328][    T1]  free_unref_folios+0x1ebb/0x2280
[   32.677365][    T1]  folios_put_refs+0x569/0x670
[   32.677396][    T1]  ? __pfx_folios_put_refs+0x10/0x10
[   32.677427][    T1]  truncate_inode_pages_range+0x338/0xb90
[   32.677450][    T1]  ? __pfx_truncate_inode_pages_range+0x10/0x10
[   32.677485][    T1]  ? has_bh_in_lru+0x307/0x340
[   32.677507][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
[   32.677530][    T1]  ? smp_call_function_many_cond+0xda5/0x12d0
[   32.677572][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   32.677593][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
[   32.677620][    T1]  blkdev_flush_mapping+0x10b/0x280
[   32.677641][    T1]  ? bdev_release+0x41a/0x660
[   32.677662][    T1]  bdev_release+0x422/0x660
[   32.677687][    T1]  ? __pfx_blkdev_release+0x10/0x10
[   32.677709][    T1]  blkdev_release+0x15/0x20
[   32.677729][    T1]  __fput+0x458/0xa80
[   32.677761][    T1]  task_work_run+0x1d1/0x260
[   32.677795][    T1]  ? __pfx_task_work_run+0x10/0x10
[   32.677825][    T1]  mount_root_generic+0x1b0/0x350
[   32.677851][    T1]  ? __pfx_mount_root_generic+0x10/0x10
[   32.677869][    T1]  ? getname_kernel+0x20e/0x2f0
[   32.677893][    T1]  ? kernel_init+0x1d/0x1d0
[   32.677914][    T1]  prepare_namespace+0x71/0xa0
[   32.677929][    T1]  kernel_init_freeable+0x373/0x4b0
[   32.677948][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   32.677963][    T1]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
[   32.677991][    T1]  ? __pfx_kernel_init+0x10/0x10
[   32.678012][    T1]  kernel_init+0x1d/0x1d0
[   32.678031][    T1]  ? __pfx_kernel_init+0x10/0x10
[   32.678050][    T1]  ret_from_fork+0x3fc/0x770
[   32.678092][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[   32.678114][    T1]  ? __switch_to_asm+0x39/0x70
[   32.678137][    T1]  ? __switch_to_asm+0x33/0x70
[   32.678158][    T1]  ? __pfx_kernel_init+0x10/0x10
[   32.678180][    T1]  ret_from_fork_asm+0x1a/0x30
[   32.678214][    T1]  </TASK>
[   32.678226][    T1] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   32.678238][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     =
   W           6.16.0-syzkaller-11579-g35a813e010b9-dirty #0 PREEMPT_{RT,(f=
ull)}=20
[   32.678259][    T1] Tainted: [W]=3DWARN
[   32.678264][    T1] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 07/12/2025
[   32.678273][    T1] Call Trace:
[   32.678279][    T1]  <TASK>
[   32.678284][    T1]  dump_stack_lvl+0x99/0x250
[   32.678305][    T1]  ? __asan_memcpy+0x40/0x70
[   32.678322][    T1]  ? __pfx_dump_stack_lvl+0x10/0x10
[   32.678342][    T1]  ? __pfx__printk+0x10/0x10
[   32.678367][    T1]  vpanic+0x281/0x750
[   32.678388][    T1]  ? __pfx__printk+0x10/0x10
[   32.678402][    T1]  ? __pfx_vpanic+0x10/0x10
[   32.678422][    T1]  ? is_bpf_text_address+0x26/0x2b0
[   32.678450][    T1]  panic+0xb9/0xc0
[   32.678470][    T1]  ? __pfx_panic+0x10/0x10
[   32.678502][    T1]  __warn+0x31b/0x4b0
[   32.678521][    T1]  ? depot_fetch_stack+0x97/0xa0
[   32.678536][    T1]  ? depot_fetch_stack+0x97/0xa0
[   32.678550][    T1]  report_bug+0x2be/0x4f0
[   32.678564][    T1]  ? depot_fetch_stack+0x97/0xa0
[   32.678578][    T1]  ? depot_fetch_stack+0x97/0xa0
[   32.678591][    T1]  ? depot_fetch_stack+0x99/0xa0
[   32.678604][    T1]  handle_bug+0x84/0x160
[   32.678624][    T1]  exc_invalid_op+0x1a/0x50
[   32.678642][    T1]  asm_exc_invalid_op+0x1a/0x20
[   32.678658][    T1] RIP: 0010:depot_fetch_stack+0x97/0xa0
[   32.678672][    T1] Code: c7 c7 d7 a3 04 8d 89 ee 44 89 f2 89 d9 e8 e1 c=
a 95 fc 90 0f 0b 90 90 31 c0 5b 41 5e 5d e9 c1 7c 08 06 cc 90 0f 0b 90 eb e=
e 90 <0f> 0b 90 eb e8 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90
[   32.678684][    T1] RSP: 0000:ffffc90000067480 EFLAGS: 00010246
[   32.678696][    T1] RAX: ffff88814371c000 RBX: 0000000000002de0 RCX: 000=
00000000000b6
[   32.678707][    T1] RDX: 0000000000000000 RSI: ffffffff8d1e65a6 RDI: fff=
fffff8b61eb00
[   32.678717][    T1] RBP: 00000000000000b6 R08: 0000000000000000 R09: 000=
0000000000000
[   32.678726][    T1] R10: dffffc0000000000 R11: ffffed10035a9b81 R12: 000=
0000000000000
[   32.678736][    T1] R13: 0000000000000000 R14: 00000000000001d4 R15: 000=
000079bacacab
[   32.678760][    T1]  __reset_page_owner+0xd0/0x1f0
[   32.678781][    T1]  free_unref_folios+0x1ebb/0x2280
[   32.678829][    T1]  folios_put_refs+0x569/0x670
[   32.678859][    T1]  ? __pfx_folios_put_refs+0x10/0x10
[   32.678890][    T1]  truncate_inode_pages_range+0x338/0xb90
[   32.678913][    T1]  ? __pfx_truncate_inode_pages_range+0x10/0x10
[   32.678948][    T1]  ? has_bh_in_lru+0x307/0x340
[   32.678970][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
[   32.678992][    T1]  ? smp_call_function_many_cond+0xda5/0x12d0
[   32.679033][    T1]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[   32.679054][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
[   32.679086][    T1]  blkdev_flush_mapping+0x10b/0x280
[   32.679106][    T1]  ? bdev_release+0x41a/0x660
[   32.679127][    T1]  bdev_release+0x422/0x660
[   32.679152][    T1]  ? __pfx_blkdev_release+0x10/0x10
[   32.679174][    T1]  blkdev_release+0x15/0x20
[   32.679194][    T1]  __fput+0x458/0xa80
[   32.679225][    T1]  task_work_run+0x1d1/0x260
[   32.679250][    T1]  ? __pfx_task_work_run+0x10/0x10
[   32.679282][    T1]  mount_root_generic+0x1b0/0x350
[   32.679306][    T1]  ? __pfx_mount_root_generic+0x10/0x10
[   32.679327][    T1]  ? getname_kernel+0x20e/0x2f0
[   32.679351][    T1]  ? kernel_init+0x1d/0x1d0
[   32.679371][    T1]  prepare_namespace+0x71/0xa0
[   32.679386][    T1]  kernel_init_freeable+0x373/0x4b0
[   32.679405][    T1]  ? __pfx_kernel_init_freeable+0x10/0x10
[   32.679421][    T1]  ? __pfx_rt_mutex_slowunlock+0x10/0x10
[   32.679448][    T1]  ? __pfx_kernel_init+0x10/0x10
[   32.679470][    T1]  kernel_init+0x1d/0x1d0
[   32.679489][    T1]  ? __pfx_kernel_init+0x10/0x10
[   32.679508][    T1]  ret_from_fork+0x3fc/0x770
[   32.679528][    T1]  ? __pfx_ret_from_fork+0x10/0x10
[   32.679550][    T1]  ? __switch_to_asm+0x39/0x70
[   32.679572][    T1]  ? __switch_to_asm+0x33/0x70
[   32.679593][    T1]  ? __pfx_kernel_init+0x10/0x10
[   32.679615][    T1]  ret_from_fork_asm+0x1a/0x30
[   32.679649][    T1]  </TASK>
[   32.680257][    T1] Kernel Offset: disabled


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3629070628=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at 0c075d67fc
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' ./sys/syz-sysgen | grep -q false || go install ./sy=
s/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D0c075d67fcfde8d048cca2f751a82db97ebc3754 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250731-125440"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"0c075d67fcfde8d048cca2f751a82db97e=
bc3754\"
/usr/bin/ld: /tmp/ccXqOJPu.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17ebfaa2580000


Tested on:

commit:         35a813e0 Merge tag 'printk-for-6.17' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7d9fab85f5904d6=
4
dashboard link: https://syzkaller.appspot.com/bug?extid=3D2a0d2af125c01db73=
079
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D110302f05800=
00


