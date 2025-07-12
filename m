Return-Path: <linux-kernel+bounces-728554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF77B029E6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A93F1C24C90
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DE223DEF;
	Sat, 12 Jul 2025 08:11:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB3C223324
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752307865; cv=none; b=nboVe6sBtBJI0i40G6IMWbLSXcYfMyeso9XZPp3YMS0LWcWJrUzbdBZxtWbtJun0w41oDHOd4X/y+ZIsLwraTsH2a0mNTRnogcFK/OSyeFOVy7xnHiHnHS+qHsyPS+fAApYSdKi+HXv5K6eww2nCo0pFjNZyHhFeh/LM5yzDmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752307865; c=relaxed/simple;
	bh=O/gIJ+Byoe1HUgWMazz1k6JA1RNPRnQOwiyHA7/6NNc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pl+OjWvcl4Kalox/noJdj80dg6u1Jcz6A0ouZFJwNC4Pp0lIpc4WhpG/2UoSVpOuJ2s7B+Yyy1Qf93mjbmrKUYgiONft4iOcPnhD04s1xcTumandpvpXOgQVPuecYaPvVtYGm+igMWpvMPLCUfgIdVCC4gXxW9v8obuBqXG8N1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d07944f29so562622439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 01:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752307863; x=1752912663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxA0bw6vzcwyTokn6nubSR1PJByh+GO35DS4D+OYI64=;
        b=MA7soqYzZNXM8bf/6jagLeiFq9phQz+Nh3ANFTkony66MpUbg6nVV5o22LB9O6twCz
         1cemBNbhcqwm3noNt4XRSS5I+eeVvOsYdvW/w1J8cnR3LG4Py7sktBGHHDQ0DP5XKql5
         5TIa950lBfSkexbLP5NzoSE9eB/voe2JIiPUbpDcNu72fVyFOxcIgR01CKNEPHwBJ3MB
         KTFIjJ4BjQze8DKXgQtRESD8nSPCLAH31c1Rg+IrQRp5PXxnm2mBGG/7BIJZBik7xCk+
         MlssN76rbUV42OCJYiAUvdMzbDBkJvzJRxtMwfpl52hLoCmIMv0Tm7mk3IvAaQNvjjX4
         jeFg==
X-Forwarded-Encrypted: i=1; AJvYcCXV9LaBI1LGGjL2STifgf5i/3J2KuatLO6rPz9JZt+5lXZdCQ2UjAVy9w6R8+O8bOqrvDBXSdwMP8M23xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlnluLvK/K6S9/aOMbork1GdTJOD/DuzVb6ZCsvAWeZ9yoti9
	rnjOlLyI4ctIpogGZP9En2HOnu7o4bmauwuy65d9BjlZORIRi8nSjSWwbj3c8Ay/LJXOjQU/kvl
	negZPVqyZDdhteLGUSkiLQxW2gCFqjiQ6sHmGSzG2DqJ23rTYd+Ox43N46jI=
X-Google-Smtp-Source: AGHT+IFI68HskVufu9pRsd1ogtwtVNXBvQiTh+Crm9J2fzblk+KFTeqnRdfvoYxEDjdTjW7a2y48hMvItbBMP6IYb+ilNXWQIOqH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:36cf:b0:86a:93c:f5fb with SMTP id
 ca18e2360f4ac-879787a0c07mr679285539f.1.1752307863615; Sat, 12 Jul 2025
 01:11:03 -0700 (PDT)
Date: Sat, 12 Jul 2025 01:11:03 -0700
In-Reply-To: <683dad17.a00a0220.d8eae.0054.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68721897.a00a0220.26a83e.0073.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bkey_pack_pos_lossy (2)
From: syzbot <syzbot+a6af6dbf934175da5161@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 263561649ee5875a922f4358e96d3deb17a91021
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Jun 7 18:27:35 2025 +0000

    bcachefs: Don't persistently run scan_for_btree_nodes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=141eae8c580000
start commit:   90b83efa6701 Merge tag 'bpf-next-6.16' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae6d9a7dd3ac8772
dashboard link: https://syzkaller.appspot.com/bug?extid=a6af6dbf934175da5161
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159907f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1758a482580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Don't persistently run scan_for_btree_nodes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

