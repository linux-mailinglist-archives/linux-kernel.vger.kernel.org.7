Return-Path: <linux-kernel+bounces-862841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A4BF65FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C9D5426A0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6860B3346B4;
	Tue, 21 Oct 2025 11:57:15 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D042FB989
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047835; cv=none; b=IpB+xTr/VMN4eIQjQJMjX6IVGIkghRFT9kbsFXPsYSury0aRCNCpThk9jqpiIHTfaZNoYtIvxWDh9iFF0Bzk+wbCHb5ACA9wDn8K5fkTxSII4qxvAbt1c4PDMfpfQkc6D5rfg2QfyfBbpALMdFGjGUh6khx/BrGjuT4QQ8hTKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047835; c=relaxed/simple;
	bh=AGNQYCd9RppPP11eDF+p8PnPZY3PKaiQLSPrWoTdXmc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J5hCD4DPhzbqGFuaLBsobnu77VLYOGluhT51RhVVw5aGLwovyXbFQiq+fYxI4XOWI8ZPx420ScclkqFfsICneAqkQ3sRdEbDebrhc6L9s6JZWJ5MPE+bTCtznYrmrLxcnRPw7H6hD9c41xCwJqbH/JkWPSCUATYIMp7WIo2gQz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-93e86696b5fso344552839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047832; x=1761652632;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRPEBifTvLKJugZ6m1KAqTS6vQA/g6rh7HQSnl8uq1Q=;
        b=LUJy5JPMUPvyV+xr7/PfaEYKP88uG7mFAL/gEcRfbUne5s7cPtA6M/x7nFodFA/DQN
         gvyzAd8g9yxgdlAgv/N3Qgb/vjBvRfrT/isAeV4WlCmqirukHmw97i+Bi8kP7q3D7ye0
         CkYW55FIJzJjGlK8HziIZINEAdURVVI3XcetcKIUQ9JQS2T0fdALwT0OAoZt/KLIwvLQ
         ULdBg50tBNFGBQCI6iY0Q/agoix11vheETl4n/hXuNG2nCdDbRa3BgfMYvys2Gk54Ub4
         TojaKhkcOEnNL0ZffRQ9rYdKjYJPUdHlYl5m7sAqCkuaz1jkVEA6ZHqYru0+1IzIIZBu
         tGNw==
X-Gm-Message-State: AOJu0YyNoE3Rs8ncibZ6jvkZENsQi7xwie8VeTCzHfXPD97KeriZ3HkP
	+lcO1qxlmS0v5endcUdyQq4kde+tAygtMsAWQxzHLogkz5ij0mFaN409RQ4+mlCJehg+ICpgj+8
	Da7DYFr+RtLE7FJzsX9f4WQbHNDbJIsYBy/m5ndlsJ+9M6eNpYMy2LQNqRTjdSw==
X-Google-Smtp-Source: AGHT+IGt5foV0Hf79U99xFDLmxGtpbReC6Hzeqbyiz2aAIZ96N4HB5VUN+ZN/xZYuIij7A2tQOoIG6uERRQyKpE58buZOUnpzJrC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:430:ab21:8c4d with SMTP id
 e9e14a558f8ab-430c5232bd3mr233226405ab.11.1761047832536; Tue, 21 Oct 2025
 04:57:12 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:57:12 -0700
In-Reply-To: <68f6a48f.050a0220.91a22.0453.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f77518.a70a0220.3bf6c6.0005.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
Author: listout@listout.xyz

On 20.10.2025 14:07, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16be6734580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bbd3e7f3c2e28265
> dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111e7dcd980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1223a492580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8ad8459a8da/disk-98ac9cc4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/28720fa307c1/vmlinux-98ac9cc4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e4f310acec99/bzImage-98ac9cc4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com

#syz test

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 56724b33af04..b7290912dffb 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -938,9 +938,9 @@ EXPORT_SYMBOL(ieee80211_amsdu_to_8023s);
 unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 				    struct cfg80211_qos_map *qos_map)
 {
-	unsigned int dscp;
-	unsigned char vlan_priority;
-	unsigned int ret;
+	unsigned int dscp = 0;
+	unsigned char vlan_priority = 0;
+	unsigned int ret = 0;
 
 	/* skb->priority values from 256->263 are magic values to
 	 * directly indicate a specific 802.1d priority.  This is used

-- 
Regards,
listout

