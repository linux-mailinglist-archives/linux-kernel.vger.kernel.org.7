Return-Path: <linux-kernel+bounces-857895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E012BE826F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DBDA35C916
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42160326D42;
	Fri, 17 Oct 2025 10:53:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD22C21FA
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698386; cv=none; b=UnNNpnSga5moNR+2cCEY0JBV1iM9EZ/69+qGJEnW03NrEL3qHB96PAK50qdZhBgyqWPovlnKDdsYz0zwHNPu6OUNIzBn9GvgHcv643e+h00yH1OWMgAGz+b9kbTjBSbeqAzgQS7CfINa5S7C13VW6Q8QSb2VxKMsFrdu/sWuQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698386; c=relaxed/simple;
	bh=UZ84pK8EZum2L4NrxRfDoOLY6Mk6uo+z6/MO8unb2Dc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XcyOc1LicPv3dHag9ADf0AIe93PPVHcJE0EdYpMu7PDpUyh+ccXUkEI2nOhfsYuZzPdU0dGYEQBP+Wbe2yqZ9Zixy+rdyrwhSFxBmAmgEcO9s+uxojZ62OwmQgj4m8EANajPCHAdPSeQEYVMubSWVpytxUE6g+OXUlRzyv9w4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c8321bc1so6321125ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760698384; x=1761303184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPL3Arg3gcXkbhPv1W9tkdK4HJ9POrjtlajg24JkOqE=;
        b=woRYQ5wP+oJwxv4qNuZlmgEzD2wWlMXGTttcUZVz9o58Xn0Aau34NTGXichs3F02Tr
         Y3N0ifW13RhV15NPgTvZZWdWBURFYdkZXCttYHT8C0+mbnVvmm2e/YBm80zAPEVOAB4U
         npm0kI90QxpigR5Hf7J0vaV4OPYxkzQuC7rdcnzwjyxdU/DfjjHoHvsvLfNfWqjY3UHV
         HEV7tvWw/bWB6TUswY0EMW91AonlAMX22MimpijrjOq7hx4j7JpMgrl9KdFx8Wm8DD2L
         0aDHA18yhlEzxi5gfcVgYBKmHvg4zZh34VaNkYJN6n0KDeAAcSDZHMYZtuJRa7uqrG8b
         FU+A==
X-Forwarded-Encrypted: i=1; AJvYcCVKxq5A6uD4ERPtDlCNRFvOaw/i1fKPJ1tyH6tILPZ+B51cAlY1ZPbXON6Q1vGKxHXsEYPtThLL0zaicio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDmYTpQW33YM3Mo+GFwQ/b6EnZfeMRa6SFzyQKuN2KGn2kJr/
	u/UAHeJAlvsU85KYhY2rI7jpBc6qVpBUqDsppm59/d3TcJr24i5eOub83Am+4KFPxHZ3jRPPUeP
	tG7DGqmvMn7BTXb8VZ+zbno8vzLUrNC4AuE5AvAw9+wf/8qcAc6KDICuEnuY=
X-Google-Smtp-Source: AGHT+IHmxJ13Rz2Lu+NbMBxEXD8Heu8HuIssxc/gVTc21ECqI5eDExNTc4rXaDI9jqlDn4xLtV8QBDUtIbnuo7atZCPhjPPp+y2d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1445:b0:430:aec5:9bee with SMTP id
 e9e14a558f8ab-430c524ce95mr42601305ab.7.1760698384460; Fri, 17 Oct 2025
 03:53:04 -0700 (PDT)
Date: Fri, 17 Oct 2025 03:53:04 -0700
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f22010.050a0220.91a22.041c.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
From: syzbot <syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com>
To: alexanderduyck@fb.com, chuck.lever@oracle.com, davem@davemloft.net, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 14ad6ed30a10afbe91b0749d6378285f4225d482
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Feb 18 18:29:39 2025 +0000

    net: allow small head cache usage with large MAX_SKB_FRAGS values

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177a35e2580000
start commit:   48a97ffc6c82 bpf: Consistently use bpf_rcu_lock_held() eve..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14fa35e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10fa35e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f7e5e2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ecec58580000

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Fixes: 14ad6ed30a10 ("net: allow small head cache usage with large MAX_SKB_FRAGS values")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

