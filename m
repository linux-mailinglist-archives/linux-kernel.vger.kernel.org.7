Return-Path: <linux-kernel+bounces-860766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D1BBF0E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ABA188367D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE71730148E;
	Mon, 20 Oct 2025 11:38:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D465F2FD1D6
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960311; cv=none; b=nDPL8w/pf/NfnDDEKK5DdcCSievQb6DH8oyWHc4ODRxkfv4Sr/CVVym49lbzhG8VB3SQ4TW6FGVyUGzllGS749Lnqyp3oC8jeOHGhhRbGxVun6gldmQpv39FPOFwgpUTZnXOLWhK4YEaUMTC0fJlcZPvy3n7ix4jwTKtUN+nruE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960311; c=relaxed/simple;
	bh=UZ/VKJ+pN2yig+GvLBIqSb6Ut6P9Eohn0TODs04PIH4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mp9AUBbOxCgXKeJ7eU/BjSOEIfPk4oHJY8uw7vYu0gPory0M2NsgLgZy162cEcUHz2p6yTl0SWE4gBaXeDjZMwXrd1FRBJVkXOqmrlgBm6kUt8YNZ0pIVFGRZv3tABoHVYbLvjAENeRdZAGyjeQbU+84A/RD7GdRFq4IZTaQPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8d8d2617so169739439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760960309; x=1761565109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgb7OtlYnMQoM90V6NabwiO23RskwmJJ0h2MWLGQTV4=;
        b=Vcr5cJKG2XZ/tEyIrEQUpgm9xC65Ft9S6RliIL6O/q9woSDfgaeFMWvJdE8kkcfIvB
         Fze/wtPeyOohs4PLdQCWrOoTAel/Ki3Ihwt3hST/bmYinqBCXPWC8OUMJwVNnWdn1VXG
         LnujkC12TbiZW6kFh6/XyPnQEjdHTSjxArgTTpbkKLLsbb9SkQtWkiMOfxzu1Pngd/0k
         1p0Laae6oELgYjANbMPtBJ7bfRY5Jd/9zub5EV/A4FvnaXBebzG4vFdR9+sb5QJNosrc
         UqCLUH5rjj+SK+LN9IN7FQ/2blCjH5WNB12/a8mdFCvm0oj0Iy705zwFKKnlTtHlk1Ck
         JFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBdo80kQEG1641C0JtjZuezWHvjtNoI8eqK4SR+W805PPYkjfiwYTO5QmRGKLiK6P8CWueTKhk4QoEKlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKpermBpmIFo0teSGYX2JwiELvUSkBnyaYpmumrpXpxXVAvbfZ
	mL/wsEktKrgSK5UmBzRhvWkZRd+a54soMcIAQ2cCf9zZFyc/rPnb0hWzLsmV5CwY8fARAOV9ozz
	hK0/b475nUkqpncbjSyE5tLQIfkQ5T3yGqxJnsqg7i6tsd9F5wYsnXiSLcbc=
X-Google-Smtp-Source: AGHT+IGNhxcWHTK2o061+zSJWgTbgedgGJQ7DlHF5OInK8gPKeca53b3HERWWsC4cASlO1Uxc3OLuvUzSLuQO4RTeyYNoL1bv51g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c5:b0:883:fc4a:ea55 with SMTP id
 ca18e2360f4ac-93e75321bc7mr2257904739f.3.1760960309088; Mon, 20 Oct 2025
 04:38:29 -0700 (PDT)
Date: Mon, 20 Oct 2025 04:38:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f61f35.a70a0220.205af.0031.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Oct 2025)
From: syzbot <syzbot+listefd84cff8486e6c23cb2@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 0 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 46      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<2> 39      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
<3> 35      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

