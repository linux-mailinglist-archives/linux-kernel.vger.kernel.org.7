Return-Path: <linux-kernel+bounces-840949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA3BB5CBD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB9019C58FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556792D23A9;
	Fri,  3 Oct 2025 02:23:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21320330
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759458186; cv=none; b=mryaQ066DhPxEB4yCJ5UeK5znf72qV1qmY7Y6U0tIotPsEa5bKeHZuAcOPkyYdfgWsTy2IEireTYKyZfavcql2hNOUsy2/rIW+Vb0apUcI4HZx7Csjz/r0wUWQnBmYoUKutU2xhRTTQEqRRatL4ETriLQZO90L6m6KACMclN+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759458186; c=relaxed/simple;
	bh=Aqfy4Ory85uUiwt1LYLWi1QFtiU/8CTHIEgKPGLdFgI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=onBX+rPTxP4G4WBzSFmnqiw3Wxfwb+AAS7Q+1iWhp/4h/fi95VabYxRQHSDqEnoqEaW1GG3XdRftZJQtW4z/KJqdX0BW6pBPK4NFsV8gl+pzK2D3NgAnv9Xwpd93KccU7CffabwtLkZXYZb1XFL7wjy7xUz5ESvD6ER2XbDnFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42e7bad43c4so11233125ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759458183; x=1760062983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oW3NH//ucGZsrQc1DcPv5j1XmXcxLWUTTYiQgRIuo3U=;
        b=O0SIpHMN+6TB5Q3GtBDjbNRXjbRakfJO2Z4KiOkZMxW/71g/FZPRaPC/Qa5qijzE/7
         dcWuCUkVeLd+1oP1MxaBapKZGvuJecy/ZutShp4hLpq/PSb1eTVsGst8TjYFgZGLF6Y7
         l75X7ELYeL1xoaKsezi+bfU39Vv2tEdAbDxqBHCtf0yfDyUngZoWZI15QNkMwrModH2w
         9r8d1mDQ/b0hg9LOGl3NaKbOOZ9Fk6bJg3ym7yvz8KNnT/Mwutvp2HgqhzVs2uYdPD+C
         zHTWRuB0zT4Qts1EPQ2DllMyk6QnjdmG8EHRIZE6xBQywE/eTRKH05vHkEKWdgSUXk3W
         wegg==
X-Forwarded-Encrypted: i=1; AJvYcCXXa0uVkr3HnwqeWnLAAgE1ADA3lzny3nB0S9QLNiFwgun60dkip6QIsZDktiC0VTqJC3jK/DEwWDnLDBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqABmuHzqe7WX4AD4Axm8tCwJ+c6OFeLTGQbT2uM0s1B69XYgH
	4QzbW3/fQLx53NOuychKvhKkh3h3MS0mqqOW4LWcaebF1QmJAxVcbEHwfdl/4O84yWPz4pZAgCn
	iSCamw/J7fWrS3z65k5a6r7MeBtE82C9fHClbpuBsbtMiFiZFEfRNOrSIbic=
X-Google-Smtp-Source: AGHT+IFXZR/XgMy7yq0GBY75bKhVtaFz/TVQq2WRfZ2Gc+8XIsdXP2pqlm/0FAIRh53SAPLEvCOnrimWsR217vdgufYUYu0e4o0n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174a:b0:42e:741f:b608 with SMTP id
 e9e14a558f8ab-42e7ad8431dmr18758425ab.18.1759458183575; Thu, 02 Oct 2025
 19:23:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 19:23:03 -0700
In-Reply-To: <20251003020223.2408483-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df3387.050a0220.2c17c1.0011.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114b1214580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bc5f6d89013f5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11731214580000

Note: testing is done by a robot and is best-effort only.

