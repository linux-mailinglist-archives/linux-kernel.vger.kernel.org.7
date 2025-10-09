Return-Path: <linux-kernel+bounces-847038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450DBC9B63
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7449C3403C5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416912ECD3E;
	Thu,  9 Oct 2025 15:12:27 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AE3595D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022746; cv=none; b=iOFY6U1jC+B8YjozpOcOAB2lnHeZF91B4wddz6MHiMBe/K705v8bMbLsgYaLhcOa5t/b/QlbCtla7Pr6nDIGSWV7VrPSwQ+YgbweTwBrvrJdblE0OPfWEKa9zqLiUzXy7uGclFKHTTInQGd6gCzSvMfxTFjW1/mCgCg8gBTFCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022746; c=relaxed/simple;
	bh=OrfBHu462u5miL7zNgpdeFg45TR78pvZ+llzmEVQRrA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MsrwlZJnT25YfgBF4+lrrcYjX8kmlLs8fVdY9JmTdFLatqs4oQKeV33W7u2oV/4OYI5rI13X28AU262jz3aFWsC3rhCzMAvhbI58SnLOzSM0eVSTmiec2RYXctzPzuquOtY4N4yHz3qYuDh7enLO8WYXpo0h/wL4SR2eTuCkg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-930db3a16c0so400841539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760022744; x=1760627544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzvlDmP3GPPuphXcMJYFAQvUdjy5O+VQjGl0Edw6854=;
        b=PtmSBbcKxY5/xUlgckpuTRo4wDU6qYzb1Pas2oT4Ijw6JuSm1hebX5n8+SthxlQn2G
         RtHQG3ouvW97oP78lOLPqTQnDFRHV2Pi7r2sCC+Axx4opaczu5XZ138KbBRG2BtXo/K0
         Yk7DCCvykiuVLpYdgzpOsGnMmAcYFTdK68nyGJhkwf6ds4M+Oz4gZFfy47g2d432TlPB
         bGum+QcQFBFOvYAzGyeNA/OHJdMqpbQFmKrXYWcbKiER1Dcq4RcWJ0H2CHyVT+OEIyok
         4kEnGofzmH3YBzgOcGzJgzwdGeyUpDGKW3ERSJsnQR/1gfvdzbQlxVJdOWqr/5ezkK/e
         pcdQ==
X-Gm-Message-State: AOJu0YyKOv0PzXfF3mSdcHUgVwz5YXmYGuMUe8exlUd9IPo37Z+SgoOP
	/lMgg/wkn/QFqUCzZxtR3M1HqT/2qDjtS/dMVZpZYyGIeU4zbgzsu9944qN9dpEIVUy+dLFYOus
	ylT9czYfvn/52tK7dExv5xlJM6EUVA3gqts8PnADeD/tfMu0zykhNgYvfy4RO/w==
X-Google-Smtp-Source: AGHT+IFpHgVhK/eitPn+A4/rJDaEPue9oMnW/JUcIn1VlC7yZ+MHgwL5jUZq1iSRAaF1MRag01/5xUx86O3yiX7H6K4h7RZBMQ7W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c09:b0:919:629f:9770 with SMTP id
 ca18e2360f4ac-93bd192916cmr909234539f.10.1760022744236; Thu, 09 Oct 2025
 08:12:24 -0700 (PDT)
Date: Thu, 09 Oct 2025 08:12:24 -0700
In-Reply-To: <68b3985f.a00a0220.1337b0.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7d0d8.050a0220.91a22.0008.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: vmalloc-out-of-bounds Read in run_irq_workd
From: syzbot <syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ec714e371f22 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1284a1e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
dashboard link: https://syzkaller.appspot.com/bug?extid=2617fc732430968b45d2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1200b458580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a24b34580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6d5cce2bcf5d/disk-ec714e37.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/60dff1e3a58f/vmlinux-ec714e37.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6a1823720b55/bzImage-ec714e37.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in irq_work_run_list kernel/irq_work.c:251 [inline]
BUG: KASAN: vmalloc-out-of-bounds in run_irq_workd+0x116/0x190 kernel/irq_work.c:305
Read of size 8 at addr ffffc9000cc08090 by task irq_work/1/26

CPU: 1 UID: 0 PID: 26 Comm: irq_work/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xca/0x240 mm/kasan/report.c:482
 kasan_report+0x118/0x150 mm/kasan/report.c:595
 irq_work_run_list kernel/irq_work.c:251 [inline]
 run_irq_workd+0x116/0x190 kernel/irq_work.c:305
 smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4b9/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc9000cc07f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000cc08000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000cc08080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                         ^
 ffffc9000cc08100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000cc08180: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

