Return-Path: <linux-kernel+bounces-689577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94148ADC3C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 09:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537FF3B82BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C463208;
	Tue, 17 Jun 2025 07:53:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29A28ECC0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146804; cv=none; b=oGrzym6jHYF8Y5uIB1uGsswjcvqzHvFBVLDgDpbdnDzETdy2gafmYss5Tt4qi3JnPhhOVuX1aHcp5Q9LRX48CwLN46wc9Bm2g1gGIsOX00R/4gcygsU8qIhiZ/AJhY2qa/UL8JhCjLZd+7I9ocM3cdNuX06myO4PTKoNEL9+d6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146804; c=relaxed/simple;
	bh=rEr+5N/mTMWE4Y3jEsGYmoyWb3myE5IMlly4FRJ2MGw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mpU6+Fgl+7yYUw81HCrDH7wSx62aU2CPVIZ30g76zH+UbC9OPYny+ms8WRTLlYv6RdCT4Kp0DvmxHdK/pwdeksTMxfaNHMk/Uhdwx8v5W5Dbtn4kRwzn0nl4GAVAGKgTq+/2Og1NKJIwB9HzQ9IkoHoH6BCQq4bZ8OWk0WjSuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddb4dcebfaso131506005ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750146802; x=1750751602;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2+rGIVSS+A+aClXDZH5sduqubbo8vIVGKtWBDyBvzA=;
        b=UdTz14xmHWzH5hiCryGxnQHbSIlBj93iCImxbAIYmyC+hkAYmlR4ttRxmQOIggjObi
         DdXGSUnN1G0L5Ihho1U13xLvKxLFpVJdCIlyMKlKD2DrUC3AzldR3/ujyGfi9o+L5kHA
         Hp3+8GP5jTtzuN4ZIC/QDZUFO8wqWRd+eOuDQCpudDqwKEcKzQwyP0TV3rLKATwUqHo7
         Pl+nZ45/3Nb8yzSVHpWEr8m17p3bn9EmqDsswGlYcRPW5UaHcMqXJLZMMu4n9dQRsdcI
         covtNWyckoivfDLp/DXMCmyGzTSBzN6R4Qn/iAnsTP9kGDoDOnRyvrHpHzHQiifzi8Cz
         27ow==
X-Gm-Message-State: AOJu0YxYpnGa7S3IwhXCCfzGYGbWrVtsdeO6JiH3gZAWrFn4NpWMGV3v
	PHTvnzUz4zBcHtB2tI1XHu5rthe2Y64yviY1j3V4z4LmOBAlkCnD10j7GKqV4FIJXL9Og3xBPjc
	Qex/r5Abv8FYHZcTfVr0XGQYoTRYK5RWr3WXOFAuGh2E8IVvOJddBqzmculA=
X-Google-Smtp-Source: AGHT+IFHa8CSHcQSVOjgppdoJiutDcaXPPigLSse3J4TM/L/kvmHIMK5NY3KRlUcwlN3rH+SCnEUilvr9ZfwCPs/3Z4UxWV+qZJw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:3dd:f813:64c5 with SMTP id
 e9e14a558f8ab-3de07cd451emr150549135ab.22.1750146802058; Tue, 17 Jun 2025
 00:53:22 -0700 (PDT)
Date: Tue, 17 Jun 2025 00:53:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68511ef2.050a0220.2608ac.0010.GAE@google.com>
Subject: [syzbot] Monthly pm report (Jun 2025)
From: syzbot <syzbot+liste1df6065339a4cbd4e74@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2086    Yes   possible deadlock in console_lock_spinning_enable (5)
                  https://syzkaller.appspot.com/bug?extid=622acb507894a48b2ce9
<2> 810     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<3> 2       Yes   possible deadlock in dpm_for_each_dev
                  https://syzkaller.appspot.com/bug?extid=2a03726f1d4eff48b278

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

