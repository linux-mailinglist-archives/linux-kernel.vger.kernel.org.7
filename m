Return-Path: <linux-kernel+bounces-759837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E7B1E388
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40749584A49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5D2749CA;
	Fri,  8 Aug 2025 07:28:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F7224AF9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638108; cv=none; b=XPK3MC41zfxAyFv7u5ltFAxDmT/xg4x3lDeMUQJaO7DSKywoTSl3XerRvByzSeRGSE/W+ZqQbJqZQvSTupm7awXSreA1Gb0J9w65n6XgfDp5utUD1WA2QWS3UisJVGhzD2W6SCaQfHwmr6b5MW7r7yiWhHKC0PSlDytLi343zjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638108; c=relaxed/simple;
	bh=WN1V6yRyJ3onv3rvnAMeyzF2zAArTPYEpwhlnOArAmM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WNfGdFygMuDRKvUkCGGV2/rxS/iMKNcVDpxOTQn7pH9TbcGiNuSBNJ9sj83OD6FSPdqkmXCNzpEe/rLbJs4HxvnzJJ8k56jIctGeScRo0ykpsO0+VqkaGFizIaU3k0AEs/HTQ9u2sewJ1uz5bfGn+Ex9gBqzWx0P64BX9Z5y6Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-881776a2c22so403263339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 00:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754638106; x=1755242906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/a35FeMXcLyPHOaDsyqFQMi+gYIhEq1it06M3z49ms=;
        b=gTFDuKvDBeE/+4d+zVHqMM4FCiuZvqmaTXktxPn4+24MEenftkteSAKDEoatabygNV
         F/YLxS9wKyKNVyZdozIlsS9ToRxrGvA5axOugRrUwXt2HfEk2U3Rd1IoRX5Kfk2yIJ4d
         2VGVHRnlzt6hclL3rWSZWehuj0C1le0lQG+c9FfbNeNzWaox2FZ9neZvWEK7aEgTulIr
         7uA93K5d9Tj/rKSsvR3ESe6iLYKXzA12HCTlhrZo777qoWdwC4TsjgCXe4aR2bRoLz6l
         I8pL1++lYs6wxiTWuMHLaymRBEPZtkNG7h5RHsxxQJL1uP22tDcftVUkqeBz8mjyzlyn
         Dy7w==
X-Forwarded-Encrypted: i=1; AJvYcCX/pcRUcvkGJedlO7JdYSzouMuEDZ+Spxtpz9NYOMwLG2c1b8zwFowc3MMr9++pmY6eHyViXKFH4SdhPGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpy7L9tQt+3F+8uoBTlweyPIm7a4Z4as6acCb/eWwmRWIzqFS
	lgsRnqu8+v62HzDiXxWdrtNFgesvVphE8wrZPyuH8yjM4k2p3MOl10mwAI86BMgyS1rLkeMqgc9
	ag7G75dsz9Q5AXtEHWizwVhELgd3vaXjSh8n3EF/NdBubiFfH6u03RK0PosI=
X-Google-Smtp-Source: AGHT+IEp8c7QV3AN+fKWmFyPuh00UU3Ig82a4VQ9v8HNUDVelYcjEJjN1v5lCDAGIwJaemzQJj7Ran6EEVeqkf75mh7u3cxneHfN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:84c2:0:b0:881:7e3a:4a37 with SMTP id
 ca18e2360f4ac-883f11e38bdmr309075639f.6.1754638106549; Fri, 08 Aug 2025
 00:28:26 -0700 (PDT)
Date: Fri, 08 Aug 2025 00:28:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6895a71a.050a0220.7f033.0056.GAE@google.com>
Subject: [syzbot] Monthly perf report (Aug 2025)
From: syzbot <syzbot+list72eae33f52f6a337d370@syzkaller.appspotmail.com>
To: acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello perf maintainers/developers,

This is a 31-day syzbot report for the perf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/perf

During the period, 1 new issues were detected and 1 were fixed.
In total, 3 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 7542    Yes   WARNING: suspicious RCU usage in get_callchain_entry
                  https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
<2> 43      Yes   WARNING in __perf_event_overflow (2)
                  https://syzkaller.appspot.com/bug?extid=2524754f17993441bf66
<3> 2       No    KASAN: slab-use-after-free Read in __task_pid_nr_ns
                  https://syzkaller.appspot.com/bug?extid=e0378d4f4fe57aa2bdd0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

