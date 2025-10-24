Return-Path: <linux-kernel+bounces-869409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE5C07CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E7B19A0266
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A922134BA54;
	Fri, 24 Oct 2025 18:48:31 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639F3451C9
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331711; cv=none; b=XTUDbTcVxYNlodGK3sS2KW9wUDmrzraEMhrHT5hTnVW6Gi8aUmThVNKoehvRdNijWRHd8cBD727Hhh4yJ9Gcn+edjTf9S7OkVha51nwNWVgep4fyy2bmMGc2d+aba+zGgPbrqgUiIG4qIki3HmogcC3buA54HBFczE7AjhulsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331711; c=relaxed/simple;
	bh=/sddA5GyOSu+NmzOtxnvdlpxCOa2Qap22t2nIUrTPsA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jUmVOUlICrtmAwDBvx/tEls7lzKcS+4OJALCI/0LOFHJT4Eyup6cF1Zzb8Fmi2yrFO3o+FooNNXZGeIB6YWtZOcbnlhTRbuvELO0JYxIFKJmOt2AclWXpf5J3VswIvHAy89li2Ng4CCgN8zTgIGOY9RJ4kpapaP0+w317FvvKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430da49fcbbso32356945ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331709; x=1761936509;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ibQ65fSRokqWgaG4QSVQy0ejGVCf8laCEnbWyhrOTSk=;
        b=YJ6IHAoTIpMXgfFq/0vJWxO5RX0BogIodpzTF68Ji0F4NfCfWQfuqD6y4q4vvkjrye
         EtC4+D2FoVwlPm6928e3kTKfX42ulWdYGsDZ2kPofQzZd/T9mEcOP24pze4u+2rJ/mcW
         KZXcA6vPHsBpvHbO1BuBPMKhQpPUPOBctNDrTdlKEW/LS+WLusZ2FLkmvu5A0CWSs1BW
         mXUgscEpHMaMYbvhDWVAralXODON09rINw3fjg0m2XGoF5pgzReyth9oLi1CzCSYyMXg
         auqAfzPdmEcJvamy+6rejT2s8kgetmQZPcjLQh90ohIDov1bk9nahS0N1GjNddFTMbof
         e8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPobDyPEPm38BCsUIsvywrIzbkm+iHR8u0Vvftc5vUex++mm8QS4BVSNC0leArNTq88cLSClhoAkCig+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShLBNR4Zq/pbfU/sC3Rd7E11sjCdxbZ1GsHJpyZn7+6IhAFLR
	BV/bO54zEXK1VGvzYphMEpYW810oUJCn8/kybVKN9bcMH6G7mayL6SlNIMgy2vEiFZ7A7BTGX10
	rGkaxdIO3GPEGdt7SfnZxrgAjRNuHPdQU7Hy71oummkw+KUEJQVW3aRXGKrw=
X-Google-Smtp-Source: AGHT+IH+O+UM38jrvlTQkim2NlyJYSGcQATLCEzd55hx6zSrc+YvJa4mUwXl+bBJGkoyqEPkW5NmlRhuWZNrkEMCRYbzjBdn5uKI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:430:b178:428a with SMTP id
 e9e14a558f8ab-430c52d7705mr393314925ab.22.1761331708962; Fri, 24 Oct 2025
 11:48:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbc9fc.050a0220.346f24.0156.GAE@google.com>
Subject: [syzbot] Monthly kernfs report (Oct 2025)
From: syzbot <syzbot+liste96aba5955f514e24086@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 26 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2087    Yes   possible deadlock in kernfs_iop_getattr
                   https://syzkaller.appspot.com/bug?extid=4bb2305559463e8f6a2a
<2>  504     Yes   WARNING in kernfs_remove_by_name_ns (3)
                   https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3>  500     Yes   WARNING in kernfs_get (5)
                   https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
<4>  112     Yes   INFO: task hung in fdget_pos
                   https://syzkaller.appspot.com/bug?extid=0ee1ef35cf7e70ce55d7
<5>  78      No    possible deadlock in kernfs_fop_write_iter (2)
                   https://syzkaller.appspot.com/bug?extid=1cfd86253864f61b533e
<6>  65      No    possible deadlock in kernfs_fop_readdir
                   https://syzkaller.appspot.com/bug?extid=8fd10d8928ed1f715290
<7>  59      Yes   possible deadlock in walk_component (4)
                   https://syzkaller.appspot.com/bug?extid=b4567a8b2d2ad5f9dd06
<8>  42      Yes   INFO: rcu detected stall in hub_event (2)
                   https://syzkaller.appspot.com/bug?extid=039eab266c6321a174bd
<9>  30      Yes   INFO: task hung in kernfs_remove_by_name_ns (2)
                   https://syzkaller.appspot.com/bug?extid=6d5664213a6db9a5a72c
<10> 23      Yes   possible deadlock in kernfs_seq_start
                   https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

