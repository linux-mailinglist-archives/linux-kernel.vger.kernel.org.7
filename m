Return-Path: <linux-kernel+bounces-722676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF138AFDDA1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB6A3BF7EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AAF1DDA15;
	Wed,  9 Jul 2025 02:45:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA151D54F7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029104; cv=none; b=aQXCtyebLMlk/Z7k8dIvRzfuiphJtJBFAeLBrN1ee5SP13BvFhp0KqTajs9qPqMYeij+RCAPtNNVBVOmnzTxG1+KycOjdhXusEgGSbl1gY25H7WLZUCdiRU3DOJyGbmQtjJqKwHwzPRoLagwYOztY/cqiFhodPO+Njsblk8IG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029104; c=relaxed/simple;
	bh=dV7QteIn1fvobieIXO25O8Nx2HJcwpcMZ5rTpETa0JE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=peWdWGqBuTSUbDXxopEnSsb9zBqV5tRnJG5pRVU7lQvZSNafuJQYl730sUSoG6+hHKnN607S0cq7GwAU9vtHRQKsG3xKLDk0RzMKRTHa7Q86CzzHgiKIL/eW6LRqcjJGYOZn7oUUg83FjuGIMl6u0eagXU3+A3rCrlPCSKZ87UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e059add15eso56307665ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 19:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029102; x=1752633902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ICBu6x3s0/L23ouilMWSOGpzCOfNBr8wvBjMfUrups=;
        b=oN90OwZ5w5tr0hB4vmrlwXgrejjhFIa3UrkcS4X1+KBa0/+aEL4MogE8ETgBy85XwB
         R+uUfMNPzvTWEOAVMgOdxbL4GG5uk0utBUL+060XCmKih/kQ3ACWgkDHDPOUwDQfAh64
         BpJmpXMGtHPYalHTbDgki+G0EvniAX092pyss6szcyxi7jFuVzjF0jmHXz87lRPE1XFe
         MBI9RXM++yxEB9nBtAEFHy+dbGDJggdiLng9PnJyOJHDFazQdkb1mDK0/tEXkG8bLPq9
         8gbuRvOZpwD/pvEWpcm5BjNy8S8XwGSL4qOalzmmD61H0/CQg9Ggb6TKZM7lh1bPPVuu
         ib5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6CMVhecf6cM+4Ju5W76Ib56TLb2tGMfQSL1XfGwZZVE/duVzR1R8Mfjkhnk5TG47CTDXfFyh3HBkBQr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hSltyMT68CvJtZMyFlyotv3uh2u9nJDjsVtedgCuj7rdaUR3
	A8ZRgn5W/5C/ctm8czBmmKqVrA6JaqelbCwFVRjzGS424YQJC2jAaJTciTysY1pDrHECKprpoWd
	JV+qSAnSjGj61zPY4vjpG43VO6lzrHdUB3zRNXsme1dmiA8Y/5amwtUnVXLg=
X-Google-Smtp-Source: AGHT+IF7xhD3qUKq+LRF9MmYotTd+jfM+1zeSVjiUxO4BMLXH7lPYM3bYN8KKymvdBDe9zKrdMsljmYX5tdnkKOMRDAf3Jr30Nvj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:3dd:d33a:741a with SMTP id
 e9e14a558f8ab-3e1670e345emr11982005ab.18.1752029102057; Tue, 08 Jul 2025
 19:45:02 -0700 (PDT)
Date: Tue, 08 Jul 2025 19:45:02 -0700
In-Reply-To: <20250709021318.3100-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dd7ae.050a0220.1ffab7.002c.GAE@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbnet_status_start
From: syzbot <syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com
Tested-by: syzbot+3f89ec3d1d0842e95d50@syzkaller.appspotmail.com

Tested on:

commit:         d1b07cc0 arm64: dts: s32g: Add USB device tree informa..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12c38a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28729dff5d03ad1
dashboard link: https://syzkaller.appspot.com/bug?extid=3f89ec3d1d0842e95d50
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104d8a8c580000

Note: testing is done by a robot and is best-effort only.

