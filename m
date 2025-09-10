Return-Path: <linux-kernel+bounces-809752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF68B51195
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31D63A5708
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4C30FF2A;
	Wed, 10 Sep 2025 08:38:39 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E762652B4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493519; cv=none; b=rrycBSCAPvYEy2grZg1M5z5w/y9crHko+oZw0QBeUAj7m4kB1j5Qc303y+JmLvaoszBQNTZqzEYOFu4HWrUpZAQ1L5F7XaK8OAqucWgk5c9/qWdtZQeVado6SVlZyjToi3t986JZc/K0c/0YoPQQ7MDbXe54rowbzyNNEiJzWBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493519; c=relaxed/simple;
	bh=S2CuiN4Cn68yiXA2JsJbOfDFzzbK2I3epVu42Zi6/BQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OAZ1GI0J8MEonYPHy/5yKnoAWLmdfg1ySPI1XoO24w4PmhIsSOJ8Ie/LbabAwlKlsapKvTMT4T943YNcQ9vU5NxBJi2ovQTJ9xHze+8+8G5LwMukYT6/ENlEjz3unGlD4bzgW1hz1+AucRuDA41mjdQ30KHwnZrONeoPPTmmnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-887777bd720so473875639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493517; x=1758098317;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u95acIewyFF1J3EgBYIfRXlsjL8T55TJ1tUJBGSOkSM=;
        b=YLHv7vvD/4tP8wVOIUXLlGMG5swRReT6/NDOroPAH+sp+F4dgaeEizWcHim3uLHNDk
         gYLjeLdMCY5q3caNDutFLEn9kKvA7o7j1yb5IeasRE30wPhSMGRSKUppqXnYzv1EoBMj
         Ll4KkFT2dxt3IIJOUgN8ubjbqsGjrN7ykXLENXUDaT2TEC9vyD2+vzaTPmaF7UAp15Mj
         uYRVk2UsTQtgxhWHWr9HpHaX+chQstl//tbKDrdwtFe+oeMMKb8yiRt1fA27Te3LFFYu
         so0oZGav5+kt81ClOOWg3G4o+W+MEh50BX6MwPVeCzHRWAdJls52Lko9jWspQZ58p7ut
         rvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTOFbQCsNwG9kdE5r1rKv1FvgVCjprnqPOghEdQs5ojGH29UExMuUlg3Gg2xzz+WLH7EpY1QXljLh440Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwzh4gbP5rBCzLHEDXP+MrKGKNkxysU8by0f26OiRf4Dj/hhTg
	cfvPtG5dZ2GvPKc22CLcsxOWkZmwig+3U7/4TcFCie4qBg56goKwnCttVUHOWrJ7kGg0CJPCYFS
	BdBq3z8BmZssrs5OluMx6d0hWAFBoS9txCFSWCtvehXHq2Z8tkp1kuo1J27k=
X-Google-Smtp-Source: AGHT+IGzcg/wm2PHttGbI3po8u0Y0KNqW8L+wNQusiH0lTexSBBTiSNAmHESO/uJ4/VlzKA3EsnKToce5UYM6xchkv44wJGYn/fU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:412:5782:c7d2 with SMTP id
 e9e14a558f8ab-4125782cf42mr49266255ab.16.1757493516971; Wed, 10 Sep 2025
 01:38:36 -0700 (PDT)
Date: Wed, 10 Sep 2025 01:38:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c1390c.050a0220.2ff435.000a.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Sep 2025)
From: syzbot <syzbot+listed2bff2fbfbec329cf12@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 641     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 381     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 109     Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 62      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<5> 5       Yes   KMSAN: uninit-value in nci_dev_up (2)
                  https://syzkaller.appspot.com/bug?extid=740e04c2a93467a0f8c8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

