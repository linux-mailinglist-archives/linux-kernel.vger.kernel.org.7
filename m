Return-Path: <linux-kernel+bounces-726568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D8B00EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443A21C251C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4629C35B;
	Thu, 10 Jul 2025 22:38:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9A2951B5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187084; cv=none; b=aHBV9/iYHxY+/6Dtu7+urvZdcBz98D1LJ3p7SznOFvNXn+8kCZBY0n1N8ERSEllrrRpSTG1A2MhwPmtiubqLCGPqX1EUicJzvB7a6N8L7Zp47hjUGq1q31EewF4udH3PsPYi3ZFy4Q2fCNejZ18yEHG9KM9XXgmioHqsHXsFFM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187084; c=relaxed/simple;
	bh=vv+yCUcoaHxQ8BBe5s/3RR+FRvvf+feqcFxvt9Jq2+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h4lVUUJ3C3L7PfKdXMmXbjKmsyqOmaFfwlJi5HF2lz2cKTeDcdTcqdSYnBL5puN/hC3zuXyhN9eMLEyy9cJoc5UohoiBY7RS7HZUCYph3N82KSEx0HHKMmE6A5V6PvioPWoTjEZOD6viWaNYeWs16JR6eZyi9hKx0cReCLj/Fcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3df4d2a8b5eso16539485ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187082; x=1752791882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aj29vt+eYforRhHdEWSraObRQ2gLQ7p0Ps1ACKxNtZg=;
        b=BDMTUnYy+wrd9mggWztdvV6l/AwS9FXHkmcWkRU+aowue+B+4sS1D6n74iAR/2KQ0D
         3zEsImMu5dktWlWrBzeNY95Z9P6jtebmTPqn2rHGDwWsLXQaT+Br9zrTSuiOWHtoG8qi
         vpRLkp2mT09EYNZlArTrPoVwOt+Wxt65pN/T3hVgnblUDZTTmVrX30LezNpWya8EuJTn
         t/CT9g8OE/bkDMGkUA1WRbV6oJjHlFKiLK1qwMzs4T5KVkZDUUFx1b4UE1rIfSCnO16G
         laXODgSY3vb/qHYT3JPBAuN8ozYmW2UQ4hj8+W/VqMRXnV3FkqzhVzGf0d9JpSW0xEbE
         +L2w==
X-Forwarded-Encrypted: i=1; AJvYcCU8VELkmzhAtrWE5nWvOPoodvjwQ6vrNj4l43bvy26J+CMLsWZSNDL+vu+q+U0QALfuOhSbM2JcjME8w9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2pFOHU9zXIZJSOh0J/b3Utz1D7XLbTRA4z4gktS+0hKGVIRL
	wXm58FUliSG453S6rXwAn3LpdYowWxQGoTYRR8VGKc9Qts0kp76cIIXOnDm5MuHElmHIjY/X4P4
	zo5+AhyBEAGqse3vdy94sIaRCs1ZLiKTfVL8ZWFjoUpNQvt+OnuIln8xYcqM=
X-Google-Smtp-Source: AGHT+IEd8YEDQvvTzY8O4EJBGgqJDoflCn1y+Enx80RqfvrXqsj0OdIZPl1lEg44ay6PjOPxD3HyQDgDAfPqWV1XkKq1VOVQa7KF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2304:b0:3df:4024:9402 with SMTP id
 e9e14a558f8ab-3e25421b24dmr9038405ab.8.1752187082146; Thu, 10 Jul 2025
 15:38:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:38:02 -0700
In-Reply-To: <bf1b2aa4-9ce3-4ad5-b0d1-fa379b96c9a3@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687040ca.a00a0220.26a83e.0026.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] INFO: task hung in vfs_coredump
From: syzbot <syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, axboe@kernel.dk, frederic@kernel.org, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com
Tested-by: syzbot+c29db0c6705a06cb65f2@syzkaller.appspotmail.com

Tested on:

commit:         5f9df768 Merge branch 'mm-everything' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git --
console output: https://syzkaller.appspot.com/x/log.txt?x=137fc0f0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44a6ca1881a12208
dashboard link: https://syzkaller.appspot.com/bug?extid=c29db0c6705a06cb65f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

