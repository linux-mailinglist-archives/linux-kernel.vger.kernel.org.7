Return-Path: <linux-kernel+bounces-890423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFB7C40067
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9EF3B4A68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D629BDA5;
	Fri,  7 Nov 2025 13:06:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B18283FFC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520765; cv=none; b=oQedT2oqFbi5NHBvvhf93mPFkXzGzQZ6XRQNnzfzMd0GehaSqcVywFVja9kLS4+PtFCMDdyyQyLCCgiojNJ9FwOBOA3Byp/kJK14lA16xvAAjM/ygBgUGayc8ojJtoAkFVlDlGTcIXslE8nm/IL4U4cSpQ8YGhE8dHfaUOYRIWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520765; c=relaxed/simple;
	bh=eFntj20X7b1NVvzMR9Pj8YElABNWZ42qlT0dpI26zPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MCgioNXM8QTWOddOHHQxc+mZB4rwJib0itwAJTjb0rU+KxI23CqCw7Em889PiT2/LG0k/AUaEFxPxUGMA7M7Xn12/Aj3GiBPQk+DYX1iFCB0jUfVmLIYYIoU76pyHyTNA1fYA3NiuWYDPOoFwiZW4M2CMnVCiozxoceDgy+oxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-948756fb9cfso193834439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520763; x=1763125563;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhmp5lIZ3yJ1J+S8TP5hfXmITXkwngEkfrR0Vzn4vp4=;
        b=uMM/oVDs5ez+Du3dFS/HKYPKX2JRdhRKJsI/U5FWdOPtfTeoMWCQvcLLIurAHvvW5z
         DZ89ldtR171m2TRqf301xmqST2DVqXl2IamS7na518mCmLhVXjZvKB9QMYYfnwo4tE5M
         31jmQzSNcFtM4/ZE6OLQbzvSulaCjh0XMEB569nlHbQ6AiP20/cbZNhmqILDyM4dveJf
         WSf4Eno/xvt/CAb5TuXoGYGYaQx2/fKQlQXTXS9BhxBz1vOY/C9w/4HbEJ1XvZOx2nl0
         ow4NRCvRxeh++OpR6Uo18nHh7IgXcqCP1FqLM6GEnIFS9KY/BJm7Kb0HuN9J5NRnpGWM
         5z5A==
X-Forwarded-Encrypted: i=1; AJvYcCUoA6hJ0cjVEbZOIWdwBDTRo9zn7ibHngXjCfPaOmcR9Xz0kpEy7l9SMIIivkL4kQlb/3qrrbe/P+QkDsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uuVUnQgaPFk7dsuGNQr1fkxHTyvzFe4EPYoPQPqlMq4nsxDt
	/4Ur0jnPxFnCRpPqJXrnrJu+r5rBTngKnWGFrq3kx1Oy3Nca5URr61Mwg6Dicoc1VxNcFok2W0Z
	gaHfljsn5TK9M3pYLRmIUS9csv7a5bLzqo37nHocijos4xwHfqG3k/k6g6AI=
X-Google-Smtp-Source: AGHT+IG5cZybp3EcWdbDCrxRkugAN+sx8UTghkuMuaOJQJygo+oeexaXIkXPvXj3Vu4gj4R321NskCereN6tZvMTsUJ5cQijjZQi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c245:0:b0:431:da08:d652 with SMTP id
 e9e14a558f8ab-4335f2c4818mr46254165ab.0.1762520762310; Fri, 07 Nov 2025
 05:06:02 -0800 (PST)
Date: Fri, 07 Nov 2025 05:06:01 -0800
In-Reply-To: <20251107114102.22298-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690deeb9.a70a0220.22f260.004b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_put
From: syzbot <syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

970707b2'
[   21.974518][    T1] zswap: loaded using pool 842
[   21.982912][    T1] Demotion targets for Node 0: null
[   21.988200][    T1] Demotion targets for Node 1: null
[   21.993522][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]: Valid=
ating architecture page table helpers
[   24.797559][    T1] Key type .fscrypt registered
[   24.802517][    T1] Key type fscrypt-provisioning registered
[   24.811687][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   24.837336][    T1] Btrfs loaded, assert=3Don, zoned=3Dyes, fsverity=3Dy=
es
[   24.844500][    T1] Key type big_key registered
[   24.849260][    T1] Key type encrypted registered
[   24.854106][    T1] AppArmor: AppArmor sha256 policy hashing enabled
[   24.860731][    T1] ima: No TPM chip found, activating TPM-bypass!
[   24.867175][    T1] Loading compiled-in module X.509 certificates
[   24.894366][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: de56e482b03ecd8d239a6590830ee0f7970707b2'
[   24.905348][    T1] ima: Allocated hash algorithm: sha256
[   24.911357][    T1] ima: No architecture policies found
[   24.917173][    T1] evm: Initialising EVM extended attributes:
[   24.923151][    T1] evm: security.selinux (disabled)
[   24.928238][    T1] evm: security.SMACK64 (disabled)
[   24.933355][    T1] evm: security.SMACK64EXEC (disabled)
[   24.938815][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   24.944683][    T1] evm: security.SMACK64MMAP (disabled)
[   24.950134][    T1] evm: security.apparmor
[   24.954370][    T1] evm: security.ima
[   24.958145][    T1] evm: security.capability
[   24.962553][    T1] evm: HMAC attrs: 0x1
[   24.968988][    T1] PM:   Magic number: 1:272:986
[   24.973842][    T1] net rose20: hash matches
[   24.978361][    T1] dsp_pipeline hwec: hash matches
[   24.984302][    T1] netconsole: network logging started
[   24.990369][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   25.002183][    T1] rdma_rxe: loaded
[   25.007915][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   25.019009][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   25.026972][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   25.038011][    T1] clk: Disabling unused clocks
[   25.043143][    T1] ALSA device list:
[   25.044532][  T793] faux_driver regulatory: Direct firmware load for reg=
ulatory.db failed with error -2
[   25.046952][    T1]   #0: Dummy 1
[   25.046964][    T1]   #1: Loopback 1
[   25.056659][  T793] faux_driver regulatory: Falling back to sysfs fallba=
ck for: regulatory.db
[   25.072704][    T1]   #2: Virtual MIDI Card 1
[   25.080464][    T1] check access for rdinit=3D/init failed: -2, ignoring
[   25.087134][    T1] md: Waiting for all devices to be available before a=
utodetect
[   25.094786][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   25.101311][    T1] md: Autodetecting RAID arrays.
[   25.106328][    T1] md: autorun ...
[   25.109974][    T1] md: ... autorun DONE.
[   25.202934][    T1] EXT4-fs (sda1): orphan cleanup on readonly fs
[   25.211522][    T1] EXT4-fs (sda1): mounted filesystem 4f91c6db-4997-4bb=
4-91b8-7e83a20c1bf1 ro with ordered data mode. Quota mode: none.
[   25.224301][    T1] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce 8:1.
[   25.234167][    T1] devtmpfs: mounted
[   25.311718][    T1] Freeing unused kernel image (initmem) memory: 26112K
[   25.322460][    T1] Write protecting the kernel read-only data: 212992k
[   25.341592][    T1] Freeing unused kernel image (text/rodata gap) memory=
: 1436K
[   25.353977][    T1] Freeing unused kernel image (rodata/data gap) memory=
: 1240K
[   25.458459][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   25.466412][    T1] x86/mm: Checking user space page tables
[   25.555644][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages f=
ound.
[   25.568271][    T1] Failed to set sysctl parameter 'max_rcu_stall_to_pan=
ic=3D1': parameter not found
[   25.578126][    T1] Run /sbin/init as init process
[   25.833630][ T5157] mount (5157) used greatest stack depth: 23816 bytes =
left
[   25.885026][ T5158] EXT4-fs (sda1): re-mounted 4f91c6db-4997-4bb4-91b8-7=
e83a20c1bf1 r/w.
[   25.897827][ T5158] mount (5158) used greatest stack depth: 23624 bytes =
left
mount: mounting devtmpfs on /dev failed: Device or resource busy
mount: mounting smackfs on /sys/fs/smackfs failed: No such file or director=
y
mount: mounting selinuxfs on /sys/fs/selinux failed: No such file or direct=
ory
[   26.026823][ T5162] mount (5162) used greatest stack depth: 21672 bytes =
left
Starting syslogd: OK
Starting acpid: [   26.448559][ T5177] acpid (5177) used greatest stack dep=
th: 20968 bytes left
OK
Starting klogd: OK
Running sysctl: OK
Populating /dev using udev: [   27.039741][ T5192] udevd[5192]: starting ve=
rsion 3.2.14
[   27.206253][ T5193] udevd[5193]: starting eudev-3.2.14
[   27.210256][ T5192] udevd (5192) used greatest stack depth: 18088 bytes =
left
done
Starting system message bus: done
Starting iptables: OK
Starting network: OK
Starting dhcpcd...
dhcpcd-10.2.0 starting
[   46.776298][ T5487] ------------[ cut here ]------------
[   46.781953][ T5487] WARNING: ./include/linux/ns_common.h:314 at nsfs_evi=
ct+0x18e/0x200, CPU#1: dhcpcd/5487
[   46.792403][ T5487] Modules linked in:
[   46.796337][ T5487] CPU: 1 UID: 0 PID: 5487 Comm: dhcpcd Not tainted syz=
kaller #0 PREEMPT(full)=20
[   46.805316][ T5487] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   46.815409][ T5487] RIP: 0010:nsfs_evict+0x18e/0x200
[   46.820563][ T5487] Code: 4d 8b 1e 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5=
d 41 ff e3 cc cc cc e8 01 c7 76 ff 90 0f 0b 90 e9 1f ff ff ff e8 f3 c6 76 f=
f 90 <0f> 0b 90 e9 42 ff ff ff e8 e5 c6 76 ff 90 0f 0b 90 e9 72 ff ff ff
[   46.840207][ T5487] RSP: 0018:ffffc900039afa28 EFLAGS: 00010293
[   46.846262][ T5487] RAX: ffffffff824b0e3d RBX: ffffffff9a180fd8 RCX: fff=
f88802e6d1e80
[   46.854272][ T5487] RDX: 0000000000000000 RSI: 00000000effffff8 RDI: 000=
00000effffff8
[   46.862272][ T5487] RBP: 00000000effffff8 R08: ffffffff9a181093 R09: 1ff=
ffffff3430212
[   46.870298][ T5487] R10: dffffc0000000000 R11: fffffbfff3430213 R12: dff=
ffc0000000000
[   46.878265][ T5487] R13: 1ffffffff34301fe R14: ffff88807a7cf248 R15: fff=
fffff9a180ff0
[   46.886301][ T5487] FS:  00007f5b3bc92740(0000) GS:ffff888125b78000(0000=
) knlGS:0000000000000000
[   46.895267][ T5487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.901937][ T5487] CR2: 0000563ddc89c4a0 CR3: 000000006f210000 CR4: 000=
00000003526f0
[   46.909942][ T5487] Call Trace:
[   46.913233][ T5487]  <TASK>
[   46.916163][ T5487]  ? __pfx_nsfs_evict+0x10/0x10
[   46.921065][ T5487]  evict+0x5f4/0xae0
[   46.925002][ T5487]  ? __pfx_evict+0x10/0x10
[   46.929539][ T5487]  ? _raw_spin_unlock+0x28/0x50
[   46.934391][ T5487]  ? iput+0xce7/0x1050
[   46.938444][ T5487]  __dentry_kill+0x209/0x660
[   46.943076][ T5487]  ? dput+0x37/0x2b0
[   46.946973][ T5487]  dput+0x19f/0x2b0
[   46.950799][ T5487]  path_put+0x39/0x60
[   46.954833][ T5487]  vfs_statx+0x36e/0x550
[   46.959106][ T5487]  ? __pfx_vfs_statx+0x10/0x10
[   46.963873][ T5487]  ? strncpy_from_user+0x150/0x2c0
[   46.969019][ T5487]  ? getname_flags+0x1e5/0x540
[   46.973824][ T5487]  vfs_fstatat+0x118/0x170
[   46.978223][ T5487]  __x64_sys_newfstatat+0x116/0x190
[   46.983447][ T5487]  ? __pfx___x64_sys_newfstatat+0x10/0x10
[   46.989202][ T5487]  ? do_syscall_64+0xbe/0xfa0
[   46.993883][ T5487]  do_syscall_64+0xfa/0xfa0
[   46.998365][ T5487]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   47.004477][ T5487]  ? clear_bhb_loop+0x60/0xb0
[   47.009189][ T5487]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   47.015094][ T5487] RIP: 0033:0x7f5b3bd86b0a
[   47.019580][ T5487] Code: 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8 ff ff f=
f ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 89 ca b8 06 01 00 00 0=
f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 b9 f2 0d 00 f7
[   47.039327][ T5487] RSP: 002b:00007ffc209e1718 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000106
[   47.047744][ T5487] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000=
07f5b3bd86b0a
[   47.055741][ T5487] RDX: 00007ffc209e1720 RSI: 0000563ddc8c4557 RDI: 000=
00000ffffff9c
[   47.063747][ T5487] RBP: 00007ffc209e3eb8 R08: 0000000000000000 R09: 000=
0000000000000
[   47.071763][ T5487] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07ffc209e2890
[   47.079775][ T5487] R13: 0000563e1752d8a0 R14: 0000000000001000 R15: 000=
07f5b3bc926c8
[   47.087762][ T5487]  </TASK>
[   47.090819][ T5487] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   47.098094][ T5487] CPU: 1 UID: 0 PID: 5487 Comm: dhcpcd Not tainted syz=
kaller #0 PREEMPT(full)=20
[   47.107008][ T5487] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   47.117042][ T5487] Call Trace:
[   47.120305][ T5487]  <TASK>
[   47.123217][ T5487]  dump_stack_lvl+0x99/0x250
[   47.127804][ T5487]  ? __asan_memcpy+0x40/0x70
[   47.132372][ T5487]  ? __pfx_dump_stack_lvl+0x10/0x10
[   47.137549][ T5487]  ? __pfx__printk+0x10/0x10
[   47.142123][ T5487]  vpanic+0x237/0x6d0
[   47.146171][ T5487]  ? __pfx_vpanic+0x10/0x10
[   47.150648][ T5487]  ? is_bpf_text_address+0x292/0x2b0
[   47.155913][ T5487]  ? is_bpf_text_address+0x26/0x2b0
[   47.161096][ T5487]  panic+0xb9/0xc0
[   47.164798][ T5487]  ? __pfx_panic+0x10/0x10
[   47.169202][ T5487]  __warn+0x334/0x4c0
[   47.173160][ T5487]  ? nsfs_evict+0x18e/0x200
[   47.177641][ T5487]  ? nsfs_evict+0x18e/0x200
[   47.182126][ T5487]  report_bug+0x2be/0x4f0
[   47.186436][ T5487]  ? nsfs_evict+0x18e/0x200
[   47.190915][ T5487]  ? nsfs_evict+0x18e/0x200
[   47.195395][ T5487]  ? nsfs_evict+0x190/0x200
[   47.199876][ T5487]  handle_bug+0x84/0x160
[   47.204114][ T5487]  exc_invalid_op+0x1a/0x50
[   47.208629][ T5487]  asm_exc_invalid_op+0x1a/0x20
[   47.213486][ T5487] RIP: 0010:nsfs_evict+0x18e/0x200
[   47.218605][ T5487] Code: 4d 8b 1e 48 89 df 5b 41 5c 41 5d 41 5e 41 5f 5=
d 41 ff e3 cc cc cc e8 01 c7 76 ff 90 0f 0b 90 e9 1f ff ff ff e8 f3 c6 76 f=
f 90 <0f> 0b 90 e9 42 ff ff ff e8 e5 c6 76 ff 90 0f 0b 90 e9 72 ff ff ff
[   47.238215][ T5487] RSP: 0018:ffffc900039afa28 EFLAGS: 00010293
[   47.244897][ T5487] RAX: ffffffff824b0e3d RBX: ffffffff9a180fd8 RCX: fff=
f88802e6d1e80
[   47.252860][ T5487] RDX: 0000000000000000 RSI: 00000000effffff8 RDI: 000=
00000effffff8
[   47.260822][ T5487] RBP: 00000000effffff8 R08: ffffffff9a181093 R09: 1ff=
ffffff3430212
[   47.268783][ T5487] R10: dffffc0000000000 R11: fffffbfff3430213 R12: dff=
ffc0000000000
[   47.276756][ T5487] R13: 1ffffffff34301fe R14: ffff88807a7cf248 R15: fff=
fffff9a180ff0
[   47.284739][ T5487]  ? nsfs_evict+0x18d/0x200
[   47.289248][ T5487]  ? nsfs_evict+0x18d/0x200
[   47.293742][ T5487]  ? __pfx_nsfs_evict+0x10/0x10
[   47.298581][ T5487]  evict+0x5f4/0xae0
[   47.302483][ T5487]  ? __pfx_evict+0x10/0x10
[   47.306894][ T5487]  ? _raw_spin_unlock+0x28/0x50
[   47.311737][ T5487]  ? iput+0xce7/0x1050
[   47.315801][ T5487]  __dentry_kill+0x209/0x660
[   47.320380][ T5487]  ? dput+0x37/0x2b0
[   47.324265][ T5487]  dput+0x19f/0x2b0
[   47.328059][ T5487]  path_put+0x39/0x60
[   47.332030][ T5487]  vfs_statx+0x36e/0x550
[   47.336284][ T5487]  ? __pfx_vfs_statx+0x10/0x10
[   47.341048][ T5487]  ? strncpy_from_user+0x150/0x2c0
[   47.346174][ T5487]  ? getname_flags+0x1e5/0x540
[   47.350940][ T5487]  vfs_fstatat+0x118/0x170
[   47.355369][ T5487]  __x64_sys_newfstatat+0x116/0x190
[   47.360640][ T5487]  ? __pfx___x64_sys_newfstatat+0x10/0x10
[   47.366383][ T5487]  ? do_syscall_64+0xbe/0xfa0
[   47.371078][ T5487]  do_syscall_64+0xfa/0xfa0
[   47.375592][ T5487]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   47.381648][ T5487]  ? clear_bhb_loop+0x60/0xb0
[   47.386425][ T5487]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   47.392748][ T5487] RIP: 0033:0x7f5b3bd86b0a
[   47.397245][ T5487] Code: 48 8b 15 f1 f2 0d 00 f7 d8 64 89 02 b8 ff ff f=
f ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 41 89 ca b8 06 01 00 00 0=
f 05 <3d> 00 f0 ff ff 77 07 31 c0 c3 0f 1f 40 00 48 8b 15 b9 f2 0d 00 f7
[   47.416866][ T5487] RSP: 002b:00007ffc209e1718 EFLAGS: 00000246 ORIG_RAX=
: 0000000000000106
[   47.425277][ T5487] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000=
07f5b3bd86b0a
[   47.433236][ T5487] RDX: 00007ffc209e1720 RSI: 0000563ddc8c4557 RDI: 000=
00000ffffff9c
[   47.441215][ T5487] RBP: 00007ffc209e3eb8 R08: 0000000000000000 R09: 000=
0000000000000
[   47.449171][ T5487] R10: 0000000000000000 R11: 0000000000000246 R12: 000=
07ffc209e2890
[   47.457124][ T5487] R13: 0000563e1752d8a0 R14: 0000000000001000 R15: 000=
07f5b3bc926c8
[   47.465097][ T5487]  </TASK>
[   47.468346][ T5487] Kernel Offset: disabled
[   47.472660][ T5487] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1222549954=3D/tmp/go-build -gno-record-gc=
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
/usr/bin/ld: /tmp/ccl2NrsB.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D17b05084580000


Tested on:

commit:         9c0826a5 Add linux-next specific files for 20251107
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4f8fcc6438a785e=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0b2e79f91ff6579bf=
a5b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D11e038125800=
00


