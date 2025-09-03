Return-Path: <linux-kernel+bounces-798525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2FCB41F2E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B4617B371
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41212FFDDC;
	Wed,  3 Sep 2025 12:36:38 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB78B2FDC50
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902998; cv=none; b=dO2GbpH8AmjoAUMim6uMohH92Duro0kU1fM94kFEuKNRivqBtwNb+sIciCIuJUaxpx+NOqb+KC8SD4h2+mYgxev7jYPbwen2alyi8ZkfcfKhRVVskAzv3I0tUGBG9/A1Isa5nmsDK3dGYe+85yeZAtrF+VHZsnrRtp3KQTf+wtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902998; c=relaxed/simple;
	bh=OeZ2/DC7R0QGjvivR5IydEgfYsUxOmhBrplooZ0Wm9o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DULjs+cDqhcXqvfvOc0euqyn7vNPeK9eO5BXVpgwZ09zkxzQIE5rCDrHgmmfrMA2SpESzEHEq1Jun8pbH9JmkWULf3EMMMue7oPvsxN6XbCWgv+BoGTK9hFgGXClCkUGTYX2yH/rpr9RmCMcM42IuDAo41JTNlyZALwzPKrxgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3f05a805d9bso70738745ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902996; x=1757507796;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2LHOUvTxUHRDZHTuy2WgSxf7xJT4vtu2i2hgQBjuX7w=;
        b=J/SBz1elOStdn6/Ej90X0jfDCqvz7q9IV2MqPPiLv2lYX8FNwaGvvMPFjvcO8iJgsc
         7G6A0pfO+HheLdf7/tf35YH9y+yRbXccnSdMh5tgvmX7ZaAC8USyet4jIPOBa15FnTi+
         /Ke3AGY0P9kserbii0otiFIax0GTH4FBMObbMIHFa877drkG95HIsjYd1T1ym6RUznRU
         tLNSmPwJvHQ4XbjtgioDBq2D3FzaM23TC4xOQBtVEyJdn1Ib3FzhaQ+8ie+E8JaDBvGl
         8Wl+z79JaQXNJTiy99irz4yS4X8/9KndrltizOzZod0X5twxq/gTDExbX2mLeHq7PPNh
         VjoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoFrYJpJO4oznz7d93lsNbcfh0CBUkEafozwaKyqpwQvQN58gktIQPIfc1UWezEw3jDTrI1/XM54hb5RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tCiRh8ApdLwfvgszE4x47mqmPtH52tepyYhvrtDN+xMma21n
	Iy0Zs1B0Z/VCHmMOQeEEYz2PpmVgw935LA5AMQpCK6usqDBLESTtEA9KcGtRb2LFgyc88GdNYSA
	DheT+rAV/zCcHyg+MdhMQncmgWnMq/60bn2VzmY2F8p8NmhU7IgE1BlDZtwk=
X-Google-Smtp-Source: AGHT+IETUswS2yDFuaaHHg2PyJKvgAiFrqCIYR4tRHFKt9SSy6k3VMVIe6nukUo/0neTzFmx7S3M8oMr51X9urYuFi1S6OfiVxkd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1488:b0:3f1:a5b9:4a32 with SMTP id
 e9e14a558f8ab-3f3ffda5bacmr225600425ab.1.1756902995790; Wed, 03 Sep 2025
 05:36:35 -0700 (PDT)
Date: Wed, 03 Sep 2025 05:36:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b83653.050a0220.3db4df.01ef.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Sep 2025)
From: syzbot <syzbot+liste8f48e3526c73d4bcab4@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 861     Yes   possible deadlock in pcpu_alloc_noprof (2)
                  https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
<2> 304     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 143     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<4> 55      No    INFO: task hung in nbd_disconnect_and_put
                  https://syzkaller.appspot.com/bug?extid=aa56a8f25e07970eef7f
<5> 6       No    possible deadlock in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=3dbc6142c85cc77eaf04

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

