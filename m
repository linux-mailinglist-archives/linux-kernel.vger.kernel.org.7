Return-Path: <linux-kernel+bounces-643637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA9AB2FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 08:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55076178DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 06:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE7255F55;
	Mon, 12 May 2025 06:34:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC525522D
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 06:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031663; cv=none; b=amK7MTcwK6n4PClmsayC6vMq21zwxUzaSKs3DC2CyIMREecBd6UwLrd32LhwsL9HkDvg2l5cKvGe0AGH6Tch07skAYHKNwtFxLb36540pj4tfR7JjePEwS0jmpljRLanRWSYH1sOajR3BCWbFOE37vVHIHQJCa70Tg7v1NwHwf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031663; c=relaxed/simple;
	bh=4hTnCJZKbc6IzowhXTEn7o+qQ+7Igw0KCzxnMJkeNsE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PPB733H4xRr3IGh3G61dp/xKJgCX5IKzJ4fYhCGBYvhnHaREchCDSR1hd3JSbfgqRYC3TyvjZUkbHr+pCGCQietDBaPh0Dca0MxekNgAmXhW88Gpgp8aKnUgr/Vo0IBLEoIwCAk9NT7jIwavHh2c1Or10M63YzPAzoiPrNZn/kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86465e3f1c6so488839439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 23:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747031661; x=1747636461;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aY4YPekFezEFOenoNv7QvnHL9ecGgH1YuNNn9+bqEQM=;
        b=c+/eX5uAdw9rnM52hekiHfxg5z7x0LigB533RSZRw6N/41qd/kdJw78kAmDDmgHxVb
         2KL78bRn6wwkVoaDpqs+H/H0LgNsWa0wc8Eh6c0+6eejYSAiVcz/MJqCQu98sSPmplxK
         Q/jL67NSP6KkXqipB2bkMonMf1OeAd3GqIQAM0cXzmeFLd+Fsh1bLdJBRkO5TlTs7AZ2
         T7nkqFQElziFYSgGhDMq/ZMIZgpl17eVNRV8um2IzBg12N1FUf30NXmRp4NSIHc/GyIF
         0Z+zEwL3e2yxY3tQYezyljHZ1qnpaCsr2BJIj9yN/lXV0NttUbThJeHEy7wvQfEthJ0D
         pI9w==
X-Forwarded-Encrypted: i=1; AJvYcCV4gFkqJNiX0L0bgh59dQnoo84diiS6/O1I5FAmwhBDy6skwQJNv+iAwLvwBv9JK7SEDr2FmJzLcV/xKk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRx/cMDS2+8Lcr4uznx2bEbANzzAHSgdB+5Gd0dmfP1UALW298
	UU+7mLKmKepLqC70GpcmRdlcCzng3xVM8PMkyPZgkCLrRfyvLndDhS0uwOsMpyMahIdPFk3TDtg
	obkCPpl31xDR9c6eUBpamqeyP/t/u0AU9t6WjyFAko3r+GGnn7a9PDyc=
X-Google-Smtp-Source: AGHT+IE/gq9tU8dDX0ASPqGXpdsRLrai6u1l1DaPlmIX4+KOGGG7M7zAz8Nc88V/zx5bwevHNOlj5Q/7zqSuQmQo1RVVNZ6/iRgI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fca:b0:867:16f4:5254 with SMTP id
 ca18e2360f4ac-8676445406dmr1255531439f.6.1747031661405; Sun, 11 May 2025
 23:34:21 -0700 (PDT)
Date: Sun, 11 May 2025 23:34:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6821966d.050a0220.f2294.0051.GAE@google.com>
Subject: [syzbot] Monthly fbdev report (May 2025)
From: syzbot <syzbot+listee2134ca234fc0c46f91@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fbdev maintainers/developers,

This is a 31-day syzbot report for the fbdev subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fbdev

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 25 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1393    Yes   KASAN: vmalloc-out-of-bounds Write in imageblit (4)
                  https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
<2> 123     Yes   KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
                  https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
<3> 18      Yes   KASAN: global-out-of-bounds Read in bit_putcs (3)
                  https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

