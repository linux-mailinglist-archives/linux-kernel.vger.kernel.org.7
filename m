Return-Path: <linux-kernel+bounces-584768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F60A78B34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 11:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AF3188EEA7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E792356A8;
	Wed,  2 Apr 2025 09:38:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7B2356A6
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743586705; cv=none; b=ZKJbOIPxlfSm9Ng6XuqkXodfI6J/Vy6DfSNlnd0hawUzD30/dZWRC9D9gb2+Okzc66E+KMcaUajFuZveeKKl6lePW0nwyvYMW9nsbYAFpH02ddltGgC/H8o97wpYwA/IW+oS/UO0v2Hxk59DN1uKehN6XSuNJNgAmnHgQfc8ef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743586705; c=relaxed/simple;
	bh=TxOdn7zfMJ1G4ABuFDhrvNKGIFsxHeCl5qtcdIukllg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ETGtwnI3DaOwLeHAsnnWVkiSHtucPS2WW5W6BKre8UwvnX8k7OconCga85VzLXzrrGOpqp5XHzMjMz6re+IqeX33spbDXTgMa4853s0F+cnWD6wKvCSIm2iHTrGa2VfHEnRa+KGGpuE3dtgzbUchgrzed398ggNoVdfOWcQ94CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d43d1df18bso70541835ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 02:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743586703; x=1744191503;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFAFcDdeatsk0rIUEwRZMxS5vX6WVqCabbcWXMXHWEc=;
        b=wWIvYfSjfOQkuyEYY/BTfaYoh8dZfxIO8zVpDTfVtbF56sMq7uDABWDh15tnS+iqLZ
         umMKpbP25mODCSwJWNECPBq7lv3k/hhgiPQ8/5YK20TL+eUObgF3Js3oh9OjWj2oe8vP
         ED4OQH8DC8ZrzcS7eB9FHgItsy7az9zOhEicFwVuNuF0nXjlyiMAI+l+6pTJqt6I68Qa
         lkyaal3q+hxn8GNmREjzPfIi6EZA4bzxeWDYkbkf5lgjVE1BHyUQy6PB2JItAbQDEpWy
         HV0YQwfd8gLQXjyrT6AG2v9R8tQIHw3PVduZZo4ItD0nDwJgCs1YRG/zPNfNBVIpwZis
         H59w==
X-Forwarded-Encrypted: i=1; AJvYcCV+60Rx6Qfg7dwxZLGdpz7v6hCkC7Y4d5Vz/8DKiuPxkFlpc07FqcTdaH0IZ5JXaEByFAELICtkworqM+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNwJ5z5dcVnfM/fJGUt/fKQfonrHFAmu8LYzJ35usr+W+jMCa
	InIJZjqzr3owkWiOS6Pnuh2n0z+xmUa0gpm5qiU68eykSjM1B4dDV3yIaO6V8x5+WqiIMnPRxrN
	qlUMhfousMHKTA0MyAMkvY7Y7jZfBgDKdmag91btS8GKF4yLFsZkT1gQ=
X-Google-Smtp-Source: AGHT+IHLCNtKlZQUNTx1aPxdQlS77LFaF4uvBLk2+xCqBEWq6nfh5H96ofCOufzihjvGjl+6za0RD++QASHqV6IexKQvbxHiUiWm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152e:b0:3d2:6768:c4fa with SMTP id
 e9e14a558f8ab-3d5e09fdbf6mr170165725ab.21.1743586703538; Wed, 02 Apr 2025
 02:38:23 -0700 (PDT)
Date: Wed, 02 Apr 2025 02:38:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ed058f.050a0220.31979b.0040.GAE@google.com>
Subject: [syzbot] Monthly kvm report (Apr 2025)
From: syzbot <syzbot+list005eb7ef44f63424b8ba@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 129 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 323     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 147     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<3> 6       Yes   WARNING in vcpu_run
                  https://syzkaller.appspot.com/bug?extid=1522459a74d26b0ac33a

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

