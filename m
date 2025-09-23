Return-Path: <linux-kernel+bounces-828439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA927B949D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1DED44664C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7596F30DEDA;
	Tue, 23 Sep 2025 06:49:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BF274B55
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610169; cv=none; b=LE5SZncWkoFyGik7Ml0C77sLwmXUw29P2fQD8FbJzAYHpEmOq5U3lddJskf0u/3rOO7vrN1f5Gs1QKgtMCENlcfvDavqXCygFYYhmEDtmGKtOnl6T4Kp/9WUKIzw59dG5ymalh3xpyhVa/cLl6qgPVf4KuHhofJHhzZlcuZp/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610169; c=relaxed/simple;
	bh=MPODFSa0LB+Kumxg3VaWBPcm4aie8Ump57xJcnaWcNw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hVvXHUZYnJNyVU7ZSaz8HVwvvXeo+aUuKTJPHp63MxtQarP8NOGHNqDzlEvztEJKH0uVbaBhSuUvjLebuHN9vrgauU9qMurBkaqDGYilh7I4tQ6VSQB8k52tZJLCK7FLWWHICRaRV6dHc1sqIejXeqDwAzqeP4DjHMLkpKxQgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4257ba85609so27700775ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758610166; x=1759214966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fp8qKM4BrjWQru6ag0msdw9SrawryFPII+VRZhnNmTc=;
        b=lbGBblJMe7rRobuzNlBKxLsIhztD4nFq/vRYUNvLh3bxOIAM8mOHJ9Aq43O2ZD3ihG
         QMRuHfpv/c+k9Ww/vuvj1LyDY4+ZN7ExscJj4kRbV6vjq+ItwMQw8hgIxqwubYAN5GV3
         rhfEYjCoTxhcnNQ348P4ifDjYph/0dlt2OKzhE84rnSQ9LatXEVlroK4I6yNFUmUV393
         HVG2lXFJ8/TjPvSX+vXHFDYhz1yYKdsK7AkwTQi66NDU0d7YPqpRSm9FBpj9xiVQPo8/
         ehHkSzKGgykYThrJHEAaK2S8QTo8Y09ewDRlMQwhEYwBunfTHuQ4jxK7yTCRg6e8PLin
         W4dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuCYrR55ESRRHf/gB+clv12KIgl92xjTv7o9jM8zAJ6ke5pv0JhOF5rJ9Oro40L/l/m5MQ0Es89bWoqlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTslzuVdJ4UP0lNnfzqhORM6/udfUg1sZdAjs8k7U8L+EarTu
	B8ztmhBZVzM/0ZRIhHXFrag5WG6vBboj9VaZIf9o6WBo6x+jHhSBZTO3m3QU4cUDlm0hAOuNh53
	2a0Or9QHib1j1jgVQ3Lv7yZXY+nXl3atSaQBEkWDgFzda3SkXmK9v351uu6s=
X-Google-Smtp-Source: AGHT+IEBGF24zzOyubeneeFGtitQGCJWusqzPv2WHH8CjVfNVGRFNz6pN9Bdydodfv+1iOjpxp/pCH7PstDLtqYTIkBOrF+9/PRC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:424:89d:5add with SMTP id
 e9e14a558f8ab-42581e301fbmr20526255ab.10.1758610166402; Mon, 22 Sep 2025
 23:49:26 -0700 (PDT)
Date: Mon, 22 Sep 2025 23:49:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d242f6.a70a0220.1b52b.0054.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Sep 2025)
From: syzbot <syzbot+listafc63eacd78064f7d062@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 54 issues are still open and 64 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  66285   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  36894   Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<3>  32836   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<4>  7150    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  4620    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  3815    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
<7>  3690    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<8>  3382    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<9>  2907    Yes   KASAN: slab-use-after-free Write in dtSplitPage
                   https://syzkaller.appspot.com/bug?extid=a939a1121380d3212940
<10> 2596    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

