Return-Path: <linux-kernel+bounces-740847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1394FB0D9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4833F3B2387
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB112E498E;
	Tue, 22 Jul 2025 12:43:38 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC12E3701
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188218; cv=none; b=PokF6gaVzJg0h7WKyFjHaul8jJghItwKKd/TCao/Ak/Tp8m5MWw0YMa/hc1/G+A4QqU8ZsEx8l+A9yMgrUyK5TUnuDQeC4I4Hh5GT3xraKi9vXPm39NlzOZ/EAhk5AEtJ1+259unBduQv3GVL44LiKrlpab3omru41mgrBiQcrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188218; c=relaxed/simple;
	bh=OEEo5QZ0zrycMs4eocYeRQEGw9OPdWr5gFXO/9eQzhU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c6Agzk63T3dMPIc1UW6DnMUHC+niHqDvUMQOyt2ViT/CP2Yk0CqTKynPMVVIgPsRJt3XxnZsg4igB1Yx2OIuAkaYeUBUzeXfHqYpZlmc6CtBShZPqwS6NL0NKNSAzc8gdRUwojGFuf6XN4z2WaKf3RqaImsfEKJZvPMCs2kptSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c43c2af72so208047839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753188215; x=1753793015;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCK/CoDQa4+fiUlH5iG7Umnl8iLRsK5lK8skAbpq76I=;
        b=PZ4UTV7fgV/OcEryvYs9oaLQ3Q+bbDclozg4cnDD6AZdICkHT5eWeVRP2ScXGimPK2
         v8jFnFC8XLFhmf1yv86YY+5faWzogXCrvOKDqqM6nik3WBZIc/pqvvxyoXAVUO37pX3t
         uBDJzAO4dtuQS/SoNI6aWVOfm3TJICLIxAeBw8MYi+yJpTljss/h+vkNi0fCLEK04hq8
         sdhcLopnaQG5E/MHBvXdzi9r7ib/jw+z+aL9fD0GqW9K8l8WBRc1BPhlY4kLgHPLszTN
         vqkPFXuUeryBKhuwPByLAYA4W5P1Vz+AaKTtRzSrNZSL2brr0295uQZMo50jtDZ16F/F
         5V8w==
X-Forwarded-Encrypted: i=1; AJvYcCXhUgaVWMXwULdn6Prix0LN1nlN8Wd8//7jWBFaUWqaGdXxoV44DiZSbICl5yTWX2NpugKyFzMYhSuhzI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbddj+rRbFgl1036HSWxX9QiJuGxItt6mV7GK0SoqiukGMjhdD
	VpEK8RwwpouINX5m43vhNbIprdTA4d6j/xnPlhZHgJbpeHeZfciKUCCYFW0Wjrq0Sj2B3AvAhE3
	I5cy7R0c6MTorNQ+x7cx7WRuCaRhY5Meen1oyTMaXQ9XunM/oQFrw+e11sNc=
X-Google-Smtp-Source: AGHT+IFJQbh/pzXQNp9St2OMEZQF7qEK8sDQHk1iqLkUqW77BKWGwVl/IhabTazb6kYBuQBXMUajXBW6sDifu8RTq5PooVRf+KlE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:5110:0:b0:87c:bf5:c242 with SMTP id
 ca18e2360f4ac-87c0bf5c480mr1943777739f.3.1753188214817; Tue, 22 Jul 2025
 05:43:34 -0700 (PDT)
Date: Tue, 22 Jul 2025 05:43:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687f8776.a70a0220.693ce.0102.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Jul 2025)
From: syzbot <syzbot+list7cfc8445997df7df0f0f@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 53 issues are still open and 60 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  57987   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  30948   Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<3>  28598   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<4>  6827    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  4026    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  3466    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<7>  3309    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<8>  3083    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
<9>  2413    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<10> 2364    Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

