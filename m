Return-Path: <linux-kernel+bounces-645881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE3BAB54F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 14:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033BA462AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 12:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AADB28FAAC;
	Tue, 13 May 2025 12:36:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E028F94E
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139790; cv=none; b=fIRgMVJCauYBC+wqJHicViJLPG6dBlUo3dHPC9n8JSPPFPGw7OawKl8N2n4/mg1e5yzrfHoPfIj0VngFGGjV9CzKrFa71gsd9eyWaNO8DiN0hNOYsq8HZQC023UZ53djldpShzbfQgiOsIVGJGAQGR7JM8j85JA500WhpZIwgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139790; c=relaxed/simple;
	bh=2Hp279qOKoUwK53A0IlWl9Z6A9oGh6aPql8Id7/C4ec=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NeGwoOPnkvroi7v0znDlWoOQCW1qPsD6tfgUirRegYD1CRejyFetgZB8gLjZ4TgRkhvVbBg8fNNz5hwXroXYJbgHWEt+uAtn6DrKPrRfkyZ2OuVqAp6Pd2MZ9pBW7ha7vwtNhGBHNLwF0p3Bb1pi7/7Py9bwzQfW5lRVxsoeDUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3da6fe2a552so115606035ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 05:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747139788; x=1747744588;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYgHQ98etugRn9nrFF/Y396tZ8D+/Ig7ihfcqGgA2as=;
        b=FwL5NoOcB4xSS20OeRL2tRwtiksusPYa+D45ciGhpypi50SVrN868/4hkVbTo80762
         o8ng1iEjMfmRFhu51VCMW6n+YExrWDJU722DEn2FPiU65b9vzXIbL61BNTMS2NkMCPP5
         eXPyd9olcqqwLVPRntRxzKJ/7uS76GMDviFSYRIpgky2HXchM/oY+/g/cbzyTFN+UULi
         7T+3hu8vYyEbMbsIScrZfB5zUWj2t+mK+x0scOeHAFZ+i/MHyqy0N6LyviCktgGMweJh
         1qnYf1TVu33t2zkhT9VXr21PgREGTCMGxQlBE6wzedmaRi7b6ms/SQ2bdtXOtE+1LuAw
         6L1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPEvcn/z5PZg8mxFmnTcTSR+Pju+uuu1sHWETo5RNG8MtYqWwcT7ODm3SBkvUg/pGpgbYSLU0/t1rPun8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcO7CQPONAD72IVGJ07rG+0E01u4c4wd6kFb8AkICsY499rwv
	LlGY/n+Ifh/sgXKPdc3alReCyX9PBwHThJbwAF3rQg56DSVmYhQlYdiHZVPkbB4htE1UJIcN/Mc
	9V7i7b+hsvqXkL5hspSlSkwWesKbscZDpIZ2NAr5FiI7phqjL43EFlTs=
X-Google-Smtp-Source: AGHT+IEKhD87ADuvIbZqF3IVuejXHxQwIrZ9v7DshXQN7uxn/CK9a/0SWGRW3VsRb8nou7/Bfipq9krzeFmYzST4ehdVQLjh7HaS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:398f:b0:3d4:e6:d872 with SMTP id
 e9e14a558f8ab-3da7e1e3ab8mr192584185ab.9.1747139787612; Tue, 13 May 2025
 05:36:27 -0700 (PDT)
Date: Tue, 13 May 2025 05:36:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68233ccb.050a0220.f2294.09f8.GAE@google.com>
Subject: [syzbot] Monthly wpan report (May 2025)
From: syzbot <syzbot+list1679a20fcec2fc473afb@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 273     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 33      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 13      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

