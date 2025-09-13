Return-Path: <linux-kernel+bounces-815090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E39A0B55F72
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8EE1CC0D97
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3AC2E92D4;
	Sat, 13 Sep 2025 08:23:35 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F02AC17
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757751814; cv=none; b=jK+NNwCrC7v++V3hnjwjErt6rGDNwsC3DhW/vu6LbD4tZYULUo3RYpAR9aVyfQXKe+N1kQSr5fi8yTN1eu7DkakiU2YrCG6CCDs1kRV88fC1ndwjdL4AJy8E9ar1BtCQ9qXf5Cgjp1fQPSNrhOYidvrPeIbz7ryzf8fLaRLaPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757751814; c=relaxed/simple;
	bh=9Cyk73qCemZLt2TIQWoAm/Fos2OIzYEaVPWTQ0IJGMY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mY/Uv0UfGvyJvOPdZqkBrIJdr7JNuGp3WJQIAZpjas/VR5e8cM1QAJLd46hQ+WjCmtu8N5jAZgB2+ZY7ZudDuiSyyjT14aztlTuXIid398DXt/Gs8WwcK9I0vsl2U6Y5d1RlzuxdzOWLVZtixy/WOqF2ACBKDW8l/NbDWMU76VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ee1d164774so53097155ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757751812; x=1758356612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vl0zIm0bJh13wDJcRfKZ8dttaz6xfqHDCOb+BzqK/pw=;
        b=F+T6HY0lUGdpOft2fp1Iy8R9IuwthOmpNVq1vdAVbTSUQDzbM727yk4Bhiyk0BS1kH
         ZDx1dZPGaj4+xWr1Ts0JxndOenX+SeXTTMiMaTZA6FgJM4k4x/FDECoPpsF822Qqj3t9
         Ykv+xx7xgdJgFg4UPudISiQqEchR8/pjwSVr1r1Pza/8vt7xd6O8CicW7sKVOMhZBu/C
         EzkTlaBwjOqtYZz9Th+rXRwpkNOg75UyeVAEFaLLQZbvYn3u3OZ0j58gIQJs8If6tz61
         AcC1bh2xoOqGd+jwPXZ0TToqv4mFhRcdpQtd258AI0/DMz3DhsYJupe2DKK6pNNUEHJk
         aMBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvv+3Ombdj3+getXeNfLXTysVLOe4eZSdXWkjHTpa8/9mIljSC6ojizIzDDkQz13ipliUyyWgKIm1GUe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtaIfIn5XIMsvhw9w+B7jH6WoYk3VixAf3GgsofSh3kWLK/eP
	osm2jwY/ocm2aq2csuf9WtNfC4ZzPpvzTRcHONcaP7hixOt7EfOCShJ+xnhlt2OpPcvvZf6WzNt
	fUcayrcXVaBxPF6wyA4O0qZg24J2Y7V7dn4h4mFODbips5lieuXvsdDEJO3M=
X-Google-Smtp-Source: AGHT+IFK1fMwzxxD9XGrrmOZqg+lJNUAzsE9p2HV1T+nkudZ47oV4Lb1zki9F6sQ1p+gHrSLBCIYGN6GvLKXLllPBjM6pbmbAsoX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-422a9aaa667mr48616895ab.11.1757751812305; Sat, 13 Sep 2025
 01:23:32 -0700 (PDT)
Date: Sat, 13 Sep 2025 01:23:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c52a04.050a0220.2ff435.0372.GAE@google.com>
Subject: [syzbot] [bpf?] WARNING in convert_ctx_accesses (2)
From: syzbot <syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f20375f5b7 Merge tag 'pci-v6.17-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1003d642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13bd892ec3b155a2
dashboard link: https://syzkaller.appspot.com/bug?extid=136ca59d411f92e821b7
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1782f362580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c09b12580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-22f20375.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2e4b3490c173/vmlinux-22f20375.xz
kernel image: https://storage.googleapis.com/syzbot-assets/884bdc12ee68/Image-22f20375.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+136ca59d411f92e821b7@syzkaller.appspotmail.com

------------[ cut here ]------------
verifier bug: error during ctx access conversion (0)(1)
WARNING: CPU: 0 PID: 3603 at kernel/bpf/verifier.c:21452 convert_ctx_accesses+0x9b0/0xb04 kernel/bpf/verifier.c:21452
Modules linked in:
CPU: 0 UID: 0 PID: 3603 Comm: syz.2.17 Not tainted syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : convert_ctx_accesses+0x9b0/0xb04 kernel/bpf/verifier.c:21452
lr : convert_ctx_accesses+0x9b0/0xb04 kernel/bpf/verifier.c:21452
sp : ffff8000894e39e0
x29: ffff8000894e39e0 x28: fcf0000012540000 x27: 0000000000000002
x26: f4ff800083265058 x25: 0000000000000000 x24: 0000000000000000
x23: ffff8000816c4744 x22: 0000000000000004 x21: 0000000000000002
x20: 0000000000000004 x19: ffff80008242a948 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000002
x14: f6f00000086b0080 x13: 0000000000000400 x12: 000000007e4ab000
x11: 00000023a2977bad x10: f6f00000086b0080 x9 : fbf0000007523c00
x8 : 0000000000000001 x7 : f6f00000086b0080 x6 : 0000000000000002
x5 : 0000000000000297 x4 : 0000000000000297 x3 : f5f0000005c20400
x2 : 0000000000000000 x1 : 0000000000000000 x0 : f6f00000086b0000
Call trace:
 convert_ctx_accesses+0x9b0/0xb04 kernel/bpf/verifier.c:21452 (P)
 bpf_check+0x12f8/0x2aac kernel/bpf/verifier.c:24743
 bpf_prog_load+0x634/0xb74 kernel/bpf/syscall.c:2979
 __sys_bpf+0x2e0/0x1a3c kernel/bpf/syscall.c:6029
 __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
 __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6137
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
 el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

