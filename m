Return-Path: <linux-kernel+bounces-814769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB97B5586E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD511C86321
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7159E273D6D;
	Fri, 12 Sep 2025 21:33:40 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855A92BAF4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757712820; cv=none; b=qbPgs1DMNKn+qe0qgskrO4QiEAUkoHRVJckdQB/C6u9T3eCuKL8y8jaXg1gud9FakVlIxop7ksOPtjwUSMipjN36O3x6qrmAVkjnv+sEcTqr14tdxPApYrhvkp4O9fBGAzFl0+fAsVHyL5CRnzpOPYY2xZWSSKJ/tB6zhLqmCMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757712820; c=relaxed/simple;
	bh=gcdA79jjgnz60CIEeHOHbDEu314Bxj0wQZ0X2/ezgFU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uCo3bVrWNGWRZYBE7X5rYuHT5SzeU6daQ+OyCMuiGym3CNmYY3pKgxshQTRkmhv2X/dTZuZZwzOE95agpA4gP9TUYLYfNJCo/OUjFEmsUZvbrUWijy1mJMEWC3SajTOvxAJPhjl9p24hzO5zUapx+RJx0THjX+yD9bUakWDHSLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88c34279992so245608139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:33:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757712817; x=1758317617;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8a0ZRJbbCExrO1+qyDpP5M5QUSdrfps3t/spMWOAQuM=;
        b=L/XPI83RM1/KSMnKNXU3wqN9rgy2VNm73FKYvinDKfwfKzW0IEji12epSc2WS4a+8T
         9wDFa+bbZSncrHVA8MVsymcNNuN/bxi2EqTIEAjJmmqH2oEqMXIfMlEksmGdbM78f67a
         fPVNxsMCKOS5rIUleSy8y3SiXZ3XWDaP6di2TY4nNK6crO+ZdvNHDAYmhAL0kIoBdVUG
         WPJUWrjE//W1mrTF1jBHkGrrDvpnyVpQPOjOInoRDDzhDj2nvjNIYcNwr5ta/Nm7dVFy
         s8lFrAJM5fWbCpDbGup0rh2ZRDFVUu2e934JgtLMYQAUcxezB6a3LLjHouXRp3wFd5qZ
         t1rA==
X-Forwarded-Encrypted: i=1; AJvYcCUamrisH3mkw1iJa5h9nlP8xxG/WolRuIUBZNAvtDR2FYTlrjtre3OpRtUoFZfAuXJvM0DtHkLxdXNl664=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFCy5yaOg8r/8VzQV1fcnCJWGVlrpF6uxhsE3IoFOOsmxrBZ0
	9qS5c8Xt2hhs1EfEa7ZTcZTFd9E5zmCw1OPM8SYZS7dOpobDcQHnf8N3yIXR0S95Uw9M0sKNOnA
	qwJhi8NCbDl1wLsM/rZHAznRrkt8dc3IB41GIx6sRSzKDBedjx1VFaQtvoZY=
X-Google-Smtp-Source: AGHT+IH1KcDF6ZOKvqgaH5XswldPsIA0D47Hmd0oos+XqJuwnvUqwtk3Tw5W+uczmfeNMRinLndwFkjK372rzN7fzqIQIgDQAs57
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:3f6:5e42:9ec3 with SMTP id
 e9e14a558f8ab-4209ecfd129mr75530145ab.11.1757712816787; Fri, 12 Sep 2025
 14:33:36 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:33:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c491b0.050a0220.2ff435.0365.GAE@google.com>
Subject: [syzbot] Monthly perf report (Sep 2025)
From: syzbot <syzbot+list5953edbdf82f0fc894ae@syzkaller.appspotmail.com>
To: acme@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello perf maintainers/developers,

This is a 31-day syzbot report for the perf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/perf

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 8006    Yes   WARNING: suspicious RCU usage in get_callchain_entry
                  https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
<2> 57      Yes   WARNING in __perf_event_overflow (2)
                  https://syzkaller.appspot.com/bug?extid=2524754f17993441bf66
<3> 4       No    KASAN: slab-use-after-free Read in __task_pid_nr_ns
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

