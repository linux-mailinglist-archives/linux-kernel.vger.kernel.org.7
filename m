Return-Path: <linux-kernel+bounces-598007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72967A84126
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 12:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F2F1B80C49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 10:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06138267F7E;
	Thu, 10 Apr 2025 10:47:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2826B972
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282049; cv=none; b=goJfR7SkVITkxlvrA9qNbjrGJdP77Li+zN5I02hYlJrxWsqAXczHMeY7O/p6DUeNt/e98w4sC38DtFp00dtoyym4V3NsgBvbNl78D7fL4R4bfxsqe+0l/XmpM2cFYDXlOFnt6I/Cm3w5/ywM5iYzUTCeeVIMMbWtF5Wz4ZPXBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282049; c=relaxed/simple;
	bh=7zv0IjhXNzKmOok7B90KSMLM/qIH1bGHaQDDM1g854c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=THTvwqG/0tUWMEsQUDX5lVnPpq8SBGQwVRBp5+fpYsrte2dKoW1xZVc7zAgSaF/owRDc5FnTUdhIzAmE9RUwGcwNw1RtQT5p4i2g5gebgIfeSNQ36G5oRen1JTb2sG3CGkthrmy7yPEtgepZdSF/oBSlww5kDnlqPhhFryWhsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d5d6c997d2so6877145ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 03:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744282047; x=1744886847;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlTWe7lPsGw31nuXM8chVWl1bx2tUtkForMg0W0gSgk=;
        b=YrBXfXoMO0EIlwKz9zVOOAQqhplfA9o+zMxUFH3JXxNn6tMe5tCpNIoKeTIWp9UcMo
         CV4hYe1d7b7LB0+2LP+3zB9Pvws4tNRz6CrB86MmABFP14gt10DmNnGaDLATetIpKEkw
         Sycs6YwLGbCxIcKmrlIFFkOnqUW7Ub5R50VGwRzovLiXAoWkEzLt7X1B7UCzbANTaYPL
         dPiIp8HQhSgr5xNnO/3YBdD8p9IWxj8HWwS3OdZrrucBWjjvoLG7hEzy0ie3TKOIVAr4
         p7tW8APa++yjnbPhYvULq5UWt4StoUT4Wgupxj3HBBbIB2axDPv8mKqDEjV7SG0CoTBx
         p1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUpDzAAluiB9dm8kX8uPdiomoBxoT3UmGMboW9Cz5gR/gm2LfKf/CRee88j7+RZj28GABSf/6E869vMoTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAuSnGmqwfHTnD5MJ8ZRJ19D1zrB+/l6ml7x7qslf/hBMBD/T
	EYVXEGIwGNonffPmtckPcktYKXGNVK08qBxCKQ8GJnI35G4HcGTCtfch8tKKGx+QIzY5GCIsPco
	oVabj0Pi5qlIr/nU4uVA7a712jQDAm76Ewjbtf5UOYsS795w+9LhRAIE=
X-Google-Smtp-Source: AGHT+IHjlwJZZdP9uaIUa3mFoLVyCXxsGN/30yQx65nP8833D2MI5lVc6QRZxHZHUwjbdB5VTVJfQZZFFkFzmOy9nV0tTPKS766B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c86:b0:3d4:36c3:7fe3 with SMTP id
 e9e14a558f8ab-3d7e46f8e7bmr21247925ab.9.1744282047171; Thu, 10 Apr 2025
 03:47:27 -0700 (PDT)
Date: Thu, 10 Apr 2025 03:47:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7a1bf.050a0220.258fea.002c.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (Apr 2025)
From: syzbot <syzbot+list6acef4c48c6bb189b56e@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1136    Yes   KASAN: vmalloc-out-of-bounds Write in imageblit (4)
                  https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
<2> 42      Yes   KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
                  https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
<3> 17      Yes   KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

