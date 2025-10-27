Return-Path: <linux-kernel+bounces-870867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E341AC0BDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24EF3BC0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216F2D77E3;
	Mon, 27 Oct 2025 05:54:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9462D4B71
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544475; cv=none; b=JjWAAhkFXV5/wp1qJXmtKJxs76yk/GbMXtxmfwf5c4Ry+MFCohvVDFL1hQvhmke7nW+0nlejQ18OeBgt15JNAx4CEdTcKHlhTm0sPjPjZOSu3539p2N6aeLKAe4yr9KHHwZZRqMQqsAdF2f8iTPd2b1WTvp0FplWDqs33QxjXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544475; c=relaxed/simple;
	bh=+FXJ1mNHayUl1UXm4PfVW7u9O0w1zItt9AcmsoI71hQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pLlJbEw474kVpc/UXJCqeuMVuSuaojFIJm9nZYy8V9YyaJCHooxMojovV9cZ+cEJu/hEo3wGQuWfF0pfBvxsHzddE12+6GZ7k9ocwDmp0kZJkRNBk6HIZOQV/HE9YXpTdU2d4R5aS2qEkxVf7scfehkWm9imo5Ml4JszsP95ROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d0cf9b85so172319905ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544472; x=1762149272;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QqdGyCg0oq3/m1WbNEFikel3sZ+B8S0et7KY38/GQkI=;
        b=b7J2FoWd5PKvt9UaMnDVcrvYeKiCfqwDIQCxwiVo1WSXslDsHzoHmwOblhbJRdOKQA
         hURdqt/mT7YsZpGI+SFTWXkirexTE5ZV9bRRjallW+xsmny/zw49BruoBHcouQLrbHRX
         kB0bfPtq0Koq8bQRybvPbWtM1ubKIOl38FSj8wnnsmhaWxaORWSmveLY+Vt9n81cJ4+k
         bJ1bBGN643RTTDDI233NMefmixaWhERUZEtfBioDU+RsRkJrIS0vJ676cM8LoXe3N7zY
         7loInCyAYU9QGKJF6kqpL5k3tJ8Oj0rn7npdaLVNmxtpBhFtA/+HkZV65clm+0d+z+UW
         LcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzQinKPgnGaUXpY6kxOv970oU53Mic1yNviGXMCfgYyDdX1Zl5M/9FrI2SRfauSdykzRNoB70pcTFLC6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+5YtB0s9eTOVL9qVYOsR1mVDBjz/xEb5qIiLfJfoVbBTRnez
	OpSVBtqS9ohbJuYRRpfRUELalis6Qa7nEfD7GKl41bCB7uCNs7zV731wnxMRXaLfpGZacByf5Yq
	XLvDwKCnxTiylUsbncO7c+PcQ8SMzgcR3cYNRY8N978ECtjUnGo1OBWfWkPU=
X-Google-Smtp-Source: AGHT+IHbDXs4+j5PZo+jsU1Z/67z7lyxmFJnOcDUy26n8NFoeQJsLfx0/deMBOiG6/lVra5buqr6r9O3mVXQb4VzzckVMrhi9XqN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:268a:b0:430:ac49:b3b1 with SMTP id
 e9e14a558f8ab-431ebee1c2amr159659995ab.12.1761544472677; Sun, 26 Oct 2025
 22:54:32 -0700 (PDT)
Date: Sun, 26 Oct 2025 22:54:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff0918.050a0220.3344a1.0288.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Oct 2025)
From: syzbot <syzbot+list958732057695567d6dd0@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 92 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  44172   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  7533    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  3609    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  2145    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<5>  825     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<6>  378     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<7>  352     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692
<8>  315     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<9>  126     No    BUG: corrupted list in hci_cmd_sync_dequeue_once
                   https://syzkaller.appspot.com/bug?extid=5250d87dea2afdb718a5
<10> 101     Yes   WARNING in hci_recv_frame
                   https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

