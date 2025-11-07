Return-Path: <linux-kernel+bounces-889720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A1C3E500
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 04:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7503AD64A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 03:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B682EBB90;
	Fri,  7 Nov 2025 03:13:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743F718DB35
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762485183; cv=none; b=YMdFNtylfwBIIklhEIQjz+eiFZHj4O/9/6Vc0iGhtQaRDIUOQfbseK0wegvhHgI6Sqn96T/Zxw0ZgLOkPwDHediY/Slz8aArI1NtEdjDB2ZzrBCQOkxKHaTPydk6ll4MLE/zvuK+hDnz+0Qmz7bCm/HaMMHEnO2yTslWWAPRSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762485183; c=relaxed/simple;
	bh=ZXD+eYPOzlfj0DlpLLc+70121fll89rP/Bu5iQ6rMcs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UfQawMnVXV5kZhFzi0QGXqXTNwE5MVb9q4rf7i+4Kcy/DbKMXRjSPc542KnFZmHmcT+eurtBmQ4A6TxXI+7XiXYkY0570uCWxNLqTva10yM1n9Szz6zqEGmT0QddoumNWJsjO6REvx1XKtHjcLzQQQmXS+MYQBA82Lb3O3duIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-9488163e81cso31363539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 19:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762485181; x=1763089981;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiOJZeFzfraKPz8mHbyX0kQZhUL6Ns+eAJgK5yDrX64=;
        b=lUBtn2aGhaSUGOfZYyiL2g9nVXI4kHmQCPlfzeem+jlOPf7L6wkSTvJgI8PKKFyxNL
         e1a4pgddffbohQpGrjcvjwgqNbJw3qDr6BapeMgJiQJB0THuhEFsJz0yxvw3Omg6o21H
         ii7WKh0CJc0zF9xmz85jxZZc8PErqoyVvGCIQqkkpr8PkwCoM/4Dcw1zKQloI+4Gj2KE
         ixqduP9GbMw30hvg4Lazcvdx+JkJVONud7HSXe//yQbK0zhfJ6qU2pBYYxvZ6frqUez5
         oFnurwd+ccQxfobytcRKLg4xTKFF6VeCdlxftm0it1k+oOqFuCeVqNlsI4lrAJ8CpJEx
         jGTQ==
X-Gm-Message-State: AOJu0Yz0E3jnrwbaxvmRZejCkbXO6xyZI5SehkPukE7vv01AkCN4Tioa
	X77UV7J9JayiQAg4gPNxg4dqFdsbX6w5TUepSY9KKTU3jZApQStAwQs8lm5NPctYeXayWObmgKp
	DRLycDjfidMQDvRfjNpPbi9Q0eXbEqQUAqVtwng99E3NpxejofK5Ljr/mqVM=
X-Google-Smtp-Source: AGHT+IGqY8Gc8a0u7BgdVN5wdnHKtDBN6fcqD+/8enA6/1efoIhbmzaA1HQUJEftazgDL7a7UNL5wdq3rx/s7i7px2yzAmptP3KD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3486:b0:433:332b:946d with SMTP id
 e9e14a558f8ab-4335f3a67acmr27030935ab.2.1762485181583; Thu, 06 Nov 2025
 19:13:01 -0800 (PST)
Date: Thu, 06 Nov 2025 19:13:01 -0800
In-Reply-To: <20251107011853.3653104-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d63bd.a70a0220.22f260.001a.GAE@google.com>
Subject: Re: [syzbot] [nbd?] KASAN: slab-use-after-free Write in recv_work (3)
From: syzbot <syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com
Tested-by: syzbot+56fbf4c7ddf65e95c7cc@syzkaller.appspotmail.com

Tested on:

commit:         df5d7972 Add linux-next specific files for 20251106
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac1114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2455df6102bd15fa
dashboard link: https://syzkaller.appspot.com/bug?extid=56fbf4c7ddf65e95c7cc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14701114580000

Note: testing is done by a robot and is best-effort only.

