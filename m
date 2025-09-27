Return-Path: <linux-kernel+bounces-835083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D055FBA6366
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3A6189B8FA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283123C50C;
	Sat, 27 Sep 2025 20:43:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0755A23643E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005814; cv=none; b=qrcZHe8nATeQEN4DAZ/2cuHSzAD5rxNaVeEOYV/AzVBW6PEAdhRyYZnyl4QtU3Fg0uRmqQzMsuAai3IeYFFAzDkHWUU8R7iGkciPYsntyPcc54Mpnwrc8zDJQDn34neYpXBQgvPk/MulpHwQebCyIuVfP/O3P2ofyovGelCCP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005814; c=relaxed/simple;
	bh=7SkEe/zvyQysTDka38ynuqkbsVoHOJ2iyi9zBfiyT4o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rBwHujIPktile5R99HYGPcZ0ysUHDBhPS1ZzJyB0tA2NLG4KYV2RQTgepOHWFTz8qdL/Gmc+9zc+5KEOubJ6BxOVWal6BjdoI0APK/C8zbgDE8BeMvAPtPe8auxPimjZ8Rli/UK+wQZ4j+qvocv93EjMaCV+BLNc/fEbOtExOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9222fcbb34aso28448239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005812; x=1759610612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXZUIJbPItwdz9/xAAErgDFB6Tn5IZZJ2tB/9ZZez0c=;
        b=Xp4UU7cQP9TURsZPIXpMEm45siRwEv/M3/A76DlkzPLp5ZDASeIOjfi+RazjwblRIC
         Hjv5ugtT/srj3rG8/gurXBvZ7W+MZnq6da78cYNwp3KcpvkwMtLEMb6DPWi8z0Cop4C/
         t+mfWWwTTVb5KfWMAFxVX1gH38wfzwoRQQVXQXEDFjVwyzfopswpxksCWnz7t8BOpHdI
         3J3NPX/DMs8QXWUHdFcd3ZlNw9bE8Hdi3JFD53uXJ6OFmNAyq2Tqg/q5lrh0FYNgqgTZ
         KdBd6r5Jd3+mQuoGAWi2X6yVCNadHwnq7ZcTswZNTULIF8xxa15GzbTm8fFXWIkmOat8
         VYHg==
X-Gm-Message-State: AOJu0YxduFQoH1dwHg+O/6LndsVoCZsXOqUtBlmKqiv1KoB2kGem8cpX
	h/lysjIimzvuEU0gaaafAsvYCCEVsQsdWIzyi6b16n3ow2doabhBOy9xlsh8npnUs509nDmTcw5
	7dhiSawMoZTcy30/xEcQlIjon415Kdj+MLSUUz89AhxfXvrER7oEmJWfRdww=
X-Google-Smtp-Source: AGHT+IENnQaf2eCJDj8lumKevT293Bl2t/ol4S17x7fpk04JZjuTuu/gb6/4XOruJmaCKea7MStdMPCvmOcPnawNJCjlNPGxmNwJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188d:b0:427:be36:2952 with SMTP id
 e9e14a558f8ab-427be362c13mr90845285ab.4.1759005812238; Sat, 27 Sep 2025
 13:43:32 -0700 (PDT)
Date: Sat, 27 Sep 2025 13:43:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d84c74.a00a0220.102ee.001d.GAE@google.com>
Subject: [syzbot] Monthly lsm report (Sep 2025)
From: syzbot <syzbot+list42e94670ec5498409de3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello lsm maintainers/developers,

This is a 31-day syzbot report for the lsm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/lsm

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 41 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 45      No    possible deadlock in process_measurement (5)
                  https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c
<2> 43      Yes   INFO: task hung in process_measurement (3)
                  https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
<3> 13      Yes   INFO: task hung in ima_file_free (4)
                  https://syzkaller.appspot.com/bug?extid=8036326eebe7d0140944

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

