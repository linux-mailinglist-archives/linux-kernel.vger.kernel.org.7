Return-Path: <linux-kernel+bounces-753421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E57FCB182B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094AC1AA366A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FE226D17;
	Fri,  1 Aug 2025 13:49:38 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896004315A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056178; cv=none; b=c1dS1gw/i+tsLBuBCfm+UfhAY9nPxRwLG/KzxSc8JiwJJEjGYBGHMyO4M3gPdzATogDlNkrysF9mvjFA+zh+3UYkQv0dZgoqEoVmQzRYwDobSKyDztD10tKO5YoDjAvY1htynjYMW3q8G+66srOtP773l5kWWHmPw765B2K/Q8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056178; c=relaxed/simple;
	bh=vRGRmD2OF0jOgtUF3edWj9SRmfioDKKAcamWboIXP/A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kccBM10flSL4fHH24Fb3J3oKDXIK9vBF8h6HSDhyHNHouLvthvZUS2p4FnXZ/ZDIAhUgsCVHaNKNoubxaygeCl5ofFJ3kBkobR5HZn/HuDCRIFPO8lhSttNp6L2Oc+UzOSdLlnL2DdhZyM+ZduGAzKNqDoma7lfhc5qKXyZ0pOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-881571123dfso90081739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754056175; x=1754660975;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DNxgr3qm2Ys714TTlyjFVWm/rdUAMp9OJnDF2EXN9RI=;
        b=W12kslBz7aoXDdp4HgVSGUkJZwO8/EgbWDjOM1Xv/KR3UVP6j9VuXxpJ71PxdhSBl2
         tNTgejVK0ijy3FAKIAVU6UXm4Agd/6oKEF4dxrNuLpFIiGENjZgJmRC0wrLJKoTb6uCN
         kLudH5JDKSVcxKakI8rAmLlYOSjbdiSa6AVLqYxHO2djCLn/hrlo6keF5DWQpy7yLwno
         6TEYlaAUIfB45ziOI3oYDT9lAT357l7lxoCnp5tADaEEQOAMqtvnJiNJ5/s7ubAGQIDK
         6l6Dag9BDz7cChNNNnuJVsjsFifo0NMospBI6C8Mq3ZNIoCpiYabrRGTd/GPehSsjXfP
         1r5A==
X-Forwarded-Encrypted: i=1; AJvYcCVExjrhBYPs3gaRl+e/PeUcGZEMYRbUh6krwPiGcQrRcT+WEhHB65dsiKlAhL5D77H7fxe415ehUgOWB4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0marfMj6DbxGc9wWeNdSXN8Fz0XEsYsNHJYY8hGh1vAnxb8Tz
	RyKFa2NWqZv9/togFRVKZUc1Tcb4rjFkqWkv88aY+nC1oDl/G99Kl0SPJPtQF6Dbflo/W5gqmAc
	dCgC97vfnewWt23BTRBzdu02uqs6QiHv4b7iUGUBhsr+QPmckbtmrGZWsdC8=
X-Google-Smtp-Source: AGHT+IE9ILAeXIH6pfNIPFq5u3zg4e/2UfOHzvv7ZY8AwDOffvHcDlLYeRPK2nIi8mbZ6ddQbIoT1/RwZQRSBhNNjbjK3kYrJzfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3188:b0:3e3:d304:10d6 with SMTP id
 e9e14a558f8ab-3e4059b1cefmr101472965ab.11.1754056175666; Fri, 01 Aug 2025
 06:49:35 -0700 (PDT)
Date: Fri, 01 Aug 2025 06:49:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688cc5ef.a00a0220.26d0e1.006f.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Aug 2025)
From: syzbot <syzbot+list1cc30056768fee2fad99@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4275    Yes   kernel BUG in f2fs_sync_node_pages
                  https://syzkaller.appspot.com/bug?extid=bcdfadd9bda9988fa52a
<2> 1288    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 956     Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<4> 50      Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<5> 42      No    INFO: task hung in sb_start_write (2)
                  https://syzkaller.appspot.com/bug?extid=b3fba2e269970207b61d
<6> 39      Yes   kernel BUG in f2fs_write_end_io
                  https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

