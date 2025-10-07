Return-Path: <linux-kernel+bounces-843901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E2BC086C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC5631892976
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736852571BD;
	Tue,  7 Oct 2025 07:53:39 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA9255F31
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823619; cv=none; b=JZBC0ZnfhTZW3ieqYdnPTVZgbIVnaJLpZir3aC+VHuJrEsGx9NELX+wsVqrdrPSXQicyKQO+chAxKX3Zc8f6D8HdaT+NevpRn9i1xo020ilTBEw9PggA32E+OnV5JZFcq+aF9rS7tEmY7BIlgAcQow1yCys12qXtQD15t4leHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823619; c=relaxed/simple;
	bh=SYV0VzaXmVcdrymls2gZqsHHMs4sDQM9FFCVeTA5+Bo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r7mN4VgAvhFuB1Vdh2Md7I5/LV2GPos2qf6tZPU/Zo5h8whUnyFM+maqe4Gj4fzUJYSo/KMTahE8ZJ7xPyuikVHR4qMskkQsMNQOtUdXIbSivs1Bs9k9I/UzipBDZp26qC4G9bxOt6JDQBOzrlyJ6tOj5wtI2UjJ+5JOl2s58xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f610046d9so108991915ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759823616; x=1760428416;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlL8Ccl5bRpb3O8T+vMias4aOm48j71+Au75LzIRuyw=;
        b=Y6QRtq1cJLqW2WM6t6t92fTpMaxBP9bA2GM20s2gu/F6+k5u6gmtebiPnCEu2tBIGW
         53OjmRBRFCA3p4vXDP5ZvyOmVEwgVvdOu1jVPCWv4ZV6z8g96+eNOQ+x9tU0oIJTctKZ
         BNtcE6DgjE6FSfS2/JImYBruxqXvbdQQExnj+DmvlcDd2IPhDstwjN51pVpDoj6uhsS7
         e1RKiIrWY5IFHDLZR8DBPE1MCUtWw9H1bg0ggD2YCkZn30msVdj8Hz3W4lkrKJGQjZ09
         wx9MhX7qJGMiS5LUIOKg7e4G/HtXsvuKKnNq8RlpTl5g3p6dAxEtAV1uUbRbB/e0IaC2
         32cg==
X-Forwarded-Encrypted: i=1; AJvYcCXVE7BDCcR5++fL8ATTv7kJrf8ANfVW8Da/mqWbNLPk5Qtn/F96NzDf4Rwl4aScDm8sMxTKCaStLbGpYZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEyudmaIIeoakzBBup4HQm4Wij08EsF/bRC1XndgVQpmutGm2q
	UAQge6xEFrxljuTislvDevYYhKpjKlzNgpVt6qlSsFTmXKtXbpJktA8XPWRyfeng4Djy5I5uQ2U
	F0xEo+DXp8RIvzg81+st0mWC6e6X4GSgQBsQfrdg+jVvN2jdRG+CxgKTmmQI=
X-Google-Smtp-Source: AGHT+IHQWuTSZu22Hq6Tt7NvdHRh/KvDDARAleqyZs60XatDiMEIcIfLfkMudhU4ZnCPBaoXL/QYUzbzTXDQ3aPmCaTX+ujv7jY3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e02:b0:42d:5d48:acb9 with SMTP id
 e9e14a558f8ab-42e7ad0501dmr188680595ab.7.1759823616593; Tue, 07 Oct 2025
 00:53:36 -0700 (PDT)
Date: Tue, 07 Oct 2025 00:53:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e4c700.a00a0220.298cc0.0475.GAE@google.com>
Subject: [syzbot] Monthly cgroups report (Oct 2025)
From: syzbot <syzbot+list377db4cd6f4eb8386b35@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello cgroups maintainers/developers,

This is a 31-day syzbot report for the cgroups subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/cgroups

During the period, 2 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3957    Yes   possible deadlock in task_rq_lock
                  https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
<2> 584     Yes   possible deadlock in console_flush_all (4)
                  https://syzkaller.appspot.com/bug?extid=d10e9d53059eb8aed654
<3> 2       No    possible deadlock in cgroup_procs_write_start
                  https://syzkaller.appspot.com/bug?extid=1e5645cf2f3764308787

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

