Return-Path: <linux-kernel+bounces-786108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B83B35512
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEF1A17727D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D62F7443;
	Tue, 26 Aug 2025 07:14:35 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFB2EC55E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192474; cv=none; b=gWO7xsYIOmQxS2BJN85oiUNtWVECPdqZlHP11RNnpYlfLjcymMs4hxfR81EGjplIKpXJm6vdmbK4W+1NBfuiCKflhqy838IXSjAJJoFkFnXR2NhLbnhIUtjzu6eqGJksxkLn6cJoWpqY2Z7+teIYReiElFYOjewQ0w1BXV2vy6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192474; c=relaxed/simple;
	bh=GEs+opGn8331c4PiPhRHAxrBOtHlP3VG45cSNShKl5k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bA5P+YKixZOWav9zIX/+Z4BmggtZHcTcQtE3O9rD94M6AGwRLkaYHb0sT5iIMUmpAdcmqd/xrr8yKmrVYmMTOOb5WIp+x4tJQvcB35sdVLYMiL8YJaHEsxmRjn94nZeZ52wuWfsKkYjBAKMBa1/ZR9yPIsXp1OOCwnG9fKB7DKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432e1630fso495291339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192472; x=1756797272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIS3KzpbB5EOefn6RkDMRGNPbYPh9SwSUhXZC4mDvPI=;
        b=rdHR2p4iN4wX3+2QWbJdbL1EF59G5j+RuPDjeisa7VeHb8C8WU3h6XlssXBppfKgin
         yp4weZWQ1h/LakHpFa3ElRkCtlfQ19zPpPZ0cfbFSb5r1Ol1wPCbbTlUnx1wMvGq/ukI
         iXmLEUYlf1jAmGprOYxbs1/9cVACucQKP7nXjek7oUa+x0H52ZGXs0l1mQ+EBFatfWDa
         iKdeuCu3VYFu8B6ptymP/ahxKJ0Qoj5e4++IEy1xdT8TdHKQyGfoopUNeB2qoYUsCydE
         3uUhZgyHHwLozrgksbzrnR1f3vUycAnsgdwWD6KwNJjQZhvCHNwNhwCQrb2870+tZjms
         qVbw==
X-Gm-Message-State: AOJu0Yzhl6Cbu0+KlT1ROqo/sI29tH5EXYwYXOUKyL/y8PYkOTXXR/4G
	attKEmw5u9nOs2Xm9wvtKp0NQgJBiT2HMlQ/ITNPLt1YhJ3bPr1FCRfhP8BJPbPehtL9aXkYGmM
	3P6FSmgT8tQqkA2BZIcugzjiU3Jj8yDE9kPom1O8iKjK+GNhv+GgRTfp+wyc=
X-Google-Smtp-Source: AGHT+IG+XkNNvl86GIWEOFvAl1lvuX+rDfOCQ4m47CfItuZ4mdORa8C2RBY9A3rg8zSUYWyX9CuM5zeIYpWINw/J1qbutGSVHu3P
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2142:b0:3ea:b64e:6da0 with SMTP id
 e9e14a558f8ab-3eab64e6fd6mr134647085ab.23.1756192472536; Tue, 26 Aug 2025
 00:14:32 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5ed8.050a0220.37038e.00b1.GAE@google.com>
Subject: [syzbot] Monthly media report (Aug 2025)
From: syzbot <syzbot+list1b1949acf52edc8a00fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 96 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 360     No    KASAN: slab-use-after-free Read in em28xx_release_resources
                  https://syzkaller.appspot.com/bug?extid=16062f26c6480975e5ed
<2> 237     Yes   KASAN: slab-use-after-free Read in dvb_device_open
                  https://syzkaller.appspot.com/bug?extid=1eb177ecc3943b883f0a
<3> 173     Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<4> 48      Yes   general protection fault in dvb_usbv2_generic_write
                  https://syzkaller.appspot.com/bug?extid=f9f5333782a854509322
<5> 17      No    KASAN: vmalloc-out-of-bounds Write in tpg_fill_plane_buffer (4)
                  https://syzkaller.appspot.com/bug?extid=dac8f5eaa46837e97b89
<6> 9       Yes   WARNING in media_create_pad_link (2)
                  https://syzkaller.appspot.com/bug?extid=701fc9cc0cb44e2b0fe9
<7> 5       Yes   BUG: corrupted list in az6007_i2c_xfer
                  https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

