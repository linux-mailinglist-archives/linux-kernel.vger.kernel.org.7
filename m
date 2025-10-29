Return-Path: <linux-kernel+bounces-877306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D197C1DC51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB96189D7C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF33254A8;
	Wed, 29 Oct 2025 23:47:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292EF32142D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761781625; cv=none; b=vGJ9qLlKojLfT/T3G//UpPOT9nDtJxutgED/n8dRYxWAaMREBsnqZJsUCtvYeTx4MMQG/9SPFNL8yFy8LbH38W2GfBORpCSmR9k7egghansehncX3VDv8Kq9w+GthtG7qI+dMXRS6YfiU5CEm04K9I2PpEyu24rLenzGXnDmbYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761781625; c=relaxed/simple;
	bh=nfRxFHm+9TZ0tLP/v5TW7uTT0F58CAooDqfltg0GWks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eonHW03bnliK9hduL7Iz5gUXGQlixk8KVKbKar4/2fNa0sUoZ32Yc+mEyfvbFGQrrtlYhXPBtM9r/V9kKDsJq/A5hpKQ/8VG2r1pvgUUlioWufr+clc1IMUlXN5PemHzzrexB3C6m9S8ckg/CA1B6UXr1F1KFaBNy/pkbL02s30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-431d84fdb91so10748015ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761781623; x=1762386423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4ohgP/kWGAWCgLzkRSuXf2G22n9q/x2vsu6I4BIXPo=;
        b=mLK4KVO/6RBo8zNmWTd2DMlsyoimQ/yleehk+8Ex12xg2+2UueyoEJAOrIoZa6mXF9
         OjC4oxKjuAhC/63txhheTUmEHpwFmaH+bwGWjIMOYlfG0KCdnW0BFcf1nbJoJnCynRuk
         W4F54tExJ/OEppcNPzmxsLqeo+RHI/ezgzrhR0b2dJcEHqvMiGFgtsISEb8bHq3HV+Vg
         TSrKyXkpZjwcrIBL3dPpZjPVIgfAAGwVdHoB+gzJ7/J3DqSRUkF2Dl9ubYVVSWYxPcp+
         pTrThPLQXZ4Xesd0VFOa5QtgYl4goewnMUtWeJBFgQpBuE0CZbuUpRFgYhWRO29FoHqY
         gX4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHgWxlWQCvmminr6Q/qVVWHTmyh+NJ8bPc+b2B3KDPe5rsy3rRa/Z2XY+fGUaq+lLCg31tudp6tIGzfMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzVbhFOgULCj/bGR6XQzqtYUG1fYtRyBhYs2P6590KsLSfxRZ2
	tVZp7qFHY1Eb7J1x23vopCiwSJbWbZvEGful15PXmCpHtz9VfsJudl8sjBBqsT/t26BYeqUKSoJ
	p5MyzA3a7ikAfIJZ/HZoVVlaQ4orXdksyc9gxiqkcBxYslIvqp0c2OojCOCQ=
X-Google-Smtp-Source: AGHT+IFlCtKkoBjZVCQ14rcVAEaGC/TrYlK+5JUYeN/+dO89IWGnuhYs+O+4fqOSCTTYeLZC/DzdXHtz4yGtPGLjzHDaINa1Tnje
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3486:b0:432:f835:2584 with SMTP id
 e9e14a558f8ab-432f8f871b3mr64356975ab.1.1761781623296; Wed, 29 Oct 2025
 16:47:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 16:47:03 -0700
In-Reply-To: <69015bf1.050a0220.3344a1.03f8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6902a777.a70a0220.5b2ed.0015.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ntfs_fill_super (2)
From: syzbot <syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anmuxixixi@gmail.com, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 02f312754c873efe076888a2fdca982e56617929
Author: YangWen <anmuxixixi@gmail.com>
Date:   Wed Sep 10 15:17:08 2025 +0000

    ntfs3: fix use-after-free of sbi->options in cmp_fnames

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11825f34580000
start commit:   f7d2388eeec2 Add linux-next specific files for 20251028
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13825f34580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15825f34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecdce5bceba74f
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6c1eda2eff0745b028
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116e6704580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11198fe2580000

Reported-by: syzbot+2e6c1eda2eff0745b028@syzkaller.appspotmail.com
Fixes: 02f312754c87 ("ntfs3: fix use-after-free of sbi->options in cmp_fnames")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

