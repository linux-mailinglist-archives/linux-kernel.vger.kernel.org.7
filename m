Return-Path: <linux-kernel+bounces-685600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38591AD8BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2B537ADDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A552E2EFF;
	Fri, 13 Jun 2025 12:25:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A952E0B7B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817536; cv=none; b=Dpqkjg4yD0yCSZKXAHfcW27VKCZZwNR7s07tIP2UsmaVp3anOKpCwGnDcjxjyNtCEvAh4OzYsIhmI563IaXQ3fgXeuWGA4xx5t4mPEEmokJEMF7IIZoBc6xxntonSPI4Ek+/3P3wMlGW42fN9jp76JOJwxmKCVu8YLHwjlCcXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817536; c=relaxed/simple;
	bh=v4nV6ArY/b2cxycNNBhT4o2bFDGH/w71FZ5kVdLb5xs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DZmSP3NBOSVuUWO2hWtOk6dWOz64Yf6tFAnNi+MJryh4upxrtj5WMW1j0iYtCoXGRYsVpLtib4yGnDo9s6yHNVLRh+eVmzcevvvk31pA6lIUEzxwQR+LxSHgxWgnwZce+KPHjMRRwqaXgmYeauKdFLAyqofPY/iuQrHCnLQVV5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddce213201so21146925ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 05:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817534; x=1750422334;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrCliSPKgn1XpxYnvyYXYhtyX+ci3ht5hIAyC24GxIE=;
        b=KbvFkCozKmmQRDWa+hDJk+XgJO22D1eEAkQk4coBxqtlf7OI3yMUQWguZtg1t+SV7G
         dis5kknjNl2PrIFISSxKVjBINzR/ZAq0O1JCKJhvknfcqnSU9vEwIs5B0zU4NwMWxkVm
         16hkvubvZZp3FPCKsRGr+NiuJElUoe8Ti8eBFLMdAdxGeQVY2vU4RO4jtBE+Anb84lni
         aCBVrSUddhWwTf4WPp1CIarHGcyY15x5Y9ls1QcTArDT/upTh8RZqkCJX+YlXTKW6JQi
         NdS7VmJFDMvnMv4SqZdovRz16e816ZI/0PX29b10QXdcQ9xZPAkPjsM4NiYOifya8l6S
         uyKg==
X-Forwarded-Encrypted: i=1; AJvYcCWWXlL84LajKIoBIA/CCmFJH8qprBEIFeKNJwr0eTk38ndLU+JIs4ETfp2nQpofhdpFqfH5q0cpKNWjjOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKJD5VAQzI69/UJU0h9Ht4zDRbll+QSKW6qdjlV778pjAzBOXW
	uYGnUwBm+l66vUtBraiKtAKr5PUuUH5ShXKhNYUaxpHu32IimBamFwRAtxoYkM4rV4PzRQkmmY4
	bzUxkfpQW9w/9BFT07NV9+zRf2TcksHKtAUhFq6aCNyrG6d0mp08bvi6aEyM=
X-Google-Smtp-Source: AGHT+IGE1fnfL3o5IseIDYF6yRyjy39RMc3Jof33bin8vIigQgcPixdDS6fgFWvpv/PFWVGDKZjP4PYCOEGAmV1ZuIT1IX8h4jnu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcb:b0:3dd:6696:2da7 with SMTP id
 e9e14a558f8ab-3de067161acmr5529625ab.1.1749817534313; Fri, 13 Jun 2025
 05:25:34 -0700 (PDT)
Date: Fri, 13 Jun 2025 05:25:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684c18be.a00a0220.279073.000d.GAE@google.com>
Subject: [syzbot] Monthly input report (Jun 2025)
From: syzbot <syzbot+list7c1df8bebe8dcd5a94d2@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 59 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2148    Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<2>  1179    No    possible deadlock in evdev_pass_values (2)
                   https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<3>  799     Yes   WARNING in enable_work
                   https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<4>  538     Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event
                   https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
<5>  166     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                   https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<6>  64      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                   https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<7>  41      Yes   possible deadlock in uinput_request_submit
                   https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<8>  26      Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
                   https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
<9>  18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d
<10> 6       No    KASAN: slab-use-after-free Read in report_descriptor_read
                   https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

