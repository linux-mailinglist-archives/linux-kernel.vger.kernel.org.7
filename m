Return-Path: <linux-kernel+bounces-772368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E4EB291D5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D3C205A48
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DC214228;
	Sun, 17 Aug 2025 06:18:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31491E491B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755411487; cv=none; b=fPjDdTJD2ttRRVN3JNu34DLT/X64FnHvEGo8qPkZ0sLS7tyN0bzDBfRxLOgq7VZOh/2VMA6Hae22sEvtP6aL/s+LIuC64GNC+Qlka3n1Rhq6+uPlmoO8sb5S1lbpqAmazpIL2exGX5C0auTHqglnoEPpsrgNjzVgpc0EQhfE1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755411487; c=relaxed/simple;
	bh=x6SRgnib0G7M2g+ot+TWQJ8h3Z9ID7PuY1Ye6vQiO7A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lCcdbWbVICL1Y54sVfcK/40iIkCh9gXfldKFYH4OC6vfQVeDe+DC6yLAZJJ24698pK/bgsEauJnN/MD6o8mxZoEpQ3Fcpos0mR1aptIw8PW/wyDyGbaopdSjoTTktCk71NOaL6aRqShFynMQyCCsaIe5vyoYtDavOGGbFMQSkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432d8ddb1so382254539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 23:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755411485; x=1756016285;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdO8zLjvXGnLAKqt2Wo9ucoKrtcFQMjL+W6shvTRwsE=;
        b=p5On85v2hS1rwv4+DnyyvMay7gSyvggc69h+mg3hcZ2SPQgUn6t1AvM5linEXcbNv+
         y6h1ix8y/0pdiQ/zdvzSLXf6r+jFsmlv/HPo7e92zN2VK/lxaMgeFZ4PwVhr1La2jntT
         utNMF7kqwb0tG5iJTZqwIWb/88Ix6+Zo9MApZg0DPwXwUgyJ2gJEHCHeSDvlagI1zaH/
         sRFsPrO5VnldhnbnRL4GGodRNxEt2N1WPjVpmem1z7eYFWWcfW1v7FivTnXoWsy+Hfsn
         qCV4Pf8EPAY+fLwOGwjt8YFktQATcmk2MhkBZ1IiX1fZgj84rYuU3di0/TS5PIS5ef2v
         hhrw==
X-Forwarded-Encrypted: i=1; AJvYcCUMO1GNKwuDXDC5VYKm8+iSgbQE+PF4oACbWl7gJTGOIcQJLiKS7D9IiP4javBOXhd/itFUw1rAmnuE1ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdCbirQvInkQFIOJd/eFSKEzgPdRmsMRyRPFaS2WTjm7yHaQU
	5RyUIumL+385dWIhtJh4BgoTzX5W08k2XT3hhFo1/z9STzCoQ7iC3dgyzzf0cR8b5AYoYh+36fm
	+CmVKGmt3T1MTmDgRmzp92nQYzY/xHRzdMLX983Tmgfj/0IqrZtsVNOKik6E=
X-Google-Smtp-Source: AGHT+IHZFzSwDxf2TRTZM6Le8S0sSkvLrk9hGAeEtwb8V3MPhnIYewVlR7ckO5uIS7XAC1CPsuDIjUd08C4UFZSkM+VjvxP9yYWX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3e5:7e02:a06d with SMTP id
 e9e14a558f8ab-3e57e84b6c4mr127240065ab.4.1755411484903; Sat, 16 Aug 2025
 23:18:04 -0700 (PDT)
Date: Sat, 16 Aug 2025 23:18:04 -0700
In-Reply-To: <689ff66d.050a0220.e29e5.0036.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a1741c.050a0220.e29e5.005d.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in debug_object_active_state
From: syzbot <syzbot+56728135217003dc6f7d@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, davem@davemloft.net, 
	johan.hedberg@gmail.com, kuba@kernel.org, linma@zju.edu.cn, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e305509e678b3a4af2b3cfd410f409f7cdaabb52
Author: Lin Ma <linma@zju.edu.cn>
Date:   Sun May 30 13:37:43 2021 +0000

    Bluetooth: use correct lock to prevent UAF of hdev object

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c6e234580000
start commit:   ee94b00c1a64 Merge tag 'block-6.17-20250815' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c6e234580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c6e234580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=56728135217003dc6f7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118d2234580000

Reported-by: syzbot+56728135217003dc6f7d@syzkaller.appspotmail.com
Fixes: e305509e678b ("Bluetooth: use correct lock to prevent UAF of hdev object")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

