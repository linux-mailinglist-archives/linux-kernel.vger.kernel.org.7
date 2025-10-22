Return-Path: <linux-kernel+bounces-864677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A96BFB522
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DFCB50801F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820D19CC28;
	Wed, 22 Oct 2025 10:09:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C4C3168F8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127744; cv=none; b=Le2A24c1Ujo59ORh0hl0FW8ippUbZf6RW58Q1ei+pbz7SnhgAGCjym93rUapwkY4TReANfWsNKDtSIBUNqPZggXszXFakX6oXXOCiAFUMkLcm64Wtn09V/hO1CFnwV82R9t140EMIdsPjTi7RSp8hj0d9k7mXDvqnpIwChybVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127744; c=relaxed/simple;
	bh=aZAGFJfp/MBBgSkq0BF6H6LXQVTg3SL+3I6+A6rzAwo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C/FFcPW+mkMAmlsBtgiKHzds9mxER89SISjI4qogWvy1Satn6FXngcLeOLmlKjuw6+z/+D27tMf3yBFrZvd/8yOrAJIRUOm3hFycYOBkJz8LuM1vhehsVbXyfu2+aFRN8Axp4YbTysYd3iDr9VhFHpwXf4IHJgyak1kcY4kkccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430bee303f7so208020585ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127741; x=1761732541;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xsrRR48PD0s1VvuTmihRLJlFX0Kb4jTgCxyBlTJO+8=;
        b=V7RklLuT2efbYgOlVuzxLvdom1p2ygQh3MYJ8GqLwV0NfRs4jZ/anLLT7CAb7ZMuOA
         fyMeY9oJJoUQvKnzgr3H0YFzEFwFejkQPJuMT6yOyv/bqZMmOHdMYMTlASYTLVUIiCFH
         ePXttOAPx56T0/NnUdBLovfVp23zoJ30N8wfLEnbzMvKbH164lYuUgI6FYdo2RVKVsHH
         a09cT6sXUnKiFSlZiEKtUjPo2zrHKG4/sykh39G5ey7SKdS0VH9MPtaaKB3k9AGN8xNw
         4CLrzmnJKchnKJEJeEStl8lSABO+fj9eM4xvNlRdsqNADxfZp51MCmsaArSG5SYR+BFX
         G99g==
X-Forwarded-Encrypted: i=1; AJvYcCVxA2mnP6PJFZ162Cqq4wItX6ZLEV8XGOuZjiQRaln5Id1gMxML6ll1a5GZ9XZ+dB7eqWiBSHkOMkI3whA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrkdvVjve+EyXVG9qSAqOEbRQR6Fv9hxdOzrMq1pAVf2P2LCw
	dWnJnh/Q9AQVij5MOXvRYQIO0shNWBa/b7oZDUI98fbcjRnIatczxCphPJN2mZjWrTfNx/iwz0I
	4LR52aI6CIz3kw3HenfUcmuqhLWdJ2lZrEjy/JVsTVe6a+lajABCNZvrOi9o=
X-Google-Smtp-Source: AGHT+IF8gb6OtKvsarDywe1nOwpYk0pKXabvBNYXnEq4eHpi/ecuqEqc2dzdETICU/buN0vmEtdt4JH66PSf73iORmETDz0l/zD6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:300a:b0:431:d864:364c with SMTP id
 e9e14a558f8ab-431d86438femr2807355ab.17.1761127741749; Wed, 22 Oct 2025
 03:09:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 03:09:01 -0700
In-Reply-To: <20251022090931.38191-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8ad3d.050a0220.346f24.003d.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_rename2 (2)
From: syzbot <syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Tested-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d7d734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9a2ca2a8964bd4a
dashboard link: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f0e3e2580000

Note: testing is done by a robot and is best-effort only.

