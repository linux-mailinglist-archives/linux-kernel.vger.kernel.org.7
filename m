Return-Path: <linux-kernel+bounces-766432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C20BB24682
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2329F1BC0C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE693074BD;
	Wed, 13 Aug 2025 09:55:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19C2F8BFA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078934; cv=none; b=nk91AgUepltA/noFn3tg24P9kDgTvXEigppR02Ot2Nwl9k54Uy+xP0VyzZIXUjD5d8hx0FKEESiztRJH6ghNjDwts9jFwbCIl0SHMrIVqpB1mLJK1lH1UaQP76VOcnbhyXRWtisEo+zJPq5/99qCEMFiBfY54XI7COV7/vHPCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078934; c=relaxed/simple;
	bh=sidzB44vS8fDxirm53233zlrvmEKC6RPy48nYeF8be8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IiQSRbosSrvZj//tVixVxXmAFuKFxc1kVzQvRvx64Ih80e38OkyY1F6prgyDDnzB9jk/E0qndDNZ5yrmueyNbk5jrAMmVVPynA9DEsILcB0oVDw2zeCvMfC+dkIeedtxEhO8T1v9zGf1O1GPZb/IZcltoBwlt5IbtjxwwjrzlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8649be94fa1so1677351739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755078932; x=1755683732;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=syW6P6sH96DJbGciuh8z8YbdPpQvxJ0Uqcbcksg9U2s=;
        b=BV0GuAyBZHjM3cT+qm2u61f+AyuPUyTVQocAvwhagYA4Ww2r+gRhc1W8P8ImsdYZMh
         eTFuob8ns3TAffv28e/1q9Jai9e80nmYTNulGuTtEWzpFQ3/jfKOGPN/3b2udxUujV4L
         q8feyqh0zhOcu4mpWYzLDUp/fpgzEx1PMs0WRGtlN6FX/W3AXFGO21yhXocRFdx9RinF
         /4s7lDotRc7pydHHK9o7BawOtdlF0e08J0nsfcSrkNjLHSC9Zj0abFM4568HC9oP945z
         I9RwA6BxxGEUBmDaVuXzoHXzRn9AjaAwRnPsMnYSQ6l79KuCrrkX8oq/y30Aezcto5v2
         8Tvw==
X-Forwarded-Encrypted: i=1; AJvYcCWGOHXyoaWGr4131J0bLFXArG2rwYOlqAdHhzTeBpEYZBTZ6MV0l0maMKzB+O5jQeNTfnFSE9TthiwSJ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA5wlmdZ0kkO9YdT1vbsprt8XdHxLpLmtYZ74L9pzIt0fcejC7
	Nc3YPSAjdYpdQeMfkonqcg2WEGFLTVR/44Febn1fxDvgjCP2NROMBLi9Jx6N3IfM/nPdftBAler
	2MbfpXH88i9+g572RXd94a0oH4javZ7BMJ0uPOTugEsip151JjDa/c5gQ/iY=
X-Google-Smtp-Source: AGHT+IEn8c73mlS7WXENcuLt8rnI6vTHagW+0HPPhr7dc5hTPRl7uLTR/9723zxYmtU4T6a62OMDPjwwXkHiNAff/BQcwDalW30A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d81:b0:881:a0df:34cb with SMTP id
 ca18e2360f4ac-88429613554mr424595939f.1.1755078931739; Wed, 13 Aug 2025
 02:55:31 -0700 (PDT)
Date: Wed, 13 Aug 2025 02:55:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689c6113.050a0220.7f033.0143.GAE@google.com>
Subject: [syzbot] Monthly kvm-x86 report (Aug 2025)
From: syzbot <syzbot+liste8f38291080552a06e3a@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm-x86 maintainers/developers,

This is a 31-day syzbot report for the kvm-x86 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm-x86

During the period, 1 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 74 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 151     Yes   WARNING in handle_exception_nmi (2)
                  https://syzkaller.appspot.com/bug?extid=4688c50a9c8e68e7aaa1
<2> 43      Yes   WARNING in kvm_arch_vcpu_ioctl_run (6)
                  https://syzkaller.appspot.com/bug?extid=cc2032ba16cc2018ca25
<3> 18      Yes   WARNING in kvm_apic_accept_events
                  https://syzkaller.appspot.com/bug?extid=b1784a9a955885da51cd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

