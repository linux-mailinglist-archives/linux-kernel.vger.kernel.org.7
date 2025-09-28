Return-Path: <linux-kernel+bounces-835572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8145BA77B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596661897BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F8F281368;
	Sun, 28 Sep 2025 20:44:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA429271A94
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092244; cv=none; b=VhaWM+kpMEF/YV8/t4H4WoeL7Kr63U9Y50rqcQTMccMNP5FdkzLu8De7s+BJ2Ya5XAkheUjzTOlx689zzhYkS/tPZ4TrdjcONYWDdnlQxI0AaZUGGChNPplfm+TYJ00bnZNIElQoHb9UlmeWq3CJE9V+ALHlch2jZDd5q5VJzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092244; c=relaxed/simple;
	bh=V8xKQwwsH/XLY4Xk6PkdAS1Q+SeNBbSM2xSYmq88rSI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NvSr/GJv4CiEhrEMt1uxscJxT9c1OsMIVUgQJSctMuuHONc8pA3w0aAS1TUmIuqMV7Uzw13zTgNZ8RGbrHfzJfcZ8fyelucPYmfIDWN6a7xcql5LrvJyX4twlJdRbtqewnnwECKOiVRUqbHJy846RiwvwpLRA3XEPh79axJ6Oeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42594b7f324so73768595ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759092242; x=1759697042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9dQliXP7JgazeSaJLTI4yW9dp3kNzKqsfM43FrdpZRM=;
        b=TE+/WKYhwEkK0ktGzKoaQC2gPnt02jDtt3dC+2luaQL0PEvYvEX2IiLsnxAT4X86Xc
         sfO8MSCW550QYz/GoZMlnkGJxwuTWzT+3NQWQwTsCsow9AusMGbKL+uleyUhT7azcXzz
         r6myB73j1L0YK0EGHiH8is3yd3mmgvYNljNB2inNp5tH9N4UnVqnhbcepZ7nnQNK9lkh
         qk5B0WJgoT6ie9uiHL0xUBHfiC8+umC+UjSd70TKTxWuBkZoMbdqGLhdSds0zijAJFKV
         Q90IF+UrVMX0U5y05jPa/eSNGNGPngu6vRtNrHiOdAcPLJ3WMJBh8MTORFIQNLH9eC6c
         j1oQ==
X-Gm-Message-State: AOJu0Yx2+vK/vtT7DWozrvClrDISqVFZWvztp8cpQQQl3T4a5t2nAQy5
	MxTNJ7Z3Vxm7bh5Gv/hwFeXuasxje/67VnX6x9DacWWhGEMizlgoovIX44XH1ASw3dbzClT8aoV
	4nv9yKr5FBVe+m9JN3EIR3XXANQ2PNo41OlOHLReEp5mc7a65Y3e26oPgmzs=
X-Google-Smtp-Source: AGHT+IF6FkJnM+39oMv1n/h9pPrdqfE5NGfbH0a80J0mHH2T/nH1NK/2qSMmuayW/C8v+Y9XOffp3LHJNcRITlCZafFoHjOKq2xz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca09:0:b0:408:6044:8d1a with SMTP id
 e9e14a558f8ab-425c19aed2amr53641665ab.5.1759092241957; Sun, 28 Sep 2025
 13:44:01 -0700 (PDT)
Date: Sun, 28 Sep 2025 13:44:01 -0700
In-Reply-To: <87h5wm2ybu.fsf@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d99e11.a00a0220.102ee.0031.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] UBSAN: shift-out-of-bounds in v9fs_get_tree
From: syzbot <syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xandfury@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com
Tested-by: syzbot+30c83da54e948f6e9436@syzkaller.appspotmail.com

Tested on:

commit:         26285807 Add linux-next specific files for 20250926
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15090334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=997066872b7941b6
dashboard link: https://syzkaller.appspot.com/bug?extid=30c83da54e948f6e9436
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

