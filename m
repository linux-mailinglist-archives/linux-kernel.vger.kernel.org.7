Return-Path: <linux-kernel+bounces-855745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97ABE22BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B2A4841D4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C874306484;
	Thu, 16 Oct 2025 08:36:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1052FB0A0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760603787; cv=none; b=RqDdJS2dR4MdJUpIn3VM9C8VNbWeCT0qX0gZKS6+q1aoEIzHkfFAeNmDtBXGG4rFsiSdmZgdpxHQvNMyBzS1m4vIYRwD8pWJ9eyMLByET09Z+cUBOilgID4u7jr3YjL9LWScdC9kpsJWOqRSH3TGPNsGiRMIm4TFyykF3JYtZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760603787; c=relaxed/simple;
	bh=PCyDlCUfCq0Agt1oPeF5drU1awIBbIWG264BrykFgYQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VledPyZLU/ggteO+v8bunhgQDqiHiElAA40tHZWNSSOpOalPNCRzy/r86yzaj+fWyc08BpXu8eTv+2f3S+Pe2UDqtm9JJn9WpdJwhaI4wd86g1LPJY92lutX7edxGVOAKgtFifTC8niYMWld4cmU2a2H9DkQQCxUI2GZ0KP4b1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4308bc881abso3152265ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760603785; x=1761208585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpmHc0uOkkob1Q69uXBxTpjAuoIetwsjVGhE+E6NTuw=;
        b=VltVoo0KrTNBqDU2GNxIiYVa0OpzvJL6kNPnoD1aWr2fKkw7un8liUWfyt9zMO1Vkk
         GMKDV8jF/RhxetxJu8pWeqM0FHJZ8yfCBGaB4Ji6DabjhcFM2ggv+UfF5ZkdwBISVWM6
         4n32mtOXopKCvUXCjSBCg1cgauq2SupfDbCRO9RTLxwqG+HqfF4kG+s0kwJEo9gxuGWA
         7le9xnSi6oKkXGkjdHWZ0aIlma82FvnaliJWrjJj7PCXy1oYaLV6AqWSz5D6w3GBL+V2
         +7lgcCGugPdZp9cMC4pERyYPghLZo3jJqVfkxULa0NUb8kmMK+1QFs7mmswJCqMlZKpb
         LBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8pCZkxqHpUQiJx+wBcKx4GivDuupPWOxMmvt7kgpMeI88iVP8RjL3HGBTQVGzaGPnPlTlfKImfb/yUyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuxqUfAygFvBzGs43DjKLxF26u/QTrHbO9m+0tgKPx4f4FUPnE
	bBWtmojcLersCrCduAWzV+ac2jmMj/paE2igg5KBQTlyq3eg3/5UX/cm+6L6ys0THySPOkWn2XQ
	KHCI7wPG7tEkMpC0IYtnSL7a3DLZh0bjR+2vyZ18ILTFBeyummJ58UvJZqP0=
X-Google-Smtp-Source: AGHT+IFpcOyJyf7OezUeUoOAgv05R5w68VCdIsHbocnFHrIUYmaD8IAyNxslwMW+QuZc5U+VQxc3BnUpMbjPHNBPq9qC6DfltUJd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170b:b0:425:7788:871 with SMTP id
 e9e14a558f8ab-430b437e76dmr45661655ab.12.1760603785371; Thu, 16 Oct 2025
 01:36:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 01:36:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f0ae89.050a0220.91a22.03e1.GAE@google.com>
Subject: [syzbot] Monthly input report (Oct 2025)
From: syzbot <syzbot+listf6f192aed14fe19392d1@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 62 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2969    Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<2> 1436    No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<3> 964     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<4> 99      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                  https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<5> 64      Yes   possible deadlock in uinput_request_submit
                  https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<6> 55      Yes   INFO: rcu detected stall in sys_pselect6 (2)
                  https://syzkaller.appspot.com/bug?extid=310c88228172bcf54bef
<7> 32      No    KASAN: slab-use-after-free Read in report_descriptor_read
                  https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
<8> 10      Yes   INFO: task hung in console_callback (6)
                  https://syzkaller.appspot.com/bug?extid=6027421afa74a2ba440d
<9> 3       Yes   possible deadlock in input_ff_flush
                  https://syzkaller.appspot.com/bug?extid=ed7c6209f62eba1565aa

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

