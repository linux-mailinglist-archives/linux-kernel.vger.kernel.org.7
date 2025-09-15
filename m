Return-Path: <linux-kernel+bounces-816186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95991B570B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A095189CA99
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B92C08DC;
	Mon, 15 Sep 2025 06:54:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75272C028F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919269; cv=none; b=Xo0OxRRKYTggmdZD1u/2Ac4KIYY62c/9MVJi0waDEU4k3CnEPqslXvg/E/q5IwCq/BDeIS+EZiiHoV5ZdheoEnZz3YSPUN5eAyQw1ER8TwgihZyZ9sqcu2pLqH1EO9YTP6QkvjVy8huZEd1sk+E/RINBhyTMfTm0dm6XcGG3Cuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919269; c=relaxed/simple;
	bh=RUZH9MrG6R2Wn6lSGMC7EE6+Qysluoi8w7ciEMdR1qs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y+jVwajmmvz+HQts7QSjbk+gLmEK4n2FyYmAqBvQbVhNxQEXIKGjLe6cZZnoP0pTEfHZmUjWNRTAAEbpa8oPtC2SjB01YKsTsVzivgLxwGz7T53XHUbGbk7/tvi3jlHKUtW17D0PJ8HhPMGaFWPmJYc/5iQI4ua/J4Pqoe3vpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-40babea9468so54783535ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919267; x=1758524067;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7hR5rpAZBPEZc1EKhxVCYMk7mWTNMUgwIo/9YzXWOU=;
        b=wjQW1qKZxtayZ11HP+7eJDYR4dAdF4w8arrV7q2PTuhHqFpzXXNXx/BWONbCkofSUn
         LZQBbosIGteOBIcUvnG8nNTm61YIxdsUMlF9Lpg0cX/2RH2vSJq6rtu/PkI5qd0moiOq
         +7Y2Dwbl4bHAZlDZd9qq45Eg2QNBlSjxXxg0ifGIv59lgj8qg+8TicVncEvN/s8l2CEV
         bNxWL5wabaum0vyCewvxGpxM+A0oH5DRzfYxDsnKcljE5h0K0jNgn6kuP2PJ3CYdpVnX
         9lsvb/bkTd3qUr+doCmrIHZjrPUdUFXJeg3PFvFr54gU8q29yCPtB7XSulNWL5212bYy
         jJHA==
X-Gm-Message-State: AOJu0Yyr+M50dTH+NzoH1kMtr3iC+uKwoZY7cwrz2kkQfCuA51iPTrYR
	tSbpgHEab/d+6IsP+tcKKlcsOW8oVZy/nlpclz6TNvjXAFmSYxHj78m+WNM8Hg+bzpf1dzVWNpw
	0lOWFdXSviimsr5t1EKxSIbwOI03fYDiQPFEdBvO5qw7KDT8uX6oL1OIVnN0=
X-Google-Smtp-Source: AGHT+IF2L9yVZW7XISBlrtauCEba2ApjG5kZ+P92pW97GXCIXBM2cihO3vzh0aiAlyO+QMnj3FbPATvgocOZde63LNFTX0c6SMs9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:423:fcd6:548d with SMTP id
 e9e14a558f8ab-423fcd65896mr37175755ab.21.1757919266933; Sun, 14 Sep 2025
 23:54:26 -0700 (PDT)
Date: Sun, 14 Sep 2025 23:54:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7b822.050a0220.2ff435.038e.GAE@google.com>
Subject: [syzbot] Monthly net report (Sep 2025)
From: syzbot <syzbot+lista3c06afc490da39b0b27@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 8 new issues were detected and 6 were fixed.
In total, 107 issues are still open and 1615 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  13347   Yes   BUG: workqueue lockup (5)
                   https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2>  11498   Yes   KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
                   https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
<3>  7829    Yes   WARNING: suspicious RCU usage in dev_deactivate_queue
                   https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
<4>  7624    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<5>  3337    Yes   INFO: task hung in linkwatch_event (4)
                   https://syzkaller.appspot.com/bug?extid=2ba2d70f288cf61174e4
<6>  2653    Yes   WARNING in rcu_check_gp_start_stall
                   https://syzkaller.appspot.com/bug?extid=111bc509cd9740d7e4aa
<7>  1860    Yes   INFO: task hung in del_device_store
                   https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
<8>  1782    Yes   KMSAN: uninit-value in bpf_prog_run_generic_xdp
                   https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
<9>  1540    Yes   INFO: task hung in addrconf_dad_work (5)
                   https://syzkaller.appspot.com/bug?extid=82ccd564344eeaa5427d
<10> 1383    No    KASAN: use-after-free Read in __xfrm_state_insert
                   https://syzkaller.appspot.com/bug?extid=409c1e76795047429447

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

