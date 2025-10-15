Return-Path: <linux-kernel+bounces-854344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A557CBDE2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C898485DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA74321449;
	Wed, 15 Oct 2025 10:57:30 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FE320CB2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525850; cv=none; b=LMcKTKxn2JhedcSdM7ysDAsJB0a1ngIdjLFxjW2h71p9O4Lo9wHsTrZKoEw+LFzsTPqo6N9nXAlMJSujyFOK+XDL5qrkCx0YsZntPKI1EVzNcFPI0XM/J32//Egiaq2v+3pzCr9lRcY1Z3tBOYs8PiG+yhvb0XdQaUj0v5HWpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525850; c=relaxed/simple;
	bh=zAWDx3tIFHM1BSYR3NxG2zBbTbL1iu8EeeEo9Kpyr4M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mBo1NroSlfFWWW0qEjCk2NB2gwr5VgymUFk1WOCXgPlck6DIlnFaLhc0xuDejPr8tZQoXfQl6XMeT4Vvz/1rUJ0ZUhiovUSYcnsT3C8xeUkgPuGN4lGVG85NvYLVJKYMHsHc3ChhOJQZ3r0zsYLq26ZVT7w3NCpDCcdmt9PoUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42b2a51fad2so9562385ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525847; x=1761130647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJ0UPEBIr5F/l6Gs+Yq+zgXthaPPwqqa0MqDdVTRD7w=;
        b=bbWgqnDDgbz8sncoE0BK0HYsJBguv0CrxjMmyPQTh5cdjoiX1Dh8LUlKOM/++TCRkY
         8aEiRKhQxbMbkn9F/fQKRLC2P/LSWRZq6xsFpZCo3/sxGylWIM2dOst/DQVC9+4gj09i
         AdOAYXw2CZt7KhyZZrPE3gIelQ1e0YQ8WmUl3KZvVqHkVQnC46tZ1oUzkBNDIUUMiZ4d
         X7HYadTVhwjLV6Avk1epAsHYjePZ9j8SDgRDdQ5bP86Aur6AiMWwuKDY7TNXZfYbO6Ox
         WU05sD2LDxb/2R2FM6jox7uWedds8lihuNYf9kUTuXVFprRqsW57/dMIKP+ZeG/mVdAP
         AlWw==
X-Gm-Message-State: AOJu0Yycx3Ei76kbhdHBOUgVdyIjqO7Fh2B0DfKZOK+wxHwDyOkIgpkD
	gyOxPrUvFHGDGb9aYGgsenUsTG3+7V6QwHMWN0x8zXf9WOEC/mS32HWL/NX8FPfhdG5Vm8PghEN
	rD2FuSh+9NJvbbksw9g9QLRpN7WKVShxodT64sZ4XFVrvJrTIYZa6d6112+8=
X-Google-Smtp-Source: AGHT+IH2h2RMp2fIlhrgNwvwTNGe5V8AcHshxopNCzzwQw6MYpkNzPqwZPRXXIrffxZJY0nM7nEu561VyiiAe1Ml0XixBSPpLiAZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:430:ae6b:aa15 with SMTP id
 e9e14a558f8ab-430ae6bab6fmr11834085ab.12.1760525847491; Wed, 15 Oct 2025
 03:57:27 -0700 (PDT)
Date: Wed, 15 Oct 2025 03:57:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ef7e17.050a0220.91a22.023a.GAE@google.com>
Subject: [syzbot] Monthly x86 report (Oct 2025)
From: syzbot <syzbot+list6ba08bf20ccc16ba1b61@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello x86 maintainers/developers,

This is a 31-day syzbot report for the x86 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/x86

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3368    Yes   INFO: rcu detected stall in do_idle
                  https://syzkaller.appspot.com/bug?extid=385468161961cee80c31
<2> 585     Yes   INFO: rcu detected stall in addrconf_rs_timer (6)
                  https://syzkaller.appspot.com/bug?extid=fecf8bd19c1f78edb255
<3> 5       No    general protection fault in call_timer_fn (2)
                  https://syzkaller.appspot.com/bug?extid=dbca4dcd735c25501713

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

