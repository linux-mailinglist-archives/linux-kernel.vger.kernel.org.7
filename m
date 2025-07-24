Return-Path: <linux-kernel+bounces-743988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DAFB1069C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8722D189C475
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453C241664;
	Thu, 24 Jul 2025 09:32:43 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10E23D2B5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349563; cv=none; b=eMgJyx2NCjX0VIzxa6ggWss46hBNOxiO4E4vaCakiiE0c2p+r1rCWSzVn7+oSZORz71EsP4WZys7uNYIShC8QAgMjcMHt1AtBT0Czhl2AQTD01gFYx9+jjo8etY9rYJzxPpTdQ6v+IekV+h3LyW2aTDvhLSkvdkIVwjbm70OR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349563; c=relaxed/simple;
	bh=pDmxqXkgtT077gBGUWCuGFnsjfQ7B4vJdQKb1n8lMm0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=av9rvuZhU6LHaeG1/eXjbu4nFzCZWepr+UWv8wd9mBgOm7XBvDJJtjslsk/eYm4LVjaFgPUKhKcOlFUYrbQz1eUPq+q+ETSAISu3TmwZ8W5mUDQvBeWIWx009CYT8QHqLliwIjnyu23H3gtpuU1bQcMMZ4AQhmOhmL0mY0He1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8760733a107so93952039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 02:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349561; x=1753954361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnLt7OL5FV5Gnqj6M/9QGNu9DnfrjRfhT5iMthmB2UU=;
        b=dVt8sDljPsdMsBsxZs2WbKRd5ctJiDnIdznOj/LXt8xd/MX9KkiFOIo65Y0jsnnE8d
         M1aOrNgZZMBVsMKyR3hhYGOdS1ujcY6Nz9BrzMfHJF34VMFwsiBED9Vl4IY6fDTkI8Ux
         ZgBZQxIvIBNfROb6LZwIcB5K9neTGj496zrqd8EPWk03VGzTxjRBwR4Y3YfV11opzatU
         J7Hl9745cIvXYw7cLfxGPXQ7d97TA/Mf+IeV/un64N2gLZa1eJtIx8TqsyTb2qcL/B3p
         lwz8L+PlirM3n1/ZSEWjxRWt72QNXe4NcH7rrNxqMVLvIy9dcn1Ksb0nXSGT3pndqUhW
         yLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUBND3ul65tRFrlauWNMurDijEbPP4hW+DiBwSo2/06InC9nojEPiAImkjaNDWz+Sg1bhqK/FSTlkXDweA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYD0OHNVangmudbEhT34S3oTki0Zm8HcdmW31Sd+X5d+MF5ar5
	BLokTmPoAC84bdHVg9r13oecFqIyh/MlpHFU2vHURHBke6/GGng4Fw/I1Vv/3quDOD4S+vp8Ee0
	Doee53gsMO8e0WhqNqfJzkxDb4vTnJFq/5BdsH3bQCWaMR4uwrBEFHA+lV2E=
X-Google-Smtp-Source: AGHT+IHYlaxdRTp97vlTVOLPj4bENCS9v3pmbcFIG51NoHWmxkI/XgOTVCjdtyx0GNY+IiSwG/pdU3BaO6Bpuuj66sJYTLElBXoD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d2:b0:861:6f49:626 with SMTP id
 ca18e2360f4ac-87c64f937b3mr1253977039f.6.1753349560831; Thu, 24 Jul 2025
 02:32:40 -0700 (PDT)
Date: Thu, 24 Jul 2025 02:32:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881fdb8.a00a0220.2f88df.001a.GAE@google.com>
Subject: [syzbot] Monthly bluetooth report (Jul 2025)
From: syzbot <syzbot+list4602750c76f9f394cfea@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 4 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 83 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  41759   Yes   KASAN: slab-use-after-free Read in l2cap_unregister_user
                   https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
<2>  7143    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<3>  3022    Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<4>  1093    Yes   general protection fault in h5_recv
                   https://syzkaller.appspot.com/bug?extid=b5691bb559396b262064
<5>  578     Yes   general protection fault in bcsp_recv
                   https://syzkaller.appspot.com/bug?extid=4ed6852d4da4606c93da
<6>  570     Yes   WARNING in hci_conn_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=fc4b5b2477d4ca272907
<7>  363     Yes   KASAN: slab-use-after-free Read in force_devcd_write
                   https://syzkaller.appspot.com/bug?extid=bc71245e56f06e3127b7
<8>  314     Yes   WARNING: ODEBUG bug in hci_release_dev (2)
                   https://syzkaller.appspot.com/bug?extid=b170dbf55520ebf5969a
<9>  282     No    WARNING in l2cap_chan_del
                   https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
<10> 206     Yes   possible deadlock in l2cap_conn_del
                   https://syzkaller.appspot.com/bug?extid=b71bb48c13bf3fed3692

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

