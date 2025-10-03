Return-Path: <linux-kernel+bounces-840976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EDEBB5E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 05:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B9EF4E4767
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105EA2DC789;
	Fri,  3 Oct 2025 03:43:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C71A4F3C
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759462985; cv=none; b=pnerbaEElExa8V6veW4/Q7oG+bogxqh6YYRCz51IyJ0GTCDCfq9+auZtvOPLY0S4xErj60J9N5BXXjwa9LmKodfwH1BV/P9TPVfowXG1zxlhuGKr60W/QcVpMCmB7pGNUzYVkYDG/e+uI1/ttJaX9oQL2fc88bpnVCVH8AkCfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759462985; c=relaxed/simple;
	bh=cVjQy/7qwMmJlYy/3NUiiTxwieSDVla2g5r2AZ9QSTU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TLa/HAY2u9s2r3bOOtm1ReWgw0Ea/IpX8dpQs3LqzXRrDuTgC5ZoUgYJfUV6CjycjaEyjXCQ0XpMGrXN80NjXF9Y1vDwPUrlW6YBOOGJZZqLiJBwDnJWhf9BADJiazwW6gBUJ2koDToAKxO0kD/8jqWC3jaqT+uKfIWBdpeoHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9228ed70eb7so449886939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 20:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759462983; x=1760067783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvMaN8vnPZOIjIRCqhvtmxIu+CBaNt/uIYJfo1m0LJA=;
        b=j9zTt/QyfP3Q2Nf3F7bpk95RSorJ9GVFgCc2BJ1o2JRKx1vB/Q7SUXX/1LyVrJ1NHv
         hd0m2jF9a+KwmKU4NQmDil34Vs2LkxbD5k9jcPySCnZm79J43mk9PwBApTdd+o74himi
         xlHntAROCpdqVUFbFehJnJ0X9kue2Z6DjD/fYLz/iopJtih5mHsr+9NAZnnJ/MwEgYDq
         nAof3FMn2+Clegj2cK77w40hJ1KEfG1xyYTC8NmpD+xFKwtwU2a7t3eqbP6hjCd1HDwg
         nonF2qGLlqOk7gQncmdrM/7eHwQsz9eTXmUq/UDX6cZJJweiHkInIxUqvZkTZXxOzTLa
         /bSw==
X-Forwarded-Encrypted: i=1; AJvYcCV6vffIrLa5oyTYtMvMqVZBdsbtK50ZtrjCpn7DFVDfBy5w38sam6g9WBGkEB6PPVXltDy8Znfp4OK90gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+PFvHbUzZoJl9oS7lLuZTaiIJ4MafiP6/tYZL4Y5kVQNjaiS
	umSt1SSrMixmHIHU091xlZXO6GXqc9VFvJoC6bChqbfqDmurL/97hMmFr7E3dvf6KH5bn8lh2Is
	ysuuxSIpDrmZ96DYwfAvQfvHXhh6RmkLy38f63wWro33oTxdpECFNDLQPW/8=
X-Google-Smtp-Source: AGHT+IESqHp/IZeWm743pf14s8bnvjm1lMGCyYgI13FyW3imWccj3JFEUXpF7/SLP+jG8fmXZVWmd1zaFrGjfAnwaJvcsiC7aXPO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:a011:b0:8fc:4226:5d2a with SMTP id
 ca18e2360f4ac-93b96958aa6mr179002239f.5.1759462983351; Thu, 02 Oct 2025
 20:43:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 20:43:03 -0700
In-Reply-To: <20251003031625.2411015-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df4647.050a0220.2c17c1.0015.GAE@google.com>
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

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115aa85b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c6aa7c580000

Note: testing is done by a robot and is best-effort only.

