Return-Path: <linux-kernel+bounces-727731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D97B01EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F143D645F93
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58252292B36;
	Fri, 11 Jul 2025 14:09:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC114884C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242944; cv=none; b=PfimeqMpyXye3gLNZdCqM0x6VIIokQiWJDWWDHbmP+yRoVKVzvjxBMq1GzhYbKcL69Jz3T9ee50JgWMZVu2IgpL85VtJRWf49KqSq+Q6rVRgonruspyWNF9UV/zuUUgLo5oc7jV9WtGgC4FSuuVSZfA6QHguQI9zNeWqnsq1Mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242944; c=relaxed/simple;
	bh=JKeb9yeEjB4sfYVEc4lH2JYkwaQ26CIkzWXbCSTYGMk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aTzsprO7biUwQwh8JWqXoKess1ilQeCknNPKpkZjXOmO5dE0C/wIp1gFgnkhJTbnv5CcgqMgqMESi/oD6NwMY0Xa6XuwKVmlK3+2zvBjK/Wt71E8OMFMuFHod7cdnKGwGBWfg5YuzdII36QOKQDu40u0HGCh13pfZRNKuOrwk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8760733a107so246167639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242941; x=1752847741;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAYRTfTeARSWg/s1fTbUHMy7DTlOEH44pLxeEKfablQ=;
        b=Y4Pnm1wqERKd9QueSo6QWaGJSiRMCbwuzuYWlub8Lf0PFWRT7MFc5XE51NT94UvFzd
         LLpAYgk6xTB70QtDtm04XcZAAY97oxGKyt+TR06lJXtm29lDt3zDVZjqovp6USwIxPwe
         0MTwVzH1HL0in3+DUyngNZHRe9hTLFia6+wB3AIkNBU1dqZrjR3mjJDybtnOZvA82k/G
         qeKSFK1pI3cmRaRmxIa4q8OXRXga4s4loewxbAjzB0N9zJC16IJDclJ6p3grw59jbqUw
         3x/6BCP8nCUnZmJzaPrlOPaw9fYA8EKWygAaib5zOVAH1UAKc5Ogip46NYj3vQ0EsK1L
         QQOw==
X-Gm-Message-State: AOJu0Yw8N23j1/NcNrR6bHbpypr2PxvqgGka29FGTqNnzyGpT42ISwOX
	8eXnmeA3rdUoGULHt3nUFZYkQRxGrvH79sCbGXcyYI9/KRMgHNBGflZV1/02kImk6g6CxC98WgH
	23ygeqz2B9M1kF0HSSwHTXUbgQtHYYJ1eIQZb4qCRgpizodWqVtZWOHjuCsw=
X-Google-Smtp-Source: AGHT+IGNH0GGKIqH4ZTazeOsJRLovu6xe0zBJSdiyhzqQ00UqI28H58TdP50KeFcqopr2FU8jGgewBS1ttk3lu5/XYHNYu0WQSGY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d15:b0:86c:f0d9:553 with SMTP id
 ca18e2360f4ac-87977f74cc2mr448801939f.5.1752242941649; Fri, 11 Jul 2025
 07:09:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 07:09:01 -0700
In-Reply-To: <40417f2a-e0d8-4f3c-9a37-a0068b6f268a@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68711afd.a00a0220.26a83e.004f.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com
Tested-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

Tested on:

commit:         bc9ff192 Merge tag 'net-6.16-rc6' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115fa0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1650c68c580000

Note: testing is done by a robot and is best-effort only.

