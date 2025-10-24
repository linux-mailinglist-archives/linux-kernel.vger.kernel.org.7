Return-Path: <linux-kernel+bounces-868603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 200D7C05970
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3E0B4FB246
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1198D30FC37;
	Fri, 24 Oct 2025 10:31:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD5B30FC0A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301864; cv=none; b=IG38YFRB/JgTrdW/3a5wqbQUq1kQuHVwtYQNahuk52eDxYj7P5WsLxtXtR1xXsaYYb40IHh2S1b4JPFTHQBDbP30wrkEU/I5YZ01wv8StCgWBiYadOFuheGwcB7DuG8ALfl7vpTPDSBZo1iAq7+iBsfvmANGRrzzG+OXTiIAPng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301864; c=relaxed/simple;
	bh=awMDi9vsgw31pxQV/PeYcXMlCxohzJRIww4dv4rFgkI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YZnUdI8Sg2KCw9sl9KIoUCwyMQSEouI44o1wfqdjrRVd9wui7aFMoktm7ZSrimL4c5392CTmTmO04uKATF8FOP4s4ScGRvWFFhM473Z6bX+0naeEzrmwnEiJ8Gb0tly7G3aRxVbnFphZ+Em3YqVbkTuCDHHnypP42ROrWQVaOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dea3so36079445ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761301862; x=1761906662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UK0lmX5OdwjvBdxN8xRhjMcBb9rHCmB33ZSxl/Tcjek=;
        b=aYdnBZWxZ1lzG2Vdg8vwpjU71YQu30ycuHWFZ3+XyctS4F8isnBBgmZQD2yVBFRYeS
         KY+BuIuiyyACgErXVCG9TCghpAkBJxrP4ZARh+cvxxZbgsvxVx13148bf5TZVYB+zt4l
         f3jLMqLumS49Ua4OqXh0ZVUUZZg3VteyGtPgA4unwggX6DMCmUtC2WNAQkQs768IZbjq
         UC3Q/1eILvIZRm9AMd6wcmIbbjDjB3exJ8It0nTXLYX2a1YmvG/2jNhr9j1pAbHZ7ZFt
         IZa8zVRUgC80pfat6gkcCVAoArXjOkgLKvzyTySji9SvTlfzsSH54p1zKBbU7aJB19+R
         6p4g==
X-Forwarded-Encrypted: i=1; AJvYcCV/HPh0XXHjYpSz3L6SwbaAMZ4AN9abzufdU71EgqH5GXFUjc7DXkKzgfSWBQJfYtzoDiPNFnStnRYTKJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUFNpcl41ojP1uyKhcdgxwJ3u6a+4ySYqLxzcUqfePv9SPTNt
	X+LydpsBEgWD1gOxr98vU/kktnVYDX9e3CArPj+tRbpt6qeYh/2xWqbIWEmn4Wpvmmix+9N47Sw
	jsEJTJ5rEVc6qCbayWiqFNHIvChR2WrxPfOz4ebdpIBVvwLHFAyaTNwFWkDc=
X-Google-Smtp-Source: AGHT+IEeyQZmxJknhkG4WfeauPCIS6apJmXIumBFPVNLQnik1ux6JBGAn6ELy7ZFuZo1yh8xEoG6axMYntPq3XE2zP9h/LPgNAxK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ed:b0:42f:94f5:4684 with SMTP id
 e9e14a558f8ab-431eb60dfb0mr22579985ab.5.1761301862290; Fri, 24 Oct 2025
 03:31:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 03:31:02 -0700
In-Reply-To: <20251024071533.erXko%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb5566.050a0220.346f24.00bf.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com
Tested-by: syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=13f19be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7ee22a53c27b385
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f28258580000

Note: testing is done by a robot and is best-effort only.

