Return-Path: <linux-kernel+bounces-695261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE9DAE1797
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 11:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1B516620F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B787F283FEB;
	Fri, 20 Jun 2025 09:32:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815C266561
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750411953; cv=none; b=gbdKGxhyimC5T0JT7RSUmiGwuezRNGmWDs73oy+mmfvb/avLD91JuF0OW4mnctQSTuSOF0fuAxmabZV1iZWAeBwhzu+pHVlsxBOUTVFOKsYaPZB2tOq8GEg3IjDHNaOl9VaizDOTcp7haiR+HlJzaD6a3F1CYIu/nmytMcTLLtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750411953; c=relaxed/simple;
	bh=+DS0SwWGVhQpF7xks0fNEy+VbOQ73ZppUW78S1YUBSQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R3QDOcGMzlsLAdXNlQ+nzZmQG1El95JvvW22n61F67vxpsBTFwQjbOhbPvcmaWv0cq5l2kocA0HcoC+TKepmPF5dqahSa29+9KUBkc2wK0er7lPM4BmCvyBO1zj5MTrs4HcgCpZSp6Y/mepTsm9kyfDdL+I+FX9ibHPgjLI7288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddd5cd020dso37544385ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 02:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750411951; x=1751016751;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfVCfYID8ynNoAhHJetYJjFvlI7W95iRFPmmIzEobSE=;
        b=bHfjJfFxZi4gqD59SesJ32mIGHclqt23n1LjIXeJGU8m8GxuKaRECECoyIGbb0uw6+
         IhieEVc4StmmhvEVuoNXjxCS8qAcAxXkimZRJS/cgd2Npkb6xvbnqYJOycux6vZuKkX9
         ioKR3CglVNgdLuhQKbKj5XPboof2A24Lg0no7oiEb8d+zVNh+FYoYCshQ3ssgYwUW2Ss
         VkWLOQAP9MuWeev55L2y/hIUARqZGYPi+g2WSyVs996L3ajF1+khLoxOAjtVeMwAv2iX
         Ka15jOiTV19dfMa8RlbBSfD2DI3VcIcpHDDrRX2M7oe80oT3onx2BXK5jB532xIP0XZC
         UOIQ==
X-Gm-Message-State: AOJu0YzJUgQIPyhGMNkYpWo5lsGgbwilinqVirYYZ1MECDslwiJuBhKN
	BlFxuw0ZtM6bFsvKstlnKZcrSA+YU2mmY/vb7gwcfARuhKljFRW2corebNGxhqDQ1lnTOaU+FNa
	V32r/SEGdxMPv/6LgCmD1JkR3leeNFkBlNtiIwzA/uwJZkViMZZGeuSAy3xI=
X-Google-Smtp-Source: AGHT+IGstLq5VANh65+Gc1YZ63Lb/J4GcN486TU1d/5UDaj2NwXT+37gbrQyZYU3p0tWbq526CIxLzOfT9Hq+MXgpbHqRUdj3xTI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1985:b0:3dd:b706:b7d3 with SMTP id
 e9e14a558f8ab-3de38c5c97fmr21209505ab.7.1750411950892; Fri, 20 Jun 2025
 02:32:30 -0700 (PDT)
Date: Fri, 20 Jun 2025 02:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68552aae.a00a0220.137b3.003f.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Jun 2025)
From: syzbot <syzbot+list130c9052d10c27bfc9e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 462     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 338     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 72      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 50      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<5> 28      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
<6> 5       No    WARNING in rxe_skb_tx_dtor
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

