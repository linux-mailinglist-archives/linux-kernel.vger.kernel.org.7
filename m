Return-Path: <linux-kernel+bounces-874677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 327C4C16D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C224F12D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62634BA2B;
	Tue, 28 Oct 2025 20:58:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A734B408
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761685116; cv=none; b=TeSPQPz6jsUwHMrYEn9aY/eiP2Xgt+LMOll1k0T4kBmK/RGpcKlFjU/tYWVK37ukkhs8XLHTfldzS5Q7ZpLfKgAv2TVkkbMONBFLvsBhilfZsWJw5yrlN1onSDePJUycsVCda3nckIy3euil1oZx0C6XQQL7L97Y7FN7Ipt8wyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761685116; c=relaxed/simple;
	bh=Mx2U75YyRBX+WnGe1CaROXNmoIyCY0JNk4DZIf09M14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=mnv7r2JckKQfCd0zZvXrjVEziFX489NA0amq8okPDFnkswfkKpy1GmVbBOp3xKqEzmPBKTTDPgg+ZdUY9iHJHHOtpekSyLcN24W9b57h6PF3u8jCjSLTRN4WM1v1fEuejhgZpslxJIFF9M/W/6v7JtRZywD1S756ArMhhnpN+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c477fe44so79819275ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761685113; x=1762289913;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8Q6xMc7Ndu8q4AA2QZ12NoLPaoVzQEf+yv3C2w/BPw=;
        b=vK4cODVbRxx1EGUVx2Unfu4JNrKzQYq0WGQMIn0N70k+AcK03lm44wz0b7ptDMkb2Z
         Ysys9uT0CBsIl7pw3XNy3OgXYv7TqdJj+fklNIQkjqJ5lHzfwDEY67TjQnU7OSwYPCnc
         3vcyTzOk+C/XLztCKoKYD2Ertj9r9SLTftO4U1IdFq5S9ukodS5sgomfxH0GVsgGtGMT
         3d132G83ef29XJwoAH7yYPI3jMkR1Lqh/QFMDg12p+IbliU7NTLpwiaRTQwAKMjMp/U1
         jNI9szFw7ZxaWPrHCskZWVvoRl0nvcQK7IO6oZXrRtWYuXV8T2tuR9eMQ52ZQZ5I7ACY
         km0A==
X-Forwarded-Encrypted: i=1; AJvYcCVOb8nxcLg+uQtoO+la6HORJZ+n1A0IjQkXk9ltMbg9TyjjE/9yZzFKORkUWL23g39r/mjwNaELvNUVb+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwftnyU35Ec4jY3PnwmADE/2ipqyYZS+mgf9o97KhOOU1ly+814
	MCkPoP4U3a5N5IP/zIIF1mi2OWxMjvwtElUkpQHxX2hFzsxfuJzQ+w7B9ax3rOU1Krt+jM9BOut
	gqp1X6SYffKJsIOGaQxUkFcp+2/0VNCE8filtDPQdtnFpGm7QnqGl6/116mo=
X-Google-Smtp-Source: AGHT+IFDFBbc8Cb1UY0q9NJksMCDOPUyRjNT8FEq3e2eFa+YqZJej0oEiYsoupU3doybBUYAA/Hw2lsuh3cPLS+djdwOlI5htbTy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3003:b0:42f:94fd:318f with SMTP id
 e9e14a558f8ab-432f8fac67bmr9677295ab.9.1761685113513; Tue, 28 Oct 2025
 13:58:33 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:58:33 -0700
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012e79.050a0220.3344a1.03ee.GAE@google.com>
Subject: [syzbot ci] Re: Eliminate Dying Memory Cgroup
From: syzbot ci <syzbot+cie7d8f1fc805fcd7a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, 
	cgroups@vger.kernel.org, chengming.zhou@linux.dev, david@redhat.com, 
	hannes@cmpxchg.org, harry.yoo@oracle.com, hughd@google.com, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, muchun.song@linux.dev, nphamcs@gmail.com, qi.zheng@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, songmuchun@bytedance.com, 
	weixugc@google.com, yuanchu@google.com, zhengqi.arch@bytedance.com, 
	ziy@nvidia.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] Eliminate Dying Memory Cgroup
https://lore.kernel.org/all/cover.1761658310.git.zhengqi.arch@bytedance.com
* [PATCH v1 01/26] mm: memcontrol: remove dead code of checking parent memory cgroup
* [PATCH v1 02/26] mm: workingset: use folio_lruvec() in workingset_refault()
* [PATCH v1 03/26] mm: rename unlock_page_lruvec_irq and its variants
* [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
* [PATCH v1 05/26] mm: memcontrol: allocate object cgroup for non-kmem case
* [PATCH v1 06/26] mm: memcontrol: return root object cgroup for root memory cgroup
* [PATCH v1 07/26] mm: memcontrol: prevent memory cgroup release in get_mem_cgroup_from_folio()
* [PATCH v1 08/26] buffer: prevent memory cgroup release in folio_alloc_buffers()
* [PATCH v1 09/26] writeback: prevent memory cgroup release in writeback module
* [PATCH v1 10/26] mm: memcontrol: prevent memory cgroup release in count_memcg_folio_events()
* [PATCH v1 11/26] mm: page_io: prevent memory cgroup release in page_io module
* [PATCH v1 12/26] mm: migrate: prevent memory cgroup release in folio_migrate_mapping()
* [PATCH v1 13/26] mm: mglru: prevent memory cgroup release in mglru
* [PATCH v1 14/26] mm: memcontrol: prevent memory cgroup release in mem_cgroup_swap_full()
* [PATCH v1 15/26] mm: workingset: prevent memory cgroup release in lru_gen_eviction()
* [PATCH v1 16/26] mm: thp: prevent memory cgroup release in folio_split_queue_lock{_irqsave}()
* [PATCH v1 17/26] mm: workingset: prevent lruvec release in workingset_refault()
* [PATCH v1 18/26] mm: zswap: prevent lruvec release in zswap_folio_swapin()
* [PATCH v1 19/26] mm: swap: prevent lruvec release in swap module
* [PATCH v1 20/26] mm: workingset: prevent lruvec release in workingset_activation()
* [PATCH v1 21/26] mm: memcontrol: prepare for reparenting LRU pages for lruvec lock
* [PATCH v1 22/26] mm: vmscan: prepare for reparenting traditional LRU folios
* [PATCH v1 23/26] mm: vmscan: prepare for reparenting MGLRU folios
* [PATCH v1 24/26] mm: memcontrol: refactor memcg_reparent_objcgs()
* [PATCH v1 25/26] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
* [PATCH v1 26/26] mm: lru: add VM_WARN_ON_ONCE_FOLIO to lru maintenance helpers

and found the following issue:
WARNING in folio_memcg

Full report is available here:
https://ci.syzbot.org/series/0d48a77a-fb4f-485d-9fd6-086afd6fb650

***

WARNING in folio_memcg

tree:      mm-new
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/akpm/mm.git
base:      b227c04932039bccc21a0a89cd6df50fa57e4716
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/503d7034-ae99-44d1-8fb2-62e7ef5e1c7c/config
C repro:   https://ci.syzbot.org/findings/880c374a-1b49-436e-9be2-63d5e2c6b6ab/c_repro
syz repro: https://ci.syzbot.org/findings/880c374a-1b49-436e-9be2-63d5e2c6b6ab/syz_repro

exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0xe5674ec2, utbl_chksum : 0xe619d30d)
exFAT-fs (loop0): failed to load alloc-bitmap
exFAT-fs (loop0): failed to recognize exfat type
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5965 at ./include/linux/memcontrol.h:380 obj_cgroup_memcg include/linux/memcontrol.h:380 [inline]
WARNING: CPU: 1 PID: 5965 at ./include/linux/memcontrol.h:380 folio_memcg+0x148/0x1c0 include/linux/memcontrol.h:434
Modules linked in:
CPU: 1 UID: 0 PID: 5965 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:obj_cgroup_memcg include/linux/memcontrol.h:380 [inline]
RIP: 0010:folio_memcg+0x148/0x1c0 include/linux/memcontrol.h:434
Code: 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 5f c8 06 00 48 8b 03 5b 41 5c 41 5e 41 5f 5d e9 cf 89 2a 09 cc e8 a9 bb a0 ff 90 <0f> 0b 90 eb ca 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c ef fe ff ff
RSP: 0018:ffffc90003ec66b0 EFLAGS: 00010293
RAX: ffffffff821f4b57 RBX: ffff888108b31480 RCX: ffff88816be91d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88816be91d00 R09: 0000000000000002
R10: 00000000fffffff0 R11: 0000000000000000 R12: dffffc0000000000
R13: 00000000ffffffe4 R14: ffffea0006d5f840 R15: ffffea0006d5f870
FS:  000055555db87500(0000) GS:ffff8882a9f35000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ee63fff CR3: 000000010c308000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 zswap_compress mm/zswap.c:900 [inline]
 zswap_store_page mm/zswap.c:1430 [inline]
 zswap_store+0xfa2/0x1f80 mm/zswap.c:1541
 swap_writeout+0x6e8/0xf20 mm/page_io.c:275
 writeout mm/vmscan.c:651 [inline]
 pageout mm/vmscan.c:699 [inline]
 shrink_folio_list+0x34ec/0x4c40 mm/vmscan.c:1418
 reclaim_folio_list+0xeb/0x500 mm/vmscan.c:2196
 reclaim_pages+0x454/0x520 mm/vmscan.c:2233
 madvise_cold_or_pageout_pte_range+0x1974/0x1d00 mm/madvise.c:565
 walk_pmd_range mm/pagewalk.c:130 [inline]
 walk_pud_range mm/pagewalk.c:224 [inline]
 walk_p4d_range mm/pagewalk.c:262 [inline]
 walk_pgd_range+0xfe9/0x1d40 mm/pagewalk.c:303
 __walk_page_range+0x14c/0x710 mm/pagewalk.c:410
 walk_page_range_vma+0x393/0x440 mm/pagewalk.c:717
 madvise_pageout_page_range mm/madvise.c:624 [inline]
 madvise_pageout mm/madvise.c:649 [inline]
 madvise_vma_behavior+0x311f/0x3a10 mm/madvise.c:1352
 madvise_walk_vmas+0x51c/0xa30 mm/madvise.c:1669
 madvise_do_behavior+0x38e/0x550 mm/madvise.c:1885
 do_madvise+0x1bc/0x270 mm/madvise.c:1978
 __do_sys_madvise mm/madvise.c:1987 [inline]
 __se_sys_madvise mm/madvise.c:1985 [inline]
 __x64_sys_madvise+0xa7/0xc0 mm/madvise.c:1985
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fccac38efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd9cc58708 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fccac5e5fa0 RCX: 00007fccac38efc9
RDX: 0000000000000015 RSI: 7fffffffffffffff RDI: 0000200000000000
RBP: 00007fccac411f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fccac5e5fa0 R14: 00007fccac5e5fa0 R15: 0000000000000003
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

