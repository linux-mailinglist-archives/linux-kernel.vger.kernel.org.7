Return-Path: <linux-kernel+bounces-847872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E406BCBED2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEE03B395E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913E274FF9;
	Fri, 10 Oct 2025 07:31:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F5246781
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081487; cv=none; b=uCPNOsDT5XTiQ7xg5uVmNuas1NQD0shsYUyUbheRIoSEfXGodCVzDdL/kf3UMU4xeuGUkPrZBhLXwzpGWN12YpTNCy9o67QtsCYDB3mfNJSuV4OA3Nzr27VAo/2e6K+Ile69W+YaN+J/Yns73fVZqsqs4juNzE+RV3TdoQoxtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081487; c=relaxed/simple;
	bh=W90majqgrs0tolx4oJY7qz8kD+dyDGhIdiy8Oi9pIs8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hzZRDyFjOEB0rCNU2ZKLRJ22oVjegOKUhAsQVZMugOXCYtqpIYw+WVoWm1oIKJ66Yn+1HTO02el0aCeNcXs7W2PnbYHznzSfTr4rseAVWGVmANkTB9p7c0PCtvO6D3sEh84x5xGc6zh+roRXT6ggq/HzwAnsuBoJw55lr3r4w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e285e5f4bso96742639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081485; x=1760686285;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCYq4z6Kszb2v0v6uENtGUQTd+mgNya6TE28IxsUmS0=;
        b=vjRrKy/4rEdroL0svFpycggMsM0iYZY87n5ZTbLodeFB2pAO9DE1qXQrcN0a3HsFF4
         OfG+qKYRihbUUTVjjT5NhR7cpYvgi1ASvTxJYaMqOsGK6DVll3NFRja/IJeP6AbQsOFL
         3R5vWqCitmNxb9ggDhdfS4LAERtvCm3it+8jlPPZCNUxUVHQ8UHQDYxBd6gnazFe8TGC
         kWJsufZNWkNCKCH0GjeCDlJiyQNb7r/Cqwp4UHBb0ccpj7Ak8EO7WrgDM+dFPlKAf3sK
         YD7i4Fbz73Vj/T3PRbZFUi0VT2BvlNjcVwP3FU7FiI2sVJtD+QgeGJwJptopdUu/LPXH
         +p7w==
X-Forwarded-Encrypted: i=1; AJvYcCW1X9GZZzEH+yMt+H+vod4PjrTN1iKYEPVVQpX96jzXcA5/rhASx7zynBai0csdASFpiklfRgb44ovHoqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNL/svSdi0tGVRXoNKmokg22ek1L6a3wsQlZxWFU8p1r5+VN4
	5/XtYUMomLhU8A1S+d5Q/mNErApQwED6z9OMRtl9JJ+5qpuy3YcuYU6eeBbL/BFpFpiMpCnvOF5
	rIc7JN802TWGEIYcPn3zqbA2TWCEFaGwNku3sUxUSbPoMZs7d14TPm5BEKQ0=
X-Google-Smtp-Source: AGHT+IGIkRJsIU+QvLmjOyXTQC0ZaKHGg02aOWol40MTqH84ncsOxPaqhP7NnQVs/cw19AAZh4kbyWO6Y/0lKjfDdAkDEza1RXl6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:461c:b0:42f:880a:cffe with SMTP id
 e9e14a558f8ab-42f880ad145mr74119305ab.26.1760081485057; Fri, 10 Oct 2025
 00:31:25 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8b64d.050a0220.91a22.0136.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Oct 2025)
From: syzbot <syzbot+list66dcae303d719007ad9d@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 1 were fixed.
In total, 6 issues are still open and 28 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 822     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 443     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 134     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 73      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 11      Yes   WARNING in nfc_rfkill_set_block
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

