Return-Path: <linux-kernel+bounces-859529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C699BBEDE65
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D5F189CB19
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0318F1FBEA2;
	Sun, 19 Oct 2025 05:16:37 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94105635
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850996; cv=none; b=YrrvFBayo1lVcQl/4JIcidfDhEZoImyROEhD37fU0SYWP1EqGieNaJJrZ8jCtCHIE0b8ovTIgdGYVrvEwL5ZiN4ziA15b+yleMH38++5uF+fIBsw71Tsuo9+eyUVb+CRAT1Wpm4+Z63LfXrQBxuRrdjKwC90mWj8ur2iaRs0qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850996; c=relaxed/simple;
	bh=m4AQ6VGAvDc85MQih1/wAzo7AtOC4RqmG5UJQtQfVXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C+/Yp9K920EMyaO9ZCDp3ZwHFeVxQWjVR62AhWOnz9XoUhm1nWV8vEccoJ1+G3Ehkv98MHcLyV/GYdBOWLNsEbf69L7+l9lHkr+quDvEp8PxQSIlS7QHkaeTITqaAl9iJXMS2Mim7E0mH8UYwMCh7M+rDmu0ALcaDZDsSAFgrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8870219dce3so330170839f.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 22:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760850993; x=1761455793;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAfM+A6P7GEyu1Nd9/FZ0Wa4Tk/65zJQZhjssYJyAi4=;
        b=XS9j69YrJg2dKZQgYTDR2EHfXKmwGDCElQJFPvLOKiKYUK9h6CRdG0YPSSIexmNLf7
         4ki3jzwSCw6dy6fCgtjijqCMTtg7xe8c+T244Bkcqbh6qOqa5ESX/bZTrwiVg46wXP4X
         A/MzqBGd3wh/Y8dY3vUmmu/uJpfdFtUnp3DiAx0nS5aWJNuJd802s+4idqF6nv8mjEON
         Ixuc89UcLl3OJKNVlguJQKTdhOSAU3XbaQ2LU39loQ79LeRnb7ZbmAHWMpB6eFoHYTi1
         kyDlwCvJ7CQtPgnTwuPrznjy/Leq2Dlhjn1Xhga7OwHIVwSyfpgu334cTzefSDlO6Ftk
         J07g==
X-Gm-Message-State: AOJu0YzvOdyeLO40CAw8QtbM7GynBXsq3UcWskQ5mHwM42QJSg6QU1D1
	vp5K8TRuoGP1aYRJM70aZJ9wMH1oJFIXt8iNVeZ73Jv6e1kWeldbulVyxC3rMcA88V3AtLSpHR0
	qsDz9bLQK8FqhPMfuy0xBbiOvkcXuVWsfRUrvmTYwfQcVcHm49hXizD20xff9jw==
X-Google-Smtp-Source: AGHT+IG3aPhwxh7FbtQB1gBI0Ghf/lpDLAxIknMgvtMb1XItIU2E3zPk2S2/68oLKJ4sqjTzX3pS8O/wJb3BH4Uviv995ibSWXMB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e9:b0:430:9104:3894 with SMTP id
 e9e14a558f8ab-430c5318de7mr128960995ab.30.1760850992776; Sat, 18 Oct 2025
 22:16:32 -0700 (PDT)
Date: Sat, 18 Oct 2025 22:16:32 -0700
In-Reply-To: <68d56f4d.050a0220.25d7ab.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f47430.050a0220.1186a4.0527.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
From: syzbot <syzbot+2860e75836a08b172755@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hams?] KASAN: slab-use-after-free Read in nr_add_node
Author: listout@listout.xyz

On 18.10.2025 13:37, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f406055cb18c Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11cf767c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
> dashboard link: https://syzkaller.appspot.com/bug?extid=2860e75836a08b172755
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155f1de2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b6b52f980000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-f406055c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a4db2a99bfb1/vmlinux-f406055c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/91d1ca420bac/bzImage-f406055c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2860e75836a08b172755@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in nr_add_node+0x25db/0x2c00 net/netrom/nr_route.c:248
> Read of size 4 at addr ffff888054b8cc30 by task syz.3.7839/22393

#syz test linux-next 1c64efcb083c48c85227cb4d72ab137feef2cdac

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index b94cb2ffbaf8..5fa7d9febbbb 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -245,7 +245,9 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 				nr_node->routes[2].neighbour->count--;
 				nr_neigh_put(nr_node->routes[2].neighbour);
 
-				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
+				if (nr_node->routes[2].neighbour &&
+				    nr_node->routes[2].neighbour->count == 0 &&
+				    !nr_node->routes[2].neighbour->locked)
 					nr_remove_neigh(nr_node->routes[2].neighbour);
 
 				nr_node->routes[2].quality   = quality;

-- 
Regards,
listout

