Return-Path: <linux-kernel+bounces-896953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDFC51A27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3CC3A91C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF63016FC;
	Wed, 12 Nov 2025 10:18:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971720FAAB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942690; cv=none; b=ntoZcT4poVgyMKlVwZYGH5g7PCKWnmpB7j51/x4LDIrZ4YvwSPjM0ZJnay/U3kwYPY0N5wnn2s/FZuj4FMpyrY7DMFsLbAdQtR7xU4gwGwZzSNrVb4wm/7YFRGtYWP+I1NgB0OAssY6EhpUPuvjabJZ45XEg1VAquHagPOoI+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942690; c=relaxed/simple;
	bh=j6zU9E8/y0C65fl0xXr+Lxr++CUVJidoLOO92dvmDk8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nX7CxWNkH0xCWjLYGYONzLYw9b4koyJybIdneDpQQsvc/27itiHMBhWO7eQqvU0faAsklt3fzpFOLHbVuHk3rwO7vIq5kseOS1HR3OmA6Fkg5B5kYVRnvT06GqBO8ltNo2GAvi/hhA9UQveoPty3kZEp5XDRwi282jQmOQBOfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4337853ffbbso6401415ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:18:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942686; x=1763547486;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ydwsIp/N1SK5PZm+wrWCTPbimcP98aU1H27UJH0frI=;
        b=hFdUGww7kGvJGS8EG4ANFSRxBJithF5CpAW+3uOcowpwRb5tDxBI2+4zcjk/1Az9p8
         B74gu/mWhyGOTnz8+SIrP7S6ZjY8WkFRU6Or5gfYmgN5zRRFHMSTLOmWHtHPqUHxmbkF
         Yk2AKlxsfFF3bDURsHO1m40qxW4GTZokC2FLvyHYguDM1rWohh8y0oZVNz3LqbqbnsJO
         hvQDCNgqGu2wL32qFMz6EFyYdI7kgfh7MkifpChNRMh6J0n9gGNOFp039bU6EbxW+Etw
         /E6p1Dbnikn4tELmh8G1Q2yOimGs0U0v1uHxdLhNq0Oxikq0lr2Y2keZ6eqRzEyu0d5w
         AJMw==
X-Forwarded-Encrypted: i=1; AJvYcCX0W0Z04xBVQ8aUaKFkukyTR5xWhlilcIHVGLYvxb0as/KDHFh0sXLU2ZGFFyu3IdvMu/rFE5PkUF3Gu1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+1rPOQ3C1ZsFyZ1kRby3xvKIZvqFohzAf77kcUjPoNz5FYgrC
	upTGbt0PGYaAuMwAIuTFlUHFbBN/rXDGA4FqpLB8DjEItFhhUTHPHdu1xbVzi+hjgJmWa9LC3uL
	EBN6GSqJPz2LJ0onG6q6XvjhJQ8iZR9G3PVDwdlL6HmPa6yTZTGdyrkvrIBc=
X-Google-Smtp-Source: AGHT+IEwCOorlomunj5Yu48khKiNlihTq+cCIdqellMLyEdeTyySXda6PUSFEaJFZ+u8spiTznag8gxrG9VrgRzdhpaci7YlA6iC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3789:b0:433:1b32:2a6a with SMTP id
 e9e14a558f8ab-43473c56168mr33335085ab.0.1762942685755; Wed, 12 Nov 2025
 02:18:05 -0800 (PST)
Date: Wed, 12 Nov 2025 02:18:05 -0800
In-Reply-To: <20251112-ferien-trott-4d99d59d676d@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69145edd.a70a0220.22f260.015b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in nsproxy_ns_active_get
From: syzbot <syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com
Tested-by: syzbot+0a8655a80e189278487e@syzkaller.appspotmail.com

Tested on:

commit:         53974b87 nsproxy: fix free_nsproxy() and simplify crea..
git tree:       https://github.com/brauner/linux.git namespace-6.19
console output: https://syzkaller.appspot.com/x/log.txt?x=143dec12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59952e73920025e4
dashboard link: https://syzkaller.appspot.com/bug?extid=0a8655a80e189278487e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

