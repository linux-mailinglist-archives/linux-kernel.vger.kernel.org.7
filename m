Return-Path: <linux-kernel+bounces-755574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17962B1A89D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A7118A2F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA428B51F;
	Mon,  4 Aug 2025 17:26:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C9266568
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328367; cv=none; b=RWU1XBB921L+M0Ig8xRqTmplVjH4KdpmcIDz+hxd7oy51Dun1hCEt1wzhTbYDrOCP2qdrTpUWgqkzVQzlbB5irqrUKEORQMaqw3gJU2uns6wpTRm0uky2QF4xrAL40rMyAj2t5+ZB1htd6d20pc49vJ+1MQPFMgvRmFSzjmNW4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328367; c=relaxed/simple;
	bh=Qezuv9NuVZOhWaySQtgzOxHiO1L4SfJn5ghYTPVBw1s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qKghOoaHCb81gp3LmhI3PKAHNBsO0efdihIyL1oDeonK6WoJjEvv8vupZ27Pz7yjxOf2o5gpLgh3q1q2oHTvVjoZCfS2KHJri9jiHq0R8NyP1wnI7mJSXWiuMEmJs8ZcDY2a7W0hZGl298Xebn+uTbXwIO5F/JFFhOJyuIkKsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c306a1b38so246062639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328365; x=1754933165;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGNXSO7IuhXm4UYEUpJyIzcI75ucxzQehTEB7opvPpw=;
        b=tY/cVGlp8XvsDuRLQWmnSLcwkHv0uOh9yNtsYVSSH/z1AoziQqITBHwMk4cThhkDHw
         F7TRdEvzxz7FsZ2CYD5wsUeTh+oRbohbuf1LA50QYCuqbQecsxHle0H90CvcVpTJZFmq
         UNNrvaHSo/NOoY6hrt8S5RL9JXzvdcOg9UjuR1RBhUjXtl1LyO11+AtIyX4nsvVNoNBb
         9c3fUPG0LtEtWNLktfOYTov/8hvccM74UXHW0KAgIopKvUQhkW4Hfm3dwmWAa7QH4Rey
         3vRLkgg5OZhAz4bMK/9dDN97yhAIRlg9xmJbnIYl0OpLQjATGY2JJ8J6fC+FOp8ELE8b
         9n7A==
X-Forwarded-Encrypted: i=1; AJvYcCUqBFvsMUzJSItj75/2JLpctWQcENMH6VrQt6svAgIh15fOePiKMHZOQQ4P2Agt35Q7mXcljYs0jiPkr1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8kukAbE2D4ynLSUH+zLBCo7XueDZ2PZ92X8zlwOG9VCQoteG
	YbGLz5mVF6ToFNQPB8a6Nb9zVZXV2htINQJVgc2YU5orgLRhajuyJTdElvMh2u1MzTjJ2jHs3dU
	YNKe8xdIDncuaRYvYJnDBmjig0HrTQBipn2K4mEJ3hrp7MKmNQYOqmmH6qRo=
X-Google-Smtp-Source: AGHT+IHWWgSdVCva3mVOA0w0tIxfsrZTdnaw0rPAlY9oMSyW/c4V4pnoepcwuBQ4hg/IMmjMvGyhsI5JTGGAPIiHPM5SIYrUpnqT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:85d1:0:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-881683d6ba6mr1589110039f.12.1754328364766; Mon, 04 Aug 2025
 10:26:04 -0700 (PDT)
Date: Mon, 04 Aug 2025 10:26:04 -0700
In-Reply-To: <68905ecc.050a0220.7f033.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6890ed2c.050a0220.1fc43d.0010.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: array-index-out-of-bounds in bch2_accounting_validate
From: syzbot <syzbot+cd063f869beedf5b9cd7@syzkaller.appspotmail.com>
To: bfoster@redhat.com, elver@google.com, justinstitt@google.com, 
	keescook@chromium.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mmpgouride@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 557f8c582a9ba8abe6aa0fd734b6f342af106b26
Author: Kees Cook <keescook@chromium.org>
Date:   Thu Jan 18 23:06:05 2024 +0000

    ubsan: Reintroduce signed overflow sanitizer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=161982f0580000
start commit:   352af6a011d5 Merge tag 'rust-6.17' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=151982f0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=111982f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cae1291240e8962a
dashboard link: https://syzkaller.appspot.com/bug?extid=cd063f869beedf5b9cd7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dcc6a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133e02f0580000

Reported-by: syzbot+cd063f869beedf5b9cd7@syzkaller.appspotmail.com
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

