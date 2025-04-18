Return-Path: <linux-kernel+bounces-610703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4B3A937EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 15:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2EC4668BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEBA277811;
	Fri, 18 Apr 2025 13:27:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AE826B95E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744982846; cv=none; b=mDyKb4TPufakAAx0Q+5DkwXHxG/jQJ2ekZRfv1KNGFdAgQnSKtfZroNbm+GV8Vw+YqZ1NcH5C8JHM6eH1O93J8c4I/qgK8on6f6Fr1S1MReVBL+spi6FRhvUZ64qQ1Fn8I4Nkmzwrg2qyc8t/9Zxqp9zrliSffOIXwgOFY+vVK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744982846; c=relaxed/simple;
	bh=wu8mSfeIBDO6KqG7W2Vh95W46gAQLgssjJ3cq07VZRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lY0Iao8+zp1P65V62BsBLnGUMKbwM0EYOb/WToJMXkIOyhp/b4nrwIA+D43sEVn5hSnBGl/R/efY7aaAu2YV+jxR/Xlv8J9/j/gysqF8Zxo5e/pPkHuiJkquCi8GEjZuM4zmWPsy4TGlcZZmr9fbxO7q+9B6dz/K3g77sWR3Y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d80ac98803so18414395ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 06:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744982844; x=1745587644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/eyz29Z6M/l4RqhbbbKF7w00kXtBCX6BZPlmNLIfN0=;
        b=Wik4mtUNrAnc94vmmRJ1o5UG4IkjELjLMeN3FK8v1DKa3eA5oKrfIZKbODQz0ogwIk
         8mARjUAXcjd9TGSSKVKHhQf2VBLPlcgzJAqaFEOOHW0MOnt8RwSl4/dsQYJH7AEKuCbk
         5M4Jm6XwwOsKBkPJ11rllL18oceyOTHO6yuYWM5fa94cMgOvOx/eC1SNv7ZlVyQhG9N6
         kxSOPMoVnRhb8QqIjrRF8KJGz0Nvu3Ov6mheuqIuc/dI68IrKTD5BNxCcHqShHt+V7N9
         YHIUFyC+YIAFTfKmacmBqEhaM6gTsIMgPEAK/28PBOWuDMQcezD6sRbA+YbJRfszsnIA
         dg/A==
X-Forwarded-Encrypted: i=1; AJvYcCUpxoZKp6kYATbG8YFE5vnsefnVQ2R9B/T2hQieRcXuLbTMdOPX1Ep1oJ8rC59hgleY0Suzvms6Vb0qFS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNC1Dxwt63DeXH0N5XkDOZKKz1a/T7qWpmWym1e7JdAOGPmrMq
	DUsIXFLV2wQikNplC5h9tHB8qI3L2UWp/lNHA75amPwnTAHhFSiA7cJZ1uW2mjAzqZlGL/fRWcc
	Qouw+9qGFecJ14YOVPV7O8q+9QoJB5yCIBtBw7g2/t4Xd8sSYAjI09io=
X-Google-Smtp-Source: AGHT+IFQ+oKFpqmbd51V+7D1W6AygrNigw2YfTqQkpFMV9oFaIishQvozS3JkHCAgrH40/hL/NP44J6g6+z8lKCb8UkJ35jGQtvr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:3d8:20f0:4026 with SMTP id
 e9e14a558f8ab-3d88ed669e6mr26217775ab.1.1744982844263; Fri, 18 Apr 2025
 06:27:24 -0700 (PDT)
Date: Fri, 18 Apr 2025 06:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6802533c.050a0220.5cdb3.001a.GAE@google.com>
Subject: [syzbot] Monthly afs report (Apr 2025)
From: syzbot <syzbot+listb78bb39892741cb5f049@syzkaller.appspotmail.com>
To: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello afs maintainers/developers,

This is a 31-day syzbot report for the afs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/afs

During the period, 5 new issues were detected and 4 were fixed.
In total, 6 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 430     Yes   KASAN: slab-out-of-bounds Read in afs_proc_addr_prefs_write
                  https://syzkaller.appspot.com/bug?extid=7741f872f3c53385a2e2
<2> 5       Yes   WARNING: ODEBUG bug in delete_node (3)
                  https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
<3> 1       No    KASAN: slab-use-after-free Read in idr_get_free
                  https://syzkaller.appspot.com/bug?extid=9197b322744974667353

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

