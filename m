Return-Path: <linux-kernel+bounces-865898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EABFE488
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 23:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB541A07081
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECBA301489;
	Wed, 22 Oct 2025 21:18:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44274285CB3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167886; cv=none; b=qGt+CYkwkO7CeMwvbaP+t+Ip/7Zh7sQLISlwWKmtU7r6NgMUHuB0e8LgQ/b7+/o4cDt/4hZdX5NlV5sogHCdG2J9amhCgkZZgeSO7MgDinKVC5gioRsoam7EBNkcp3FjqWOhcKERoHbssNeqkZd5H+Y+NJ+wn56ViyGIWys56nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167886; c=relaxed/simple;
	bh=/L/fPbCoR2XqlDrsRtlPPBd/U8dg77Yv79v+3d5LmzQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C8YWswW360Diw/ZQdbfQalCI8s7LGR74w2af9Ni+4PDih5gdK8qoLkAdUTgdyY6lyTKLqIGCrrAZ5qO/oDxJ5bkomhOkwFtbrekqw91A0iM9vbg+gMw3fb2oL2V7E4IuZDuGFQ3nK9yjdJvLMvC+der/LY6ln4oMlZUbu0WajfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430b3c32f75so1783495ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167884; x=1761772684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38L+WYnMweIaXWmLLBw36vMJPck9XE2in7xrVdZRTNA=;
        b=p61nFME5fAJWLPuFxZh8LGqzywYt6AyGuEyBfL7J3mDYWRlGpOPLdJ2pdHkqbOUmQW
         Yn4yuvc6c2qOHsby+byE1bKaGBXveWPb6MY9yH3KNelyL75/UoJu4X+IM32ox8clv24T
         UIWoLQjVrrRWnKp+A/P/1MGRypiBhKKOKwMtMDLah1Jt0fM+kvALXoGQ2HxIFKu6hD2h
         YEj/HX+n5XlHBhW7dHm+o9PoiGi5e/koPIA9OLk4dY2ojA394zrnRJrU/H17U+2VHegz
         fZeVgsuby5X1KW85ysUl1t4IwKMH3IzIqdgn79yIpEa1G8XB7DXGmif8rs6grBwCYngf
         cF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUUB6pymFqgUxcoUZmGrsYiNYe2irhmqCJObq0hcGGhEeu3TqITQyNxjyXXVmAjPCHZGhTKGznMfQ85gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJSGAFVqjp/sNAcmmZdC6kNO3RJrzKWHIwkkmoCYUOXTsJXqGM
	4iWkFU7AKsTXWIa1ExuAHe/o1PGb1pextbSXRPhVHZlqYReRVjTxgG16CJOtnEovYtUtJhnXowF
	mPpX98k7ZqddgtpBfXUWvz5eoimHj7OWUaCSBQGswKdNmoLKL6TwHER0+bv0=
X-Google-Smtp-Source: AGHT+IHrUSfO+wBM+XYa1GlvGvMMe+lBfBQsqxYOOsn5NpbJGauDpFdlyQyzzo+MmANocreJib5/WATuse9K/QUzdbg+mA0U/OQf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4615:b0:431:d726:9ef5 with SMTP id
 e9e14a558f8ab-431d726a1ecmr31681445ab.28.1761167883822; Wed, 22 Oct 2025
 14:18:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:18:03 -0700
In-Reply-To: <20251022163049.98558-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f94a0b.050a0220.346f24.0062.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_rename2 (2)
From: syzbot <syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Tested-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com

Tested on:

commit:         dd72c8fc Merge tag 'platform-drivers-x86-v6.18-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c24d2f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9a2ca2a8964bd4a
dashboard link: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1756e3e2580000

Note: testing is done by a robot and is best-effort only.

