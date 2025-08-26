Return-Path: <linux-kernel+bounces-785909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5106BB35262
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037745E6AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A82D29D8;
	Tue, 26 Aug 2025 03:53:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933F9460
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756180385; cv=none; b=pthmbokXLv0okEAT6b6KWgx5damNRZ1gMFpRwYRZpaW7CtClTZT1iUnTUltivOx+Yo2BEmvbhvE1Jg0WWkhg4UbTbSBkHQ2cyszVJyfGUK38JyqikXxZy2xhvsB41bEJYQsLOECq0DT68cD6hmBhnHTTrCxvesZG4RgpKIM7ApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756180385; c=relaxed/simple;
	bh=b9KknDWjzcv9pCfUVxhEU6qF5W4lyO0GvVLXKK0I67M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NX1VZfRWRoA80dO7uwD0gxzJ3IHLCgdIJgjJeU6uGM9r96WiKHUE1DZCSIOi6EUMxKfpI3595mG4/9G/Vt1EX/Ibnfk/Dm/RlS1aL3flzZ1rdTPLWY6vHvKCH4cwz614w5oqSd7qB1k4fREVlwyM64oFY4usBK8AQ5iLlBFtewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ed0ba44c8fso17679705ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756180382; x=1756785182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmnJDU3qd38QH8T38CuiKYrkFEHVy2tnXsdapkes1I4=;
        b=AEFG+3PAJPULP7tewfcHKqrEAyjkwsqhTlY9sZT7SzE8CubHyeQFM7sZ5FMjxYTJIz
         W0vlsdsp4GG5mRJBcBTDeochLpgCZCSflG2QV/p28Ny88/TGPyJiM9joTpe63xqZqxJY
         f20gjg13IfqqoO3zzXyIpPYCCFQ7UWQoNA8BYxXkjKkhc2wEA8evNlLjKrWdKKQ+F203
         m02TiSh849k+/heaDMsvnxHGCIZ1ie2WOZPq5JR94WMj6Okb617+pFIq1kcBHCJuglk9
         oRANPu1DemAwKfyWipTwJ2qACpzspmuodYWCmFEhUsPUa+g7wBSqmLXLQtTGc5DUdT+8
         /UfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuNCKr7YmVTeJ38BBnHgioaJQnAdKuEuchk0nSJH45HrD1IeZc/Jxr3TVhSB+qfpmyHYjbFIRSuLuGmww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGsVM5vNOSh4kloCyp5kn8YghEYer1hV/donoS39RjvkNmVDh
	j7PxF1W8Bnt8xdaMT7NLiYlEPQEpgO8Gdm70iD3olvwtk9YBpO70iPDGe22PO1ijgMfMmWjZGFP
	80yjpPjQYaLnr9qT2OfNw5CUE++JbgwOzamKc3Y8Sr1S6qDyW2jDSMSvU37I=
X-Google-Smtp-Source: AGHT+IFd6qHK130IpSOukowGdIffcEpZ4VpdtNc3lrUEPoWC0LWOc+/oJ+eoe/QDScj5JMwW5sDivnxmVJB3qZswrRUnwg4pqKx3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:3e5:4c7d:b772 with SMTP id
 e9e14a558f8ab-3e91f93bd19mr212756345ab.2.1756180382727; Mon, 25 Aug 2025
 20:53:02 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:53:02 -0700
In-Reply-To: <20250826032731.5585-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad2f9e.a00a0220.33401d.048c.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in __xfrm_state_destroy

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1107 at net/xfrm/xfrm_state.c:801 __xfrm_state_destroy+0x15f/0x190 net/xfrm/xfrm_state.c:801
Modules linked in:
CPU: 1 UID: 0 PID: 1107 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:__xfrm_state_destroy+0x15f/0x190 net/xfrm/xfrm_state.c:801
Code: 48 c7 c2 00 34 63 8f 5b 41 5c 41 5d 41 5e 41 5f 5d e9 25 89 69 f7 e8 70 33 9f f7 90 0f 0b 90 e9 00 ff ff ff e8 62 33 9f f7 90 <0f> 0b 90 e9 20 ff ff ff 44 89 f1 80 e1 07 38 c1 0f 8c c6 fe ff ff
RSP: 0018:ffffc90003aaf7f0 EFLAGS: 00010293
RAX: ffffffff8a2077ce RBX: ffff88806bb13308 RCX: ffff888026b2bc00
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
RBP: 0000000000000005 R08: ffff88806bb1336b R09: 1ffff1100d76266d
R10: dffffc0000000000 R11: ffffed100d76266e R12: dffffc0000000000
R13: 1ffff1100d762662 R14: ffff88806bb13310 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888125d18000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3a61070008 CR3: 00000000777e6000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 xfrm_state_put include/net/xfrm.h:928 [inline]
 xfrm_state_flush+0x4ab/0x630 net/xfrm/xfrm_state.c:943
 xfrm6_tunnel_net_exit+0x3c/0x100 net/ipv6/xfrm6_tunnel.c:337
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         df534e75 net: phylink: remove stale an_enabled from doc
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17488634580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1660c462580000


