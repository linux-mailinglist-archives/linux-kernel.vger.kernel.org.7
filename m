Return-Path: <linux-kernel+bounces-746662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A54B129C2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 10:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ACE1C21EE6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C612F2206A9;
	Sat, 26 Jul 2025 08:56:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74A21D3DB
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753520203; cv=none; b=K4h8StxK4xXc7RjhLvF7Ns5LvpBW5jiECBHMRfvCy5u2SJxAJNyNafV791y1nluS0Ok23LaYynXOYY6Et13hakJh8CPF2L6p5HSVXyAcHIiFAB1YdH/SMYx87b5ZTeERmC2nRsdTnIl7855QjUUwwibRlzV8veFzoU0pJGv9c3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753520203; c=relaxed/simple;
	bh=r8ZjYIBoHWp3Er4XQQDCMKi4woSIdnfufa1P11ySiFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NSGloWiq8cCLh8sIbaDL8HasRitfenvRQ4ioeUn9X9szRPAkj50kAFHaXR1p/LUGcQxiewJhXTKfnFoLzHfDHWS0NrXPnoeXgRNL2BIX1UjuWx6vXk9NjA1hiwwovliLofb2cOiq8w2+iVfgDcIsqO6Zq5yBwe8FfHH6+6BXfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c1d1356f3so312958039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 01:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753520201; x=1754125001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13xxILUIH8NwouizMzWPFNtet7N10oMiBjeHQXTNiTw=;
        b=g3HtNnQNQlnfntDJ3qO1jbfB7L6xl8IXHb8saVwi4CHMVw0YhY2eWjpb++TimnqBOt
         lA1WSJWwuYDv7PHp7j5FtiEkI54ZcFmGIl7d7yMzZxI8zH9kk9HcbwFyJMRODV9RaUDx
         LCFNUad00tvQDZvigwMBBU6BVgMX43RBTeCYheWmu4cFHpVVIoDlGn+aPLToMkBnUDyD
         YQuEoBM3+dSKuUcVYg9Hvxo2mjEDcOFSEhI1+p9dBjavX09ynHA/pSJmZT5kC/wGDueQ
         Pv7CyPPcULTqyzTJ3vBguEXdHwCdueDrQUr2RgsceSN+bJjurYalEIES3OuWGn8LcsJc
         OIug==
X-Forwarded-Encrypted: i=1; AJvYcCVdAI59E0tZ//xZ3L8fvoiD19+tWaWqw4dg0bA5TVFz12w69CUzePRQkMbSNHPszs8vyc1Krq9h2YZDkf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdzz7gYGjMjxID8qbnf4PWzph6NfLnZojo4LgIG8XHVRqXsPcQ
	rJnXG2uc798jdaEpPyb67ilOCNrDEtrDAtmZW2JiYbYskL3KJctxcJCpOKEiE52tJhQRrpHH/aB
	UTcPcNtyhyVC2ZaHbZcUUP1xNFFwDYdsj+ta7NlGHdwZTuj2oQsXnbjCAfUg=
X-Google-Smtp-Source: AGHT+IHkcWhhZHBm0S0ijK0UaSwKbtJPh279kl6oxHrH33UsqKoWhEyfu9+4G4GpidI7QbmrzCHoF+8UHqXa817inWpA6P1t4DNW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f81:b0:87c:1cc3:c0fa with SMTP id
 ca18e2360f4ac-87fffa87a2bmr811822039f.0.1753520201108; Sat, 26 Jul 2025
 01:56:41 -0700 (PDT)
Date: Sat, 26 Jul 2025 01:56:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68849849.a00a0220.b12ec.0012.GAE@google.com>
Subject: [syzbot] Monthly exfat report (Jul 2025)
From: syzbot <syzbot+lista38bf97afe36425ea6d3@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 35 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 403     Yes   WARNING in rcu_sync_dtor (2)
                  https://syzkaller.appspot.com/bug?extid=823cd0d24881f21ab9f1
<2> 60      Yes   INFO: task hung in vfs_unlink (5)
                  https://syzkaller.appspot.com/bug?extid=6983c03a6a28616e362f
<3> 14      Yes   WARNING in fanotify_handle_event (2)
                  https://syzkaller.appspot.com/bug?extid=318aab2cf26bb7d40228
<4> 13      Yes   kernel BUG in folio_set_bh
                  https://syzkaller.appspot.com/bug?extid=f4f84b57a01d6b8364ad
<5> 5       Yes   INFO: task hung in lock_two_directories (4)
                  https://syzkaller.appspot.com/bug?extid=1bfacdf603474cfa86bd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

