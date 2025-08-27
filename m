Return-Path: <linux-kernel+bounces-787917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49DB37DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4981BA290B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4A3376B4;
	Wed, 27 Aug 2025 08:22:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A72ED175
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282925; cv=none; b=iGvMn6wTFgWHgMOGfH9r6AUenlzkbkFN/AZRccKLNggUFnPOOif9S8ENh+fNJ2r/BvP9Nn3Pt99kaiQbqCiJZGtWhoLwRLBdsH8o394lIqFNuateAmiqmsXx/5cCl1HLTfauX2WEP4tnkfH+7dSXaMZTWoLMZYmGK5n7UTiFHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282925; c=relaxed/simple;
	bh=h9JM+wigBt8MR0FO5WEIgeOUJyh1gEM8RDT0ogLjRJc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UNRoB4M9jsdqPx2qduq2N/svh/O2Nbd9XtNHfnFwssuQ7NIiD6Mz3jcAWG/rlX77H5szE4elB4htXOdrX8FoG0uIvLUto4OlJKSe/4uc2AL+IStScUh1JY1Qgh836B/OsEwKrqruWEdedfmhqfAjOMOjPk8P6ZMQCJkOQG0u2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e6766c3935so80064315ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756282922; x=1756887722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHN9JLtVG/Cs5rhkvGRKRizc/w5Jmj/8BZXp/ddNvvQ=;
        b=Bn9wneYjsLBK+BSu6vSdYR9zhyWiZ9DUneE06DW9h3DXyQjtLNn0bUlJsVwuLM/cAB
         0+fXZV8u67EvAh9cN3MeT+Ov0ExC4cYmLoTH6YrLnT3mNHTiispbI4FOW4qzWOi/KF+i
         rc/I5wxhIi1/pgYHUxa5XldrDHcWypCXBw0ereZlbRX+8C0UlW53+UK4jBlPwkMLE66a
         1Yl38RMMpcQyWuM4zbG67EuxyQZGSNsmr1CjQAhcfPlRcs56xp49wMBGwQixpuqa+HWX
         1igsUPtKhsxGpF+P1+NA6x+mY3bhBsdRNZRu6+hGFnk4Xr4meXtokDaIFNPEMdas12Mn
         LUYg==
X-Forwarded-Encrypted: i=1; AJvYcCWmkVFAgThj75bcGew/AKkgXa8sbhC1dTdJH1U+xMlvsv775qgjd9UAV5Tmj9ZTHEieqNnEFIYLeB+5GIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fpzaDo1hdVGCHePh/s9GphZO+Q/FZzS1He8uO2zLe9PfyepN
	sf3xJUbQsbdhpmbTXIjFODFCe2Q9ezv4eY8yhNOV2Oh7NXFu+43EzSEHcLxdZr6hIUq3t+JV6R7
	D64/t2r+zPdEvFFI5fYtX/Ddl9Ac45AiIp3DnHo8E8aOPQtkf+8rgCc9z7cg=
X-Google-Smtp-Source: AGHT+IGGYyJXbn6zWsod1hEo6RY3lQ2FR4+Psb5egYOXQZI7Y/rtlncLw+Sw6IEiU/a2SwpeZlI92o8OH2FelP4v44m4pvVCor0P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164e:b0:3ed:94a6:2edb with SMTP id
 e9e14a558f8ab-3ed94a63097mr103428905ab.21.1756282922622; Wed, 27 Aug 2025
 01:22:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 01:22:02 -0700
In-Reply-To: <20250827075711.5808-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aec02a.a70a0220.3cafd4.0016.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
From: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING: refcount bug in __xfrm_state_delete

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 24 at lib/refcount.c:28 refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Modules linked in:
CPU: 1 UID: 0 PID: 24 Comm: kworker/1:0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events xfrm_state_gc_task
RIP: 0010:refcount_warn_saturate+0x11a/0x1d0 lib/refcount.c:28
Code: 80 b1 e2 8b e8 77 4e bb fc 90 0f 0b 90 90 eb d7 e8 6b af f7 fc c6 05 81 7b c5 0a 01 90 48 c7 c7 e0 b1 e2 8b e8 57 4e bb fc 90 <0f> 0b 90 90 eb b7 e8 4b af f7 fc c6 05 5e 7b c5 0a 01 90 48 c7 c7
RSP: 0018:ffffc900001e7888 EFLAGS: 00010246
RAX: 516864998ccbad00 RBX: 0000000000000003 RCX: ffff88801d680000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffc900001e75a7 R09: 1ffff9200003ceb4
R10: dffffc0000000000 R11: fffff5200003ceb5 R12: dffffc0000000000
R13: ffff88802f119aa0 R14: ffff88802f1199e8 R15: ffff88802f119b90
FS:  0000000000000000(0000) GS:ffff888125d1a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055809cc3f950 CR3: 000000007eb98000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_sub_and_test include/linux/refcount.h:400 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 xfrm_state_put include/net/xfrm.h:928 [inline]
 __xfrm_state_delete+0xc73/0xde0 net/xfrm/xfrm_state.c:850
 xfrm_state_delete net/xfrm/xfrm_state.c:863 [inline]
 xfrm_state_gc_destroy net/xfrm/xfrm_state.c:618 [inline]
 xfrm_state_gc_task+0x532/0x6d0 net/xfrm/xfrm_state.c:635
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         24204116 Merge branch 'ipv6-sr-simplify-and-optimize-h..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13749462580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c49462580000


