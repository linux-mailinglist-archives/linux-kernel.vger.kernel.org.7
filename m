Return-Path: <linux-kernel+bounces-894679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA8C4B955
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE74E45C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A83218AAF;
	Tue, 11 Nov 2025 06:02:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73D16EB42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840924; cv=none; b=Mod1w1978qG/xmbKeuqYALMMPP7f2oSN8XmXt1sKmcAAy1a4Y6t6tztNJQdCf7cu5PlO5pRl1yc/9zianauNzIlei3pnOBmAu2qvnXkJtT6EL/KMteza270OZsd91/kjBw8x9jQcyus65xS1jU8mMKnHvPHh0QypFxwPbLB0iQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840924; c=relaxed/simple;
	bh=I21XCKpynDsSOtEYjkjSZrJKz0++tPQI2/53zFx76lc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WfEg6wzrsEitiJ0wPhRlA6cp4FpflEox9Z/fUd0JmMY8bN/4n0GPVmq4PpU4aM51PXnuWsXSnRSuvrTOsy/GbtPVHgBoa07VvL499zhbLqszWOCVlV/HwjgLlNhcKJ2oIeujCePqI1hw1WTjpz/7N/1tKBCEwPCWnfGs4c8clQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4337e902d2bso19982375ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762840922; x=1763445722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBGZCy4jidFkA+nke8uw3qmxra/k4bxDc1sFkG0E/Fo=;
        b=hC353Jdb8N60nC3W5tNPqmP/lUTkEghyU5O7jy9+b/IjwHyJ+5LDfosnoTTP8v8fPL
         qf+EXYBeoET2ILIipqIG8K8pvupkpLSJX/d/tJmryg9x9LGSdjN75TFxwnwvHNB3w5dc
         Mf0AVyRgK3n/bJxu3KXYh2iy6LesiKmNmLiztsM/S+QZL4VB7ldglHFtYbiq/kKWoSN3
         UAMnLQzZcv9mwzVpXAOQr4eSlkuV7uq15KsizI2hGQZX2cs/Z6gj3r2cXebkZx7hcea9
         E0V7MOotTq40hA2Eh6340bIe29O5IN8pmY1vpYQFG/njESADldqIsKsPAphSVDds1Dzq
         IMzg==
X-Forwarded-Encrypted: i=1; AJvYcCV+BbjwJl4DkP+Set+JAuUhx14IV3ooVn6UdQKGqkWrvD13Vsc9jnmq+FHXXeNKbQ0XEkRmYZ9QhLM/MyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycxh/4zlTbz4fVYmi7HXYLT97tnar8NQ7WhajZ70OnfYmmSCKQ
	u/ecDs5QEV5pbiP6nTfdboDNnT8ALaWlzIkLzJIJ9ZzQueXpqwZFGSe3cyieMEzOGFrCTUK24dA
	TbejDNyUDZP5qwNv/MCcIW1aUcCGGNs6aY5QExkNXSkAH2IIQWabTklxcLRw=
X-Google-Smtp-Source: AGHT+IGUxunPALgsXL+nXAcuSe1FhhTbhOR3pgWENJbM3q6TjDEgfAtwnrI0/QI+SeXn4b4/kS4ZevRM3lHYZiRT08G7DtjCQPVQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0c:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-43367dead04mr167837075ab.12.1762840922123; Mon, 10 Nov 2025
 22:02:02 -0800 (PST)
Date: Mon, 10 Nov 2025 22:02:02 -0800
In-Reply-To: <20251111044000.2016410-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912d15a.a70a0220.22f260.0129.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_listxattr
From: syzbot <syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in ocfs2_listxattr

On-disk corruption discovered. Please run fsck.ocfs2 once the filesystem is unmounted.
OCFS2: File system is now read-only.
==================================================================
BUG: KASAN: use-after-free in ocfs2_xattr_get_type fs/ocfs2/ocfs2_fs.h:1114 [inline]
BUG: KASAN: use-after-free in ocfs2_xattr_list_entries fs/ocfs2/xattr.c:934 [inline]
BUG: KASAN: use-after-free in ocfs2_xattr_ibody_list fs/ocfs2/xattr.c:982 [inline]
BUG: KASAN: use-after-free in ocfs2_listxattr+0x408/0xa74 fs/ocfs2/xattr.c:1044
Read of size 1 at addr ffff0000e76a4007 by task syz.0.20/7236

CPU: 1 UID: 0 PID: 7236 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xa8/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 ocfs2_xattr_get_type fs/ocfs2/ocfs2_fs.h:1114 [inline]
 ocfs2_xattr_list_entries fs/ocfs2/xattr.c:934 [inline]
 ocfs2_xattr_ibody_list fs/ocfs2/xattr.c:982 [inline]
 ocfs2_listxattr+0x408/0xa74 fs/ocfs2/xattr.c:1044
 vfs_listxattr+0xc0/0x128 fs/xattr.c:493
 ovl_listxattr+0xd8/0x49c fs/overlayfs/xattrs.c:123
 vfs_listxattr fs/xattr.c:493 [inline]
 listxattr+0x10c/0x380 fs/xattr.c:924
 filename_listxattr fs/xattr.c:958 [inline]
 path_listxattrat+0x15c/0x33c fs/xattr.c:988
 __do_sys_listxattr fs/xattr.c:1001 [inline]
 __se_sys_listxattr fs/xattr.c:998 [inline]
 __arm64_sys_listxattr+0x84/0x98 fs/xattr.c:998
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x254 arch/arm64/kernel/entry-common.c:746
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:765
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffffb9581 pfn:0x1276a4
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 fffffdffc3a50548 fffffdffc39dab88 0000000000000000
raw: 0000000ffffb9581 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000e76a3f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000e76a3f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000e76a4000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff0000e76a4080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000e76a4100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         e424ed99 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12f30658580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1566f17c580000


