Return-Path: <linux-kernel+bounces-816184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3EFB570AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0F2189CA7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 06:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270BD2C029B;
	Mon, 15 Sep 2025 06:54:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFC214236
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919268; cv=none; b=DYTx0YUtqzT56mlr4L5JB7FGoipLdUsYvRkJR+5bn3mzGXAJYIG+SGTa9miqkuacuFDyy6kL/kglleUS8snkctdWB2qhPJmOAG/9bqN1fI/koOdhcuqvWpfKetS3UhxukU97BPTgnj7ArVMpZGO/++SXcEfoC0wMFxXiadgikEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919268; c=relaxed/simple;
	bh=XaQN2H2S1QXnTApPXoJ73KHsBZ1my6NmAZ6S5+6LBX4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JocExMYUKDMhvnCcV+lytHuzQMMlH3w7DLaucesZiqesM7sAR7agmvpe7XQCRV+6XbX8py0YG/uiDAK0kKIy8nKU5rQJE3BMCucUb1jeNVpD2/cu67PBXTyCZ2XPQWVDTAC2RcMEVPhTsX/mteuy3nMo46yAd25OaJ0WOSj8jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4240926dcd1so2699655ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 23:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757919266; x=1758524066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35LddoAycIkIJZ4G8fPfZLybSwKCAwTcTKRvI9msLyU=;
        b=LQ54yQNnRyrrr04VfnzFk4Tg8JGL6mRUr3/6ThlwFlYa5aUbED57TflnQEBm4N2QA5
         5ot7u9K25z+Y/iHA/lA0UIVfRtc8PB6bxn/MnrJaiFbQMSKFucv8wtysw582PYeesPv+
         TKxqw39PXfUvi0kQaU9J1lhX/PQWY6er2gJkfW0NG73BibTY0reygFc82SUIMWnGWPkT
         i3bYZyMxt2WP2IyLH1dcOhvbDrCLShK4ZOzm01IQe9DDf4F6IDQaSJoIrLsUTa5yqTXC
         ejnOW0PGuKFN8DfpjCzGliZsQ1AiPmrF4epaRqL+vRqVK6HpuexX6i/seeUyhAAX/vl7
         RSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEM+apekYpiFbEISEDwKjpjyxpcwEd31LtAIPtahlCECFdzvd8U4y6xMuJwJcXqd3EqBudW0ikd3NI1aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuAk6fWLDCv9lv75bs976kD2IdTdXH8t54y7Hwu0MtPPVEPv2D
	+xtsHAWG1LJzdJr2qajtpdv0fpXVdPvIA8FulKUoog7uGkExlP9lQltqwJ0Km5+nmNkXXAgXzXm
	zDdeGJId664Sh/KseLZASHwnlmVGb6hQf6DUQMNKndYIZkv4Tlc3SqfT+o68=
X-Google-Smtp-Source: AGHT+IFHakhglgBdRFJAguj1OsNcIE95IWTf4beEOqdjTQsvoyVjXcsmP8JT7HeWoVQKVtp0lKMC6DKkvZL2PgiPBgxP9s4ExS9R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4e:0:b0:423:fc5f:cad3 with SMTP id
 e9e14a558f8ab-423fc5fcdf6mr38125945ab.17.1757919266545; Sun, 14 Sep 2025
 23:54:26 -0700 (PDT)
Date: Sun, 14 Sep 2025 23:54:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c7b822.050a0220.2ff435.038c.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Sep 2025)
From: syzbot <syzbot+listca0112af71376217520a@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 3 new issues were detected and 0 were fixed.
In total, 29 issues are still open and 39 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  546     Yes   INFO: task hung in __gfs2_lookup
                   https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<2>  445     Yes   WARNING in vfs_setxattr (3)
                   https://syzkaller.appspot.com/bug?extid=5ce48a14916462cec450
<3>  374     Yes   KASAN: stack-out-of-bounds Read in gfs2_dump_glock
                   https://syzkaller.appspot.com/bug?extid=7efd59a5a532c57037e6
<4>  339     No    kernel BUG in __gfs2_glock_put (2)
                   https://syzkaller.appspot.com/bug?extid=ef4ad020dc976d178975
<5>  188     Yes   WARNING in do_mknodat (3)
                   https://syzkaller.appspot.com/bug?extid=0cee785b798102696a4b
<6>  68      Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                   https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<7>  61      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                   https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<8>  58      No    WARNING in gfs2_put_super
                   https://syzkaller.appspot.com/bug?extid=56182be23469e01affbc
<9>  39      Yes   kernel BUG in do_qc
                   https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<10> 35      Yes   kernel BUG in qd_put (3)
                   https://syzkaller.appspot.com/bug?extid=0423714c06c369318794

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

