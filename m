Return-Path: <linux-kernel+bounces-830213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B5B99140
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2086419C6804
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04662D6E52;
	Wed, 24 Sep 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhPc9wWK"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E583B2557A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705747; cv=none; b=Cc9uJHPUL9frGo1KQn7K6RPXEYFVSK2ERC3+X1/2hxcXbXRfuurC7ao/ko4ysgvFmvMoxToEWTX1QmjU8pkoR9ppeyGFuGUH9Bm+UTNz2IqMwdBrYaXZx5O4diwkBFM4Mg+woLXdkWpCFXCe9/4Pb5vomPthyTue+QP+LrNDV7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705747; c=relaxed/simple;
	bh=urKK93UriRvYksxsjW3THpt+6o0nNXCCmGwZ1WQqXIw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ldVi+Nz/L3FEAvnc8AowqyXgG8ThrmfWHb5Hg/RKE74voVemW5JTeI2nM4tOPCq0f11mXPIxqDAL6dOjzAE8j0qzWunE4RVp1nf6vie6Db0caCbBOJxcHE02pG+zU+hr+Lfuoh/7bRNMV6mKHfeyVJrc7KRi2agMQgCrY2HVcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhPc9wWK; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea3c51e4cffso5474199276.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758705739; x=1759310539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5eBv5+X81VVm+OJohCi3MWFU1Skt+wsLxd/gpoKdD1M=;
        b=fhPc9wWKt/PWz85+j6Od/FCOhDttuIxeC3qUZp6CroBj3JvH4YuzSWahBrfOyqjyMn
         wiWHjG2D8DP4KW32DCI34FUmeGmuF0UjfTgJOPNlmKMI2zy2fxhcXnonnKnJl7fjmGnE
         kpM6Q9IK7jOKLCrqk1CFz3ektuSvbOb4/Vlq3C5WUS1L1Dl/AcWinujkLxu5rWH5Zp6Z
         V0hpByQZ4GhLBM//0G4dNnEdzZAy+jgMjdqH8/NRNWHR9CVHfdidKEpAjdvFmQefFUM7
         LKFhFdtDnyHKUYNzSFy1D4yl8HWzbut4vT/+Kku42H8vmeZctUc4etvZA0pcfHccECT4
         2XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705739; x=1759310539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eBv5+X81VVm+OJohCi3MWFU1Skt+wsLxd/gpoKdD1M=;
        b=QnqMWXO20iVlrLa71s9HGEt5RlKkLQzU5F74BouesbeEerwXcKOihw1rwr+AVyBKrA
         /dZgdatu8vE+M5M4nXNpznGlfGR/2wTwZ/TcEyQ98I54VecTElPd6pIWoJ+nPZEo7FQN
         U3a2LH6bVwwmSjS+H4i3crjgJIwGzn2rt9qYEQZts5YOK25wh86mdsh+yVt6rg0HlFPM
         aISU3StJWh/urxIJjFLdp2d9IvKH5HcUzdQAkZVRT5fICplgYHEO48DrVYHZOEp1uKTW
         rCLAawwqLLhh1DbK4BIYLGHmKVmcx8KXNUyV8/x6jzZMkvL/dCeFBNggG4wlq14O1g6C
         xdUA==
X-Gm-Message-State: AOJu0Yw9gPXYRLMYd6FV8X0ew6kmwJkSTMjQFLXS1I9C72MyCe3MJMaR
	3C1qCvUEKGttL9r8jCjwDu1lm5e9Ndz3H7kvjIxgCcunlreLCBuVMXF2kUnhUAdTyuCiRWgpau+
	Kz9VgOBjtwpv9uI596pbVvpWaMiFJecY=
X-Gm-Gg: ASbGncvUX7/almihz8oLTXF/Qnbe4XA7CqeEuTLOOzExwXuX7knAyN/zI3HieWIKpOH
	jtxIn/9GnHF5NELrompOhJAtHubhY/P3NNzc2MPq8Vnxf/HEm8HpYxAQBQuzB/eRy6CHFdmy2Ev
	s+5uPsjWZQiP+TFY0VnyT0drAnxQ8frxKx5nGtKfN1X+RPQSHYzFZQKrnpX/wTH8PXmt67RltdO
	ZrBiQ==
X-Google-Smtp-Source: AGHT+IE09RjDDyTL2CEiuY+DHybA5QftRbqzkPDay+NN3bkOTX6rRNQAD93BvqdnSDZ+AwZ4ouMLMjOlmSR7+1/ZG2o=
X-Received: by 2002:a05:6902:188b:b0:ea5:771d:d22c with SMTP id
 3f1490d57ef6-eb3309701d8mr5206921276.51.1758705738683; Wed, 24 Sep 2025
 02:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 24 Sep 2025 17:22:06 +0800
X-Gm-Features: AS18NWDAH8vdxDZG7lz5ddmLyaO5SXg_jHwnbJKJkm9h_e831HgfGjp4szR39Ik
Message-ID: <CAFRLqsUm4M2HTQuO7ORXVE4tScuSTjhjeAVek-7JTBgb9i3wrQ@mail.gmail.com>
Subject: [BUG] Bluetooth: hci_sync: Fix race in hci_cmd_sync_dequeue_once
 causing list corruption GPF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-bluetooth@vger.kernel.org, 
	"gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hci_cmd_sync_dequeue_once() used to: (1) call
hci_cmd_sync_lookup_entry() which takes and releases
cmd_sync_work_lock, returning a raw pointer to the entry (2) later
call hci_cmd_sync_cancel_entry() (re=E2=80=91taking the lock) and
list_del()/kfree() the same entry

Between (1) and (2) the cmd_sync worker thread (hci_cmd_sync_work())
can concurrently:

lock cmd_sync_work_lock
list_del() and remove the same entry
unlocked

So the list entry was accessed after it had already been deleted,
leading to a wild memory access.
The detailed stack trace is shown below.

Oops: general protection fault, probably for non-canonical address
0xff7aaf8000000004: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xfbd59c0000000020-0xfbd59c000000=
0027]
CPU: 0 UID: 0 PID: 323 Comm: kworker/u17:6 Not tainted
6.17.0-rc5-ge5bbb70171d1-dirty #21 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: hci11 hci_conn_timeout
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_entry include/linux/list.h:218 [inline]
RIP: 0010:list_del include/linux/list.h:229 [inline]
RIP: 0010:_hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:647 [inline]
RIP: 0010:hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:851 [inline]
RIP: 0010:hci_cmd_sync_dequeue_once+0x660/0x950 net/bluetooth/hci_sync.c:87=
0
Code: c6 fc 48 8b 03 48 89 44 24 28 4c 8d 78 08 4d 89 fe 49 c1 ee 03
48 b9 00 00 00 00 00 fc ff df 4d 8d 24 0e 4c 89 e0 48 c1 e8 03 <0f> b6
04 08 84 c0 0f 85 4d 02 00 00 45 0f b6 24 24 31 ff 44 89 e6
RSP: 0018:ffff88811a597b10 EFLAGS: 00010a02
RAX: 1f7ab38000000004 RBX: ffff88810d76df80 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dead000000000122 R08: ffff88811a597aef R09: 1ffff110234b2f5d
R10: dffffc0000000000 R11: ffffed10234b2f5e R12: fbd59c0000000021
R13: 1ffffda20435db7e R14: 1bd5a00000000021 R15: dead000000000108
FS:  0000000000000000(0000) GS:ffff88826d216000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb9aea860b8 CR3: 0000000102d50000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 hci_cancel_connect_sync+0x1bb/0x2e0
 hci_abort_conn+0x4b5/0x9a0 net/bluetooth/hci_conn.c:2958
 hci_conn_timeout+0x3a8/0x540 net/bluetooth/hci_conn.c:579
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
 worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
 kthread+0x3d4/0x800 kernel/kthread.c:463
 ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

After our analysis,may be we can fix this by making these two
operations in hci_cmd_sync_dequeue_once() atomic =E2=80=94 i.e. protecting
both under the same lock as below:

 bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
                               hci_cmd_sync_work_func_t func,
                               void *data, hci_cmd_sync_work_destroy_t dest=
roy)
 {
-       struct hci_cmd_sync_work_entry *entry;
-
-       entry =3D hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
-       if (!entry)
-               return false;
-
-       hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
-       return true;
+       struct hci_cmd_sync_work_entry *entry;
+
+       mutex_lock(&hdev->cmd_sync_work_lock);
+       entry =3D _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
+       if (!entry) {
+               mutex_unlock(&hdev->cmd_sync_work_lock);
+               return false;
+       }
+       _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+       mutex_unlock(&hdev->cmd_sync_work_lock);
+       return true;
 }

