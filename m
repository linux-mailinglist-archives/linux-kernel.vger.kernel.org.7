Return-Path: <linux-kernel+bounces-797636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E95B412C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081897003BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DB82C21DF;
	Wed,  3 Sep 2025 03:12:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472511853
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869125; cv=none; b=WXgN2RSCkSGMvOIeQYbdPRgDvXh46rtsmwImQIeo2t3ihhrMPOv5dLMEvgvyP27KC/puPw/pvjVn1wO7n8EvT6OCK7ezxhNeYAlhGqn8bHsh0+YetGdh9kxta0lZj+B97hv9MyMxJZzhJbxMSMEk42tJvsSxDiFFzLMyxd3ICuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869125; c=relaxed/simple;
	bh=gtxfPgdfCcDqfNt0Kq2nSCJXZnm3SosKEAP1U/WHuVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M7+Oy5dyOPaE8NEuBwIuvRVjDlLUscmMg3eRHJi51Ee/zuz5NYY09a7YeADiD9GPbYQuSmquW151ahhkNPOkn3hh0Ff2E/VH/pYM2GxnUe4B73NSXhkTEHmkYFhQraVcRiQHT+9yYtI9DaLgTqHeFcDN7z8/NmoZOQ4LIJhIe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88731310ba4so517304239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 20:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756869123; x=1757473923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm2aJaDhNN5sGIQhrQ224nx++sFWDSMjycRjNz9pSJc=;
        b=vnrDqVw52Bo++aXAwk8EMlIyYDhJv1mFXykD0uNqGV0eqNU+n2+sQtzFiI015WWD+H
         qHXnAWcpmaVcppR0Vr22lwgBHMFVzZ6C0+C3w9em5G8R0ZON8oaw+QsTkmisXo8nXVmx
         J/TUHh1Dxl5X2g4xkCfQwcQa8T5k/gJTQO6pmWjnjDWjSEr0O5wl50NVvaWC/m+YN5u0
         558hBogKl5vOG73oX94Jmdgb/jV1Emca2BgJEpEhVj1YYZYsT4SZ9JiVAeFg5Ixz4fcn
         DFr8wkvM/EJffYLmu953Nqt6PvKelhI+wajnsjGC5rHLo/+qFbreLC/2sgXwNqXrgcRb
         IwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJaM1owAO0Bfrv/ihY3J0WXlnA96whODtrJF7ZG76WWJ3FlAhxKLaY0YJCL45UhAbwtsbblAABb0pVQBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkYn0aZcEQzWe4uAzeAh4gaa6lqrSE7TKFp4Gxp3RIJIGZXq3
	l2/f5CLPz0F4tTcn4Id8EVUWIAD6quZ9UBTlN6qLTSdhA7Kxs2zfnnlqf8wQcTN6ViV1Xj9mXUY
	AdPvwkcd6AnJJvyeO4Wfa3NESL8A3Jy6fjfw/KWFIE8gfELlHF/Mym5/SD70=
X-Google-Smtp-Source: AGHT+IEVsrZE15aNeOVQXXUA0qrctLufM/J9xZFzOsUMcbMkY8wW6aJYnqe1onAQKO1ozPr/BKc+k6QYQGRtaf8PlHKZWwOg1l1X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1486:b0:3ef:d092:c07d with SMTP id
 e9e14a558f8ab-3f401be28abmr248105625ab.16.1756869123406; Tue, 02 Sep 2025
 20:12:03 -0700 (PDT)
Date: Tue, 02 Sep 2025 20:12:03 -0700
In-Reply-To: <20250903023326.6389-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b7b203.050a0220.3db4df.01e4.GAE@google.com>
Subject: Re: [syzbot] [block?] [mm?] INFO: rcu detected stall in wb_workfn (4)
From: syzbot <syzbot+5b4f4f81240931b16844@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in linkwatch_event

INFO: task kworker/u8:0:12 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:24856 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7115
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x81b/0x1060 kernel/locking/mutex.c:760
 linkwatch_event+0x51/0xc0 net/core/link_watch.c:303
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3236


Tested on:

commit:         e6b9dce0 Merge tag 'sound-6.17-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13236e62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=5b4f4f81240931b16844
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15af4312580000


