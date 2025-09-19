Return-Path: <linux-kernel+bounces-823858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E4DB8796A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BA344E1F89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08822069A;
	Fri, 19 Sep 2025 01:25:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693D1DF24F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758245127; cv=none; b=YYHoo37PTOVQkcoNRh40063UUBupeC7O9t46kimJvHbDZFrEzTw6Tx4fVefmUQKMmG0syfaEYTIRmQLE10Jlj+8/AJG6PibOUG6VTngX27vrPfd0nK4bPgDfz948wzgdyJ6lS4uWSrIr5Nc8MEljCwZDH52Zy1E/cNi0S+y/kbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758245127; c=relaxed/simple;
	bh=3B9U4B/eTulQQ96ZL9HHu9UCYkkDDwmq7C89BSwRt+0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqKuYv9gMqFyx0/e4b2InQEyZ0gKwx1IMuTC5fvCcvys3uWD9g3A2COJxjZ5vR+NRDYG+dl6Y0s5ZIZSZpYAMfr7HtgrIoDcjveG8UWfw3/sZN0JmXEUbNggxejZtM/o4JLFdlzM/dGJuCbHwYXWqU4h78T1eWZ6Up9n1JBiglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f65e91bfa9so38460115ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 18:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758245124; x=1758849924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWxrNtHYVry1r3GcKuFRysHU2zDdASQhNBPs4OPIWdA=;
        b=L4A/Oem/Q05ESmDoV/MmHAIJujdtPfNZes0zZu2ftj8T5ZKs3QvFGuNB+6VCcvBLA6
         wskllLQcwMI1OSkNSpsJCWgwkFHJMX/KaSSluGJwkPzpQuRn0yh05ER6L9N3RfJENAWf
         tFQ1onW9FAa9uU/CXYSPk/bxMZUV0+VCJ/0KOAj5lV3hHpdCWx0Owk+USB/g/J9D56Ed
         7WCp0avajzH1A6nYC9lr07Q11iYe16P/czKkW+cYXsLJ45Q3IR7z9n9TGQc3nSK1ulTB
         vqr7LPy/hdjW52IEetxP7zZX4Dz5kcyku/OdeEq5SSAvOrAEg4mmI7M05kKNMsyI15Cl
         9Xmw==
X-Gm-Message-State: AOJu0YxT/hEaklKP33U6T5RJY+uzSJQO6r7bnRMnIxEq5y5D05VBnaRZ
	MkSaCO6LrK+DepBBDbWyIdbEIxx7yiP8fllDGjQiUXgUcu/XyUt5OOJ+QxaKWDQulsGcGBuoV0m
	IT9yOPpwokNyy+nw7XPo/lfQB/VdLZjxGpOS9+EiAHc6vFp4Y96iYz+eAxJU=
X-Google-Smtp-Source: AGHT+IFpNawJ9Nxg81L7uE0mpGHfBdfzZiShESHAooIxOZHToZEtzzfPDtDnBjwb/mG9F/RGL2oE4InLVc9Udv1OfNv67bT9O9ib
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:410:cae9:a089 with SMTP id
 e9e14a558f8ab-42481922e1cmr29256175ab.2.1758245124617; Thu, 18 Sep 2025
 18:25:24 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:25:24 -0700
In-Reply-To: <68c7c2b3.050a0220.3c6139.0d0d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ccb104.050a0220.28a605.0014.GAE@google.com>
Subject: Forwarded: Re: [syzbot] WARNING in ext4_mb_load_buddy_gfp
From: syzbot <syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] WARNING in ext4_mb_load_buddy_gfp
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

From 24ea14fccda1e40b265a9f79b865958e215b240c Mon Sep 17 00:00:00 2001
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 19 Sep 2025 06:49:46 +0530
Subject: [PATCH] ext4: fix allocation failure in
 ext4_mb_load_buddy_gfp

Fix WARNING in __alloc_pages_slowpath() when ext4_discard_preallocations()
is called during memory pressure.

The issue occurs when __GFP_NOFAIL is used during memory reclaim context,
which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
the current process is already in memory allocation context to prevent
potential deadlocks and warnings.

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..61ee009717f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode *inode)
  list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
  BUG_ON(pa->pa_type != MB_INODE_PA);
  group = ext4_get_group_number(sb, pa->pa_pstart);
+ gfp_t flags = GFP_NOFS;
+ if (!(current->flags & PF_MEMALLOC))
+ flags |= __GFP_NOFAIL;

- err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-     GFP_NOFS|__GFP_NOFAIL);
+ err = ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
  if (err) {
  ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
        err, group);
-- 
2.43.0

