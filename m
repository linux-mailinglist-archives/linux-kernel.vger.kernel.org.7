Return-Path: <linux-kernel+bounces-794025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225FB3DBA1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB34189CA2C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6282EDD6F;
	Mon,  1 Sep 2025 07:59:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57241E47A5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713544; cv=none; b=pTyOCdk0fP4hQT5j6M/UJ0jgy2AdEdYojf539R/g8ujwNRVdxs+i0cUNLhuwpv0/j8Fch3z9kI7lfzYfVorDsHfij/VDZDJFC6paoY+gWEXWqk6//6uDHT2abOPZ/oMduk85wsYIdQoUQLkox2cBGDP7jplww7ibLlFbmYAu75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713544; c=relaxed/simple;
	bh=U+3HJz2k5gfXojPRjRY9ivcaS+FnuDZv/X2TY8ArTpE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vCU2J4fTq7j52QVSMXja+byPQsBSfCVWU6K41VncmgdKTBW88XuIh5Z7Wzf0HXmovcP1788otltrVAofgHhRJs0GmwbXl+ESBzRsWE2KY/rS+itS1+JJmv7fdyAg6UKcSxqmvuPn3rtddvKyIalMBB0DjpcDPEniJSZRBBONV40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3efd62bc46fso42408175ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 00:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756713542; x=1757318342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncCn6bpTVDHk1ba1TpluJzliVkR7s5GToCEpP4HhJVg=;
        b=rjiYeGwxJQdjsVBe1J0UVKYv5JJ55snlOQiKVvhDbyTHGIMDlz8ce1yzzmbkJ2leBj
         7zOludtaIlCxGFvcMrP5nbtAoe1aFqMaxK5npR0beMPgpugPc444p969Wf7NiwfpO0Xe
         yEIKr3CWAGLRfnJFCr/ht7jIQX5WegYNY+oAr+1k7w+bKbcWhufLBe+UI5nqN+ahhnAO
         B9inE/CAiwz4YprIT1Aq74E0rdjoa10Twd+n9F6xl4RewxPHmZKROzW1fZkYgx32OILo
         L+I71J71a3VZJQdzhynaJkwxsCv53JKqDzHMiALE/exLoXypPT34azhcyZqFFalbZZPx
         zTLw==
X-Forwarded-Encrypted: i=1; AJvYcCVyn+cN4F0LhM+pcyfIBlkFUBG0sVqOFbBa0a9OGujRsWIQ9GZIfyfHZZ7UtTK0vk25b+u89+jXyf6+obc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5m0+6x5xO+FC3Q0i9t6qamWp3I/YZa0u0EDuNwrusd7p5Lpe
	kKnyFSnT1r9q9rDb/p1Ey+5VPZ9vz0Ds1X4rjZgHu3g99ZM7zs6bm7mRVC7T1j1+Ic8BtYR3v9l
	amzEKI6is8WouO7WDwfc3qTBU5NQqAEEUyYQtrSvtfTqiZZ3QixRN8ukQUGs=
X-Google-Smtp-Source: AGHT+IG1coevK4BPflUC3vJfg3mRNLVwz6bIIweWGs6nW994OKtQhlFQDvA5RRrv/tDtocb6ctTseJaAcH45ebW8YHSROsp0rn+s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:3ed:6cee:f83d with SMTP id
 e9e14a558f8ab-3f4019f6bd1mr126599275ab.20.1756713541938; Mon, 01 Sep 2025
 00:59:01 -0700 (PDT)
Date: Mon, 01 Sep 2025 00:59:01 -0700
In-Reply-To: <00000000000091e466061cee5be7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b55245.050a0220.3db4df.01bc.GAE@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in deactivate_super (3)
From: syzbot <syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, dave@stgolabs.net, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org, 
	shaggy@kernel.org, slava@dubeyko.com, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5b67d43976828dea2394eae2556b369bb7a61f64
Author: Davidlohr Bueso <dave@stgolabs.net>
Date:   Fri Apr 18 01:59:17 2025 +0000

    fs/buffer: use sleeping version of __find_get_block()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101ba1f0580000
start commit:   c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121ba1f0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=141ba1f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
dashboard link: https://syzkaller.appspot.com/bug?extid=cba6270878c89ed64a2d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10857a62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f5ce34580000

Reported-by: syzbot+cba6270878c89ed64a2d@syzkaller.appspotmail.com
Fixes: 5b67d4397682 ("fs/buffer: use sleeping version of __find_get_block()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

