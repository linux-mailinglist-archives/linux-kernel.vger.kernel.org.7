Return-Path: <linux-kernel+bounces-729520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB16B037D5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B1B189C2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D3B2356BA;
	Mon, 14 Jul 2025 07:23:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF527233704
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752477816; cv=none; b=fHLAetDpN8WZl28LtPPoADt1Va1DP6jjexeEI6g4RHWpNUHzX6EzNuhj7ghefALtMKBHMUgX4QxflBDRQvLPFzCNU1NxLchDN4sZflA/L58f7JG3X+/wE5a1dZUYhkmOCl0Okzy72j86/50pitwburrM0BcPMomSXx6Wzhu576Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752477816; c=relaxed/simple;
	bh=ayW077Gk2pvt3Hw6dVG5Yg2VKry/Kayw1iHiNu51UC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YKTOJqd0/JRE7HOLhEQgVHJJbGixViyk9XRUWctSWzZm0I0LdCxm3cLDd7d1IFzmMD7N7i4Ui9IZm9KaLDzhExMBx2XUOwLC8B1wwm3qMX15ls0BIywKgIyjgonM5hRkMw/TETMhBVB0X9IgvTV8fcfUw2tp9iWTrkhQIXc8Yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so52201455ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752477814; x=1753082614;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnrSjNkG3/uaXhOO/o2sQgdxidCRv7vVZ1X52wDBqS8=;
        b=wgXfynbhewfS8SXKT2O4sUPCy4RnTSTOoW5JNUWRUWz/PBE6Ss7MWOOCcvlUf5fsn7
         AuiwlAziWnAmTZoKU28DMRGj8MVkMYL7m9j8hXEIwau/jfvjdqMov9WzvyaInGpCjcRQ
         FlvQ1BtZXkZ4VJyFk77nxOqO+BlpaVpUASM5FpfaORo0T4ebY2CTYAMfZ1YU3WciePGf
         m7b+mgQnXT2flwDvEsMtf1YBocwoyhbigrA303jMPxpLeLHsNcKTTGEdlkwIfMCh490k
         SQHnEgD8QU1hKdv4ygraM6MIy8f+OGhy4dcblIr2G5zLVUr2yRk7JKcD815H3dJpEN9c
         Emzw==
X-Forwarded-Encrypted: i=1; AJvYcCXy91DAT+D3URVs/gMu3oslZk7qmY7a2UtA2ch7N+mA8YHHtQ2ePW1HPQ76CGcB+nUcmXUGWP+onn/qNNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpgcjWd1cHGgtbrdM8iSRX0OTb6LSBM3Ir/uHNMlkLrqgvNtOV
	/zdch10E96rSc7wtP662PIJ/FYFMwIU7bH1XrSKNFjZklLIVXT9Cf4bDNx4oKBUbnMAS8fJ8AXP
	nfu2UKmyzmig1Mc1ZFko9D3a1J2pMZFpH7+ZYZ3S6rUT56m4kUITBuKN7ICY=
X-Google-Smtp-Source: AGHT+IGdCHUa+pREzYVT/fJ+UZ5bQW6X7dVgoNVel3kmofbNf92QjDptPa5wKag7BTHjheHNeD9l03cafOladEMcDE89kl8gUKrW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:3de:12ba:7d6c with SMTP id
 e9e14a558f8ab-3e2532799e5mr145101745ab.8.1752477813853; Mon, 14 Jul 2025
 00:23:33 -0700 (PDT)
Date: Mon, 14 Jul 2025 00:23:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6874b075.a70a0220.3b380f.004d.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Jul 2025)
From: syzbot <syzbot+list034a5bbd793492eeb988@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2518    Yes   kernel BUG in gfs2_withdraw
                   https://syzkaller.appspot.com/bug?extid=ed42f17ebcb58526788c
<2>  1392    Yes   kernel BUG in gfs2_glock_nq (2)
                   https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3>  357     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<4>  288     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<5>  98      No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<6>  44      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<7>  41      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc
<8>  32      Yes   WARNING in gfs2_ri_update (2)
                   https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<9>  31      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<10> 29      Yes   INFO: task hung in gfs2_glock_nq
                   https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

