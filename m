Return-Path: <linux-kernel+bounces-814768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1374B5586D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08184E12CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD89274B58;
	Fri, 12 Sep 2025 21:33:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B1126E161
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712818; cv=none; b=OVWqmPKo9+Rw2nzkuyvlatvETHPxIgw4Y6FS65Ut5lZuoQO9BwQrbnNWd9+uEikWCHvndpHJAaFJU9dK1mymMWkRaSer6usj6DOf3Ptbxm0kBsfNoJm2ukDZwBD1fZQ7MGevbENYnOJMQcw+6JHFrTSaGupxUUsUUmYd62rvMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712818; c=relaxed/simple;
	bh=HnmzlyxjR6rrvKe11Aj9jBd2UJxbBPPj8iol5QCFONo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ALiTY5SwWPwvXLXcCpDtOUp9hak1PWUViOhh5oYS6reymmtssM0tDn9DQT6FpVApH20n3uIiyytHRL/J8JQfLqPXUZoJp6SaAT2O0sNvwrxKc0K5238gjlkBOv8oxyBBW92vWzIhPUorKfC2z9rmSwqKM+TojH0vnASBBOfv1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-417306d252cso30747655ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712816; x=1758317616;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXO5mkFCL4ZX0NuJtYajf8x5HrQRd3rVt9ZYSd4TZdU=;
        b=SdhBxbc0Nop6Tjo1JVa0s0lxSF+F6AWqJUsTCDZ6rymarr/TcX5fA7w8RB1x3L94Zw
         pdZBfx0Xep0mIcsJijxUImuep7omduN0rZ0Mo8UrDfqZY+S5nn+RbFA4VZK3JTe0DDLt
         JvpHyCMaQ1KyO5wGQyPZQQLAywf++VsxR7ul7g6PwuHkpPaGZCCfs6kJI+t2zIQsefY5
         253mdxgagz+55dMmaWfOKoic6zXwj7RWCrqSSQYBTPDt2N3Plqh0uh/KSjUTOPvnplfV
         JoSxxAs3t6aKd+w+CpdMBmLUGOVDQcULL7lk7CeIAXEAZD2Br+21vdl0vEKXZTYW6GHz
         lLIA==
X-Forwarded-Encrypted: i=1; AJvYcCWfUJuX9I7sQFd6V+BZUPZtj3vVVqngdZ/DerDu/jQmKqA8UTjEcq8OyCpB443UMOXWA1wjuTCohVX5rj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPllvcfW1epYE2O9+e5NvebozUK342Fnw805fAgrIqHRgonh+
	ZjVATyJWDWVU/kTisv6IHCofUeQbtwaOFskxiYw5SKpYnH01XVJ8Yvr8vrfeZJ5ABiMtv9ekIZR
	a7Ef58yuUzQGwr8wCEL3+1h5h+2Up6qGn0q9ikpwiza8fyxP67RKmnvPKKy0=
X-Google-Smtp-Source: AGHT+IEJ0MQ3LWqpsXMgBd/aLzM5ImfP69r2HA2KIQl7mSRqFOCMb4uN8AY54+NtaLOAQuIWrn4OEN17ioWWA7OqecGTlENNxkR8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fee:b0:405:59ba:4ef0 with SMTP id
 e9e14a558f8ab-4209e463015mr67657245ab.8.1757712816477; Fri, 12 Sep 2025
 14:33:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:33:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c491b0.050a0220.2ff435.0364.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (Sep 2025)
From: syzbot <syzbot+list5c6629998bf2c39e2dfc@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 345     Yes   KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
                  https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
<2> 201     No    KASAN: vmalloc-out-of-bounds Write in imageblit (5)
                  https://syzkaller.appspot.com/bug?extid=48b0652a95834717f190
<3> 65      No    KASAN: vmalloc-out-of-bounds Write in fillrect
                  https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b
<4> 44      Yes   KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

