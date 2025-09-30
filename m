Return-Path: <linux-kernel+bounces-837305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70661BABEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D621893420
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1662D7DDF;
	Tue, 30 Sep 2025 07:56:39 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781C22172D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218998; cv=none; b=MNYgkfFwsPYWsSJJoaTSppludj0bH/XzPa1IG5gFCFRT9kUgEzBUxair+L4IsrZrSE5i+HkQkLcsSGuZ4M+/Mh7dWQHJ+4XfG5vJ/xggjRGi7XGLH34OKixwiBvNx2THIwPx+pWb1FH1RfyA14XsGSIidetPBnOyZTTC9zhlPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218998; c=relaxed/simple;
	bh=Uv75VHzwzodN/iFg2QyyTKYBfqgugtw4uy9y1OMCQRU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WUfmmXX1+/8uMm2rEDlCA1krcbE74/el3Ey4UPa6ZGo5G2+VUYtvCcaS/R7qVobDVyxg44n6/WRBevfiQNNVnLWMM189Ck64hl5F3YfdaNqoiUQ66E6b63B2fGN5UZqg+E+rV5T5qgW8ChQjGKnUUY8LDVu0aPWtxWWTHGMuQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-90e469a7f6bso471160839f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218996; x=1759823796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbNYsaEk58vNzaUVYv+66XCe3nNgMD1F6rNfOCmPIOw=;
        b=R9hi1B3+dYWa39OX/WNOKM1I4QpxGVmfb88BZdFPPT9V65hpe5rlDAssGHoR85GpR2
         kWFRlpGl3wZA6CAlrzIXqaU3/SGfRBFqlGniWZPO8j7JAGvK4LDTsAjt3J058reoLDJm
         By2GGH+GeOxuHR1R42RD7JZ7dZGFgBeLYRoEdxtUSiajKQvvATtGaHQIpVf5qX87nHHq
         dHza/ZLiRqr/QUtrWZpJ/PjebmN9vAiA5Sg/LFQdKh7LE/GmOOhNzJ2Wz3wcNBfRjM4R
         ab2xChSYVGUA+kPes19jhvaOxcdrKPuSqM1PZCSnN+nDinpIMM4bU+cpCIW4NpoSBL2t
         HzhA==
X-Forwarded-Encrypted: i=1; AJvYcCX74UvMrXFXOTv2uXJ9Crfr8ZO8p5L9/XbCL5Frqt6sIZ+pUG8/iWK7jNt6P/VpmTBOWlub7+7LhLidw34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76/UJJL+PrQUSK3pMasrQ0INazddSGRUsM2EhCrpSsA6JfplX
	YInuEwMPsNphUQMxap/lEdNplZiBH6atj3SEMluhqrR2eoIUJ8PLljVadRYgNP+YS2bFeqH/TTI
	jNLzxjNJVHXtRgKjW3o+2PvrVYVxXApP0G2otsib16OHG44mLKXEd10li8gU=
X-Google-Smtp-Source: AGHT+IGsuontnO7CZFIc60QbGnMZ6HvvL5aTlAE/tmbnY9fG+eDHbgg8Y+vxPaW6+01fJXiGOjyYjk313njPTeqSPLze7IevnF6I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8e:b0:92e:298e:eeac with SMTP id
 ca18e2360f4ac-92e298ef01bmr663554239f.2.1759218996480; Tue, 30 Sep 2025
 00:56:36 -0700 (PDT)
Date: Tue, 30 Sep 2025 00:56:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db8d34.a70a0220.10c4b.011f.GAE@google.com>
Subject: [syzbot] Monthly fs report (Sep 2025)
From: syzbot <syzbot+list350c6536db9fa6ce459e@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 4 new issues were detected and 1 were fixed.
In total, 58 issues are still open and 395 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6883    Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<2>  6287    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<3>  4544    Yes   INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<4>  3991    Yes   BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (4)
                   https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
<5>  3207    Yes   INFO: task hung in __iterate_supers
                   https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<6>  2287    Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<7>  1886    Yes   INFO: task hung in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<8>  1292    Yes   KASAN: use-after-free Read in hpfs_get_ea
                   https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
<9>  1066    Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<10> 931     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

