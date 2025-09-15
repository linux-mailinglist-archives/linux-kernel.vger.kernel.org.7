Return-Path: <linux-kernel+bounces-817690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E4B5856C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3265A1B22506
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D166C285C81;
	Mon, 15 Sep 2025 19:39:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86521578D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965146; cv=none; b=Jp6NriOzAlqFYpKP3vKRbh+j5fTqoWggQm48xp8g4P6G139+k/bm7OyVgyBh75zdt/aQp57liSELTvdkWUWwSHAdfoAwV2cvH2JtqmUWxPL1pU7Cu7vC0jdFpM9gcyQ2Rim90qHBpe7oL4aEmOIuyu+s8x3ZhI5h5KupDa0a02E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965146; c=relaxed/simple;
	bh=9WZ8MoUVfCwiW6ydom+lKoaSODl3PXPFo1/2IFAj+v0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pk8jBEQw0SUHI9MwP0ixahG+f6E9revIK6QjMmfsxiMdDpm6dDnHymgumDl/KsQrpJ75FpXifHm7u4/e57k5hUbkdfSBeXw2NPjs8aLc0T/h3aMoqdGoOEqnLpiZkUV78TyLSRT0uwalDwud2bGXlxgkddEswfO3fMu0iDDEGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3f736aa339aso129370885ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965144; x=1758569944;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WZ8MoUVfCwiW6ydom+lKoaSODl3PXPFo1/2IFAj+v0=;
        b=K4MsKLwC5EO3Y8Vnuly7+SSCTioj8J+QuOtsEFf7xF4Oc20RQBhGpfiWg9ERC9YcIK
         1cZuMOguK7E5rdivSlvQOvDR0NzgQD3zsYNSDwsreaATfNNCSuvoyNAhlT//UkFsv5qR
         jk/S6GGCF4eqzxS3+GuwA+BAO5h41nrlfSh+haId8XNPEZixSSrJpErXGeuq5mt7rhVG
         IY0f436GA9H6dcZXJpKjOLM9tr3+jhWOl/Wf2XqskVV7JU3pgx//NVZL21J5son3a7zl
         Hr8mHrtmHPBIhgnY9M7EjVqWy+l0c9FnT27l1Jc7i4ncC/y+pyGxE0mUJB7WuDzlU3uP
         sRsw==
X-Forwarded-Encrypted: i=1; AJvYcCWWI28tnoR/nitvJ4TjaUbtBhseofszeNS7A4AJPEo0XyGxcoygTIGih8VpVxUcZwfwUu0m6fS2zwKVFZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALSzAx6QsD03Utd5ZW3XjDMn4j9TZzPLqRDaKGPPCUiIIzWWe
	MYQVqg8MZOFzOm9WJ3kviV1H7/2A7kyDHbTRwcEYzefQWkaeoWDoCOxhbkdAwmoCN1FHS+Bkbdr
	T99MyPXFHdRCAAvCAkOYLJyqmYpOHRUnrMIlmqef5rruLfIB2jryI6jI3hwE=
X-Google-Smtp-Source: AGHT+IGcZP9eFGHRfO+CEySg83Nho3DhZlFvIHUWI3wIr3YAoDMzF7qiqbZN0kpLhVSgSwDmAxMRPrWEYieRonVy4auq5zGWW+Kl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:424:7e6:a73d with SMTP id
 e9e14a558f8ab-42407e6a905mr32314145ab.27.1757965143963; Mon, 15 Sep 2025
 12:39:03 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:39:03 -0700
In-Reply-To: <1ea1efd9-4c9d-4432-82b7-f8998bd4e421@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c86b57.050a0220.2ff435.03a9.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: yanjun.zhu@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test:https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_=
one

unknown command "test:https://github.com/zhuyj/linux.git"

>
>
> On 9/15/25 12:16 PM, Yanjun.Zhu wrote:
>> #syz test:https://github.com/zhuyj/linux.git=20
>> v6.17_fix_gid_table_release_one
>>
>>
>> On 9/15/25 12:07 PM, syzbot wrote:
>>>> #syz test:https://github.com/zhuyj/linux.git=20
>>>> v6.17_fix_gid_table_release_one
>>> unknown command "test:https://github.com/zhuyj/linux.git"
>>>
>>>> On 9/12/25 3:04 PM, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot has tested the proposed patch but the reproducer is still=20
>>>>> triggering an issue:
>>>>> WARNING in gid_table_release_one
>>>>>
>>>>> ------------[ cut here ]------------
>>>>> GID entry ref leak for dev syz1 index 2 ref=3D445
>>>>> WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809=20
>>>>> release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>>>>> WARNING: CPU: 1 PID: 1088 at drivers/infiniband/core/cache.c:809=20
>>>>> gid_table_release_one+0x346/0x4d0 drivers/infiniband/core/cache.c:886
>>>>> Modules linked in:
>>>>> CPU: 1 UID: 0 PID: 1088 Comm: kworker/u8:5 Not tainted syzkaller #0=
=20
>>>>> PREEMPT(full)
>>>>> Hardware name: Google Google Compute Engine/Google Compute Engine,=20
>>>>> BIOS Google 08/18/2025
>>>>> Workqueue: ib-unreg-wq ib_unregister_work
>>>>> RIP: 0010:release_gid_table drivers/infiniband/core/cache.c:806=20
>>>>> [inline]
>>>>> RIP: 0010:gid_table_release_one+0x346/0x4d0=20
>>>>> drivers/infiniband/core/cache.c:886
>>>>> Code: e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 3d=20
>>>>> 41 8b 0e 48 c7 c7 00 46 71 8c 4c 89 e6 44 89 fa e8 3b a5 fa f8 90=20
>>>>> <0f> 0b 90 90 e9 e3 fe ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c
>>>>> RSP: 0018:ffffc90003d0f908 EFLAGS: 00010246
>>>>> RAX: 11007f8b953ea200 RBX: ffff88802d562cd8 RCX: ffff888026adda00
>>>>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
>>>>> RBP: 1ffff11005aac59b R08: ffff8880b8724253 R09: 1ffff110170e484a
>>>>> R10: dffffc0000000000 R11: ffffed10170e484b R12: ffff888028265480
>>>>> R13: ffff88802d562c00 R14: ffff8880779b1800 R15: 0000000000000002
>>>>> FS:=C2=A0 0000000000000000(0000) GS:ffff888125d16000(0000)=20
>>>>> knlGS:0000000000000000
>>>>> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: 0000200000000240 CR3: 000000007612e000 CR4: 00000000003526f0
>>>>> Call Trace:
>>>>> =C2=A0=C2=A0 <TASK>
>>>>> =C2=A0=C2=A0 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/dev=
ice.c:509
>>>>> =C2=A0=C2=A0 device_release+0x99/0x1c0 drivers/base/core.c:-1
>>>>> =C2=A0=C2=A0 kobject_cleanup lib/kobject.c:689 [inline]
>>>>> =C2=A0=C2=A0 kobject_release lib/kobject.c:720 [inline]
>>>>> =C2=A0=C2=A0 kref_put include/linux/kref.h:65 [inline]
>>>>> =C2=A0=C2=A0 kobject_put+0x22b/0x480 lib/kobject.c:737
>>>>> =C2=A0=C2=A0 process_one_work kernel/workqueue.c:3236 [inline]
>>>>> =C2=A0=C2=A0 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:=
3319
>>>>> =C2=A0=C2=A0 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>>>>> =C2=A0=C2=A0 kthread+0x70e/0x8a0 kernel/kthread.c:463
>>>>> =C2=A0=C2=A0 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:148
>>>>> =C2=A0=C2=A0 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:24=
5
>>>>> =C2=A0=C2=A0 </TASK>
>>>>>
>>>>>
>>>>> Tested on:
>>>>>
>>>>> commit:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dd87fd3f RDMA=
/rxe: Add logs to find out the root cause
>>>>> git tree:https://github.com/zhuyj/linux.git=20
>>>>> v6.17_fix_gid_table_release_one
>>>>> console=20
>>>>> output:https://syzkaller.appspot.com/x/log.txt?x=3D144a9934580000
>>>>> kernel=20
>>>>> config:https://syzkaller.appspot.com/x/.config?x=3D4239c29711f936f
>>>>> dashboard=20
>>>>> link:https://syzkaller.appspot.com/bug?extid=3Db0da83a6c0e2e2bddbd4
>>>>> compiler:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debian clang version 20=
.1.8=20
>>>>> (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian=20
>>>>> LLD 20.1.8
>>>>>
>>>>> Note: no patches were applied.

