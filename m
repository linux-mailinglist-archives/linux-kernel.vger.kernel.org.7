Return-Path: <linux-kernel+bounces-738860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E4EB0BE51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C8316D9A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27AF2857DD;
	Mon, 21 Jul 2025 07:58:36 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C31D07BA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084716; cv=none; b=WVStxHvRlryoyTyhoe46YPllyl+cTpJqGcU5N55PQIaASGy2KpuZeNMQ8GFUUUi5bdHD0V/odqG8MWWcf00scxVuMsXdNTgV9K9iFgHxDDwcfVz1anlxT0wnYG7wPVgNvq59lg2qsbTZTsMIfNlzramHPtJyvUoQJAUTdWbejVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084716; c=relaxed/simple;
	bh=vWoc6vkEMUZ8tSt7qmyI5v7WgtN0mWOUlxC4Ce5T7ps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rUb5OaS7NONOliaN+7FXaBcjOQr8h98ar/sCvH8lv+e8BO1ltLkLUjPtY80wZp2QjCkcirYt6M54EKtwBx7TEIzRYGDzvibgC1FMbv3bAKj/8Fs/MSfczYfeyR+amQbaqLeB0OFPRWyrWeCESRenlcS3agha2nU04xRRvsfI724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86463467dddso419179439f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084714; x=1753689514;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0qWsH7gI2IrsNAjvn+IJGgtDqsL30WdsMqCwe8OFr7E=;
        b=LDaGFSJobeeXfU5GV4QHaE+P2tz14PehRXJZraykkW/dY980Kc936q7ojePUII/eZh
         d0vR1Dvj1YO1cLpTW0XtjkhYxt+zoK0u6PPElBu7Yn7faJWTqJDca/ThKnszjVYipn5r
         AMhrHmLpjvIdxK1QaHUEwqsJKGUeJf/PkdJTcyDWjsJ2ky9bBI8yx89UURHZPWbidIBi
         pa10LHtn0voIxgGhqUpJ78N5ZLpb1Nj6GwZlXtpxdxPu9p+GlbFtZ/HyYC+nZX+Ldiaz
         w7z9xL+vUxQSVxiiMP3nCmYwF7MET3ALs2yk4pArV+Nsr/579Q4LY/9MlaDsbz0/sKR6
         bTUw==
X-Gm-Message-State: AOJu0Yyw8K6Pq4886W9qTl0sC1GXakUps/AFnn4GeGBbuzPkQAQLOfkH
	VBwhB2RKt6gy0hQuzQ7Wt0315pjvzG8cTD1qjQea2Da7akr4Tbqzw2c1tp0iNlhAPQ8YoFn2jP/
	5nsrKE504MG0K90MafrE9eru46khCy2Nn6/ogpBukL4qRfkgJN/AmUEZSQu8=
X-Google-Smtp-Source: AGHT+IFs4koPgAH1a6/fQqINc1P2RFkey8F9mJltws+a0M1nOFV9A0+p6DC2S6cAkOEUom3pFAg1TXFnwLTvvuOgFLHrq6rh094z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4144:b0:879:49e9:5156 with SMTP id
 ca18e2360f4ac-879c293fbf9mr2405562239f.9.1753084714382; Mon, 21 Jul 2025
 00:58:34 -0700 (PDT)
Date: Mon, 21 Jul 2025 00:58:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687df32a.a70a0220.693ce.00e6.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jul 2025)
From: syzbot <syzbot+liste30f0bbb947a4c7635ee@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 536     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 369     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 75      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 43      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<5> 10      Yes   WARNING in rxe_skb_tx_dtor
                  https://syzkaller.appspot.com/bug?extid=8425ccfb599521edb153

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

