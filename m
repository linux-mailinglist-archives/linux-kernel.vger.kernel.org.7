Return-Path: <linux-kernel+bounces-697648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF3AAE36D8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 09:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD57817162D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 07:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1C1FF7BC;
	Mon, 23 Jun 2025 07:31:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F31EFF9B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663888; cv=none; b=ky7J3rK5S+t+zNA20wwQ6wD8l4ZtJ2gVNu2iPCMqJUj4GUNN9nKZ7HUIT6npkZW/7mEIBJU2CQ5yrzaoyhmqyaYMrgDLpwsbTimAkrou498FGkhhciMwJc48ZP62a+fJN6Ipp46Qvdk/4l4LIkmVnkgDrxP9akZNa4tg1oeCM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663888; c=relaxed/simple;
	bh=c0L5Ic9p78fz8025vT4Q+4lIQmNaESDGFZ91EYVrIm0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fRtTMyKDZ/El29lkiAMNvy7OYUT2WA+CKh2/HmMwQRVQQzSZrVxri+QGPAf2VQF6YDI6Y6v0ST351l6wlAJSoasgCldFKd3OSKg0utfZBK4IbMTH3n5pXnPFjHqhLKld6hFWYzdFHFHewLbNf1BJMdzgs0vTgzOaw1voNPP3yQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so39224875ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663885; x=1751268685;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7N6CFb8geC7GFaDZTPC3hB0Jfnej5N6iNsLrQHnvBDM=;
        b=iH6Ds1MPgibShIAtGhZPO3chrVSgWKteI8dCSN313ejlcACDZnRE2cp5tVFcWA0+CU
         Qe2PUrBq7R2dR6c/oVfduUUkb6waNYNRb2p6dYtXsy3zDmMsNduLRo2uGPqSIkNF6GXZ
         u0OouQfGVOW8wiuEMFJ87rKPqzLSewAcir9c63/60fj/kCNm6/5vx/ZOwU61ThKXBp5F
         acVy23uvyPpl3AchrrrauQPUo9Khu0Li7TnLazGp3FZ1/WzEhWG1/5cusTdRatVuADu6
         X21IFh/4fVF4Th/qtzSD4mtEBUQChUmUfQUrFNHxVu2y+qGk15qu5yMunpYWYv2Xh+R/
         cMyw==
X-Forwarded-Encrypted: i=1; AJvYcCVHJ08TMZvTqFVPlLniI2NPS8hboSxbhCX97ElHKAtsV/X6ih+bb/3gxsbbYVO86igGj/yFlaj0KIT18+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfioDjpoVIQg0zWw5lbHfJxcG8ddC6teYPfp9dEuDJBBDtR40t
	53PTjUJ7t/bVyiQmBaYrvSC6L96mHCz5yovOtcAQuluJx/LeC7sg2BRvOUOzWa0+DfrNk7QKYPj
	gDJtm3+CfCDXLpeYedTaLPFjh6DMgIVTMYLqPHvzyDFyTOzUhH1fsW8OdKL8=
X-Google-Smtp-Source: AGHT+IGC099jadcheZ5mK3WjDhzyW1CBvRHM0bX6E/FnAGPCVWbJoaBDP8C50TaB62x1Y8doz7+TLDaj5ky8vooUeYMc9chkmT03
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3782:b0:3dc:7fa4:834 with SMTP id
 e9e14a558f8ab-3de38cb06a0mr116323135ab.15.1750663885509; Mon, 23 Jun 2025
 00:31:25 -0700 (PDT)
Date: Mon, 23 Jun 2025 00:31:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685902cd.a00a0220.2e5631.000f.GAE@google.com>
Subject: [syzbot] Monthly hams report (Jun 2025)
From: syzbot <syzbot+list3771629df5fd7b67abcc@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1256    Yes   KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<2> 321     No    KASAN: slab-use-after-free Read in rose_timer_expiry (3)
                  https://syzkaller.appspot.com/bug?extid=942297eecf7d2d61d1f1
<3> 268     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 112     No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

