Return-Path: <linux-kernel+bounces-786104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7045EB3550A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7921770DA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41D2F6578;
	Tue, 26 Aug 2025 07:13:36 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E90F155322
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192415; cv=none; b=kXdAPr0uSrEIyRhFxbjcfbvVmqkkOL1T654WJ/xfLC911Kec6n8vjrf9uDz5F5RFguPvOw6LhKw93nQUpM69X7sYosHFg/1kEsv9chdffgr09+7WGELemgJCo/YGm0CKDeLMJv5Xg/XxW6COtLzS+VaDvMfk9qrqkPR5Dq6N7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192415; c=relaxed/simple;
	bh=e4+LN9VJ/FvXPbGXSjCrXOaZtrPB81yZlLjDGr42tfg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u1RJD6BoU7nNOO3HbeoMU8FL+uYodi9fzS/+Rve9xO+VaaiHolB/8qqCnMZsGjPhFeluU43IGcCepsx3S+HDp/ucMcT9Y4xdTegc4q2zLGwskUpfx8WCuNcDoyiu0/2ncvcui8dJcvz44vqIUgEgSdlVFTnl6EZLQx6B1LotAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eea931c037so14060365ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192413; x=1756797213;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OwtFk3OBEqmOdFmpz6iENBLxP923nbiGy1Q2vgm/Aso=;
        b=ATmAnjVCR0w3cm1Kg7hixOcf2lLPryMltsvxfNeVa2bDJ8Wf6go/suNr1A634f9SDk
         BdYA4HhfXScwNNr2fM/jZhNu21I4VWaXVdJtwhhozyNALaZXLDiR1xQypB/UySBaXV1i
         i0mKgAkIeT163yNgis9vLvu/f0YvjRTMAeLpvpGW+lBPTqHI6Bq5dm0+Quiu8M9tEp/X
         /aC3oKU99+utRzrLGipDEzQzAVsxXKfQ0ECxHdyy5Ll1j/ts3IPmf4K2Obf+LXK7yxFc
         88qw0H9I73vK0Mq5FW8ENEXob81E5RoAu4WCh/73IuD6Zn4kS3ndqb0UJbtMu73fuTBO
         JFSg==
X-Forwarded-Encrypted: i=1; AJvYcCVTvasG5SGlpbZ5ZozTi4CVjiN5bGizNqObY9l6mQ/ShmjAKYkeT6BFfqHuiQoZZK5XHV876dxZW/jOKos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWHEMuHOFgqNDinkGtrhJvl1L09vAxI2SUhckq2JtHNQ6tWYBO
	j6HXe1s/epFfCsidjS7agxXdAZnLq0C4mhNDsS0orsXbVcbWl6WXH/yshbFKsE76jCrbNTlt6AJ
	rEEVAb0Sm6OZBwSUTEEFY4GHK7Vo+pah3XzWfTPz8PWixL2KyAoCz6PByHVA=
X-Google-Smtp-Source: AGHT+IGX1ebrSxEjq825kfMpN9f16FdGDQBuyHxdo9Y3GMv4umkBvCfO6w7U6yk3DRcV3gAfkU0UKioHoLfwxwwaKTfZ6WD+fae2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3ee:66f4:a8c with SMTP id
 e9e14a558f8ab-3ee66f40bcdmr35154665ab.6.1756192413301; Tue, 26 Aug 2025
 00:13:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:13:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5e9d.050a0220.37038e.00ad.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Aug 2025)
From: syzbot <syzbot+list55f13d56985d7df20cbc@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 7 new issues were detected and 1 were fixed.
In total, 40 issues are still open and 224 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4006    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<2>  1442    Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<3>  758     Yes   kernel BUG in bch2_quota_check_limit
                   https://syzkaller.appspot.com/bug?extid=8364d1e040a88ed5657d
<4>  483     Yes   WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<5>  369     Yes   WARNING in __bch2_truncate_folio
                   https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b
<6>  292     Yes   INFO: task hung in bch2_fs_read_only
                   https://syzkaller.appspot.com/bug?extid=c7aacacf99dcfd3475a7
<7>  241     Yes   WARNING in bch2_alloc_sectors_start_trans
                   https://syzkaller.appspot.com/bug?extid=23573dac1278bb26916d
<8>  125     Yes   general protection fault in put_pwq_unlocked (2)
                   https://syzkaller.appspot.com/bug?extid=aa930d41d2f32904c5da
<9>  120     Yes   kernel BUG in __bch2_trans_commit (3)
                   https://syzkaller.appspot.com/bug?extid=b6ef9edaba01d5b4e43f
<10> 69      Yes   KMSAN: uninit-value in LZ4_decompress_safe_partial
                   https://syzkaller.appspot.com/bug?extid=3c88ea590c13f5f92152

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

