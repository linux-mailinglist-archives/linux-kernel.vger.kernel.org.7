Return-Path: <linux-kernel+bounces-820235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BFAB7C7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11891BC697C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663A6309EE6;
	Wed, 17 Sep 2025 08:29:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8E3093CD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097768; cv=none; b=lzA+Ktga/lKlR5IjU2t1QWYEcG/fPh7++pdXuBnqC/OceDbpJ7jPxvVvF2nmuA8RT939ld6668OzK9gdbJS4LKe2VqoGXY0AE6ewm3iiuLkqoiE1oP3/GgLq/IyMq0Kgbwi+Z8gZz5Z+7OmoTV1CMzf4hDHB44hsSCSAzBsfPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097768; c=relaxed/simple;
	bh=n59laAWVXht+XSJwX+Rx/sSiBmHzbFIhT7eyu/CjkeY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=El7F9ofjlJHQ/YNz+nsEKo3Hl52NJOZeGY4+tkzS4cIaaIWmSdSMW9mQhniDTiDQrUX2Kib17XoKqEi3Swr+KrP2yzH0z1Sgc7sb+C1MhM2+4MuUzF+HaEn0imutb1fT8/D0KHPkDomnykkpkDW/269K0hnObRdJNSar4i8V0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4020e59b735so173058945ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097766; x=1758702566;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2J8GtT+BO7dplocXTbSJWE7GTVxB1AxvhITY82Zhu38=;
        b=WQ3BSdnLSqoqaz/q+qNkWXkrzCPAcqhwPVh0l46y2AZ3YUmjNa0zCgieo+BKkLm6cB
         NMWyXmRB+w/wr/3PoDT3wEddJiFcqiUIjGHopULWJWQPuJ+UyXT3gXc2RlFEdo8qCZ2k
         cJkXMd9yGlfih7ohk9do8cF/X1ac7i27bNLCcdEvmeE1+GriCqg66dNtS5wtemmTFCnm
         TWsDX/e6oVf6qNmRNc9ToqbpwLNRRe/9rtSYhLhRbdDdVY7/sF1vsix92W33wZ8ujDvQ
         suh9fHcPhEU7jjB5P6FqdxnDJuJe7z1r7tI5R5etVutPjLTrBV3Lzfnx6F2GHhR4E4Te
         r7mg==
X-Forwarded-Encrypted: i=1; AJvYcCV3pLyhhxeAcU9YnkkJ83o+30gid1ChMJ6ghF/yLzmFbSCtrcIAvraMfKcQp9+Bm5TtQyPnzQztqaww+oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXEOBz0Whp607UPBn1lPYKGP34O+M5WI5lh14n4+ZmxtFxYu/s
	i153bckndr6F+kijbS99XXn+vcfwM0axzIky0j8USXP3BEfJBztBO7JHdjgae/x9G5RT5eZytVK
	XcK4S+YqoyhFC+sI2FvpZThtgrBRjgS49fzIC6rzf+qUn1NPpKm7zwUFXu70=
X-Google-Smtp-Source: AGHT+IG3kZ/PgMbkZjXiMB1OoMvpiayLLIxDSFGcBjyf/EHLPDkXxRSwkZbtc46UAmaIN7WisPVG1wdEmVR2PIc75EmKZIAVH2kg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3809:b0:404:c21a:466e with SMTP id
 e9e14a558f8ab-4241a528271mr12754805ab.21.1758097765821; Wed, 17 Sep 2025
 01:29:25 -0700 (PDT)
Date: Wed, 17 Sep 2025 01:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ca7165.050a0220.3c6139.0fa0.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Sep 2025)
From: syzbot <syzbot+listc85250626370904755c9@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 2 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 42      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<2> 31      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<3> 4       Yes   WARNING in lowpan_xmit (2)
                  https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
<4> 1       No    KMSAN: uninit-value in crc_ccitt (3)
                  https://syzkaller.appspot.com/bug?extid=29d74bf076f40407a62a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

