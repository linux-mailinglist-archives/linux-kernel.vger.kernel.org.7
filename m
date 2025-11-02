Return-Path: <linux-kernel+bounces-881920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D60C293AC
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 18:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5062D188C557
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8A02DF140;
	Sun,  2 Nov 2025 17:27:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A678A2DC353
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762104427; cv=none; b=uHpdzDq+FnsgPKynB5CTAXU70qVQiDpRvNsXNHkd1hFjwwWiQGvkRrW/brJXh5e+zamWBEo6rPudmU3ChBYb8To+Axqu70e/Vs0kd/wO8I+sg3ZrG4jHQjshxL5c8anRYE3qWS+LbzA/NSmXkgjBvi5gY5M6LQ1nw6FB1A8ZSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762104427; c=relaxed/simple;
	bh=bq/Ionq38JnMe/TcV8fkFPLnY5/3D1nSc/BzHNAm1rw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KmwH4x2/BZEvdFT+2iS8jTdEzw6uVWFOhUFZ+QmPiIcrbdsKcLMG8/FU35z2z6G4jqDDvDxiy30/FLmDhj6eOhJdy5vIGe2qy1Tipvncd+E+r+DhzZkhAElApaVl5be6QCkPo3a92GjlV/uLEAtYftp3xV1vayIraDHhvr05p1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43322b98837so9595735ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 09:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762104425; x=1762709225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/0hZPD2u5t281eY9dAujEDnJhbpbeKLZ1cEskV+fxk=;
        b=qfj9ySC9ZmiuQTYOHkYbR2oIH9o4L5uBL5jjFaOojRPyO2uJ9/J3XpLOSXlhcrE00M
         RCXGuijVI8puTCYkbl7b2m90ueUilnN94QGum2QcTXFWS/Oa5ezMZkaGU2fRomHenrmR
         GYI8ysEGX8MZr9dqNYIpbgVCOBfQEafqzKcr+Rs3+qtfkCD2GJfs2J90jpP2sjfpXUqH
         +kIV3iVWO9FhbNaaM6j3xrqwnvaxjyj7qPhRel7V3H67G2GLfug3DiZzcJ/wtMpdx5hm
         FrPoCwml221jQ9RXWbgAiW/dc24hTAZO2gC7Ev+xsvZC9sbP2ZB0BTYWMJ+XnMHRxwWa
         K3bg==
X-Forwarded-Encrypted: i=1; AJvYcCXQc/3ZAuy40rKXX+p5R0xfDe5AU4wTeYoFF+TkjyKwIYxftT5kGDdvkTi0bVJhDG5FocjJW3L7ntxtrOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgLLKS0Z2QAqxrybjzLL6wz7Rg6aFRnr3GhyOrM2ip+7I9mlWS
	/fdWqlkzu42+EfUB/qLjLn6/8E/nT6VSBu7PwxspI5JtS4JnrFB84tdgd/T4ci5ip+nlgZuuTbM
	J9twjymYxZSxQN+W2CSdHFlfmwCPMbfApOBagzvozit0LWbbMlLjb9smNJnA=
X-Google-Smtp-Source: AGHT+IHk3wKAN3cFQiXei5+KsO3m3fHpmGdsA+XQttZssaFd/rp7I+908aJ1UiEFVKAyEOTYW+Fiur7y0rxXV7FDN6ik5aXK8hY+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:430:9f96:23b9 with SMTP id
 e9e14a558f8ab-4330d10ab0bmr151335155ab.3.1762104424817; Sun, 02 Nov 2025
 09:27:04 -0800 (PST)
Date: Sun, 02 Nov 2025 09:27:04 -0800
In-Reply-To: <196626359.3484070.1762102724022@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69079468.050a0220.29fc44.002a.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
Tested-by: syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com

Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=150ea012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=824b00f06adfda3c
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dcee14580000

Note: testing is done by a robot and is best-effort only.

