Return-Path: <linux-kernel+bounces-663851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C91AC4E53
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 14:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F7F3A2FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1902B26868E;
	Tue, 27 May 2025 12:11:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23C1D63C0
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347866; cv=none; b=B6lUaOsudHqOKKbr4MLIFwSl0CbaV5C//DdNCSoB95cMSz3FnCh5Cw44aoMkSp/GOKqrDvv8qG37XYKtzeVRLN4O/npnqU1XLTaQIWl5IXMo4MffaZ2c78W8aXXe/OMTVqjmmF3A1hj/VpGLxLhNGOh4yz2R772z+jhc7wZ0S30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347866; c=relaxed/simple;
	bh=7nzdsY+tw9XJsuzHhu7PU8LWMK8ftVc9MdradTmqDw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RqNhZVUD0sf4/gsgCNPF7ymTFCErkLtYcVfllFzxKO19F5I3DwJz/IrwI0M17rZEJkH+vr/yk09HvW9IH6c7UG9fui7RB1/h4iESfd9LIwNOb+ofDwmPqP7whi6EbcqwDsno+i0Yqgih7CXkib1Gh6iv2/O2LFpq4A5leKMk4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86176e300fdso276832539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 05:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748347864; x=1748952664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4m1UUqpJAKgKSluML/kNfo/ue7vZEDdh4UZJYDFlyc=;
        b=aj/r404vb4YGLh1sExA7RGe9FfmNm/gRKeb9k6bjBJmUp0cnzNr0lk4DHqDwrh/0v0
         P7XwxxBbJfzY5zb9oCgcP5JGnrJLdZMj9MMFxaieZSDOLiY+qrDfHVpHM/DhN6EnpHzI
         ixks61dKgjO/1CQimQPfvORnWpqWeUvdPjBpHanrHfAouQr0G08OL8PS5JAAiHSPJ0nb
         oHl8irXo1mvBYA4bxgak5ui10hjy2Xqg+vexDBJvHTAyfn0MKpV69VkP2meQhxE/YmPI
         9tXBQ9E3XjAvHwMOzPtlXwiNmb4Noo5qoZRNw3axgfuBy6DgPlqn6zg7kC6s8t2nc3mo
         2uXA==
X-Forwarded-Encrypted: i=1; AJvYcCVLkvFdIrSgOSUPDF220XY3sNIhgy9x9TtRUq0n15VnBUY+oXolhE8xTq6bKjvcrSWibPI/EtyX6QgSdkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpUhXzQQ5BvgIu7Djv7GLPXENcFDiAzjoMqAmfZZ0kyh7tP5R
	p9plkNLxORblUrYd/8cHWRGWZ9debPVwR+WoSar/owgQhGmAEl68ddeXq9E7Kmmu1LIhM+Ozdnb
	ets5SXvsoAsFV+h3WrLyyNMWtWhOd8zNVIUZWXpQStuJOfnHKMg11EwM0Qow=
X-Google-Smtp-Source: AGHT+IGSIYi5LdnFWkgJ0KvvU4ja4Y93K3443EfUaNTHWFd5hTIcdZto9eLwg1ST/yNQUSv/ulr77hadAEByejL8PZvym6cI0i1Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3791:b0:869:d7bf:6f31 with SMTP id
 ca18e2360f4ac-86cbb7f51cdmr2008782439f.6.1748347864379; Tue, 27 May 2025
 05:11:04 -0700 (PDT)
Date: Tue, 27 May 2025 05:11:04 -0700
In-Reply-To: <68342b55.a70a0220.253bc2.0092.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6835abd8.a70a0220.253bc2.00b0.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in rhashtable_init_noprof
From: syzbot <syzbot+bcc38a9556d0324c2ec2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, guoweikang.kernel@gmail.com, 
	kent.overstreet@linux.dev, kpsingh@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mmpgouride@gmail.com, paulmck@kernel.org, 
	pmladek@suse.com, rrangel@chromium.org, syzkaller-bugs@googlegroups.com, 
	urezki@gmail.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 82067c916994dd1bfec65496144dc16e17899e36
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri May 9 03:21:28 2025 +0000

    bcachefs: buckets_in_flight on stack

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1528f882580000
start commit:   176e917e010c Add linux-next specific files for 20250523
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1728f882580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1328f882580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7902c752bef748
dashboard link: https://syzkaller.appspot.com/bug?extid=bcc38a9556d0324c2ec2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145948e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d6a170580000

Reported-by: syzbot+bcc38a9556d0324c2ec2@syzkaller.appspotmail.com
Fixes: 82067c916994 ("bcachefs: buckets_in_flight on stack")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

