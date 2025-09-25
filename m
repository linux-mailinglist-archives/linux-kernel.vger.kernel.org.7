Return-Path: <linux-kernel+bounces-832182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCBFB9E935
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6050A4E30EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E22E9EC9;
	Thu, 25 Sep 2025 10:09:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2EF27EFFB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794947; cv=none; b=oHwoCmxvqUxtB53T9PIRgZ1X5iyezQIJ6O8u/uTfghxdEsxYSCOuQQReO8mXlfvI1UtIgybmkj+GV29Pg10bkgwIkq5eo0DloLg2PAiJq1VdXMlwYdS7QU4/E+2Pr2jLLEUWJA8c3swPeEfVcGZZL50oTGj1DKybL0BeZTP5SJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794947; c=relaxed/simple;
	bh=Cb+PJsfXQVjMFKa88JFyHwAWLSXfRqlsmHwuqRHkS6s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RVDyNArRlS9guYxk23EVhTqTHECUccPOTLVIVwUSEuXyJlY9mLsI3eK3Vwny7nDJzSAUUICmkOuwlBoRmEZaYya+opA7qTfJ5IDtNE1vp2Gt0Gc+oCk6+a5DghMu43uRnO7YyXfBFCrNl2uury9jIQUoykkmc85Ggx/NZU7NkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42594b7f2ddso10613045ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794945; x=1759399745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHMGfNY9iCX/I5OqnCCgwn00QEVbB7rGGet5Y3wlmbo=;
        b=K+KF2rTQ1gT7snpZzQSKhodLL5hF2AvgOrX6R1pOWxvSWdmEKh4ZofmCUqZSDKxK5D
         jOGOx13xA/xzqn8ZDm1ZKEbdnZT6cuYJUTxaF5nAWGNYZR11jBHpuS8rTvMXDn2y8ni4
         wR+BrlThXqojcNDxmI0jwGHATQdzpDsE+/RB3qHfp2853OC/OFqSubGFAYdRViTC3xZ3
         kqYv3rbvpYWAaCY4wV9mAxLBMXUQKHmiideBA37Odj/Y1uXZ72UOwbeOfxh6EGOtccJt
         DxmO7MBGRyweE0Osg9aNcRJnp+P+efD2lZf8KQiBWsAbvgM1pTAlldCdZg7nan+vX4HE
         oDWQ==
X-Gm-Message-State: AOJu0YzCjTOM0ikaltA6snlE+tTXsgayHOuQ8Q3m8uw+B+Ms6IpSSmjU
	OpcSbMZfAGuC+DpQHoNcBd2/gea4WStJZz04UHm5b2Z9M1TBMulNndHM9mth6/6SJBQnY9rkHZi
	Swa7QgxBRvcwcLxdjuuvWjvgiqJdQI2PafYgEn+Xgv3JModv/8PNZDI3T+Mo=
X-Google-Smtp-Source: AGHT+IF30hew2ObHiniw/+qgw63OiWo/a9lCfUvlGkOs9blXVWmwgBEQgipH0Cfl4Vrr5x4bzrC3/YX8yKBbhNFq+bVGUBpFW4rc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d93:b0:424:843f:a010 with SMTP id
 e9e14a558f8ab-4259565775amr32095745ab.22.1758794945418; Thu, 25 Sep 2025
 03:09:05 -0700 (PDT)
Date: Thu, 25 Sep 2025 03:09:05 -0700
In-Reply-To: <905bb5a8bc3e969ef332dd604864ba67b93e1a85.1758789532.git.xiaopei01@kylinos.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d514c1.050a0220.25d7ab.0008.GAE@google.com>
Subject: Re: [syzbot] [serial?] KMSAN: uninit-value in n_tty_receive_buf_closing
 (3)
From: syzbot <syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiaopei01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: use-after-free in n_tty_receive_buf_standard

=====================================================
BUG: KMSAN: use-after-free in n_tty_receive_char_special drivers/tty/n_tty.c:1347 [inline]
BUG: KMSAN: use-after-free in n_tty_receive_buf_standard+0x1283/0x98a0 drivers/tty/n_tty.c:1588
 n_tty_receive_char_special drivers/tty/n_tty.c:1347 [inline]
 n_tty_receive_buf_standard+0x1283/0x98a0 drivers/tty/n_tty.c:1588
 __receive_buf drivers/tty/n_tty.c:1624 [inline]
 n_tty_receive_buf_common+0x198b/0x2470 drivers/tty/n_tty.c:1723
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1769
 tty_ldisc_receive_buf+0xc3/0x2c0 drivers/tty/tty_buffer.c:388
 tty_port_default_receive_buf+0xd7/0x1a0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:446 [inline]
 flush_to_ldisc+0x43e/0xe30 drivers/tty/tty_buffer.c:496
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa2d/0x1b80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x230/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Uninit was created at:
 slab_free_hook mm/slub.c:2348 [inline]
 slab_free mm/slub.c:4695 [inline]
 kfree+0x252/0xec0 mm/slub.c:4894
 ieee80211_ibss_rx_queued_mgmt+0x2eea/0x3e80 net/mac80211/ibss.c:-1
 ieee80211_iface_process_skb net/mac80211/iface.c:1699 [inline]
 ieee80211_iface_work+0x11c7/0x1e70 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x341/0x850 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa2d/0x1b80 kernel/workqueue.c:3319
 worker_thread+0xedf/0x1590 kernel/workqueue.c:3400
 kthread+0xd5c/0xf00 kernel/kthread.c:463
 ret_from_fork+0x230/0x380 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

CPU: 0 UID: 0 PID: 3884 Comm: kworker/u8:21 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
Workqueue: events_unbound flush_to_ldisc
=====================================================


Tested on:

commit:         bf40f4b8 Merge tag 'probes-fixes-v6.17-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a134e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7564f7873be81d2
dashboard link: https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173a34e2580000


