Return-Path: <linux-kernel+bounces-864747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D93BCBFB751
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A14D508894
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC4C322DD4;
	Wed, 22 Oct 2025 10:50:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A33309EEA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130205; cv=none; b=AQL/R6b6LQCzSOMD1W8OsXaC7TC61WdrROOhMKRcnjguO12wOod1j+r31ClQEkch6jEC75+1ib8BNBcYSjl0Z8Wn2DQWRbdlgOfAQ6SZSJj0B4toiIy6apWUROo5kN4YAENWkuw9un4WIuduDC2+/bZ6cGM3is/NPm/Q7WQitOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130205; c=relaxed/simple;
	bh=KAgu5IugI7caoZsDFAxQ4c+AWLhL0ddYSbvmrWyorbk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KHqQTRGngxYx22LG0OlO2CUtCKruIUsvp7kkLr83WOnqzTrCzBAhM7y+NKQKS+lHD52049FjLUs7AvU5PSaQFKcVGA9Ah9rAIrpTDB0BIaVf4dMhEqItsMYD+liMZi7XDOZMT8fbQp4VsGT65/IM19Dty2Yoa+c1RXXI2VNktr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-92c4374566fso438559039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761130202; x=1761735002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlmXij5Uaeilfor/bVltP21qZ8iz6XbHFYFTbD6qy5w=;
        b=SijJrqM40kK2yLrI0YemsmTC2Zt6iVTTruS0LF72hanN6mADhO/tQK3KOBhuk5vEGo
         ue+g9No+Hc0+JgkHej1kpjyAancOh4hUO+/rVJ9LLn+pj0iL7Fej0k+fzHF69e8iG1J4
         3m7XHAUjwqlCtn+3HB0QLGtUcxv75hCvZj2MEiseRQ/5JbRHCfDTt3R6WLU/pTTPuwxx
         2nFuHQWwPEAgvVBxvNfngg7sJvlWMkF9JD96WJxbsQfFpBJEs6p3VEtM8nEA9+ezNf0a
         yWCiYPvBg/R5K+NNXk2EWXrOaXAKcslph8W+F6VydGShBZ5y91f5Nmi5NQ5F4iuwX7G6
         DXmw==
X-Forwarded-Encrypted: i=1; AJvYcCVa4bKGAFkD3V2xZ9UrAr2bXTnxNqcbjOIDW1izKid8MvF9GzKRPxih70s+jnC12dOj6ruy1Rwl0BvntpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72en9XMWkovZc19w9YKLHV7EV7U5LkWH+aatjoAFgDFfshWlk
	sp/STxjeLyr+Ec0VYwgs21a7WHlIB1ZP0gIQv+krJkZfwQ5+OKx1ZJDEaeKRfxdNGwI7ZmRdAt7
	QDBFHIm68D87z22GkT3rP+giMN9ax7JcFcNl6Ytn1aSKWGPqdT9akMYmWTFs=
X-Google-Smtp-Source: AGHT+IFuYVGdHIdVB5Irqp0wJIp/XBoRCgTEMcg7x2Stj5KBjRavGfaYGifN4dFm2hj5wBCT3jqmYKo2yd/6POU2Lp+pMfQKMXT2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380f:b0:42e:72ee:cde6 with SMTP id
 e9e14a558f8ab-430c525f609mr316861145ab.12.1761130202364; Wed, 22 Oct 2025
 03:50:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:50:02 -0700
In-Reply-To: <068e55cc-f5c0-42ad-99b5-352830583144@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8b6da.050a0220.346f24.0040.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=122cce7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c601ba0b0d071c6
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b8e3e2580000

Note: testing is done by a robot and is best-effort only.

