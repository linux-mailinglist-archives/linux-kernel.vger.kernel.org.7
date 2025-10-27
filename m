Return-Path: <linux-kernel+bounces-870869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7671FC0BDFE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A88618A129B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F092D7DDA;
	Mon, 27 Oct 2025 05:54:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB42D6603
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544475; cv=none; b=G/MVp+CB7Q3tfo6mhLFRw+gAEsuwGuIJn/tC1sjjRDZWXoTKpPl6pScO48yy7elyXXtUNUgkuauVYPUhiPBy6LJYBz2ecb+OPf7N5fq7cmHhqxqjCijLFheEghn4ola+k/4hekfxLrmVF03l9XWT8M6qj2ajdAeqRNC+1PS9CZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544475; c=relaxed/simple;
	bh=PztpVAs3drt48jvt9eLs4KEy4sHiRmkCetB9IDuYzdY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bEI9+JI7Y2VPTWTuxgldgO50pbDBBUNvw6hNj8MfiKJMEn3YhA8F/eFvC25zUpp0UhKmb5c6BN281MwV6+jL2w13aQhLcfQyJ+JS7HlkpylPAnJkg+5zASrsDQuSIzlS0V+vUr63gpuQDr0Q+qD55QAljZE1fK2J9ouwdy3JUaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c523ce49so53313565ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544473; x=1762149273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHSw8fUQiPVOwSm1qjuED0GSm7e0skLcOl1YEGJaMZc=;
        b=M0NzxYeVgs6AuhwFUKGhqtArZd0Es3KMB7hoLcmD02mcSUaJtJw8RJtShGfzSh7XvV
         TrYcrdDnWJKQdNp3biPbMlk/xvju+WXC99oiXn5+TgrwVQ/USTnQ4icF8CnhZ6RjDiky
         e7gGz949GbawP9PNtAWTKv0Wcin4j80h+EtMJ6pVQS+34HphSyFnBTFD2f9mrMYLXzHt
         Z981u7EaWt1D4/FXWQZSrU5ituYsfu+R80sV7ru/rXKmEvI/0oKIn9H+m2jbFR0rPynd
         oTL9gUrtQ45fdENzCPcRsFkCVoZ5PhsihVkRJGEEujleGi+wWfUCgW3AwfpPfw0hLAot
         f0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXjor0ZU0sLua5t6k8vptfjOWBO//U2X/Pvb3IfFoO2bXMWT8ZLnxFENQrSF1txSiGWHtCAAd9QeRs3boY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcyPBGPwpxBxcJTQJBhU5pTIu0L1CWFW6Xlt6H3b3jWDxUXBD
	7S9tnXJr+k5CCCRriNheKsNpPHoYI8I7uRkGp2eP0HnMd8FoQi+Vh39JGccy7+97VT3oBSZTlQ9
	XBcrlrA7eHzHdYokfQCazmpcjy4wMD78SYjwNtGfPAHBHrEu+Lam7+57+kgs=
X-Google-Smtp-Source: AGHT+IElPz7lInqcyPE0acwJcdaaoIb5AJ3HEuFkfO6w744ftpIW8TXqSBX4XNn5UEURG4vVydUBvRs6Au8X+MqpJKccAKZ8g1ZB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:23c5:b0:429:b49:7351 with SMTP id
 e9e14a558f8ab-431ebea7a17mr119796285ab.19.1761544473174; Sun, 26 Oct 2025
 22:54:33 -0700 (PDT)
Date: Sun, 26 Oct 2025 22:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff0919.050a0220.3344a1.028a.GAE@google.com>
Subject: [syzbot] Monthly serial report (Oct 2025)
From: syzbot <syzbot+list4bcc9e973f97dc44b961@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 1 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2490    Yes   possible deadlock in console_lock_spinning_enable (5)
                   https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2>  1829    Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                   https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<3>  908     Yes   BUG: soft lockup in tx
                   https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4>  223     Yes   INFO: task can't die in show_free_areas
                   https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5>  221     Yes   KASAN: slab-use-after-free Read in tty_write_room (2)
                   https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
<6>  188     Yes   KMSAN: uninit-value in n_tty_receive_buf_closing (3)
                   https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
<7>  115     Yes   possible deadlock in tty_buffer_flush (3)
                   https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
<8>  36      No    KMSAN: uninit-value in n_tty_lookahead_flow_ctrl (2)
                   https://syzkaller.appspot.com/bug?extid=290abdcd4f509377a0eb
<9>  31      No    possible deadlock in kbd_event
                   https://syzkaller.appspot.com/bug?extid=781c8bb5e4d62cc883d3
<10> 18      Yes   INFO: rcu detected stall in console_callback
                   https://syzkaller.appspot.com/bug?extid=32af18ae7b894a681f2d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

