Return-Path: <linux-kernel+bounces-823541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC64B86C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7435D62702C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721B2F83B3;
	Thu, 18 Sep 2025 19:56:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E425B301
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225365; cv=none; b=tHLKHwy9SUdyOFDA5NxH8MOOSPIz8wGURAfainijS01mf8rzuQA4RL1hzz0o2Zab3H4L8dI/WDlPOaXZmpvb1Mpq7YqeelRDJyhYjJrcRS8L6cFa051WpEuwF0vgIbske6cfa/O+9teiM6uCh528zYGyNWTQ5VyObcMMh9wEVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225365; c=relaxed/simple;
	bh=uEJ5rpoQRsf3231TzWULGSYRK0VjvaGvrl0bDigsSuQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dK1TPHdaRYRYTCjYwT+MeJBlUAi9Zzf1zApZe8mfC9DfKAgGWRfbLXuu9Pk8E5SK1F6kyCThiUdYk6b4JM5iw0ZYxBiDk7KJuz54M2yukP4Ic10/cw7loDnsCIR26XWAfQErdzacFcp19ez9DKcsHd4+rddrZcpXSAUmo/UjJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-424122ae369so28861455ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 12:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758225362; x=1758830162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGTx02BGOXxCMFqWgSyjzgGS4iq6EdbiUVb0K/VeaIs=;
        b=DUuwdQPhGXdjP4sK7JYL8H8AcNsVjC/AyOa+SBTD+P/YB2zO1Qm3QVFJTN8iaB2dln
         vFzaTLLyoiiQV99uiFUZ+InV4FROsgnHcWKCcOtSz19xfwR1ujHWeae79I21W93R+xG6
         PMDi4m91wxmrLN8acAjXt/f/IYmNz2dkd2vD9mLJnCNuNxPgdO8n8vE/b3Kpv9hwO/yl
         jTQEMEhzs85j+PLeKuXzFytqoBayMEM92MwUhCVzCmGsRd2MoH9cJF9QVvsZduSvmtcH
         PgTqRWfhzGSATk+6ajIgSP5cKKbHWVQNm013D+9y5MpvThXfhE7KT6sKvbj26+mgNjTG
         Ao0A==
X-Gm-Message-State: AOJu0YwSfiTQri5cCrNU6f3Z8PlAuVpWk07TmbiQM4HzyH4sM1/yvQMX
	IPdcR5PDpwUIGAb8FGykDh7Sumuvhnbta3XcUMVA+MHOOxwcYPc0HO40FEGotIU/uNq0KeJGztP
	xMrUEcr/5svivfdreDiQ9O2i4obI04XZKnOLeEN9ZQx8gBfRzmFYg5jYaOH0=
X-Google-Smtp-Source: AGHT+IGHkr5/IdNJ9LHH9Ldu9h5W/AFLcSmi9k/FA4qQs3UZ+ZmBzfl1OIpi8OlkdvKZIKT5A5F2NMItrTacKKd+loaM7Qx0t+yQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:40c:c955:b67d with SMTP id
 e9e14a558f8ab-42481995347mr13497665ab.28.1758225362677; Thu, 18 Sep 2025
 12:56:02 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:56:02 -0700
In-Reply-To: <20250918193455.115481-1-sidharthseela@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc63d2.a00a0220.37dadf.0005.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_hdr (3)
From: syzbot <syzbot+332bd4e9d148f11a87dc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sidharthseela@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ntfs_read_hdr

=====================================================
BUG: KMSAN: uninit-value in ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
BUG: KMSAN: uninit-value in ntfs_read_hdr+0xfcc/0x13e0 fs/ntfs3/dir.c:385
 ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
 ntfs_read_hdr+0xfcc/0x13e0 fs/ntfs3/dir.c:385
 ntfs_readdir+0xf21/0x1a30 fs/ntfs3/dir.c:496
 iterate_dir+0x452/0x620 fs/readdir.c:108
 __do_sys_getdents64 fs/readdir.c:410 [inline]
 __se_sys_getdents64+0x17e/0x550 fs/readdir.c:396
 __x64_sys_getdents64+0x97/0xe0 fs/readdir.c:396
 x64_sys_call+0x3a14/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:218
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4197 [inline]
 slab_alloc_node mm/slub.c:4240 [inline]
 kmem_cache_alloc_noprof+0x81b/0xec0 mm/slub.c:4247
 ntfs_lookup+0x60/0x410 fs/ntfs3/namei.c:71
 lookup_one_qstr_excl+0x23f/0x7a0 fs/namei.c:1697
 filename_create+0x2cb/0x590 fs/namei.c:4140
 do_linkat+0x1fb/0x1040 fs/namei.c:4908
 __do_sys_link fs/namei.c:4958 [inline]
 __se_sys_link fs/namei.c:4956 [inline]
 __x64_sys_link+0xd7/0x140 fs/namei.c:4956
 x64_sys_call+0x162f/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:87
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 6379 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
=====================================================


Tested on:

commit:         cbf658dd Merge tag 'net-6.17-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1430c0e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=332bd4e9d148f11a87dc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11383f62580000


