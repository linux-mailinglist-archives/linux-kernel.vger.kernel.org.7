Return-Path: <linux-kernel+bounces-864401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D0BFAB37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2567C344610
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58132FD687;
	Wed, 22 Oct 2025 07:53:31 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCF2F5328
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119611; cv=none; b=itFkuWshjxNqgXRhkvamuJKoRneT3aIylhEuAEnih3RVCq6+XHLoSnVs1g81E6YJfAfBQt8FLmLo2XrsHGLQX4EwHoePhpVQ2h6WwllfHQxHBWodcdVqNz30BIVkGGYf/k0BH0M9RkHHAYJkgqjAEz12uB1s4k2Hultv9zon5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119611; c=relaxed/simple;
	bh=ufaQz49n6GDzpdFGe7nVKvW3X2a8XA6eNMe1oyPxgyU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UkaDXml+MgjmLG25Hl1WRfCwQqZITNK2IIj1g3qNjRIlVcErfUbhdrC7d4NpUGq4eddUlK3dSP5Y4vKFS/IkfXQlcg1GZ+fGIuLR8+dhabKcDvomre0zDvJeZENqFlIL0blhqHiWCwpuMPAwR5XbrGmSNwaPdWVZIqAFlpLDO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8870219dce3so691166939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119609; x=1761724409;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BZl/sACGkzllJfolRARBo2gSVYuEA7sZCtXyyRozaA=;
        b=pkeDEa7Z0FDXbGWkF7IA+lFfoxpClH/QZDnI9BhnYKC7ZqQjmLaPLHn9u4qyJ/isrq
         8CvG5VfPP1gN7sdQ25jkdjEdopM8UhIQ9FsUw9xjbdh9UHE8TqLkJO/zzNCG/M3ck7e6
         54ChNygUhiAZuj22Oz09TSV4lFeRHgbnqYJYGNdXEpYpbmBWZSp8cDYELIZy8Zk2gJ8M
         06lty+Ri//wRRLEgR6Z9AN7vYJT5kMPoEQORRbbbUiXiQOll4TFP0sMS1nPGy2nripD2
         lJsiyR3K+y2wJnaiwGxPgmM7UvppLlR+auqjJD4Eh/QPM9ZXiGeHYpB4EyPXEH60+jn/
         MloA==
X-Gm-Message-State: AOJu0Ywg4TdvpikrL/m7Gm2qe7EJq/s6sZJ+uZgBYknRx+Fb4Nifxd93
	ekvkK8gL4VGMM3lgjnjmY5Y6BPSbHdrbMgOUaFqfeOzbSqFy+IJ3SbZ2KH3x1Y8sBec03Kwcg1k
	Xt+rkKoAfqEERkIJC4FroT67jSJqGVlKXrsq2nb88gRwIjtk4d4bIMT0DPyo=
X-Google-Smtp-Source: AGHT+IH9xYY9rCes5+PP6dDPXa/IwAKtwc/tmp/IjLpaD9sBIBOYjZMLkWP3s5EMxOBU3H/gGQ4hdPoWGEccuBCz8qS+ALCwTcPJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d8c:b0:93e:7edc:12c with SMTP id
 ca18e2360f4ac-93e7edc1fb8mr2484491039f.0.1761119609102; Wed, 22 Oct 2025
 00:53:29 -0700 (PDT)
Date: Wed, 22 Oct 2025 00:53:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f88d79.050a0220.346f24.0039.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Oct 2025)
From: syzbot <syzbot+list414156adcf2ae8feb6cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 3 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 75 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 111     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<2> 34      Yes   INFO: rcu detected stall in sock_close (5)
                  https://syzkaller.appspot.com/bug?extid=9a29e1dba699b6f46a03
<3> 1       No    WARNING: refcount bug in sctp_generate_timeout_event (2)
                  https://syzkaller.appspot.com/bug?extid=b86c971dee837a7f5993

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

