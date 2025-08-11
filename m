Return-Path: <linux-kernel+bounces-761945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1351B2003C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD983BCF42
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DFB2D9781;
	Mon, 11 Aug 2025 07:25:41 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC361EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897141; cv=none; b=OEmplfbeeKhFF2xGVzPq1B+q6LB+nidf9wa62tsixUVOaFMyIV71tGcWuheRmlCL98cUxK0b/huKkNGhq9KzhEudEkJaTJbqXKz6FB7B/ka7LAjT8kJIIV94z/+HQum+M1M2/3WsRX/igE0MMfbWh6UTB34gXa6je+hJCPB3YBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897141; c=relaxed/simple;
	bh=xm2EpZKk+k3x+HvyHd9k8c160CEuMjwM/VD6nf1n4Ug=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DdMFTQCJp9f/CU7ZCWJ9A/fUf3V24bGzkrf7g4hQzcQHSRtzbiHfugy+kB2+pIu4NzO2mmG4TyCt6pA+B/ix8r24+90SyoQoRTYfJfHFGZdCA1e3Q14+Un+/loNEAfIg+CnQ5MT8YeYip/CK+9QNVQYPCJvoebmuQ5XeQZfa7rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87c1c2a4f9dso1128520039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897138; x=1755501938;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olU9SnnoSCC/d73YCyF8XVcJcqWdgZbCNJBOcBwmvz0=;
        b=I19Pj5lkbINUnt6lbOCbP7v14drcnyHAFDemmzWubM0ls8mdqMpIBwyW8UeDNVUTN7
         AfIkjBqpGVOr71K/LoGP6vL4QIRbFc7or516da7EM3JN3AaTDlRfAotGOp7vXIdJ7kMc
         qaoQRvZfB3smiex/gbC0cUkqzlmU+lLFp57gJavTgihmQ5TiuP0FpwrqRo0okKH9g18G
         HCvx5GI11grIjDijrvnPAXCwZx4TjdAlmpcwHXFOtPXyKc/EqhoWRl864pjtkjjNhh0M
         be8CaoTUmAO6TcT8X1qZXe0XnE4xLFAom+oQgCHDptXW+k+R5msPFOLT8bjzPjUtJYJ2
         ICxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiH25TIlW4V6gmMOl0VqZZHkyMl5tTwmEPluoJoGj+tmdLLlU2d34hzG3MCl5/5/qqvLhaw6bz/65XYNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fu+otEyU3WvKH7KjbjeQ3f11tJkiVY+rkblMVHCDNtBXta/8
	V8ZgDihA2az5AiPBbjHjGc10UvE5VXcyiTX61C+adVBnlIjo8bSeY3lQrzgzdciMoDDGYyOY5Go
	s94TwMwLol9rNFUQEM9yV4/6uJZ8qeCjTlFay4gWuVyWPHAYERrdNMBzgCo8=
X-Google-Smtp-Source: AGHT+IEbkXqO6L6J0Tep8Jf/3PmJE00hITklGnMl5a9MiuE176wCv+JC4ljyzmC5H6bX2ue+FgGbNvoMOUMhP2STDLfvDPrfcPXx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d12:b0:883:ee95:7266 with SMTP id
 ca18e2360f4ac-883f1254879mr2040568439f.9.1754897138021; Mon, 11 Aug 2025
 00:25:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 00:25:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68999af2.050a0220.51d73.009a.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_folio_set
From: syzbot <syzbot+8397085af632792ccc3a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82af5ea7c611 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12b2c1a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71154cdde49ea192
dashboard link: https://syzkaller.appspot.com/bug?extid=8397085af632792ccc3a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f6d5bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c19434580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dd1816edf6fa/disk-82af5ea7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/961cb9724207/vmlinux-82af5ea7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b93e015179fb/Image-82af5ea7.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/622cc58dab82/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8397085af632792ccc3a@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/bcachefs/fs-io-pagecache.c:219!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
Modules linked in:
CPU: 0 UID: 0 PID: 6736 Comm: syz.0.17 Not tainted 6.16.0-rc7-syzkaller-g82af5ea7c611 #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/18/2025
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : bch2_folio_set+0x940/0x964 fs/bcachefs/fs-io-pagecache.c:201
lr : bch2_folio_set+0x940/0x964 fs/bcachefs/fs-io-pagecache.c:201
sp : ffff8000a0767660
x29: ffff8000a0767800 x28: 0040000000000040 x27: 0040000000000040
x26: ffc0000000000038 x25: ffff8000a0767790 x24: dfff800000000000
x23: ffc0000100000037 x22: fffffdffc39e5208 x21: fffffdffc39e5200
x20: ffc0000000000038 x19: ffc0000000000038 x18: 00000000ffffffff
x17: ffff800080d32178 x16: ffff80008ae69508 x15: 0000000000000003
x14: 0000000000000000 x13: 0000000000000013 x12: 0000000000ff0100
x11: ffff0000da3c5b80 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000da3c5b80 x7 : 20000000ffc00000 x6 : 00000038ffffffff
x5 : ffff8000a07677a0 x4 : ffff8000a0767774 x3 : 0000000000000000
x2 : ffff8000a0767778 x1 : 0040000000000040 x0 : ffc0000000000038
Call trace:
 bch2_folio_set+0x940/0x964 fs/bcachefs/fs-io-pagecache.c:201 (P)
 __bch2_buffered_write fs/bcachefs/fs-io-buffered.c:864 [inline]
 bch2_buffered_write fs/bcachefs/fs-io-buffered.c:1026 [inline]
 bch2_write_iter+0xa14/0x2300 fs/bcachefs/fs-io-buffered.c:1082
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x62c/0x97c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: d4210000 9776de90 d4210000 9776de8e (d4210000) 
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

