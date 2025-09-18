Return-Path: <linux-kernel+bounces-768803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C31B2659E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC20A016CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BF83002B5;
	Thu, 14 Aug 2025 12:42:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F52FCC1B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175348; cv=none; b=OhBqXCvyWXcQMt0JFfQFxWsPP6FnCytqNo4CgbJ7KoFgNBQQaKGMjgY2ikm5s0C4ymjPi15BDPJk1rDOR3Xf2wOKTCWBe+982xhSGW9ffbYUnf0cJ6NZUMgoycB6G4y1M0dCqkga/jVXANZyvTNpcZKDpxzxWweU8v0okDN6Yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175348; c=relaxed/simple;
	bh=+jEP63/fwVi2lrN9xFrebDIsSXfRw9oRl5BYut7hPDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GwOyNU3hi6HziplVhCrAfv9wkeZC2VCPYCSfmah25fFw/OTacjJXDZY+6hFdnWNzTMaXMf04qE75Ox7bdRrY+YRZTAMFYsVikaHRBY34uowzypqATqR1USljwXo3tKIVlwWGzz+TW9LtV0LjN44+MEEjvaS6LYh1Zzz2Iiq4jFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88432cbe110so98499739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755175345; x=1755780145;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uiRRu9OJFyKeenKqerh2f8im3zeM5epxTzM5uWVDxL4=;
        b=SVYX8llF55IeJk1WdkfaeKo+W9pVYEhlgEtZjoosfIsOrQKjI8dx1RGn/eQDxM87R6
         zyzssglmfhhU6ZTx1yH+d2eZF+xKqotgXHwKmwGWHZzMB1Z+Gd+rfUq8YTd2mDjTpD2q
         xipkt6cJEWrHK53FPexfjpGE3wLZXRPQXe176BhXz0B58NHUf4QEIWMaz8eptbB6e7eM
         Q9/TieXlMONnOWfnS7opEgL/Um5NfutwjBdqC439+hgjPhDdce7uHqnqI50Nt7+/aUHc
         yV+cCEaYasmBFWWrj9EUDs1cVGtTBAYawTr8tUpiyt+CGQJTU0mXOeRsBtw+jSKQTHe+
         mCEw==
X-Gm-Message-State: AOJu0YzzBJy8w0SPCJ3uC9z2Ez0YySl+PVXOTp2PE06/KMa2HDDtuDkK
	eoWZTNM3kzNKY04jVGKXOVZNUNOz+n5PKPZb7ORtC8KjUJco3IuLVVDbesXfq3/YKtGtE/Cfo54
	9lN97nwAzrR7c38lVMFwJWo0CcY8BHKZCmkQv7W/Tp6xSwpbf2ofcx6x6qzM=
X-Google-Smtp-Source: AGHT+IFLTLOk5lm5M0xQ8qibNIbknOd85LTrLoRWuJLHUBvMopNJUjY/dVy1Po/t4iRcG8rrKtakJVdxO8EiiuwNg4DgXPd/z9jn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1550:b0:879:66fe:8d1e with SMTP id
 ca18e2360f4ac-8843386e0e9mr579219239f.8.1755175345671; Thu, 14 Aug 2025
 05:42:25 -0700 (PDT)
Date: Thu, 14 Aug 2025 05:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689dd9b1.050a0220.17479b.0008.GAE@google.com>
Subject: [syzbot] Monthly net report (Aug 2025)
From: syzbot <syzbot+list60930c84dcf19143ccdb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 5 new issues were detected and 6 were fixed.
In total, 128 issues are still open and 1604 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  370101  Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<2>  13108   Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<3>  10021   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<4>  7473    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<5>  3275    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<6>  2639    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<7>  1846    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<8>  1684    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<9>  1506    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<10> 1034    Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

