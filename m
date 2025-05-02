Return-Path: <linux-kernel+bounces-629151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D29CAA6847
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 03:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D1B7B2D7D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 01:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36714F117;
	Fri,  2 May 2025 01:15:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D11494A9
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 01:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148505; cv=none; b=uiTQTnLtYZzUkVYmoEc2pkQ04FpmWVrRdkdDrh+87hGoVQztipssLxU59M40PXRS8wp8GaEIZBno4jzf5kmkMd+AHiEIa1tssUZ+0/GT2dvLQDz2sAzLqwNmyf0TeE9txPNQnpYl0U45K+onhgApSK30Kg6OdWdG2MM2Z/DYKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148505; c=relaxed/simple;
	bh=Dw50wM+A97gwq4+TxkMwV1ecsaILAVVzYlQkkr0CgHg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UczEkvp+zFWvmgHlCCcNRsQ4jIuBZO1Ryky99COnbFt3hkC9Oz+tMvBN74WiVqmCuy1o+go8fGXpiiyqRKVLc5KmyhEBwN27/K7ldq4NacR180n1QqHWIyMVLnv7SbiaFo1dD+tzqEmTAZmnhDiS9qLTAsRhA1dLVD2NCbfvHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85dad58e80fso405620939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 May 2025 18:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746148502; x=1746753302;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMVt45Ol5YCPHJk5dA5w0DvKYlW9xQmcrAZOc0H8P78=;
        b=pczp1Vrlq54g4IVLDTywn+oR5632q/dn74+rDVA40YdlGlr5eSN/aJeDHRcPVYhAIo
         0hSZSBwmfvnP+Wu5hQIwJZcFemsHDkSzb46m4KwEPZWcXn1xQXt4uJqrOW2i5wJaCX89
         8faxVwkDLVSUZOI3goyjGTjnkaWbznYve0vEpA4z3qghhOI5/3+zMCFkHZ+qN+3vEYua
         nkTtNqUqrGLFB5CzZUwfqdlR7KaJcEWHixbfEaIfAQR4VT2u9PmTj/dnDduhJcyNQA8N
         PBQjPALpL0JSloUDuMDGHHBA27/hI3bLWxsgPr1U09vZLLJRJ2lbTDAB4arVfatiaH8C
         l+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgAuBKYyFKDcUS8vpKriIXJLtYDOn3V5k7QzE+tnzZOQDI7HPDFt5g68R+mjBKGIcfzviuY7MeZQPJT9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRKbIoJ2s1vGLx32Ysn9mPlFqLi44puKvKsRB8Q4a7R+xwy48N
	ckGXk2BxHz66yryeAEGltQ6UjtDooax6r8fJiwGw0r5qccn9Y7WVWayyNPBM+19fXJypJiqPaAL
	UCk61Ki47N/bWX5UH6ouGckZlSlLfClK+1u7FeUgNpnAHTZKG0abwhVM=
X-Google-Smtp-Source: AGHT+IGBNl7USOBFSoa86LS1JHhQDHWc/uQ5ERTZh1KJGKMuzrGCZKzFCIxS019nOKNkMDt1qqZxprOzA7kqKrvCQVmoGP2fI25L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:380e:b0:861:628f:2d2b with SMTP id
 ca18e2360f4ac-8669f993535mr202508539f.1.1746148501977; Thu, 01 May 2025
 18:15:01 -0700 (PDT)
Date: Thu, 01 May 2025 18:15:01 -0700
In-Reply-To: <20250502005259.4359-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68141c95.050a0220.14dd7d.001c.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page state in page_cache_ra_order
From: syzbot <syzbot+7b3842775c9ce6b69efc@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

_pgtable         ]: Validating architecture page table helpers
[   18.960143][    T1] Key type .fscrypt registered
[   18.963394][    T1] Key type fscrypt-provisioning registered
[   18.997093][    T1] kAFS: Red Hat AFS client v0.1 registering.
[   19.015868][    T1] Btrfs loaded, assert=3Don, ref-verify=3Don, zoned=3D=
yes, fsverity=3Dyes
[   19.020415][    T1] Key type big_key registered
[   19.028071][    T1] Key type encrypted registered
[   19.031538][    T1] ima: No TPM chip found, activating TPM-bypass!
[   19.034968][    T1] Loading compiled-in module X.509 certificates
[   19.064977][    T1] Loaded X.509 cert 'Build time autogenerated kernel k=
ey: 5ffa98226aab18898f938e23c71e38ddbdc3d6be'
[   19.071363][    T1] ima: Allocated hash algorithm: sha256
[   19.074921][    T1] ima: No architecture policies found
[   19.078073][    T1] evm: Initialising EVM extended attributes:
[   19.081136][    T1] evm: security.selinux
[   19.083318][    T1] evm: security.SMACK64 (disabled)
[   19.085959][    T1] evm: security.SMACK64EXEC (disabled)
[   19.088774][    T1] evm: security.SMACK64TRANSMUTE (disabled)
[   19.091720][    T1] evm: security.SMACK64MMAP (disabled)
[   19.094549][    T1] evm: security.apparmor (disabled)
[   19.097192][    T1] evm: security.ima
[   19.099109][    T1] evm: security.capability
[   19.101316][    T1] evm: HMAC attrs: 0x1
[   19.105400][    T1] PM:   Magic number: 9:757:52
[   19.108017][    T1] gadget gadget.3: hash matches
[   19.111074][    T1] printk: legacy console [netcon0] enabled
[   19.114174][    T1] netconsole: network logging started
[   19.117496][    T1] gtp: GTP module loaded (pdp ctx size 128 bytes)
[   19.123577][    T1] rdma_rxe: loaded
[   19.126289][    T1] cfg80211: Loading compiled-in X.509 certificates for=
 regulatory database
[   19.132568][    T1] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   19.137040][    T1] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06=
c7248db18c600'
[   19.141979][   T64] platform regulatory.0: Direct firmware load for regu=
latory.db failed with error -2
[   19.144278][    T1] clk: Disabling unused clocks
[   19.147093][   T64] platform regulatory.0: Falling back to sysfs fallbac=
k for: regulatory.db
[   19.149365][    T1] ALSA device list:
[   19.156335][    T1]   #0: Dummy 1
[   19.158671][    T1]   #1: Loopback 1
[   19.161218][    T1]   #2: Virtual MIDI Card 1
[   19.168255][    T1] md: Waiting for all devices to be available before a=
utodetect
[   19.171325][    T1] md: If you don't use raid, use raid=3Dnoautodetect
[   19.173752][    T1] md: Autodetecting RAID arrays.
[   19.175815][    T1] md: autorun ...
[   19.177419][    T1] md: ... autorun DONE.
[   19.184183][    T1]=20
[   19.184924][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
[   19.186790][    T1] WARNING: possible recursive locking detected
[   19.188720][    T1] 6.15.0-rc4-syzkaller-gebd297a2affa-dirty #0 Not tain=
ted
[   19.190708][    T1] --------------------------------------------
[   19.192499][    T1] swapper/0/1 is trying to acquire lock:
[   19.194144][    T1] ffff88801fa8f0c0 (mapping.invalidate_lock){+.+.}-{4:=
4}, at: set_blocksize+0x2c7/0x540
[   19.196953][    T1]=20
[   19.196953][    T1] but task is already holding lock:
[   19.199108][    T1] ffff88801fa8f0c0 (mapping.invalidate_lock){+.+.}-{4:=
4}, at: set_blocksize+0x20f/0x540
[   19.201846][    T1]=20
[   19.201846][    T1] other info that might help us debug this:
[   19.204121][    T1]  Possible unsafe locking scenario:
[   19.204121][    T1]=20
[   19.206228][    T1]        CPU0
[   19.207168][    T1]        ----
[   19.208188][    T1]   lock(mapping.invalidate_lock);
[   19.209671][    T1]   lock(mapping.invalidate_lock);
[   19.211139][    T1]=20
[   19.211139][    T1]  *** DEADLOCK ***
[   19.211139][    T1]=20
[   19.213468][    T1]  May be due to missing lock nesting notation
[   19.213468][    T1]=20
[   19.215860][    T1] 3 locks held by swapper/0/1:
[   19.217308][    T1]  #0: ffff88802b51a0e0 (&type->s_umount_key#24/1){+.+=
.}-{4:4}, at: alloc_super+0x235/0xbd0
[   19.220365][    T1]  #1: ffff88801fa8ef20 (&sb->s_type->i_mutex_key#7){+=
.+.}-{4:4}, at: set_blocksize+0x1e0/0x540
[   19.223505][    T1]  #2: ffff88801fa8f0c0 (mapping.invalidate_lock){+.+.=
}-{4:4}, at: set_blocksize+0x20f/0x540
[   19.226605][    T1]=20
[   19.226605][    T1] stack backtrace:
[   19.228455][    T1] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.1=
5.0-rc4-syzkaller-gebd297a2affa-dirty #0 PREEMPT(full)=20
[   19.228469][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[   19.228475][    T1] Call Trace:
[   19.228480][    T1]  <TASK>
[   19.228484][    T1]  dump_stack_lvl+0x116/0x1f0
[   19.228527][    T1]  print_deadlock_bug+0x1e9/0x240
[   19.228542][    T1]  __lock_acquire+0xff7/0x1ba0
[   19.228559][    T1]  lock_acquire+0x179/0x350
[   19.228573][    T1]  ? set_blocksize+0x2c7/0x540
[   19.228584][    T1]  ? __pfx___might_resched+0x10/0x10
[   19.228597][    T1]  ? smp_call_function_many_cond+0x524/0x1290
[   19.228610][    T1]  down_write+0x92/0x200
[   19.228622][    T1]  ? set_blocksize+0x2c7/0x540
[   19.228632][    T1]  ? __pfx_down_write+0x10/0x10
[   19.228645][    T1]  ? __pfx_invalidate_bh_lru+0x10/0x10
[   19.228661][    T1]  ? __pfx_has_bh_in_lru+0x10/0x10
[   19.228675][    T1]  ? on_each_cpu_cond_mask+0x5a/0x90
[   19.228686][    T1]  set_blocksize+0x2c7/0x540
[   19.228697][    T1]  sb_set_blocksize+0xca/0x1d0
[   19.228708][    T1]  ext4_fill_super+0x8b4/0xb020
[   19.228722][    T1]  ? snprintf+0xc7/0x100
[   19.228732][    T1]  ? __pfx_snprintf+0x10/0x10
[   19.228742][    T1]  ? __pfx_ext4_fill_super+0x10/0x10
[   19.228751][    T1]  ? do_raw_spin_lock+0x12c/0x2b0
[   19.228761][    T1]  ? find_held_lock+0x2b/0x80
[   19.228772][    T1]  ? set_blocksize+0x43f/0x540
[   19.228783][    T1]  ? sb_set_blocksize+0x176/0x1d0
[   19.228793][    T1]  ? setup_bdev_super+0x369/0x730
[   19.228807][    T1]  get_tree_bdev_flags+0x389/0x620
[   19.228821][    T1]  ? __pfx_ext4_fill_super+0x10/0x10
[   19.228831][    T1]  ? __pfx_get_tree_bdev_flags+0x10/0x10
[   19.228847][    T1]  ? bpf_lsm_capable+0x9/0x10
[   19.228856][    T1]  ? security_capable+0x7e/0x260
[   19.228867][    T1]  vfs_get_tree+0x8b/0x340
[   19.228879][    T1]  path_mount+0x14d4/0x1f20
[   19.228890][    T1]  ? kmem_cache_free+0x2d4/0x4d0
[   19.228905][    T1]  ? __pfx_path_mount+0x10/0x10
[   19.228916][    T1]  ? putname+0x154/0x1a0
[   19.228926][    T1]  init_mount+0xbe/0x110
[   19.228958][    T1]  ? __pfx_init_mount+0x10/0x10
[   19.228969][    T1]  ? list_bdev_fs_names+0x10d/0x170
[   19.228982][    T1]  do_mount_root+0x22a/0x540
[   19.228994][    T1]  mount_root_generic+0x199/0x690
[   19.229007][    T1]  ? __pfx_mount_root_generic+0x10/0x10
[   19.229019][    T1]  ? __asan_memcpy+0x3c/0x60
[   19.229033][    T1]  ? getname_kernel+0x21b/0x370
[   19.229044][    T1]  mount_root+0x243/0x480
[   19.229054][    T1]  ? kmem_cache_alloc_noprof+0x21e/0x3b0
[   19.229071][    T1]  ? __pfx_mount_root+0x10/0x10
[   19.229082][    T1]  ? __asan_memcpy+0x3c/0x60
[   19.229095][    T1]  ? getname_kernel+0x21b/0x370
[   19.229106][    T1]  prepare_namespace+0xe2/0x3f0
[   19.229121][    T1]  ? __pfx_prepare_namespace+0x10/0x10
[   19.229133][    T1]  ? fput+0x70/0xf0
[   19.229143][    T1]  kernel_init_freeable+0x705/0x900
[   19.229154][    T1]  ? __pfx_kernel_init+0x10/0x10
[   19.229168][    T1]  kernel_init+0x1c/0x2b0
[   19.229181][    T1]  ? __pfx_kernel_init+0x10/0x10
[   19.229194][    T1]  ret_from_fork+0x45/0x80
[   19.229204][    T1]  ? __pfx_kernel_init+0x10/0x10
[   19.229218][    T1]  ret_from_fork_asm+0x1a/0x30
[   19.229235][    T1]  </TASK>
[   81.482424][   T64] cfg80211: failed to load regulatory.db
[  286.281965][   T41] INFO: task swapper/0:1 blocked for more than 143 sec=
onds.
[  286.284156][   T41]       Not tainted 6.15.0-rc4-syzkaller-gebd297a2affa=
-dirty #0
[  286.286388][   T41] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" d=
isables this message.
[  286.288911][   T41] task:swapper/0       state:D stack:22520 pid:1     t=
gid:1     ppid:0      task_flags:0x0140 flags:0x00004002
[  286.292445][   T41] Call Trace:
[  286.293501][   T41]  <TASK>
[  286.294421][   T41]  __schedule+0x116f/0x5de0
[  286.295775][   T41]  ? lock_release+0x201/0x2f0
[  286.297172][   T41]  ? rcu_is_watching+0x12/0xc0
[  286.298603][   T41]  ? trace_sched_exit_tp+0xde/0x130
[  286.300147][   T41]  ? __pfx___schedule+0x10/0x10
[  286.301615][   T41]  ? schedule+0x2d7/0x3a0
[  286.302953][   T41]  ? rcu_is_watching+0x12/0xc0
[  286.304387][   T41]  ? lock_release+0x201/0x2f0
[  286.305836][   T41]  schedule+0xe7/0x3a0
[  286.307106][   T41]  schedule_preempt_disabled+0x13/0x30
[  286.308826][   T41]  rwsem_down_write_slowpath+0x524/0x1310
[  286.310541][   T41]  ? __pfx_rwsem_down_write_slowpath+0x10/0x10
[  286.312447][   T41]  ? __pfx___might_resched+0x10/0x10
[  286.314090][   T41]  ? smp_call_function_many_cond+0x524/0x1290
[  286.315957][   T41]  down_write+0x1d6/0x200
[  286.317252][   T41]  ? __pfx_down_write+0x10/0x10
[  286.318812][   T41]  ? __pfx_invalidate_bh_lru+0x10/0x10
[  286.320534][   T41]  ? __pfx_has_bh_in_lru+0x10/0x10
[  286.322210][   T41]  ? on_each_cpu_cond_mask+0x5a/0x90
[  286.323906][   T41]  set_blocksize+0x2c7/0x540
[  286.325357][   T41]  sb_set_blocksize+0xca/0x1d0
[  286.326869][   T41]  ext4_fill_super+0x8b4/0xb020
[  286.328395][   T41]  ? snprintf+0xc7/0x100
[  286.329760][   T41]  ? __pfx_snprintf+0x10/0x10
[  286.331242][   T41]  ? __pfx_ext4_fill_super+0x10/0x10
[  286.332970][   T41]  ? do_raw_spin_lock+0x12c/0x2b0
[  286.334602][   T41]  ? find_held_lock+0x2b/0x80
[  286.336083][   T41]  ? set_blocksize+0x43f/0x540
[  286.337596][   T41]  ? sb_set_blocksize+0x176/0x1d0
[  286.339191][   T41]  ? setup_bdev_super+0x369/0x730
[  286.340773][   T41]  get_tree_bdev_flags+0x389/0x620
[  286.342447][   T41]  ? __pfx_ext4_fill_super+0x10/0x10
[  286.344107][   T41]  ? __pfx_get_tree_bdev_flags+0x10/0x10
[  286.345871][   T41]  ? bpf_lsm_capable+0x9/0x10
[  286.347344][   T41]  ? security_capable+0x7e/0x260
[  286.348910][   T41]  vfs_get_tree+0x8b/0x340
[  286.350330][   T41]  path_mount+0x14d4/0x1f20
[  286.351768][   T41]  ? kmem_cache_free+0x2d4/0x4d0
[  286.353369][   T41]  ? __pfx_path_mount+0x10/0x10
[  286.354935][   T41]  ? putname+0x154/0x1a0
[  286.356280][   T41]  init_mount+0xbe/0x110
[  286.357635][   T41]  ? __pfx_init_mount+0x10/0x10
[  286.359186][   T41]  ? list_bdev_fs_names+0x10d/0x170
[  286.360819][   T41]  do_mount_root+0x22a/0x540
[  286.362350][   T41]  mount_root_generic+0x199/0x690
[  286.363959][   T41]  ? __pfx_mount_root_generic+0x10/0x10
[  286.365694][   T41]  ? __asan_memcpy+0x3c/0x60
[  286.367173][   T41]  ? getname_kernel+0x21b/0x370
[  286.368720][   T41]  mount_root+0x243/0x480
[  286.370203][   T41]  ? kmem_cache_alloc_noprof+0x21e/0x3b0
[  286.372064][   T41]  ? __pfx_mount_root+0x10/0x10
[  286.373629][   T41]  ? __asan_memcpy+0x3c/0x60
[  286.375086][   T41]  ? getname_kernel+0x21b/0x370
[  286.376619][   T41]  prepare_namespace+0xe2/0x3f0
[  286.378165][   T41]  ? __pfx_prepare_namespace+0x10/0x10
[  286.379885][   T41]  ? fput+0x70/0xf0
[  286.381122][   T41]  kernel_init_freeable+0x705/0x900
[  286.382830][   T41]  ? __pfx_kernel_init+0x10/0x10
[  286.384413][   T41]  kernel_init+0x1c/0x2b0
[  286.385808][   T41]  ? __pfx_kernel_init+0x10/0x10
[  286.387388][   T41]  ret_from_fork+0x45/0x80
[  286.388808][   T41]  ? __pfx_kernel_init+0x10/0x10
[  286.390457][   T41]  ret_from_fork_asm+0x1a/0x30
[  286.392028][   T41]  </TASK>
[  286.393125][   T41] INFO: lockdep is turned off.
[  286.394664][   T41] Kernel panic - not syncing: hung_task: blocked tasks
[  286.396810][   T41] CPU: 3 UID: 0 PID: 41 Comm: khungtaskd Not tainted 6=
.15.0-rc4-syzkaller-gebd297a2affa-dirty #0 PREEMPT(full)=20
[  286.400476][   T41] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
[  286.404020][   T41] Call Trace:
[  286.405169][   T41]  <TASK>
[  286.406133][   T41]  dump_stack_lvl+0x3d/0x1f0
[  286.407615][   T41]  panic+0x71c/0x800
[  286.408912][   T41]  ? __pfx_panic+0x10/0x10
[  286.410428][   T41]  ? rcu_is_watching+0x12/0xc0
[  286.411948][   T41]  ? rcu_is_watching+0x12/0xc0
[  286.413468][   T41]  ? watchdog+0xdda/0x12c0
[  286.414892][   T41]  ? watchdog+0xdcd/0x12c0
[  286.416296][   T41]  watchdog+0xdeb/0x12c0
[  286.417642][   T41]  ? __pfx_watchdog+0x10/0x10
[  286.419134][   T41]  ? lockdep_hardirqs_on+0x7c/0x110
[  286.420764][   T41]  ? __kthread_parkme+0x19e/0x250
[  286.422370][   T41]  ? __pfx_watchdog+0x10/0x10
[  286.423864][   T41]  kthread+0x3c2/0x780
[  286.425148][   T41]  ? __pfx_kthread+0x10/0x10
[  286.426607][   T41]  ? __pfx_kthread+0x10/0x10
[  286.428061][   T41]  ? __pfx_kthread+0x10/0x10
[  286.429544][   T41]  ? __pfx_kthread+0x10/0x10
[  286.431050][   T41]  ? rcu_is_watching+0x12/0xc0
[  286.432676][   T41]  ? __pfx_kthread+0x10/0x10
[  286.434145][   T41]  ret_from_fork+0x45/0x80
[  286.435555][   T41]  ? __pfx_kthread+0x10/0x10
[  286.437021][   T41]  ret_from_fork_asm+0x1a/0x30
[  286.438545][   T41]  </TASK>
[  286.440143][   T41] Kernel Offset: disabled
[  286.441519][   T41] Rebooting in 86400 seconds..


syzkaller build log:
go env (err=3D<nil>)
GO111MODULE=3D'auto'
GOARCH=3D'amd64'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFLAGS=3D''
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0.1-=
go1.23.7.linux-amd64'
GOSUMDB=3D'sum.golang.org'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/syzkaller/jobs/linux/gopath/pkg/mod/golang.org/toolchain@v0.0=
.1-go1.23.7.linux-amd64/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.23.7'
GODEBUG=3D''
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GCCGO=3D'gccgo'
GOAMD64=3D'v1'
AR=3D'ar'
CC=3D'gcc'
CXX=3D'g++'
CGO_ENABLED=3D'1'
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOWORK=3D''
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
PKG_CONFIG=3D'pkg-config'
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build137835052=3D/tmp/go-build -gno-record-gcc=
-switches'

git status (err=3D<nil>)
HEAD detached at c6b4fb3992
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
GOOS=3Dlinux GOARCH=3Damd64 go build "-ldflags=3D-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Dc6b4fb399236b655a39701fd51c33522caa06811 -X '=
github.com/google/syzkaller/prog.gitRevisionDate=3D20250425-123509'" -o ./b=
in/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"c6b4fb399236b655a39701fd51c33522ca=
a06811\"
/usr/bin/ld: /tmp/cccPF3Tm.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D160b3f74580000


Tested on:

commit:         ebd297a2 Merge tag 'net-6.15-rc5' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dca17f2d2ba38f7a=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D7b3842775c9ce6b69=
efc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1481939b9800=
00


