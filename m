Return-Path: <linux-kernel+bounces-890486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1096C402C2
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54E4C4F014D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A162F6596;
	Fri,  7 Nov 2025 13:44:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827F2F28FF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523048; cv=none; b=WSMjmmD4lv6yEwTt4HfKoJTOUEQW1RDXpe5rCd/u3wIna2kVS7zPQaKA/5RTBeQANMZG/fb3xALlwbWhVrKgZ5RbbRRJf0LdpP6ouJ8Du3DyRl1qBY8mm611TsAlQAdyFc1x9d6ApAZhk1XvE4iQzOAVKMM4NSfTer+udcwBkuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523048; c=relaxed/simple;
	bh=syIlmXuKbZkx0NBh5kCQzUfbtEEy4NuWyKuZLkLsKeg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aEHm2NdjgdLNsJhmtFe204cQxyfGJ6ZsEZBlIRtYfMIqBuPrxvBDr5Km6qUUbkOlgNal6OPEdTAiNujfNDVqDN9CNh/F2CSdQ/Zp5EhZ5MOipF10+8SmqziSlD4j8PmI6g11Rdbjs/rS6Z/djHjYWeEDAr/PcmZtFbCxzktqrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4335b48ad16so8470855ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523045; x=1763127845;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fleKBZVDEwckqZQt250pYemA353qSolISfl/m1slqc=;
        b=k4CJ/8CFADUvlfvWn5uz7WFDhItD784vZXW/iGZDmlrRmGzFcrOKr2CdMBuM/WXvoZ
         zcRtMa5mK1kQGzeU+Y/DM7moziQL2WT8869ldk/U6UQZaMLN1wFGW5xRMcU3qkljFM8d
         Oiir9fv0suHxz+nPeDBGbf6D1HGuFpgFpLeIF88an07uldMQi1qEdY5KmkeFFzPcVpRl
         iFQlbms+24NohcWlrCXujlzHWuqraDPq6B4FUg1hbKK+lQpLBIJFJ1D/Za7OQjdQoYnB
         st9+1QyAnsTNHPx9G0H5tL6L1gjWz5O9Ahx/6EKwWddqVBU+n8nvT5CDherI57+/87eu
         rkfg==
X-Forwarded-Encrypted: i=1; AJvYcCVRcbAdNnm+4B4fM4nArgG2tyQfmnclJjt3tLH8hAMOw7pDF262DxX4f8e81cwb+chzlR+AFaJpGP+s57s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQom8E4/S7LZg/bYBTn1KHIjVmrwYTjjyZh38lYGfvlhSFqOMH
	4RMFD7fUo5fJ+bIDvZNDNj9uyaV88/fv89MSeEtEml0jv9H3AaaU5wZt2uiBgZkUkNPxLXN/6M4
	9b2sLQYfXVJTH3YGS2kQAHb71A8ROBGKVGm27J2bEJa0uZxARmGBx4ynnlXE=
X-Google-Smtp-Source: AGHT+IHqhdTYYaxo9uQXbJ2lF3tJI35zqW9HOIzFscvu+iESGGvNAokWwSGWlp9i3+97cQ4um1d5R30VLIWB0AkM/zhZDbvdCtCA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:433:2660:6856 with SMTP id
 e9e14a558f8ab-4335f4b5b93mr43284365ab.31.1762523044759; Fri, 07 Nov 2025
 05:44:04 -0800 (PST)
Date: Fri, 07 Nov 2025 05:44:04 -0800
In-Reply-To: <20251107114335.22409-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690df7a4.a70a0220.22f260.004c.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

 26.481884][    T1] Loading compiled-in X.509 certificates
[   26.516950][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: f5143acf1d690a3971428b7fa3c37300acff3a6e'
[   26.900243][    T1] zswap: loaded using pool 842
[   26.908732][    T1] Demotion targets for Node 0: null
[   26.914058][    T1] Demotion targets for Node 1: null
[   26.919319][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   29.792072][    T1] Key type .fscrypt registered
[   29.796868][    T1] Key type fscrypt-provisioning registered
[   29.806376][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   29.835595][    T1] Btrfs loaded, assert=3Don, zoned=3Dyes, fsverity=3Dy=
es
[   29.843055][    T1] Key type big_key registered
[   29.847786][    T1] Key type encrypted registered
[   29.852651][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   29.859262][    T1] ima: No TPM chip found, activating TPM-bypass!
[   29.865703][    T1] Loading compiled-in module X.509 certificates
[   29.898151][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: f5143acf1d690a3971428b7fa3c37300acff3a6e'
[   29.909093][    T1] ima: Allocated hash algorithm: sha256
[   29.915206][    T1] ima: No architecture policies found
[   29.921406][    T1] evm: Initialising EVM extended attributes:
[   29.927394][    T1] evm: security.selinux (disabled)
[   29.932519][    T1] evm: security.SMACK64 (disabled)
[   29.937623][    T1] evm: security.SMACK64EXEC (disabled)
[   29.943088][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   29.948967][    T1] evm: security.SMACK64MMAP (disabled)
[   29.954435][    T1] evm: security.apparmor
[   29.958662][    T1] evm: security.ima
[   29.962478][    T1] evm: security.capability
[   29.966893][    T1] evm: HMAC attrs: 0x1
[   29.973825][    T1] PM:   Magic number: 1:963:583
[   29.978800][    T1] cec cec10: hash matches
[   29.983532][    T1] tty ptyc1: hash matches
[   29.988103][    T1] netconsole: network logging started
[   29.994201][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   30.007061][    T1] rdma_rxe: loaded
[   30.013137][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   30.024801][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   30.034477][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   30.044095][ T1208] faux_driver regulatory: Direct firmware load for reg=
ulatory.db failed with error -2
[   30.051936][    T1] clk: Disabling unused clocks
[   30.053922][ T1208] faux_driver regulatory: Falling back to sysfs fallba=
ck for: regulatory.db
[   30.058707][    T1] ALSA device list:
[   30.071200][    T1]   #0: Dummy 1
[   30.074969][    T1]   #1: Loopback 1
[   30.078718][    T1]   #2: Virtual MIDI Card 1
[   30.086410][    T1] check access for rdinit=3D/init failed: -2, ignoring
[   30.093222][    T1] md: Waiting for all devices to be available before a=
utodetect
[   30.100857][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   30.107485][    T1] md: Autodetecting RAID arrays.
[   30.112631][    T1] md: autorun ...
[   30.116274][    T1] md: ... autorun DONE.
[   30.242475][    T1] EXT4-fs (sda1): orphan cleanup on readonly fs
[   30.251116][    T1] EXT4-fs (sda1): mounted filesystem 4f91c6db-4997-4bb=
4-91b8-7e83a20c1bf1 ro with ordered data mode. Quota mode: none.
[   30.263959][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   30.274587][    T1] devtmpfs: mounted
[   30.350955][    T1] Freeing unused kernel image (initmem) memory: 26112K
[   30.361768][    T1] Write protecting the kernel read-only data: 212992k
[   30.380228][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1436K
[   30.392825][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1240K
[   30.528715][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   30.536730][    T1] x86/mm: Checking user space page tables
[   30.654084][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   30.666870][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   30.676750][    T1] Run /sbin/init as init process
[   31.177715][ T5158] mount (5158) used greatest stack depth: 23576 bytes =
left
[   31.225728][ T5159] EXT4-fs (sda1): re-mounted 4f91c6db-4997-4bb4-91b8-7=
e83a20c1bf1 r/w.
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   31.387784][ T5163] mount (5163) used greatest stack depth: 21672 bytes =
left
Starting syslogd: OK
Starting acpid: OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   32.674421][ T5193] udevd[5193]: starting ve=
rsion 3.2.14
[   32.996569][ T5194] udevd[5194]: starting eudev-3.2.14
[   33.000117][ T5193] udevd (5193) used greatest stack depth: 18696 bytes =
left
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-10.2.0 starting
[   56.220735][ T5488] ------------[ cut here ]------------
[   56.226516][ T5488] WARNING: ./include/linux/ns_common.h:314 at nsfs_evi=
ct+0x18e/0x200, CPU#1: dhcpcd/5488
[   56.236736][ T5488] Modules linked in:
[   56.240773][ T5488] CPU: 1 UID: 0 PID: 5488 Comm: dhcpcd Not tainted syz=
kaller #0 PREEMPT(full)=20
[   56.249797][ T5488] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   56.260095][ T5488] RIP: 0010:nsfs_evict+0x18e/0x200
[   56.265291][ T5488] Code: 4d 8b 1e 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5=
d 41 ff e3 cc cc cc e8 01 c7 76 ff 90 0f 0b 90 e9 1f ff ff ff e8 f3 c6 76 f=
f 90 <0f> 0b 90 e9 42 ff ff ff e8 e5 c6 76 ff 90 0f 0b 90 e9 72 ff ff ff
[   56.285086][ T5488] RSP: 0018:ffffc9000389fa28 EFLAGS: 00010293
[   56.291186][ T5488] RAX: ffffffff824b0e3d RBX: ffffffff9a180fd8 RCX: fff=
f888027d00000
[   56.299224][ T5488] RDX: 0000000000000000 RSI: 00000000effffff8 RDI: 000=
00000effffff8
[   56.307291][ T5488] RBP: 00000000effffff8 R08: ffffffff9a181093 R09: 1ff=
ffffff3430212
[   56.315341][ T5488] R10: dffffc0000000000 R11: fffffbfff3430213 R12: dff=
ffc0000000000
[   56.323376][ T5488] R13: 1ffffffff34301fe R14: ffff888077f26d50 R15: fff=
fffff9a180ff0
[   56.331386][ T5488] FS:  00007ff1e1049740(0000) GS:ffff888125b78000(0000=
) knlGS:0000000000000000
[   56.340332][ T5488] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.346978][ T5488] CR2: 00005604455e84a0 CR3: 000000007d5e6000 CR4: 000=
00000003526f0
[   56.354995][ T5488] Call Trace:
[   56.358288][ T5488]  <TASK>
[   56.361298][ T5488]  ? __pfx_nsfs_evict+0x10/0x10
[   56.366173][ T5488]  evict+0x5f4/0xae0
[   56.370068][ T5488]  ? __pfx_evict+0x10/0x10
[   56.374531][ T5488]  ? _raw_spin_unlock+0x28/0x50
[   56.379401][ T5488]  ? iput+0xce7/0x1050
[   56.383538][ T5488]  __dentry_kill+0x209/0x660
[   56.388147][ T5488]  ? dput+0x37/0x2b0
[   56.392093][ T5488]  dput+0x19f/0x2b0
[   56.395945][ T5488]  path_put+0x39/0x60
[   56.399929][ T5488]  vfs_statx+0x36e/0x550
[   56.404250][ T5488]  ? __pfx_vfs_statx+0x10/0x10
[   56.409209][ T5488]  ? strncpy_from_user+0x150/0x2c0
[   56.414394][ T5488]  ? getname_flags+0x1e5/0x540
[   56.419195][ T5488]  vfs_fstatat+0x118/0x170
[   56.423710][ T5488]  __x64_sys_newfstatat+0x116/0x190
[   56.428941][ T5488]  ? __pfx___x64_sys_newfstatat+0x10/0x10
[   56.434927][ T5488]  ? do_syscall_64+0xbe/0xfa0
[   56.439644][ T5488]  do_syscall_64+0xfa/0xfa0
[   56.444214][ T5488]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.450300][ T5488]  ? clear_bhb_loop+0x60/0xb0
[   56.455019][ T5488]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.460957][ T5488] RIP: 0033:0x7ff1e113db0a
[   56.465433][ T5488] Code: 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8 ff ff f=
f ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 89 ca b8 06 01 00 00 0=
f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 b9 f2 0d 00 f7
[   56.485147][ T5488] RSP: 002b:00007ffe530d70b8 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000106
[   56.493625][ T5488] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000=
07ff1e113db0a
[   56.501659][ T5488] RDX: 00007ffe530d70c0 RSI: 0000560445610557 RDI: 000=
00000ffffff9c
[   56.509645][ T5488] RBP: 00007ffe530d9858 R08: 0000000000000000 R09: 000=
0000000000000
[   56.517679][ T5488] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07ffe530d8230
[   56.525708][ T5488] R13: 000056044e3fd8a0 R14: 0000000000001000 R15: 000=
07ff1e10496c8
[   56.533830][ T5488]  </TASK>
[   56.536879][ T5488] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   56.544239][ T5488] CPU: 1 UID: 0 PID: 5488 Comm: dhcpcd Not tainted syz=
kaller #0 PREEMPT(full)=20
[   56.553163][ T5488] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   56.563227][ T5488] Call Trace:
[   56.566502][ T5488]  <TASK>
[   56.569528][ T5488]  dump_stack_lvl+0x99/0x250
[   56.574131][ T5488]  ? __asan_memcpy+0x40/0x70
[   56.578721][ T5488]  ? __pfx_dump_stack_lvl+0x10/0x10
[   56.583912][ T5488]  ? __pfx__printk+0x10/0x10
[   56.588500][ T5488]  vpanic+0x237/0x6d0
[   56.592733][ T5488]  ? __pfx_vpanic+0x10/0x10
[   56.597237][ T5488]  ? is_bpf_text_address+0x292/0x2b0
[   56.602529][ T5488]  ? is_bpf_text_address+0x26/0x2b0
[   56.607740][ T5488]  panic+0xb9/0xc0
[   56.611464][ T5488]  ? __pfx_panic+0x10/0x10
[   56.615906][ T5488]  __warn+0x334/0x4c0
[   56.619892][ T5488]  ? nsfs_evict+0x18e/0x200
[   56.624402][ T5488]  ? nsfs_evict+0x18e/0x200
[   56.628910][ T5488]  report_bug+0x2be/0x4f0
[   56.633248][ T5488]  ? nsfs_evict+0x18e/0x200
[   56.637754][ T5488]  ? nsfs_evict+0x18e/0x200
[   56.642261][ T5488]  ? nsfs_evict+0x190/0x200
[   56.646864][ T5488]  handle_bug+0x84/0x160
[   56.651109][ T5488]  exc_invalid_op+0x1a/0x50
[   56.655637][ T5488]  asm_exc_invalid_op+0x1a/0x20
[   56.660495][ T5488] RIP: 0010:nsfs_evict+0x18e/0x200
[   56.665614][ T5488] Code: 4d 8b 1e 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5=
d 41 ff e3 cc cc cc e8 01 c7 76 ff 90 0f 0b 90 e9 1f ff ff ff e8 f3 c6 76 f=
f 90 <0f> 0b 90 e9 42 ff ff ff e8 e5 c6 76 ff 90 0f 0b 90 e9 72 ff ff ff
[   56.685231][ T5488] RSP: 0018:ffffc9000389fa28 EFLAGS: 00010293
[   56.691305][ T5488] RAX: ffffffff824b0e3d RBX: ffffffff9a180fd8 RCX: fff=
f888027d00000
[   56.699276][ T5488] RDX: 0000000000000000 RSI: 00000000effffff8 RDI: 000=
00000effffff8
[   56.707248][ T5488] RBP: 00000000effffff8 R08: ffffffff9a181093 R09: 1ff=
ffffff3430212
[   56.715395][ T5488] R10: dffffc0000000000 R11: fffffbfff3430213 R12: dff=
ffc0000000000
[   56.723457][ T5488] R13: 1ffffffff34301fe R14: ffff888077f26d50 R15: fff=
fffff9a180ff0
[   56.731441][ T5488]  ? nsfs_evict+0x18d/0x200
[   56.735961][ T5488]  ? nsfs_evict+0x18d/0x200
[   56.740466][ T5488]  ? __pfx_nsfs_evict+0x10/0x10
[   56.745344][ T5488]  evict+0x5f4/0xae0
[   56.749272][ T5488]  ? __pfx_evict+0x10/0x10
[   56.753700][ T5488]  ? _raw_spin_unlock+0x28/0x50
[   56.758559][ T5488]  ? iput+0xce7/0x1050
[   56.762727][ T5488]  __dentry_kill+0x209/0x660
[   56.767321][ T5488]  ? dput+0x37/0x2b0
[   56.771225][ T5488]  dput+0x19f/0x2b0
[   56.775046][ T5488]  path_put+0x39/0x60
[   56.779037][ T5488]  vfs_statx+0x36e/0x550
[   56.783307][ T5488]  ? __pfx_vfs_statx+0x10/0x10
[   56.788107][ T5488]  ? strncpy_from_user+0x150/0x2c0
[   56.793251][ T5488]  ? getname_flags+0x1e5/0x540
[   56.798034][ T5488]  vfs_fstatat+0x118/0x170
[   56.802466][ T5488]  __x64_sys_newfstatat+0x116/0x190
[   56.807674][ T5488]  ? __pfx___x64_sys_newfstatat+0x10/0x10
[   56.813445][ T5488]  ? do_syscall_64+0xbe/0xfa0
[   56.818158][ T5488]  do_syscall_64+0xfa/0xfa0
[   56.822684][ T5488]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.828855][ T5488]  ? clear_bhb_loop+0x60/0xb0
[   56.833544][ T5488]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   56.839529][ T5488] RIP: 0033:0x7ff1e113db0a
[   56.844039][ T5488] Code: 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8 ff ff f=
f ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 89 ca b8 06 01 00 00 0=
f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 b9 f2 0d 00 f7
[   56.863750][ T5488] RSP: 002b:00007ffe530d70b8 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000106
[   56.872366][ T5488] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000=
07ff1e113db0a
[   56.880429][ T5488] RDX: 00007ffe530d70c0 RSI: 0000560445610557 RDI: 000=
00000ffffff9c
[   56.888417][ T5488] RBP: 00007ffe530d9858 R08: 0000000000000000 R09: 000=
0000000000000
[   56.896404][ T5488] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07ffe530d8230
[   56.904382][ T5488] R13: 000056044e3fd8a0 R14: 0000000000001000 R15: 000=
07ff1e10496c8
[   56.912381][ T5488]  </TASK>
[   56.915663][ T5488] Kernel Offset: disabled
[   56.920100][ T5488] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build3988901650=3D/tmp/go-build -gno-record-gc=
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
HEAD detached at a6c9c731229
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Da6c9c7312290da5bca2fc1be4872a7aeefb6e3ea -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251104-181356"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Da6c9c7312290da5bca2fc1be4872a7aeefb6e3ea -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251104-181356"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Da6c9c7312290da5bca2fc1be4872a7aeefb6e3ea -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251104-181356"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"a6c9c7312290da5bca2fc1be4872a7aeef=
b6e3ea\"
/usr/bin/ld: /tmp/ccZrqXJp.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D14843812580000


Tested on:

commit:         9c0826a5 Add linux-next specific files for 20251107
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4f8fcc6438a785e=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0b2e79f91ff6579bf=
a5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D167110b45800=
00


