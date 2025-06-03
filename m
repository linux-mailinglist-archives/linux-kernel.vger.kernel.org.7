Return-Path: <linux-kernel+bounces-671692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217F9ACC4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0963A188B415
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EC522D78A;
	Tue,  3 Jun 2025 11:07:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597832C325C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948855; cv=none; b=Qem4euej0Tbm6Ime4RQPF+ErraE5Ze6IBS06OvfS4ErCiMLzXHRZP8noA3FD4WZa/t8na+PjW+RJ0Pr/0zILIlDT4L19rPbD1F9T/Bf+E7DaCAa4OtXzuUWixWSiLBR8huzWUh5b8blOb8cC/2KZwLaLbo8GUwaaaRGGLJtIP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948855; c=relaxed/simple;
	bh=4hbfj5sk/5AB04z35bRJN6lFh7ptHm1xUFlOrm/nFNc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E73f1ekRJZeD7dmGtk+qQsAWQg7nxVK4730+v7RA/dG7iPXCL9wQ5tkaJfKDi1Ko6+5hfVE/HiOAH4iswYvYtDhlGbO3MwwqZqMXRxIP2kxXm1oeYRIsdwXbjHCVStTlZsf8mcNNtSlKV3hzZImhaAEvnIQ0lRekoVOw0qikUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3dd74e0f5c7so37849425ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 04:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948853; x=1749553653;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLSrHWHbfNcA561XoJBDbzrjzmQLC4U5teo5ImQYiP0=;
        b=kK9eubxc5oLX1vhi4JIdvv+FNQ4npJlN3SK9S9Axm9nS360go6CyfwYzm5cE8sc72A
         JkH4Z46AtfMsSVDbRKBPtprWAVlj9qFqJy325wDSBJzYdRtFmzki79t9SVKE7eEAmqik
         tVomLieUkuFN1xNPO52ylJIu9WRD/vPKNnNjN1z/EMngZezxpCxVwyNW67Qndxm/OHMD
         Ds/23Xo2BEAxZFp8nulKpKXh3UEP+xUXkShdmXILuumS4YOJ9U7s99uGKKW8LbuF5TXx
         Ed4FrNA7axB/q/Y+gk/P8HqkerWaqt9sIOn8l9Ni+mxKuVrgxUlqEMPAwHwXK4V1WY+I
         b44A==
X-Forwarded-Encrypted: i=1; AJvYcCX+o75GmCCt74Md4U+LUNAv9ouB0IZ/PnP9DAUorMg6SIsNVKAy9e9CIIrxWtsBk0Pmm5vh39ng8IIbHHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSezcFvrqg+2kPpNr5QOgqygQPueNSpqW8Z9rvt6V/vFMog/Sp
	DXYn1xlBdk1T4clqM0fa+/dX3+ph5Yo4BzAZrbWhnIUAZ4My+ci21eGW2Tfv9E9dn23WODNX24I
	X8SAe+mxcOCsrErvcHR6uEQi47JA1JrK23JY/+XPKf+u63yvN7RAylzcZFKY=
X-Google-Smtp-Source: AGHT+IHtUaHEYDxtHe0U3SnICJX2cwJl+0M+OnT9H8IlulFaatAkd4pYEAgGae5VDAkYnjSlTg9TR+OlXSISbm1Am68ps6Np5uBh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e05:b0:3dc:7b3d:6a5a with SMTP id
 e9e14a558f8ab-3dd9cbeed37mr130630885ab.10.1748948853398; Tue, 03 Jun 2025
 04:07:33 -0700 (PDT)
Date: Tue, 03 Jun 2025 04:07:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ed775.a00a0220.d8eae.0066.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Jun 2025)
From: syzbot <syzbot+list5809bc83320af48e7eee@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 7 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 271     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<2> 140     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<3> 3       Yes   KASAN: slab-use-after-free Write in recv_work (2)
                  https://syzkaller.appspot.com/bug?extid=48240bab47e705c53126

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

