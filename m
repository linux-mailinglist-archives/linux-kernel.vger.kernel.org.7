Return-Path: <linux-kernel+bounces-702693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4741CAE85EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 16:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96C418943EC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15A2652AE;
	Wed, 25 Jun 2025 14:15:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9D262FE4
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860930; cv=none; b=JEkmhjxnvRH+IbCfcP1G0nl9ScK9g0DcfcNwjE9eO4+tjEW6O1NTnqpw2K503qLSXPtq3g4Oz6Fbm+VmqxOCmbbw2/hjNorEeG1JyWN0k795YvJxGrXFQeohQcp6Xe9qmgtV1vjvoKIBVgmPUEdPwM2+1MGgFHgvD2b6t13TU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860930; c=relaxed/simple;
	bh=+JuP94E+xnI7Vs9bx0Yg0sizMRQ02R9RzaTYaHIgy1I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PMNR71/WRJa8s/OQBC0Y07ib97U9KUd2K/2rdTiyNq7QytGZ3Y0pmywH19LmFf3hiTraHOHhqZ06vhe4kcweONiYwmj/W8GjSjDzSMfouuPZQs7Qr0GSp/4XWklJct+61++HAZvT7HfS4FGmSDV04PaeMB0FssbuujzOtbQhp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddb9c3b6edso81777685ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 07:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750860928; x=1751465728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCIcDbKondlW8ppRnkwn6db9TfBmjbxFdq4ebWTNKY8=;
        b=d6msgS4LQTvHaYplSIb2WtwmsRNCCUpUw43f6DYuYBInyml/blg593Pg2X/TzXGvSi
         T3GmFus/4hNYlmAtsqwsDahymOLClhn6Kd4zkwJNwNYw7doTl9W7sT71a9co9dNU3N3f
         uZYwap7UNTSTqh2iEpjRnqdfHcitCn4qht5YV5YQ0OG4M/2N/Lhzp4ZZ7TErCiqhyPtS
         p24frfW1ybl+BCFS8xRgK3XdZw6dZC5xg8iEKhgQHRIHnSGUmTzgofZQe/s/KpqeCWDw
         EYcQPBP52yLYa3beY6wMHDno6d3VLZdg5ijHMmWQmuFgDvCy+d1lHaHOapQU8GzGGrty
         WV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLZOgS9awYZ4yk9X6VlpY4YTkrGZs6j/wKlEyhQry++pCA6EqkYNAKI7UJqLwUm/17IB1YNrqScs3zqnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzldld32LMvg3n7aoEK3Z1gPbz2pfHZoMMHVdAaTNC9j40sj3Cy
	C2wzmlB+gmoeLuZfYkTnFN/HtMeWEF4vb/c4RRhPJastNT10unZ8CQWPUoTYw0SB+e1vWKgOvFN
	OmGEJUss+lyJywZYAIvbdxSbHfFuju0NKnZk2S/TI1F+kIJ5k+AF27iDnW7A=
X-Google-Smtp-Source: AGHT+IF0N5izkvk2XRTDSQ1nt3hmCUFxXeFtrzu3SDrAbpiwcqO/JR3izt0dnHOOXUODNUiEjGPszdTVWnA8/qOaA9nhSo4Za8+O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2167:b0:3dd:dd41:d3dc with SMTP id
 e9e14a558f8ab-3df32912c24mr37718555ab.1.1750860928288; Wed, 25 Jun 2025
 07:15:28 -0700 (PDT)
Date: Wed, 25 Jun 2025 07:15:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c0480.a00a0220.2e5631.00d1.GAE@google.com>
Subject: [syzbot] Monthly xfs report (Jun 2025)
From: syzbot <syzbot+list9c999283c4df605d8e03@syzkaller.appspotmail.com>
To: cem@kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 17 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 242     Yes   BUG: Bad page state in iomap_write_begin
                  https://syzkaller.appspot.com/bug?extid=c317c107c68f8bc257d9
<2> 198     Yes   KASAN: slab-use-after-free Read in xfs_inode_item_push
                  https://syzkaller.appspot.com/bug?extid=1a28995e12fd13faa44e
<3> 14      Yes   INFO: task hung in vfs_setxattr (7)
                  https://syzkaller.appspot.com/bug?extid=3d0a18cd22695979a7c6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

