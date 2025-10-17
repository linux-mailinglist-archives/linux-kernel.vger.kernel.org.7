Return-Path: <linux-kernel+bounces-858830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA72BEBF5D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E2F40686D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D9F3126D5;
	Fri, 17 Oct 2025 22:57:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749E2D7803
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741826; cv=none; b=As+OAEDoviPS6cRGK8M09GAD3JxXsHKUcff4dQ355tRoN7fWpsacU+nOy4dWAyXMyGHkltV3MmUV1j0mV5EbrhilroJrbrlcBU/Xs5BWQyd7ne1sep6FRTJAFcapt5KZp0sgjQiDRJZst7PiZwPvUZSaaqgwS/59r0G2+LpmD3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741826; c=relaxed/simple;
	bh=f7KvCyEDTyzOxXZjve5/fBxv3fhXq88Wg/v716HQCy4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jjdq+LZNrtsegZYnaud7HaFzFLFh44zblS+dUhj5EK4S01nVORgv5d2lmSWg+eMo0LGYBn3MZT+UmEcNDAC8xe+mqqIYpgzs4hAlqsrMjfyoUb2X/io41clAACWNgnuYu4tcc3HtcFRCEyaViKIX5/ATZV5Tbrw+hPnU8BMtSws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c8321bc1so16418505ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760741824; x=1761346624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJpgDBAxLccAhUteGLabQLlE9rHnlPNcTGhEEI8GY10=;
        b=B45GndXXl4b5A1d56hSDoiGJ+xspvFpHNz+OOoaXYdbsF2QdePvxRlnas6z2/5I84T
         bPaeDmvLP3vGysJMPU1RsMkg+3+tTCEN8GKg3BXDe1/HaNY+nh/NHxaVYbS9ySFiwQTp
         69SI36+He+8jz6Fj6m3ZV0VDkiD7gflUugflOnPOpnHkCN4PYNYyefFgf4KerFFMfSoN
         KSmdXzyyGWD+nfMZW7e5n/h+oN9YhdVw8fJQ1g533Qtgvo6K19WzFA9g2ovcPWfH7/jb
         rq4cKD2Hv7SrGZiso1aZm7WqQReq9c+heeqLSeHgVrejRd6IlB/1p6v7mC0yaztlF5AB
         Vomw==
X-Forwarded-Encrypted: i=1; AJvYcCWC6tJWT0IpRiWE+jpQ4kMacMSzyxuX8tyt4etspEiC3RYS33+bILixsacxZ88yAKjNOGQB63SO8gwm+wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzat3i/BfYuzOu+VnrbEn0hHldRvKdFVhDJ55VtDGuOOi6P4QO0
	gS+Kzd9As4HGeccPv9vWNeTU2UCD54cG42aTwWjLAz2P8i7H53F49g5PpBVk/JC816RiFtIsUN4
	o0Q3aGJYsxyfr77mWgvYip0O9jVXBX1blBJW7Cn8HATwvreXVVTCVsZppqk8=
X-Google-Smtp-Source: AGHT+IF+DUySWarTjVDbax0WipWnWUmr3IAi8Ismsyh5rLjk7lt5iY6vnww0yV3GZ+Fljwql2QmO8PvAs1Uull9sCzlzd2U19Y0H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3f3:4562:ca92 with SMTP id
 e9e14a558f8ab-430c525f51dmr87920195ab.10.1760741823800; Fri, 17 Oct 2025
 15:57:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:57:03 -0700
In-Reply-To: <000000000000ae5aca05e68a7748@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f2c9bf.050a0220.1186a4.051b.GAE@google.com>
Subject: Re: [syzbot] [bpf?] INFO: rcu detected stall in watchdog
From: syzbot <syzbot+0bab26cf3949891fb534@syzkaller.appspotmail.com>
To: andrii@kernel.org, anna-maria@linutronix.de, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, frederic@kernel.org, 
	gregkh@linuxfoundation.org, hdanton@sina.com, hverkuil+cisco@kernel.org, 
	linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rafael@kernel.org, sean@mess.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit eecd203ada43a4693ce6fdd3a58ae10c7819252c
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Thu Jul 17 14:21:55 2025 +0000

    media: imon: make send_packet() more robust

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154d6734580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=0bab26cf3949891fb534
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11646580580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: imon: make send_packet() more robust

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

