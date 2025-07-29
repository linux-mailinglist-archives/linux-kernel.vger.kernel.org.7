Return-Path: <linux-kernel+bounces-749151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD0B14ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83B51164632
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162862620F1;
	Tue, 29 Jul 2025 09:05:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DCD2165EC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753779904; cv=none; b=l1RtUVjbUjkzp/xqqHT91zCJn86f/yrHOw8q3X3bzdDhOw5vmzG7jL9GlyfNOBnC0vAwjF+u/jgT1r4wLEALl4yxosksvECp1tdmlxCzikFguyLm9VZ90x58fXyn2O0QDz8TnJZCNVZW9rBOnbUfKCd8ZNbh5McTw5PVUuaE4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753779904; c=relaxed/simple;
	bh=G6+VDTwJ6uaAW2tCDjI7Qd5wq31a21SJI9lYsrwSrUE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cIc4PN19ZFS7+42x7aa3Gk+GJ1/auaN9/DLmnPA3Heow1Nv7q3pHtA3uAncb5QjQC11ccEQLwKIq5JqpbgliFsvUYpuh0GK7+Kopd4CYM8EOLYA5eGMul+d6l5cLpnglTSjDksc3wbohcSJmbucHMaWLZouXORqprH28PGBWWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e2a48a2216so29322335ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753779902; x=1754384702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Db6hdRWQLd66LNFo2a5Dy9PgIOyiSE6qlOAFZK4TYHE=;
        b=V4cSGaunZXS3lnDVh0jQIGJ8mMp7q/zQw34hoJdPYe+2g5Uj+N06KnS7Q9QH+eOA7E
         naFTpxCfzm35QiZ5pfgoBuAQLLTtiGblJrVesUmOpDgcNWNRHipUuBHcD3G78do9Ri7F
         63gtQlWAYQQcu9W/G0BRyKu/Ft7sC4OzpBpe+MzHhqiCKUgheB2WBHALLjiPlTcUEAFl
         OHul1zhIUMfOAsFvFbNFBBsDpoyzOo4oh65yrAmLMSOv4e01J0CKjKyRtjHP5ht4m0sn
         cSI5HaEmjR7cCmsA4ljk1MvDQaa81S4DjUlc8Z6DDGizbVfPuvQvVPzBin6b6qi2DpGT
         9qDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEYrhu1mRw4ZutrqRjHPIYctBcSgqu857wq8WpMzvqK18IM6F5JdL627Ikaz7S9dzKJyyvpnaND3ANcpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9cE6IdxkzYEpCeigAewdzxV7A9wRm3q55WdHGHXLqQOGCZI1
	2sG69M/f+khu6arastlXTgZXDfPjzWmCboH6ycASderoDP379NajgAmYQyOD4OKToSFmIYGnBvo
	11gURd9EoY3VBwJ/EkUsLc2KarAZhAhedrjnAb5SA9fMglQsGzX9U3yh2ko0=
X-Google-Smtp-Source: AGHT+IFTBk+q73WZ21VZy8K2PFCwNndbMDJ6YQiCIW9wyHK78AauQC3djewqYdmAqIlOGRLZjHU5+qgAzlIP3BPvkSuRznHcZZ5+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d95:b0:3e3:d204:5722 with SMTP id
 e9e14a558f8ab-3e3d20459b7mr175755255ab.11.1753779902442; Tue, 29 Jul 2025
 02:05:02 -0700 (PDT)
Date: Tue, 29 Jul 2025 02:05:02 -0700
In-Reply-To: <20250729081109.3381-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68888ebe.a70a0220.13df61.0001.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in xfrm_state_fini (3)
From: syzbot <syzbot+6641a61fe0e2e89ae8c5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in xfrm_state_fini

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1084 at net/xfrm/xfrm_state.c:3293 xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3293
Modules linked in:
CPU: 1 UID: 0 PID: 1084 Comm: kworker/u8:6 Not tainted 6.16.0-syzkaller-g86aa72182095-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:xfrm_state_fini+0x270/0x2f0 net/xfrm/xfrm_state.c:3293
Code: c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 18 dd 09 f8 48 8b 3b 5b 41 5c 41 5d 41 5e 41 5f 5d e9 06 ab ea f7 e8 31 c4 a7 f7 90 <0f> 0b 90 e9 fd fd ff ff e8 23 c4 a7 f7 90 0f 0b 90 e9 60 fe ff ff
RSP: 0018:ffffc90003a8f898 EFLAGS: 00010293
RAX: ffffffff8a17909f RBX: ffff888035c00000 RCX: ffff888026f79e00
RDX: 0000000000000000 RSI: ffffffff8db5f1fd RDI: ffff888026f79e00
RBP: ffffc90003a8f9b0 R08: ffffffff8f6025e7 R09: 1ffffffff1ec04bc
R10: dffffc0000000000 R11: fffffbfff1ec04bd R12: ffffffff8f600660
R13: 1ffff92000751f40 R14: ffff888035c014c0 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d86000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efd65a94e9c CR3: 0000000031b09000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 xfrm_net_exit+0x2d/0x70 net/xfrm/xfrm_policy.c:4348
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:253
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:686
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x711/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         86aa7218 Merge tag 'chrome-platform-v6.17' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100531bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6aef71a615d0cdf2
dashboard link: https://syzkaller.appspot.com/bug?extid=6641a61fe0e2e89ae8c5
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16798cf0580000


