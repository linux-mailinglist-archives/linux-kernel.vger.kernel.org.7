Return-Path: <linux-kernel+bounces-875646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331EC19841
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8B5C4FE100
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1493254A7;
	Wed, 29 Oct 2025 09:50:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363242DE703
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731426; cv=none; b=pFGXZaIMANlZJ1QBXgmTSUegKqUlSPAD0W7HzqarcdcqyhrK1fG4dfsdzyq+NMlIsTyphxY6Utc3sxTYwZN/YnYPOy2gwQHfnTov47uHO8CIRb3rjbu0n2s7cga3cuv5D4ZjHNbqsBymB329WDSnCHsBWWJ8uRKjChzouvAhhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731426; c=relaxed/simple;
	bh=i2274T3EiOfn6UpUQwtwrYisfXS3VSVxRaByoKyNgIs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YzigVIhqKQGXu6dkvqf0O7FSmoUKewb04+OXxGMt9J3L0QsjdRfInw3pdZkjCJHGU2w5UOk3AtieoAkZySDmLixeyNwI6msIOEA1M6HlRUVA9QY8BAsfiCmA+cseMlXOgHGcL+LQh16oR7uQH6jLRBQuB91EJ+SEPx8t8ZLroQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c9176acaso11597585ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761731424; x=1762336224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jwoSeUsY61j27pfA6Y+vP/gnRCBaC7z+pC1Hkeo8ai8=;
        b=q4wBnuKcMeCeBFpJtzLsgk2/KPNgv10sLWu9X+mRBOtf7Kx5KNOxLSDPu6E8+//0HO
         9EaVZm6pkD8cQCnvsacaElskYFu9ZWNXdg5may2CovbeOPsXunSiFZD1fZ14ch6U5TnB
         Mf+3uX96Z7Y1NeTq3ehozlT+zsrNC1Hx0BXTvUXvE9xYZce+R2IyYSbVa5SRxuG0NIz5
         42cdyu9W1BKwZtBWUMk1O2H0+/+KEwFqA2BQLjRb55IVtRoCkkApmFxEpM7IByGrROsk
         kD0mdEU9QWPLWnBKeHtIYK6ZktTz9ji8i0f2OXW29akOySNTQNTxCYIUs7vl+qTRpl48
         6wCw==
X-Forwarded-Encrypted: i=1; AJvYcCXdIyZWmO3hus24GDKBTyeKFF2qm4biUrRChXWGrnD2vL1c2ha9nfWNW1Oy3p80MydvjhyWPpSljIMMnEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAdhiuJbYrKObi3uAq7oZ7ngOOq2LacvNgqw8D9QPK4fiMiWL
	uH0TqUkUk9HPytrX2csbbx5+vtxWSMxUy4SVz84LqWf2hBTfmZeAA8k97G++P3nkAFsMWWPb/HY
	Z7UvvtK8jjV6aK+0q/NiW1/y3KgpoA8dISEK3+Vi2Hl03VLx1mOmONJZo06Q=
X-Google-Smtp-Source: AGHT+IHJEEjGrzy7XELdwqGJKXko10bukKrbj4WBmWxVYWNBo9BpdJfqRZwCRKvltDZssxx6wGHty7y/021k4/UQzoib3H51RPcA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9:b0:430:cafc:df6a with SMTP id
 e9e14a558f8ab-43210445659mr75948155ab.15.1761731424228; Wed, 29 Oct 2025
 02:50:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e360.050a0220.32483.0207.GAE@google.com>
Subject: [syzbot] Monthly fuse report (Oct 2025)
From: syzbot <syzbot+listcb1b5ea4746c3aafb761@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fuse maintainers/developers,

This is a 31-day syzbot report for the fuse subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fuse

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2470    Yes   possible deadlock in __folio_end_writeback
                  https://syzkaller.appspot.com/bug?extid=27727256237e6bdd3649
<2> 488     Yes   INFO: task hung in __fuse_simple_request
                  https://syzkaller.appspot.com/bug?extid=0dbb0d6fda088e78a4d8
<3> 47      Yes   INFO: task hung in fuse_lookup (3)
                  https://syzkaller.appspot.com/bug?extid=b64df836ad08c8e31a47

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

