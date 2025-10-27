Return-Path: <linux-kernel+bounces-871064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0516C0C5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 727DF4F1116
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDE32F12A9;
	Mon, 27 Oct 2025 08:42:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D42ED871
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554543; cv=none; b=KC5mmt7tHgQ4VyO4+zp7M04Lt9PPucnASI+YsCrMotMul9yJSnVUVkQlw1MKj7KGxMGFFz5ZF5ZjcH/yqeHdCmMwMcRDQBSbD2HIlAgBF0btGJ1u60kHhIu1rTu8cqvS1WGKyUvCitwPiApdXoPZeVetp9tVYe87H5DDsFY/xU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554543; c=relaxed/simple;
	bh=hnlLRcV8zn3MJM2yQhRmnXTcVYj2iqM+bgJVAjxQtm0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cQqCuCincyKf045bTK1Djm93ZYY0GLuFBP04DaXU8HsewwZdagF3fHc7XfjAe/kQ2QTZp85Y/qssSK4jS0G6GDZDXsiUSQJCjHGgGI5RCk+7kC6cZvWuEPEFQPGeu6z8D08hYq98vD0uWqUB5UZZqReo3Ppv0lRfXaVdg6RQbt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9374627bb7eso641563739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554541; x=1762159341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QBqeIwOciaTmXKoZIhci2rtjD+K88Ea+ckvbwYoOuU=;
        b=V5Gofp4uv75zmnwihE/PAe1CnmJN9nY+/iWkLABzqPkd+NhH2Qkt1RNUU25bvT+PPn
         +72oq/Jcsw/uGnosdJACBWJqlSs02s0FgW1G9Gs7fM+ZEwB5NcWVyUWIs1rnnWQ4uAxd
         DeqBIR1IjwAb5T5+Lc6jDQtSiBdzcPv11DmhPfesF2Oex8HwNOvjtAc4+HMLqAVGnB9x
         GwDtrfxjYW9WXMhf48QRgLq/jeW6ZjRuczwy0VJnPz/03jX7TCGGWnMiHeIU8ft+QvUk
         iDfCXyosfxpQiO9Na+Q02z6sOjesRyiqaQBs1JwIMT7d9sw7AXZPp0HWsSLP7iZGMGBx
         VRnw==
X-Forwarded-Encrypted: i=1; AJvYcCVZfahk/BxeGIt5K1UeijszB23LwrajBFwdLIBamUVM3kxnnTBViMGrA5bbcSgdKrJgZFWx8Cxb4GmLmQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhoDbuR7mxAwxOf6YsqiWvjfb2bQrcjR6hy3z9L1nN9o6B4tJm
	CjAebY4vDrOfUIoVYbYOyfQsBqMZWhapcUq17qAzSyAOwa/GeYP2CqAoEt5IuKQMnhvfmrzIsVn
	F9MTelFjB2W/dfX991IxVQrmPkGtF1uiAiB+3mw8j1/eyO6i92yTs95hE8ng=
X-Google-Smtp-Source: AGHT+IHuDkYOQ/FNaVGfp1mI13EztKQGqIFfCUpYQu1XTw5g4VXS4sBo5lLIUmoxmiVDtdogHimrS0mAP7Yy5u0bHCL5lx/W+Uo4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c95:b0:945:a834:5951 with SMTP id
 ca18e2360f4ac-945a8346334mr425689639f.6.1761554541318; Mon, 27 Oct 2025
 01:42:21 -0700 (PDT)
Date: Mon, 27 Oct 2025 01:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff306d.050a0220.32483.0013.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Oct 2025)
From: syzbot <syzbot+list0bca5cd9894f3ce13802@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 3 new issues were detected and 0 were fixed.
In total, 40 issues are still open and 70 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19521   Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<2>  7872    Yes   possible deadlock in run_unpack_ex
                   https://syzkaller.appspot.com/bug?extid=731b27ee9413ba859499
<3>  5563    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<4>  5086    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<5>  3590    Yes   possible deadlock in mark_as_free_ex (2)
                   https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
<6>  3255    Yes   possible deadlock in ntfs_look_for_free_space
                   https://syzkaller.appspot.com/bug?extid=d27edf9f96ae85939222
<7>  2983    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<8>  499     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
<9>  380     Yes   possible deadlock in mi_read (2)
                   https://syzkaller.appspot.com/bug?extid=17f812893d5906837f33
<10> 193     Yes   KMSAN: uninit-value in ntfs_read_bh
                   https://syzkaller.appspot.com/bug?extid=7a2ba6b7b66340cff225

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

