Return-Path: <linux-kernel+bounces-745789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90512B11ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A942E1CE3589
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631DF2ED157;
	Fri, 25 Jul 2025 12:39:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF82EBDC0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447174; cv=none; b=NLmvEMdcZzRQgC2x6lUl13eEcqXOGoA7jvGs3SuDPIRjG+ke4a8L2xwF7Sjoocqroqj6ePqDRaUSO9Vdj3ViAggvQHn8IJWxSH/ZIeFvdLcEQmhRGrascAxKJY7RNO7HmfzRzx0logQzQ4fTj9+f3IQomdbW0s6G6c9Wh9xOyzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447174; c=relaxed/simple;
	bh=j+a4W2shNO3E2WvLnM7Gg4ZUOiPasmfuQFrkEvfwDws=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QiqQfWFcvEkoiQvaoBxxLNHW7b1RgNMtQ9D4996u1DTKHH+J+Z6VefXKQ/u61QLGMjEDggAScMnhAlLSs6kLEA4JAJnm9Lp3lXD5+p5y6ifSKZ45JSPKEasdc5S5FvdWuZ22QBUTm6ClWWyfSg+S2Cn/VOnhO/1Iv6DaRvNaJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c13b0a7beso233739439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447171; x=1754051971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DsRRqNHku6ZeTrZx42NT9gZz/zhlyjxw4E67HoXW6+Q=;
        b=eYgCfr9aUP5hpRiEPpVLI6aYspuz0IGZHLQ73EawxrQV7iJpKvSB9g2M0vYPT4uS/z
         i6kw6222m92vZRbqW+XBQhINpVe3Eh4KambFWNpqZLuA2msga1BbI5s1S5VxFr4936j8
         1P58nULRtKGshUtKut0cKcp7PQ5sl9Lp+n0o45yb7Xnt63LTV2aNL2NnHvhGD0AG8iOn
         fiOqGSrEIW6wrWMld3ONw7VINxXfirOY7W+VjoYQIaLY0IYXuId2XoHPRGvmD7NyhCkG
         xJUOzEhrveWg5v9tGMkkxCC9WUXy89kOiqtod43BYxCyF2KHEbm9CanlKxZO/TS84Dc0
         52vg==
X-Gm-Message-State: AOJu0Yzu52Xr//U9x/ZBU6NDLD6ofN+eaOa0vuVbhXmSEGU9zFKel8q/
	rzkzvMjoBDP6iinE+0hfhrkCM8Z8MnjvHjWR22KnLybK4z6JwCwqbsm98sPTBBg1/R07njuZh4R
	A8VScX+VGs5IPkhsQNs7261AK6g+vm/gDz2DC9z0LWE1JmDXt2BeKUU+BSXw=
X-Google-Smtp-Source: AGHT+IH0F8Z8GN8WXxDT8Boy8j2mXmuu58wAX84J/uXKvxSVcDkuLOBTc4CxdIJ60uw1BF3KmlAN3kg/hAkEeiOghmrHB83fYO1a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6016:b0:876:c5ff:24d4 with SMTP id
 ca18e2360f4ac-8800f114ff2mr296894639f.4.1753447171528; Fri, 25 Jul 2025
 05:39:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68837b03.a00a0220.2f88df.0051.GAE@google.com>
Subject: [syzbot] Monthly wireless report (Jul 2025)
From: syzbot <syzbot+list7eb4325eb2535c41d4b1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 4 new issues were detected and 2 were fixed.
In total, 49 issues are still open and 165 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  12509   Yes   WARNING in rate_control_rate_init (3)
                   https://syzkaller.appspot.com/bug?extid=9bdc0c5998ab45b05030
<2>  9621    Yes   WARNING in __rate_control_send_low (3)
                   https://syzkaller.appspot.com/bug?extid=34463a129786910405dd
<3>  6819    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1216    Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<5>  764     Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<6>  623     Yes   INFO: task hung in reg_check_chans_work (7)
                   https://syzkaller.appspot.com/bug?extid=a2de4763f84f61499210
<7>  577     Yes   INFO: task hung in crda_timeout_work (8)
                   https://syzkaller.appspot.com/bug?extid=d41f74db64598e0b5016
<8>  492     Yes   INFO: rcu detected stall in ieee80211_handle_queued_frames
                   https://syzkaller.appspot.com/bug?extid=1c991592da3ef18957c0
<9>  438     No    WARNING in ieee80211_request_ibss_scan
                   https://syzkaller.appspot.com/bug?extid=1634c5399e29d8b66789
<10> 208     Yes   INFO: task hung in ath9k_hif_usb_firmware_cb (3)
                   https://syzkaller.appspot.com/bug?extid=e9b1ff41aa6a7ebf9640

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

