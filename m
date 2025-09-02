Return-Path: <linux-kernel+bounces-796630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B666B4047D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6B5E1937
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06AA212568;
	Tue,  2 Sep 2025 13:36:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC53115B1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820196; cv=none; b=YpdIqj1H7ZL+azaLRXq9iCCCy8Eptg9uy2yYyUwiygYj2ixm8Jsw7pChchy/CPzlNnn+aj3WeqxUHlYurD+06D0Anm82/Y2UcfvYhKJNwFCHjku258YbSN7LVbLEVyIIjPt84PPEjB5X1tBw2Dvc7bIwGbizngGVFBHyydcROEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820196; c=relaxed/simple;
	bh=XU12tgy5cFtNfHDTSDSMaY0YEy+aNz1anhwqSwHvSdU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fUVqhfzuwVbYX+7z2jbBpX0Xbyw/JutnC8dEhuV5H7f7RmpJlVS8WvnVmPKU1181O71DZy5LuMzUHedG0zfllJ7JC7/1f4xXJeCmv6KJZq9bV2l5u8fU+LWibjSJjJP+9D88OCI/4Hmt3lj1ickNJpHA6OW4lI0jnizDjqFzN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ed0ba44c87so65510275ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756820194; x=1757424994;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJ4WUckzf+thXGnhKppJ/Gc49Jj6gD+28ZH2a1rykdY=;
        b=s1gbv8HVsBmssCxOfNlB3/ummmWj40FlmqraXGKiy22Vv1esd2iBo2Bx/b8hX7XML8
         23WAoL2LQraNEAtQy4EKTFQ/Bk5Zd8ds9EYTvnq6Am0Cddh4jxNJE81YieQsrU65rKNr
         EylxhIY5Wn01C+qBfsyD139uXJNUpuEW0xFsOnjDqEmg8npP+6tlGxKkAr+S+Vk+tBNG
         Lo0sexvbybMi2UZxiU4WvbO+4iknPhug8gxtxJQ80ChZDOexZg7jhu7aOg0jq3yW+fMW
         a6K7WtPUBKwqAUFm+td/Y5DkJlTjSkNfi4K60UHDhvSjRdKZ0z0L5oFtIOoUoega42it
         yacw==
X-Forwarded-Encrypted: i=1; AJvYcCUUOuACqyVd5TQQIqlWmV9kgm9npD9uaLXogjCZlQfj4w8wg0hezgYy2gh02nuTWrpkH1kNOrFonjfR0xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPMKx9gWKSjVYyP5m5/BgjWRgmU4tYBw0vvWa7Pgae2bGWafos
	8dFYBRXOVTaToI79Yr9+spM9lRz7kuxnYG/hMwY0i8Be7q2/MDB/d5LYFiS7fYlbFG5ujuIHsyM
	L6qRHRX+u2/1b5LA52tnU7RyORbOlib1tBS2elqZZ+NcINm3hLHkstAkwy5A=
X-Google-Smtp-Source: AGHT+IFqPcNrz9BJatttRCnPm1PX4Yoqp4tnOBpH54zRujZhTQz5Xkn9SOm3Mya0CC8xwe1f0Pkl0io72pYDe6J3PAmtDXeSiVNJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:3e9:9070:b0bb with SMTP id
 e9e14a558f8ab-3f401fcf87fmr224323215ab.15.1756820193804; Tue, 02 Sep 2025
 06:36:33 -0700 (PDT)
Date: Tue, 02 Sep 2025 06:36:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b6f2e1.050a0220.3db4df.01d0.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Sep 2025)
From: syzbot <syzbot+list9215b00f957a8e369653@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 3       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       Yes   INFO: task hung in mISDN_ioctl
                  https://syzkaller.appspot.com/bug?extid=5d83cecd003a369a9965
<4> 2       No    WARNING in nilfs_rename (2)
                  https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

