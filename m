Return-Path: <linux-kernel+bounces-874935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C86C178A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B11F4E15D5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8C42857C1;
	Wed, 29 Oct 2025 00:29:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEA184E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697746; cv=none; b=Ehwd3TSoBFl0wHaFWLIIM1eLke8/EZ+O3CH/hXIWwn+ZXUVIX+16O6dIJb7ENpr7yqN1uAiC0DlrZuURPQbqrXJslfHmlbwCJaX2xttLuGvG1Elp9xCYS1uQFK3dy6o8AgCYk5A+eaqKqm6Jf9VicgwO2TYyLK8ty+OxrfYtJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697746; c=relaxed/simple;
	bh=FRKS0r0aTRHKmZO/0F5ajJn0ZWFYhpKOd7Zk4D0lKU4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EphrHcuTGBIyaUSIs2OYx/CcV2r/M/bxcv5dEPArWoKR8ZWRdE8zi+NYvscv9DcnK3maYyMCgU06Q/kxfc3kEhhWIWCJ2MfTKs6pcZ+KhRwBlNwbGVrwiAG0tVPFZ3cTI6/I6Ue8n3QRvBPt788gU072T430I50HtlS0IkXulzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430ca53080bso70682265ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761697743; x=1762302543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLdQCAacS5waVDFY7lP7BQdWuDh3+UMXWWpsrldv88g=;
        b=BTKQt6iwA6lFt6DEZWZKeg7ktMSJFq3CSMyRHQ4SoytgLv8tNeEpEqUJLV5sNrrW7M
         UgJ9bQDe+2ZEkiGiPrbQpmFWMVr7G+I4Hb7lZrC5a3w7au/uFU0NVzckBko36L7Hr57d
         yRXUnyMC9EdQ9WvQ6+LxiBwyGiwxKOZbivAQZZEN4KR9pcCnFi0yL1KZKiesvC8JzTGi
         wnM5UNOG+POndsJRWlg+z+M8+wL6x54fqO2W12XGSl2ple9bkj5Qtp0EuooCY33sKwTI
         n8H0xILLuRsquesIQee/PnVCjsTsk3r7XokCYiykxoLjpOjLtM46eKM7s6IBQgyyFwws
         5TtA==
X-Forwarded-Encrypted: i=1; AJvYcCUtbTocdX7gEqocMFnJI4wOOBO54zrSygnjWALZl7DRRHAB0d3Dw/428r7kKMKpVkAhJ13x4Rwi+feJYU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywil3nD9NsL583uMH4PzwIjyyqIFXWxeUeFwyUV3bCiY+TowCjd
	In37ku+UOE54ROf9LkHB4plqD6bUpCuRDJG4Hybd1JRhyjwsj255xX86TOL+bIu9WKFBzhifq2S
	/hNmtqlHAGyTUGKTkxr25EpircLIIrb0Drqwe9+N2nqBBqAxZrD1Wj+kL0fw=
X-Google-Smtp-Source: AGHT+IFfixI8vUMb1CBqCtnaqNFiUNlz9ak/yxi5F5dIBk8p4kbEcgYw7tkLEAeySWprvWeGSh/BoKH436AOjyvG1K3QdWeL1mYL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:430:aea6:833f with SMTP id
 e9e14a558f8ab-432f8fad569mr11890975ab.8.1761697743607; Tue, 28 Oct 2025
 17:29:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:29:03 -0700
In-Reply-To: <CAHxJ8O-JKA=eMjKGOYg3a5nhxxdHsx8rMXLrsdJGHEk34vrm2Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69015fcf.050a0220.32483.01e3.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_file
From: syzbot <syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com
Tested-by: syzbot+b93b65ee321c97861072@syzkaller.appspotmail.com

Tested on:

commit:         8eefed8f Merge tag 'nfsd-6.18-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cd8fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9dd0e4f446d638a
dashboard link: https://syzkaller.appspot.com/bug?extid=b93b65ee321c97861072
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173af614580000

Note: testing is done by a robot and is best-effort only.

