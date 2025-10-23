Return-Path: <linux-kernel+bounces-866411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9CEBFFAEF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B65719C6A13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85032C21D6;
	Thu, 23 Oct 2025 07:46:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765B2C15BC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761205568; cv=none; b=Ffl6m6ff0GXyFUklAv6UMSaGZg0It6rowesS5O5dZ/5tA4MBmRlz4qrVQdQvzz4+KM6+rqzYtGvS6F+zBgy8qWlJa2iDA7oRm/y1Ipf0tiwLa2+FdAtDGezoI//65k47xmdT4bZuOJ/QBagbHADL17+Mv6XMrQUbZ7FRXsYv0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761205568; c=relaxed/simple;
	bh=mVYOyb4mY/R3I0qazG+bSTyVgEhsMGMLoq+Ene2X1fY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Drd0Zq0Fp5htvgGB883ZjaLR2VOz0FksQ2ti5WFTeVtSajrNZqjRtu9zuxyYINkwCtPrxtnJLUXCvvbXUJle8rHX9B5uHzXB4Zocs7UqPG0LnTI6uyVy79fLUDUznjlL4aR6ZCx1wMEXPpaFf70ihreVsacFfjimKefaQlFa7tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-940dbc45bc3so37744439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761205564; x=1761810364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vmip/qhiz3V5Zxb68MSXXPM2oLCrw5vCeq6I1ybLO98=;
        b=OG1ELOm0R4iUUdf7tb+blCHDi7w/TUHi2KOvygeVZY/JSDZGxbmHtjzbH4E63aNA0P
         MpWCwC1MVJ72DbkHntiHtVcW3xiztx9m6JyTlaX11zl7xzqqYAuVLw4AG9K4kMyvv/Aw
         DWsWKPhgPMvyh+KxZIvC4AczuTZWO77/o3K5neojbjqElBYoAfec+HLrAfBmMQC5Ju8S
         5F2AgjFam7zoSG3FaMGKhB/daPcCXikyrSaUfiM8bNCOSvK3vjCl8Z+vFUPw2Kn3Vngf
         kTotxHqKXSOdtuUEuSWWOVYk/b2OCYcF6x9fSCfjiNtAKdZzoMip9WGd4MbSHLhXhYIq
         MaPg==
X-Forwarded-Encrypted: i=1; AJvYcCVVJOAw715qGUQmBKXYJvEkejTzd2l3sYLkAi+I2stW0Vu32ZYCgBZWAeiln3IRbUE+i0vJVJiAH6TKTGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtF2xgvKbhrd2yC1CPgucdwAuJR5x5pdf5PEYaUdPXisS2WL2b
	5uWHBtOEuU+6tyhlVm0lJ1/1gFRj9ENeIg6nF7dhjiuyarP8P51iuWqFs6abo3iv/OmZ8wM58qP
	SJ3t82eYu83aMWD1ODhlSZu4gOyL41vYR6NZHCkiqHa3FJdrhwZQlM4/b4vA=
X-Google-Smtp-Source: AGHT+IGFSi+RsBvebwACUQDHXq40Hp+o//RQg9v658Uxu7DuNy5dS+FeudBx/77QPaZQM9AVHoaI07JH+8LL1nutmY8FokAdfSsM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3:b0:431:d093:758d with SMTP id
 e9e14a558f8ab-431d0937867mr104690445ab.22.1761205564359; Thu, 23 Oct 2025
 00:46:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 00:46:04 -0700
In-Reply-To: <6744873b.050a0220.1286eb.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f9dd3c.a70a0220.3bf6c6.0034.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: global-out-of-bounds Read in rcu_pending_exit
From: syzbot <syzbot+e733ab672a1b6724c27f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15440258580000
start commit:   87a132e73910 Merge tag 'mm-hotfixes-stable-2025-02-19-17-4..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=e733ab672a1b6724c27f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d8aba4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e1dae4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

