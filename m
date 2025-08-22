Return-Path: <linux-kernel+bounces-782650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B351B32322
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6327EB21D18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BBC2D1F40;
	Fri, 22 Aug 2025 19:46:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959672C0274
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755891967; cv=none; b=A1ezWzDJSw+X+cGYESNdyPMGPT25OkJHIaq9wg3Ey2rP/GFi5jXe6mSlz1+eQkw/Z7Egdtv1Tq9ZM0DuNDaFjO47l6zADT6iYEnDlowpj5QF5TyWkD8s9R5/YiJjnpeJnNa2hACQu1GOmE+v7p6Pkou6UKDz6NzrvY5ynSAUBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755891967; c=relaxed/simple;
	bh=7NiEu3tkA6S8mPNtHs1Won+TKrSvzrKDenD6kfio+Uo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jvj44j7apT8EqNSFWF1KLn5fTLCM9GfaHWXYp+hc4B2hYR/ezt0wNOLbDdJgJ6+r3/+huLVcFEuVpo0+G6nogxqv7tufbb+rkIlA93FwKnvytFubP2+XyoPkb6etTsaj2RCc/QDv9G2DNsK+Eq7kYTIh6h5TCDTGIoCzrTWOVE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e56ffe6c5cso22707225ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755891965; x=1756496765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqSC6tySboQLbJ5EI4n/KR+EKbtxNLb53k76lwO30Xw=;
        b=EMfTXVbANw5bsmEwdYV+/ejkx5yGcLUR3Whs38tCMQ+NcwLcKeViQ2J+zSUMVeTjua
         YfRf5I/R3/ENUPwbd2LPyb852MR+eJAoeqtrxX1q1dBL0qI7c1KAY3wz00nMQ/FkREo0
         rm1TWfWyVmNe3mMNx3c6JkfYbzwgg2Rr0DA4Y9PZhckTDnLsdRIg2ebk05JeMw5GTcdO
         6gcqXd8iQOrfM/GEuqZZuH83Zv2BTObVuickJY1AJ0xGnyKEEporwSs0QToquy5jlBwT
         qTqRXyO3OEVd+iw9nOdHHYclEaqFqd/hMmTpj+ZQzOFFmvVBPw4O9wAbaCZvI42jpFFA
         +LOw==
X-Forwarded-Encrypted: i=1; AJvYcCX4b0RM5SB49qnb7lLMRRXgTjWaIYLBBZ5g52me/2NclJQwYZBLHGu/gW+yuj5WOLGFiHvuIRi5sli1zGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB9Xh8DHWnEPLD85EPVGV3A9P2Rpm+6mvVa6bsrj222ybvtYES
	kZBsZe9YGGJUMjdIpWDxIA4GVPjTOfn2ge4Fj67/PFoyN5qOHSMpX/Kkc6AQYyS/a65RpnbtDkH
	UCWdQJcSl2ITpJJbLWuKPkvw5I/IpOFK+OZ/ovAQ1Ob9H6PgCpESfcc0bb1Q=
X-Google-Smtp-Source: AGHT+IFotciXfb2/EVLMWr2EFo9hzs2Nns60EL1F8NvVSxbaXh1nQaZZ6WdP4J/p9TwLul/qlKcoHIG9x8l4KEeaMNE3+39TEPH8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:3e5:2df0:4b7e with SMTP id
 e9e14a558f8ab-3e91fe19d9emr67355225ab.7.1755891964741; Fri, 22 Aug 2025
 12:46:04 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:46:04 -0700
In-Reply-To: <68a8bd20.050a0220.37038e.005a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a8c8fc.a00a0220.3557d1.0014.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: chao@kernel.org, dhavale@google.com, hsiangkao@linux.alibaba.com, 
	jefflexu@linux.alibaba.com, lihongbo22@huawei.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org, zbestahu@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit df0ce6cefa453d2236381645e529a27ef2f0a573
Author: Chao Yu <chao@kernel.org>
Date:   Mon Jul 21 02:13:52 2025 +0000

    erofs: support to readahead dirent blocks in erofs_readdir()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e047bc580000
start commit:   3957a5720157 Merge tag 'cgroup-for-6.17-rc2-fixes' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11e047bc580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e047bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151b07bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b07bc580000

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Fixes: df0ce6cefa45 ("erofs: support to readahead dirent blocks in erofs_readdir()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

