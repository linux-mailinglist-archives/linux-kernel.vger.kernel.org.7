Return-Path: <linux-kernel+bounces-742257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F092B0EF41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E96963D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DA28AB11;
	Wed, 23 Jul 2025 10:04:28 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EC15C158
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265067; cv=none; b=E6LNGaSGND7Ujv/OyNGYAncg929nCwTbfxRgk2FJm1XHBGKvbBgTPkNtBvWBGoWkfCSM/NHO52bPSJpfGDtlKwXA2Ivl1grvuEyMAPjC5mrm7N/5lLb0FS88qyP6XVxy9coHTQIEEoGwz17JbQI4kd3eN6V5UfZox59GSk2Sz/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265067; c=relaxed/simple;
	bh=bE0yIo25baacy16U6DjEzxsyFcbj3tsm0i+HCiWRQ7c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q+2LMpgjzRkiYOprFiDoupBSkNJPcSSL4vUIJuO2TiNq0sOVc6sYuQkIEg9Wa7na/b3+2/0kQUx+iF8QQfqo8SYAPkcrSvU2IAp3QRIWPNVS7/BLfLhHU4v8TC5q7n5EkIqMQgPQ67l8N5eEF8gb5ChuPm4CdlXX4xXqXSlDjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c24b196cbso437926039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265065; x=1753869865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKDNn80UNdegqD35YXNlsiMYgRpP2DwQxC56oqDnj7o=;
        b=UFwVUofuf/jyvMugpXySQ6axGI4x6FmOfO9KucWH/tIeXYtq5qZsXReRLrqOUNb3nL
         lrNmwD1JPYRA3vODHlDPGrO5hnYLyZU0/6XAaJsEbfAp1N6Ib+F1+NWcVWMh8tgX7ilX
         +D7vbGtICnZjjZEUTFuzob+4NXcqv7MqpJHFuSDWCP9eXtifPbe3Ro5/bi86lhsMi5Ps
         iLTCOyZdCl4+GLwtqfakVptx/j1BfEGBa7MCcLaEwBC/MiSFEUW4y1pliEFg+KyN/l23
         QRMGp3VyjaAs5hnmxsThMvbBAp2E3OioKgU6Q2JgRRjRbw6sYWkl3JMBVb2A7I1rBIMX
         MVMA==
X-Forwarded-Encrypted: i=1; AJvYcCWeIbI7bDzYZfkJgOKK7Pq4w8qFMdlB3KDuh9xFFK5atOKt0AWXES//k/RhxvJamY5/Zk6IPAoF9rTJgYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykCj3d4F0cuXJlJpuJHEcb5wQlKPBEpmRQ7UlMw0e9aPyhgKLN
	CWvzeFHj1saiL0icAngmZ4zsQV+T+zTXjOiPTf29pPZ1ZWC9QczQ/yF5znCSdmVJ+ghqUrdlxlx
	8SV/MuhvMkRZ5zdoWEg5CHhqd1G4gGUr5IlBuKU5kG+jNdjXrn3bwsZ53GBI=
X-Google-Smtp-Source: AGHT+IGmXIzvjUkm1ra6c1AN/IRIKqaj5QTggQN7vkr0icouMduAxcGeWv8Xt7bE2QI7R7gxf42uXoamrSrPN917MyEdzqndfxQS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1689:b0:867:6680:cfd with SMTP id
 ca18e2360f4ac-87c64f87d98mr424509839f.1.1753265065372; Wed, 23 Jul 2025
 03:04:25 -0700 (PDT)
Date: Wed, 23 Jul 2025 03:04:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6880b3a9.050a0220.40ccf.0002.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Jul 2025)
From: syzbot <syzbot+listbd47593dbaa9c88b91d7@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 23 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  422     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<2>  422     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  353     No    possible deadlock in lookup_slow (3)
                   https://syzkaller.appspot.com/bug?extid=65459fd3b61877d717a3
<4>  113     Yes   INFO: task hung in kernfs_dop_revalidate (4)
                   https://syzkaller.appspot.com/bug?extid=da20d108162166514db6
<5>  68      No    possible deadlock in kernfs_fop_write_iter (2)
                   https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e
<6>  33      Yes   WARNING in kernfs_new_node (3)
                   https://syzkaller.appspot.com/bug?extid=306212936b13e520679d
<7>  32      Yes   possible deadlock in walk_component (4)
                   https://syzkaller.appspot.com/bug?extid=b4567a8b2d2ad5f9dd06
<8>  25      Yes   INFO: task hung in kernfs_remove_by_name_ns (2)
                   https://syzkaller.appspot.com/bug?extid=6d5664213a6db9a5a72c
<9>  22      Yes   possible deadlock in kernfs_seq_start
                   https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
<10> 10      Yes   INFO: task hung in pipe_write (6)
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

