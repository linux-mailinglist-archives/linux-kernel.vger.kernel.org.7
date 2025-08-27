Return-Path: <linux-kernel+bounces-788406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82795B383ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7245117D377
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BD53090CB;
	Wed, 27 Aug 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sJSE5qE"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641C35336C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302334; cv=none; b=E3c/fZ3EBlZIMTv/vV4XbydFSvfPV4GtCnLSGX7xMTd8j3KF+CCtffv3qYgYgeNFxjylInImDudR0mg+k9WbIACP+v/UigaxjwcHjf6puGYKxXCg9U/xpQA7UXcxzepJfnmUsnANrnmh19vlM+lBkJm/h+f9WJtk1jcVn/n735k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302334; c=relaxed/simple;
	bh=ZX8SMIBgQ95qntVf9YS1VBrO7bMmM4Wa6bSxjIC0AZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elOyTnT1knOx3ZP/T0trwdUL2u7sYTJCQcyIcEPXQmGvvYwqOPTGp6YHGMliSkxsgOIbnmoqqYLvg1f3VTGB/beypjhoeQ7bG1U3tE3ykaZXg0HAeMmGPVodAgMfIhsCX4eBzvZYJOTfpcZN9hguaA1ivlOcRYk02zdS8HWEbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sJSE5qE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74542b1b2f7so325013a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756302328; x=1756907128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpeAyXHMygB6Vp8avv/l/2pS0bBbs9F68uJjKNzJkaA=;
        b=4sJSE5qE9ftLzt0wFXDoQ9eY/1b+PNvH/nPwUEbDEeTXQmlYaVVlgNAkH2DUhRNVlR
         MZJNFM3AJRT1yQ9yNSEu4aPRMCimZon73WVlGPDeM2QYy/Lq9PR1J3phqP78lj4UU8/E
         +xXM3ipr4CqlGPOoULhhJDN/giIFQFMm7b0X1w4V9PvFcgXN7qLqNc7f/GSkTRCvJdJ+
         DPwfFwCGXNuBxVZPzWDLms+kIRARAKuFxEEDl160NC0uxuCbxCBqFtZg0y6KUyGoq1Lm
         khJ902NKEPygHBKw66/2ahpxlEG0EcoETJBKe7V6mvu3niItLQf3OdDf1Pfa9zwJPr+7
         dScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302328; x=1756907128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpeAyXHMygB6Vp8avv/l/2pS0bBbs9F68uJjKNzJkaA=;
        b=c11PmeRVU58MEN9FLLETLfdJmaE82mPByzPwDxQ47z4n8lVGa4qYMaZhvLIDh6UOPB
         7Y4pDcfxhBzPHYvX76OF0Ks40LfDKUHUN8ReKw9wCbWsIB4PjdfNlVBwiLOYScHWRm4O
         58LcFkPe0Mlkf1834v37RtYKdwvd5pCX7/uEZ0apZt3NtIRAQT+zGyPFXgf/Lel2O3kh
         VMGwtIQdPN308K6iol1eh+ZcKgtdkwOde/qxVoHYGJbrr5VzPdJ0DTYnEHLkcDN1CDk4
         K7MfOWeGgMNLZ93kp099ojyeHeRgTDBw1f3JFTMM48HpBaATcGypM7q6sABdebKzG+F1
         5Anw==
X-Forwarded-Encrypted: i=1; AJvYcCUABssAAFKZDQSgmBAOfqaky17BcI7hyOeU4cUaOUsN9bnS7AflqNpgdP3Gg0bTAlrAUSGa/YzSP81+XMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2As4ReLHi8Dv1rQI4cLvf89mWvjjVYlq4jZu78ZLRL0vdGFU
	Ur72KEaG6foyPrsgyk8r1NrvUvrOAeKw49tk7mCL6RLTYHvqqhsibHDeGtHtJWDRDLfxR+mgR1U
	2aTeoWFS0md8uRdUOV6YTBWd/jX2DEieKMohKVC6y
X-Gm-Gg: ASbGnctdpBYkaky1biMqzionm5lTmpaXlU6aJOQpkpopGsAairuDAj6f6fbag5pBYI+
	iD+LwsVISZJ1uwC9VXlc6ClzZQ9pXVAZy/kMT5Zb8HmLD0PjoxiTJUNQpI023PMdY1USaprIvuG
	8HhPv/HBNkKBIhsrheYpkSwY6YnVet/MxqdQaQ9HRRhMSaF/qu3vW0kMrj6MgiA3VkRewfPmIrd
	zw6VfPf2DS/E/eNAxuvXfciquVlZ05c/EnMYh1Mp1SKO9gKy64KJYk=
X-Google-Smtp-Source: AGHT+IGK7wifIZTut20YoDMzlxEGyZdNXsXaZZswhXERO89C+jJhJO5osaSyoHUdvFiNWYFFLseH95HRoPKQiuu2iAE=
X-Received: by 2002:a05:6830:60cf:10b0:745:1905:af2d with SMTP id
 46e09a7af769-7451905afa6mr4676726a34.10.1756302327478; Wed, 27 Aug 2025
 06:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68a841d7.050a0220.37038e.0051.GAE@google.com>
In-Reply-To: <68a841d7.050a0220.37038e.0051.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 27 Aug 2025 15:45:16 +0200
X-Gm-Features: Ac12FXy3XsS3r_1Xsoljd22xWwY_l_Rgh701RqGb2u2OIv6ofdVJaEbx_TPotDk
Message-ID: <CANp29Y5zWmwXDq1uuzxi43_VXieykD2OOLF12YvBELCUS_Hibg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] [mm?] linux-next test error: WARNING in __folio_start_writeback
To: syzbot <syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com>, 
	joannelkoong@gmail.com, David Hildenbrand <david@redhat.com>, mszeredi@redhat.com
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've bisected the problem to the following commit:

commit 167f21a81a9c4dbd6970a4ee3853aecad405fa7f (HEAD)
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Mon Jul 7 16:46:06 2025 -0700

    mm: remove BDI_CAP_WRITEBACK_ACCT

    There are no users of BDI_CAP_WRITEBACK_ACCT now that fuse doesn't do
    its own writeback accounting. This commit removes
    BDI_CAP_WRITEBACK_ACCT.

Joanne Koong, could you please take a look at the syzbot report below?

On Fri, Aug 22, 2025 at 12:09=E2=80=AFPM syzbot
<syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0f4c93f7eb86 Add linux-next specific files for 20250822
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D172c07bc58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D21eed27c0dead=
b92
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0630e71306742d4=
b2aea
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/669ede8f5d66/dis=
k-0f4c93f7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/50feda89fe89/vmlinu=
x-0f4c93f7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/317a0d3516fb/b=
zImage-0f4c93f7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0630e71306742d4b2aea@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: ./include/linux/backing-dev.h:243 at inode_to_wb include/linux/b=
acking-dev.h:239 [inline], CPU#1: kworker/u8:6/2949
> WARNING: ./include/linux/backing-dev.h:243 at __folio_start_writeback+0x9=
d5/0xb70 mm/page-writeback.c:3027, CPU#1: kworker/u8:6/2949
> Modules linked in:
> CPU: 1 UID: 0 PID: 2949 Comm: kworker/u8:6 Not tainted syzkaller #0 PREEM=
PT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/12/2025
> Workqueue: writeback wb_workfn (flush-8:0)
> RIP: 0010:inode_to_wb include/linux/backing-dev.h:239 [inline]
> RIP: 0010:__folio_start_writeback+0x9d5/0xb70 mm/page-writeback.c:3027
> Code: 28 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89 ff e8 ce a2 29 0=
0 49 8b 07 25 ff 3f 00 00 e9 1b fa ff ff e8 7c 04 c6 ff 90 <0f> 0b 90 e9 d6=
 fb ff ff e8 6e 04 c6 ff 48 c7 c7 a0 f8 5f 8e 4c 89
> RSP: 0018:ffffc9000bb06ea0 EFLAGS: 00010293
> RAX: ffffffff81fad344 RBX: ffffea00050de8c0 RCX: ffff88802ee29e00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc9000bb07010 R08: ffffc9000bb06f97 R09: 0000000000000000
> R10: ffffc9000bb06f80 R11: fffff52001760df3 R12: ffffea00050de8c8
> R13: 0000000000000000 R14: ffff888023060880 R15: ffff888023060660
> FS:  0000000000000000(0000) GS:ffff8881258c3000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f7354907000 CR3: 000000000e338000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  __block_write_full_folio+0x75f/0xe10 fs/buffer.c:1928
>  blkdev_writepages+0xd1/0x170 block/fops.c:484
>  do_writepages+0x32e/0x550 mm/page-writeback.c:2604
>  __writeback_single_inode+0x145/0xff0 fs/fs-writeback.c:1680
>  writeback_sb_inodes+0x6c7/0x1010 fs/fs-writeback.c:1976
>  __writeback_inodes_wb+0x111/0x240 fs/fs-writeback.c:2047
>  wb_writeback+0x44f/0xaf0 fs/fs-writeback.c:2158
>  wb_check_old_data_flush fs/fs-writeback.c:2262 [inline]
>  wb_do_writeback fs/fs-writeback.c:2315 [inline]
>  wb_workfn+0xaef/0xef0 fs/fs-writeback.c:2343
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
>  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

