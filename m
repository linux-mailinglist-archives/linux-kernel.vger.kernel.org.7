Return-Path: <linux-kernel+bounces-742278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B549B0EF66
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560BF1C80B96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0719728D8DA;
	Wed, 23 Jul 2025 10:08:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E014E28C032
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265311; cv=none; b=ETopoMNGMJ2ueRW3IBmN39xsbDrfhxrlrADHAKH+tH/Np44g8Aas/8Y275D1nKlRYvEBY2pS0FesaoSRqNQ7eymeVCcQLFk1zE5SFMZutZB86Me2E9ieB6yFvHh3gBiEQ9R/gcVUoYw3myeBeiAiyFKzo/DjQpivCYztxwUFzyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265311; c=relaxed/simple;
	bh=kKJQaGhBElhQ20uA93eAYsEevl1YP025Ukp6RiYXQOo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MbzURQtNJz1V6rKnw9oPuWoedP3SLgCmWclZmutHZ2VSX1xpb1vSa3kuoaK/GISVvDC5yo8jXzUN1T6VlPDYnvythBbScAOcqQWJylCTVOq+iHaFA5byjUvL8q8Jtuy70e5JfWup8Guz0nyXVMCtIYU8oP4TOf3EnPZGkIOmJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e134cebaf0so119249145ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265309; x=1753870109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xa262BFzbymM4aCqSeO/zKmpLThSI/29qjkAS1Z9TrU=;
        b=Gugl8UXyzE44B3OUltKnpDK2pxa1ABws7yVDALQ6sYSjiguixZ6niof9lL65ckVHx1
         Fz3jilfeJXrOYpKPil+bB4KcUUJYm3SVIAyVU8QKX6iAddP0lgRGDVNs60J07zm5UvYf
         Cy+cBi2G3eI3iWFoo9wGXaJ84Zv6rsF+y81TrcuStj04WgaEyzeVqKGqoQenO1Kjo0uY
         mimKkJodF7yS499lWLWJgKvUArRMt4dPHLZHFoHWGP5Js540OYVF6wXNS2zBAH6pG292
         2r2r2O52IEj1STTPbGpzP8lPk29YCARqDk6e6KwY8WtAKqMysyk+5TUZoE1k1XeLslGA
         ydUA==
X-Forwarded-Encrypted: i=1; AJvYcCV3D+mDlVNWW0lvc/pY9hTgLdD0BjWHqIgjkfmRsryJQnnutELkBRamRDbCXaHxbdRjfEURIwVItWXM3Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntVCy87MfGDilZ8dIDB6FhvGx6ZuYoiJBt9wVqfhp2mJfQMTj
	+svSO95ASPZ9K/QlXfwj3sx2xQ07oeOXZQW4EyF7PYhn7xwTaVheq51AQ48UY21yT8AwVPZC7Ns
	a3cEsuK9QS7y4m0U70P37KPfP7srrI1/O2zrWaUwzm/Thq3W5AJPhqZo2P8o=
X-Google-Smtp-Source: AGHT+IFcrhHvTGBz1zdoqCV8kRY2Cm0a5LrAOsbdYDWNMhblZGINElXWEkXposOemC7ppVKx+C7Ql8XUnfFzTc05jT3KXSTNW+p6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3e2:dc2e:85d8 with SMTP id
 e9e14a558f8ab-3e33556e315mr43529655ab.19.1753265309091; Wed, 23 Jul 2025
 03:08:29 -0700 (PDT)
Date: Wed, 23 Jul 2025 03:08:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880b49d.050a0220.40ccf.0003.GAE@google.com>
Subject: [syzbot] Monthly hams report (Jul 2025)
From: syzbot <syzbot+list5a87a1528a3f47c76f8a@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 1 were fixed.
In total, 8 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4423    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 1359    No    KASAN: slab-use-after-free Read in rose_timer_expiry (3)
                  https://syzkaller.appspot.com/bug?extid=942297eecf7d2d61d1f1
<3> 787     Yes   possible deadlock in nr_rt_ioctl (2)
                  https://syzkaller.appspot.com/bug?extid=14afda08dc3484d5db82
<4> 279     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<5> 131     No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

