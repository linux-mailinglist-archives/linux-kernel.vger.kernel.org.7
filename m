Return-Path: <linux-kernel+bounces-759728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E296B1E1B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57FE0165243
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B1E1DE3C0;
	Fri,  8 Aug 2025 05:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIOCXhn8"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F92E36E2;
	Fri,  8 Aug 2025 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631133; cv=none; b=qEsNlLDFIpO7bht0AowkzmHUsFeLNvUxG7lvlwQguCN+VvtpCZNVFgRGygWe4+Kn7zFt/g7M7IgxVlji+LYTZYj6xeQapwCtDuN/WOdomQtNpnJmEtmFh1UJ0G5LgTZG9Vj26GwvGPcZkPxzZ79uq+KbdHKioImN6wMvPatU6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631133; c=relaxed/simple;
	bh=0UST82hdyXJjNP8UyiLvcz7QWzM3vcuslRVuXZU5gRk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H/RI10MoO9jrypOvgckrf9fVxxqstgn4jROS6ItYQOiygF01WoQJQ8+faEfp+wqOP7boxz1fsXwgjg+Q28JLvjuR+45IBk+3Y75o5tg4nVtP57whGfqFbaHgtIJWhUqZHKQHMwMH35SlALuPyDCx8QzFjCoYb7muIUbPXnuBd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIOCXhn8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2405c0c431cso16296365ad.1;
        Thu, 07 Aug 2025 22:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754631131; x=1755235931; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZt7nIYTPasvER08fO5MJPF5lGGdCf/P1sE3XZpmcYs=;
        b=PIOCXhn8Tx/lH0c9QprSRrjqi7xgs3Pp7Gzvw80OB2tvLkMiAbxL0RgfCkz+19w+Do
         iJT4XPofJLT/5HAJ9vtSJ/nOcwC9J9y+unwMBeJn00ArplkvkePi1U8nreHlS69u7ouK
         vmLoD+6IMeLYVz1Hp5IZCdSuporzqbzm6w+qL1zJeRk6R+yNKc94ll0+cObSETCooSGE
         OdFTbTR1/yjZgE3+OO7XXvexLjVVeqn7a3xJYmfJ0opxHUuGo8Dpo389rrtjPycWjPk6
         wRCZYY2MkN/EguLRCzqzm35OxUveyLxnkTOwpq8QoywvVK0jSKE9b/CVGhu/EMrtkQrs
         WdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631131; x=1755235931;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZt7nIYTPasvER08fO5MJPF5lGGdCf/P1sE3XZpmcYs=;
        b=Ed7K+Xiccr/G08H3ITr2FKDXSxGmBG3EdnTX2O+rfBjvU8dX9PNzSU6tNG1r7/iHzk
         7iiNGohHtzJr7CmLiz3OFrVGEg0o2Y3aLpk+TTYqz09XMBoVINldhgFaBuOztO7Sgc0U
         6RU3fR/25Iwue7m6CtLu0MEcaIgPRqSJDfseS/Xg9wzuOwTmLMpE27GJuyu5qeffQraD
         A/0aa59Dp2PZNz+2TwxWhhoOeBr9PIAiSKJX/2yUCDXEcEjejUOMXiayIMWLuCe3E/iL
         bNOa/CuPzwzX7UHwJ+w4vpvqLV0TdT8baqI5RitAYqqTKPJYri81GX1+/TasbEb6M2Sm
         x20Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGCkZuWrw8uJS7//7LAkzxz/oFTm3o+oSpEDIgUrb2nbwJfTwwkH4RfD5Qagv/iTZeYAip+RIH0PgQTt3B@vger.kernel.org, AJvYcCWt9J7Fl3ZTOESSHnWE+Osltd9/Z0Jk+jqNzLz3Z1iHIVIVlIcveYJT8lI6mscBZ1ouoZJzOCQDex+X0JRClQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVdARLo1naKRy8xVU6GVzD761ubPhHnvh0dFFdw8A1uVWn2Ac
	9YAZ3YXVgLbzN7xnU+2zb8xZD1HpWDcfBgZX93gGb5wYOF0pw0Tu5zCE
X-Gm-Gg: ASbGnct1ZaQQ1MJObnNYz5uMUasXMH5JzWymKdylnUgJrtZ4Dbdv8WOnDgUGkCqtOhj
	C9SqAJWWJC9euYC/m5/rH6wzSWD7n8lK4zqAwKhjZENHUGYBYaJlc8Ka1mEgj6339PC7pWpqTNY
	7dERNx9II0PwpJDYW8SrZZkvfnhZ97FqF+Uon26Ke3/rLEky6V6lgLz+Tn57Ata0cL3ewoY8/w3
	jHapHUhf8FExCVpU4JT0uYzi+T+T9M6ARdop9vcJSlMxgKwnI6zeQ9eit53icn70EDs/rWbW830
	QppkL7kxUTDSxxYKYOElsSiDoGaFlpJeyn3/DATaGLlMc1OPrBB2+nCrAM6jj8dk1UiNFXk3BGE
	Rb+VStg==
X-Google-Smtp-Source: AGHT+IH83s/bqcJ7kCYGpjobyd2vgXNAAtjtdiB/yZaXRvXiJ46UvRJRS5/4ghSELrkJitXY1H359A==
X-Received: by 2002:a17:902:ea01:b0:240:3c64:8626 with SMTP id d9443c01a7336-242c200314bmr21464945ad.5.1754631130247;
        Thu, 07 Aug 2025 22:32:10 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:11:86::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b4adsm200022325ad.132.2025.08.07.22.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2025 22:32:09 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in pipe_release (6)
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <67c0c335.050a0220.222324.0271.GAE@google.com>
Date: Fri, 8 Aug 2025 13:31:52 +0800
Cc: bfoster@redhat.com,
 kent.overstreet@linux.dev,
 linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCA5343D-6312-4CEE-8080-3B2DED2B06BC@gmail.com>
References: <67c0c335.050a0220.222324.0271.GAE@google.com>
To: syzbot <syzbot+23e4a7772eb9a9715b85@syzkaller.appspotmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

On Feb 28, 2025, at 03:55, syzbot =
<syzbot+23e4a7772eb9a9715b85@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
> git tree:       upstream
> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D11fe26e4580000
> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3D8de9cc84d5960254
> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3D23e4a7772eb9a9715b85
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for =
Debian) 2.40
> syz repro:      =
https://syzkaller.appspot.com/x/repro.syz?x=3D15fe26e4580000
>=20
> Downloadable assets:
> disk image: =
https://storage.googleapis.com/syzbot-assets/5efd609bee65/disk-d082ecbc.ra=
w.xz
> vmlinux: =
https://storage.googleapis.com/syzbot-assets/dfadbc41acd8/vmlinux-d082ecbc=
.xz
> kernel image: =
https://storage.googleapis.com/syzbot-assets/50189caf8ad6/bzImage-d082ecbc=
.xz
> mounted in repro: =
https://storage.googleapis.com/syzbot-assets/470a5d56ad27/mount_0.gz
>=20
> The issue was bisected to:
>=20
> commit 1d16c605cc55ef26f0c65b362665a6c99080ccbc
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Thu Nov 9 19:22:46 2023 +0000
>=20
>    bcachefs: Disk space accounting rewrite
>=20
> bisection log:  =
https://syzkaller.appspot.com/x/bisect.txt?x=3D117c9db0580000
> final oops:     =
https://syzkaller.appspot.com/x/report.txt?x=3D137c9db0580000
> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D157c9db0580000
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> Reported-by: syzbot+23e4a7772eb9a9715b85@syzkaller.appspotmail.com
> Fixes: 1d16c605cc55 ("bcachefs: Disk space accounting rewrite")
>=20
> INFO: task syz-executor:5849 blocked for more than 143 seconds.
>      Not tainted 6.14.0-rc4-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
> task:syz-executor    state:D stack:20592 pid:5849  tgid:5849  =
ppid:5843   task_flags:0x400100 flags:0x00000002
> Call Trace:
> <TASK>
> context_switch kernel/sched/core.c:5378 [inline]
> __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
> __schedule_loop kernel/sched/core.c:6842 [inline]
> schedule+0x14b/0x320 kernel/sched/core.c:6857
> schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6914
> __mutex_lock_common kernel/locking/mutex.c:662 [inline]
> __mutex_lock+0x817/0x1010 kernel/locking/mutex.c:730
> pipe_release+0x48/0x320 fs/pipe.c:728
> __fput+0x3e9/0x9f0 fs/file_table.c:464
> __do_sys_close fs/open.c:1580 [inline]
> __se_sys_close fs/open.c:1565 [inline]
> __x64_sys_close+0x7f/0x110 fs/open.c:1565
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe6de58bda0
> RSP: 002b:00007fff16f18de8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
> RAX: ffffffffffffffda RBX: 0000555580184ec0 RCX: 00007fe6de58bda0
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 000000000000001d
> RBP: 00005555801847a0 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000008 R11: 0000000000000202 R12: 00007fff16f18e10
> R13: 0000000000000023 R14: 0000555580184f0c R15: 00005555801854c8
> </TASK>
> INFO: task syz.3.64:6573 blocked for more than 143 seconds.
>      Not tainted 6.14.0-rc4-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
> task:syz.3.64        state:D stack:10240 pid:6573  tgid:6572  =
ppid:5971   task_flags:0x400140 flags:0x00004004
> Call Trace:
> <TASK>
> context_switch kernel/sched/core.c:5378 [inline]
> __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
> __schedule_loop kernel/sched/core.c:6842 [inline]
> schedule+0x14b/0x320 kernel/sched/core.c:6857
> io_schedule+0x8d/0x110 kernel/sched/core.c:7690
> folio_wait_bit_common+0x839/0xee0 mm/filemap.c:1318
> folio_lock include/linux/pagemap.h:1163 [inline]
> invalidate_inode_pages2_range+0x48f/0x960 mm/truncate.c:639
> bch2_write_invalidate_inode_pages_range+0xce/0x120 =
fs/bcachefs/fs-io-pagecache.c:68
> bch2_direct_write+0x2ebf/0x3190 fs/bcachefs/fs-io-direct.c:653
> bch2_write_iter+0x19d/0x2cd0 fs/bcachefs/fs-io-buffered.c:1047
> iter_file_splice_write+0xbfa/0x1510 fs/splice.c:743
> do_splice_from fs/splice.c:941 [inline]
> direct_splice_actor+0x11b/0x220 fs/splice.c:1164
> splice_direct_to_actor+0x586/0xc80 fs/splice.c:1108
> do_splice_direct_actor fs/splice.c:1207 [inline]
> do_splice_direct+0x289/0x3e0 fs/splice.c:1233
> do_sendfile+0x564/0x8a0 fs/read_write.c:1363
> __do_sys_sendfile64 fs/read_write.c:1424 [inline]
> __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f893338d169
> RSP: 002b:00007f89342ae038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f89335a5fa0 RCX: 00007f893338d169
> RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000006
> RBP: 00007f893340e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000fffa83 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f89335a5fa0 R15: 00007fffa972dc48
> </TASK>
> INFO: task syz.3.64:6613 blocked for more than 144 seconds.
>      Not tainted 6.14.0-rc4-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this =
message.
> task:syz.3.64        state:D stack:15824 pid:6613  tgid:6572  =
ppid:5971   task_flags:0x440140 flags:0x00004004
> Call Trace:
> <TASK>
> context_switch kernel/sched/core.c:5378 [inline]
> __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
> __schedule_loop kernel/sched/core.c:6842 [inline]
> schedule+0x14b/0x320 kernel/sched/core.c:6857
> __bch2_two_state_lock+0x229/0x2c0 =
fs/bcachefs/two_state_shared_lock.c:7
> bch2_two_state_lock fs/bcachefs/two_state_shared_lock.h:55 [inline]
> bch2_readahead+0x9e1/0x1240 fs/bcachefs/fs-io-buffered.c:272
> read_pages+0x179/0x570 mm/readahead.c:161
> page_cache_ra_unbounded+0x708/0x820 mm/readahead.c:298
> filemap_readahead mm/filemap.c:2549 [inline]
> filemap_get_pages+0x9e4/0x1fb0 mm/filemap.c:2594
> filemap_splice_read+0x68e/0xef0 mm/filemap.c:2971
> do_splice_read fs/splice.c:985 [inline]
> splice_file_to_pipe+0x290/0x500 fs/splice.c:1295
> do_sendfile+0x508/0x8a0 fs/read_write.c:1369
> __do_sys_sendfile64 fs/read_write.c:1424 [inline]
> __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1410
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f893338d169
> RSP: 002b:00007f893428d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 00007f89335a6080 RCX: 00007f893338d169
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: 00007f893340e2a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000002ab R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f89335a6080 R15: 00007fffa972dc48
> </TASK>
>=20
> Showing all locks held in the system:
> 1 lock held by khungtaskd/30:
> #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire =
include/linux/rcupdate.h:337 [inline]
> #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock =
include/linux/rcupdate.h:849 [inline]
> #0: ffffffff8eb38f60 (rcu_read_lock){....}-{1:3}, at: =
debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6746
> 2 locks held by getty/5582:
> #0: ffff88803571a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: =
tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: =
n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
> 1 lock held by syz-executor/5849:
> #0: ffff88802a3d6068 (&pipe->mutex){+.+.}-{4:4}, at: =
pipe_release+0x48/0x320 fs/pipe.c:728
> 4 locks held by kworker/u8:4/6005:
> #0: ffff8880b873e7d8 (&rq->__lock){-.-.}-{2:2}, at: =
raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:598
> #1: ffff8880b8728948 (&per_cpu_ptr(group->pcpu, =
cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x41d/0x7a0 =
kernel/sched/psi.c:987
> #2: ffff8880b872a398 (&base->lock){-.-.}-{2:2}, at: lock_timer_base =
kernel/time/timer.c:1046 [inline]
> #2: ffff8880b872a398 (&base->lock){-.-.}-{2:2}, at: =
__mod_timer+0x24a/0x10e0 kernel/time/timer.c:1127
> #3: ffffffff9a832208 (&obj_hash[i].lock){-.-.}-{2:2}, at: =
debug_object_activate+0x17f/0x580 lib/debugobjects.c:818
> 1 lock held by syz.3.64/6573:
> #0: ffff8880741e2420 (sb_writers#13){.+.+}-{0:0}, at: =
direct_splice_actor+0x49/0x220 fs/splice.c:1163
> 2 locks held by syz.3.64/6613:
> #0: ffff88802a3d6068 (&pipe->mutex){+.+.}-{4:4}, at: =
splice_file_to_pipe+0x2e/0x500 fs/splice.c:1292
> #1: ffff8880744ba148 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: =
filemap_invalidate_lock_shared include/linux/fs.h:932 [inline]
> #1: ffff8880744ba148 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: =
page_cache_ra_unbounded+0x156/0x820 mm/readahead.c:229
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted =
6.14.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 02/12/2025
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:94 [inline]
> dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
> nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
> trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
> check_hung_uninterruptible_tasks kernel/hung_task.c:236 [inline]
> watchdog+0x1058/0x10a0 kernel/hung_task.c:399
> kthread+0x7a9/0x920 kernel/kthread.c:464
> ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1 skipped: idling at native_safe_halt =
arch/x86/include/asm/irqflags.h:48 [inline]
> NMI backtrace for cpu 1 skipped: idling at arch_safe_halt =
arch/x86/include/asm/irqflags.h:106 [inline]
> NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x21/0x30 =
drivers/acpi/processor_idle.c:111
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: =
https://goo.gl/tpsmEJ#bisection
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before =
testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20

#syz fix: bcachefs: Fix readahead involved deadlock


