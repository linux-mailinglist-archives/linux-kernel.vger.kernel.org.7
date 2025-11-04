Return-Path: <linux-kernel+bounces-885350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C4BC32A34
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5138D4F53C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B9733EB1B;
	Tue,  4 Nov 2025 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dFRPhX8o"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E517233F389
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280760; cv=none; b=jdeSD+u/ZgMzchls6+oS8803tsSjELV7B/yM0iT2AUusgXscWdFbjmuTZIFo8MIxBORRpQ/Ur8e0QQ99RkxGtjPe9LlJ8WiY6zGr+0MqNeHAyQLPFxDU5DM7Suwpcxibq3+7CHBVnKxyd4nap9aJS8orrnRJf7Zkm1VSaDVbsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280760; c=relaxed/simple;
	bh=xQr66sfWcYDPdt1OZVxS5cHO8GM9E9VyMkXI31644oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXDLJKvhkDm8UVUH2a970uPGJgZJqemIr/RYDwBDGo74/MMPuWS5fIlfxp1ciExDhqAYuUX3wrxDltwuIFySWoY1WhZ5ikI93a9ER3cpA6Unw4ehKwpPEMUvQQXvVNqsSvYkT505+5xpjBdw0P+10XMcyuz0tZhkC7EPI6GhZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dFRPhX8o; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso4273280a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762280756; x=1762885556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPkYNb3AdFbUUvWyK5+IEaMU2KcLnkNB85urH6+U/Jk=;
        b=dFRPhX8oqsH6jubgf1gBo7jemKvHClcsXD1y/s38YhgMgYZQtMJb2+ZpH6+nlcfUpk
         7zUAlS86em3FVnrRrP13wv2X9lfTvcMSVuIg6MfvLm06PsBvuhqgIk3kI8nHEkgI65Vl
         F8mtL3HcccS98+KkK5a8SfIesPSlGIJdYY8CVUSMjkONTSftH4IsqKOv+xQO+FGo3ttM
         E7NK8VvIDNzv7HDaWBUhXoFpUv/aZNWHk2+9EsV81Njljp40rJciZzW8Ua4WJJoT/K49
         jKKlAeQeXjIgoIONia0SvPmDQvSLl8zDaoqKzZH63mYuKa+LJa1JlBZ3dU281qszTb0f
         lGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762280756; x=1762885556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPkYNb3AdFbUUvWyK5+IEaMU2KcLnkNB85urH6+U/Jk=;
        b=DIdXsfg+t6pCV1ITxbSlNh7HPu/or7ltyJaN4EGn6deXs/KKwS29GuFSR0ULhXItWd
         Gr45ab9+WPARVGEx9M1fIY1SJPW5VYFh68ithAhopjaJO7fga9+zV24FwkLPIw5ackdv
         2OroqY9eagjo/ZBsrjwpH35JM2dHnz6lW/bzjc2T6BraTS0i2k3NWvEwmg7xDbL28MMH
         u0RYWBtjjcB3mVcc+EmVYQf7lLOALF+5IjUU2U8Kynd8PMJ+f3xkcvtLhc8tqzrc2nGd
         Pp8TJGc+Gfb9Hq0OHHFR85CYf4DsWA+TgnJ7OO/a7FdkGznrNO6jfvq4GfTaLZudIslu
         4IDg==
X-Forwarded-Encrypted: i=1; AJvYcCWfWDWYP4x9fdFJiVe8ECXFLf46mFmJxHDfWpDsLJX5RmJliHwHZZh+Xado0gUDDIuL5dj7ZuYl4MxJZYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UappuNGembuHIAKv2zs5CaMW7b0P2byirTeczb+PrXmKxSrQ
	E0OakVqoRKMlmrdkLgzccxPElAjjN0Uq0SvaVi5TXZ8KiwBTxT8hfZZgKEKaJdNtZ+Q=
X-Gm-Gg: ASbGncvyzFEuDyqMJXuVgBs5mNfDZS5xeuC/4WdGdGHtORPpD1/poakRE4jQj++HfA0
	xej8BA1fpBqFxO7Cj5SCveOtFhfmUwa28aV+lxumDwbwKj4hA395AAniiqta2wxQqoX17GT0mQX
	UFf7wXe/nsQqRK9pN8wxyxRYatIqvkFLjFaAUcpf5yzFnLgcG0XzMBv2fqBKJAmZszyjaAoMXTc
	CT4xt5srS+QPXeYqTe0WrQeVavjtgP8ob+wJF4GTY3Y1oq2QfKEfoyJQLDWJ3mSq5U71qz1OEjf
	RSH0qyOAGGPf0V7ix46Tt8KzlrpGrdXIcINI7ibgELaRk7nQTYHIquFBQspU9ZDPyJjREacM+6n
	YloTyOpSoqzBRJkVn4b44QT2xgx6F5cXyGsDRd59jAaySDdIgQ5zOeQjgQXxLV2WMsmiLoJX7K0
	biJo4=
X-Google-Smtp-Source: AGHT+IFAz3YGZNVaEACS46pBOhwodMBp8mAa30t1ei+hvvakkC32yROwn5/v/BY4HZBMgQz5jF71mw==
X-Received: by 2002:a17:907:3f1b:b0:b43:b7ec:b8a1 with SMTP id a640c23a62f3a-b726529edfemr13155566b.24.1762280751465;
        Tue, 04 Nov 2025 10:25:51 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3d4asm277568566b.2.2025.11.04.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 10:25:51 -0800 (PST)
Date: Tue, 4 Nov 2025 19:25:48 +0100
From: Petr Mladek <pmladek@suse.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
	"amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
	brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
Message-ID: <aQpFLJM96uRpO4S-@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>

Adding John into Cc.

On Tue 2025-11-04 09:45:27, Joanne Koong wrote:
> On Mon, Nov 3, 2025 at 6:43 PM syzbot
> <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > WARNING in get_data
> >
> > loop0: detected capacity change from 0 to 16
> > ------------[ cut here ]------------
> > WARNING: kernel/printk/printk_ringbuffer.c:1278 at get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278, CPU#1: syz.0.585/7652

It seems to trigger an "Illegac block description" warning, see :

   1263         /* Regular data block: @begin less than @next and in same wrap. */
   1264         if (!is_blk_wrapped(data_ring, blk_lpos->begin, blk_lpos->next) &&
   1265             blk_lpos->begin < blk_lpos->next) {
   1266                 db = to_block(data_ring, blk_lpos->begin);
   1267                 *data_size = blk_lpos->next - blk_lpos->begin;
   1268 
   1269         /* Wrapping data block: @begin is one wrap behind @next. */
   1270         } else if (!is_blk_wrapped(data_ring,
   1271                                    blk_lpos->begin + DATA_SIZE(data_ring),
   1272                                    blk_lpos->next)) {
   1273                 db = to_block(data_ring, 0);
   1274                 *data_size = DATA_INDEX(data_ring, blk_lpos->next);
   1275 
   1276         /* Illegal block description. */
   1277         } else {
   1278                 WARN_ON_ONCE(1);		<-----------
   1279                 return NULL;
   1280         }


> > Modules linked in:
> > CPU: 1 UID: 0 PID: 7652 Comm: syz.0.585 Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
> > RIP: 0010:get_data+0x48a/0x840 kernel/printk/printk_ringbuffer.c:1278
> > Code: 83 c4 f8 48 b8 00 00 00 00 00 fc ff df 41 0f b6 04 07 84 c0 0f 85 ee 01 00 00 44 89 65 00 49 83 c5 08 eb 13 e8 a7 19 1f 00 90 <0f> 0b 90 eb 05 e8 9c 19 1f 00 45 31 ed 4c 89 e8 48 83 c4 28 5b 41
> > RSP: 0018:ffffc900035170e0 EFLAGS: 00010293
> > RAX: ffffffff81a1eee9 RBX: 00003fffffffffff RCX: ffff888033255b80
> > RDX: 0000000000000000 RSI: 00003fffffffffff RDI: 0000000000000000
> > RBP: 0000000000000012 R08: 0000000000000e55 R09: 000000325e213cc7
> > R10: 000000325e213cc7 R11: 00001de4c2000037 R12: 0000000000000012
> > R13: 0000000000000000 R14: ffffc90003517228 R15: 1ffffffff1bca646
> > FS:  00007f44eb8da6c0(0000) GS:ffff888125fda000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f44ea9722e0 CR3: 0000000066344000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  copy_data kernel/printk/printk_ringbuffer.c:1857 [inline]
> >  prb_read kernel/printk/printk_ringbuffer.c:1966 [inline]
> >  _prb_read_valid+0x672/0xa90 kernel/printk/printk_ringbuffer.c:2143
> >  prb_read_valid+0x3c/0x60 kernel/printk/printk_ringbuffer.c:2215
> >  printk_get_next_message+0x15c/0x7b0 kernel/printk/printk.c:2978
> >  console_emit_next_record kernel/printk/printk.c:3062 [inline]
> >  console_flush_one_record kernel/printk/printk.c:3194 [inline]
> >  console_flush_all+0x4cc/0xb10 kernel/printk/printk.c:3268
> >  __console_flush_and_unlock kernel/printk/printk.c:3298 [inline]
> >  console_unlock+0xbb/0x190 kernel/printk/printk.c:3338
> >  vprintk_emit+0x4c5/0x590 kernel/printk/printk.c:2423
> >  _printk+0xcf/0x120 kernel/printk/printk.c:2448
> >  _erofs_printk+0x349/0x410 fs/erofs/super.c:33
> >  erofs_fc_fill_super+0x1591/0x1b20 fs/erofs/super.c:746
> >  get_tree_bdev_flags+0x40e/0x4d0 fs/super.c:1692
> >  vfs_get_tree+0x92/0x2b0 fs/super.c:1752
> >  fc_mount fs/namespace.c:1198 [inline]
> >  do_new_mount_fc fs/namespace.c:3641 [inline]
> >  do_new_mount+0x302/0xa10 fs/namespace.c:3717
> >  do_mount fs/namespace.c:4040 [inline]
> >  __do_sys_mount fs/namespace.c:4228 [inline]
> >  __se_sys_mount+0x313/0x410 fs/namespace.c:4205
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f44ea99076a
> > Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f44eb8d9e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 00007f44eb8d9ef0 RCX: 00007f44ea99076a
> > RDX: 0000200000000180 RSI: 00002000000001c0 RDI: 00007f44eb8d9eb0
> > RBP: 0000200000000180 R08: 00007f44eb8d9ef0 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00002000000001c0
> > R13: 00007f44eb8d9eb0 R14: 00000000000001a1 R15: 0000200000000080
> >  </TASK>
> >
> 
> This looks unrelated to the iomap changes and seems tied to the recent
> printk console flushing changes. Hmm, maybe one of these changes
> [1,2,3]?
>> 
> [1] https://lore.kernel.org/all/20251020-printk_legacy_thread_console_lock-v3-1-00f1f0ac055a@thegoodpenguin.co.uk/
> [2] https://lore.kernel.org/all/20251020-printk_legacy_thread_console_lock-v3-2-00f1f0ac055a@thegoodpenguin.co.uk/
> [3] https://lore.kernel.org/all/20251020-printk_legacy_thread_console_lock-v3-3-00f1f0ac055a@thegoodpenguin.co.uk/

These patches modified the callers of the printk_ringbuffer API.
I doubt that they might cause the problem.

It rather looks like an internal bug in the printk_ringbuffer code.
And there is only one recent patch:

   https://patch.msgid.link/20250905144152.9137-2-d-tatianin@yandex-team.ru

The scenario leading to the WARN() is not obvious to me. But the patch
touched this code path. So it is a likely culprit. I have to think
more about it.

Anyway, I wonder if the WARNING is reproducible and if it happens even after
reverting the commit 67e1b0052f6bb82be84e3 ("printk_ringbuffer: don't
needlessly wrap data blocks around")

Best Regards,
Petr

> Thanks,
> Joanne
> 
> >
> > Tested on:
> >
> > commit:         98231209 Add linux-next specific files for 20251103
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1370a292580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3686758660f980b402dc
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> >
> > Note: no patches were applied.

