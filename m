Return-Path: <linux-kernel+bounces-832832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A518BA084B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6244E38516A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2672E6CD7;
	Thu, 25 Sep 2025 16:00:33 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5171E1C6A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816032; cv=none; b=P6PfAechba1S+iAyYUVqTJgo+3yRoAbOWkTz4aJD1QIIHyWYxtTuXII3jBEOsF5GGyJvF6JhL1VQB/YwHRTCNfbmlWuSBfmPhJV0J3ow7hLh32yrBhThzUR6/bQhKT3q29p1Lh7IBAwx3l+oLcBDwby/bp+gEPk7H4aROsng0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816032; c=relaxed/simple;
	bh=EXar3tsH9qglxBsbMt03/JUy7kyy2abd7kI+GYStds0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UjrRMPPJrDDx01A4cG/bvYJhyfj4CgFYsZMYD46R/mF+aXFlsvYYadv4oJ8UrsvhmlGktUfGNw2wdO+ADM64orqbuz5puZcIKibtUQk5TCW7kZ6qoGet/oANemisYKPgN3zikzNTaH2JDVhPHs9knIA3pCD2rHRSxh6K4NFw2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8f7ba409518so122111339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816030; x=1759420830;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DW0ZfQWXFZl9N34BnL9g/30uZshCzQQ+bop28aLFdZg=;
        b=g84/7NGCnU4ac4DqsUN/Q+yuosvMY9rda0kUps8HGYPqgmXgIIPlf4ncvHal9A3KJt
         X2oeaudCFwdrR45W4Cy0YjjtYxsV5KPuDPeVsUt/R1hjL1e8uS5KCcIysHl3ve+1ZWnO
         CCC0XtdkOH14vs3Xd+QB1/a3yvUU8i8Ig13BJBPBasmk8NOMAvcvEqskYeVK8moirpnk
         SCYZTsVkDnrW7c7pXjmCt+PCI3qyjBgTmgF9yKDKmQWT3GUoze+vk0d85gINk64Ejq6x
         DaAAto0WCnWpAFBVXeCXerqKvn3iVMeP6Pj1JHZ9yMtMb+OR4HJ8k+l6l4cIDdcfHD/H
         N/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGSsr8ZLam1emaE4qyWMrkkyEH7OYU+wph3shNBACmejjNkhmK6/hl3lZVGtG1UlaVlTGRC6Tmdju26JY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjG9j30oI+rlk7IpANl164HsqMlgQ608TP9rrS8jqq7typGBN
	oiIQgDrqpVJDv/5vL2vcfGXY3MFdJqxKCtUmZkSQNCgWjqkQxuYwvtN3cZy+bgiUzHwWlb7qKMg
	nhRxytY7ne4QqmawLLxIbG2OdYC6qDScpsgz8Vgs2hQo/A2DGADIdEY8DiSQ=
X-Google-Smtp-Source: AGHT+IFC8z6HOm6DG+LNPriR8vrkj8jtgYvRRUrXz5wgb/fIEjeWSaheh3c9Q12s5nb1yHzcIx8tg180dPqfIJJYmrauDWDSlguQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:426:3ab1:74b2 with SMTP id
 e9e14a558f8ab-4263ab17a64mr23743365ab.16.1758816026819; Thu, 25 Sep 2025
 09:00:26 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:00:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5671a.050a0220.25d7ab.0040.GAE@google.com>
Subject: [syzbot] Monthly dri report (Sep 2025)
From: syzbot <syzbot+list9e8e9593a6e965c829c3@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 33 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2100    Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 502     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 192     Yes   WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<4> 41      Yes   possible deadlock in drm_vblank_disable_and_save
                  https://syzkaller.appspot.com/bug?extid=e0930cb581675ca1c2e5
<5> 40      Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                  https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

