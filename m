Return-Path: <linux-kernel+bounces-833656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3796ABA291A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E446356128E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ED627D77D;
	Fri, 26 Sep 2025 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdTxdaxg"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8A8F6F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758869304; cv=none; b=I1UBJQ9QhqJGAPs1BCWsVdu3XCjHlpHPxaYAkIIBgi2FGguraw7xYVMS8qJiRvVum4Oz4yrKH0pwvgobWaktAIxOT2ms+SJCRA2fp7xtf4Ws3zurtgTRxxozYMrSLt0ONY/NnKVefUVArTcC71qMLaHpDqHb6/+Ivylf28T/IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758869304; c=relaxed/simple;
	bh=t1mgwziuQgYdtYzvQ1tc7owsSFqhrDeGItfKOMdbfhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHGpX+AUhN1cd+HipCPE13wGuh9OXVYWfv4AaKRvSqaZ3jGeXlFpKv0209wfyBbJ109RDUkl80ZfOFHZyjHp4I7ZutalkT2U6oJe+mAw96TIBB8IEGIrgHoeSxUiGJ6nAWQ68YyWmFwLroBWSavq2WPJK0BIkCTZl258Emb8moY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FdTxdaxg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26c209802c0so19889675ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758869302; x=1759474102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aJgWHabvDduY7CKx07HtPWunby2WlRQjkpPq1jpmCK4=;
        b=FdTxdaxg00J2o5eqqWim+WdMLZbN9xM4PxvksNg39lkx0VNg+vJUEGG8cgKtJv7mvb
         jFF5rpaoSa66YJpcC064/8AgB/uIDIh8beF9RqpExVcOjSBByr1VTPv21CwnFpXAkiYN
         zPBEqIbiIsVC2HceSXvBzTZHeJbCKfpt0WEkw05NwXIC5jBY1DI5qxSYcEq3OFBOdES2
         ErocIdd2jvlxiIWxtyBiE48eYBxD7n+SPphdfjRFq83ROPrX2yNJ9O0Nfk3TQ3E0neSq
         +jRaEDQo57tKh8KXog/qX267NGtC/9D4Z04jv0FU7e5i5UjymKOqloDcuCQeANxaxQoi
         0GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869302; x=1759474102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJgWHabvDduY7CKx07HtPWunby2WlRQjkpPq1jpmCK4=;
        b=FUNsjahyZvSYbKHbgjbwX2iFOjyDwCDWuR9cvlrl/u0+5Sh2xwg1XCKrnoL3h+Ye7n
         K3o62zDZ8fg/BD9+twB7aST4ApIq9GFV54L3a12n5meO2gvJw/jLrfQJZ4M0SZuzDZHB
         7rwcpnRlMHT8GQ8g7Zf6b1gt+HI8+0xATb3zeZDLwH63UEME+cZMVrljbRSdoAeD2bfV
         mh+0bQXVpDDrXMWzo8zwFT/pUI1oaqg2m9fFe6QgSxSEDNDUquEo+ohUYwuwCBG7CK+O
         PUp6pxZVJMWZAjG3ptAIHH6wT0MgynTSv/bf2Ddt4b5u8t1yrRl+BdnAeQVKUK1PS0R3
         ge+A==
X-Forwarded-Encrypted: i=1; AJvYcCW2qnIdUWmvXjP6fAP9JuhOG8EIvxPK7u58Rz8/eGqMDsP2bSqZsADbOYUTjH+Aun5JGGsb3FOY/7ENxck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfjCseImBjO0klr+e9a3u5fwEhbwgtR8Iu98LJzxhdm3cRbc2
	qOA5pKz2DGV67MXSgqLHf9Kw4uc7+O5c6OX2TsnsluNMwqQY46wn1ZsedPo+LaFbRrsB2sCE+pZ
	tXPDF2T1Afc6U30P9xoQ8an7I9AZOEMVXSxTyHXGB
X-Gm-Gg: ASbGnctgWl+4AuDoWO+KTRg3YLpMxSn3y//wa+7hd+aCATu3Do/r9267zQXtRrfRNFW
	LsCq/0LP0LhBXIPXkKdZuHJt3iQr7r8BQ+LDZQeq7CcYv5BLdaliS2NIibDN6T5+dwR5+8Hb+v7
	s/LMi26ZRKrxH8KRVXNK8wkMDO9AhweNLhGeGOa3PCFgS1JlluecPEWtyCjOc24M5sQonOCbKz6
	K++d+ucoo15KXJw0J7M99mLS/Hqme9hJ1cJqmxLe0lvUQ==
X-Google-Smtp-Source: AGHT+IFQ5dcE8jI9jLYWO3ZIojoAEp7kw7htpHJSMwq3UBPFdCKdp/gCcYtzso7T+qMu7jMyGkvqB3ynpVlhrrLt0JA=
X-Received: by 2002:a17:902:f78a:b0:27f:1c1a:ee57 with SMTP id
 d9443c01a7336-27f1c1af218mr11140145ad.16.1758869302047; Thu, 25 Sep 2025
 23:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68d6364e.050a0220.3390a8.000d.GAE@google.com>
In-Reply-To: <68d6364e.050a0220.3390a8.000d.GAE@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 26 Sep 2025 08:47:45 +0200
X-Gm-Features: AS18NWDuKHZOuTTHwXeZU7Mpq5jZFUp5-2GMJyGgVogYWdeZQykYphkIZQwvd7M
Message-ID: <CANpmjNMA4sOXAUdCpDDYz-4D9F_BaTFF8DL3Vkhx=q7vPfYG+A@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in try_to_migrate_one / zap_page_range_single_batched
To: syzbot <syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	harry.yoo@oracle.com, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, riel@surriel.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 08:44, syzbot
<syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cec1e6e5d1ab Merge tag 'sched_ext-for-6.17-rc7-fixes' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=145d4f12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6e0c213d0735f5dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=60192c8877d0bc92a92b
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/10b7c8fdfdec/disk-cec1e6e5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/cbecc36962db/vmlinux-cec1e6e5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/214f107d0a3e/bzImage-cec1e6e5.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+60192c8877d0bc92a92b@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in try_to_migrate_one / zap_page_range_single_batched
>
> write to 0xffff88810adfd798 of 8 bytes by task 13594 on cpu 1:
>  update_hiwater_rss include/linux/mm.h:2657 [inline]
>  try_to_migrate_one+0x918/0x16e0 mm/rmap.c:2455
>  __rmap_walk_file+0x1ec/0x2b0 mm/rmap.c:2905
>  try_to_migrate+0x1db/0x210 mm/rmap.c:-1
>  migrate_folio_unmap mm/migrate.c:1324 [inline]
>  migrate_pages_batch+0x6e1/0x1ae0 mm/migrate.c:1873
>  migrate_pages_sync mm/migrate.c:1996 [inline]
>  migrate_pages+0xf5f/0x1770 mm/migrate.c:2105
>  do_mbind mm/mempolicy.c:1539 [inline]
>  kernel_mbind mm/mempolicy.c:1682 [inline]
>  __do_sys_mbind mm/mempolicy.c:1756 [inline]
>  __se_sys_mbind+0x975/0xac0 mm/mempolicy.c:1752
>  __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1752
>  x64_sys_call+0x2932/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:238
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> write to 0xffff88810adfd798 of 8 bytes by task 13595 on cpu 0:
>  update_hiwater_rss include/linux/mm.h:2657 [inline]
>  zap_page_range_single_batched+0x182/0x450 mm/memory.c:2007
>  zap_page_range_single mm/memory.c:2041 [inline]
>  unmap_mapping_range_vma mm/memory.c:4020 [inline]
>  unmap_mapping_range_tree+0xfd/0x160 mm/memory.c:4037
>  unmap_mapping_pages mm/memory.c:4103 [inline]
>  unmap_mapping_range+0xe4/0xf0 mm/memory.c:4140
>  shmem_fallocate+0x262/0x840 mm/shmem.c:3746
>  vfs_fallocate+0x3b6/0x400 fs/open.c:342
>  madvise_remove mm/madvise.c:1049 [inline]
>  madvise_vma_behavior+0x192d/0x1cf0 mm/madvise.c:1346
>  madvise_walk_vmas mm/madvise.c:1669 [inline]
>  madvise_do_behavior+0x5b7/0x970 mm/madvise.c:1885
>  do_madvise+0x10e/0x190 mm/madvise.c:1978
>  __do_sys_madvise mm/madvise.c:1987 [inline]
>  __se_sys_madvise mm/madvise.c:1985 [inline]
>  __x64_sys_madvise+0x64/0x80 mm/madvise.c:1985
>  x64_sys_call+0x1f1a/0x2ff0 arch/x86/include/generated/asm/syscalls_64.h:29
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> value changed: 0x0000000000001645 -> 0x0000000000002165

One of these writes is getting lost. Which means highwater_rss is
lossy/approximate - does it matter?

