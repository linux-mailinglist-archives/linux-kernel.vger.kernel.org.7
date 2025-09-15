Return-Path: <linux-kernel+bounces-817833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312FFB5873A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D952F2A3400
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05542C0278;
	Mon, 15 Sep 2025 22:14:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096B323957D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974445; cv=none; b=Yey5vKUHKEU9y+68N1xu9m29zObYm6PCqlz/67Q2HeQV+LSds5BDJsx2N7e1Zq4muVaRQtqhve2uhC+ozJ2yCD0BeVX+BzjB5M1t0OugnhD8NPuHV3BnnZnqqXfO97PmCHEKh3Kfdmm+D/sDuWdZtcONHq7CdW1QyWtmEqBw7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974445; c=relaxed/simple;
	bh=ltl18Mdg91TfXlhKUBDahgzBwh4WPULipQl1FHomFZk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cSDoEhIuSmhzRN8guIL5ss9mopAHNjBWe1ofrLq9oUD6s6OEzko82EkDEeoQGr+4TDwcK3vp3/ndQhrWpfcz3/yDzHBJ0y4AVzAz6Dz2V7gyuAjOzostkUwIqhlOmOjxjT4Zx1FrRe34Qmq0TilLHCGPKfY3jxGsMwYGGhggGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-89395ddf099so146347239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974443; x=1758579243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lER89BDVnERxRaY3zEFnJCZycfYUkLMHZPmwlu+YyjA=;
        b=rk4SGO5c9jL5cchKdza7SASqOGH9Cse+GKMgzMEtR5X6a1wQSqiKMZE5zi7zXlj+vd
         Xzaiuggm8dwLOtuvMQOMRsA74MEjI9DfP1FLulUUt0oH1NFNXbRFdbO7V3vqAY603pIA
         APMlTjVUClweBJPTgBgjvrT057a2Vbks7WKBYl+iVXRvU66RJWhC8o3yjPPTKY3llhgY
         HxwLfoRb0yJXOpa7p8Qk3RLHP3p6docNSNecY+cJ7/uPo4cWoySTZpRQa880kox2D6wB
         uumGJDx3O4DJAMJ7BvuhM7y0v888cKAOsjkNDbmb6dBC7179Yux/CwwePIx4s0BSOTYk
         e+JA==
X-Gm-Message-State: AOJu0YxpI4EA0BwGlo8EnoFiiD5XynmjV1deL+WtNuT8o1ixZ4LJ6Kv8
	m26YbmP8i9W13QLN7Fu40uvmWiQe2Zlut7gNR+/OVCy2C88oy4fU31W8ooJghh36bCOd9ow2shO
	b/Kf3U2RFK2evJS/xZDM5176I740o16m1i5lawA6wrDP1YmvxhaEiJRg9i5I=
X-Google-Smtp-Source: AGHT+IE9cORsrS5e8Ei+NlZLKmqf5vyufhTDS0UHOdefQs5uQdM33hI2z4ZKE9UzHaOlNuEut0TfwhCljJbg1k2BWWnaHhuBObLN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36ce:b0:889:b536:779b with SMTP id
 ca18e2360f4ac-8903378d714mr1619083339f.7.1757974443142; Mon, 15 Sep 2025
 15:14:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:14:03 -0700
In-Reply-To: <e50a6a79-6c0c-4313-a09e-a69d8456b202@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c88fab.050a0220.2ff435.03b2.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in gid_table_release_one

------------[ cut here ]------------
GID entry ref leak for dev syz1 index 2 ref=468
WARNING: CPU: 0 PID: 1038 at drivers/infiniband/core/cache.c:811 release_gid_table drivers/infiniband/core/cache.c:808 [inline]
WARNING: CPU: 0 PID: 1038 at drivers/infiniband/core/cache.c:811 gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:888
Modules linked in:
CPU: 0 UID: 0 PID: 1038 Comm: kworker/u8:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: ib-unreg-wq ib_unregister_work
RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:808 [inline]
RIP: 0010:gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:888
Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d 41 8b 0e 48 c7 c7 00 4b 71 8c 4c 89 e6 44 89 fa e8 2b 82 fa f8 90 <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc90003aaf908 EFLAGS: 00010246
RAX: d857da1c4d948b00 RBX: ffff88807e2b14d8 RCX: ffff8880265b5a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 1ffff1100fc5629b R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa24c R12: ffff888027d6d8e0
R13: ffff88807e2b1400 R14: ffff888025ba0100 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff888125c16000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe16e9d7dac CR3: 000000000df36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
 device_release+0x9c/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


Tested on:

commit:         3a2493fa RDMA/rxe: Add logs to find out the root cause
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=1662547c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.

