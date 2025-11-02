Return-Path: <linux-kernel+bounces-882053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A4C29823
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 509174E7FD8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E765235072;
	Sun,  2 Nov 2025 22:04:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50A212FB3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762121045; cv=none; b=Pp7TRG7rLz7QXani332TtayeV3ercU7JAyiH/wcGtqQxp0e63oLp6LhmXHsNIPJbeCNjfIFBUV20C5zyps4JCkXShjN0ADYpdJpmjtBoA9tiaFJTWPA9TJi/H/OuClayJ5R65WFPv5dVAqgEEDlLMEDTwKokYYNhFKvojyS29Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762121045; c=relaxed/simple;
	bh=AO+iFmYMA226N7iYyxx7Hp+iP+wh/OF1WZVixG/5Lys=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y3wPCAkl7y/D1I9oUeX7o8peH6PAl+7/4wuQVtQzboOl37083znmoK49s4tm1AlOqfkeTIQpEo3JUNq0u/OdaTC04R+/Uz7jnh6SJZ56MesIGoEp7/mD9QOWe3lsmb9xGk31IgvCA/xAJwWderJQGGKLksCaD206N41vzoCJG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d7ace0ddso46876795ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 14:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762121043; x=1762725843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQVwdv4eWaYvaHTFkMJxPuK+gjott87AxWNHFjmTT5s=;
        b=dqeO8WDUwFXnvUdUQPVfatOOVPwKC4XZ5fBGdb9twZ1tR949P4bL9OzCaybbyVYmhD
         zmHRxte7vhN59P9Q2hRZCAfMpB31mGIdnFplkdQPlnWswVJA3E1wU8KyBJplu9Rkv2Cw
         lA35Rt7ZKzFP7zhpXu1lIqOS13A3Zy0KznDn3AVQlzXhrmXYHDM8NeQ9TQ2hK+kFk6jl
         XDbWXM9egVGUGei1mIMrFmt4f+ZWsHAYzvwPSU5xI+n+R+BUKHnRQ7ucj0tPwf5dFs2E
         VEB1QE3To+bcFglKbLz6YmDvnyZvZOteGSmjuxmai38Xxb2eFEPsMP8QKlQOo5j6s8Pj
         V3tw==
X-Forwarded-Encrypted: i=1; AJvYcCXYTP2ENypARhDkvWIhJwMibDY8v9NVfHo6g1WLrqlxS9jdp2sf9jitFuZk0yxGO13MV8OyMqBCUl2W3rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1z0eIlQbNRirM361bt7Wv3l/3LHUin/aJ8fMVkw7k/7tk9uy
	8JExZJtdS1hb6gq4ykUy52mr6fZP+eTkITxvHcyUfUi3Ycqag4BfyPO9aQ3zGLH80eUkS/gGTl1
	viAMP49LZdLCPOWgJd+nkU7mNVyeOiu7ExFDNOVnsfTAuVwlTtkmuLf0KBQk=
X-Google-Smtp-Source: AGHT+IEjXK0QkI+rrPxBrgxfc6cLoylG6k/U84Pa8d7z5Q4Vs/iJfDP8oHvMlgTOENA7qqiv7frDPv9TdDWWXhTgRyu05GFz52KI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2707:b0:433:2943:3a78 with SMTP id
 e9e14a558f8ab-43329433c4fmr37972075ab.31.1762121043382; Sun, 02 Nov 2025
 14:04:03 -0800 (PST)
Date: Sun, 02 Nov 2025 14:04:03 -0800
In-Reply-To: <68a7eee8.a00a0220.33401d.0167.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907d553.050a0220.29fc44.002b.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_mark_pagecache_reserved
 (3)
From: syzbot <syzbot+baf59efef8862c9ba260@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1295a012580000
start commit:   8d561baae505 Merge tag 'x86_urgent_for_v6.17_rc2' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=baf59efef8862c9ba260
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172f1ba2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a79234580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

