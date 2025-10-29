Return-Path: <linux-kernel+bounces-876510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D384C1BFBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCA4663381
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A722321F54;
	Wed, 29 Oct 2025 15:25:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656B306498
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751506; cv=none; b=KYPMMQ4bPtvv7BML+lqbD15M66/fVtk3O9LUZGWfXdN/WdJjxkL9lh920Qb6P79GcqlgDPQZK795I6QSKm/D5gRARt60baRA/xJM6moT33oRQ7XKZnoRNqsHceuUI9ZaoyF7LAutiZVORvxS96W45BDHD5oEPg8h42oJjRStFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751506; c=relaxed/simple;
	bh=oz5/FdGaNUEgLVToKsd5oT6RMB3AVWzvznYx2ubnONQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a5BE9JOOS5UqVGVFtRpyziHqVVX8yRXx7NT5t1M8FMHcoGVS2wDY6Co9/H1S9Kj0XU/xO/v9JNr8ciGcOhpmBeChfZjZaZ7y2+WnYnNv2nktyCpCjFl5no3EYsCQpf+Mrji6I+Uj3DiHZk4pPTqdKbN4ggRRZK9uaLxuI6t1mZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-945a94ceab8so1734439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761751504; x=1762356304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjxd8/NUsI1hfMIrqtOMXoq3b6QjBv+xq100vcZ9G+E=;
        b=MfBZxaOEGm10bDZp+9w40rHWDKwm+Jg6QdniYm9E01h44tk371A16m1F2BLQ8YuMB5
         7VGJ+7ddFvqHzKa5XzaUxNAsl1HDEisfcr/aovJQaWvw1PfFqOCis7wTzOTWr/JerBxC
         KDu160+hl4AyKCr2PJPDStalNGhryHpLRxw1W6UhVNM+5rJr3uo8H/5zjI22K6jvQo83
         D1MrPyul7HTHDpT1q6Xg3oS/0NJOaVa/1x45TlilFktwHNVn+y2KgQmCtGePP4J5uk8K
         K5ousGZvXvUpGD4BVu1CMrX/WW3qDYjlWw9yhnmw9sDhGhgvbIMJhFX43JujsD6LNFoO
         LR/g==
X-Forwarded-Encrypted: i=1; AJvYcCXbKnRDQq2YvDKvg4DvgBEQZHgeCbb7eomPsD85TkOcmnSFty9+cm5/IUs8+PTCuyFyjxI8TD6jvxeivko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy69Weq39psUvFb8l9lPWTCwrGEeofeThu9v3JK/z6DjgmHq79S
	GmpN3s+U6gCbtUihU5mFdosF0QUNO0bq2D6l3N5Jk46kKQyfiOtmJGEzzXZJCJyFPbVsaTcwTyU
	tq3SZURYXJm8RipDCgQ8LnDtLnOsZfqGxOYlUephQ4hGjoJACwv34BIVd5ck=
X-Google-Smtp-Source: AGHT+IGuHiMjVIwLMgSMF2Yqd97+3DJATLJD55vykLJy9hu3ZBUHu44RCvAnyaEsWL6rkVUmh9Khhk/hjDnedWa666N0X3odFRz8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4611:b0:432:fd5c:df03 with SMTP id
 e9e14a558f8ab-432fd5cdff8mr13478835ab.24.1761751504572; Wed, 29 Oct 2025
 08:25:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:25:04 -0700
In-Reply-To: <69015bf1.050a0220.3344a1.03f7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690231d0.050a0220.3344a1.0425.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ntfs_put_super
From: syzbot <syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anmuxixixi@gmail.com, 
	eadavis@qq.com, linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 02f312754c873efe076888a2fdca982e56617929
Author: YangWen <anmuxixixi@gmail.com>
Date:   Wed Sep 10 15:17:08 2025 +0000

    ntfs3: fix use-after-free of sbi->options in cmp_fnames

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12ba4bcd980000
start commit:   f7d2388eeec2 Add linux-next specific files for 20251028
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11ba4bcd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16ba4bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ecdce5bceba74f
dashboard link: https://syzkaller.appspot.com/bug?extid=cc433e4cd6d54736bf80
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b73d42580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1019dfe2580000

Reported-by: syzbot+cc433e4cd6d54736bf80@syzkaller.appspotmail.com
Fixes: 02f312754c87 ("ntfs3: fix use-after-free of sbi->options in cmp_fnames")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

