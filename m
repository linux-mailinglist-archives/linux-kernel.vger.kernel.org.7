Return-Path: <linux-kernel+bounces-712368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C1AAF082C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 03:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4F73ADFAC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 01:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECF19ABC3;
	Wed,  2 Jul 2025 01:56:40 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F76F2F2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751421400; cv=none; b=eIkC+Fejfj1ykeiYGG7QI+oz/lhjDrz4pk+xdHP9dlRQks8qEqrr+5zRwMCI+6lXB0OGWlKqatcFtPjdckeb08wtEmdz7pRfMxIQiiHsN58fnVt1kexLvA8nENjjA86DL6dymRHBObQDVnYLG8wcSwETGSkaKGc/9K9uSau7o6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751421400; c=relaxed/simple;
	bh=fKeSclWULZ9iAiZjVORycKIENeiTUZ4CNEJS/y2Y3Xo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pjJhAdvynD+9pY8MsXHpsDU4co1bx9zgoS35J+lt7iiIrBIPb95/gLZ5db648v4KqJxXKR4xP7XE6WOrE1N+WNyJ/5EVeyIjv6Cl+GMDJpgnsSXXa0a171mQdUumGP76a3gNC+1j4i3PEeGpMA5NTiEt1Unqz0DTx5/TZlapVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8730ca8143eso672502039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 18:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751421398; x=1752026198;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7O0rdgOwfhhpJHyfG7TMZATURKoTTxVXu+F8u51d9E=;
        b=TwfG+UtlM5uar/qTjXMslY83vOt4VChF5VJbEuLgBmuPVdGvIFDCbGFV55NtM39H7G
         4NhDPSp93G29hOzqJR7nbGfEWy1d5aJOUqH8d36nhuYV5JZCLPVym3kjnbKNWTQp8cmn
         0jlfEpkv5UGKb8xaOcbuCGBmVLxSLKSqVG7+UOsQqrFzlHo7M3JrRZ4D8dX2v0FQ8Zyi
         9j3sFXYSV4GTjEiHCMbIAtkooqETyOIJOEWAh8j+cLeR/wbIuIF5LLsaoOmY5Q9iTckC
         e/y/NlL5Aft/GwIMgctHP3egw0s3JeS6tCUF52ezpGckTuJIw9ImiwLiGecLYuU8oLWR
         Y9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX58DIRKujV6zyj/HzriJQ8Ye3x1N1k8QIx9L+qyJzTd6e8BuB7ISjf2ycVMB4/QKrvw+m2fQDaypOpvHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsBvyU6r8MY16cN4p8g8cb1lhcPFO4juMMmLGVVT3DqM1wYK9
	Dn/JPZVSzTKe52Syxx3Q0OV90RrRu2F282E8y4l2Wr3ZN9g34yCmBgddCAECJ18RZ4+osOIk/Ud
	M0cz/ByZnqQwzW3w2llm9ojblXnO9bkfJaS/zAN+Chenf7VzW+UhqvRuXxhA=
X-Google-Smtp-Source: AGHT+IEskQ1Bkal74yoiBoF97O70hJbzZIAnixhEL/5rAiuJbA9zuFtrPIYsNftp2dGMSNE/DqqRxv7Rdru4XeN07MM1gf0BXMqe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160c:b0:3e0:536d:2b72 with SMTP id
 e9e14a558f8ab-3e0552a705dmr8108725ab.8.1751421397768; Tue, 01 Jul 2025
 18:56:37 -0700 (PDT)
Date: Tue, 01 Jul 2025 18:56:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686491d5.a70a0220.3b7e22.20e9.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in record_func_key
From: syzbot <syzbot+efb099d5833bca355e51@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cce3fee729ee selftests/bpf: Enable dynptr/test_probe_read_..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=132ab982580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79da270cec5ffd65
dashboard link: https://syzkaller.appspot.com/bug?extid=efb099d5833bca355e51
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1343388c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179bf88c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f286a7ef4940/disk-cce3fee7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2ebe1fdc3/vmlinux-cce3fee7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e3070663778/bzImage-cce3fee7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+efb099d5833bca355e51@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: expected array map for tail call(1)
WARNING: CPU: 0 PID: 5831 at kernel/bpf/verifier.c:11084 record_func_key+0x2d6/0x490 kernel/bpf/verifier.c:11084
Modules linked in:
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor941 Not tainted 6.16.0-rc3-syzkaller-gcce3fee729ee #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:record_func_key+0x2d6/0x490 kernel/bpf/verifier.c:11084
Code: 09 cc e8 cd 64 e3 ff 80 3d 78 15 ae 0d 01 74 ba e8 bf 64 e3 ff c6 05 6a 15 ae 0d 01 90 48 c7 c7 e0 e3 91 8b e8 bb 07 a7 ff 90 <0f> 0b 90 90 eb 9f e8 9f 64 e3 ff eb 05 e8 98 64 e3 ff 48 8b 5c 24
RSP: 0018:ffffc90003f9ec70 EFLAGS: 00010246
RAX: 1a7eac49ccc01000 RBX: dffffc0000000000 RCX: ffff88807bb0bc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 0000000000000001 R08: ffff8880b8624293 R09: 1ffff110170c4852
R10: dffffc0000000000 R11: ffffed10170c4853 R12: ffff888142ec6000
R13: ffff8880278b2000 R14: ffff888032380000 R15: 1ffff11006470006
FS:  000055557603c380(0000) GS:ffff888125c4d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000364be398 CR3: 0000000077a22000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_helper_call+0x2fb8/0x6b60 kernel/bpf/verifier.c:11395
 do_check_insn kernel/bpf/verifier.c:19850 [inline]
 do_check+0x95ec/0xe080 kernel/bpf/verifier.c:20017
 do_check_common+0x188f/0x23f0 kernel/bpf/verifier.c:23180
 do_check_main kernel/bpf/verifier.c:23263 [inline]
 bpf_check+0x10252/0x1a5d0 kernel/bpf/verifier.c:24619
 bpf_prog_load+0x1318/0x1930 kernel/bpf/syscall.c:2972
 __sys_bpf+0x5f1/0x860 kernel/bpf/syscall.c:5978
 __do_sys_bpf kernel/bpf/syscall.c:6085 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6083 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6083
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4fbbba64a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd87326708 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007ffd873268d8 RCX: 00007f4fbbba64a9
RDX: 0000000000000094 RSI: 00002000000008c0 RDI: 0000000000000005
RBP: 00007f4fbbc19610 R08: 00007ffd873268d8 R09: 00007ffd873268d8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd873268c8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

