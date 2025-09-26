Return-Path: <linux-kernel+bounces-833616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA0BA26C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39214C85BD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9E7267714;
	Fri, 26 Sep 2025 05:14:34 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D9926E6FF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863674; cv=none; b=j6wJcHAWw/dDDeHhDt9+2hot05D/KLgYbSoexz18F2L2bznmbQbhmcNwfDv0vGtLH5Nt8IFq8z/8zh3P4A+koSgebzV1OabypgeSXdYLY5C3fJgu5sGi25CXNdyR+ueKZp93Zg6idHQ62k6NmRpQ7Jw7sOSeRJ+F8lDVEkNHTXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863674; c=relaxed/simple;
	bh=HSJtfGMM+e3EPXGEEqO/EYuIjZZOdU8m7yB3yQ59liM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oEhlU/lp+hOL2C3VKJrIGg/LyC+Ysbyoo/YYPdGdlh7oKPEmPhbuWhRwondJbrEzjO17+ZNAeRU4I2SfvSYP68gfVo3ULpN3PCDyenLp2j//u2O3On8kliSMaEbhMqDmpE3eBLJ0GO9qJIKk5lC+jkdl/57uCmmE0xtmDvjBF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-426188f9ebcso17795345ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758863671; x=1759468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wHZMBxinlsxS+AKs3lrLYDpCFnfFQW76Oxq6oEegMGc=;
        b=d7vpYWaYd1q6qFK1KhYksLtGvvrPYAjYQhiMUYb8uWfK+fD6z80R6Vg0MBreqaiWLu
         Ep7o2wAUYxaf+KyC6eAtqii0RJERi1E2cij0YZI9TImc1UGi8p37yiwRfmoNovWAia0o
         +N4WhYUGehQ/+wpDLfeNphZhNLASJcAs0e2wu/wRIeyMchFMjtpnLOxnP3iySt3wp8g2
         XAYJb+/zFZwadjqNS+oGXTBwT/3S5rDuWa/MwU0YwLj8CjLdzZLkaBCnwcApLVAys8C6
         VtnxkhFSRdSc6Emxrizl6ZQm7bc8s924fn4VNtKjLMYqgovZzmJtZWn/m2kKqcxUGIp5
         QYew==
X-Forwarded-Encrypted: i=1; AJvYcCX1fw0a0s1QBQo/1YO22v6bRIA17j5LPlN2H0IKkaFUl7ywu57gnbhSxHqL++Qjrizxae31wrjHQ8sdInk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkYaYt5dGtAjwL8+lJgFDcJGtNoddpu3g/qct50MmN8ua0Ju+
	ULEK+oa9Iebf4rTQikoTv5ppcJX2cN3meub3INdvwrJs37QnH+B5FW/YuJG76WHSBFPoXWDK3fo
	OS0RMpZY4tffl0TD5x3dyaaysV1kO7Uy3KjFI6C937rutIWoHMwRMo7I892w=
X-Google-Smtp-Source: AGHT+IF8SkQF1fJI/UhUezrn6BNK51O7jh6XTi8kzkYAO45SlOIqJw3vXGUvLZ2puFYiEpBiG+LXVyggjBpPUry+oh1TUvMF/CEa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c82:b0:425:715a:e6c8 with SMTP id
 e9e14a558f8ab-4259560a9eamr86275175ab.13.1758863671606; Thu, 25 Sep 2025
 22:14:31 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d62137.050a0220.3390a8.0009.GAE@google.com>
Subject: [syzbot] Monthly udf report (Sep 2025)
From: syzbot <syzbot+list86729d0f0fc02f3b9fe0@syzkaller.appspotmail.com>
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
<1> 13762   Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 1334    Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 580     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 147     Yes   WARNING in __getblk_slow
                  https://syzkaller.appspot.com/bug?extid=89fa933c2012e808890e
<5> 105     Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<6> 40      Yes   WARNING in bdev_getblk (2)
                  https://syzkaller.appspot.com/bug?extid=7f94fe3ce0f6613e12b8
<7> 9       No    KASAN: slab-out-of-bounds Write in udf_write_aext (2)
                  https://syzkaller.appspot.com/bug?extid=4e1da0d327b65949fe1b
<8> 1       Yes   WARNING in udf_fiiter_add_entry
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

