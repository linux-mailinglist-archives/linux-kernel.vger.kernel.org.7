Return-Path: <linux-kernel+bounces-586210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8BCA79C90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 09:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F1F3A6385
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96023F28C;
	Thu,  3 Apr 2025 07:06:24 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F018732B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663983; cv=none; b=kV+C9kpuH9r4Zo/WKXLgULu/J41wLDq9abi9fBXeiugIYyFP+LWjzbH+N1OZVTTBVNoEylYEWqDem+asW7dNdd/qruYMy+vg2U4tUwjQYaX/dMVGvmnTmWHipqqpZSoERJEC1hK9pFoj4PGhkGrhvcz8N80z+5+Yeq20qgJp7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663983; c=relaxed/simple;
	bh=rgdstKn60sD1Okf2hAloIZB3CTc4wYl85c4OrwQ3qJI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F5AH9hV67OycuH92W0Zg2H84DdYpZ163QXkm7L57gW+wQLmvP5iCg2f270LR7FffQYlG+bP1Ljr1yP+JHqeMXrHORR2p+inq9IEgq35X/IBGSa0yUgJ6FpgRASytzIcRi4iKux5vuRXD99U7QGdNHsvWQkMNr+ZFv9STbuRm0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so67413939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 00:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743663981; x=1744268781;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vFLX8CB9J1hm9b0MG16a4Sih7/+Grqg2geKmMLii7Y=;
        b=fT6VekmXFs/T6Iz8/C+uGMkuFq8854TOe6b3mkTxgpkLv5nemEeqAOxAT0I6oWTAjh
         tIz5wCrpI9Yl127naLjLFexL4SBwhjgN1j6hhDMuqz2j8wCY+pvv/3RteV2zvASizbZE
         /KloafjD0xZkMCt13vw3iq34VtyQhU3OY5K+YUxlzDWAS1q1MrdmUL7+FswBgBxPaphm
         LumJ3By2leljfjMO9wqv80nh0a3mxdpTWv1GMBiu1irl1cJxbD8Lf7GrSsi5x4vBcrfZ
         pKjzj8253EgStGA1BJ+JT2r8wSXkOoATAer6lwObPHCaiwJvZxr8Y1OwF6QuCneQgasJ
         lgSw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwh6Tbpf+L1MsoyCCRFOQPkQRjXiM5iafUdbeX+UDgBcAOM5WJ5LEAuPOUAK0KnZ3Mbum0SGUStNm7hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD2c/RTj9GRjgsKbzgHBGvgtv8qMy+tfFDoLJI/CzNmNnHFbUT
	jTvxRrvr1dLdkZilSLvLtiOKHiy8/scwTCx8WK88vur9VescpHMEMMRocX10Lsf7YOOgsdTHvXv
	+acbDXpf4I8jEvaVp2Clr667EPVWJeU8SYBk7tZqmQxZWkWJo4p5/nHs=
X-Google-Smtp-Source: AGHT+IFXGxgA6l2MUKszTI6qTYG2bWbrfzzFe7UZow8mndTDS1q4BqGgogI9ec6oVPUw+7KMi7bbAfankREseWxp76VG2QApMSfY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194c:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d5e08edf07mr219711355ab.1.1743663981333; Thu, 03 Apr 2025
 00:06:21 -0700 (PDT)
Date: Thu, 03 Apr 2025 00:06:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ee336d.050a0220.9040b.014f.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Apr 2025)
From: syzbot <syzbot+list3fa35a27aadd3050311b@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 2       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 1       No    possible deadlock in nilfs_evict_inode (3)
                  https://syzkaller.appspot.com/bug?extid=cfb767df63e683c533af

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

