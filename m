Return-Path: <linux-kernel+bounces-657768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE5ABF8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EFD1C0111C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2998221FC4;
	Wed, 21 May 2025 14:55:36 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5EC1537C6
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839336; cv=none; b=ptgwKmGLIJGsm50gIJ+G1Ksid+NlNEfx/VWarH5v5zVuWWbyDlvYpW/UvsQxKFL/TtvaYen7mfsT+QMFdcTv/1bwslunUQcNujmJdJQzDBcQzYKz7H2YeyrJzzPYXN0Yel1gvk+46U42wOhUef5dYc/K2+aFHMY+44wGH0axxx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839336; c=relaxed/simple;
	bh=7aC1JFlJZC4DzuXo5UNsxoo2hoz3sVAMFo0FeeyWrBA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q7OaLlFvJoiug52xdvgGuAc83yV1YJhZPV7b8NP9dd2KaADXyNJoYHSHHIK+w1xLIV+I1ETTCaw3mHljn7IrlsPBQKW/SwVYj+EW81Uq6PCp3bopl5ExuIWGypy+yy9r7pCtSj8BnkNW+aZhw4HCPvCQXfLAs4Y6kcGwZqfKKZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b5e46a526so643902939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 07:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839333; x=1748444133;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVkLcreEGxWf9CWcJBGD5Glu9UoiEI6rdnhABCYz4Uc=;
        b=HzgMaYNTbJLIm/7RmB/gtQ4J0fcA+1Vye/14msWv+KOAwdnO99TbtUhbncVeO174O8
         V0lsUyDtHdu5WITRZOoe4fJMuRBZuUvn9N16F4N+8TNeX3aM6gXha9b0Odh63hnagWS1
         gDArSDColf3BxsJAIOXfl2nY19ksOaJDLzYmDClKa8fKlcpGyFj97YAxBquZy3UQW08u
         2LhdZOEXVCxtXha6ejVUkl7bxtN5dovdhH4+1IWhqMr2QcnL6WkGcjtEMHIaoyi7KdYz
         tKUQnhn5dxGYW/CW1sGZEnBQ4xDZSkstxiAY1uC/ranC/hZl69cjdZa9vyyn67SBzjOQ
         xHeg==
X-Forwarded-Encrypted: i=1; AJvYcCW0QEYHZHwWbdckeKFaIM09De1ht3xV4ineIO+wQ3aq1hYTkSu6R5eB36thKPPudiw+AI6uwvSop7KPeoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gCrQWjrezzmBWF3rvOeuPWTcZwThfp5VifQ2KzFXF2n2zG1H
	JUHSWUXNvtqjwrY8xfcaAZNIuVyk01pEv501r75skaOzzRrjrVPJUIu0CuDzAi1D/79Lmy7wrUd
	5iCwgbSpwlQgezSd0p6NFskPQ94fnz4NJVQe4RpyshqM9fKNOMM2DxkzkKrI=
X-Google-Smtp-Source: AGHT+IHU3VOEtR1uxykFIZrxe5rsDjd3adSviinbsN8tiduT8BUfJ+kIHoWgSOKKBBfAdvb56JDQ1InZaweUiKFe+b6dknXVv2b2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a8e:b0:866:217f:80a with SMTP id
 ca18e2360f4ac-86a24c12feemr2365065639f.7.1747839333227; Wed, 21 May 2025
 07:55:33 -0700 (PDT)
Date: Wed, 21 May 2025 07:55:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682de965.a00a0220.29bc26.0290.GAE@google.com>
Subject: [syzbot] Monthly hams report (May 2025)
From: syzbot <syzbot+list0ce723fccf3cd8df852f@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4013    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 685     Yes   KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<3> 263     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 97      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

