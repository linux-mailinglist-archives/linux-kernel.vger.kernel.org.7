Return-Path: <linux-kernel+bounces-809754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 273C8B5119C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E56D188D6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C03101B4;
	Wed, 10 Sep 2025 08:39:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8593530F54C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493572; cv=none; b=Z+0Hb5IAfCIhBJtXB3rkBNaK0Nz+gfkutGLG8FgkaxrEbsWFCp/ZUET+cmS8LtPllfdydyCGcZPu3nh6aYtY/xygE7fY/jGrdquI4h4AL2by4Kzq07uTyruzqgZpUPghkabANrFVOu5kQyf16AIqAAAaKVIgdxd+Cma+P+EQ/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493572; c=relaxed/simple;
	bh=gry4TlZ3aQ73uBdGDKA5zzFuF4d7TFuTwiMfXGz2ICc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=tEOu+RRDPMpwHTuYHGF3uoOO16iS4fzcQd2qDzqEIASiBCK+Kee6X8nFpBVA9fT4tXY1vUEfhLPaM6QDvTuqb5mdbIpiK5ofYlKAemOpZhKcLNzOF2UVzbRr28NEBly5QzYrJsCJ6Nby+iANd8GST6ehz7d80nUQ3xKbwtuR0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4190d8f16c3so2595215ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493569; x=1758098369;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wcqwa9UVTgt+vSJ2HOOPjUHsHWgh6bX7b58VAKjfe3Q=;
        b=a4a3SegfcMalVhUxXMfbz39d9/CWtAXMVn+1iTgR7MO67M5P8tHMncp/4feIJHBIVO
         smQWSgDjCLpFKOOrJmqFDehCaboU4I6WXI6lKhVd7QYEFXgTleFql8/qJlwMBRAAL52s
         nETLzEs1ADzSjA/fZPsjXbLP4uTYTk1d/sYTg3BTTwu3PbEeolNRXy3B5Fu77560mNrS
         W0Vp9Fo/kT06XaePCMpjS18jREURThIpPgjovYIrBKoe7mtH1uCHACuDC0AIFBqDqwy6
         MlDIw4KHUkjGo7+QsCfwNmhhPad5vsoYYpaFPREITq+B98gVuZLD3KWadc8x9yH2IHVn
         wpVg==
X-Forwarded-Encrypted: i=1; AJvYcCXpoucJIwbUvIEPMP55LfIckaGk/gY89BFOIEyN1UJ+vcyXYnDKHb+sME48l7O9P8Vwt4rHr7Q9Zb7bBsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyry+6p7ZNqBjUG1SP47SiaSQBmLu+3fDq7zyHPU8wdJygjv2rL
	uQqG6L0WkFsw1jrevMKq2zloDG0QzSRNB9ntwwDCGvDsYonytW3LveImUtITzvO4axfR2Lu3vcV
	K28Rh5zr/Z24Fv5u9x7mm08ns0CapqUKvEcInkZrKYDjUsULcFMGhN5HUnxY=
X-Google-Smtp-Source: AGHT+IF+kkdZuXHRGt39YmgS5WbPtMYJOAMbJ/XGa2whcdg3dnOyi8+jm0FGA1na2rxzdjWkeavI2JXVEsr6LVsp5+Vhp83goTur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2e:b0:412:f7d1:7432 with SMTP id
 e9e14a558f8ab-412f7d17596mr65192215ab.1.1757493569579; Wed, 10 Sep 2025
 01:39:29 -0700 (PDT)
Date: Wed, 10 Sep 2025 01:39:29 -0700
In-Reply-To: <20250910005957.54108-1-rgbi3307@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c13941.050a0220.3c6139.001d.GAE@google.com>
Subject: [syzbot ci] Re: mm/slub: Removing unnecessary variable accesses in
 the get_freelist()
From: syzbot ci <syzbot+ci49ef42f07c0503e6@syzkaller.appspotmail.com>
To: 42.hyeyoo@gmail.com, akpm@linux-foundation.org, cl@linux.com, 
	iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	penberg@kernel.org, rgbi3307@gmail.com, rgbi3307@naver.com, 
	rientjes@google.com, roman.gushchin@linux.dev, vbabka@suse.cz
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] mm/slub: Removing unnecessary variable accesses in the get_freelist()
https://lore.kernel.org/all/20250910005957.54108-1-rgbi3307@gmail.com
* [PATCH] mm/slub: Removing unnecessary variable accesses in the get_freelist()

and found the following issue:
kernel BUG in __smpboot_create_thread

Full report is available here:
https://ci.syzbot.org/series/832d6128-4556-4bd1-ab18-0676b8e7dbc1

***

kernel BUG in __smpboot_create_thread

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      f777d1112ee597d7f7dd3ca232220873a34ad0c8
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/7bff7792-4edd-4680-a5e7-3cc9d97ac5ed/config

smpboot: CPU0: Intel QEMU Virtual CPU version 2.5+ (family: 0xf, model: 0x6b, stepping: 0x1)
Performance Events: unsupported Netburst CPU model 107 no PMU driver, software events only.
signal: max sigframe size: 1440
------------[ cut here ]------------
kernel BUG at mm/slub.c:3832!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:___slab_alloc+0x13ab/0x1420
Code: ff ff 4c 89 e7 48 c7 c6 3a a1 a0 8d e8 3e 4f 0f ff 90 0f 0b 90 0f 0b 48 89 f7 48 c7 c6 3a a1 a0 8d e8 29 4f 0f ff 90 0f 0b 90 <0f> 0b 90 0f 0b 4c 89 e7 48 c7 c6 3a a1 a0 8d e8 11 4f 0f ff 90 0f
RSP: 0000:ffffc90000047750 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888100028000 RCX: 0000000000800001
RDX: 0000000000800001 RSI: ffffffff8dba8965 RDI: ffffffff8be33980
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff82189e55
R10: dffffc0000000000 R11: fffffbfff1f47407 R12: ffff88804b03e480
R13: ffff88801a441640 R14: ffff88804b03e460 R15: ffffffff82189e55
FS:  0000000000000000(0000) GS:ffff8880b8615000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88813ffff000 CR3: 000000000df36000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 __kmalloc_cache_node_noprof+0x29a/0x3d0
 __smpboot_create_thread+0x11a/0x3b0
 smpboot_register_percpu_thread+0xc6/0x420
 spawn_ksoftirqd+0x2f/0xc0
 do_one_initcall+0x236/0x820
 do_pre_smp_initcalls+0x4c/0x80
 kernel_init_freeable+0x30c/0x4b0
 kernel_init+0x1d/0x1d0
 ret_from_fork+0x3fc/0x770
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:___slab_alloc+0x13ab/0x1420
Code: ff ff 4c 89 e7 48 c7 c6 3a a1 a0 8d e8 3e 4f 0f ff 90 0f 0b 90 0f 0b 48 89 f7 48 c7 c6 3a a1 a0 8d e8 29 4f 0f ff 90 0f 0b 90 <0f> 0b 90 0f 0b 4c 89 e7 48 c7 c6 3a a1 a0 8d e8 11 4f 0f ff 90 0f
RSP: 0000:ffffc90000047750 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888100028000 RCX: 0000000000800001
RDX: 0000000000800001 RSI: ffffffff8dba8965 RDI: ffffffff8be33980
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff82189e55
R10: dffffc0000000000 R11: fffffbfff1f47407 R12: ffff88804b03e480
R13: ffff88801a441640 R14: ffff88804b03e460 R15: ffffffff82189e55
FS:  0000000000000000(0000) GS:ffff8880b8615000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88813ffff000 CR3: 000000000df36000 CR4: 00000000000006f0


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

