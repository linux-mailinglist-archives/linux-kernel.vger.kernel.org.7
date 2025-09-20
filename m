Return-Path: <linux-kernel+bounces-825498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE1B8BF78
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 07:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E84B586A9F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3EB22069E;
	Sat, 20 Sep 2025 05:04:24 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512344A21
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758344663; cv=none; b=qiWmAnGPuKsb/4L/0PnUItgsTPBs1OWweespS2XPcmI2iMWhx9iQDDVPAAyfCGpXpFP0AjXrwAbSHcMJ51247ItVIJCwcal9cT9PbUND/2R5fdm862AhlYvtHeHLck83ZpTBTzZ7B21nIhLbsUpWptbxFTNjsx5pUpMNfj1h1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758344663; c=relaxed/simple;
	bh=hZTJRt1Nlc55C/plBNX96dXZSDZddDFBRNaQ5sGj6sA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d2tok07Ke3OKfWdguTF8vlCKlktayjDUV3T1mS9R6NPQWPsm5Qhh030kbKXsdYWLQ/Lyx92h4mWxyP7RWSeX9ZNoTQ7L5keqDSvXBe0fhPRFhst5Y1p9brh4qLItIWWWYe+fpT5i8FB9PF54EaXVqqIat2gPHfVJ/JUTnDw1GaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88de776aab6so215917539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758344661; x=1758949461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m++5cuBJbMnEx4hmF52JH+NdHgmgjtZrhgbDgT4ZFlk=;
        b=ZK7ioq4u/IAlWPh0AW5JftZHrTQKgx1ew00o471v2HQu9SPybNFI61igWv0c9u5Wg7
         kp/y3CLCLDrl6MzP1hwDFSy+lYh+u0tFe+kVWatvIXCeSt+BCYsKDt7thZb5VRdoLOqb
         4KILjtBEKp8rvtvVbo46NPwpfP8QyzION7d5GaVpOiNt0C2d3ANcIjcMlx6qquZ407P1
         3T/Wh2l+B0Sot7O/K7SG/6byLibgeK2F4WJZYhvG37xCa7o7OOFu5rud6dAJBlWYyulm
         4IVp2kMEf2+6gLG+Zqv7nOsIncUh9rC9VILzTuikxD9WMAXiQgJdjKLMOovaclwVkhIv
         nJtw==
X-Gm-Message-State: AOJu0YyeSqyGFEykqDABjTSl/S9EJw5bHLCC5TI/S+Cv1EEEkfw77zQJ
	7G1N0YaFinaS26lakh/Lz4Q6OeOAXjVVB6QSEJzz4dY4wbXZpgYMcJs+7MLHsGuUXZ32pdhIY8v
	X/tDMcnU3Vr0UOrbW5VcusIvU+BUvYqutYrptbOEwGsMIxXXt0BYWavFZOWQ=
X-Google-Smtp-Source: AGHT+IF6GhCP7BSxxEkTutECu+aACaBv5lvocY3TyNcdtpxR1lasNqtWt9hk6ejRkpSmg6G0pfUSg/xK9iT6kQWdRuEVf95teDHp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:424:29c:e86e with SMTP id
 e9e14a558f8ab-4248178db6cmr97035895ab.14.1758344661457; Fri, 19 Sep 2025
 22:04:21 -0700 (PDT)
Date: Fri, 19 Sep 2025 22:04:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ce35d5.050a0220.13cd81.0011.GAE@google.com>
Subject: [syzbot] Monthly trace report (Sep 2025)
From: syzbot <syzbot+lista04d7bd54742a42feca6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mhiramat@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello trace maintainers/developers,

This is a 31-day syzbot report for the trace subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/trace

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 55 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1039    Yes   WARNING in tracing_buffers_mmap_close
                  https://syzkaller.appspot.com/bug?extid=ddc001b92c083dbf2b97
<2> 82      Yes   WARNING in blk_register_tracepoints
                  https://syzkaller.appspot.com/bug?extid=c54ded83396afee31eb1
<3> 61      Yes   WARNING in tracepoint_probe_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
<4> 55      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 47      Yes   INFO: task hung in blk_trace_remove (2)
                  https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

