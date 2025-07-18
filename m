Return-Path: <linux-kernel+bounces-736766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D1B0A194
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D83E172A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFF52BE63D;
	Fri, 18 Jul 2025 11:06:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1782BD59C
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836765; cv=none; b=DlnZ3LADBht5s6Enrb8Sd1agi34E7IrgIOGh2ao73K7hvZ9bssLRRDKEVw+ZrZhszEXO0VAghWG4gtB6AJzdTQCI5ZegYHB5Dpb52/JrOd+NMe2S7Crp24dISnR2Uq/K305W8ylHCRBAGNyrplQ1sE+wEor8nQZzjiye4TTYaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836765; c=relaxed/simple;
	bh=mMYjD5ushRAcn0hxxbHrwd7wuEdKG3kCFHG24EwFero=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qhQZ0oblLdHoEojqfyQ0hW9+0gp5bnXy7LeP44Q0FGtkp4VbsbzGAAv9My0huEPio0/WwatlJLn7faGSXl8qtZGsd7JVNS44yJASKEczpuOiZ91U5mUuz3ahC6/oZ0dexMxSinG4yUGsBt42Ge3Mefvr7JE2tGFZM6fy8M5wMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d126265baso195508439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752836763; x=1753441563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yZ8G9EiyDhRVh1AzpW2U4oZQf3M8tcVseb712htYAg=;
        b=H3v2AR1VIlYfhCyIo/IKwinAU5/Edrki7RZLmDmC5eksjnRyffQNJB/v7Ixz3AqHmf
         jcvsUK/Unhrl3bWQOhmaN7FvdgIsQPRo36yUPq6onSvEL3ZKh+OuusFZoy7KBHXhmZQy
         ZGtGfyZ8mTDujb3lfoRACBBkbh6gBiNunZityq7VfHMChxrj9gOD3Ha4axgmyfD8fZ1O
         C+49UR2p8V+x//+ZCFGoT3KthtUgcI5bbeAOVA1qRplHGoLi/ajr4QLEjSqgfbNxLiJ4
         gKoYcgJBzYWLaJFWczM4e1OVDmytxGzNEv2jKiK6ZyC3ZalQU3p5XthR+58OyxihrshQ
         i7hw==
X-Forwarded-Encrypted: i=1; AJvYcCWzMgcNtJOqKLC9as8IOlMC6OhHJw7JqjBPokhP8u75f6BoZkuUMmHgv+byELdf77syHEjKtbpHKSXigx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+PzJ0awax6m5plUvFxnUrT1kJKHgbRoHqvDTvsW0zxXSYfI5
	2GmtebQm6EW91SVvDd6GVUTU+iZYmr1OORuUoDHz+u/o1oiFLY0Drq9dHCqVaesumlGwnNthKtv
	unUC6uAniCLNhPjAYe9xIJYczCC33dx9GX/GFvvT+LvnnHcaJx7aAvdeznXM=
X-Google-Smtp-Source: AGHT+IH3XGerJTcZ08gWl7gkWbjUtHbgYsutqn8t7bKkbzp+UR+MXO2gWdp42jzBOwH0Xk3PsWYJSIw/fv2m5NY5wGEa8saFprWy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6010:b0:876:a8dc:96cc with SMTP id
 ca18e2360f4ac-87c0136243cmr760657539f.6.1752836763586; Fri, 18 Jul 2025
 04:06:03 -0700 (PDT)
Date: Fri, 18 Jul 2025 04:06:03 -0700
In-Reply-To: <aHoiS5AD92AR3QkT@strlen.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687a2a9b.a70a0220.693ce.0061.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in nfacct_mt_checkentry
From: syzbot <syzbot+4ff165b9251e4d295690@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4ff165b9251e4d295690@syzkaller.appspotmail.com
Tested-by: syzbot+4ff165b9251e4d295690@syzkaller.appspotmail.com

Tested on:

commit:         d32b52c0 netfilter: xt_nfacct: make sure acct name is ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16c77d8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=4ff165b9251e4d295690
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

