Return-Path: <linux-kernel+bounces-661681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 144FCAC2EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 12:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB551BC1B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 10:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1021DC1A7;
	Sat, 24 May 2025 10:05:38 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6119DF8B
	for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081137; cv=none; b=coung8NGkV388m60tvTHgWHeOu7wmowdGg7OYE/97ckGoOhcFNWhNlbwyG3L9DgLFPPpJm+kACKiFUjJep2GDIyLoPIHAOMjUWazjGMLvzRlgIdvGILX5YtUmo0blbI11omyxzcgR8nDDFcvbQzCUQ9A8Wst5hy5QIqjgCLpNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081137; c=relaxed/simple;
	bh=R/xUfFzp/fDQs7kjT1aaG1SzWQb9aRjoB08DOs35MKc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NSy1TciuRf4m0xP73gwHsOoxcq6fZ+zs49UpPWL22yzl7BNv8g5PbOpF+2BkHGLAKeFNR7Dv/78/hyUrMwEc1ydfFw0gUzFKBtouHPVNjImKY4covU3Mu1EjnABetdc5+sUJ1WsT+dJC1+3o60V3PBi3o4nzTW6zgDXr7hq/oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3888569bso64695139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 03:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081135; x=1748685935;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyfvruw3e4VtCQ7JMVorHnOO0iqIjFUQMoSg+g63PZg=;
        b=eTqahoZ4qTZ48X1Dg269SQMmjtBVnH0bwiK4X362Vr5ggmxrkJlUaddfDssPlNcAt/
         vMY8kCZziJm3WLXFL77nf1WqJndQgnTtgA6PTHLDR+Tsn4z/8KFpllzvp05EBsgSnqCw
         /a2NmRDOAbT9Vvo8GGGQYuBui8DEkvAQ/YnR4Pomw662CFMZOcmclv5iGRT85kMhpX7D
         S0arh98/LdhzLXnAgoBZFEsF7QNp8D6/NdsqaRHHhBXyi8mjKEVtaKVJgOUJY9AP0Npn
         zYG0PhBthWrstcNJKw9YFWrXrJuBzZKFV+FXF4ujK3s3LSc3JDLMe/r0Gy47+e90tf9H
         rn/A==
X-Forwarded-Encrypted: i=1; AJvYcCWC2uPR+RA0l+dJ+WY6nAaeFsZ8QsZlr3L4UKpEl8Lhr6K7r19B8iuuvCk9hXe5ts0ZhUBUQHBRvX9MUVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8pr5DIwwZIaknDCV43qubtEREDfZuGYxGk8f1yY4yPoA0Ggo
	HYPvhWfmvKswzg3+wb3cqIDlk9ZrYTdrtk1BqTr+u6jR5lUR8iFjpD31mTwfobed2QSk+MZa3XH
	eBh0JlOKDES3bQ9bMhtFpfR2qL8A2uJcT6XmjPHtvAR4JLLKyABoI3BQF1NM=
X-Google-Smtp-Source: AGHT+IEElf9Krj6BjGI7FhWMTrDmS6kdI4GVCZfePlLyRE1YAlSwIQjIJu1+CAVDi0Zzpu0/E310rIO+cdE2Dur9ZeSbCDYHm4dE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d17:b0:85b:3ae9:da01 with SMTP id
 ca18e2360f4ac-86cadd5ffbcmr601311039f.4.1748081134809; Sat, 24 May 2025
 03:05:34 -0700 (PDT)
Date: Sat, 24 May 2025 03:05:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199ee.a70a0220.29d4a0.07fb.GAE@google.com>
Subject: [syzbot] Monthly udf report (May 2025)
From: syzbot <syzbot+list27569dd09b9fd53c3177@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 11065   Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 1097    Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 361     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 50      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

