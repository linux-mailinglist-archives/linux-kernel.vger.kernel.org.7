Return-Path: <linux-kernel+bounces-876643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4CC1C348
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C00D45A0BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9E33F37D;
	Wed, 29 Oct 2025 16:02:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFD30AAD6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753726; cv=none; b=DhMTanWzVFydZ3MvuVjpKCKfBIC/dN/kEERVrtxcRy3C+32w/PK+hcHf7ncb3FV3EvMSSx4vNJ5H+pOLegxM69xEbaTAnSGu2LPtvpevXfJzWZEzayA+0umzyopaoOSxaDDKgWhBEULw5I3JP6UOtwUd4hng0vZznMC0KE9+bF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753726; c=relaxed/simple;
	bh=zryJeOFIioGRa3ReXb5nBHNZ/8ebazhRhxeVr7WRTo4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IXTpcQTf3mwvbwb9+ZiwXkKQg8LYd7GhJH/k5tc/o+ISojfoF6K/nzTFqSczmzxAOp+DsGwOfs7q9LBPv9sjH20e3VDWKhktpweGSllISf675PZnw1ye9rbFiRBe5s25NRbyFr3lU85s5ykGWkBJwyW/KBvZK6xwvHYEeyUNwEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940d395fd10so11737239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753723; x=1762358523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgxe8fqHOQwwzuu6r9RZwZgaplbJltlwb5Ltfe8xl5Q=;
        b=G+6bRc9674mR1QJDl71OaIh4t7JhffHAPQBBwQ482KdfG/TkVzTdYWqyAHLtMpYjhO
         YTZGMe3VvBDBy/Kz8cm/cpwMoFjSR8ZBXxXYyR41d17Htm26iz3/vxuJXRrK9lbTx5Uk
         q3lQ7q7G/BY9xyV85p0TkwfCXDECKJP0gR3lNFmbo/4pO9QdULPAQTekVfC6mBzXSnO/
         t+18hKmKdCPCToreHsFVzEeSAhAv/2lC4tK5oKEL0PtwzXNd0Pp5hXYJP4mOMK4W+ydj
         6/6Iqdm4jocO1Pf/2u3Tn8+hlf+IbkzBQzx3qJLZpbnoRm43MrKmwB80MlhNXsXlV4oY
         uElw==
X-Forwarded-Encrypted: i=1; AJvYcCXuZ+CrP7dkJiEYxawdy4m7jTLDAuKnG8tYwakBaoRHqN4HtYpJZLIyNo84x1Y+0x26ljFaGFNJCgLbw28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6GV+c9qHlukoIFXuq0r9syVTOLJcPk9viwMk160qQGeeAUnF
	V8OHMfds8KaFXil15DwQe8k3AW7qbHoRaRu0SByZ1YJe2Vh/BmSgP1u3zQZZ5sKSo/N2tRnMz6s
	wEVAF1xtoR6AFb6Upf+xatREprbSYtuXpMfE6K9aVhSavYud+NZNl7zRZSFw=
X-Google-Smtp-Source: AGHT+IHoOu5xtTcf/RjPjhD0W1hagIukpNrUXFM7uVCcu6ZdF03m+qrREYQ7nY4Js9Y50zVLLMmETwMcDeSzzSc9QY1vs4hgkU6I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240f:b0:430:a013:b523 with SMTP id
 e9e14a558f8ab-432f904538dmr48877115ab.25.1761753723546; Wed, 29 Oct 2025
 09:02:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:02:03 -0700
In-Reply-To: <20251029062740.cE49P%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69023a7b.050a0220.3344a1.0426.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+5054473a31f78f735416@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com
Tested-by: syzbot+5054473a31f78f735416@syzkaller.appspotmail.com

Tested on:

commit:         4408a3d6 Linux 6.12.56
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=11e10e14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5054473a31f78f735416
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136bf614580000

Note: testing is done by a robot and is best-effort only.

