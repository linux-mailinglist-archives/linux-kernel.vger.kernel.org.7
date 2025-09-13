Return-Path: <linux-kernel+bounces-815003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D7AB55DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 04:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9C565BE6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CA81B4248;
	Sat, 13 Sep 2025 02:48:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E7A927
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757731686; cv=none; b=HTIwz5btParlycPFrTFQ6V1QAuPdpH5fuQg8PX27CnPqqpzi6+rbS2xSeJY7MQdOg5ggbEQs56JAuKNPLIqbWolHeFr8VEK7cfft4Nfnk36leHRixE1iPgqP4PFO/VurdTuVd0bvR9q9yIHaxwud+VW7FJqnFfGUTY28d0ArKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757731686; c=relaxed/simple;
	bh=p5p8YjdcT5chy807qIS4Su+o5uz6+R7AuqsMpjKZaaI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sHTuf2mVvZ2D0hLohxW7brG/Ns8CFG9Uu+enkk6Zg41nK/rda5YcfeKes/eg93cTzRjEnZZIPB/GFBeIYkqxiIt8BVPmyj8pU4Ymf8QtWcfMJb83OGzxf8dZcVhx+ciw2QVdcM/wpIqMqJyER1IlLcR4A7KhJsw0LmuI7uAHnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-406d2dab9b0so36283805ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757731684; x=1758336484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=blHSYevcFfXqjbcA1ip7wQWCgKXamj6MK+hm6awZujs=;
        b=QxEnRfEYAUO+omnpLF80bO/cOfWUkrN2TaMYql2mY60nyo4hWSK2gjMtlJLzsYNOky
         MKtmQQweu0n1iwJgT5p3ucI6pBav8rPYy3tmREom1vpQTgUwjYIljXUKV+NCLbSV0u62
         +YaBV3iCQRz/9UzyLqtv76v4tgj594ujSauaLIL7k3XxuaPrFzgXNGJD5csX1B8B622J
         6NvM+c8dRL7HAC6NHD6KNQ0I6l8g+9/zq769R0O+78bmeRDhq7piEPuSF+bPDz7D6IBX
         s1NqoJsgA30V4Zyl/rAMuvyQ6QACIWca7FmTlhaRg9mlgSuqGWnUaV2hTAx+zyE8svb4
         IklQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9/KGD71EPM8wOrLymK0SdH4I87iCcuCW+SPPevYQVhAKSfFolA0nui/Tw9sPYbbPwilsd/BXYYJawPsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1BSkckXxta9V0ul3SdgIdztMrpfEgG5IcriWFkCjar9+NlT8P
	HfwsO3b6VjWa4mF3+FsTsUEwFrjHiE3/WV6g+S5PTYTbJaX6m1VKtkK7gHHwgsXFEFpO2EQX2a2
	cMijSPNm7SLBHB+E5McrSQUcMH8XEBS4FbmyEj39V79f0t5zBxRe908/5aA8=
X-Google-Smtp-Source: AGHT+IEa2jLIAbgrMnuH/2RPmOOPQsA/VMNCbMEzuCCh4/6JFqU4mnkNlOl3RfBw7ImaR6XaOZ8kpiYL5fxuMmPu1Wti6as2ruwc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:423:9063:f1e8 with SMTP id
 e9e14a558f8ab-4239063f364mr17482375ab.0.1757731684404; Fri, 12 Sep 2025
 19:48:04 -0700 (PDT)
Date: Fri, 12 Sep 2025 19:48:04 -0700
In-Reply-To: <20250913012512.6904-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c4db64.050a0220.2ff435.036a.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=452
WARNING: drivers/infiniband/core/cache.c:809 at release_gid_table drivers/infiniband/core/cache.c:806 [inline], CPU#1: kworker/u8:6/2125
WARNING: drivers/infiniband/core/cache.c:809 at gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886, CPU#1: kworker/u8:6/2125
Modules linked in:
CPU: 1 UID: 0 PID: 2125 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 a0 56 91 8c 4c 89 e6 44 89 fa e8 7b a8 f4 f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc900050a7908 EFLAGS: 00010246
RAX: aa4d2ac68a741700 RBX: ffff888075471cd8 RCX: ffff888029ac9e40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100ea8e39b R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1c3a6c8 R12: ffff888028a5fe20
R13: ffff888075471c00 R14: ffff8880291e4000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125ae8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556a47588 CR3: 000000007a4a8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xda/0x1d0 drivers/infiniband/core/device.c:510
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3263 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         590b221e Add linux-next specific files for 20250912
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16939934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12a1d1f3a8199632
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12a76b62580000


