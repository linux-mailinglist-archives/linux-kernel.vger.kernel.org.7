Return-Path: <linux-kernel+bounces-873804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81520C14C40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4421B4E355C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09D308F11;
	Tue, 28 Oct 2025 13:08:33 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CE1E834B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761656913; cv=none; b=NMvEhV80ZvtI5YCMrecn9Op2xaEmVDpfhI2zqh4JjFKYQxq9k6DY0PgBKwcdVff/fsi36X41oVl4Ar6q/oNTy2F/O33+UxzOWE2CtWOajhAmBGAouKO2KPzTvQOWfGqsEDNCnlpNN4Etm+liZ1gETp7fqchD6wh8RGN7MIWpnF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761656913; c=relaxed/simple;
	bh=xLHgF9+jSMNtBQ2sQ0wJ+W+4e4IrQ/mAuGOKtLd2Kc8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RgvJeFPT7WVJmY0j0xG57ZTHlr+zOcjMW0aEdhuGYf9gwFVw6O7AyhjcjGO2VTOp+JiUhnwOKpwzbLHSzo6gDLWyPWBWwUL12ParYC1Dynu9zHSPZEyknuRzgPBt5z1tZwlBbXDZKUNmU2KrOtn/mmu3bMc0J+pQdCtr8I06ZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-94109728fadso545199939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761656911; x=1762261711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iEMDpGeJcdM8ih4UyCIvTGZihHZxrUOC2mI8PP6H5/E=;
        b=X40/Bjap/oS8jL+lluEoo7Wci3hKDkqJFmOmlov73v4gunfHklIjs19IN3/e+kRM+X
         aOUX1y3j9XEnuHpzL80DU56IZDE94GNsIkpny3J/9Lf6mnzJIRFgVas/kdGfmOjNOI4K
         YJR0eIsa5fmJ4IuSXMYnrLSeC+mHlUqDoqPmmDem4wM5yXkjR7QDD0Le09PP+vYO8YwD
         /da2oXi1owKfroNslzZC4d10o4unC2GMkmHqna77wjnAhePXoRcwziA9NnxbipVeTBuA
         d6+dy8D9IzPfBA2JDBMi9rw0NwctTU5LNRWdg5Dhu0QLSxdioLZass3eu7QSPKgSj76O
         BpTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOniSELx7wDulYr7E1EnRwItj1JvVeK/8+sFh2q7D7JRw9M9hrntpE8pWujzsQToKWzK2+5oh7Xx9eQos=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4VYkPV2woooRpk66KUHGDArK2MQgRApnm6iw+yGwnPlKfSg0
	I0ppIPFxPbzSps/ityPf79qfqr6HpQBmXZdQe6JIRtwfBfbhW8DyxRj0MY+vvaE/kBvHxHH+hDu
	SZ9vKb6l1SMJOh0XdsNFf+0FZh9hGl/0assgmeqjOsbmuyDq9sjtNL0fWzuk=
X-Google-Smtp-Source: AGHT+IFY6RHhEJTH7EjQ4I5zlecu14QoNUN/CBaxVE95ObGYvwHDrk96i31CRuo4zfx/IG3j/sQ4L/FceqrabLxyRTq00n6yVa3q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3009:b0:430:aec5:9bee with SMTP id
 e9e14a558f8ab-4320f6a7762mr48011265ab.7.1761656911151; Tue, 28 Oct 2025
 06:08:31 -0700 (PDT)
Date: Tue, 28 Oct 2025 06:08:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900c04f.050a0220.17b81f.001c.GAE@google.com>
Subject: [syzbot] Monthly i2c report (Oct 2025)
From: syzbot <syzbot+liste32750d0dd9019b06ac1@syzkaller.appspotmail.com>
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello i2c maintainers/developers,

This is a 31-day syzbot report for the i2c subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/i2c

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 4 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 682     Yes   KMSAN: kernel-infoleak in i2cdev_ioctl_smbus
                  https://syzkaller.appspot.com/bug?extid=08b819a87faa6def6dfb
<2> 65      Yes   KMSAN: uninit-value in __i2c_smbus_xfer
                  https://syzkaller.appspot.com/bug?extid=0a36c1fec090c67a9885
<3> 2       No    WARNING: refcount bug in i2c_get_adapter
                  https://syzkaller.appspot.com/bug?extid=76501d32a94a432940a8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

