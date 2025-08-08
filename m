Return-Path: <linux-kernel+bounces-760811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80157B1F070
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 23:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342E6A031AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA2289E26;
	Fri,  8 Aug 2025 21:53:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F85246BB6
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754689987; cv=none; b=GDVo8MoghyqHLyow7ZTkxqK/uOMkfTJ6FqfN4GT2tCUmS+lE5Wevce59N9gGXpxW9lQJ4WZfwVOVa1UDoa9uJ2ElCUl8yFeWvQR0bHKVpV2qnAECK9tLd65wyvQEotBaNIkWTjuNIFg7SD93VgO6Zv9MWHri6ljc2jaDNnL8yIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754689987; c=relaxed/simple;
	bh=ZzjdYrxYEcxo99s9h1GnuOAWn45kMBSUB24pYO67++U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BTkciU5Ztw6NwXMvCj5P+KhqI6Vcur7SIbHvwFiHBzNfWzSDm2Y225BWRe8B5l96511jsOk2McqN8X2VFRXR1hngJKDts84lxmxWwILYWSIL6K+AP7ju2YRYHD2wCkR6VbgAAHE7ZLJkgEv60bluQyWRjH5/5TUVEvH1qOme4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-86a5def8869so719596339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 14:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754689985; x=1755294785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBCMcg0k4PNCUZ4EcEMcgDzn+4NHxC7yQYWs8JkG+bc=;
        b=bYcmDNjLrOw+ZDpGz6T+3xw5Q+FnCBA3LQChhZgW9MgHZ8S4O2kcr29Uk7j4KmdpQ1
         16xlMwE1krsZ5V3xUjWZ56LkcF4kzjV0CjT4Lv8PXr0EkI/pDA9JpiMEue5UxKuYmOZo
         LQBM+dtrT4F9sMqoAcp8Sf7j7IoMfGbBfoR2+dLU56dJTYTbgBwrSpJCATfSiyE54sk5
         2txLyCb/ePBYGI73smT56fssbx/gL0K7IxLLKC+4CgA2MvjS2z+JXFu1lJpB1vy3a/TK
         mKJkpqeFPg/RXP4NQgEokd69XDqOR+4UtxX6Yyy6qiZwkPnPZMtA2+eP6sBB9NHG8tBu
         TOuA==
X-Forwarded-Encrypted: i=1; AJvYcCUIoMURXxeTxbqyRceD2YbggEzxdxIqROwOtlZCXK565KeMjxzElPHJEZY8gDdnFqWiMjoCR1F6NinCDmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpiXpGLFKi3qx/Iv9HQIqgbXO37l+pGYwPnd4Cfi81gA9E0ZE
	0gtoy0eAB6AKRSq7naLp35ysUxzfS+YXdKUjtwvFCRUKNliJz9RN9mpHjf759gg6zfKlm/xjqb6
	PMUFg1QUyOb9/IJBBDMjXUwVUJj/ZwdwSr0qnkp29RBKT4wcN0+te4X6pFGw=
X-Google-Smtp-Source: AGHT+IEF1na4CL596K5tr9vAfldDM2eKsOY8NzKJNyOz392+5p4iZ2zo9TIo+Y+YiykN5IC1WA2v5EXCr9l6aXuaz9h/U5aUXy/9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1591:b0:881:8e2c:9995 with SMTP id
 ca18e2360f4ac-883f12552ccmr907971639f.11.1754689984923; Fri, 08 Aug 2025
 14:53:04 -0700 (PDT)
Date: Fri, 08 Aug 2025 14:53:04 -0700
In-Reply-To: <6871b125.a00a0220.26a83e.0066.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689671c0.050a0220.7f033.008b.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in rt_set_nexthop
From: syzbot <syzbot+97bf275720e06ad75f63@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, dsahern@kernel.org, 
	edumazet@google.com, hdanton@sina.com, horms@kernel.org, jaltman@auristor.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e4d2878369d590bf8455e3678a644e503172eafa
Author: David Howells <dhowells@redhat.com>
Date:   Thu Jul 17 07:43:41 2025 +0000

    rxrpc: Fix irq-disabled in local_bh_enable()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a4c1a2580000
start commit:   d7b8f8e20813 Linux 6.16-rc5
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6cfc97245100778
dashboard link: https://syzkaller.appspot.com/bug?extid=97bf275720e06ad75f63
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1532c28c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148f9582580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rxrpc: Fix irq-disabled in local_bh_enable()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

