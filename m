Return-Path: <linux-kernel+bounces-849678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967EEBD0A45
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A583018977DE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B39F2F1FD3;
	Sun, 12 Oct 2025 19:00:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B631F03C9
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760295610; cv=none; b=YZRobqTy0+PlV4ogRfUqw5NXDpOq7TRkM828ZUJqU6SaKPJl+mrIrq20J4eIdI1I/ZzrcCu9Au1063ZyYcFQtRIfokasdn9omvSADexB6MOkJryAxKdmfgr5J7DCWzOTLu9IslGbOl8e4VMZobOyKrW9T/d82I+3VhHYv3u0oN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760295610; c=relaxed/simple;
	bh=Pt3ZB83Q3mfKRpOu3a30iXqtlMYmHF2EzgkJHVQE4TM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TPd+rVa6NWUd8HEWcri8RJvhXdX/hOo5lkV7hB8JAOp5KAFlVzdfc9ykKLR0583EZFpz8cDAfm7qvA2hSA5kpmZEby9G0q0vEiIBCI8BcOpFSL91VlVx9zABx1PCrwxxFnkiEj77xNnvMFFz/rVveu5kiEM4fg9CdjTQhv71OzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f8824b65fso251341405ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 12:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760295604; x=1760900404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcJVBjs2ChGoReimlqt8lYiH1ukMGH92wGhJJIL/roA=;
        b=P1TU7vE3g41cp9HHcc60L5G09LmiPdTwZ2GBW+FBOmgOWiU8ZuLuFhtLgdv1x8HXQZ
         4224zJpBq9zUo59Th3QcT0T2Cja+KFDUMU7HDiVw1e7keDiJU3csDUCqQj49vgmd63uv
         ayqTM/7s/qE2KtXGGALOpvOiY8b6T/RqV6NOhsQVv0HS9RKSFKfkjz4ku7n/gko+M6dY
         e9UzNo//DHoB+zCgrrrH9eJaVD7PGh6kZendupLAzbEy0QBvXdXc0m8kuWidyP/DX+kw
         mRiuToLaLSFAGbcG5C1HYqEfDpZkZj0WOPLJ94qprIWVFU6bqvl9SJEAS2ZqT/Zm0O6B
         mJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWBID7ZzCSUXZRjSMPrNLItHiwmPPNImd6L0oY+9AymQtKzQLzA9ACltG3+BesSLyiUPd2kKGwN1aY1Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/BI8q1F3aukw0czsaZtkyW94EOPWbhtSAFWsfLqWJESO0S3KX
	lxdLDuoM9m8RGGCe8zvvoxZJbfbW1txciObZtn6eXQ+aBO/Ft39YKqn8mBZbO3xRsDiPJkbbq0E
	ZruYBforXwnxNkhtV0m7r/prwWnXXxuYfjAuNS0i9yg2YpMnmIAX+Aeq4a40=
X-Google-Smtp-Source: AGHT+IHZuNtemUzT33hMZvox1iRge2hv5hQFESvK5Ke3OkprcLTQOXp/1StbpSfeo77zazlQ4FPyJi5J2a+Y4DMOm9aofNP/h78A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e04:b0:42f:9e92:a44a with SMTP id
 e9e14a558f8ab-42f9e92bb52mr111706485ab.22.1760295604614; Sun, 12 Oct 2025
 12:00:04 -0700 (PDT)
Date: Sun, 12 Oct 2025 12:00:04 -0700
In-Reply-To: <20251012174221.72873-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ebfab4.a70a0220.b3ac9.0012.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Write in __bpf_get_stackid
From: syzbot <syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com
Tested-by: syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com

Tested on:

commit:         ad94c972 bpf: fix stackmap overflow check in __bpf_get..
git tree:       https://github.com/ArnaudLcm/linux.git bpf-slab-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=1618b304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aff57b5083a987a
dashboard link: https://syzkaller.appspot.com/bug?extid=c9b724fbb41cf2538b7b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

