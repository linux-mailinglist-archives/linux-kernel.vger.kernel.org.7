Return-Path: <linux-kernel+bounces-750787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE2B16113
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F3E3AFD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF47298CD0;
	Wed, 30 Jul 2025 13:11:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D7293C4A
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881095; cv=none; b=FTVYE99uSHay47xc720nLU1tjBdXYmt8+tCmuoMcWRH8ydzy2RT2DVnS8MtjnPuDZSxIvU+J7t9ZekIh9SovZ2bvAI4UPDVlDMOAflLQY7u3iaT+mN6Gy/Vlvbk5VruRgR6wPgDtUoB/ys+2rPbBxe5cTUg9iI5bL+6TzM4mIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881095; c=relaxed/simple;
	bh=KG7fc77M01owqZUjVFGZdn6vql/jSvmuV/IfwiUPv28=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sKIB1ImjU3xFXeOq/i1dUJOS4X1zhjpclLt0uu96v+VKr1JlbQcCmCEGBXCK899StDv3SaZ3iH8vUNThCMto4Hh0g9+28ymI6Yxf1XmTAUjAQVIxWLE3hHpVdFkKIih95FwY4FKg3VrqDF5qOXZDJ3TvUOiN/hfbMfqcXYmfNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86a5def8869so1726493839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753881093; x=1754485893;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJmB3YmXk9guqFYOXDB/HPecSW6ZbcNiYqBhlwZDyNA=;
        b=ImVliTtjmPtseoHNYMLge0YfL4IxW+Qy+BoPzJOSrmzInfRxTBGXfCMpxZz2Ok3OYG
         z1o+P+q0++ypEf/5PA/CYfbhq8/DsFEiuz0vDdirDCaF2hg/E5TjAgNTOmQm+CXgfI+w
         rPkHo+XHjMVdpHk669EELBK6B29UeWGdJLlQKuaG0s0fe+sy0lr4eLv56GVzatbiuRhc
         LFRsBHSbpMuRJNgzVkz+GUiCZzXCQKBUpZAgpsC6bG63izyuL0qdGNNeN5mO56yGiQJz
         ao4wFMGNgLe3snDqHeVeNaCGyPRBamfiC+RWRAWORfpCLKpgG/KDBUBS6NbmEdKiqoaw
         pcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBgthZC/gD8tooH2A2tOBzgyYHl4iHXiVhTjiAdColec0+Le3Pb74wOCK9NHTbqsflKVuPjP2ABDVuxhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhIGNp8vXkZxFJqZUSG/CGMhLkyVtEqi3MZxJxr/iSatxufak+
	uZfFcSCezGgp/1ab4rTyPZZ8Odzpp8AH5X4MXbqCypmhFcEKcvQRk5vzemXsM0J60FbpdIeQs/n
	wFCFbNLoH3Nylh48QXdSDMNgUNXifvvpzOKQFEnmYXS+en2xjRVP3HSaCsFI=
X-Google-Smtp-Source: AGHT+IGJwAdTFGg3Rdi9jBmlpL/2xSJuY7eJEzfxnTLlkQxPj47h2YY6tNCTixDNuZcPqnEZAYUmlr4YyfnDppwIQ9XgBrKTc6Wq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3288:b0:3e2:8ddd:b406 with SMTP id
 e9e14a558f8ab-3e3f624f316mr51134025ab.17.1753881093463; Wed, 30 Jul 2025
 06:11:33 -0700 (PDT)
Date: Wed, 30 Jul 2025 06:11:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688a1a05.050a0220.5d226.0008.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ipv6_gso_segment
From: syzbot <syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7abc678e3084 Merge tag 'pmdomain-v6.16-rc2' of git://git.k..
git tree:       bpf
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11cc0ca2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12b5044868deb866
dashboard link: https://syzkaller.appspot.com/bug?extid=af43e647fd835acc02df
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10480f82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14248834580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a9fc2a6bfdf/disk-7abc678e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29375cef95f6/vmlinux-7abc678e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8148ffc5b47b/bzImage-7abc678e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5874 at ./include/linux/skbuff.h:3032 skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
WARNING: CPU: 1 PID: 5874 at ./include/linux/skbuff.h:3032 ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
Modules linked in:
CPU: 1 UID: 0 PID: 5874 Comm: syz-executor410 Not tainted 6.16.0-rc6-syzkaller-g7abc678e3084 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:skb_reset_transport_header include/linux/skbuff.h:3032 [inline]
RIP: 0010:ipv6_gso_segment+0x15e2/0x21e0 net/ipv6/ip6_offload.c:151
Code: ff ff e8 f1 db 80 f7 49 c7 c5 a3 ff ff ff e9 27 fe ff ff e8 e0 db 80 f7 49 c7 c5 a3 ff ff ff e9 16 fe ff ff e8 cf db 80 f7 90 <0f> 0b 90 e9 71 f5 ff ff e8 c1 db 80 f7 e9 d3 00 00 00 e8 b7 db 80
RSP: 0018:ffffc90003faed00 EFLAGS: 00010293
RAX: ffffffff8a3f4d21 RBX: ffffffff8de66da0 RCX: ffff888030385a00
RDX: 0000000000000000 RSI: 00000000000100f4 RDI: 0000000000010000
RBP: ffffc90003faee30 R08: ffffea0001ff8240 R09: 0000013a000001a7
R10: ffffea0001ff8240 R11: 0000013a000001a7 R12: 1ffffffff1bccdb4
R13: ffff8880334eb280 R14: 00000000000100f4 R15: ffff8880334eb350
FS:  000055555a160380(0000) GS:ffff888125d23000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000010000 CR3: 000000007fe76000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
 nsh_gso_segment+0x54a/0xe10 net/nsh/nsh.c:110
 skb_mac_gso_segment+0x31c/0x640 net/core/gso.c:53
 __skb_gso_segment+0x342/0x510 net/core/gso.c:124
 skb_gso_segment include/net/gso.h:83 [inline]
 validate_xmit_skb+0x857/0x11b0 net/core/dev.c:3950
 validate_xmit_skb_list+0x84/0x120 net/core/dev.c:4000
 sch_direct_xmit+0xd3/0x4b0 net/sched/sch_generic.c:329
 __dev_xmit_skb net/core/dev.c:4102 [inline]
 __dev_queue_xmit+0x17b6/0x3a70 net/core/dev.c:4679
 packet_snd net/packet/af_packet.c:3130 [inline]
 packet_sendmsg+0x3e16/0x5060 net/packet/af_packet.c:3162
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb36bb8ea9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4bae10a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007ffb36bb8ea9
RDX: 00000000200400c4 RSI: 0000200000000180 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000001 R09: 0000000000000001
R10: 0000200000000180 R11: 0000000000000246 R12: 00007fff4bae1100
R13: 00007ffb36c063fe R14: 0000000000000003 R15: 00007fff4bae10e0
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

