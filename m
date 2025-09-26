Return-Path: <linux-kernel+bounces-833612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A8BA26B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DA61C01D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5F246799;
	Fri, 26 Sep 2025 05:14:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF8E56A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863672; cv=none; b=FKJ1rJ9bPHuZhIuXwI0tb+65hQYV8W+QweuZ6g533nJAwVHncY84A6KugPiviL1Kmah329rQ9aHgfCrrqwDlB5G1E+loBd1gRitdCyxKEPf5ZdV5bv6mcmt23i8YVzy02/wc/nXCmpqXy1XjmPlXp+zJUPEvDcx7gfkIdiE9YkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863672; c=relaxed/simple;
	bh=9wRttYzh/Apy5zLesvQXpOQylmAT3nwzo7gE0t6VrVg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lGupaHDTTQFjCKU1xGADzZGCS0aivwwdH3wAr0oATlDCyVLpyn67kgQThSwt1HXNn8ZH3uE8rnmPpNzTra6XbOSRYKj/zYBVWSak6zQr4gL7x6JdBiy1jzbxoH3fa6e5KvJNfHirMwRcnKWW5Xfby5dLKqQk5E+YDQ1DGcCH8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4256ef4eea3so21845435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758863670; x=1759468470;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hWx7q9CNnmoX39Q0wc2VjUaNCf9+s8bMRA2G0BcSoII=;
        b=apMgv/7CHFYpE9mmIgfnzxDRAB61mWMqHvE4DEf33q2H1lYzf13aS+7Y5QD/FPynjF
         qtIF6Ljru57VydOxv1H45cv0kHE/H3+WhF89h98lUpVp0oOyV95PJZyKbR+4yFNTq8MR
         qDmuUFLtds49bj+doxkQo8/201DqQjHkeHoLvnWSDFw44ghqZxeXEZ9l73auczFF3m+e
         ovM3SyKguAPZhDUJhvWbPGrbikCT/hyJ6IRM54vgvYT/r3wFxAvf6mwGzFuGxdwDYNZU
         FiU/H5oiKctNX+aEjUGQbUPoMfOOgiLSm8KxLSHIzBV95QoL7BkSIIVzuO4TToQmiPGf
         nMRg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXQ0bAnyd1JpouOWXpliFcFrNiZqQmpNoASDOXY0CVHGgdij3tG2oV16rWgZHAaBzDb0rOjbJ6nqS2co=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvYxOLaQOKdHDNylUpSuPfBoMnz22mvHPgoPveWdLM4QM2ZuE
	o+9r9HR34dfBykgueEJd6KEmXbDNLCJl86lHNkZGRb67x1IuvHVSlYJhMqPSv4fd0drrlps9hU0
	/AyK7VkB7aFIWCwMfdZCHMZT+WI3CAc+F/4/dWreFlPSdipsgpquIm5inV2o=
X-Google-Smtp-Source: AGHT+IGjwehvV9wruhqWRtwLbUujGLynWk+PLDvnx9XYNg3xvYkjJ9qQTmw3e/l120MIlAzW06MmTIkSFy/TTzD/etB9hmCkAntK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd89:0:b0:425:79f5:2349 with SMTP id
 e9e14a558f8ab-42595654368mr73166385ab.24.1758863670656; Thu, 25 Sep 2025
 22:14:30 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d62136.050a0220.3390a8.0005.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Sep 2025)
From: syzbot <syzbot+list1de35383332a7562f939@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 14 new issues were detected and 0 were fixed.
In total, 52 issues are still open and 224 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4086    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<2>  1561    Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<3>  793     Yes   kernel BUG in bch2_quota_check_limit
                   https://syzkaller.appspot.com/bug?extid=8364d1e040a88ed5657d
<4>  758     Yes   INFO: task hung in btree_write_buffer_flush_seq
                   https://syzkaller.appspot.com/bug?extid=cf3d1015b55ff73dcdc8
<5>  503     Yes   WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<6>  395     Yes   WARNING in __bch2_truncate_folio
                   https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b
<7>  295     Yes   INFO: task hung in bch2_fs_read_only
                   https://syzkaller.appspot.com/bug?extid=c7aacacf99dcfd3475a7
<8>  293     Yes   WARNING in bch2_alloc_sectors_start_trans
                   https://syzkaller.appspot.com/bug?extid=23573dac1278bb26916d
<9>  288     Yes   kernel BUG in __bch2_trans_commit (3)
                   https://syzkaller.appspot.com/bug?extid=b6ef9edaba01d5b4e43f
<10> 221     Yes   kernel BUG in bch2_btree_path_level_init (4)
                   https://syzkaller.appspot.com/bug?extid=55c84106264e92ea9ada

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

