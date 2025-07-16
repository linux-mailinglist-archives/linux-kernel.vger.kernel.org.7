Return-Path: <linux-kernel+bounces-734128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC96B07D66
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2926F1C2763C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727828F518;
	Wed, 16 Jul 2025 19:11:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A824A07A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693066; cv=none; b=S0vhKeLtguOq+97qRkVmKb5aujf1cGQOiOEdAIO9AGpJ7D6vo3ZJZMjNqs7QZRdy85zjapubAoq7nXBTVUQzDkFaAJe0lEYnPbENwOJhNWBsilpqwYja9hmrUX6qSAW/3LpSprt1iGSXCZ41lnyoBktybtxh+D/B+JjgVzWP0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693066; c=relaxed/simple;
	bh=1J3djSIePyIfLpIF/UjN+hA/9Dg6VUcMujoKJOL32fw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fJ6DxXGP3o9BpP6/I+V7TVEXy1RbWpnmXcYoAlj+U3IjNXezjxkPvvV4Z9rWxKr3siVEmwyEWGV/gmZVDhZtLVuPHdomlxjNBjdA17Q9P97TLsG30ZasNWGtxBD0xO9lAtvLFcDsmdhRjskx0qSvsXI/IC9LHzxfmEiJWr5Y9Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8649be94fa1so31926839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752693063; x=1753297863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJMxK8LtAGrhPevKHQd8XAQG8kMghr34yxzCtNO5pRk=;
        b=YGSSTQax9AXzxIB29iBfRxVP7CU8/Ph/prLrSn+cH5F7WDvWlBUv6rG73YDcP5H9Wx
         h+fUMAb2zXfjYjIAw1nViX48z4hTr+Y6sOQO2Izac6InGElrwwJgP/Zkd8tfqtFAFRsA
         di3y7cGVeAaX8+9d6Mva/dkY3BSiBJXOskoLupS9/Ow6UsOTxt+Aqh0sHeKJ1Io5UuZO
         uf5hPmtPhea8V5y6/SQsFyzrZEErg60UMKolPDbUSsYrucXjF1bfO8cCNdFi2r/q/JOv
         F1EF2wZceyJTMWifPos0jF/z9/mwMOyjPR0+kymfCRWJhmzcsDRbtmW9DrcC9HmLXx+a
         n+kA==
X-Forwarded-Encrypted: i=1; AJvYcCU01GthjQgUQ5+dObX+cc3LMjMiqulhIN21V4OZotRmKbxj6OMQG5utyUNEMkviBWBr7/P+ztC+8vfTvGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPU3Le/JvJ8tvxLMgAm7Ni4GXUfzBVkf0BXkGa8pkBoSKfr3us
	LRxL8YaaPXbDrXqz2okxlbqZo0fgWJgCwf50lcjxx/XoxCrTeWgQGmQjVmDOr7xVV+7bH5VBY/Z
	AePWBU856ixr/rahumrEnhBkEYhPfBQ1TasAG4oQf7yv2em9EajP++qegI+4=
X-Google-Smtp-Source: AGHT+IGgjHBEbEX5fuDHKG55A+V3GzbJqmaGHn8GLGKJLDBc9fn7wyXAc88SqcxtXTgM29JC1MuE2CeJ9FBGKIvhezWy5DMz4AqU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f0b:b0:873:47d1:2259 with SMTP id
 ca18e2360f4ac-879c08c4c8bmr536064739f.7.1752693063681; Wed, 16 Jul 2025
 12:11:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 12:11:03 -0700
In-Reply-To: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877f947.a70a0220.693ce.002f.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot (2)
From: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, pfalcato@suse.de, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ef69a41567549aa8ba7deb350ab1f3f55011591d
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Fri Jul 11 11:38:23 2025 +0000

    mm/mremap: permit mremap() move of multiple VMAs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170f458c580000
start commit:   0be23810e32e Add linux-next specific files for 20250714
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148f458c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=108f458c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000

Reported-by: syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com
Fixes: ef69a4156754 ("mm/mremap: permit mremap() move of multiple VMAs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

