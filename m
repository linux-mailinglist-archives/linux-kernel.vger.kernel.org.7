Return-Path: <linux-kernel+bounces-799470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEEAB42C39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094A1546EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC2E2EDD5B;
	Wed,  3 Sep 2025 21:54:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553D2EDD4C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936473; cv=none; b=I5qSHeftraTxz7U3jijTCF4uJjweWi25XEAsIgXtSWjQgkmV/cROr7I0jktpeGGMRI5/IFp6bXz7CV99CqbC26/yq6vTEvAtyxFEMrTULW4pis29/mTO2b2f90cZyQ6iFP51Q+iXdCj3LTvdEpRn7iNPoSw+4vjLhjGoJw693YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936473; c=relaxed/simple;
	bh=G4mYCXoN4yRBxspHAQL769uJxZrsIjBLXNwvtiJGyI8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C5AoOLM7+1lKVqwcjfRSjfHsTXe5vARn9oblDRvb8MsAMpGXOIrQQSoJQTXPi9pICMKFNkrhJPE6Vjm5c2KOdwNMsuabloP9oRwSL/t9F1jkVDtVsyPrKXbDIBPjnXQd/Wgc7GHEBjZ07ADPIMoKRW3YRAmDzBQCkeGi+kFbmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ecc8a40bd1so5427895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756936471; x=1757541271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2O74hPI1AmCEb/MNAKEFM55bhmEH5GlfBH15kqp2jTI=;
        b=Hxb1fCsNaAazu4SNdY7aCjvz8ocH9SxZ+QlIAv95wjsOr+Pq9kjOwBKsWRXQLDB/X6
         AJPN1086thNrbQLc+o/vBRdOeOHfXfsi/yGJlYFoZHkV4CCW8lKAnrZQRTm0qtO38b8U
         n8h4isjVXOBMAIZqSkgK7J4uWJ6+OCAd0eOmshv1RvsQAG+DzjUTXx0R9PhQggBXpux+
         gDxOEmItHU3pWJ9QeHQfBW/YDecBJCl8TkaO3I568fJpBYmRs7VQRXmqfyZE+PkVPZDB
         9h1ITzum+VB4X+CloJ6rQ7gGjQvixMr7Ik8NpwDVROFbW2DxnwHR0I558zcVdTLX+PSk
         ovAQ==
X-Gm-Message-State: AOJu0YwjQgp+9qQSEw+dZTs2t18NBMTKRGraqSaZmdCXINzISkVgb4RP
	kdN/DggmMp8wOZknhCM6TpeNne8wmp+XsXGbK1ymmnBgMF4sVm/YK2l19zZBWW5ndklXxXxutTO
	waQt3GjIJ+HUYTMnXIgY9IWsAoQtH4K+NRm/PDKR/tglzO+G9wPrZoBvYMyQ=
X-Google-Smtp-Source: AGHT+IGQ8GGe2aGNCS5FqoX3dQ8cs8QfO01N2mWEh4tvTIeUDa/c+oQzCz8n+Yhf3P8i8J3Kk9jlVMkptUoPJUd0UTZ+1fj8yVll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17ca:b0:3ee:f256:ad0f with SMTP id
 e9e14a558f8ab-3f40028a817mr292023965ab.9.1756936470782; Wed, 03 Sep 2025
 14:54:30 -0700 (PDT)
Date: Wed, 03 Sep 2025 14:54:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b8b916.050a0220.3db4df.0205.GAE@google.com>
Subject: [syzbot] Monthly pm report (Sep 2025)
From: syzbot <syzbot+list1e6f2776186824071470@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello pm maintainers/developers,

This is a 31-day syzbot report for the pm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/pm

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 10 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 920     Yes   WARNING in enable_work
                  https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<2> 8       Yes   possible deadlock in rpm_suspend
                  https://syzkaller.appspot.com/bug?extid=361e2c54f7f4bf035391
<3> 7       Yes   possible deadlock in dpm_for_each_dev
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

