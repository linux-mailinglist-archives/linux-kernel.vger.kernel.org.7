Return-Path: <linux-kernel+bounces-658138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B58BABFD32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4915B9E687F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBDA28F953;
	Wed, 21 May 2025 19:14:30 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0022F15E
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854870; cv=none; b=hS+spqRAF2R3V239RJcKEa7WqFYZRkCqtUuUtsjmBmjpQeaUwlUiMU2onrcUlzzPULJ8wlvpIneZsrb+hZMLkaNDXWq7fhWxCmAKJqx93jVVAlDy24Dhlzb4CuyHHyhw1A+U6epmCNuKtHmNOS2+0k9twAMULpqzCYt9stFd39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854870; c=relaxed/simple;
	bh=vrRsV4qLCDV0XdnD0S1yBCF6VGBs96BIYUPfqY3D0ms=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=opkIpOcZ5F+BT9lNxD7WuyRcwvf08kuh7XarrTaWnRCJqPnXGsnEFjbq+Zj7rYfaLozzFyHRSULvgyXihMX15riStOaJSXSL5YgHWuTHuoMSOavPybVHFvkxjOqLmwzD9tANwsiHTmHP8XDfcq/9DLxfkGejxBfpdYnthyqfSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8610d7ec4d3so1098196839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854867; x=1748459667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8YGFdliMkUSr1J7gzFt8Ls4s92TDOscM1r/Go3DS6o=;
        b=wtfM1jztHBP1Hy4QTZBeBXe7HcnLzm6ltRcJFyHiofwJC9M2hYDHyA+qeEv1q2fxxR
         j/7RKlQVST49oSwd7XlKate+g1w0Pz1NKSN3idIPCTEH1p35/aOEdL9t2Wf6+k6XbFsU
         ni2+tHBsprVXyRKWzvFDiwMtg+/EoTK2qBFHgSqzX+1ir8nD15DcrOR15AAoF2VWJ11H
         tbees1v85ckBMeeNeNRmsN12Zaew15O34Rxa3V9ZRJtnqFsK2mpoUSLtb0PQ9lYAhEbz
         T9At2Pn8fQSzoeoONLmEWuj5z78usNrLcGpFsAJUSl6xoi/EHXYP68sCQBWAODETQWL+
         y4rA==
X-Forwarded-Encrypted: i=1; AJvYcCVaNucmvddu1yAGclxB11asllPQlTqD2Xaw4szQrmBE/FeHdaJhuL7NSaBU9uAy8oIWWXGVPtGWJ3W+CuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIOVOsZANLkWGBo478VsDmnuAPJ5uv94Vp/vcUR4RpZcZBHsQ
	YZJnkv+FZXqnwUDS/+Ve6IGB7pWDBHFgeawgigf9N3/zlOeca5CMfK4AJnDOp+cfVe6i6bTQha+
	DzMESZJoD9SZ80duc/Z72df5nBaREvR1xnnTv1UUSgOfWLOX6jCnFpdloo8o=
X-Google-Smtp-Source: AGHT+IHfT5WaQnmmJ9kkC9N0FO1IV90UAQ6Pd8LlzJAMFikI/3t9dlwkdEE/DiNid766qTipJKXOq4Uww120NBPetUbxn6oiUAU8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:f118:0:b0:86a:2373:aa3d with SMTP id
 ca18e2360f4ac-86a2373aa86mr2118933739f.3.1747854867493; Wed, 21 May 2025
 12:14:27 -0700 (PDT)
Date: Wed, 21 May 2025 12:14:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682e2613.a00a0220.2a3337.0003.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in xfrm_state_find (4)
From: syzbot <syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b062d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56e29fa09e87dea7
dashboard link: https://syzkaller.appspot.com/bug?extid=7ed9d47e15e88581dc5b
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da9615d2ee0b/disk-172a9d94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/997b6c928374/vmlinux-172a9d94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30f01bdce820/bzImage-172a9d94.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7ed9d47e15e88581dc5b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in xfrm_state_find+0x2423/0xaae0 net/xfrm/xfrm_state.c:1438
 xfrm_state_find+0x2423/0xaae0 net/xfrm/xfrm_state.c:1438
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2519 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2570 [inline]
 xfrm_resolve_and_create_bundle+0xabc/0x58b0 net/xfrm/xfrm_policy.c:2868
 xfrm_lookup_with_ifid+0x48c/0x3ac0 net/xfrm/xfrm_policy.c:3202
 xfrm_lookup net/xfrm/xfrm_policy.c:3333 [inline]
 xfrm_lookup_route+0x63/0x2b0 net/xfrm/xfrm_policy.c:3344
 ip_route_output_flow+0x20d/0x2b0 net/ipv4/route.c:2918
 ip_route_connect include/net/route.h:352 [inline]
 tcp_v4_connect+0xa43/0x1cd0 net/ipv4/tcp_ipv4.c:252
 tcp_v6_connect+0x134a/0x1d40 net/ipv6/tcp_ipv6.c:240
 __inet_stream_connect+0x2d3/0x1760 net/ipv4/af_inet.c:677
 inet_stream_connect+0x69/0xd0 net/ipv4/af_inet.c:748
 __sys_connect_file net/socket.c:2038 [inline]
 __sys_connect+0x523/0x680 net/socket.c:2057
 __do_sys_connect net/socket.c:2063 [inline]
 __se_sys_connect net/socket.c:2060 [inline]
 __x64_sys_connect+0x95/0x100 net/socket.c:2060
 x64_sys_call+0x23bb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:43
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x1b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable tmp.i.i created at:
 xfrm_tmpl_resolve_one net/xfrm/xfrm_policy.c:2491 [inline]
 xfrm_tmpl_resolve net/xfrm/xfrm_policy.c:2570 [inline]
 xfrm_resolve_and_create_bundle+0x3a7/0x58b0 net/xfrm/xfrm_policy.c:2868
 xfrm_lookup_with_ifid+0x48c/0x3ac0 net/xfrm/xfrm_policy.c:3202

CPU: 1 UID: 0 PID: 11691 Comm: syz.5.1451 Not tainted 6.15.0-rc6-syzkaller-00278-g172a9d94339c #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

