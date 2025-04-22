Return-Path: <linux-kernel+bounces-614370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F33A96A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 14:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DFE164E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639B27EC78;
	Tue, 22 Apr 2025 12:41:33 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49C1EB180
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745325692; cv=none; b=pGloQhWeQImTyPq9K/q/zHPdVe33xEKqao+lXcjwbf+n9uPpG5CAdI4AA6BHT/I0EdqFn/elY+vEr26KAMQ29uUjYjx7yuGS14MSAZW0oPOhjRc/qx0z+TbQXmDWKksBVJHKGlTeuux74daJDtUxfCd2yWsuLWzacjQq21dmrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745325692; c=relaxed/simple;
	bh=9HDhsbv01RswNfMx4a32oUc3pEzflO6SLP0klnbym7o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pFgqsqSvEJv6tnI7XEtYZU7W87qBYWSD3Wu+2eh9oKxsKSYGIS7CwA417xUSdKVNyeQmmZ8zuucaCEx7oe8EPdrQgHpMhapGWPXwj3nYE4Qk5lL3TMvRbToa/UqLtZaLvovGkrVk/yRjIxS/x5FnWEbMOfdmV7nbfOhBUIQv6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d9099f9056so59527965ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 05:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745325690; x=1745930490;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Be+SpEOEdwqWDakuD2zS8KThXc2AfpnLOHspB4bIBlE=;
        b=YUB2v3/6Ga1OJOMlVtDKm/GyCswjVFSDEKC2Tv4KUj8xsvqb0vmnve6xvfU1PB1u8n
         x1mD2tg0cVAI+N2p0DGExycvNYTcXAEFEbdTSWRrcpSURJG3tiQEJAasW15oauFof1aM
         AuFaHVZRjFgQfYcpDk1ob4mFhSTkjAc0AddwN3RnFvtICn3gPKQ7Wa792MaKrXFYMYdB
         7qq/rRu9Wh0W9S4mMsIyCAQ0AxiX/ep02KsBcawdvaOLKg/9SONz9eKU480PpqVcxwG3
         etCfgkSPP/BreG0DhIQouhigMr7k66CjR4oX8lC74i9JeJEAwRhDa+MUDX25ShRdsVXn
         0msw==
X-Gm-Message-State: AOJu0YzOHDX/oALXeka1oi3biEQwzLcF9FTeZAwu6lhJ59MRHFJK6/n3
	GUVTu9cuGoTa8Yn3CG5FJtB16YY28qHq5J7EQMfFwAGv3VUpBqudX3x1Ffly/RAvYoo7N9nabSW
	z8rb7hn/29bpH4CJGYosW2ovSni8Ub/7Go/T860K3cdytKrn9SIPCHt8=
X-Google-Smtp-Source: AGHT+IH5wsaN/1EWPEUutBW6CD/hHPC4n4GPvZUdGxyv2J8/5bEz9Jqmsh5CU6mVoqkUzefVAO/hH6j5JCgEMKWm5Svpv03yO4x6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3d88edc18eamr134648485ab.10.1745325690031; Tue, 22 Apr 2025
 05:41:30 -0700 (PDT)
Date: Tue, 22 Apr 2025 05:41:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68078e7a.050a0220.8500a.0018.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Apr 2025)
From: syzbot <syzbot+list69c01228851d15c2b2d9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 157 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  116744  Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  9766    Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<3>  6569    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  6319    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<5>  1206    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<6>  1014    Yes   INFO: task hung in rfkill_global_led_trigger_worker (3)
                   https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
<7>  562     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<8>  455     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<9>  349     No    WARNING in ieee80211_request_ibss_scan
                   https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789
<10> 344     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

