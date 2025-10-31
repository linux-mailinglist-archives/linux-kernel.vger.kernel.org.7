Return-Path: <linux-kernel+bounces-880822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1980C26A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32431A65876
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB628643D;
	Fri, 31 Oct 2025 18:54:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9332222A0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761936845; cv=none; b=guM3IAbTPE+SnoEnOmqu9FLC9Vuz8KoFbEPVZj1SBHhih412gcFJSMgI/FJnzFpru5b7Onlw0Hg9zTFxdvmVSEn4KTbf40pwCmbbYoRFVma331zhe2S1nYbMgzpQ6xXJ9VwIlVlDECISmB5+oiSU7XlCJXLcS+UrNLXWtgNFi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761936845; c=relaxed/simple;
	bh=6hTvjPn2qj2Czqpl/P0InLA1sDEw6gSHFKsQ4rJyaA0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NZjUWX5RFgGLBw0bUkz2cc/1IIvYaNhSPUcntI34n94fY+uZ/HNI4t7K0pqEmH1Z7immVhlRmJYuQLcVYVNfPaFB45HFYFjWUB9nqHHGohASkEVQgC1/n86WIYSpwr+lX2vvaKV4BTwiQJtajePzGkwoLULq4m89oMKFObaCRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43300d247e4so26779695ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761936843; x=1762541643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeLkwpJWmQpNkSZGJ/VPIpyPL1imhY8aGMuuXJci8As=;
        b=MSnuevTYO95T0CKmdVxFBs1ZNtzenyuWyLZoOVRGKt1Vo1z1g16aftBxZpPwvvusaV
         aJpIh4dXFt4wxz26RsxKsHR8GSvXkglYVMgVZ3sNviI+LxFqG+E0olKCCd7vVpIZSMJq
         TWbO6CR1utLjTaIRn/6NP15c20RUzX8wnKP5XqCS+tUnP1fwGD/no3bZ0Jl8WJRzpgOD
         MwrPfjR/ofbFr2NNviNl1lRDOTeQrbw1UCjLnFQXRlBOPsuLFFR4A8haj2adgfsMMCek
         WSrJnPOC1t/DNVh8kLNOFLsQ7NEJz5BhR09ou4an409/HjHJUU9in6gCv+tcAI+Q3HSW
         oXUA==
X-Gm-Message-State: AOJu0YxaKL1YEhLbuGT9m51CpOoeeyT+DWVb3U6bkqdb++zGbnppwKMD
	0VB05C/YtbMtNPyH+jF1Cky9fuqFOuS4FdVKeC5UC4PlDa9dg7s2hahPDDfGgjt/Nn7VEeJoDBT
	3ekJlICJ9V7PAfhBfY2lqfmU1CJuirmDAXpe2rK47b8F+bZeYdgyWSqC/fZs=
X-Google-Smtp-Source: AGHT+IE7cUCu5stietaocKy6dBRUv86BGgEA1FsSiFWRJGkXuPCu6Unq5fVZPYQcekUliO7H8GX205wDfq7dVIJtBZtHz94ZWjXb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f01:b0:430:ae26:7c28 with SMTP id
 e9e14a558f8ab-4330d143850mr75829565ab.1.1761936842839; Fri, 31 Oct 2025
 11:54:02 -0700 (PDT)
Date: Fri, 31 Oct 2025 11:54:02 -0700
In-Reply-To: <aQTg3jUfRB9cCBv2@orbyte.nwl.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690505ca.a70a0220.1e08cc.0029.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in __nf_unregister_net_hook (9)
From: syzbot <syzbot+78ac1e46d2966eb70fda@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, phil@nwl.cc, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in nf_hook_entry_head

------------[ cut here ]------------
WARNING: CPU: 1 PID: 13 at net/netfilter/core.c:329 nf_hook_entry_head+0x23e/0x2c0 net/netfilter/core.c:329
Modules linked in:
CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Workqueue: netns cleanup_net
RIP: 0010:nf_hook_entry_head+0x23e/0x2c0 net/netfilter/core.c:329
Code: 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 4d a5 b6 f8 4d 39 37 74 36 e8 23 f0 50 f8 90 <0f> 0b 90 31 db 48 89 d8 5b 41 5e 41 5f 5d e9 3f 00 da 01 cc e8 09
RSP: 0018:ffffc90000127768 EFLAGS: 00010293
RAX: ffffffff896f140b RBX: ffff888031eda000 RCX: ffff88801caa0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88801caa0000 R09: 0000000000000006
R10: 000000000000000a R11: 0000000000000000 R12: ffff8880742e8000
R13: 0000000000000005 R14: ffff8880742e8000 R15: ffff888031eda108
FS:  0000000000000000(0000) GS:ffff88812623e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555728d3588 CR3: 0000000026f40000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __nf_unregister_net_hook+0x74/0x700 net/netfilter/core.c:491
 nft_unregister_flowtable_ops net/netfilter/nf_tables_api.c:8977 [inline]
 __nft_unregister_flowtable_net_hooks net/netfilter/nf_tables_api.c:8992 [inline]
 __nft_release_hook+0x180/0x350 net/netfilter/nf_tables_api.c:11985
 __nft_release_hooks net/netfilter/nf_tables_api.c:11999 [inline]
 nf_tables_pre_exit_net+0xa7/0x110 net/netfilter/nf_tables_api.c:12150
 ops_pre_exit_list net/core/net_namespace.c:161 [inline]
 ops_undo_list+0x187/0x990 net/core/net_namespace.c:234
 cleanup_net+0x4d8/0x820 net/core/net_namespace.c:696
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         1a2352ad Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1557d932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=810aeb811fb1cca1
dashboard link: https://syzkaller.appspot.com/bug?extid=78ac1e46d2966eb70fda
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

