Return-Path: <linux-kernel+bounces-786109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E879B35513
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9593C3A19DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4E2F7462;
	Tue, 26 Aug 2025 07:14:35 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCB2F60CF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192475; cv=none; b=PssmMVlvJyOLgDC573CS9lAl4vjqHXe4IlwyLoW0rVLaesc7NsGXSFzVuzgZThW7IVaajXdmR8Lyt4APpjSr1QV9vFkcs57FWhcpUML4J5JANZArNeARfIGYwUdVVfWAYiwmpoPlVPqAqOAPMKmquct3wvz5y+lhsRyPJDZ6xsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192475; c=relaxed/simple;
	bh=JcxRRlt+Gecjh5qT0+KSCE0LEECzgZWFhcCe6czvDkU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ksAlZM2gshc0c81chOkOdbU1TRdAg2kUACyB/kOUuD1BMcSGn0678xB1dRyYbo+xuWyCzZcqL1kz75hKB/yc4l/xDShvgvXyDoJhxaMIIGUGTS+dcUQG7tOOGAw9WybwIngm7cgszKNhBb1fruYdqKOvpjSUHlgaL1IEzB8wx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3eea931c037so14081275ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192473; x=1756797273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmbNPf9Srtguu+B0auyvT+R43TUCKVTg9+DZPZykivs=;
        b=oNIrGV+2jppjFMykpnSaIiQBXyDuD3s0RC7ux1kk/SPMTTHzztWybRCAoYQDLneqny
         a5jmm338YRw2k+RJETqSi6fHoAEFFIuXW1bntHFeyiHwp3e6WVisR2vIb9WFA3P33FG3
         +7861CxONJMOJAbyufBt/sTmtM0ZZjyHcGnScdhHitFA9rcOwSL7h4WUanvG3afcECnb
         K6+K8fohLVis5FZKg12ee0XAZXfInA/ZrJWNbdRF+IQoOR4VeeGvwhi5wpLOOi/qVAt+
         /tPXdTWVJEDw4CRlhAIgpu9gBp30I4szEMWbvGTuE3+F02y2UTLi/WarF3BifZGI4S7v
         rcTw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOHXkl+yJi5Q+1xEQJuRmf4HmbMFptWfHTAH0pJ7f2NRLj3j9eKM87GOZ40qVJqF2vhB0fbH9CmxeNZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPaI9ZacQP+pXPFvIJNKyaHYGtOQ+LUCigLlEyJ1U8JL7/2S1
	gF54HdB7zBVqSlQQoMDGENx3ToCQNWf3rv7B4NUc8yf38AT+gBL2uZSrlsfJXHFUIQQudipuzcK
	jXdwqxI/5HEaF7b33LrJGx/JylQ9g90lg9LKRxuscFujptHY9MIxwqFp8KJ0=
X-Google-Smtp-Source: AGHT+IHFKb21tJy4sBQBipibon24KUW1DwEtdCrIHZ7+rODLav5WBq8j9Jr21TxfM6fIb3Z1Gn0fEdju2ASe85o2qkSaCJH0bsHV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3309:b0:3eb:1211:8738 with SMTP id
 e9e14a558f8ab-3eb121187c5mr114177505ab.21.1756192472760; Tue, 26 Aug 2025
 00:14:32 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:14:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5ed8.050a0220.37038e.00b2.GAE@google.com>
Subject: [syzbot] Monthly udf report (Aug 2025)
From: syzbot <syzbot+list948ee5c65e0b757a7721@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 38 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 13239   Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 1275    Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 530     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 140     Yes   WARNING in __getblk_slow
                  https://syzkaller.appspot.com/bug?extid=89fa933c2012e808890e
<5> 98      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<6> 1       Yes   WARNING in udf_fiiter_add_entry
                  https://syzkaller.appspot.com/bug?extid=969e250fc7983fc7417c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

