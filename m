Return-Path: <linux-kernel+bounces-890023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04CC3F16F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AA43B04CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2242317711;
	Fri,  7 Nov 2025 09:11:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4231690A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506665; cv=none; b=jiX2WKX9XrBcvZ70PwIha38p+NsBMUhLjCBqtvbMGq248GP91Vjgdux0DHf4CZwg0vqApKPzJVo5oCnDYlFA5mYuaq6O/iLIOd7bIC47EebsTSQIXMKGz1jCRkjXzBe2RPABvBY4qMt4t9ugeUyzdgLpsUoYBtg4y7BrvwQinDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506665; c=relaxed/simple;
	bh=0X1ghcfB02TLkqvJN/K9ODmXaUSsTTg9mWNYYo1nTLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KDsrZX8vbLvYl6uwOAwOm3uvyk4192kaPMvl3MfQL0gw/h1dgK4Bl76VbBMYUjaqtkTfS+ogL+ATTWHTgb5paxLGItg4dtxyvjF08ILNzjl18ftaUmJyZLe0UE9iOKxd9nT99yyMfeExcjHdePYG+lMcJfab0Y1/1VdfDf6a9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9486440360dso46748339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506663; x=1763111463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYikHAEUL/saSFKLYHHeo8rdkIeAMjFOGtkJrMNYVw0=;
        b=pBL6P9FD9utVza9/eTS+k4vH2pw0Mx+pydeU5/fPygYbP1HPkSa7UjR8uIEMgyC4MB
         sRtah8u9SZeENNWoraPy+BkP646hCsNhF1yJu9pFXetSsoUQuSLtNqpl6oQp7ksY6sJM
         g5CWEwIBZbImVv2qbY1W2A9+5TckzjW8qEDWdg42RvRsD3v9pwMBk73wASo+1lgpwwoC
         UChErUnpoomzzbVm/VphxY1vobnutocsR3Yo0E5PZHzTV2M5dNwpid1w3Yvy3X/bueKr
         LRALF020kIfCOo3mU/zEgZO1/yQkVAeb/QwcL3L8SPCxSBFV/Vlo2Znu8fu4fYy5Qn62
         swOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVylCjPrT+5BQD7i0iSws36XzgNjNXz77DNxwqLhYgO2CucOJuJKISmHb1THJzWG1W7UUTSiiT+y7VtaO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmYjAPA21Hsag0QstdWbaTYVn9Z15jEeF1hfQHn0u38JXjcIt5
	mt83i2KyCE5wKxi53i9p2HsZ2lWSgOla2030NLjPHB0nSFewmImt5IFGco7NvtvEsq4z7lakRUq
	NnVf1deU08aOSuh/jJAMEzQAmCuwPjge15lhArg9Mm/8slHl09G75B416yds=
X-Google-Smtp-Source: AGHT+IErzOQ7//v4VQB6zTO0Xg0CKL3LrQUKyONErqYqpNX+/RP6WsAtLF5Kws28cG3k81vUpLngvkayi8Tb9oVqdd4KLBvvfc7t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:431:d7da:ee29 with SMTP id
 e9e14a558f8ab-4335f46d880mr30944475ab.28.1762506663084; Fri, 07 Nov 2025
 01:11:03 -0800 (PST)
Date: Fri, 07 Nov 2025 01:11:03 -0800
In-Reply-To: <690d2bd5.a70a0220.22f260.000f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690db7a7.a70a0220.22f260.002e.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: Yuezhang.Mo@sony.com, brauner@kernel.org, jack@suse.cz, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 184fa506e392eb78364d9283c961217ff2c0617b
Author: Yuezhang Mo <Yuezhang.Mo@sony.com>
Date:   Mon Oct 28 03:23:36 2024 +0000

    exfat: fix out-of-bounds access of directory entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12217812580000
start commit:   c2c2ccfd4ba7 Merge tag 'net-6.18-rc5' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11217812580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16217812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11062a58580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e19084580000

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Fixes: 184fa506e392 ("exfat: fix out-of-bounds access of directory entries")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

