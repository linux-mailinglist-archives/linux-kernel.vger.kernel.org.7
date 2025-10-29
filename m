Return-Path: <linux-kernel+bounces-875566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BFFC194E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76DB9427BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235372E2663;
	Wed, 29 Oct 2025 09:02:32 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F332E540C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728551; cv=none; b=N3b2upYawChB41mF+jZxeZxpmN3EvfSCCDPt0+DPLVMQ0NLV89XdQJ423uaUUhmBobVY6/h2DUgHjG94TRPgNfabbeVhI0jpD0pQqUIuEI3icNFNUUg8aE+NTKuQSrsg65TKbN1A/6sfJ/mDBQUw0WLJtUpQIqe4TvbGPckRapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728551; c=relaxed/simple;
	bh=IGp//apSYf3xJnXNtYFq4vgpO8WzhcHSiGUA4uYI5VA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eaxPvrjaftxc9xNAtirX7wWZHsJB5uJppyYP0Yf3VBmDrbKHmav8PrfXA2GHO73YvkPenqeXS3wzOU+PpNUbCq+yH8fbkIA4GYPEIkysW06NBQBkiBxEMva0dbgdhXhpcFZCLLHVm0cIDkqXz9qVy8iAsS28wcMCT4YI333b3EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430b3c32f75so73282115ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728549; x=1762333349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDiNn0o0Y3/3Q2x+pgZ37f8gFa+KMWmtZRIWR8KSINE=;
        b=I32Jd9pFsRKCCBiaC/aF/UFOWYbsvV9ue2xukno72XBjAijiRCE2XMdRTzt3MlHKm+
         ryGjl97yi2VXy6zutEapGWUpew8W9GKg3GeVZweRPjP6+PMnKho3yh+PKt66rFebMQcT
         TTKjc50YvzCGu83HLs8TOKk5cE0d81Ignwosy7ioKHiijFgogbQbsJDNHZsnkQuIJBjs
         9fSjP2NpMRt74cjURkM+Eg4PVgDgt3ssHz91bX70uDbrJfZMiEmRimR6piyaaXXTqKSI
         h78gUlQa4m3p2UKhi86F0tHm62BGNuBRH+uwQxhX9Fk34zADvH4Ou3JoTXp8JHPqV/iw
         9s5g==
X-Forwarded-Encrypted: i=1; AJvYcCVwlYIWBbpkW/Jectz8DkBNhFAwSwiPkBGnm1PCClOKA76KiwZuENuyNxiilCvby8wSo4BNGwAlIYcCafs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJ3GOVY433EnrXtq1piqCZ46MCVnKxiegJ7gVN9SrV03OTJNx
	z6gC8a/ZOp4/kgiUd3yp58HQM9sf5MqGtqGl7O4fqrQnJn9+VG4wRWkvgyIpyIF3LGKiNjo0Js7
	4Wp/dbivOf3mukr8Ko2KVzNR6S+kkATq6qXeqyVyGD868IkOocqRDPFHVDk8=
X-Google-Smtp-Source: AGHT+IEAk6pcodBPz7ol+NODHQ4h/HlMF+kCyIxpEZYFrncWqLRSijkd27y8TIFm9PoYsp2YosgHUZhH84YW9v5Ym4dXM91SidPB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:42d:7d2e:2bff with SMTP id
 e9e14a558f8ab-432f9044a31mr25339495ab.22.1761728549311; Wed, 29 Oct 2025
 02:02:29 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:02:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901d825.050a0220.32483.0205.GAE@google.com>
Subject: [syzbot] Monthly ext4 report (Oct 2025)
From: syzbot <syzbot+listc16d6233751953300e09@syzkaller.appspotmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ext4 maintainers/developers,

This is a 31-day syzbot report for the ext4 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ext4

During the period, 3 new issues were detected and 1 were fixed.
In total, 50 issues are still open and 163 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3903    Yes   KASAN: out-of-bounds Read in ext4_xattr_set_entry
                   https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
<2>  2813    Yes   kernel BUG in ext4_do_writepages
                   https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48
<3>  2779    Yes   INFO: task hung in sync_inodes_sb (5)
                   https://syzkaller.appspot.com/bug?extid=30476ec1b6dc84471133
<4>  989     Yes   WARNING in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=fe42a669c87e4a980051
<5>  572     No    KCSAN: data-race in generic_buffers_fsync_noflush / writeback_single_inode (3)
                   https://syzkaller.appspot.com/bug?extid=35257a2200785ea628f5
<6>  493     Yes   possible deadlock in ext4_writepages (2)
                   https://syzkaller.appspot.com/bug?extid=eb5b4ef634a018917f3c
<7>  269     Yes   INFO: task hung in do_renameat2 (2)
                   https://syzkaller.appspot.com/bug?extid=39a12f7473ed8066d2ca
<8>  266     Yes   possible deadlock in ext4_xattr_inode_lookup_create
                   https://syzkaller.appspot.com/bug?extid=d91a6e2efb07bd3354e9
<9>  168     Yes   kernel BUG in ext4_mb_use_inode_pa (2)
                   https://syzkaller.appspot.com/bug?extid=d79019213609e7056a19
<10> 140     Yes   KASAN: use-after-free Read in ext4_find_extent (4)
                   https://syzkaller.appspot.com/bug?extid=ee60e584b5c6bb229126

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

