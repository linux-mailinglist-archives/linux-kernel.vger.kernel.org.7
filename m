Return-Path: <linux-kernel+bounces-881810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DCC28F77
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 14:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E964E4FD0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 13:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774A17A2EA;
	Sun,  2 Nov 2025 13:26:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC8A48
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762089964; cv=none; b=b2JD3RezEm3KKirun94E3naRsiL1U5kF/aR1HGml1xT2f0/jdE/kgmzGxvpqsIKq3e1m1PSXGYPeUQgDoYElTCcdirwPAoavh422n3jQd3BalVM+WnsBtFe+zHkG84vFTX5aUjqUrzhxyWFG/VmORyBcXoU+6rEnjkTLHYVt14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762089964; c=relaxed/simple;
	bh=M3iRp7ft3G6CwFrUCksfLzj5enazkGqsuYkuabbXWiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VqW/zrMTDpDbPceLDZFX4Ip+0cNAA/5W3EfGz/eT198jei0OHyq1kVDbL73cU3dawT43h3aIxqAZvWBjPMOHlk3J+jFuTt+t01Nk9sxYFDZu3B0uC/qytfHX43oVt/iBGMiEh9UgMe6+jqbL5q7UOzP7lF6Tws6NBfBQ5TL6p64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8839f138so368845039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 05:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762089962; x=1762694762;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3eVlsaAfBOChCSZYsu148jLKJ9zXrHyPKsJlogRnpY=;
        b=O1yifKVp1wlZz+YuuPpXxdcEtde2k+dWDT1VkeT0Uj4mDIw5mo+HSPPIuI+QoagjqM
         VTUWZhlaFnwEnjCtqCa3IGXFXA2+SluBdQapV1jdD+A1qnZCxKfJIbTagLMlICvTZxgu
         cMWWKgV9DS4k3cSZfM8PJhYs4pY/lZZ/fsMNDLqy8qce6GG6tGWNOZRw9CHaYPk9LX4/
         DlBusaHfxm/Fnzkt3jA4oMIJx6ThOtdk174wheXdysDriR3ECv19SSFBYj6aclEtt+9R
         iuKcx94MXZnG0VwfaT59T3fflnAJKBRTfQpLkJQEKenAglTPdfLXq0MkcM6I2XhfSEHb
         p2pA==
X-Forwarded-Encrypted: i=1; AJvYcCWF1ofsfCuwzQben6kSB77I5CQ6uVy+1LEOb1oj0OXFnJ2N/uM5ysIy+nmff6yFYZnfn/8lXiJ3qaGt/jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV4ywFJ0y75kfc1vkvx9wJVOvxksQxvT0ipw9UImvCQkkDqgbd
	nlKPYvLcrmkK/nwS09klZZTX5UjoA8j0y/BCpuU9PEXiNHC1UBXDaJuDH3NGRAe/blmvxALExbp
	GT4j/DpwRn3hxGcQR4j5YROLHI66GwjJ01I1cF5WlNFPMX8esidKHOtmvDv4=
X-Google-Smtp-Source: AGHT+IFOg65B6yhxJ3aHy7w1y9TYqy7TyOcdnxkRwKnIvTdzEbSR0MruQuJYXGUOp2VSex2rGMPAXoIIDOu+vXj5dtLWI0aGVl8s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cd:b0:433:246d:283f with SMTP id
 e9e14a558f8ab-433246d293bmr49224185ab.17.1762089961964; Sun, 02 Nov 2025
 05:26:01 -0800 (PST)
Date: Sun, 02 Nov 2025 05:26:01 -0800
In-Reply-To: <1622468023.3430463.1762087634086@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69075be9.050a0220.29fc44.001f.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rmdir
From: syzbot <syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Tested-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com

Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f9a342580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4217fdec651c5f4e
dashboard link: https://syzkaller.appspot.com/bug?extid=4e49728ec1cbaf3b91d2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11376e14580000

Note: testing is done by a robot and is best-effort only.

