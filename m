Return-Path: <linux-kernel+bounces-866131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2DFBFEF46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621323A527B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 02:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3881A073F;
	Thu, 23 Oct 2025 02:48:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA61DF25C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761187686; cv=none; b=R0of+NwNoz5+A5ehiwfajh00AQ7SbIYgp+cXKM/5cY0nDce7ZiP8K2DdcyDP8BMRUEBE2oeruLSqI3CH2XAr16O7TdT5jPvm5WIadlH04xrjUIw3AT5RD8pkPK3EM7JlRYhdCpOnmJBtrmp8wms4nlckEItkXhJ1kagBRK5Bqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761187686; c=relaxed/simple;
	bh=WytSf4RnllgWJA9B49OflhvndVQxEvceLx57e9ZL9ic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D795FoKmErVdz02XuOQjVWrkt44zZFF+iQxEW6jjaykjWjK71izAijYiyQZuA6v8enET6jbPXwvrsQ39tPXL16I1FBLfo0ZFnUJG1hsoGcfe/ZYUMcvbCGZ2KO/PSu+lsJinjgEen2glC7PXKy8VKBkvMTT7AH2fGpEAMoom+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430afaea1beso4772595ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 19:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761187683; x=1761792483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUQfr+6NTZqF59qYLAwvtXIMgq3M6hKMUwzUvKz4xY0=;
        b=NnKbDC5fNHmy/c3og+5vcry4Vma+Ma/nLeHqH2e1NbEMalKzux19R/E7EI8Q3Wz2HE
         zq0cqzc58EsGu/hBnPj3oGykBQDczqqxsgssZlGN+wGGxBUquInPkdur2HaNYsXP6k3z
         NyAU+tGxcdf3RDw7c5XTQuzzlZgNZADXUgyK+DxUOR9Sp1gtEnt5pgYpQ4G/QrOBV+ci
         apw65Cyh7jYwIv0NhRh8SpXE1p/jhCkoCDjv2waYqvZgdIWYaWGmzt5hEaAc5s5NwAC2
         etoaM4p91ASlg2cGhwxh3Y7jUcOpiDjfuU2VnxBkGHRXkBXP5e6Yu/zgUN/pDm5ED4VO
         5VsA==
X-Forwarded-Encrypted: i=1; AJvYcCV/WsDNb9igxI8DRpnWpMLMxaimo72WmKEM58ep285pYfmmTK81yQOC3Dlim6ZZ8bxt91vnS7pJoIRczJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhpLhz32Vi5Fu5E8r7zBe9hrSKL6++4gjNzGMQwmnyoQMsR/R
	3uFv1j/CLlajwtbJRDs5NvpoI/9dffIfVbSIDWuwz/Bz1rQaW8pyGY6hmjAxIZGA1UB/hVxFUBn
	oj2jF2pLJk43D3MjjPG6Ps8yi87UbebU2kUAoZxF8e1XHHlhqQRjTq2EZ5Kc=
X-Google-Smtp-Source: AGHT+IFlyTmDauS4Q1UmTdsrJFojonqSbz37uPOqjpsgxt0JZoG9k/HALOGFTQpf/Livmh3rL3ZljO1n7nGE7d8NCzD7Ui4ORXJV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:42f:9b0c:cd84 with SMTP id
 e9e14a558f8ab-430c52048e1mr323859175ab.3.1761187683617; Wed, 22 Oct 2025
 19:48:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 19:48:03 -0700
In-Reply-To: <00000000000093a1ca0621e8d336@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f99763.050a0220.346f24.006e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_page_mkwrite
From: syzbot <syzbot+2e6495950edcf7fbfccf@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, elic@nvidia.com, jasowang@redhat.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	mark.tinguely@oracle.com, mark@fasheh.com, mst@redhat.com, 
	ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, parav@nvidia.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 04100f775c2ea501927f508f17ad824ad1f23c8d
Author: Mark Tinguely <mark.tinguely@oracle.com>
Date:   Fri Aug 29 15:18:15 2025 +0000

    ocfs2: fix recursive semaphore deadlock in fiemap call

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1357e3e2580000
start commit:   b5a24181e461 Merge tag 'trace-ringbuffer-v6.12-rc7-2' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6495950edcf7fbfccf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f252e8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ecd2c0580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: fix recursive semaphore deadlock in fiemap call

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

