Return-Path: <linux-kernel+bounces-837100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9E5BAB60C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED583C6822
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4161D2309AA;
	Tue, 30 Sep 2025 04:35:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3372CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206904; cv=none; b=LeWiQ5UuE2TD239ErjP+wNEkFY4rmFEjHGs94QwIlx0oe9pDB/XsCzIABwDFvr9Jzsg1KFfOYCRpNf3T+s3uzFs/3cnBIA9U4ltr2FSytmof9B/ULKqYKKuVqqisi+CqZ11iYvGhKkeCe+SBIYbLaugrWhpIR1ETmlreEDAp/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206904; c=relaxed/simple;
	bh=X55jS59XCvXQwsEO4T0q0YatZM3oGfqsJHacRcejOVY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ii2uE600sgPPdLiCSz85rgx+zw//7xSgx3+yagHFi1849pl3N1mLOdYWT1eZloZNrapxndZ/QfzciqupWgCZazPHzaY0bQ5Ti5IICSDId/8Z/22wwU9KkK7lwcUhxwSV9567FN1W6EFPeEbYN4PZRDQU2FDWGItDc4cn8KU1cEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42af09092b9so56236705ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 21:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206902; x=1759811702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6bEGHQIlgVrmP3pvqJCQJhuFLg5OhKOxAfS13YBGY8=;
        b=Sfcr/HmjnUtsCiB4KouvKj53pgpXs1vPSWTilSRkAd7C95cb17tOQZypIA1y6a8elT
         5LTYhK9qlop3Yof0ZQmRl3MgWLG45FFiN9802FaeR1BDwTr+nbNVypHghZRNBdgLHL0L
         jQ2V0YcpgUqAVNjgO7tJ7qGH0MYMbNFXXXBcQZCUW5+2ObeST8iNVwYpUmv9xV55OO70
         63T3SwAHZoyhf34+N7BhC1V/j+Qa1+Ar/TIkHf0CNAnpO+1M8z3NzOQScJFuxDvgfnbF
         bMHELH4hKv1PigWniXwTctOXIXPK9QBNX5e+sO5fgkpjZw34iGloWkj66JxLxOeh/vxh
         QkJg==
X-Forwarded-Encrypted: i=1; AJvYcCU1sVLDQ/VuLxWouKsPft1l12pQpAMyQlr/I6N0QqJFBycMnkpp+RqJRWigjJhLZ0LrMCcPoncSZQaGaDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeUnBX/4VWuCielvqYYYp2N8JGiz+DsWvrbsvGXBA4M+jiYAWI
	nk/ipii0wF1JgRdiphhzMi7LZTFDl1MG+5uEOHXjClHw4+AWER71rum4vs25VBGBFz2p1Pg42Nv
	qV94Gq0NWUXDbqgrRCdn9UEBBidHYZpq3/WUZxfTkte1AQtT0dhh4t5eVWKg=
X-Google-Smtp-Source: AGHT+IF+ZJqaxVH7qzoD8m+z6Wx1jgVyWYuUV8Id1JtvKOnvnaK+dNLnh0tYheXjvinW9dWsz8I2GQwkzdMxy6Nx/TreD56Bkxbx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3805:b0:426:9b42:2a06 with SMTP id
 e9e14a558f8ab-4269b422a6cmr258062505ab.3.1759206902610; Mon, 29 Sep 2025
 21:35:02 -0700 (PDT)
Date: Mon, 29 Sep 2025 21:35:02 -0700
In-Reply-To: <tencent_9DCD93762363A97943B5A44E7760377DE605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68db5df6.a00a0220.102ee.0042.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_btree_node_read_done
From: syzbot <syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com
Tested-by: syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com

Tested on:

commit:         083fc6d7 Merge tag 'sched-urgent-2025-09-26' of git://..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12d02334580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=ba71155d3eacc8f42477
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137706e2580000

Note: testing is done by a robot and is best-effort only.

