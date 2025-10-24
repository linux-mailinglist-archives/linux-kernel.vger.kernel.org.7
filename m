Return-Path: <linux-kernel+bounces-869408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DADC07CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42303503DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB334BA3B;
	Fri, 24 Oct 2025 18:48:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA531A7F7
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331711; cv=none; b=fqET5WRDvLS54JtVYu3eEnaDkk/2wG2PbrNNLoHgDIEY+lv1xNa2/16OC86WFEW7ZNYoXPrzuOZrSYaiByUqFaaSzTsErf1xMtWv84IwmUPt717DJjxuTuHerfe5XuudzAzvKyGaAkeQ0OB9/7SiNJP+OG76V0hCBBKrr5xbjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331711; c=relaxed/simple;
	bh=KBLeLG41Bh/MVHL9V2uUl2ZfABOg+r30DVrzzOZHkFI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G1yqqyJwRF1f/VVdKW19fR4MpBRAR9QePFXpNYaOKueZpv/FhFi9Pohr5rp7YSU+ZqkK4VFRs9Y6hZmbHoHla2P4btPiYG9wSP3thL0Ky+VP2S1C4lWcABObUFp8j8EJ3rezP7rur9CV9u/aHoIBpAH8aAm+EisHX9A1/r4eyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-9435917adb9so5214839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331708; x=1761936508;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBfBqOqMn2Xkfx9qgn+oZUwCAFfhzvzOwcf8bk39Klo=;
        b=eAnSY9yX+51ZZZv+sT55buhAtJO8tstlePg/+/U2rYt6SMXPHrWDAR3Rz5AINqxmCz
         Y5h1c1qCWMxKv8uS5/rWnaYSi538YCOwlmY8FPU8TLCShB5II7cZ3T/FWycUkRPwCWR8
         mLOmp8D7EzSnSIaJi6/TYgJzHzWgXau3ji5j3Lo9hfEzXpn6wLZ68XLuHVNnoNGqBnHz
         Nx+ZOzHafuVtA4M4x/yX+/LA/NtiQjXSJehYAz+r2LqGoRnhhmPF+MHkQ+nHK/udq36U
         EgdF5D/ceZDzUSoxyFtiokPp83k0eBf6kWEZ63tQwiFC5OpsSCADUPcCDd4J51IX/nZK
         Lurg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0UKMVOxG94DeRnyjDkQPRc8c8zD+aJpnJH6egVQamGNAezEyRMauNxxtG7TrWFktg3j15IvtucfE3Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8k237M9SaUQ2s2o3axmwYbWWx+pnK3tIGOwdDgQnbrHFuulyc
	Lrhjt+yo3czNH3d1tqytflxEhOEqA8YsZE1MbbL/ueU0aRHnvHsahCDifUKr+oCKH92CAvornhc
	0OVC7QhIMEc30M5KkhTJgaGnW6B3vtfjurT32d0ru6rUk4E5+TtNSxbGGDOs=
X-Google-Smtp-Source: AGHT+IGbgpbcCCHuMaVv7XrmFkj3UPVQGYBnO2C78bxStPm7JW5ig1iMfR+5V0ZXA7AJKD5pTAXHXR1QjbJvz/aSGTxZCWdJuhWT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:480b:b0:431:d6fa:6c49 with SMTP id
 e9e14a558f8ab-431d6fa6db1mr117527405ab.24.1761331708702; Fri, 24 Oct 2025
 11:48:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:48:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fbc9fc.050a0220.346f24.0155.GAE@google.com>
Subject: [syzbot] Monthly jfs report (Oct 2025)
From: syzbot <syzbot+list127cbbd529863072e782@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 55 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  70381   Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<2>  39568   Yes   WARNING in dbAdjTree
                   https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
<3>  34245   Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<4>  7355    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  5013    Yes   kernel BUG in dbFindLeaf
                   https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
<6>  4079    Yes   INFO: trying to register non-static key in txEnd (2)
                   https://syzkaller.appspot.com/bug?extid=5b27962d84feb4acb5c1
<7>  3712    Yes   INFO: task hung in lock_metapage
                   https://syzkaller.appspot.com/bug?extid=1d84a1682e4673d5c4fb
<8>  3569    Yes   KASAN: slab-use-after-free Write in dtSplitPage
                   https://syzkaller.appspot.com/bug?extid=a939a1121380d3212940
<9>  3395    Yes   KASAN: user-memory-access Write in __destroy_inode
                   https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
<10> 2801    Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

