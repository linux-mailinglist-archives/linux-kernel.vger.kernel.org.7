Return-Path: <linux-kernel+bounces-786106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977CBB3550E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D6D5E7EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC32F7462;
	Tue, 26 Aug 2025 07:13:36 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1F2F6173
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192416; cv=none; b=rK48KvNk1nVfixWx14gsR5zVWe5UgGaioRkpDrnSlqcinMFmYZ4NFTg5sEuf5iWfXCs+X+2tm53Db67mSUO9Ii+zHCop8xygb2PoC1tPlyZjdd8r0igaY5bRZCWVw2NxvmPsj1PyD06rxe7r7R1CU4J1n4VYXBuBCH3tEoGUoFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192416; c=relaxed/simple;
	bh=1FuBkqFIabgtFYenvUjjzRPxZoBYerHuUXc+RO9orlA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jVB78mu39s+QCBFWrdNxz11LjZ0W5PC2DdJ+R+hKFHZilyKQZdAlPBXvAeZhesv3BBnD/TZe7cqeNghynsq8kPpYSWJPsjbu21tKPc/rIcRPtjcLyUXAC9xv2zEIcdQpzkMH3bdUh210aE/odWRGXgvsRfLCN8sFq4NgBDN9alA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-886e2e808d0so134649239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192414; x=1756797214;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPUJLTCW+VGEQ1LsWf3zUxjP0zIDrdC0uYjAPHNBV3A=;
        b=O1s7iT6gboYyn7tiqj+E4d6FmIv/83OwiEynfm/RXjNLckz1PvXr7iKprqXeje6DIY
         YyFi9GjVHJ0FkHlQ+Wp+TTqTS1zblHIpQvxrKb47DnKFxL3QidNK1A/kYtnxgvAfLFSh
         DUaxrVEzV9C0l6oK9s59RMxHcDk7D7/2Bgfj0A+xNkeYMFJWmrtJRVaerWrwv0fV8Uel
         /Fq+9CUHbP2enMI8t8E2zwjQsjjVd+2P3aFja6LDpW6IOR/VhqEQ6IlejekNqyJY3h12
         FgSMQDHVN6yv14JQbNrnr3+bJT3NqAuqxNK2LRXxDhoAh83kpMS+LnKQho6DhDfn3qf/
         S9Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUp3+EwgvAvjlTyHRxp+dSXI6HLntI3RiR9U5GGsCeFe6EhEEnYXxQfKomWsY8Lr/gVTk1OgizZeFhMJBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1unuwMHOkC+EL+Ck68f9fPNd7vqak7oB8IB5E65ifNBRggokA
	xYCe3ZY6xh4SL9fjA7kD4ahlkV122lmoqJ0FMvNpdtvJrB86LZdiV/47udlBqfj2zKgYt4R5nFq
	j4xIx1ZND9wM/XOfdaxURGL1KBKKTjShPcC6QsacfrVc7+y7ZSQqr+J53Lhc=
X-Google-Smtp-Source: AGHT+IHkx0wZd2J60BKpDyIXDeNnPSsA78PqWlgb4F6xOsewL8rjHw4CMigtGvTSdkNr4EX8nidVXCZByFsqispjKvZQY5f+A6pX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:3e5:4631:54a5 with SMTP id
 e9e14a558f8ab-3e921f3be05mr243600775ab.18.1756192413798; Tue, 26 Aug 2025
 00:13:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:13:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5e9d.050a0220.37038e.00af.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Aug 2025)
From: syzbot <syzbot+listc4fd87023dbf3e7eff58@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  106342  Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  13601   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  9699    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<4>  4816    Yes   possible deadlock in hfs_find_init (2)
                   https://syzkaller.appspot.com/bug?extid=e390d66dda462b51fde1
<5>  4627    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<6>  4377    Yes   KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
                   https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
<7>  3343    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<8>  3050    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653
<9>  2736    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 2402    Yes   possible deadlock in hfs_extend_file (3)
                   https://syzkaller.appspot.com/bug?extid=2a62f58f1a4951a549bb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

