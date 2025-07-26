Return-Path: <linux-kernel+bounces-746875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C0B12C57
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 22:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C893A4569
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F071D28936B;
	Sat, 26 Jul 2025 20:43:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC71E9B31
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753562614; cv=none; b=VYzH9MAU8+LxiRQWiYcva5/RF9zM8YPIDjQNGyIZpncuDYqCh+CkhoJDxj7NA13ZUtKnHTEAmW/knMWO4++8IcZl4cFAwZQF5hwAMCup4u/4Q9F1BII+nObj4OTdLuUdpeB6MBNLDN9674GayeQWyHmyyHf0opZeYOIG/eIEAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753562614; c=relaxed/simple;
	bh=N+P+aGfly5ksfCYbQr1tKaWz+ojdaGQ4OlTqEyfMv8E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XIBnymCjmXMI9uZdb7PRFGyelNcoCCFhEFD1uiBjg1tw4MzD1dT1BQJqW3H+iQEkt1SLlv5sUueXZDnCi5kfnx1UfaSPW4PereOqc8KHRfTPlkw0KE2uM2w99pQwydKc9lu16d+/W7RTjD/2R0miUw4Q9hGfpnM8IZ1CKmUlw3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddce213201so28903025ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753562612; x=1754167412;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAvz5RjYS0PASzujqcQIZUaLTYjptqv9wWViXx4P9+s=;
        b=ZmYK91Op0pIxUABhtBsxC/OA6WCMuZIOV0gejZY8rWDACwnQ7CGs2WyPqlFrcZctkG
         BKZ56/jCrun4QoNbrCqy0vaHyzjZvjoZN34TV+mrzSOUslP1NwjuSwRMLXEK7wdzRgvu
         IfFhjwJsiCjhBW/mbQecqCH02WgWCzRabBWpbuhJK5TBcfMZOuOAzckfO8yegzrLmsdI
         GNEb5X/gpqd7+Y5ZO+ULsK1q5Q3H96IZR9Ji3DScjpa60y1cGyesgd9+tCcrGF4fWXr4
         mPl4MQtNdus5Uttvr8X2NUMh1Ilrjxpkyo7doq+MEwOKiJEudG6q+1sK25Rh0VsVsjlT
         L5aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCojw0KcJqBoNNSTSXYjwgdH/ut1qayrCVA5yhOu63ePNCaLvRszdQnmkW+h9C/r/3ZjmaCkZVaTEnR60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzax2+g3a5SdkK0f7HuJXPxu91lRWN3Zu2tAxSyaB7Gos8HLYzj
	NSXxUUETFHR8pfWSoFn5PBpM1rmi/PHvre+uvAA8tJ8N2yI+tiOagltSV9SRRXmVXa7V9Iy/Op2
	cV1f6xTT3c9UUtxVzEHRtrnmXHL4szK91wUAbYj0mxHEsoEkYd0/YYJ5LODY=
X-Google-Smtp-Source: AGHT+IEnRsBaH2k0SsRffwnhXJNrrq9UnGPFhhk/0MQcCNljzqhsOaVmcFHpdpYHnlECW0Mp9LNdpKzWUfx+9Q44sOPSVK54AqBB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a10:b0:3e2:84aa:f473 with SMTP id
 e9e14a558f8ab-3e3c45c1a9dmr112537435ab.1.1753562612299; Sat, 26 Jul 2025
 13:43:32 -0700 (PDT)
Date: Sat, 26 Jul 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68853df4.a00a0220.b12ec.0031.GAE@google.com>
Subject: [syzbot] Monthly udf report (Jul 2025)
From: syzbot <syzbot+listbdacb325f054fd709eae@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 12673   Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 1222    Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 514     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 92      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<5> 6       No    KASAN: slab-out-of-bounds Write in udf_write_aext (2)
                  https://syzkaller.appspot.com/bug?extid=4e1da0d327b65949fe1b
<6> 3       Yes   WARNING in udf_expand_dir_adinicb (2)
                  https://syzkaller.appspot.com/bug?extid=545e45805722d117958f
<7> 1       Yes   WARNING in udf_fiiter_add_entry
                  https://syzkaller.appspot.com/bug?extid=969e250fc7983fc7417c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

