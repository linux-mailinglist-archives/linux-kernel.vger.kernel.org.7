Return-Path: <linux-kernel+bounces-820234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFFB7C7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D861BC65BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4D309EE1;
	Wed, 17 Sep 2025 08:29:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E493093AD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097767; cv=none; b=mlKRjLh0JS3Culk9Xqt6LsMqQxYecOqg5JTHbl0tQbGkKIjANMkZiNRKwNPt5My/8ikeShwyrnXxi9TxTDWkkyBznqCJ/gEKV79ZLMOCorJL2+cTtZAy4wF6N6APFx0bEA7rNdgNnQy9C32i629S1e6VwsWr0prtZZ7vK0PIf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097767; c=relaxed/simple;
	bh=FJoNQqJXtj60g8gDv8cC2YfO+mxHB1pkxAFUcjx2IJ0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Lt2jvdWLD2yAC8sp8CkSs4XL5EHdhZ9z2JWN21rJfisvFv/ra30wxjptGTdAC2mde/MgFaV+drxjuWP7sYv4pE+YVrwbHbATZUXbERr4RbAHcc7VfTa8etchLsfYodWDq2pR5E9nldQktxTJWJ3EyNfwV5B4XuAXgspxEOuTy3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4111411b387so60396615ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097765; x=1758702565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afF6BUTjlVKGcIJLBLkX3PZzyc+3FYOu+Z3WhK+U/9k=;
        b=uGIzzBH/HqHl5UTe/mRKRUFpy09EefT3C/bqIfpVsDNY+fXf+ba5/cbi2e6WIhH/cC
         Hg298LJkM15unwUZBtLNU+oJ4owlyLt4DOFdvLyy0fJ8mEDNTlNTusS0LFJ/RPndqMUn
         mEGoesPhkDv4R9OzbqTR3z6ZZUy8otWmhzcVJzrEouqE+UXwnS6CcDASe3yn0tUmYSRc
         sI2n4k2waMKClNb/oZi5HfppONyLpX8foleESUXqvBNQard9AhZXN3rE5a5NmxuuBYcG
         lwRJB4N8b0T7CsUagLTAb5IzWVSDAoqgD7+myAVc94pDKuPguvubUK+PWTABL58nBakX
         y3PA==
X-Forwarded-Encrypted: i=1; AJvYcCXt3qrY3rNxJrZAivI9wcJBay/guEu/GPoTzQZHz8dm7gvGvgmXgzsXu0+s+k1qYP6JJjhpifJPHcpF35I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr0MRjRTJomylqCxwssDST210lTBRjkUCzHZy/bnZ9Sokj7Ajl
	K7BtysB/smGGggKCYkWNfu6gT1UrBJy5jsOgixS+7EPv/u1gbdFt8M5URZ6MaNLQX+UAyMwOPf6
	fv6vUfWwQPzIS9UQx6ZfMw7TZkrG+JBCo/koqxyXJCdG8vZtng1W6+lrVXYA=
X-Google-Smtp-Source: AGHT+IENoyFHrbAFtIiyOa0rWXLUOGHpgkw1GOGepibxcENjQfgSJHiqen3fhMb/WEuYTutvhf50XGFrYWbDYBScIk7Rj4Y4MWwW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2786:b0:423:fd85:eafc with SMTP id
 e9e14a558f8ab-4241a4ce3ccmr16474755ab.6.1758097764677; Wed, 17 Sep 2025
 01:29:24 -0700 (PDT)
Date: Wed, 17 Sep 2025 01:29:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca7164.050a0220.3c6139.0f9f.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Sep 2025)
From: syzbot <syzbot+list5a3a7425b8f8e7ef252b@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 10888   Yes   UBSAN: shift-out-of-bounds in v9fs_get_tree
                  https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
<2> 3010    Yes   INFO: task hung in __iterate_supers
                  https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<3> 2497    Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<4> 88      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

