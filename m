Return-Path: <linux-kernel+bounces-868584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56364C058E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC1C3A87FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D8830F927;
	Fri, 24 Oct 2025 10:22:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EB2F7AD3
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301326; cv=none; b=SMZ5g4KADHy8Ppx6WZ+xig43iZdPIc1eSgJ/banva0FreQNZ7YgLMQutjV2DnwZvusXfqJ34KQBvvIdTwXseOk9P7bDVPRSwYUmTVw5SGC3AnIl7Vpz/Y6+J8r4wdIifz1gelWRarxbkXs83F90sj6lzxCgTBJIMxyDQluBx89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301326; c=relaxed/simple;
	bh=CrFKdpZ+nCGu6QZV8Xice9FdNitkGbaG+BcLW2qlD2c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BvG9A8Poq7SE7OlzK3qh2LucpRV51/8QpoAOxEb/ErNDcH9ZZ6dcdhiNCffjHJC5naxgQhb50aqc4p4v42wOkqYD8RvxD8gOmhu4IZFI/QjoQxr9hIKsKJPXAiQgWcmkHZolwp2zA81Ye2cj6ljkVHIDWsQ9qumYOSGYMkszwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-940dbc45bc3so168888839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301324; x=1761906124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=facOez+QkReLZfXLtqNPhFyDd9EzwmWbmRX5wALEyco=;
        b=SH49oonoRywpALSu50F2n9T51lujUlfjUehgorzGDy1XePwSmB96x7Tb/z/lSD36TM
         o0p86AOdtUFqjKlofb3QlZ/rIoIiY24ZD+m32ObZq2o9pzGGrq2guP0s9X5xux7FQvJ8
         iApeWPaNFln6dDazgQajo7cgq0WPOG7sxbwY2oysfJ3wx09QrmWnMEjj1RiU8ZZV/X7S
         Rs8lqUlqUZ1m2fInespGp0EdU4IqZOLKQ0eY5fjO79uU7xFUVxNwFvQMLASqmCW8qbnC
         1AGmYt/0O9LfHCslOWN5c2NSxuCCG4TcnAjZyst42MO+JGMLcbOYAExbrVgjN6sWvMRu
         lfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtc2V8HXx9sUs670S4mUWEG9UYxHtIUINPT5d8YmhGQWmLeJBYrswS5xzJZ7aLWoSSOi6hBoS1cHyx3n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUfjnRWs42+0fq/jFoiMC+R+xJYTwwkyDH89TN8OW3ujZuDC9
	Chex/wPpnFqh5H+FgXAhOXVsQvcFNngqI2GdfO2QOzUb1oYwyrUVoRWrUKMVKYdY7LxZDLyWi5l
	K0hVzNrewM3FaPBNgaWx6fFCDdYAb0uD7ezLtM41G2AFPAhMAJS9vk45XIXc=
X-Google-Smtp-Source: AGHT+IHMAiSxIYwTye+tYfMz/5XQPuSIO363rUaIkfFQOca323tJvQjK7daRpuoH+upgldpOwZ/xdX5dMPaneXVpUcMLlIgOpJAu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1847:b0:425:744b:52d3 with SMTP id
 e9e14a558f8ab-431ebe04162mr22226805ab.11.1761301323907; Fri, 24 Oct 2025
 03:22:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:22:03 -0700
In-Reply-To: <20251024071522.EtAA6%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb534b.050a0220.346f24.00bd.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extents_range
From: syzbot <syzbot+f2107d999290b8166267@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
kernel BUG in __ocfs2_move_extents_range

ocfs2: Mounting device (7,0) on (node local, slot 0) with writeback data mode.
------------[ cut here ]------------
kernel BUG at fs/ocfs2/suballoc.c:1363!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 5427 Comm: syz.0.17 Not tainted syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/30/2025
pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
pc : ocfs2_block_group_set_bits+0x510/0x6c4 fs/ocfs2/suballoc.c:1363
lr : ocfs2_block_group_set_bits+0x510/0x6c4 fs/ocfs2/suballoc.c:1363
sp : ffffffc0216171e0
x29: ffffffc021617260 x28: ffffffb8042c2e7c x27: ffffff80df71a740
x26: 0000000000000002 x25: ffffff80e53bc00c x24: ffffff80f209cfb8
x23: dfffffc000000000 x22: 0000000000000168 x21: 0000000000000001
x20: 1ffffff8042c2e40 x19: ffffff80e53bc000 x18: ffffffc011b0fe20
x17: 1ffffff033e18d7e x16: ffffffc0082d0900 x15: 0000000000000000
x14: 00000000fffffffc x13: 0000000000ff0100 x12: 0000000000ff0100
x11: ff00004009c64374 x10: 0000000000000000 x9 : ffffffc009c64374
x8 : ffffff80d06f5340 x7 : 0000000000000000 x6 : ffffffc008dc3fcc
x5 : 0000000000000168 x4 : 0000000000000001 x3 : ffffff80df71a740
x2 : ffffff80e53bc000 x1 : 0000000000000002 x0 : 0000000000000168
Call trace:
 ocfs2_block_group_set_bits+0x510/0x6c4 fs/ocfs2/suballoc.c:1363
 ocfs2_move_extent fs/ocfs2/move_extents.c:693 [inline]
 __ocfs2_move_extents_range+0x208c/0x2aac fs/ocfs2/move_extents.c:866
 ocfs2_move_extents+0x314/0x7e0 fs/ocfs2/move_extents.c:933
 ocfs2_ioctl_move_extents+0x420/0x5ec fs/ocfs2/move_extents.c:1065
 ocfs2_ioctl+0x204/0xaf4 fs/ocfs2/ioctl.c:930
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2bc arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:140
 do_el0_svc+0x58/0x13c arch/arm64/kernel/syscall.c:204
 el0_svc+0x58/0x138 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:585
Code: 17ffff5e 97a116fd d4210000 97a116fb (d4210000) 
---[ end trace 0000000000000000 ]---


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=15719be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=848478f4029d639b
dashboard link: https://syzkaller.appspot.com/bug?extid=f2107d999290b8166267
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b69be2580000


