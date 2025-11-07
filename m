Return-Path: <linux-kernel+bounces-890153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237CC3F578
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AE3C4EE73F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784923016E8;
	Fri,  7 Nov 2025 10:10:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6A2FD1B1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510205; cv=none; b=tQvnRfYnhjVAN+sz+KtfZs/GxWN+tDsM2OJX58rRO4+1f5qjUMWobK1fMPVZuexaYe6rfuJ6pBoB0dO8TuDnX7ZpWstzuUrkkLUN2w5xeNY/XMK9V7+8JpR+MZraAx3K+5xUco9NYWkPjuvs8ZNufJt5rL0KZboM97FX+7imh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510205; c=relaxed/simple;
	bh=j9+pZzCfIJz13Y96zbt362iaegPWfFzrFu0gVFewou8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FKlpOAnIYdq8ktrrMj4xVmvTTlKD5fks/ZgYEK0anyxjoJLofdJ9Kx93u6kjnTLN+XW0WCzK7PGnbf79OMZhZMKxLxXwcjsU3G1Veq91ivLM2g4gCLQm7yFMycIfz4P0rDdRQNaFi03kk1MwJ0/JThrVavozCHu1ncRiZFeD4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4333052501cso4984985ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510202; x=1763115002;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifi7SIWepf0kitnd0HqJL4KnXwLU7y3b3WCt8SYtVvs=;
        b=OftiinRuehSAwsu80vrmSKecAyw6sDQRIo785MLVkyNbDU1y7JHIKRi/TFtJpcGTJM
         ksJlR2r6t3KHX0qPeLLNgwAnxs2MpU4iPlp9yssVGq5SG4jlPOdm74IKr0MEpf8PKtmn
         pNfgmThk4zeAAYJdEHj+fseyPvl++EslUPggUWfwbFY9XWaoPDJDgmd/BWqABvB+2c21
         kD8EEfo+1x+qQZA6rAqTKC/nOA5adN7oIFWnULs2RvYmq+Ce3/CEj4w8sUVI62XSnHTO
         9ttpx/HGCS/D0UenE4y0wt6rSzHkav+wF/w+MiGjxQ/RxH6NPyjXle6BswQJcMm7bRdL
         bmNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+0zZVoT62E4tW6yPLI/6Xf9DnygCm9Pim+wTftQ7WOcxEvOHJg25Y157bvxZ4ubJosKQXEzxDgMJWpe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNX5wnD5pLfGKx/vsQXBHLXKE1gVGzpxMACqSPUTlDddTuOOJ7
	+sLyxhLKlN5c+KAlWq3NyPr8+RMeITmLPMoxEHH3AVoQ91kYYp9t5ry55N4C87JZh1sQeCtRi3D
	QtZ/FFMO9a2nbhZsBPPQhnRaJIkbGCfoXrEWsrwYCnWY1dOVaS9MrgUivm+c=
X-Google-Smtp-Source: AGHT+IG6yUJl4sS3/QYXij4thj8qhD6XwowNtnJJOPiqgxDDee3pVBnUpYxhVDuBnnta/fj+Tc+92TzIJAAbnHIj1DT5IL/ZEX3k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b29:b0:433:3664:b19b with SMTP id
 e9e14a558f8ab-4335f493325mr35894675ab.15.1762510202651; Fri, 07 Nov 2025
 02:10:02 -0800 (PST)
Date: Fri, 07 Nov 2025 02:10:02 -0800
In-Reply-To: <20251107085422.8964-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dc57a.a70a0220.22f260.0032.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

WARNING in put_mnt_ns

------------[ cut here ]------------
WARNING: ./include/linux/ns_common.h:255 at __ns_ref_put include/linux/ns_c=
ommon.h:255 [inline], CPU#0: syz-executor/5842
WARNING: ./include/linux/ns_common.h:255 at put_mnt_ns+0x152/0x190 fs/names=
pace.c:6048, CPU#0: syz-executor/5842
Modules linked in:
CPU: 0 UID: 65534 PID: 5842 Comm: syz-executor Not tainted syzkaller #0 PRE=
EMPT(full)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 10/02/2025
RIP: 0010:__ns_ref_put include/linux/ns_common.h:255 [inline]
RIP: 0010:put_mnt_ns+0x152/0x190 fs/namespace.c:6048
Code: 79 00 00 bf 01 00 00 00 89 ee e8 69 84 7d ff 85 ed 7e 1f e8 20 80 7d =
ff 5b 41 5e 41 5f 5d e9 55 1f 1b 09 cc e8 0f 80 7d ff 90 <0f> 0b 90 e9 33 f=
f ff ff e8 01 80 7d ff 4c 89 f7 be 03 00 00 00 5b
RSP: 0018:ffffc90003eefa68 EFLAGS: 00010293
RAX: ffffffff8243fed1 RBX: ffff88802fc3f400 RCX: ffff88802e13bd00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffff88802fc3f4bb R09: 1ffff11005f87e97
R10: dffffc0000000000 R11: ffffed1005f87e98 R12: dffffc0000000000
R13: 0000000000000009 R14: ffff88802fc3f4b8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125ec2000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f87b83b11b8 CR3: 0000000072322000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 free_nsproxy+0x46/0x560 kernel/nsproxy.c:192
 do_exit+0x6b8/0x2300 kernel/exit.c:969
 do_group_exit+0x21c/0x2d0 kernel/exit.c:1111
 get_signal+0x1285/0x1340 kernel/signal.c:3034
 arch_do_signal_or_restart+0x9a/0x7a0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x87/0x4f0 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [in=
line]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x2e9/0xfa0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feae338d6ba
Code: Unable to access opcode bytes at 0x7feae338d690.
RSP: 002b:00007ffc8284b0b8 EFLAGS: 00000286 ORIG_RAX: 0000000000000106
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007feae338d6ba
RDX: 00007ffc8284b0e0 RSI: 00007ffc8284b170 RDI: 00000000ffffff9c
RBP: 00007ffc8284b170 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000286 R12: 00007ffc8284c200
R13: 00007feae3411d7d R14: 000000000001439b R15: 00007ffc8284c240
 </TASK>


Warning: Permanently added '10.128.1.3' (ED25519) to the list of known host=
s.
2025/11/07 10:09:29 parsed 1 programs
[   78.288542][ T5828] cgroup: Unknown subsys name 'net'
[   78.416733][ T5828] cgroup: Unknown subsys name 'cpuset'
[   78.426689][ T5828] cgroup: Unknown subsys name 'rlimit'
[   79.889458][ T5828] Adding 124996k swap on ./swap-file.  Priority:0 exte=
nts:1 across:124996k=20
[   82.629193][ T5847] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   82.638151][ T5847] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   82.647237][ T5847] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   82.664577][ T5847] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   82.682261][ T5847] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   82.921495][ T5842] ------------[ cut here ]------------
[   82.927200][ T5842] WARNING: ./include/linux/ns_common.h:255 at put_mnt_=
ns+0x152/0x190, CPU#0: syz-executor/5842
[   82.937894][ T5842] Modules linked in:
[   82.941836][ T5842] CPU: 0 UID: 65534 PID: 5842 Comm: syz-executor Not t=
ainted syzkaller #0 PREEMPT(full)=20
[   82.951938][ T5842] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   82.962381][ T5842] RIP: 0010:put_mnt_ns+0x152/0x190
[   82.967868][ T5842] Code: 79 00 00 bf 01 00 00 00 89 ee e8 69 84 7d ff 8=
5 ed 7e 1f e8 20 80 7d ff 5b 41 5e 41 5f 5d e9 55 1f 1b 09 cc e8 0f 80 7d f=
f 90 <0f> 0b 90 e9 33 ff ff ff e8 01 80 7d ff 4c 89 f7 be 03 00 00 00 5b
[   82.987767][ T5842] RSP: 0018:ffffc90003eefa68 EFLAGS: 00010293
[   82.993919][ T5842] RAX: ffffffff8243fed1 RBX: ffff88802fc3f400 RCX: fff=
f88802e13bd00
[   83.002172][ T5842] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[   83.010751][ T5842] RBP: 0000000000000001 R08: ffff88802fc3f4bb R09: 1ff=
ff11005f87e97
[   83.020230][ T5842] R10: dffffc0000000000 R11: ffffed1005f87e98 R12: dff=
ffc0000000000
[   83.029164][ T5842] R13: 0000000000000009 R14: ffff88802fc3f4b8 R15: dff=
ffc0000000000
[   83.037473][ T5842] FS:  0000000000000000(0000) GS:ffff888125ec2000(0000=
) knlGS:0000000000000000
[   83.046645][ T5842] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   83.053615][ T5842] CR2: 00007f87b83b11b8 CR3: 0000000072322000 CR4: 000=
00000003526f0
[   83.061783][ T5842] Call Trace:
[   83.065143][ T5842]  <TASK>
[   83.068100][ T5842]  free_nsproxy+0x46/0x560
[   83.072540][ T5842]  do_exit+0x6b8/0x2300
[   83.076810][ T5842]  ? do_raw_spin_lock+0x121/0x290
[   83.081866][ T5842]  ? __pfx_do_exit+0x10/0x10
[   83.086652][ T5842]  do_group_exit+0x21c/0x2d0
[   83.091298][ T5842]  ? lockdep_hardirqs_on+0x9c/0x150
[   83.096895][ T5842]  get_signal+0x1285/0x1340
[   83.101440][ T5842]  arch_do_signal_or_restart+0x9a/0x7a0
[   83.107287][ T5842]  ? __pfx___x64_sys_newfstatat+0x10/0x10
[   83.113020][ T5842]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   83.119908][ T5842]  ? exit_to_user_mode_loop+0x55/0x4f0
[   83.125440][ T5842]  exit_to_user_mode_loop+0x87/0x4f0
[   83.130743][ T5842]  ? rcu_is_watching+0x15/0xb0
[   83.135661][ T5842]  do_syscall_64+0x2e9/0xfa0
[   83.140369][ T5842]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   83.146684][ T5842]  ? clear_bhb_loop+0x60/0xb0
[   83.152080][ T5842]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   83.158131][ T5842] RIP: 0033:0x7feae338d6ba
[   83.162655][ T5842] Code: Unable to access opcode bytes at 0x7feae338d69=
0.
[   83.169945][ T5842] RSP: 002b:00007ffc8284b0b8 EFLAGS: 00000286 ORIG_RAX=
: 0000000000000106
[   83.178597][ T5842] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
07feae338d6ba
[   83.186812][ T5842] RDX: 00007ffc8284b0e0 RSI: 00007ffc8284b170 RDI: 000=
00000ffffff9c
[   83.195470][ T5842] RBP: 00007ffc8284b170 R08: 0000000000000000 R09: 000=
0000000000000
[   83.203858][ T5842] R10: 0000000000000100 R11: 0000000000000286 R12: 000=
07ffc8284c200
[   83.211844][ T5842] R13: 00007feae3411d7d R14: 000000000001439b R15: 000=
07ffc8284c240
[   83.220362][ T5842]  </TASK>
[   83.223447][ T5842] Kernel panic - not syncing: kernel: panic_on_warn se=
t ...
[   83.230752][ T5842] CPU: 0 UID: 65534 PID: 5842 Comm: syz-executor Not t=
ainted syzkaller #0 PREEMPT(full)=20
[   83.240723][ T5842] Hardware name: Google Google Compute Engine/Google C=
ompute Engine, BIOS Google 10/02/2025
[   83.250865][ T5842] Call Trace:
[   83.254246][ T5842]  <TASK>
[   83.257384][ T5842]  dump_stack_lvl+0x99/0x250
[   83.262068][ T5842]  ? __asan_memcpy+0x40/0x70
[   83.266749][ T5842]  ? __pfx_dump_stack_lvl+0x10/0x10
[   83.271940][ T5842]  ? __pfx__printk+0x10/0x10
[   83.276615][ T5842]  vpanic+0x237/0x6d0
[   83.280587][ T5842]  ? __pfx_vpanic+0x10/0x10
[   83.285341][ T5842]  ? is_bpf_text_address+0x292/0x2b0
[   83.290628][ T5842]  ? is_bpf_text_address+0x26/0x2b0
[   83.296081][ T5842]  panic+0xb9/0xc0
[   83.300039][ T5842]  ? __pfx_panic+0x10/0x10
[   83.304452][ T5842]  __warn+0x334/0x4c0
[   83.308596][ T5842]  ? put_mnt_ns+0x152/0x190
[   83.313099][ T5842]  ? put_mnt_ns+0x152/0x190
[   83.317691][ T5842]  report_bug+0x2be/0x4f0
[   83.322014][ T5842]  ? put_mnt_ns+0x152/0x190
[   83.326942][ T5842]  ? put_mnt_ns+0x152/0x190
[   83.331541][ T5842]  ? put_mnt_ns+0x154/0x190
[   83.336057][ T5842]  handle_bug+0x84/0x160
[   83.340300][ T5842]  exc_invalid_op+0x1a/0x50
[   83.344913][ T5842]  asm_exc_invalid_op+0x1a/0x20
[   83.349840][ T5842] RIP: 0010:put_mnt_ns+0x152/0x190
[   83.355313][ T5842] Code: 79 00 00 bf 01 00 00 00 89 ee e8 69 84 7d ff 8=
5 ed 7e 1f e8 20 80 7d ff 5b 41 5e 41 5f 5d e9 55 1f 1b 09 cc e8 0f 80 7d f=
f 90 <0f> 0b 90 e9 33 ff ff ff e8 01 80 7d ff 4c 89 f7 be 03 00 00 00 5b
[   83.375977][ T5842] RSP: 0018:ffffc90003eefa68 EFLAGS: 00010293
[   83.382309][ T5842] RAX: ffffffff8243fed1 RBX: ffff88802fc3f400 RCX: fff=
f88802e13bd00
[   83.390278][ T5842] RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000=
0000000000000
[   83.398243][ T5842] RBP: 0000000000000001 R08: ffff88802fc3f4bb R09: 1ff=
ff11005f87e97
[   83.406469][ T5842] R10: dffffc0000000000 R11: ffffed1005f87e98 R12: dff=
ffc0000000000
[   83.414604][ T5842] R13: 0000000000000009 R14: ffff88802fc3f4b8 R15: dff=
ffc0000000000
[   83.422581][ T5842]  ? put_mnt_ns+0x151/0x190
[   83.427262][ T5842]  ? put_mnt_ns+0x151/0x190
[   83.431955][ T5842]  free_nsproxy+0x46/0x560
[   83.436568][ T5842]  do_exit+0x6b8/0x2300
[   83.440872][ T5842]  ? do_raw_spin_lock+0x121/0x290
[   83.446184][ T5842]  ? __pfx_do_exit+0x10/0x10
[   83.450965][ T5842]  do_group_exit+0x21c/0x2d0
[   83.455810][ T5842]  ? lockdep_hardirqs_on+0x9c/0x150
[   83.461175][ T5842]  get_signal+0x1285/0x1340
[   83.465772][ T5842]  arch_do_signal_or_restart+0x9a/0x7a0
[   83.471517][ T5842]  ? __pfx___x64_sys_newfstatat+0x10/0x10
[   83.477333][ T5842]  ? __pfx_arch_do_signal_or_restart+0x10/0x10
[   83.483629][ T5842]  ? exit_to_user_mode_loop+0x55/0x4f0
[   83.489447][ T5842]  exit_to_user_mode_loop+0x87/0x4f0
[   83.495157][ T5842]  ? rcu_is_watching+0x15/0xb0
[   83.500008][ T5842]  do_syscall_64+0x2e9/0xfa0
[   83.504738][ T5842]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   83.510801][ T5842]  ? clear_bhb_loop+0x60/0xb0
[   83.515473][ T5842]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   83.521699][ T5842] RIP: 0033:0x7feae338d6ba
[   83.526273][ T5842] Code: Unable to access opcode bytes at 0x7feae338d69=
0.
[   83.533448][ T5842] RSP: 002b:00007ffc8284b0b8 EFLAGS: 00000286 ORIG_RAX=
: 0000000000000106
[   83.541954][ T5842] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000=
07feae338d6ba
[   83.549920][ T5842] RDX: 00007ffc8284b0e0 RSI: 00007ffc8284b170 RDI: 000=
00000ffffff9c
[   83.558226][ T5842] RBP: 00007ffc8284b170 R08: 0000000000000000 R09: 000=
0000000000000
[   83.566282][ T5842] R10: 0000000000000100 R11: 0000000000000286 R12: 000=
07ffc8284c200
[   83.574415][ T5842] R13: 00007feae3411d7d R14: 000000000001439b R15: 000=
07ffc8284c240
[   83.582562][ T5842]  </TASK>
[   83.585836][ T5842] Kernel Offset: disabled
[   83.590261][ T5842] Rebooting in 86400 seconds..


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
 -ffile-prefix-map=3D/tmp/go-build1062286916=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs/linux/gopath/src/github.com/google/syzkaller/go.mo=
d'
GOMODCACHE=3D'/syzkaller/jobs/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs/linux/gopath'
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
HEAD detached at 2c50b6a91af
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3D2c50b6a91afe391fad4d14f7b7d7167d570089dd -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20251030-144239"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3D2c50b6a91afe391fad4d14f7b7d7167d570089dd -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20251030-144239"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3D2c50b6a91afe391fad4d14f7b7d7167d570089dd -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20251030-144239"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"2c50b6a91afe391fad4d14f7b7d7167d57=
0089dd\"
/usr/bin/ld: /tmp/ccgWstkz.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x104): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null



Tested on:

commit:         9c0826a5 Add linux-next specific files for 20251107
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df2ebeee52bf052b=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3D1957b26299cf3ff78=
90c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-=
1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D159511145800=
00


