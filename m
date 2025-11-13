Return-Path: <linux-kernel+bounces-898645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72058C55A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8D7D3B1DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62EE2FD1BF;
	Thu, 13 Nov 2025 04:26:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF92D9EE2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007991; cv=none; b=dgVlg70sNE34Zjhmu93jDKip7D6/NSPtfA1kD2lix1/pXkNNjDrmYPoSiagacgwEnqYPR38r4+gr85WzDdUbf/uHsjRo2pf1rE1qKAwjTmwmk86n8q6XVBoYBHfhhf2EIc2Nyhjo3uxvmvKhkRS8PpogQe9B9M9378Y+GU/CzB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007991; c=relaxed/simple;
	bh=nhLbmKXgssz+M2ZkXGbr1waI7PBbdxLjfV4Nhc+cyx4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PLqcAoGyVwV6ye8r2+a54RAHUVpGhZzWXr/unhk9jSsPfbmauyccXimP3Ct2nNyyvDLyxhl4ADnSemYhFgH/rbmHdICYo7AumIGcnwlbwA6QqRXid637u7hy2PSxYjbLispaZCKQgCUTvBLdETcTKhD8plvtrTYg2jAA8dqjiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4337e3aca0cso7330715ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763007989; x=1763612789;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vko0liSXNlPrds3fLz3R6ALlGDNGPAyedKhhTM/0DZo=;
        b=HIwNCuZevbY2mkElgUqfXUSco5RjUgMyB1wdu8rmoCMaDpj4EQZnbixRK2k6Cl1zhd
         rfbDqRrV6YAhz2+lDzLGV6tp9Du6uOj7M7q0WrZ5VSICQOPntQY1J8q8RcRCrgoI2sIa
         a5nAH8gHcT+yk3lAxCThl+r/+As1Stbe0/161H5ipO6d6BdpgsIYL4p47gKfvrXzG7WU
         h3mF5OYT6TrkDLIzCSoLoOnbG8zf1OdkfVSeEYXsENoQ6p++D56W+9K0KOHLK008WliE
         r6Age4RPeYkKzdWwZ4WUbAEAFfUGTSKGo2Zrt2vGeJ3vhgvhLFk298WeXn7CUMox554y
         CaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2nTWWagBs0HN9q908WWNar4a6tXsT02DQKN4Dyz356GWlMAb9p2cfof8f6jrOWfvU0GKZUNCV9sfT9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6FWS28kREiamt20lPRt4WCpqbgYRhVQVEzFZZXmWLwhjeQnUl
	z/d9JC9LL5qlgOyrkO/knH+tMesRhvjaMo2cakrLrWbpl2AsRJelFVNAo9wNTRoZ4dzP5nGG+GO
	UvfGKsKtxuqx08a34ku/DdHbOQ5h6lCa/E9up+N/q3tHbB2Sv8TKf/+/Iq9s=
X-Google-Smtp-Source: AGHT+IHTTg/Ln7hW0ZRls9+FebScaGrhdhm3A65/NuTqSZpNXbTbj+CfmNVcC4X+buUi8x+OqoaimPhEjr/XGYz0Dg3mpKzO9m2S
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:433:74c1:2edb with SMTP id
 e9e14a558f8ab-43473d4e71cmr89149855ab.14.1763007989168; Wed, 12 Nov 2025
 20:26:29 -0800 (PST)
Date: Wed, 12 Nov 2025 20:26:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69155df5.a70a0220.3124cb.0018.GAE@google.com>
Subject: [syzbot] [bpf?] possible deadlock in bpf_lru_push_free (2)
From: syzbot <syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e427054ae7bc Merge branch 'x86-fgraph-bpf-fix-orc-stack-un..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=136b70b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=18b26edb69b2e19f3b33
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10013c12580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16541c12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c1ac942fc5fb/disk-e427054a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be05ef12ba31/vmlinux-e427054a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c75604292a15/bzImage-e427054a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18b26edb69b2e19f3b33@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz-executor149/10558 is trying to acquire lock:
ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_common_lru_push_free kernel/bpf/bpf_lru_list.c:514 [inline]
ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_lru_push_free+0x33b/0xbb0 kernel/bpf/bpf_lru_list.c:553

but task is already holding lock:
ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:440 [inline]
ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x1ab/0x19b0 kernel/bpf/bpf_lru_list.c:496

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&loc_l->lock);
  lock(&loc_l->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor149/10558:
 #0: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: bpf_percpu_hash_update+0x2b/0x200 kernel/bpf/hashtab.c:2409
 #1: ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:440 [inline]
 #1: ffffe8ffffc41588 (&loc_l->lock){....}-{2:2}, at: bpf_lru_pop_free+0x1ab/0x19b0 kernel/bpf/bpf_lru_list.c:496
 #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2074 [inline]
 #2: ffffffff8df3d620 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x186/0x4b0 kernel/trace/bpf_trace.c:2116

stack backtrace:


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

