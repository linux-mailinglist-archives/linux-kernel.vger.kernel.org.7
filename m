Return-Path: <linux-kernel+bounces-891113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26209C41DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9A6188D4A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A13019DE;
	Fri,  7 Nov 2025 22:49:45 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11A3019D8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555785; cv=none; b=be3KX1YSxkzDEZVB3z3SFLV0BzqS5jKi39T4RCadTru4621eAuTdXOGudSG6YmxNBKIqtqLW25gX+V4Jg5PU8Arxri77DuH5ooY2c2ggV4vRlV6Gs3slSGU7i0MgDNVLaz45I8r8CEKukq/jdVqQAHblO6Tt1oXyQJ8b2MeBZrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555785; c=relaxed/simple;
	bh=PP880z/VcR6rELG69Tn3FbRGKrI4LnQHK3Fw9mAf8co=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jwfIJTLdjiYA8bFnmEygGnGHnrxAmbbUGXLbKe2OaL3XUdh3gNi4gOETal6L/3mC31Bc0egCdW2+DWBJKdPifAVdOr3Z6rXY6fs3W2OVrCwwesfhRX/UE8ZqLYyPbxECZDgqRYz6hXqoadFpWG85n06eNxy+JqwEdeEf6qg7hLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-945c705df24so119078939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555783; x=1763160583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34jmLhnA1z3t3nylXjpNnuIrw60yMfRChvS/KDIZh9k=;
        b=UpAHwmSuJTe/U2acklJzjjJmidC4aH3H+t2+Y+YGQ+c/VaLQ5oViRdOVfFjvlrJNZY
         Od+W6dfSgubJeKvjcK8TxWRRCR61mkBjZwkK4YubATI4pVb+IN2uaMDh52aVi6+DEm4G
         kSCoUweTdK7Dkg752Cg5CAT51cmBhk8FHzEnGkfNdzr2ZWX05nozxdExzJxsCQjdNzvG
         RWVCqcaZ+rIJv/qxjdT8wqUZEEepLnSyxnogN3hYgkJ/rKlCAs7Husi4eNDM9ZBD++ZG
         gAhR50TGc3KeK+95oShoNF09I2WC/2wWzC/tigX17lntAhJk/B9dfl9G2fJVNXEoYmUh
         5T6A==
X-Gm-Message-State: AOJu0YyOmcKEQyPBcvtYET4SXkCv6HgDqt6I2yTF0/lKtVn9qw4LxErI
	0e5jehUWfjKL7VbAM7OrmuuEmxaCEnx6LTIDzuYqnxssSfSOIKybVY9Is3HvbeuuAb/8nHEgQGu
	AStNQp1WgGrd6D67GkBPxGd6VlDeUa4aYGDF6f93F4S5BuIDBxRrYrP95H42d7g==
X-Google-Smtp-Source: AGHT+IGY3O6wtVyCSIWCb97juaZRBrMPcwDrt6x1Codrm2mJ0SCWcGQ91Z4iV7TxqZT1Kba+w1BKdTSWZPDJzS/CgpL2IFDmwfQA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c08f:0:b0:430:ce63:4180 with SMTP id
 e9e14a558f8ab-4336299bbf7mr37299995ab.8.1762555782882; Fri, 07 Nov 2025
 14:49:42 -0800 (PST)
Date: Fri, 07 Nov 2025 14:49:42 -0800
In-Reply-To: <690da04f.a70a0220.22f260.0027.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e7786.a70a0220.22f260.0064.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [fs?] WARNING in destroy_super_work
From: syzbot <syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [fs?] WARNING in destroy_super_work
Author: brauner@kernel.org

On Thu, Nov 06, 2025 at 11:31:27PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    982312090977 Add linux-next specific files for 20251103
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b2932f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=43cc0e31558cb527
> dashboard link: https://syzkaller.appspot.com/bug?extid=1957b26299cf3ff7890c
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1347817c580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/40058f8a830c/disk-98231209.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1d7f42e8639f/vmlinux-98231209.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d8bb0284f393/bzImage-98231209.xz
> 
> The issue was bisected to:
> 
> commit 3c9820d5c64aeaadea7ffe3a6bb99d019a5ff46a
> Author: Christian Brauner <brauner@kernel.org>
> Date:   Wed Oct 29 12:20:24 2025 +0000
> 
>     ns: add active reference count
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101e9bcd980000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=121e9bcd980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=141e9bcd980000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1957b26299cf3ff7890c@syzkaller.appspotmail.com
> Fixes: 3c9820d5c64a ("ns: add active reference count")

#syz test: https://github.com/brauner/linux.git namespace-6.19.fixes

(This isn't the full fix yet. This just makes it more visible.)

