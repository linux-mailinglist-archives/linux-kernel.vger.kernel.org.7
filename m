Return-Path: <linux-kernel+bounces-688042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ACEADACE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9253B0100
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983B2ECE84;
	Mon, 16 Jun 2025 10:02:31 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E227B501
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 10:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068151; cv=none; b=td7nwicC8CIDmI0cgXA+aFT74zA9/w8FSSkMXyP6jxVXRt+4QSfe2MuaQya+mVcQRJe9M2mNjvYbvr8KaPTQLBt603+cdXs12PMnstCNLEp0pzPVEU/SudJeftF7vOR5VdXeYtT8qrB9o02GvxNsN3aLgHsHA4sgCv17mOG8qyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068151; c=relaxed/simple;
	bh=z9kAnrkpj2GfKxE79pAFRpyJIW6iX5B03w9R6zhT0X4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=esoinSuQFQInAEDZyg47jCqgXcKGevWAxWFmNuNYYrDvLCYmVzCgIcMi24Und78L+2c2kPHTAddjW6K2wi7Lx0sQoX0L6ZXvoZNH8zFgI3jKXnH3pMvOrgXA1P/iRwiim1nIgpAKbSwa/RVMG3+qyhkYoFMUc3grT3W0KW+lTPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86d126265baso385248839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 03:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750068148; x=1750672948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myEXstyGfSAkN+bF6xcG4feR2elJpzxIo3WyiuH/a/Y=;
        b=Rri0tT2De17RlAkZ9x2mqaU5TjPy+xdicbY1QUGrQmDIfiH9VgMeBOEVpoagSZw6yY
         auf8YSaddw4poh7NDeBl01/UJ4f4d5WikIhHhCGsZdOJmbBgwJpTXTLucviXnyRscBgi
         sYuj8hYQq4WYGB9N7t+FjE1LtmVpHtORJhwPQBBARDC795bcP1aML3K9Mk3B1JdlTuyo
         4rqbz5Wii47sRgd/6R19B2ihGJHxBiJr9DiQ8ZSVCipW6lRFI02XW87UKr9ObRbZ5n+8
         PZNJfPscanU0mu8tIttdPTpoPbK5usTVbbBQVzSOv2ly0kO5ULs1ygEI+fDKHXagIyY/
         6Jrg==
X-Forwarded-Encrypted: i=1; AJvYcCVEQg/OsdFLh9gP+VTJh2NxlGPw/IuMApfP+xSXQ6c8zLeeMQpAo+qaH5bfplJIgiJpStFHa+yPxMOf9Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH070+Y1nZygpkUrJifypqWOpG9Tdw+zT7vKs1CHyVKOuysu+N
	+yVeX/rvr55UHg97cnwOOp0vC98bvHufn41lvdN06kP89FFUzVgwz0cSjTnUO2gkRcIWLq9BH6M
	/cajApQPMMQJVlXQY+XHILxSa5mYeWa5IBSx4QXOdsZURJE3nWPgzeF2wo7g=
X-Google-Smtp-Source: AGHT+IE8eiWFRAM5rURp9zmqZHi1FS/z6eQkz4OXZuea06egVDNxYRzDQP1WE/XQ3CLWQbe2r/oGDMBmQW8gq/iCHHdIXhc4axEW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1687:b0:3d9:6cb6:fa52 with SMTP id
 e9e14a558f8ab-3de07d6855emr93274005ab.12.1750068148473; Mon, 16 Jun 2025
 03:02:28 -0700 (PDT)
Date: Mon, 16 Jun 2025 03:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684febb4.a00a0220.c6bd7.0017.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Jun 2025)
From: syzbot <syzbot+list96e7686d3d4357107084@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 1 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 34      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<2> 17      Yes   KMSAN: kernel-infoleak in move_addr_to_user (7)
                  https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
<3> 1       No    KMSAN: uninit-value in ieee802154_max_payload
                  https://syzkaller.appspot.com/bug?extid=fe68c78fbbd3c0ad70ee

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

