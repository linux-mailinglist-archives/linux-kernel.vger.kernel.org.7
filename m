Return-Path: <linux-kernel+bounces-738861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DF1B0BE52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC7616BEAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892062857C2;
	Mon, 21 Jul 2025 07:59:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695F27FD76
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084772; cv=none; b=En2TfNuCkIcgm90w2xncWej/F/44jJ8f43CS2pG2gdXvjJ6ooojogy7NuCRJ3pSdHB4P0SGJtg5FUbLByXzY/0jMAFedfu3PiT8wkQ9DadKt39WbU/giRv4gchgJGnboLMpm7gZ9z0grH2regpQQj6tLUdEV7T13TeB+e8qRRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084772; c=relaxed/simple;
	bh=8poz7xfu2OTFCXbFvBzbS7PP9faAnEkqUgQhKGWjoYo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=R4HQlz4i7LwqXAIK7+vAJW2Jx5TpkKsZK15f54d6ThDlktcfAY2FKzzPU4Vyv1AoWlrK73H92zhKPDnkZ0JC8hxOF7OszabH39weEwEuEwaVUaNI6jVLpUNfe7K+45weq5LSC9gHY6IhUz+1aXp+dDjxLBHyqDpctd5TbcYARVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86d07ccc9ecso287578339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 00:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753084770; x=1753689570;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrpC5NtjM63ObKi9kGe5L4eiidtLaGfFo2TZX4xxOac=;
        b=gpVmFuut1vwgez11Jn2+NSS6vrGVsFGWl/d4YeJgjPkVyf4W43bEbxtvwdRDP7Tq26
         XGkYZ9wPiQQrG6L234tr7PQdjmf1wv5vYzwue0LrXkZbAAViyGl1fcL3CW9rBggIFiVJ
         w7eM5Gb0+ukviQ44x9UvRO9ZiqFt47w8W2KC+u+9GpPPMIR0MbPM0F0y3YsMUVBfvXOP
         OOZ3j4r0eQAhnb8Kj5+UuOBTOhlmZ2J5SadV9eZgQOxT45RALdhQOfrLQhq2gBsP6ixK
         AsLsqAYmU7S/fpEJK/k4Da11qaEG7lWEDs5kX+3Xn2fMugwMOP3FrMvWj923L/JWcd/2
         FWHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAsO1qLWbQgO/l1ugFVOZQ5gvQri7Bxo4tM5wpUpsg0WIhm3b5uvEj00dNhAwNDJBfa+Al89U7phooFUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOfI3u4hHVAwvXdAJOU0WL2S1sFQit1kF4uPAH/yDznCAdes9
	xH8JiSW+QTSdMAcynh+O/CfMLEwIefMKLOnTudm50RErip3GgaQ8ffXwa2HTknU85uBHWuz308Q
	uh0Q+OT+QCYNgiSQ58PJ1C0qc+zUg72vauc1ZjUjZ+DMFMHyoQGv1zRkPgNQ=
X-Google-Smtp-Source: AGHT+IF1o1nNtgjePeiXhvupBDrEqoC3MnNkeQNNSAGAUtCFZbt8OhVJYh530GrWLVk9o+DTTxwQN5p8cvSHYMmqfHs3Flm3BEWu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8a:b0:867:40d9:bf7e with SMTP id
 ca18e2360f4ac-879c2b47988mr2248620639f.9.1753084770052; Mon, 21 Jul 2025
 00:59:30 -0700 (PDT)
Date: Mon, 21 Jul 2025 00:59:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687df362.a70a0220.693ce.00e7.GAE@google.com>
Subject: [syzbot] Monthly afs report (Jul 2025)
From: syzbot <syzbot+liste7be6efb291efe201948@syzkaller.appspotmail.com>
To: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello afs maintainers/developers,

This is a 31-day syzbot report for the afs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/afs

During the period, 0 new issues were detected and 0 were fixed.
In total, 8 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 648     Yes   KASAN: slab-out-of-bounds Read in afs_proc_addr_prefs_write
                  https://syzkaller.appspot.com/bug?extid=7741f872f3c53385a2e2
<2> 78      Yes   INFO: task hung in afs_cell_purge (2)
                  https://syzkaller.appspot.com/bug?extid=750f21d691e244b473b1
<3> 16      Yes   WARNING: ODEBUG bug in delete_node (3)
                  https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8
<4> 8       No    kernel panic: KASAN: panic_on_warn set ...
                  https://syzkaller.appspot.com/bug?extid=4eb503ec2b8156835f24
<5> 3       Yes   BUG: unable to handle kernel paging request in afs_put_vlserverlist
                  https://syzkaller.appspot.com/bug?extid=5c042fbab0b292c98fc6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

