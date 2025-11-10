Return-Path: <linux-kernel+bounces-893153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D374FC46A36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71CC44EB5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B430F7F2;
	Mon, 10 Nov 2025 12:38:28 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B30CDA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778307; cv=none; b=keEaDBal+okKvzWX9b7RN3I/YbWcxY9gLPDoBXvWG0Txlizd4D3QM3VUNxgcq0apAO5RfMzm7bf4lwnPuJCK0I756HhOMxQcltboaCEf3Eq+FLwf2wZzUIw1wpSGfxBl9QXdvwX16rKXArPoibRmicPv3haC8zlfoZ0uHkB4PLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778307; c=relaxed/simple;
	bh=xTFQJUL0lkezhYAsgGSIUDLeIxSvIp5EbM5Uvpm9yqU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k4p1ZPTxyHqe1Zxsc8+LprhIg6Qu0qgBY/cNLOMkkojQp6n59W0fOYSD/k8sJkhWHYedMvkq86OCjWsPSTLbZzqMIj7slP978EtjrHglBJEQTU/D7FWhhQmCcEwpShRvEFaWCDgUFp748q606VYgqzLRJlDslKDbE3otM0eTK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e7b0584c9so261511139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778305; x=1763383105;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pfeuF7t9W0tZyiOKHRfcCmdh/gFU/KWuvzDJl6kuhGI=;
        b=IQiQDblXx/xjuAZnYpObQmrkBJvEpb5eSa6CmriT7pzKI4vzh6SQAvxos4UBFx9ZAd
         KDhB3s+l84Jw2scsceMWfCHgHrNcyHzjl+CMc0nssflLEl89c1QaKOuk7EgIXhPiYIV2
         LkaBUOqUn4iffc/zJe13qYy6IpPGxeCmnkSqL4KH4CBtKJ4rzSU2rbSwbY/k4zaKCLVO
         E5T1se51sAeyuspYCJAoQB3wsTAhyIhmhgjxJA4aAcu3j/GerwIC3agGdg0ZxivLeVut
         U8r6qDjK+5ZXHEIV6tpVTa+F6iZfMzhBMyS7CApOgmJvl06cMaOQKlngPPa844nzDCCQ
         OuWg==
X-Forwarded-Encrypted: i=1; AJvYcCUHVmL5soUPCj/TtYFzlZh+lrws0Vu92+UURvZSEqHvk8ZdhzhGO83oDNLyBX7bPYE/2bHnpAijK4DxGcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyJb3xuZtrkosZRlzzv4EW2lLC4bLF7VrdLRpSfHpY48TOR2ag
	F+3P97bzY/OO/U8esqnhpm6tdMPDZOUNOwEk/M4w95QaTfdz8cm34dr9Z2RONzHnJIXad+ONUqe
	SWgnot/ks16R+RKjpwLDU6pYbKg982t4/yM0ZkBxKKpZB5reF53l9FOLDATc=
X-Google-Smtp-Source: AGHT+IGtuLGpBtrmikrQ9Ic4MmXUZMZWF+Y3kzEQnrlfWw9N/Yc4msFn9uKoKTYkQC1V9aXzMzhsOkvyWhzdv4VkCDcqwVS4X2eK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6f:b0:433:2390:d556 with SMTP id
 e9e14a558f8ab-43367e4c6f5mr103496525ab.26.1762778305300; Mon, 10 Nov 2025
 04:38:25 -0800 (PST)
Date: Mon, 10 Nov 2025 04:38:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911dcc1.a70a0220.22f260.00ee.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Nov 2025)
From: syzbot <syzbot+listf1e3e59758b3b8109ede@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1029    Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 518     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 145     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 87      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 23      Yes   WARNING in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

