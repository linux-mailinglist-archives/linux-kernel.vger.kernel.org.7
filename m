Return-Path: <linux-kernel+bounces-745786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C54B11ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 095D7AC79A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EA2EBDE5;
	Fri, 25 Jul 2025 12:39:33 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611A24467F
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447173; cv=none; b=LSO3UXzuYiwV4GXD7ovVSZGFLt3pSqhwMgfyY5lOUyzsO+mobYSylY1zJEfCoHyowndJ3+/iBlBp7dFEjjZrZQaj05/fmdBWNLW7G6FoQFEKvgCcYyymnVBsH66g0e79as1fIR4WvulUiJFsturoYeNDTMrvGUKpp0AZYjrExAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447173; c=relaxed/simple;
	bh=47PWfLsb7WIHOIfZ8N5wd/mezbynrdCOU1Neh7k/pbA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KXaTXos4tuw8RqlKzwTOsZOblA3eoW5BdWsUEMppC7/+qeGjaZVuEw4eAujWmYjaIFYmGaVw7NoUS/iEgZCbzXZZIm2tTK4TcFZ7UIpa1lEe6ZjP2HSIiILIVJYMJztoJbuMzh/zlDKbQKeCykU+uZEMaEmWyZwxYRi8MtWdg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c1d70dabdso222058639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447170; x=1754051970;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43M45r7jDz0F+41JzcKntix5q+AocqyxYgrMo/k6Heg=;
        b=wSKWdX4FfUNxP6w5w/CMpQHJt3QQ1n28AqvX/2GJNPVu7YRjD8Bfghr+XBSlhJr36x
         8ltZfJ4x5/Bu0AmgCTQxCST7ZPPzcJhshO3pnjTu/7jPuHwPemj4LPuY0/gKqwX/cCrt
         z1uoEcwpcUDM0q331ymJFgb2qP6Cadl41JD4d/kXvU3u3hXI2fxffKgPiKuBalnqVRSU
         VvEVktUrj7lx4L8PTp47bhLwR8Ka61Rdp+mC9xaZqUB3sLwmSHDSv2B8VZDO/UkZIK6z
         s1fJaworcR6nUkT4gfmYAN+WW7D8BDc+/XYYUBM4v8XGNvhClBW0AMpcBC+LJU15AAU2
         N5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXhttl1XEhUziVuni/QZrFB0D9B5R3hDaADEjnbU4qKQH4FXDJKDX9Y0ZuqRG88w6PJHYYJZr6REmugYvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDf0yv03bqYY2vQnayWuCWMlxySsyS0V1yMFDHLFC6RWe4Bew
	f15uEj1N8+0XweiwmYED8W/SGSUd7y01ORw3ivhG/DYFPRCCtQG4oUjDdvsAQ4pmYoE5yLNGMUC
	w4gGv9bqyLYJNewebUOD2S0t0ARd/oDg0V/I/6d7rx39Hfz/+7nuIbRsO7LM=
X-Google-Smtp-Source: AGHT+IELeZyn8Oqqw7eA0AUVpj3X4LgKnm1woF6F27PmmpB7spYp+ZYUSAiAnQ/hVNgI4NCtQmd1MPG3uMFN7cHu0QLmULYnXkeV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9c41:0:b0:87c:44ce:248d with SMTP id
 ca18e2360f4ac-8800f1960a1mr213351839f.7.1753447170572; Fri, 25 Jul 2025
 05:39:30 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68837b02.a00a0220.2f88df.004d.GAE@google.com>
Subject: [syzbot] Monthly bcachefs report (Jul 2025)
From: syzbot <syzbot+list2d3cd42628405a68164a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 5 new issues were detected and 13 were fixed.
In total, 52 issues are still open and 220 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3934    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<2>  1253    Yes   INFO: task hung in bch2_journal_reclaim_thread (2)
                   https://syzkaller.appspot.com/bug?extid=820dc3b465c69f766a57
<3>  853     Yes   kernel BUG in bch2_trans_update_by_path
                   https://syzkaller.appspot.com/bug?extid=210dfbddd64294066983
<4>  754     Yes   kernel BUG in bch2_quota_check_limit
                   https://syzkaller.appspot.com/bug?extid=8364d1e040a88ed5657d
<5>  459     Yes   WARNING in bch2_trans_put
                   https://syzkaller.appspot.com/bug?extid=291aef749c5cbb9ca2fd
<6>  346     Yes   INFO: task hung in bch2_readahead
                   https://syzkaller.appspot.com/bug?extid=a6060114362257e9798a
<7>  335     Yes   WARNING in __bch2_truncate_folio
                   https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b
<8>  158     Yes   WARNING in bch2_alloc_sectors_start_trans
                   https://syzkaller.appspot.com/bug?extid=23573dac1278bb26916d
<9>  124     Yes   general protection fault in put_pwq_unlocked (2)
                   https://syzkaller.appspot.com/bug?extid=aa930d41d2f32904c5da
<10> 62      Yes   KMSAN: uninit-value in LZ4_decompress_safe_partial
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

