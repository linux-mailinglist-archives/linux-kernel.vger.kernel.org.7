Return-Path: <linux-kernel+bounces-768801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D5BB265A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652575C335B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FD2FE043;
	Thu, 14 Aug 2025 12:42:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC672FC89A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175347; cv=none; b=clej1MlVmQwDsXSBHXbel4Oy2paMUbZhBPUuC32wCsmzH4WLuDIx36RdbBwzKZJ8dlEx9YR/yLzH5N9MJsG4WXUiBY6u9LeRBfEtPgpN6hMqDLrSQC2/HGqkb9zbHhVEJoeB5wgjgDz1Az5tkVHoC+uItINWcsCK3kyQyf2m/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175347; c=relaxed/simple;
	bh=9AVr8+ZwRaSXVUDUkJ6juEg8c2xs2GKlGuxOAIobOlE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HO43zI6g8FSTbddYt+J1FBGf4HFAqPmTeddqKvByIBklT0fBplJi6P00iqWKun+uA0w/ljrsqWU6nKc9kCjrmdibHr4EfU5jBG+wI/xQKwYCCyuf3XijPpbWJdT5lLqWMk4NAcWq1BM/fThxg/buWWvcBhvMmmX2+Q0b8MmfSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432e62d01so116921839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175345; x=1755780145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mv4/e4NIev0LVM6ZEu4+TtdJDXbpiUiEdRa70oMv6Jo=;
        b=F1Ytunh+8qXKek3IcNp4QX1htr8aO2RUSn9i/QtOHTtannak0Xg3saE6D+OcA9Z1mM
         A63yd2UZAJ96L1HlibnJwuS7vsOKBEMB7we129cXt3XNLrJsehtlGwwjisPmrw9mMAHz
         CaCrZ3+kGxXamZd5mi3f51MIGNRHMR/mFuYfb/a7WoUrwq23wx+iIAEN05K3U/OYuCaa
         xY1999AKxjJpAKeifo/EgUL7e4tWq6VPmuC50UQ96+Hzr9xPpTTH9YP0VyFicHYK+vxq
         5avaCG+GoK7HmZfwW/JHkUfS2tkallu/D7AvXyudQlBCyUPDt16kH7bX1Dn5FW4PHKIR
         qMXg==
X-Forwarded-Encrypted: i=1; AJvYcCWbJSFq0msN772tqDkHE5/rPYag4/GpzpFaseo/c8fAeuIYYG7NV3bdI9ZHd4XhPW5gvOgL652v1vaLK6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqm7rvWN/7W3S/k80tvoQX3INfh66DwEmE44yoUa5YopGxFYSB
	zoSz/e6aIvoaS+l6nCuuWoGDnvbYg0i/Eury+qbU02e27GBlMjK/cOTwY+vivXUMuEfx7r77JMx
	tCZV0zWMHKZouodzg0spHPFmcKhs3+cn0z3RmyHg/ZqqruF4xBw7FQaetymo=
X-Google-Smtp-Source: AGHT+IHTZsdV8DcVPAQxGFyD/4jDhzW69KsoReVJOLS6/TBr9mwDhoaxrvTH3qyT4fYgNs71EzPEnyoH/8/xt82otQSO/tK2za60
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6410:b0:87c:3335:37dd with SMTP id
 ca18e2360f4ac-884338233famr464361239f.5.1755175345165; Thu, 14 Aug 2025
 05:42:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 05:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689dd9b1.050a0220.17479b.0006.GAE@google.com>
Subject: [syzbot] Monthly input report (Aug 2025)
From: syzbot <syzbot+list910878d543124d7abc31@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 1 were fixed.
In total, 19 issues are still open and 60 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2582    Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<2> 1352    No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<3> 892     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<4> 80      Yes   WARNING in cm109_input_open/usb_submit_urb (3)
                  https://syzkaller.appspot.com/bug?extid=ac0f9c4cc1e034160492
<5> 54      Yes   possible deadlock in uinput_request_submit
                  https://syzkaller.appspot.com/bug?extid=159077b1355b8cd72757
<6> 28      Yes   WARNING in bcm5974_start_traffic/usb_submit_urb (2)
                  https://syzkaller.appspot.com/bug?extid=b064b5599f18f7ebb1e1
<7> 19      No    KASAN: slab-use-after-free Read in report_descriptor_read
                  https://syzkaller.appspot.com/bug?extid=bc537ca7a0efe33988eb
<8> 6       Yes   WARNING in hanwang_open/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=9fe8f6caeb5661802ca2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

