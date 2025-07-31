Return-Path: <linux-kernel+bounces-751722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A101B16CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492A55656D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24329CB41;
	Thu, 31 Jul 2025 07:29:41 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C21C1E2858
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946981; cv=none; b=GAd45vxhKfpaLLZwilJL0DQ4+Sc8BWNx4JZedmGztFCxkmIrDA7eEt0nDrG4z9DSlbPRxRZSDBIsLrMYRinatEm4oU8j2TS6+5p6e6ZfszhsfFudCtDF7KOvZPtpO8cO9/OG0OaumCb7quJ1XKZe3VQxSZS/QrNToibs8aGye70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946981; c=relaxed/simple;
	bh=7l8f93OqMJc+mgVUrKPKIF7+jNsF5jgFE1vi1gg1JjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DGwtq4kJJD/NbDV9vGYgQhR82dxewk9OcZUigwnH17IuQKL1Ci5Kz0+mlYdMLXtRJiuS9TC7a+SXZehx4Sa+LszfDdLwNKmuMLEhEjm41fU+USQVqaK/uRgBJG0gZ75RIs8lMndUavKIQBp3AcFqnVp+OQ3CVIRtzjWu71818Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88126408512so16288639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753946978; x=1754551778;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuFbYj/hCv1XeYSiiHV/soxoJacIxf8rCMlJdjl8St0=;
        b=I1z07x6Tiob0IDNMw/3hpHeYqdWZnDsde9er7lF8PWRAPIoQKEhfUKUskDdmLNX2xv
         ZsFkW3FycDo81iilOa7H+Nh5xAyndOfVf+oznrg+cIBXVj9EXE+2m9eXFij8WrZgGopK
         ddS9SDm5rYc96AZhuMyiw1/wGCwvH2UDakIg7xdl5pYLYkO5qkdv1KhAWruPMrGl4wB5
         bsMzqP6xuqcDjF01KmydyDE7pk04HaH2erXmleFbQNMhnGbae5uxUh9bOJhaUXnINLPE
         t96mR8UDMFeiHVo6z5rCpKGo6qzMhh11WUBpFLYp3HkXU3cjSkyJRx3Hrj+IiMQ+VGnx
         +D9g==
X-Forwarded-Encrypted: i=1; AJvYcCUGoLvE1UhUTYM5nAhiaHiwPt2sw8Q8d4d7F/CsV+JlVh+nwZafKhs5fhA1sbu0zY59/kBhhwv3zhAesU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwySOGy0B6abbyNO3sw/6A+Rnt+JL373KyickVsoQ2NpXDnTlIv
	gIw0arPeL7Sv6tsLyl79QgcezPYWf0g8WYbeZ78Crtl3lFo/HSxxSEk3RwT/6KAzKRbhIH8MyGp
	Cc+4lL5Jvcx69UfqNqC4inm10ac9R0LPgluDMdHYJiIvAFfKktbeSKFx0xr8=
X-Google-Smtp-Source: AGHT+IFDJ4KhfDOxH20Z+BgJFcQq9Tfa+wMjJH7mYoL2fLfLMyyVRyOI+UqUGpJmARAL5Tnbk9oA/sAPLjckAVW9ZFbbst88VGDr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:6:b0:3e3:ef79:5a8a with SMTP id
 e9e14a558f8ab-3e3f621922emr120639075ab.12.1753946978551; Thu, 31 Jul 2025
 00:29:38 -0700 (PDT)
Date: Thu, 31 Jul 2025 00:29:38 -0700
In-Reply-To: <687e955c.a70a0220.21b99c.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b1b62.a00a0220.26d0e1.0039.GAE@google.com>
Subject: Re: [syzbot] [comedi?] KMSAN: kernel-infoleak in do_insnlist_ioctl
From: syzbot <syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=154b8f82580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30a934bba3cd727
dashboard link: https://syzkaller.appspot.com/bug?extid=fb4362a104d45ab09cf9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a04ca2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a269bc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f57c48189b63/disk-e8d780dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5b7ee73a2a25/vmlinux-e8d780dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e48af4e6a5c3/bzImage-e8d780dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com

comedi comedi3: 8255: I/O port conflict (0x2,4)
comedi comedi3: 8255: I/O port conflict (0x10000,4)
comedi comedi3: 8255: I/O port conflict (0x4,4)
comedi comedi3: 8255: I/O port conflict (0x4,4)
=====================================================
BUG: KMSAN: kernel-infoleak-after-free in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _inline_copy_to_user include/linux/uaccess.h:196 [inline]
BUG: KMSAN: kernel-infoleak-after-free in _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:196 [inline]
 _copy_to_user+0xcc/0x120 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:225 [inline]
 do_insnlist_ioctl+0x66e/0x930 drivers/comedi/comedi_fops.c:1595
 comedi_unlocked_ioctl+0x1e78/0x1f60 drivers/comedi/comedi_fops.c:2293
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0x239/0x400 fs/ioctl.c:584
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
 x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4679 [inline]
 kfree+0x252/0xec0 mm/slub.c:4878
 tomoyo_supervisor+0xc57/0x3100 security/tomoyo/common.c:2250
 tomoyo_audit_path_number_log security/tomoyo/file.c:235 [inline]
 tomoyo_path_number_perm+0x4d8/0x7d0 security/tomoyo/file.c:734
 tomoyo_file_ioctl+0x3d/0x50 security/tomoyo/tomoyo.c:350
 security_file_ioctl+0x141/0x590 security/security.c:2943
 __do_sys_ioctl fs/ioctl.c:592 [inline]
 __se_sys_ioctl+0xbb/0x400 fs/ioctl.c:584
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:584
 x64_sys_call+0x1cbc/0x3e20 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 4-583 of 584 are uninitialized
Memory access of size 584 starts at ffff88814448f800

CPU: 1 UID: 0 PID: 5809 Comm: syz-executor572 Not tainted 6.16.0-syzkaller-06699-ge8d780dcd957 #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

