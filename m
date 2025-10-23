Return-Path: <linux-kernel+bounces-866386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B5BFF990
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B18C1A06688
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4F2DFA2D;
	Thu, 23 Oct 2025 07:26:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8512D0C95
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204388; cv=none; b=RgyhvgYyyzYpo7TbyGG4JawgArCL1LaAdm4b4Bmf+Bgtw/p5Zt366WjOhgq6mtfyIE6bmr/IJOyqiFTglMm0hQqZJXvyxi8L+Tkr+QCCH8J4EaJn4Hyz74w9WQz0ExnHbQqsuj5/5mJD/SQDouvGTAvdEGyzn43ESxcvFi3JQZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204388; c=relaxed/simple;
	bh=072T1hELA4IEXLyNAvTpI1QKo4tu/F09LzG59OgBE/g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pEEuIVLr83nD/oz0RyvBCbM67+ysgGHsac5KTlAgCzMj20qV2HzGAZmoxtVsMPxVCifSjF6JefH9coohzmQdXVKNmZzy+xNU4bU80gVUswGkctCVvwqrbE4jK1WOCGP4wDvF3TxNPIomMKUucyecQtHXKi2dvm4gU2MrvzKid9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e86696bd9so38663939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761204386; x=1761809186;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fvf9ZRE92JNWYABHY5d/bObPYmap/MAjRNgVlHVzgxs=;
        b=teKRNoaDpsrzj+carbLTiVXm217inESX/Ap+a2LMh4mIodfPAlekenKptmDjoe6c/D
         xX/cOIOhph3VEcvLA42zdyOh1Fqt0h4Lcv1uCOqcMHQFH8iAenzweIjo/xzXm66awZds
         LMDP8ggf2/Kip1Go+heQlm0ET0VWWa8Wy8LFWbEnTC7l3az0mzQeXiE9U3M/p2OlKR1/
         Hr26gMkiwDMmzcnd8D2TwqpKPfQqUBfqTEPaQ3oVWSzZmMf6r+T2ZAX+Ieo2Kl91WCuc
         v5RHyC8cfSZU2APloS/d3QjFRRZ3413a2V59IUXDCn2ivVsarr2/4Zaaj8fEofnfa2MH
         NWSg==
X-Gm-Message-State: AOJu0YzbsFjabHtGfCToyVgkdiAnzHFWt7G6/l6OZZ6kEGFGx3pqDK5r
	z5J6xwy6DeWp8zuWaJNodYts7IWCYgCx/tq+uDSav5WfoZZ5XEPumGcBYqoMXFHMRlIZ7U8VP7p
	t50YCpcr/bDscvSW6o4he07bNq8ZEt6mLfS/1mAfQVhtGWbP/S4Cy9mIN48g=
X-Google-Smtp-Source: AGHT+IG2kb+3VHnGMQVwuNQxhL6zzopTu/NOetDQ0IYJeK1D56foFuVk+8IoRsWkHr8VbEZDqSkkljH9Yltq1k42HqeQ8hqGDBHu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1414:b0:940:d395:fb53 with SMTP id
 ca18e2360f4ac-940d395fcbemr2167628439f.12.1761204385851; Thu, 23 Oct 2025
 00:26:25 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9d8a1.050a0220.346f24.0070.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Oct 2025)
From: syzbot <syzbot+list0ee54e0d9d6647c72420@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 66 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 969     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 546     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 100     No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<4> 94      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<5> 89      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<6> 5       Yes   KASAN: slab-use-after-free Read in ucma_create_uevent
                  https://syzkaller.appspot.com/bug?extid=a6ffe86390c8a6afc818

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

