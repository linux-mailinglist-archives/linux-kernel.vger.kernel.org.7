Return-Path: <linux-kernel+bounces-809171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBE8B50989
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785DD5620E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C1518E1F;
	Wed, 10 Sep 2025 00:08:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE817BA1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462884; cv=none; b=qHQqK4MSLiG8jJ/L1q3kpbq5SBQkiOWjBRxU/fN9qMHfybYY79IPesYVw2or1naPv5SCRGF/HCkAKPvYewU7o6WgOJ27jHKS6mgHcD4LqYWF7BgdSqCg1FP643C2R7vI6SBC7TPnJ2dJkXMYf6RoC8VHdmo6ubMWO/OgRyJ7W9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462884; c=relaxed/simple;
	bh=Y0FueEj4ovAwS98JIIHmMsJveQ2bjrRXOL6WNpNLJCo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OAHYSAIgcDTLknrdEfi/u3DacfFgm1GNsO0VJrRGTOojiRkvd8Hh6cuaJCjHYcm8dw+9TKEHrc64Hw4AEOcT6tyfrhAtQDMhTBNbrO1vAHG4xg0YJHKoHrnQnJceiz5VhTO6wyBd7LzYfQXB2ytK/8tLd5NqxTtlPhUfXZ+7TpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-40babea9468so34273895ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757462882; x=1758067682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B48eG2pE6UmtGQsdEorhi4Kz49vrL4LIBEaiUoQ1ack=;
        b=C23tQ2FsgYlmS8WwmB9atKCAPbpe4pgGkvRn2SgFvFG9H+zjGWoNk+ZPce2ZsrUOKj
         uPRSJFM/w28yrpvP+2V/lRaP79jIS/50ijeDqyU1gpu35JHMU+YXzrPcmwbDU4eYD9sl
         bZ8TooM9MEOtM31gFM7msxwToC0nwCmJUJu5Lq+iGZbf71Zho/ixfYPJS6ome8zA2G5C
         v8hjBkYRf5+r1Zq5qHfHrfYaFEnj1jTDp1TMh1VGZmXpMY03fCz8GxHvHqm4yJ9pfylf
         NOl7SVeiPP8ZsyqXOFryRDXGAnjHmVlO045KFGq5XaV3GMSlKIA2VJVB01PbROg2Me+e
         vYig==
X-Forwarded-Encrypted: i=1; AJvYcCW4S61U4FxgahzgG4AF91DGcQY/mGoNT81ClswtA4ttsdl/IPa9cn+uYus0w8u01O15a/xN/ehAOUnMQj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzAc1gmbkB2WWn1hOqExQwGNtYa4poT2YgxMNcQ0NfFRa32AZ
	J+2RxsJKJPTSN82MvxpqQiXjyUTlu/L9CiZ7VTzPvr3Tn9mkKhr+bB+1hWv0lz/gMgbHI2FnRiX
	e4SWYlkMw5OENrHHQcG1btjfIKCmCMzcWhcMwzZ4KhuKgyYJw2P/vU7akCEY=
X-Google-Smtp-Source: AGHT+IEc3Xlig2C+ezYLq6Le2Uydz707fZ7kOaTGcnmjiUoX5GndFDgFeAd1y0BFHSGOllVSy39Jjf/rLsye3GnwZSdtWkrgHRNj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3f6:69ec:ea1e with SMTP id
 e9e14a558f8ab-3fd963dc775mr179254695ab.23.1757462882139; Tue, 09 Sep 2025
 17:08:02 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:08:02 -0700
In-Reply-To: <68c09802.050a0220.3c6139.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0c162.050a0220.3c6139.0016.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in clear_inode (4)
From: syzbot <syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c240c87bcd44a1a2375fc8ef8c645d1f1fe76466
Author: Chao Yu <chao@kernel.org>
Date:   Tue May 21 06:23:18 2024 +0000

    f2fs: fix to do sanity check on blocks for inline_data inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17754b12580000
start commit:   f777d1112ee5 Merge tag 'vfs-6.17-rc6.fixes' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f54b12580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f54b12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
dashboard link: https://syzkaller.appspot.com/bug?extid=90266696fe5daacebd35
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a43562580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164dad62580000

Reported-by: syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com
Fixes: c240c87bcd44 ("f2fs: fix to do sanity check on blocks for inline_data inode")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

