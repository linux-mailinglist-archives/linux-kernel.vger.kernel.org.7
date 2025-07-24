Return-Path: <linux-kernel+bounces-743993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59BB106AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9580B0181A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07024677C;
	Thu, 24 Jul 2025 09:33:39 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8523E359
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349619; cv=none; b=U/G1L4kZUeHEWdTaOJf730xtzr8o35IPkOUkimBDR/roPrF3t+D+CWS0wPqoLQjeWvUvIywTlTWtd2LT+wCuK1yHQrUe7zGFpvxdRYlqFgsJHB/B7EY82ueKfKODEiOJmaMCDafiXA+q6KU6AlD0dOYYN3DJJH6sQ0ITMZyuqao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349619; c=relaxed/simple;
	bh=UKfesOOuPIA9GubBSTVMN9w7lPGvn3aLc4Yz9mOsMeQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bexA7hetMPM4IAoftpDnrEBLnBaKwrGSzP1ymwwVGiDf+CvdFAwGS7eITUBXgRdh9W/T/2wqxT2L91nDAEugvb7ZtUgnfaj+iwqw/n07E4PKLtfEroOw3bvI/opGDSMeHfuyELzpe9F+5Q7jU9f9gIKOZJ3fgoUatcWCeXfOjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c18a52977so84163939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349616; x=1753954416;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4U4+eilWZLIR/OsjXgrfitjbR/KaezG5rbYq36k1P8=;
        b=L4F4TUmNcuENv4t9TTmx2kvK3uZO1m9MBz0iBIIyEcdMAqZmbwvEYrvRASZ7+ShzLw
         DYzkIEZgrEwyFdOHHfbeVKA5HvwI3v8NQEvRxGz4bGwVoy01YttT7R/e2v6CqkNnwBUm
         HDzoDwTCNQOyjzXNiPZiVDSdknkprjYmPYOKVftDj1AUsP9HvxnL2TNsSTfc1XrxvRZm
         lMniWIV2bqolDpoYTDk3cGNreUXCd05VmWIsmKsvipVpzA1iPyqwLUVdOUMRafrpBRbS
         sGNPOiW2KK2rmrMvlAh944n3BNBPRS7i/4WNp802jABaS8vcPKcyoHoW55kCxfbtAEE8
         Ng0Q==
X-Gm-Message-State: AOJu0YzTTtd3Q/nqADMHAbwy2LS0GqVKOiSqoUh5LyTyWJ9q3dt7Z6Y2
	XhNyAC2GtUO2eJDFIoI5ZUPOYAhT3SD/tUxlnSBh0zhXINz6MZUfUQcAI7uEAE+e8THf24KkS4n
	g5qU3xRfo0FwRlpY/cYoPeZ3PDF/Z6BKTjScP5Hgm7D8wLoVfeuCmrDuD1Bg=
X-Google-Smtp-Source: AGHT+IFn/iELO/wJ42ZJ+FViGnhUhifqhQo4UMwm1d0U9rUADIxmjymDxiPzGoLaCrVWfZLDrrKmbNQYX3XUd/0POC/wdURIBMl8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a00f:b0:864:9cc7:b847 with SMTP id
 ca18e2360f4ac-87c6506b6e0mr1125814639f.14.1753349615772; Thu, 24 Jul 2025
 02:33:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 02:33:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881fdef.a00a0220.2f88df.001d.GAE@google.com>
Subject: [syzbot] Monthly usb report (Jul 2025)
From: syzbot <syzbot+list8a1228a332b7af6e1f80@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 6 new issues were detected and 4 were fixed.
In total, 87 issues are still open and 387 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  16230   Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<2>  4773    Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<3>  2313    Yes   WARNING in usb_free_urb
                   https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
<4>  1822    Yes   KASAN: use-after-free Read in v4l2_fh_open
                   https://syzkaller.appspot.com/bug?extid=b2391895514ed9ef4a8e
<5>  1393    Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                   https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c
<6>  1304    Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<7>  1196    Yes   possible deadlock in input_inject_event
                   https://syzkaller.appspot.com/bug?extid=79c403850e6816dc39cf
<8>  859     Yes   WARNING in enable_work
                   https://syzkaller.appspot.com/bug?extid=7053fbd8757fecbbe492
<9>  804     Yes   KASAN: slab-out-of-bounds Read in mcp2221_raw_event
                   https://syzkaller.appspot.com/bug?extid=52c1a7d3e5b361ccd346
<10> 730     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

