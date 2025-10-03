Return-Path: <linux-kernel+bounces-841025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D36BB5FBB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1A4E38B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A851F5858;
	Fri,  3 Oct 2025 06:37:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877018A6A5
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473453; cv=none; b=LkmXEVlOiRy8H0APh4KC/sMrfY7k/LOv9e4sRxGetXciHS19DSObNdl59d6XY5y5EQCHIjN/2Yrie/QL3Eyx8tCiBn5MPWtjYkbXOwHfEZfWGYDVjiGCIlxj9FVJpMd5Ey/aNCH3Ouo83+CUziUhgz7qiUTxy3Ugb25B/mLMR5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473453; c=relaxed/simple;
	bh=gtAF0CpcKepL06ZVsuRdebgrDczKcU2FBolkW/B7170=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fw4LkRrWfJtfBbfGTQKk2tmlxRqTPgjCQITJK/QdlUQPc2AyW2odRKa5HDhgo3c6BnbZUXpzU3prHUpQ+CGu1WxZDL+KFrezmXI6oqs4FGsPNj6grVDbYS3SkijEAH6oA+rdO84cEFFptB3V+eRdVPvin3QwGyHRQdWF/AH5VHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42486f6da6fso24362595ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473451; x=1760078251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gokwsh0d0oDpxymMzb3OOmlfkoX3qLWYpgmbEKkWVwc=;
        b=jU6FVupOpxe4O/nVllnJbFKtgdMGztM3na1NnWLyVGV7wGZEv9x0+PQMnS2TQ4tS76
         O54dQlumgXf6Grql/RuYKEms3YD6IXNSXDUxK/DKvhDHPTUMo1gYhEvnJ0x1UfcgGvSR
         XWoqxVKPh36vroDn1BVOoYiXXN/dhxTvVN7atq2TDRKL+XpLwPWeP6UOa52oQuCAW+qY
         ukjpjkIIPb2/btKLEnKVnnuYyEabTmjK2O8XYTn2fVJTxe68DTH+MYO4ZagxUKICjkOH
         Z5Lbko36N5f/aUHnf8K0K2MFADVSTiIbqeLlu8zbiPm8K5loFhM3YdljeGaASPbaiZ7t
         nlJw==
X-Forwarded-Encrypted: i=1; AJvYcCVhJwg8BPy4SzNSBx4JDHa1m9RzWVECBhWfMJSDDF20tiG7hWmpN+rASaun+L1AisDo6g+0KKP1kM7XscI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjafuQqA42BCrcoav5+rGyj3t2uru/3D4Ka/tIRSoosVGHyCB
	jNcWt5vO9ho9VKR40IbvqTGIFebgB7mU0+8JRfrnqcBluOBlEIrxepORir0Do+B/4n5EyakBDvi
	bQK+EE7fwMMP7vx7QTnGqiB1/gsAGJxCpaviUfHjcRlG6t78g5C3c9j8NPUI=
X-Google-Smtp-Source: AGHT+IFaCJDjzvPpZIb57jL+swJb3ZtEUzdgQTwOs60R/UvyZ+vSsgRX4xw2xMrVtd6oL6w2U5i6Qdf7JHOeR337zRN9xXd1IDwK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3488:b0:42e:2c30:2854 with SMTP id
 e9e14a558f8ab-42e7ad963d8mr23838445ab.20.1759473451156; Thu, 02 Oct 2025
 23:37:31 -0700 (PDT)
Date: Thu, 02 Oct 2025 23:37:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df6f2b.050a0220.2c17c1.0019.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Oct 2025)
From: syzbot <syzbot+list32c51e896548995ecc55@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1317    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 1179    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<3> 109     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<4> 76      Yes   kernel BUG in f2fs_write_end_io
                  https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

