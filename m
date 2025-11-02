Return-Path: <linux-kernel+bounces-881640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C5C289E0
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 06:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA95B347ADA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3366F2222B2;
	Sun,  2 Nov 2025 05:39:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B8F20E702
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 05:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762061944; cv=none; b=K0AZa+Vftb7y1rJVW52p+SYmj4dyQkv2Aw8+Nt6L6/Xd4HQqW5WxR2XzOmygDfUEUvu9d+xFKquV7dJ01lsfjwOckEUJ5rPKwllaG4p4QxujaSJy8uizj38+b78xC2MZZEH9Gtdt9fZU0GHHcRqHYzfWmGfSdPkOhVr1D3E7+Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762061944; c=relaxed/simple;
	bh=WImCX7SvTyP9WE4YKYQAr5TtP5ayByld5OhLfhadDPQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DyMVfhPu8ZWqUxhvXZR3dauiCytZYobNdzQFe1JSGsGr/q6oCkJptQw/PI2bWbfPt9sqCUAqfKlAv58ul0AyspRPDeziajhgisrg9ILfGHaHhbSFeeqoXJDRLDUutcDErNgiX0w8QLThY+Xo6eZcGaFDs/tsaoZbFzMNdgEaEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433218d02e4so39580025ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 22:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762061942; x=1762666742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5gofQLv9ATheBLZFs5eVxjk1NYdTx1xDPMzfJ3PQe4=;
        b=a9D+5OKbO4a26qgNxtqjJ0glJR8U3jacJd83yEzSuzHd88pLvyUy0uIgOT73fcCj3x
         XM6B0soY+0aClDzQt+HBPBX+SAc2i2VveTZtr2JPbbdpwg1t3h2heZ1Tie4JReC9BUVG
         bZKlvYzXuNzK4M6wTbym8WdJkJQOv8MFI7Fih7R+iv8khotknX0wklAweomScBYXQ94y
         gWFsYfW10B7QiMhPiDNOa+hvrgjPlymJa6o3mOHofZXbFZN36g05Ei7/9W0c5td9NcDc
         CCi5rgCgmOCqe1qxOT+1lqmI6cg3gpVZ/kv/hnzclkb3AhkGTodWlnmB4EOUfGRuNuCX
         86+A==
X-Forwarded-Encrypted: i=1; AJvYcCW+57yHV+KLETyiCYLcM87sGHLC1Vzpiw0ymnMLPm+/L2A/aBnsuoWJT4MbKMbUgxoJ2uDGQLlUWNsN2k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSCFkwKHLlI28Uym/SQEI6gxANFuVniUDPNQPBr/Be77WEvXGC
	/ikWVAtCMY0JnTl/VzSEaNf7eka/FVP5/4ifvzuNMvtdLyn9T4MUVMQSnxJ5QGfAXEIyrKvof7v
	qJv0Omdi1Ac6Xhs6jO/B94sJ1YQcSjXs7HJN5JAkJnjBmIb6WQpJJch97RaE=
X-Google-Smtp-Source: AGHT+IHCp5x9Csze7ts1+FeJTWPJ23oGo3DuAx7NFNbgLSzgUoEWPJQbXpSqgSY8kC3XvptviGA3Mx7pJPxr111i/n4AQSQen7Gh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4c18:b0:433:2389:e0ad with SMTP id
 e9e14a558f8ab-4332389e21fmr37683605ab.8.1762061942596; Sat, 01 Nov 2025
 22:39:02 -0700 (PDT)
Date: Sat, 01 Nov 2025 22:39:02 -0700
In-Reply-To: <68cc0578.050a0220.28a605.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6906ee76.050a0220.29fc44.0016.GAE@google.com>
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
From: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, jaegeuk@kernel.org, 
	joannelkoong@gmail.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 51311f045375984dabdf8cc523e80d39a4c3dd5a
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Fri Sep 26 00:26:02 2025 +0000

    iomap: track pending read bytes more optimally

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=103a0012580000
start commit:   98bd8b16ae57 Add linux-next specific files for 20251031
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=123a0012580000
console output: https://syzkaller.appspot.com/x/log.txt?x=143a0012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63d09725c93bcc1c
dashboard link: https://syzkaller.appspot.com/bug?extid=3686758660f980b402dc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176fc342580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10403f34580000

Reported-by: syzbot+3686758660f980b402dc@syzkaller.appspotmail.com
Fixes: 51311f045375 ("iomap: track pending read bytes more optimally")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

