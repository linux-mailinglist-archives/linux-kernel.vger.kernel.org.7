Return-Path: <linux-kernel+bounces-735997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076DB09677
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0200D4E6A01
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5279F2264D2;
	Thu, 17 Jul 2025 21:45:52 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257B12C544
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788752; cv=none; b=bBereh4gCV1OASHx4fnFvKCQ1FtAiP45icMVpBaxt73B01nV4BF1gzB2oOu2uXncE0RoJiNf+Ogz+IE1KZo6kQZt6jk36UN+xgeErhdYzMyllilNZr8ai28A8zsUbNeYFmX9RQvfywTmYSx6j/NBw54QlHz2sbijX/Bso6IZYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788752; c=relaxed/simple;
	bh=TVoGFX4wIvyvNURmhxpl3VbnP9x2Gb3LDc6h2mJ28OE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OhT0c4yB7IqNgrP+Az5tbKJhTvCvSGnVCVUE0tiYmGmqa0oQeZNVmc5ZOabJhY3VHUXOEFn+j5HfBHEgKr//sfX1vEecWUIxDjXuO9FRzxKizqZIn+YJLZCCW29Y77kJUCndU9FA1yzcqX6R6kKpDNBIpWY49tD8SzU7uuGFN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8760733a107so154456039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752788749; x=1753393549;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj2jDWTiFySKciwoQfmuZmolQBkcyx5/o3qYA+zdNPc=;
        b=u2BHro1i0086zp3/rPjRuYc4BVcS9wCkYO3rHQYEVzbgWl0OBQN9kb1l/Od0VqIM2+
         2bbFhjTB2RxykPDhrBjQNvY+xwkQuTnpfT7CgxB2AkcQubtltt5LZu1Qg1E5aN+t72M3
         95LvZpmiIoWv5DrZ7M3VvkFy3La/z9dK5JtxJ+f7h18nFforMy19F7H4u3oCUjXoctDe
         R00XoJsfDouo1QryNBXUTwrzfQE+sAC4OlFhsTR0bnKRY3Y1r9Qw/HTwxGzdeMl7wr3y
         Xc3AJFTse388yj2cUnxLuBe9WG3vh1O4z2rZD7RW21zIRHyw4TfcEharPtceKaC9ikr2
         4XfA==
X-Gm-Message-State: AOJu0Ywxv4HMt+UVKh3Nuz5bWKvme/2JrZqmnhMjDv7qcQ8dOlfaXMpu
	rISwzG9KMqn7DKjEqjgGnHQsB5CArFXP0RbUG8Nikmxnc6GrJACY1bsAHxDef1s6ySvfrUqVDjd
	RpqVyYrPjgD+MGT/qj6Gsl44xWqJyB1mtepapjDX/Xrbp31CtEed/x+OwfZ8=
X-Google-Smtp-Source: AGHT+IFYwcTWgWQLOgaOTyYKJ+OAC0nNqSsBYN0yW2Cia4WO2zjdvM6Z1LbTRiombDz+3SqAVnla135XHxsWXQsb8COYRvVhBqiH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3887:b0:876:19b9:1aaa with SMTP id
 ca18e2360f4ac-87c0f22dcdbmr22363539f.9.1752788749702; Thu, 17 Jul 2025
 14:45:49 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:45:49 -0700
In-Reply-To: <67b2eaf8.050a0220.173698.0020.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68796f0d.a00a0220.3af5df.0024.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [bcachefs] KASAN: use-after-free Read in crypto_poly1305_update
From: syzbot <syzbot+d587b24799bd8c2d32f4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs] KASAN: use-after-free Read in crypto_poly1305_update
Author: kent.overstreet@linux.dev

On Thu, Jul 17, 2025 at 01:49:03PM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d89a34b14df5c205de698c23c3950b2b947cdb97
> Author: Alan Huang <mmpgouride@gmail.com>
> Date:   Sat Jun 14 09:18:07 2025 +0000
> 
>     bcachefs: Move bset size check before csum check
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1722a58c580000
> start commit:   2408a807bfc3 Merge tag 'vfs-6.14-rc4.fixes' of git://git.k..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6cc40dfe827ffb85
> dashboard link: https://syzkaller.appspot.com/bug?extid=d587b24799bd8c2d32f4
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4f2e4580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e4c498580000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
#syz fix: bcachefs: Move bset size check before csum check

