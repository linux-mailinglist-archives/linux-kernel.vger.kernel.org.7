Return-Path: <linux-kernel+bounces-643636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EE4AB2FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749F47A37EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE34255F54;
	Mon, 12 May 2025 06:34:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7652550B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031663; cv=none; b=X6+8a0dyyLBUXJDj6B1W3EYl0FRAX6ugowzHWpbe08lJiNjxr7WGNfqOgO53UufCGDdvO1xj7JJ6n3fCt8ls697jA5I55vx/MTACjZ6aXrKVrSAVkxS+xc0KLrynU/uEgRCoR7YknRowVfCnjQkYRzlHzzi6+Bu4Kg3nS68y5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031663; c=relaxed/simple;
	bh=dx1xwTZDbaZY9TJ/RvC0JYpCldMZJmDYnz/sEdttaWM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZC5Z9nxsd5vh9iO3n3lU5vGbUPPsgmCPiasIJ18NgPRp4zsEVnQ+jAV1UHANjaDv1/aNkFBRVZsleYhB3JElfdyHvQDNmf1415SjM9vcJ3cofOYBuAkiwsy/AL5DqPMCkyta+6pikvgPzM7A8lnAZSHsXSUtJlg56rkU3PUJBus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b5e46a526so323892639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 23:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747031661; x=1747636461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNCTCFViNT8bek4HRRT3/aNA6OTSRILgCslp5/6v4b4=;
        b=Rk+Jlfk0Ov+fr/xg4oA1ymFrStmiU3nWF4hi2GjlgGDwC/yyCuqhg+xE8WvyIxjUj1
         8DT/1CVV17U8Um62luUgSZDNlg42OZTOfMrzCPPwwx2/QVKP3XTeROMVl6Mpch5ieUaD
         aSTQZqF+xsLvCHHQNQYzWQ+JNYe6RAgi2LfTqokEEsSXZsCmLSr6WrXdTuMrXUXxruHY
         f3YW1uum7L8keazNSb9lGHln2NIMFAJXahdzDeWbGAIeevHPUvkVns30YT9fEQOZnMHA
         mP22RmxSxR3CKtkFXp67e2HxYEfQCxsljivjE7tWjWmQUHn5hkRBsXaB5aghMVUi6AP3
         0AiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV55JomkEOe8ilODNlkedsdSAnuvbTKb2sGzKAteABqLXM4GVAn7Ff3z6snkelJh8Ung5OvyBj2jcAjmpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDzrZumRlYNGUyFb5jU+lR5Av+AgwwL1VeAtLXp0Zy5wWYoZX
	xbF7wFI3LnBTLSUATo8jdwhKdHYmYeVX8Doe/K3nDBXGsz8Jfr3krNn6mboK9fZ+CDVf2cWiTBG
	p3spiUqVDxD6QIEMehIOsIFEak1lQFsffaONt8VKqv+WtfUhKVtKVY/g=
X-Google-Smtp-Source: AGHT+IFRefKmtjW6013ms9QCXydNgmsa0owtvurRwlGX5Q5Y5xPOhLB3uM/XOrm4j0NA2Z4BXCNjuho3jkrk6R4JlWiB5NCiL7kw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:640f:b0:85b:59f3:2ed3 with SMTP id
 ca18e2360f4ac-867635c97d0mr1423178939f.8.1747031661590; Sun, 11 May 2025
 23:34:21 -0700 (PDT)
Date: Sun, 11 May 2025 23:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821966d.050a0220.f2294.0052.GAE@google.com>
Subject: [syzbot] Monthly wireguard report (May 2025)
From: syzbot <syzbot+listad97b905a104dc343053@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 19 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 12253   Yes   BUG: workqueue lockup (5)
                  https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2> 360     No    INFO: task hung in wg_netns_pre_exit (5)
                  https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
<3> 248     No    INFO: task hung in netdev_run_todo (4)
                  https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
<4> 3       Yes   INFO: rcu detected stall in wg_packet_handshake_receive_worker (3)
                  https://syzkaller.appspot.com/bug?extid=48f45f6dd79ca20c3283

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

