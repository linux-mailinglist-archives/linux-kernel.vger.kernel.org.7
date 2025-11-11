Return-Path: <linux-kernel+bounces-894776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A67C4C03B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE4F34B0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B1C34BA49;
	Tue, 11 Nov 2025 07:09:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892434B674
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844948; cv=none; b=XsUuZcGRXgeaC9WLGyWGfJrJnaPD/oxX9nqitxM4g6Fy7Zjl8GGymT4dM33GLaSCzds7FP6e3OtsOWv/heqVMVyF/aM1OX7x4dcBcD+GwqaANo812Z53kU4Tc8xeGnI4YWV6DmMjKGtDOsv/8mUFD92JbjSxobcXCu4PFbHSmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844948; c=relaxed/simple;
	bh=XwXzqXI8bhdXx1oRf8ye3YACiG5g3YyErnJSjQeCXf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gb4FOJeD3yZQBQ46IOen/oeE9yGBt23W6mEsyDcGE3AFJHTrAPkn6EV47xpeUE/63vOlWLi8Yr7XO+vlUGYw0XQ+g+8tiMpg4gB+ZBFDE+u6lZhwiS4114q+4KREZ+zrt4OEZfsBx+wSxOJ1BzALhJIDqpUAKSB+cBVfIQvPGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so488625539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762844942; x=1763449742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpbJkiENbLIIWyNtSXvXiGrQVhBQmL8F0csL5vJzrn0=;
        b=rsBttvcPmps9C5OeORwDQJuZt253sOF17nyMIxEdAA+w7EEx9IluuCDeQc7PYteAGb
         ByKd7lFXds6GiIrSNcpZBy77eRDJBrhD3A6nM9HmHM9D21PxQk0KYx7LS7VQ+XTaQGci
         yWzTc7R8trvCjrD8s9DF0/acPV4ASc2NK0cAh7cyKc14scRyhQMU6zcEMoqHzSb4MAj3
         cd6nL2nZZZdW/XtULNB2TroQpIJWRQ7cvzdrUM+o/VO4XsA2EjUhe4/k8OroER1qYxJ0
         k5ZG8NGcVFJFXRZuOwJm/+kLESTLCNVFQCSNk5KidU89Kt3hgrwtuE4aETzJWNeNHDF9
         8+pg==
X-Forwarded-Encrypted: i=1; AJvYcCUqbWsqByINF21sfLow+JSWHj+8ph63fefd4Tn1Z3PpjaCLcvPZC+tSc/QCH1Is302GnJkpfoxmk5fbLFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZj9Yty4/v83+YmHw6QPFEfZ8hMYNu72Cs4VVxT92UkAQNDx/
	MZLBVt2JOmGpQWfxlMxSVA8hL2XcETo8LlrmDaSkxxtZl1p4YtyZcd+cEGID+/MuCJhUR68ZGo1
	bIyqEV7ynphJv7Bb+ZtDKIMugVrIaOXpeVXNHeWi9kShnIRwtHesauuc8Kcs=
X-Google-Smtp-Source: AGHT+IEXNqlsVF2mjDJHw/ztVvp9Q7I3qi7fpJAIVw7FcPsauDPduBXaZLVlTls1xeX+HtMrJv8xUxVluSpD+S8usk/sVevmX+Ff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce85:0:b0:433:68ab:e2a with SMTP id
 e9e14a558f8ab-43368ab0ee1mr122621105ab.23.1762844942334; Mon, 10 Nov 2025
 23:09:02 -0800 (PST)
Date: Mon, 10 Nov 2025 23:09:02 -0800
In-Reply-To: <20251111060615.2022366-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912e10e.a70a0220.22f260.012d.GAE@google.com>
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
BUG: KASAN: use-after-free in ocfs2_xattr_list_entries fs/ocfs2/xattr.c:950 [inline]
BUG: KASAN: use-after-free in ocfs2_xattr_ibody_list fs/ocfs2/xattr.c:998 [inline]
BUG: KASAN: use-after-free in ocfs2_listxattr+0x408/0xa74 fs/ocfs2/xattr.c:1060
Read of size 1 at addr ffff0000ea596007 by task syz.0.17/7218

CPU: 1 UID: 0 PID: 7218 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT 
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
 ocfs2_xattr_list_entries fs/ocfs2/xattr.c:950 [inline]
 ocfs2_xattr_ibody_list fs/ocfs2/xattr.c:998 [inline]
 ocfs2_listxattr+0x408/0xa74 fs/ocfs2/xattr.c:1060
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
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffffa3920 pfn:0x12a596
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 fffffdffc39b8408 fffffdffc3a3f9c8 0000000000000000
raw: 0000000ffffa3920 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000ea595f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000ea595f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff0000ea596000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff0000ea596080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff0000ea596100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


Tested on:

commit:         e424ed99 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1594b0b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c80692580000


