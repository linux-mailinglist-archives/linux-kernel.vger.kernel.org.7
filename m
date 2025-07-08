Return-Path: <linux-kernel+bounces-722551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA7AAFDBFF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925433ACC6B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBBA23D2BC;
	Tue,  8 Jul 2025 23:55:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE14236451
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018906; cv=none; b=LGcRj/qgtajJXUpnrEgSwnOsHRsm2nrLsVzPSxykETRwE//ohrBtH9Kn8bbUKOF4mf4LPT6hgAroBxp3ELL4nATOomcj8n451P3+bLXcgoCQG8a2z8G5xmer+MJYL6F/fwRHCvAcB9x/keQz5ln67zU/o1w+lqbYGr/smQY5rvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018906; c=relaxed/simple;
	bh=wQxWK8jBvglI2zvwv6228wj6glSdtDhMFKEyulOd6Uk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TwYsbTFdjARPaiw6SRsVuUcaT3AWOQAVlPtkc5m6Q0qOix4lQFvWAy/B4U1YqjfcrYZ005R7TZ1cz9TpebwZgnL2bQvqpNfo+Wx1WudXdJHXWVszTDLttgyUIi1x0pu5/N6ZIOEpaJ2WqDU9DPZMgMXZ4Z74otlHZvOU8DCEAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df2d0b7c7eso51684615ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752018903; x=1752623703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0dogU16f7slst3dKm7CYnYhI8NIlC8uvBFGVNrpma8=;
        b=jxAn/7qn+hvPpPN26gbTipq8SoCVWszMgJ5AePwQzoSEX17+BJ0W4jh7yyvZkmh9Bh
         Z0OzFw1nUVJA3eW5Zo98yAy3ZL5aSCI19BsjLUHUUhWQYMRRqlcGJKLDhNbHdnqTDxfU
         /ZxXUwX30yKOfqZ96BmtlkKtkXUA3KqHJ/w9GxJ90opLqzT2uXQQY0bzTPG7LKWN4flk
         AZYVOnJfZSsdZgHKRqmnzP44iY8OguIjM9mC7kEIil/e33VexOWl0pNzdeXvS2E8ZbDH
         TaKPMFJZvbmY5bFikgn1AuWHKJC/QIpIjLFeRFbOKP8Kq73DttL5me42scx45f56INmo
         k6LA==
X-Forwarded-Encrypted: i=1; AJvYcCUT6DQgyR5r7FQIp14r/6vOemwoV/gz6hQFI9rVV0TFI2yzIfZdtC2pRxRV284ZehCOs1IWSZf0hQ8Xuf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKChIY35OCu1PcooyDjVWz8DvWaN+5JF44uBvdU0wXv+61fxn6
	cNUEImIHoq0HOegXFZIdLLPZKjfLetsGpUOU/0mAEb3o5PQPIx2fWHv1WKQ8Jqk8hQkYDovNkY7
	WSyhWF2PORcdVeFK1S70SZQHezcRHOy/lWzvpPFamrhTg+0SbZixdSjTJHus=
X-Google-Smtp-Source: AGHT+IEeCsE/9d5kZQOLQz9zCsrOEREOlk+pn+j4to8gmRcKCXkSndmdjkfK2hAzPunoPRw7+j/ICnzmVVJAh8c3NFUgXCiqR16Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3df:3598:7688 with SMTP id
 e9e14a558f8ab-3e1670fc2bdmr7126025ab.21.1752018903099; Tue, 08 Jul 2025
 16:55:03 -0700 (PDT)
Date: Tue, 08 Jul 2025 16:55:03 -0700
In-Reply-To: <20250708231926.356365-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dafd7.050a0220.1ffab7.0026.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Tested-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com

Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17268a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fa6bd4580000

Note: testing is done by a robot and is best-effort only.

