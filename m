Return-Path: <linux-kernel+bounces-788907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC282B38CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84401C248A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B42B3112DC;
	Wed, 27 Aug 2025 22:06:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B8B30FF13
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332368; cv=none; b=fhqYbeNzQ5Et5VKUbGrgo4rOWNUUK1KlSYtE5WVYgcaqNxw1x24WZCbY4YR6OkeyXICne48Mkpd88C4ftC8W86EjzJDVVjswQaU1XZQnwbf6RkY2qrlHf3rLjo9mNgMDbMVvVUYaGk6WpEeaV/rtoZkZH8mogH3mAZZaiVXYgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332368; c=relaxed/simple;
	bh=zugtUmFKmXUd95pOWvG9+eJCUFGrAuXFxJ0SxcIPf0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jSWfPeVWRqiRpnBz/WhouiDS8ULgit9sK/dancTSJF9e6TIsg2MKEXj1ZJs6YJ47gxs3muyv/UrpoDE7zbCVwV6poTURDF9OcSSzS9qaNDytzOv50pEmDQlI5A+ZGGmFhK1zkUYVq1LmJdy0H1PBK5hWjYC85f7nneuFbSX3etk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eefbb2da62so7781145ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332366; x=1756937166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJ679Bni6XBtGixE+p5QoNP6CexqLcPmE0YL0e5I7yA=;
        b=SaNM6QHcfERItkeR8N39Os1g3cycN8pn2W65MX2+XUp7wIvQ8g97veq+JhXhYBHN8w
         B48xZroAq86GCH3r5ngWBQ9XTawZIH0OlEXUuOvqONRVF1cHFlDalIjF7D4gzptny5U0
         +k/F76+LBu0KHlyDrn7BhTuioFE/GF2fgPDQdho+X83Aa8iPz//iTKCLkKl17rQsIGJ3
         ek43KdznChhVAF+5qnkqlXUs581DvCjGDNH0Z1XzG7O9NEIlG0r0UJyj7daaNzC0pk0U
         fKgMjwW7LzCcIrpAVFTtScKGhUZoltUd0Kvr6DMLf3ETXCH6ZIG/bEUbQfryACdtk7VY
         zoDg==
X-Forwarded-Encrypted: i=1; AJvYcCVVzTKy6WeFQOTm8U+ynWezsyqgrkvHsRYBktOPBxzQXm42D69+T3gu0lBJABTYdgUrJrJ/K9N7271izhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqGJYcxLuNvKzdX9/sSRTX7FYzKvpyp8WjAb+bLl4G0PdSjcF0
	EfFWU26PW0fMqIxUlO4SsA5XR9PM0PxwFGRIvqCpdhfiZeRd3hH8iEhX87UF+/N9uGPGLyVDhXl
	+ohbVRl6LNxjegcO01VMvthyRCPVz+AvTk7eGwIBynLGFUJwxktMAa31HHTo=
X-Google-Smtp-Source: AGHT+IGMKq0uOwnSxJdctgT8VvLStiCZNiRr0oKXEXlFnOuD4HUM01ThZw+YwaoAJWuJJEHbKqlyv0KEFqCXWFb9Nn+Zxv+c4Gey
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4801:b0:3ea:8acc:9dac with SMTP id
 e9e14a558f8ab-3ea8acc9fa9mr214136735ab.2.1756332365874; Wed, 27 Aug 2025
 15:06:05 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:06:05 -0700
In-Reply-To: <20250827213813.5905-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68af814d.050a0220.8762d.0000.GAE@google.com>
Subject: Re: [syzbot] [block?] [ext4?] [btrfs?] INFO: rcu detected stall in
 sys_mount (8)
From: syzbot <syzbot+4507914ec56d21bb39ed@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4507914ec56d21bb39ed@syzkaller.appspotmail.com
Tested-by: syzbot+4507914ec56d21bb39ed@syzkaller.appspotmail.com

Tested on:

commit:         fb924b7b change_mnt_propagation(): calculate propagati..
git tree:       vfs-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=120adef0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e92a122a0cf6f2a
dashboard link: https://syzkaller.appspot.com/bug?extid=4507914ec56d21bb39ed
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

