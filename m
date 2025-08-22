Return-Path: <linux-kernel+bounces-780962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14455B30BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E703AD269
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1F19066D;
	Fri, 22 Aug 2025 02:09:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FFD1DFCB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755828545; cv=none; b=X2UDcZKS8bOVaJU9DrElv3EOI0c3Vm29EF27plRutmcemxd7NsJ/zbDnzEpx2rDSO+vDhU5TMs53dgzgKHlAMD81NMmmInNCxM5QoSNccLogoNjAu2RLkwhSD6RMNYCqSipnD9uAp+uAAWXiiTjhyzUEejjLfcH1gDjNyobzyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755828545; c=relaxed/simple;
	bh=S61IUl+kXP8xqcmJhF6nBdGwu4eLj1fNU3YG4lL+T2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qWVpJbIeYNFbkBro0wus9FgkR4sNfqYM1aMfk1vVrMBMlkx1RLddUOPHwbGtW/LAUMzRaGR/4sCjBgnzIZ3Pt+mEhX7sD/O40R+ux56w0ev9SzvcdfAEz6sjgZ3LDfYE3xy7W2g3OkOVgNkUErjwVIoNzUYTVMLUGBP1ry+UWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e56ff1127cso18972835ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755828543; x=1756433343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WQ6MQEcL5VFAywtLpopeUbAzA9xJqdO7DFRT/zazyLQ=;
        b=L5PldQvgCWLplvuTmiF9yHPfV6AndCPNBm8+Vt/IxK6ebBRyKSbUXqDqqmR1cpGs19
         Aq5UmMTapMyG3I8ofllw0mzv/GWZMzPk4a6WLwxOyUk7mWKJzHk1cSFLIWfgzUXM2IKs
         t5keOdJ5wd9vdFttGgTioWHboNUzhPiB6uudyVPgqWdoRTPlQQ7fhsZvMxEeP0umWdVn
         xJ+1lt6pkYdmlHy22Y3F86iOEYIBV9ScM7iwjNsRKbkR5DYyyq+VYZ2izdmGy5SRvMTt
         i2quITfF4aciIyg+MJwFVrHefBbSA478BbMz8K87zV3exx3vMZYSupxvjR9tAANiwLmK
         xKSA==
X-Gm-Message-State: AOJu0YwH/zF0I+9m0SOil9IArVJDo38tg8LyNq8Ta2S92K+xk4b+xHtK
	qk+4PLLF5/W/Zk4TNs3KTC0mNEQvzNCl/aedI56ZDcYtFZJTKhy4HG9he4WCzk5GCm+9LjtCAik
	x2jgtx09UNUmt59l6p9caIQSXtC9xmQvScKqjg8IZvwov/dLRxEWMebkQ4ak=
X-Google-Smtp-Source: AGHT+IGtnyDs6rWS4LZA57CT9/hs3GMWzArNZK8NRSlfO/nIetx/uKbF4O8aSuZKZsz7AZ72PJfbeSyLDswoit/mwQfkzqTVxmoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3788:b0:3e5:81ef:b099 with SMTP id
 e9e14a558f8ab-3e91f74c7c1mr27778985ab.1.1755828542806; Thu, 21 Aug 2025
 19:09:02 -0700 (PDT)
Date: Thu, 21 Aug 2025 19:09:02 -0700
In-Reply-To: <20250822014128.751169-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7d13e.050a0220.cb3d1.0006.GAE@google.com>
Subject: Re: [syzbot] [media?] general protection fault in su3000_i2c_transfer
From: syzbot <syzbot+d99f3a288cc7d8ef60fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d99f3a288cc7d8ef60fb@syzkaller.appspotmail.com
Tested-by: syzbot+d99f3a288cc7d8ef60fb@syzkaller.appspotmail.com

Tested on:

commit:         3957a572 Merge tag 'cgroup-for-6.17-rc2-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a6fbbc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=292f3bc9f654adeb
dashboard link: https://syzkaller.appspot.com/bug?extid=d99f3a288cc7d8ef60fb
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1206f442580000

Note: testing is done by a robot and is best-effort only.

