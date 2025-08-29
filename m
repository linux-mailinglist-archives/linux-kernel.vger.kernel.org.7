Return-Path: <linux-kernel+bounces-791769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C6B3BBC0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6CA586E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EA31B13E;
	Fri, 29 Aug 2025 12:52:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A031A567
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471955; cv=none; b=UdTlJsAmSWE0LDUvA2sSdfZBGCIjwx6dC9xvRCNBFKPRbGptwxhNnn672PUPmjkmY2kJiooUFNngpxkaZEypl3mKN6qFtOsh6yQmPpwuvuqvZY9dBhSJBdOm8CKwg2PL42ufFbskZEpplO0Rq1oAQPcZ/kHm3wmJqXlauC7aATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471955; c=relaxed/simple;
	bh=ChLDMYd8I6RvXfv4qQe6LeFgz/k1Ll9oE0U+zZLcdeI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W/Q1RccUj8WGZ1+VI0vJNZrrxBa5afsp95Y6kTuL/qN/77fa9PPMA4W+17uSta3tT4skdJlr1XaCReKfpdRl//kdbns0hs7Dhw5V0R8YGlJTQAmr8FCA6uhQJeKWzvuom92xHLoN7PPJiGCMxOFp6p479pIRTK7vVjmtyX6OW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ecc8a40bd1so43894585ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471952; x=1757076752;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfU/0K8pQvwEdT3I5rhhTpdmGSF2QbNrRcAEp+fUBHg=;
        b=w781dHkgiSdr7tJity6GcDvGrlGB1H5eOPQmo7hbsYLCAXlObDEW3WbGj39DSSUQcg
         bUYiG7Fb/xVVSBawHIouLhy+sE8xDvAkjTsMkb+GiDLh70wrekFHWN6EC8MOoQK9E5DG
         lHVUh2uCaUZXTURujDd4KC6abLs56psHiyOdnggTV4CC4jnvyeb29EJ5YSKSP3g8EjZc
         TEV/dwOSCYGKiJAK+Tscaaz1yfji95+Da9MLfmUP1Nslt08/lQTzzUXZN+upYbldX/bI
         T5OdQv4fxfThJQoBI3qlQhi1bZGgJzDzRQWgZnxPoZB/rRuvSjTU3GpvsJxsrlwFucs9
         jWKQ==
X-Gm-Message-State: AOJu0YwHOBAZ/ndfPU6FQXcgc0fkhhOPQheM8ctJO2hIAdjrVrVg+Nsz
	ApY41D1p/ooWr6Frfmq6KWThBchGDIKrAvCeLlidW+4EjEiooh+gBr0zIKH0tfIF4dHRfYKMamQ
	1Sd8z44PPnZeAsEnXT4i9Vz+dLpkL8kO3bhDDTlaR77oRvtKrtucDrsVTPgI=
X-Google-Smtp-Source: AGHT+IHkgF68Yby/4sZauw7uKfE0TzTS7E/PYU6VSI1aPexQjoNIDrFVvHKyWba1dxFU7n2HGV7bmmlJQ+V3v51a/VSmwCavkjGx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3eb:2b11:441d with SMTP id
 e9e14a558f8ab-3eb2b1146bdmr343136795ab.15.1756471952202; Fri, 29 Aug 2025
 05:52:32 -0700 (PDT)
Date: Fri, 29 Aug 2025 05:52:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b1a290.a00a0220.1337b0.001a.GAE@google.com>
Subject: [syzbot] Monthly netfs report (Aug 2025)
From: syzbot <syzbot+listd0d99a8934bd992abc4c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello netfs maintainers/developers,

This is a 31-day syzbot report for the netfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/netfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 5 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 70      Yes   INFO: task hung in netfs_retry_writes
                  https://syzkaller.appspot.com/bug?extid=666a9cb4c41986207cdf
<2> 13      Yes   INFO: task hung in anon_pipe_write
                  https://syzkaller.appspot.com/bug?extid=ef2c1c404cbcbcc66453
<3> 10      Yes   INFO: task hung in pipe_write (6)
                  https://syzkaller.appspot.com/bug?extid=5984e31a805252b3b40a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

