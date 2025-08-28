Return-Path: <linux-kernel+bounces-789573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0227AB3977D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA625E50A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622802EB856;
	Thu, 28 Aug 2025 08:50:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D43B2EA741
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371007; cv=none; b=T2MDEYFcAG9CGTe2cm8Haz//kZiIqwPnMDWhfFssbv/NBOpOq8Z9+QbPHWb5cmjK7Glfx0qipjfnigqJkb6cPwcXoTz/oEYDHggmWmP+thgUhmb+een/zUDtSDy/vb7jWuKTiZLheqGy0oIFzUQoeGKX5Ja8wJUwhGS+zqObBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371007; c=relaxed/simple;
	bh=dbvZc9Q0CI5dQzYY2F9rPy5+VZ7yVrW0sYBCsYfyqJI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ttcJJgImHUM8yqaROEotr6sTyeqa2Frfot83ecSy55cH0u1j/8aLOtjgf0UQHE4vFDMkCSpc2joV4Avy/MCY5dTpxOX/dncJRWKUrhXEPgp76WThO6HZvW6rMMKwJPKjTnaZyycpt4QTV1ZmUQPYQidB8eevgLWWf7fJug1zHsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f1ca34d50aso5303625ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371004; x=1756975804;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pyosj0Y7I3KMZwOrtfqr2MoCHxxCIs7RzGiFKrWSk8=;
        b=T/OF3v6w0kumEbz/n/9epD+lQL72bQK8qrOeNfL0TdayQO5m1OTtLTQ2pYcSwg1KIK
         LGPzemQidfhajEYW7fnwbjY/xvv40GMnFw7VjI/d07QaaQdUdfvQmaZWajoOhns0YDDt
         zvcS6wzb4Cmnk/N/0t3xrUgY6tmkuZtpGr2X+yRmNLBaVBcWv6XKhEzS1K/bRz+eFGLy
         TstKnH6+mRH0CNKDFsVuLAXVcitlxxlYJ7/vgrnMzyIHASyLvLmPQjOQ/mV+JDmg8PM/
         sBo77GSue/Zp5OwIllomp1hGqQMVmQugieoTEe0r8MI9lXqRvaluNihgesJ5Gw/xd9G0
         QSWw==
X-Forwarded-Encrypted: i=1; AJvYcCXH1Q0XoCrznuNyzEfLkgCZ9cVsodvKY0VZo+OofTqhz3ayAMfIrD0jdsmi7QUNsbMvyuzCrSoMIGCCTQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+j7oH0sxYXKeWn8+HvNBmgjrDxBywDyUpCygOIw5EoZJbgPd
	rkIB/G08DyGyO4xfBuwtpCkXBYziOn/QHt0BGHYQR7veiW6qOjXwJngtZT+BaB8+g2HEbzF88jj
	IEAxqUD/MI8uz4rL3sZfPvecMJtPhkNF87UkzZMZdhooSJluWtUNsVvdb/6A=
X-Google-Smtp-Source: AGHT+IHJ/kiU+00Ot/jVBP6Jrzir+XyPJHpVfxqaCSmXRDkSDPkmqDfXXezpXeSExh6Sa1nC2Gx1jj40L3bUZuwlnni5wTi1qJJN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3e5:3521:46e3 with SMTP id
 e9e14a558f8ab-3e9228e492amr165022355ab.23.1756371004507; Thu, 28 Aug 2025
 01:50:04 -0700 (PDT)
Date: Thu, 28 Aug 2025 01:50:04 -0700
In-Reply-To: <20250828073832.5955-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b0183c.a00a0220.1337b0.0005.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in copy_process
From: syzbot <syzbot+69c74d38464686431506@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:


[   24.839186][    T1] evm: security.SMACK64MMAP (disabled)
[   24.844657][    T1] evm: security.apparmor
[   24.848870][    T1] evm: security.ima
[   24.852666][    T1] evm: security.capability
[   24.857068][    T1] evm: HMAC attrs: 0x1
[   24.863496][    T1] PM:   Magic number: 5:98:676
[   24.868417][    T1] vidtv vidtv.0: hash matches
[   24.873486][    T1] vtconsole vtcon1: hash matches
[   24.878824][    T1] netconsole: network logging started
[   24.885707][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   24.898123][    T1] rdma_rxe: loaded
[   24.903786][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   24.914903][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   24.923018][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   24.932846][    T1] clk: Disabling unused clocks
[   24.936188][ T1074] faux_driver regulatory: Direct firmware load for reg=
ulatory.db failed with error -2
[   24.937797][    T1] ALSA device list:
[   24.947507][ T1074] faux_driver regulatory: Falling back to sysfs fallba=
ck for: regulatory.db
[   24.951295][    T1]   #0: Dummy 1
[   24.963561][    T1]   #1: Loopback 1
[   24.967283][    T1]   #2: Virtual MIDI Card 1
[   24.975146][    T1] check access for rdinit=3D/init failed: -2, ignoring
[   24.981931][    T1] md: Waiting for all devices to be available before a=
utodetect
[   24.989601][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   24.996129][    T1] md: Autodetecting RAID arrays.
[   25.001152][    T1] md: autorun ...
[   25.004810][    T1] md: ... autorun DONE.
[   25.148807][    T1] EXT4-fs (sda1): orphan cleanup on readonly fs
[   25.157214][    T1] EXT4-fs (sda1): mounted filesystem 4f91c6db-4997-4bb=
4-91b8-7e83a20c1bf1 ro with ordered data mode. Quota mode: none.
[   25.169949][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   25.179896][    T1] devtmpfs: mounted
[   25.258340][    T1] Freeing unused kernel image (initmem) memory: 26240K
[   25.269309][    T1] Write protecting the kernel read-only data: 215040k
[   25.289080][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1324K
[   25.302433][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1172K
[   25.415374][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   25.423477][    T1] x86/mm: Checking user space page tables
[   25.519340][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   25.532019][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   25.541904][    T1] Run /sbin/init as init process
[   25.827231][ T5199] mount (5199) used greatest stack depth: 23848 bytes =
left
[   25.868863][ T5200] EXT4-fs (sda1): re-mounted 4f91c6db-4997-4bb4-91b8-7=
e83a20c1bf1 r/w.
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   26.015900][ T5204] mount (5204) used greatest stack depth: 21672 bytes =
left
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: [   26.784555][ T5232] logger (5232) used greatest stack de=
pth: 20968 bytes left
OK
Populating /dev using udev: [   27.037193][ T5234] udevd[5234]: starting ve=
rsion 3.2.14
[   27.218556][ T5235] udevd[5235]: starting eudev-3.2.14
[   27.226019][ T5234] udevd (5234) used greatest stack depth: 18584 bytes =
left
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-10.2.0 starting
dev: loaded udev
no interfaces have a carrier
[   49.923153][ T5530] 8021q: adding VLAN 0 to HW filter on device bond0
[   49.941046][ T5530] eql: remember to turn off Van-Jacobson compression o=
n your slave devices
Starting crond: OK
Starting sshd: OK


syzkaller

syzkaller login: [   61.193277][   T49] ------------[ cut here ]-----------=
-
[   61.199021][   T49] WARNING: ./include/linux/backing-dev.h:243 at __foli=
o_start_writeback+0x9d5/0xb70, CPU#1: kworker/u8:3/49
[   61.211060][   T49] Modules linked in:
[   61.215644][   T49] CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted=
 syzkaller #0 PREEMPT(full)=20
[   61.225807][   T49] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 07/12/2025
[   61.236905][   T49] Workqueue: writeback wb_workfn (flush-8:0)
[   61.243497][   T49] RIP: 0010:__folio_start_writeback+0x9d5/0xb70
[   61.250271][   T49] Code: 28 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4=
c 89 ff e8 0e 02 2a 00 49 8b 07 25 ff 3f 00 00 e9 1b fa ff ff e8 8c f7 c5 f=
f 90 <0f> 0b 90 e9 d6 fb ff ff e8 7e f7 c5 ff 48 c7 c7 e0 fe 5f 8e 4c 89
[   61.270834][   T49] RSP: 0018:ffffc90000b96ea0 EFLAGS: 00010293
[   61.277505][   T49] RAX: ffffffff81fb0bb4 RBX: ffffea000507ff40 RCX: fff=
f888021ee9e00
[   61.286051][   T49] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   61.294530][   T49] RBP: ffffc90000b97010 R08: ffffc90000b96f97 R09: 000=
0000000000000
[   61.302593][   T49] R10: ffffc90000b96f80 R11: fffff52000172df3 R12: fff=
fea000507ff48
[   61.310575][   T49] R13: 0000000000000000 R14: ffff88802330fb80 R15: fff=
f88802330f960
[   61.318618][   T49] FS:  0000000000000000(0000) GS:ffff8881258ba000(0000=
) knlGS:0000000000000000
[   61.327639][   T49] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.334313][   T49] CR2: 00007f5df5d7c368 CR3: 000000000e338000 CR4: 000=
00000003526f0
[   61.342341][   T49] Call Trace:
[   61.345632][   T49]  <TASK>
[   61.348570][   T49]  ? folio_clear_dirty_for_io+0x226/0x880
[   61.354381][   T49]  ? __pfx___folio_start_writeback+0x10/0x10
[   61.360382][   T49]  ? __pfx_folio_clear_dirty_for_io+0x10/0x10
[   61.366955][   T49]  ? stack_trace_save+0x9c/0xe0
[   61.371876][   T49]  __block_write_full_folio+0x75f/0xe10
[   61.377524][   T49]  ? __pfx_blkdev_get_block+0x10/0x10
[   61.382990][   T49]  blkdev_writepages+0xd1/0x170
[   61.388034][   T49]  ? __pfx_blkdev_writepages+0x10/0x10
[   61.393613][   T49]  ? __pfx_blkdev_writepages+0x10/0x10
[   61.399100][   T49]  do_writepages+0x32e/0x550
[   61.403771][   T49]  __writeback_single_inode+0x145/0xff0
[   61.409342][   T49]  ? wbc_attach_and_unlock_inode+0x3f0/0x5d0
[   61.415796][   T49]  writeback_sb_inodes+0x6c7/0x1010
[   61.421052][   T49]  ? __pfx_writeback_sb_inodes+0x10/0x10
[   61.426785][   T49]  ? __pfx_down_read_trylock+0x10/0x10
[   61.432326][   T49]  ? __pfx___up_read+0x10/0x10
[   61.437121][   T49]  __writeback_inodes_wb+0x111/0x240
[   61.442532][   T49]  wb_writeback+0x44f/0xaf0
[   61.447153][   T49]  ? queue_io+0x301/0x590
[   61.451514][   T49]  ? __pfx_wb_writeback+0x10/0x10
[   61.456660][   T49]  wb_workfn+0xaef/0xef0
[   61.461023][   T49]  ? __pfx_wb_workfn+0x10/0x10
[   61.465874][   T49]  ? __lock_acquire+0xab9/0xd20
[   61.470765][   T49]  ? process_scheduled_works+0x9ef/0x17b0
[   61.476587][   T49]  ? _raw_spin_unlock_irq+0x23/0x50
[   61.481819][   T49]  ? process_scheduled_works+0x9ef/0x17b0
[   61.487604][   T49]  ? process_scheduled_works+0x9ef/0x17b0
[   61.493412][   T49]  process_scheduled_works+0xade/0x17b0
[   61.499293][   T49]  ? __pfx_process_scheduled_works+0x10/0x10
[   61.505356][   T49]  worker_thread+0x8a0/0xda0
[   61.510083][   T49]  kthread+0x70e/0x8a0
[   61.514242][   T49]  ? __pfx_worker_thread+0x10/0x10
[   61.519371][   T49]  ? __pfx_kthread+0x10/0x10
[   61.524014][   T49]  ? _raw_spin_unlock_irq+0x23/0x50
[   61.529226][   T49]  ? lockdep_hardirqs_on+0x9c/0x150
[   61.534487][   T49]  ? __pfx_kthread+0x10/0x10
[   61.539097][   T49]  ret_from_fork+0x47c/0x820
[   61.543750][   T49]  ? __pfx_ret_from_fork+0x10/0x10
[   61.548892][   T49]  ? __switch_to_asm+0x39/0x70
[   61.554159][   T49]  ? __switch_to_asm+0x33/0x70
[   61.558943][   T49]  ? __pfx_kthread+0x10/0x10
[   61.563593][   T49]  ret_from_fork_asm+0x1a/0x30
[   61.568400][   T49]  </TASK>
[   61.571434][   T49] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   61.578719][   T49] CPU: 1 UID: 0 PID: 49 Comm: kworker/u8:3 Not tainted=
 syzkaller #0 PREEMPT(full)=20
[   61.588013][   T49] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 07/12/2025
[   61.598086][   T49] Workqueue: writeback wb_workfn (flush-8:0)
[   61.604111][   T49] Call Trace:
[   61.607477][   T49]  <TASK>
[   61.610398][   T49]  dump_stack_lvl+0x99/0x250
[   61.615000][   T49]  ? __asan_memcpy+0x40/0x70
[   61.619582][   T49]  ? __pfx_dump_stack_lvl+0x10/0x10
[   61.624789][   T49]  ? __pfx__printk+0x10/0x10
[   61.629419][   T49]  vpanic+0x229/0x6d0
[   61.633483][   T49]  ? __pfx_vpanic+0x10/0x10
[   61.637984][   T49]  ? is_bpf_text_address+0x292/0x2b0
[   61.643263][   T49]  ? is_bpf_text_address+0x26/0x2b0
[   61.648458][   T49]  panic+0xb9/0xc0
[   61.652212][   T49]  ? __pfx_panic+0x10/0x10
[   61.656633][   T49]  ? ret_from_fork_asm+0x1a/0x30
[   61.661566][   T49]  __warn+0x334/0x4c0
[   61.665629][   T49]  ? __folio_start_writeback+0x9d5/0xb70
[   61.671259][   T49]  ? __folio_start_writeback+0x9d5/0xb70
[   61.676881][   T49]  report_bug+0x2be/0x4f0
[   61.681209][   T49]  ? __folio_start_writeback+0x9d5/0xb70
[   61.686829][   T49]  ? __folio_start_writeback+0x9d5/0xb70
[   61.692461][   T49]  ? __folio_start_writeback+0x9d7/0xb70
[   61.698092][   T49]  handle_bug+0x84/0x160
[   61.702333][   T49]  exc_invalid_op+0x1a/0x50
[   61.706834][   T49]  asm_exc_invalid_op+0x1a/0x20
[   61.711672][   T49] RIP: 0010:__folio_start_writeback+0x9d5/0xb70
[   61.717906][   T49] Code: 28 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4=
c 89 ff e8 0e 02 2a 00 49 8b 07 25 ff 3f 00 00 e9 1b fa ff ff e8 8c f7 c5 f=
f 90 <0f> 0b 90 e9 d6 fb ff ff e8 7e f7 c5 ff 48 c7 c7 e0 fe 5f 8e 4c 89
[   61.737513][   T49] RSP: 0018:ffffc90000b96ea0 EFLAGS: 00010293
[   61.743575][   T49] RAX: ffffffff81fb0bb4 RBX: ffffea000507ff40 RCX: fff=
f888021ee9e00
[   61.751536][   T49] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000=
0000000000000
[   61.759496][   T49] RBP: ffffc90000b97010 R08: ffffc90000b96f97 R09: 000=
0000000000000
[   61.767548][   T49] R10: ffffc90000b96f80 R11: fffff52000172df3 R12: fff=
fea000507ff48
[   61.775511][   T49] R13: 0000000000000000 R14: ffff88802330fb80 R15: fff=
f88802330f960
[   61.783661][   T49]  ? __folio_start_writeback+0x9d4/0xb70
[   61.789308][   T49]  ? folio_clear_dirty_for_io+0x226/0x880
[   61.795141][   T49]  ? __pfx___folio_start_writeback+0x10/0x10
[   61.801124][   T49]  ? __pfx_folio_clear_dirty_for_io+0x10/0x10
[   61.807192][   T49]  ? stack_trace_save+0x9c/0xe0
[   61.812048][   T49]  __block_write_full_folio+0x75f/0xe10
[   61.817587][   T49]  ? __pfx_blkdev_get_block+0x10/0x10
[   61.822951][   T49]  blkdev_writepages+0xd1/0x170
[   61.827793][   T49]  ? __pfx_blkdev_writepages+0x10/0x10
[   61.833265][   T49]  ? __pfx_blkdev_writepages+0x10/0x10
[   61.838887][   T49]  do_writepages+0x32e/0x550
[   61.843486][   T49]  __writeback_single_inode+0x145/0xff0
[   61.849028][   T49]  ? wbc_attach_and_unlock_inode+0x3f0/0x5d0
[   61.855009][   T49]  writeback_sb_inodes+0x6c7/0x1010
[   61.860230][   T49]  ? __pfx_writeback_sb_inodes+0x10/0x10
[   61.865887][   T49]  ? __pfx_down_read_trylock+0x10/0x10
[   61.871340][   T49]  ? __pfx___up_read+0x10/0x10
[   61.876121][   T49]  __writeback_inodes_wb+0x111/0x240
[   61.881420][   T49]  wb_writeback+0x44f/0xaf0
[   61.885923][   T49]  ? queue_io+0x301/0x590
[   61.890250][   T49]  ? __pfx_wb_writeback+0x10/0x10
[   61.895299][   T49]  wb_workfn+0xaef/0xef0
[   61.899543][   T49]  ? __pfx_wb_workfn+0x10/0x10
[   61.904300][   T49]  ? __lock_acquire+0xab9/0xd20
[   61.909152][   T49]  ? process_scheduled_works+0x9ef/0x17b0
[   61.914872][   T49]  ? _raw_spin_unlock_irq+0x23/0x50
[   61.920061][   T49]  ? process_scheduled_works+0x9ef/0x17b0
[   61.925769][   T49]  ? process_scheduled_works+0x9ef/0x17b0
[   61.931508][   T49]  process_scheduled_works+0xade/0x17b0
[   61.937069][   T49]  ? __pfx_process_scheduled_works+0x10/0x10
[   61.943066][   T49]  worker_thread+0x8a0/0xda0
[   61.947677][   T49]  kthread+0x70e/0x8a0
[   61.951745][   T49]  ? __pfx_worker_thread+0x10/0x10
[   61.956848][   T49]  ? __pfx_kthread+0x10/0x10
[   61.961434][   T49]  ? _raw_spin_unlock_irq+0x23/0x50
[   61.967056][   T49]  ? lockdep_hardirqs_on+0x9c/0x150
[   61.972244][   T49]  ? __pfx_kthread+0x10/0x10
[   61.976831][   T49]  ret_from_fork+0x47c/0x820
[   61.981502][   T49]  ? __pfx_ret_from_fork+0x10/0x10
[   61.987052][   T49]  ? __switch_to_asm+0x39/0x70
[   61.991803][   T49]  ? __switch_to_asm+0x33/0x70
[   61.996560][   T49]  ? __pfx_kthread+0x10/0x10
[   62.001202][   T49]  ret_from_fork_asm+0x1a/0x30
[   62.005975][   T49]  </TASK>
[   62.009227][   T49] Kernel Offset: disabled
[   62.013542][   T49] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build4186761874=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at e12e5ba469
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3De12e5ba469cd05aa76330394486b1f2a24dd4ef6 -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20250826-131543"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3De12e5ba469cd05aa76330394486b1f2a24dd4ef6 -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20250826-131543"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3De12e5ba469cd05aa76330394486b1f2a24dd4ef6 -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20250826-131543"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"e12e5ba469cd05aa76330394486b1f2a24=
dd4ef6\"
/usr/bin/ld: /tmp/ccdzFu7W.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D131edc62580000


Tested on:

commit:         8cd53fb4 Add linux-next specific files for 20250828
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db2dd1e2b1175b2b=
e
dashboard link: https://syzkaller.appspot.com/bug?extid=3D69c74d38464686431=
506
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-=
1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D17487c425800=
00


