Return-Path: <linux-kernel+bounces-830511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2216AB99DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4334C03FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F39303A11;
	Wed, 24 Sep 2025 12:39:37 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD5B2FCBEB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717577; cv=none; b=sEgP3mEyYR5rfyXwCiGNU1GaZSs6iJe+b0frT+cQrAD54QsPwyMHoZo9076Mw6r/UH9ZuT0iG0vRMnvoOFE7nGRH0Ipi7dGhVBi+LCSNtBpYDn7jpUWXCmAVKeujvFiZuD/hJdsOC/pPfRQXic5Zd1Z41/yhiq/B+wfAMANAcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717577; c=relaxed/simple;
	bh=V2/S5MXhTJkF4QgiGL3HfzT/h2NijYPEQbtg+qrGDsQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GlT0qMg6BZxzAS0vV3Adsi8V+NeaG0kpz0csD/TtPsH0HAn8H2Tmt0KVH+aGxQdMksYNB8QOYjFf/1aKzr+4F0l79ng9NO+tqumuu4y9mTgy7i+zIMTfLQWteHdRhNuMBBwjo1Kn6JzGQDnsO2PGc0cr+bDLdQ/w08opjoRGpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8874f33d067so833608839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 05:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717575; x=1759322375;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igFS+SRzf9Z12WxHY7Jm6XPcHS03o4aQgk2xq1X3WF4=;
        b=HR3KB4L9lSM/xTSDbj9QG56SwHtnI4PRITjR4uy0CSeUal4P7eY1QtPyht9GhaMYXM
         hQoowolccIcpHj/RTV1B0/9jpIyS34aCMNeZMeixE2nZ3I7VA31CHTuyYpyRWhdts/7z
         +ydC6B9WdzeMLwqFc9ohl/0oBrp3rqo+E72Ea3Q8wcaJZi/FcFgF7KmBw6bdnuaSb2Ts
         Nsc961QUl+mdcQA0s1eMyZ9O/vivew1/BP5dvJMvcYQthi9QcONxo/N1qj7wl6p/Or6D
         bIJ1eOVvzTUE4WUWfr0rBseQZ7E9hGWliqnESc1AJ1iNgy9yd8D7NTV4BHrRe35SuLhw
         xZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT7m8CigyCSPNWY+UjRbj8RdNbSPPjBnmw8km4JvR7r1cqQ6aK7OEkdnH0yKmkNlMj3Q3bKLU5wt10mKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGfEBgJCX1pMWVImgpPF9/ENoD1fDmp6DIi7uEeGmgccJQTvXp
	vmgRHhgLhQKYTB5oSf6DH9MXHT/RCmO/Z7ePAyAG4vJWU3iiZHUP1H/c4Y+cGGOiYnXmlAPiGIu
	Ac9cq0zKGDetC8vjDIZzRG/3g3uQLFx9gRNUdqgUu9TfuB/fXxlGqye5HSac=
X-Google-Smtp-Source: AGHT+IHAw9v7k4lEmXT0RSpYDbkepjZ8o/GpwTKFQKjV1xNTesT+/FGryWRKD/sPKGDWYJTBXqKQZBHHSYUAhQuhOpZgib1r6rGz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:b0:423:fb44:e8d4 with SMTP id
 e9e14a558f8ab-42581e0df9bmr97795075ab.6.1758717575140; Wed, 24 Sep 2025
 05:39:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 05:39:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d3e687.a70a0220.4f78.0025.GAE@google.com>
Subject: [syzbot] Monthly kvmarm report (Sep 2025)
From: syzbot <syzbot+list12018f178486b71446df@syzkaller.appspotmail.com>
To: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvmarm maintainers/developers,

This is a 31-day syzbot report for the kvmarm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvmarm

During the period, 3 new issues were detected and 1 were fixed.
In total, 4 issues are still open and 6 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 6087    Yes   kernel panic: Unhandled exception
                  https://syzkaller.appspot.com/bug?extid=d173b3985bd6b9487fa1
<2> 441     Yes   KASAN: invalid-access Read in __kvm_pgtable_walk
                  https://syzkaller.appspot.com/bug?extid=31156cb24a340d8e2c05
<3> 10      Yes   BUG: unable to handle kernel paging request in vgic_its_save_tables_v0
                  https://syzkaller.appspot.com/bug?extid=4ebd710a879482a93f8f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

