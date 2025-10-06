Return-Path: <linux-kernel+bounces-843277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55593BBED16
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B99874F06D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20BA26058D;
	Mon,  6 Oct 2025 17:29:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A923F421
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771770; cv=none; b=K9PEuKxiPyudmFl+oRXRNzhyc33YWfousbl/sHRlirsBigmgIL7VpvbDP88WHrZqF1uHkyyNpS2BdulEmguMjdjRSH0ocOHXSakcxaVFOo9bJ7hMrFp7cqcAHG/0N0N+RUTRhIHwgVldbCsf4wjfRcfA/GAimh8cJrhi1yyFqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771770; c=relaxed/simple;
	bh=UfYkNlIqJ0UOcXUYMjPVrcZj2rIGaSllfBYPjdPn8fU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LrMkaoV2tvYqkCmG74lWl5uIDpOjkeOi46WM/39/KhSMWDW9CuMu5qcU7knSFl9lwUOHCAgkO0qm+3TOxEDm/2WqWyVNgxOkdgT/JUvnlhSmw2luCGydrlt2NenCxzV4zpij8KAeotyNFd7O638qHdl98wdznuOvZvFs4IZ7WAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42d7e4abc61so65604465ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759771768; x=1760376568;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYSGI+wm950aF63lFDgqtSx38FxRnb1uTcZG6/4yc3Y=;
        b=I4Sy6aRObQb5uIOK9jtxPdWEGjQDjy3wR8UzzFld3scOZrE+7lCSIhHs46DwesW6Hj
         PUVsDrKzMprsEozXlgT1AxOOU6VoNPWPuCm1EnMQHPMPCUOdWXn780+/beQDGytviolo
         JtI5NtwNlcTXfqnbHbGfGw5ObU3syBD4Zkbm5Qa6KaKlxYBhJWuhqpsfQht1SvjkCN4t
         c0elB+q4wkN5o62lmZ4l5lVAvDjv6zQWSObdopVdoa8hXl7zYfTd69Jye3JIxJFFgE69
         p091N08uzQZCKVzo0ZnsFqMBoJLm8G4YMPPwXUbrMq+5oqQhK0aB7f8TWGxoDARYjLDI
         sy2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmO0/UiGxw74ifVco2iRUO15Jv/O/BUsM3lCTjoUgbdkZ6EMhcLFrEPO37buKehvgv2yFkSNXb9JvD9jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlVXdpN24ydi4VN3+AOPnZDZ651dGikweIg9iJouuSUtqhi9T3
	C7yYzxKKCYMoA58Qp4jA2jQ9lqrvngICMhJSBVwMjQxsnj9s6IcUqvp+reIOSRSeE/Rw9TMszFj
	nP+p5l8svRuTm8Av2eQxiKeTc0IaR5CpEaQfdsG69jpkg7AX+fxSs2TwyIW8=
X-Google-Smtp-Source: AGHT+IFU19mSImJx6lton1MLSZgMp/idojUMivv0dv20oP6EqORkEcAASG3o4o0SdtLiJarrNuwleMsqT6tgK4XpkuHhHS6TQiiM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:42e:4c23:5363 with SMTP id
 e9e14a558f8ab-42e7adb29a1mr189932465ab.29.1759771767957; Mon, 06 Oct 2025
 10:29:27 -0700 (PDT)
Date: Mon, 06 Oct 2025 10:29:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e3fc77.a70a0220.160221.0006.GAE@google.com>
Subject: [syzbot] Monthly nbd report (Oct 2025)
From: syzbot <syzbot+listddef0da3f5f843882aee@syzkaller.appspotmail.com>
To: josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nbd@other.debian.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nbd maintainers/developers,

This is a 31-day syzbot report for the nbd subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nbd

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 8 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2150    Yes   possible deadlock in pcpu_alloc_noprof (2)
                  https://syzkaller.appspot.com/bug?extid=91771b3fb86ec2dd7227
<2> 310     Yes   INFO: task hung in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=30c16035531e3248dcbc
<3> 146     Yes   INFO: task hung in nbd_ioctl (3)
                  https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
<4> 88      No    INFO: task hung in nbd_disconnect_and_put
                  https://syzkaller.appspot.com/bug?extid=aa56a8f25e07970eef7f
<5> 62      Yes   possible deadlock in nbd_queue_rq
                  https://syzkaller.appspot.com/bug?extid=3dbc6142c85cc77eaf04

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

