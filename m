Return-Path: <linux-kernel+bounces-890135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B1C3F4D0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E7E84ED302
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3962C326A;
	Fri,  7 Nov 2025 10:02:10 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5441E51EE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509729; cv=none; b=BPoGWfIdDTWeRV2lONEfPJZVb7wIhQIaX0PYOa+luVHa9pGU7SkLKYEEB9nR4Mqn0gqunrH5+EX79zJ+NXhcIJf9QrFU2wf+SFMTNE8tTM6KHM1yYENZ7pBHbwv1qNqfySKYyv004gCGgtUA5iF4CfjK57OPUlnccil961T0iVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509729; c=relaxed/simple;
	bh=AXoPaWwa8ffVqk2Zkke/0dlXQ1Oi+zDs/OLq3UQGh6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ayJtd6ifEjuoNCMZ16BtFWdR5nmgy1iwfNUUXz5e4Ih2TeQNfBiy5bfmhTsbUD93aWxvak5pawM7MidpBUmT181DNvlRX1IQ5ZplK2JmJt9YvHMdueqFoSrxLa7Ldh6QYlf3p8xmY3kGfbE5hDa3dHxjsuhNInRLcXh72nro1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-4332987de75so16166355ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509727; x=1763114527;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDveRKSshYf6kCEVOVLqSVKq5ABZtY5Meh/gvwhSx0E=;
        b=lZppS6zDgl4xsaI4r1xCG5qEfQ7jG+VUOao8KO1dkpluXOgr16mRVA54haoNXKr7vI
         WfyHI+0PN7g7bnMQwtq7BNDddOqeKFYgBMLwGDZP2gSvPzySHdtvGcLIFAIopRQX+WfC
         m3+OecdmEITBgER0NgolVdiPuchnW5BFlRxtHB7U9izke87E5gKyzHtrN8ZTiglLw8nQ
         KND/QqtOLkY2kgF6Jh1MWVuhDgVNlFRoGK2uDTW4gKS7+9amJ/EAWHXL26xwjv0zOh/6
         id96PLIX60qvU7TsrjcUMMSkBetGuPdmKzj8ZlX+8C23r5n4jCu3XrfXeBmvxyi2APnB
         25Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWyLF1W3VJXeMP6a7qvgGlKd/FwsiUyOl4Lt8hXO2KKy/t0l2F2xrPwLjoagYZhgcc6EUc4O3FoFiroWy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBq0WxK+VkH8dqWsHcdtmi8qFyCBwGJU7U0SHvueF6RVH30+d
	4lqb326cSNvaxD4BwsLttHSmmPiXZwsipa1pS3oMhK5t+AnuNzfil1VSeQxCWLN6Kn9jWFdJVDn
	yectLZVtqGetwhxyoN1r9jCfJ+rcUdTeDMUu5QhqJixOTO0aNvo1s7m4JSbs=
X-Google-Smtp-Source: AGHT+IH2TF2NA0RFSxK5mfyJKpEdaRibhB1Ptd85yj66t+jzErujuDzhPTfHsVzWGV4tHuYgAoM0nHhMnhA4RbU8iX+KXxrqfKmM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258d:b0:42f:8b0f:bad2 with SMTP id
 e9e14a558f8ab-4335f484de4mr41419075ab.10.1762509726989; Fri, 07 Nov 2025
 02:02:06 -0800 (PST)
Date: Fri, 07 Nov 2025 02:02:06 -0800
In-Reply-To: <e95c7d57-affe-430f-ae18-9c82aea9133d@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dc39e.a70a0220.22f260.0031.GAE@google.com>
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: yun.zhou@windriver.com
Cc: yun.zhou@windriver.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup: https://syzkaller.appspot.com/bug?extid=4d0a0feb49c5138cac46

can't find the dup bug

>
>
> On 11/7/25 15:29, syzbot wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    dcb6fa37fd7b Linux 6.18-rc3
>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1451a532580000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7fc112f7a4a0546731c5
>> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fc5812580000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110f3012580000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/ae6bec0d0398/disk-dcb6fa37.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/dcc732da66c3/vmlinux-dcb6fa37.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/301d1bbdecc2/Image-dcb6fa37.gz.xz
>> mounted in repro: https://storage.googleapis.com/syzbot-assets/94e5a8b9504e/mount_0.gz
>>    fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=1051a532580000)
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com
>>
>> Unable to handle kernel paging request at virtual address fbd5200000000021
>> KASAN: maybe wild-memory-access in range [0xdead000000000108-0xdead00000000010f]
>> Mem abort info:
>>    ESR = 0x0000000096000004
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x04: level 0 translation fault
>> Data abort info:
>>    ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>>    CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>    GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [fbd5200000000021] address between user and kernel address ranges
>> Internal error: Oops: 0000000096000004 [#1]  SMP
>> Modules linked in:
>> CPU: 0 UID: 0 PID: 100 Comm: jfsCommit Not tainted syzkaller #0 PREEMPT
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
>> pstate: 834000c5 (Nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
>> pc : __list_add_valid_or_report+0x3c/0x148 lib/list_debug.c:29
>> lr : __list_add_valid include/linux/list.h:96 [inline]
>> lr : __list_add include/linux/list.h:158 [inline]
>> lr : list_add include/linux/list.h:177 [inline]
>> lr : diUpdatePMap+0x4e8/0xb90 fs/jfs/jfs_imap.c:2831
>> sp : ffff800099e67b50
>> x29: ffff800099e67b50 x28: dfff800000000000 x27: 00000000c0000000
>> x26: 0000000000000000 x25: dead000000000100 x24: 1bd5a00000000021
>> x23: dfff800000000000 x22: dead000000000108 x21: ffff0000e21152f8
>> x20: ffff80009b403120 x19: dead000000000100 x18: 0000000000000000
>> x17: ffff80010ca0e000 x16: ffff800080536ef4 x15: ffff7000133ccf58
>> x14: 1ffff000133ccf58 x13: 0000000000000004 x12: ffffffffffffffff
>> x11: ffff7000133ccf58 x10: 0000000000ff0100 x9 : 0000000000000000
>> x8 : 0000000000000000 x7 : ffff800081c11594 x6 : 0000000000000000
>> x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008053700c
>> x2 : dead000000000100 x1 : ffff80009b403120 x0 : ffff0000e21152f8
>> Call trace:
>>   __list_add_valid_or_report+0x3c/0x148 lib/list_debug.c:29 (P)
>>   __list_add_valid include/linux/list.h:96 [inline]
>>   __list_add include/linux/list.h:158 [inline]
>>   list_add include/linux/list.h:177 [inline]
>>   diUpdatePMap+0x4e8/0xb90 fs/jfs/jfs_imap.c:2831
>>   txUpdateMap+0x708/0x8d0 fs/jfs/jfs_txnmgr.c:2357
>>   txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
>>   jfs_lazycommit+0x394/0x94c fs/jfs/jfs_txnmgr.c:2734
>>   kthread+0x5fc/0x75c kernel/kthread.c:463
>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:844
>> Code: aa0103f4 d343fed8 f2fbfff7 aa0003f5 (38776b08)
>> ---[ end trace 0000000000000000 ]---
>> ----------------
>> Code disassembly (best guess):
>>     0:   aa0103f4        mov     x20, x1
>>     4:   d343fed8        lsr     x24, x22, #3
>>     8:   f2fbfff7        movk    x23, #0xdfff, lsl #48
>>     c:   aa0003f5        mov     x21, x0
>> * 10:   38776b08        ldrb    w8, [x24, x23] <-- trapping instruction
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup
>>
>> --
>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
>> To view this discussion visit https://groups.google.com/d/msgid/syzkaller-bugs/690d9fd4.a70a0220.22f260.0022.GAE%40google.com.
>

