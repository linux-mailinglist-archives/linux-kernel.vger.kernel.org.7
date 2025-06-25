Return-Path: <linux-kernel+bounces-702692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B61AE85EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05133B4C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7073262FD8;
	Wed, 25 Jun 2025 14:15:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B217333F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860930; cv=none; b=OIkPbGuMBtXBoe6ql57K+mMQqjzQGEHLE86hRZfJlO0jSsJMmjMH9Bx4Odq3qGJgNIWAqLwux0dd+2sfTF+7pBUzR7yyW4xP8jre5dxxszzJbbBSAsnX5MTYFX6KR69otuxZ/s0SPrOInAp3K7cMLY5mK7nJOLUssFNB6oA+ZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860930; c=relaxed/simple;
	bh=htkrJrR5CZT5OOui0gtS3RttV+j+vFcqYMYuKAHYOCY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qzV22nJ6xFrsfsp+Ly/Ps3+WzoL1GEL8Pg/ATMlZtgYV9QZKDe5Eb714XfidYwSCZTii84s4a4xOfduCmsSCsWpE3nEpr+ouGcOGRliqwneVhl9zFodT82Kb8MapvAQatdPOjcLRPLM/iW9SYfwSfhUFsCr6s0srKPjoyIVnTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddc147611fso144365215ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860928; x=1751465728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MEin4t/ziIjLNPi47j67uD/WUkbw/RxekKaFXQiDx0=;
        b=b9FFrXsMolLRpb85bV20n2JO9yggKiRqJkJFlLcNcs8FaW/o+/S939gheGlH8wPTji
         ygTIo3uK1DXftViJjs1Ga3kPehWzOHAZQNpZvSL1t76z8nlH61QmFym39EY6Gvl8VQJb
         arZqiWvNMslc8xKK4M6fyEz+AiUgYcsOMOFEHn5w931l3gnPz4bPmbLTGkWbaUmH3cyw
         U5Zg6wKYegSJfR/DkRplz0AQuDBTa9OUEFYE5gd3iWapjQFfpd+fDAAM8eMzHeA3PI25
         aFi0ItYsiaX63OivJqGOcqFJX1YMGg8bFESL2C7Y1cpl73w/wzHx/Uu2PUa6m+IIIwxn
         HTVw==
X-Forwarded-Encrypted: i=1; AJvYcCWtA/mneCBhaW08vfO8qXEyCEOJSfXocYw6NRClG7ReUtIfJikOv/PLLge4UN9UQrlqIM5+lqI9hLtZ78U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85abNXT+W3Jboc0Q6Z1qmqNIzTiXk1uTL91wCOJXVMWujIwdb
	Mp/jAnU8RqgvBDoOGox3JTeBhCTHJSSr4kc78fNOSiIAa7nobxmE9YwbluU0FNcf/vuJ7dzDIrB
	/NhVSPtOKiuF1sKgJEZxfWKPe6BBO8m5ATTkRU/Cmw2y3dDoHf5kxRCJRtVI=
X-Google-Smtp-Source: AGHT+IGlbAs8Qgq0kF4FQvO4dHFusdSL2Bk35rEbfP8CSA6+6jXl842u4d6OyaVp3mQ6hXDQFXkrbKHFfVNZwsHvhPw8m5fqJ0oe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:3de:1244:e7bc with SMTP id
 e9e14a558f8ab-3df32922375mr42246435ab.3.1750860927957; Wed, 25 Jun 2025
 07:15:27 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:15:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c047f.a00a0220.2e5631.00d0.GAE@google.com>
Subject: [syzbot] Monthly integrity report (Jun 2025)
From: syzbot <syzbot+listfc8d7b7995dd788237fc@syzkaller.appspotmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello integrity maintainers/developers,

This is a 31-day syzbot report for the integrity subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/integrity

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11      Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<2> 7       Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944
<3> 5       No    possible deadlock in process_measurement (5)
                  https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

