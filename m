Return-Path: <linux-kernel+bounces-590030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197D7A7CDE3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D837816C625
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Apr 2025 12:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DFD1552FD;
	Sun,  6 Apr 2025 12:32:31 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F271E502
	for <linux-kernel@vger.kernel.org>; Sun,  6 Apr 2025 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743942751; cv=none; b=nppgVd24zgkJtGjR+v8JY15Yr9h662CU3EqlNSD1tCmLa10YvFHIO2AFD5XNmKoflasOcdy4w2lUi8PZKPa12BRsqILvexEOdnBA7GPcgbJCEmSb7rvKBl+SNHIf8FfodC9hbfJN1/S+ZAR46CRSiAhtG7gKrLz4U1VusOVDVTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743942751; c=relaxed/simple;
	bh=CEKF0cL6nsrhmPnxpB/a4ShvkceBaHB0DRg2GVEh1HE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nuy7NkhgfvoywI2NXrYZHMezQlN56o9l2sPN/a/XJ90shIV7c1a+e4Os8fjBDzpEPgERjMFAbZxRzG+/6GH1Vqun/u1TmUa0QDdr3Q6QkK5ILg6x/eQmqnXBelUSivpVgioAgJX/pg0YdjOSSMvyDewNYQD80WSasDQLw4DOiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85db3356bafso855335539f.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Apr 2025 05:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743942749; x=1744547549;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jF1lzPVnRifEuAh9YGkKDkZBeJE690CwqchrSkh1p/0=;
        b=wjddLefxRJoyPxsSPnMXew5boVvYNSvOP47KdZdVzLb1Dy2vSuScVlWLd7zdN8BjXu
         QdHiK1n0A6S62hcIhmuo1PKrS0M6lgOEYJYDyMkxy1VA6Q16z2wEikyYUmb4Pto+VWbM
         Okow6LllQ6KVrFBpxm2EhiEzqtzU5LFPs7/Whq6pfbbj+vav7UeQliBXNUP9XVGXE7Xg
         ivUBVWXv6Y6mO/CrFcppHxBPUb8I7nyS50SxWa5yYnonxjlQ8gFFklkywAC6fhvxqRYv
         GZ3u8H4DUP1vtUxbzWHGId6SHfGiaWtFTmnTS4STTptW9ZySoplnJ1aHkul7E/QZQyho
         JCHw==
X-Forwarded-Encrypted: i=1; AJvYcCWPRHwUL/w0iY4mhUUDCUPGmt2gZM9eJvd9aMX8Mz1EX3GT8FXcfpoyGKzLvlJAbefxewtnGlB4KjuX3G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhyExbMU1RjShG8BLZh9Fnj9Wsw3IQ1fMWXGtc8aMDVRLvaWb
	zajgYbOF31NF95ZmiZ2yqrnCvbICh1o+TpNGMW765in6U4epNitL1PSK9xCx/QqYu1+7RfQEsr2
	C+zGmXIBFfHSTYxMKw1+K/M/2OI8yCh0/Fg/8947nmigA0WbxgEUb2ys=
X-Google-Smtp-Source: AGHT+IFw6WVMmRbfeCulx0Qcu7+MYCUDH2/Gstw7avVYSKc5ugMp3q5+vqfnepjv+lEyBLYf40G3wpFKkTqFKEPC8vR9xaqfI+Sy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3082:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3d6e3f06875mr123669375ab.8.1743942748815; Sun, 06 Apr 2025
 05:32:28 -0700 (PDT)
Date: Sun, 06 Apr 2025 05:32:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f2745c.050a0220.0a13.0268.GAE@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in sw842_decompress (2)
From: syzbot <syzbot+8f77ff6144a73f0cf71b@syzkaller.appspotmail.com>
To: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	ebiggers@kernel.org, hpa@zytor.com, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    acc4d5ff0b61 Merge tag 'net-6.15-rc0' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e6694c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=845c633207fbfb03
dashboard link: https://syzkaller.appspot.com/bug?extid=8f77ff6144a73f0cf71b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e1f70d143e1/disk-acc4d5ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e092d734e65/vmlinux-acc4d5ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a8aec6915ea/bzImage-acc4d5ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f77ff6144a73f0cf71b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_be_base+0x255/0x2b0 lib/crc32.c:131
 crc32_be_base+0x255/0x2b0 lib/crc32.c:131
 crc32_be_arch+0x3d/0x50 arch/x86/lib/crc32-glue.c:77
 crc32_be include/linux/crc32.h:28 [inline]
 sw842_decompress+0x167d/0x1840 lib/842/842_decompress.c:385
 crypto842_sdecompress+0x45/0x60 crypto/842.c:57
 scomp_acomp_comp_decomp+0xa8d/0xd90 crypto/scompress.c:-1
 scomp_acomp_chain crypto/scompress.c:297 [inline]
 scomp_acomp_decompress+0x39/0x1e0 crypto/scompress.c:313
 acomp_do_req_chain+0x39a/0x9f0 crypto/acompress.c:353
 crypto_acomp_decompress+0x5f/0x80 crypto/acompress.c:378
 zswap_decompress+0x561/0xe00 mm/zswap.c:1018
 zswap_load+0x296/0x660 mm/zswap.c:1678
 swap_read_folio+0x691/0x3290 mm/page_io.c:643
 swap_cluster_readahead+0xb48/0xbd0 mm/swap_state.c:638
 swapin_readahead+0x205/0x1690 mm/swap_state.c:814
 do_swap_page+0x982/0x9c50 mm/memory.c:4532
 handle_pte_fault mm/memory.c:6000 [inline]
 __handle_mm_fault mm/memory.c:6140 [inline]
 handle_mm_fault+0x3ea4/0xe360 mm/memory.c:6309
 do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x41e/0x750 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623

Uninit was created at:
 __alloc_frozen_pages_noprof+0x6a0/0xe30 mm/page_alloc.c:4957
 alloc_pages_mpol+0x4cd/0x890 mm/mempolicy.c:2301
 folio_alloc_mpol_noprof+0x57/0x1c0 mm/mempolicy.c:2320
 __read_swap_cache_async+0x2b6/0x980 mm/swap_state.c:403
 swap_cluster_readahead+0xa94/0xbd0 mm/swap_state.c:635
 swapin_readahead+0x205/0x1690 mm/swap_state.c:814
 do_swap_page+0x982/0x9c50 mm/memory.c:4532
 handle_pte_fault mm/memory.c:6000 [inline]
 __handle_mm_fault mm/memory.c:6140 [inline]
 handle_mm_fault+0x3ea4/0xe360 mm/memory.c:6309
 do_user_addr_fault arch/x86/mm/fault.c:1337 [inline]
 handle_page_fault arch/x86/mm/fault.c:1480 [inline]
 exc_page_fault+0x41e/0x750 arch/x86/mm/fault.c:1538
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623

CPU: 0 UID: 0 PID: 25609 Comm: dhcpcd Not tainted 6.14.0-syzkaller-12456-gacc4d5ff0b61 #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

