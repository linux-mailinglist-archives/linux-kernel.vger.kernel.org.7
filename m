Return-Path: <linux-kernel+bounces-714802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 059CAAF6C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58683BC814
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 08:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88B2D0C85;
	Thu,  3 Jul 2025 08:17:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ACC2BDC08
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530647; cv=none; b=dz2y2qxj0dYUZS4Ki46egNIYWS38ldBxy2yD3+58UyH+3J76KMvlJ6YyERVftxAjxa9Ht44ehSbPiy/d8bVywXh9+NoCKPwB8U+2uJBklsZYWgNYxlb7yAUJzW6qhGF2VE5oiRC95dGYuRMWCOv+mHioAw6NHMa2d/+Dpgy8W24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530647; c=relaxed/simple;
	bh=J4AFSvgzTK4Mra/Rv6b9gZTK4Zq7nBJ7Dt9Sg9YzQ+I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XpGvvY+v1PCAlcpOxTUpUEpNfJh2E5l0xt452dkddcchGb+Gdhj9DWOFR+7fFslAKE7BH/o5rXqL2An8PUMxRnNVsNg5wTXLoNQACe/wM0A6FTKk5oCwgfM6u4oDJRSctM9AWHOGe3JXlkFXTmTjBmoRcaT65A7h5uSD07hQMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87595d00ca0so759695339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jul 2025 01:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530645; x=1752135445;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZ8l2fWEOizcSPsbXsRQAKJ6s0J1KI5GlXIwR8qauZ8=;
        b=U78m8zIGJOqD2Hh3GbDKEie68dETaciY/pOtMomafCOPddShaiZUCrTswgA5p8xOys
         35jpyTFBiJlg2euP2svF1+ix1yC1CFGH7s6H+MdsBUfPJDUHc2YiZ33q2Qha7UUUXLaT
         /CEx3NJH1LvrXqZZTqPxLLiXBVhLWWRNB0GzoMZqslo8WKhRCsv5SlhHTImJXkflyLdy
         oqIk6s8kTC6EtXIdPtiMw42Iz+4ssUAl9Am/W+VUdBk4QE7N/C3DLpbcFQQSXhl/A5uq
         5PtxYFvstInynaXE1pcZHnK87QMKzeFb/4okFGutVpqApGpVxiiHhzAceQB8rxBrM6WJ
         60LQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5MtTWnbmOgRabcdpRl6pTWHUxYGJ1p6fsFz0HRgMwluK+uqfLJlITWcusCdHLXqvjht3Z9FAI9JDNteA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytxubCADTTW8spYYTgojKqJhBs28bkFfHeqY6aIbx2Up1r0xH
	Sc68GKKzluiUVP4HLHMKjQMaVsFUSdU0TxRLiEmSnhkou1QOupBWDTIhKPT9TQwPLHlFtnTdJa5
	IcrQ4t+wMAGDkRgeZOOOtp4XtywVOnDSg/xsx8kDJhbeXs0ZhjIbCDxGwmZI=
X-Google-Smtp-Source: AGHT+IHHXknABbqRXAynmCSbU37Zc4ri+45qAD660LeDcAX7dgb7lhTkzZB8H88tI3yHe9XKa5pgYJNONcD3Trloarb4x7Bixn6R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:970c:0:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-876c6a8df52mr687943039f.14.1751530644696; Thu, 03 Jul 2025
 01:17:24 -0700 (PDT)
Date: Thu, 03 Jul 2025 01:17:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68663c94.a70a0220.5d25f.0859.GAE@google.com>
Subject: [syzbot] Monthly io-uring report (Jul 2025)
From: syzbot <syzbot+list0205f720a3ad026252db@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello io-uring maintainers/developers,

This is a 31-day syzbot report for the io-uring subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/io-uring

During the period, 1 new issues were detected and 2 were fixed.
In total, 3 issues are still open and 123 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1345    No    WARNING in io_ring_exit_work (2)
                  https://syzkaller.appspot.com/bug?extid=557a278955ff3a4d3938
<2> 3       Yes   INFO: task hung in vfs_coredump
                  https://syzkaller.appspot.com/bug?extid=c29db0c6705a06cb65f2
<3> 2       No    WARNING in io_req_task_complete
                  https://syzkaller.appspot.com/bug?extid=7039663f7490865be042

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

