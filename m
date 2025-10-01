Return-Path: <linux-kernel+bounces-838723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDFBB0031
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D07B1891E98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 10:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FC2BDC0C;
	Wed,  1 Oct 2025 10:29:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F021CDFAC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759314547; cv=none; b=tc0OWVRlePyep87yPrGZ7TuSXfYRl9LPD6M/NqgOWK1dwakjWvFQQf4BEc7Dg+oGNMtUgISbVK2eFWVm2ZY0zuvLZy+jOOl7/WCygJdaAoL1Fv6ZPXpdZgofNqJtzlA0Dle1CLsNfkuuEXvwsK0R0pUjAKKRpM/DGZfGez21I44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759314547; c=relaxed/simple;
	bh=0w5Ejz96Ybf8/rKVL7gHnTjvZQUXMEJzLSIqRSsnZuI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=K4S5ncXcJt4JFj7TQigsbxlYYAnMYhhyO/WwYO6cCjfa8xMRjUUqoVPyHJXd2xWfOpn/HZWm8QjF2E/4HLOGuJ+tfqXwMq/POmYkPmxhr0ARaIFTIHzvHwptDJ+lh4nbJx9SeI5KvNKYUeuK3twB225SNtucTP10qwljXnk683s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42640cbf7f2so165960745ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 03:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759314543; x=1759919343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WjQ2mLjMG7t3g8nMDgxxMGGjQ62WQJO9DMnoIMetg4=;
        b=JLmUnWSHM4dkEEXiylP8iaqbVG8JguyU+Zg8xuvLggjAeekhTAN269zlFd0JaaK67a
         GSDjjHNAbNAFyNOuuFvG0pkgKiuQlpGSjwhpZd6hEilkWRJFRR4mnOb5nTw1MR4bGXZo
         pMmt7F1yr/kgcovqZu/lr770RCMi8UEDMNNi5iKUFCBjHF3f9sJWWpUQ8jUKW+lsol8o
         PIccL2kdIUkZHPigekOFxzwAccs6Qscn35XVX4l0tFp/89ejDztwhbABM1B39/lqG8KF
         4y/GpmPEqzqhSgevTwU3uKTvUzihEgV80zM23Ud8hpON+jLV+d3lvW/Vn1N4CPDUVFrX
         6gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdg4NDzjR3PHYK2FDkMHxp+5Im8YHBOwiB7kqk8Ru7qMbRPtEeKReb6PToKDiEszMC8rIkNdIQBcH4hLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbz4GrIN/YcUIRxOQUiMq38z+GkM7gOiWYP2oAk4X9e1o9JXud
	92EFim8DdnD+R8N2Yiw58AGlpfTcR6zimMi9ndZdDvoiadeh2Z5OLQVwnDfkOTpGgD6K3glZ2mq
	oc+IoG8oSjzH7pH2gJLVmiR0oc53+NAZRHNsPhXK2Nx/e0KWZ9jcOWCfc+Mg=
X-Google-Smtp-Source: AGHT+IFI0FmOdK6CA8b6ROYKwPm3x42fTwrV/th9wSzTiqaQAQGYZG4D9ms3yhD6PIPQ2LOcbnWoOIJzLVikWU2n5MWKRVW++H1O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1947:b0:426:3ab1:74bb with SMTP id
 e9e14a558f8ab-42d8160ebcfmr42420275ab.18.1759314543500; Wed, 01 Oct 2025
 03:29:03 -0700 (PDT)
Date: Wed, 01 Oct 2025 03:29:03 -0700
In-Reply-To: <689ff5f6.050a0220.e29e5.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68dd026f.a00a0220.102ee.0058.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_direct_write (2)
From: syzbot <syzbot+d5daa7d9e8e8d49ec379@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129e85cd980000
start commit:   ee94b00c1a64 Merge tag 'block-6.17-20250815' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=98e114f4eb77e551
dashboard link: https://syzkaller.appspot.com/bug?extid=d5daa7d9e8e8d49ec379
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bc53a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bc53a2580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

