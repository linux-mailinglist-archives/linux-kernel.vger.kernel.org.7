Return-Path: <linux-kernel+bounces-822134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8CB831AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA834A204B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463A82D7DF1;
	Thu, 18 Sep 2025 06:13:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53929E109
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758175984; cv=none; b=gD2+1NQNZz9Png3yqcNmpHWCRQ89E9h5aYNfL6cTcbqm27xuwjYId1KWabjjC7EYEnoq+uK5Vgl3CjE18jI2Sl6K2JoX6NuyhWBtLKqwlpts+AjB3y865yVrCwGfT8lVpgZgYqN18MfppeffsRy4vI3c0G0BLQURhZAb80AOT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758175984; c=relaxed/simple;
	bh=/iVxXANyReG7yaoK0bfYeA2u62svJzfCX8SMs9l+lGA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jtkA2rqeD58aFnFm1P17Gm6MIfYvn1DcNRcXaChDIhrNClGWie0OvUUAzz1VBE9pSqyZFX2ox0yRnKIrBIDsE7SI6BpWbqdXQGSQ5Zno3E7fCGr7SleEIOTMVxJfKI4D8PX1FMJxYC2ZwqutphxfAxjQVqNmE5wR/BuqAGn6anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42404e7bc94so13286455ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758175982; x=1758780782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2JWCzIWYpnzfcU15QbHfuxLHwlgc1PtHcNs1eNhIAg=;
        b=SKbb5yFfCae5DHTDHLxzCtvJe4tcTvvYYqBk/9TV8wxBuFiEXCdwbYxbgRzfgzkJhV
         N5J8Xp5pzCBEKX/Rq7OddrNuj64uLCBymiPc9vkOK8xKofawcvzt5ZClGMUouL9kAqxe
         jsg74WXVpBptldmqOgnbWG7cTYpZCg92uzNMX3S4L+xczqUfHIckbTZoiKzp7CoFQeva
         h8VrWP8Z7zjDyr6c0XB0cAc3AFkb9aStfRfKboRTUeTUGEYDLH3/hvzzt5mO7ymUDxJT
         H9hRghFiOE+NWEzSF5Y8Zq10iUBm+5omR72CGUMQodfl/f1FMdAwQad7+SJ7lc2OpjFF
         AUsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxSmr7yYbFDli8Fp1K3tKkVWr2JAlwUJNLCpeMCcMC4bKP7yJrG4pT18NjOWOQRwPcORJ6RoFwcvE3JjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFJ8qQ+AV3eewDvqq6P5D4gR1c/Ou3RVY7NYFUVmoutmpljbW
	+IWKDzxYL+1Bul+o7YjXPNo+AxefzwRmdFy6nCpzPYCG0nuEnYHCBQZL89P2rf6GHr6y9Gj1I/7
	aeZSugiLqus6/HNasKDxd2w83qbgSgP7W9FJ9RZt8XCVVm+MnYqdkAc4SRfE=
X-Google-Smtp-Source: AGHT+IG7XvhKQSwhi5NGH7XbGyi8B535OwfeGdIuKq72tPRWQB/NFHXSLSugejmQaigbfTCVUcAmgTSpLRmf//C5NLztvQeMUIYH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1649:b0:424:9d5:fd6c with SMTP id
 e9e14a558f8ab-4241a55d6f2mr61855105ab.23.1758175982456; Wed, 17 Sep 2025
 23:13:02 -0700 (PDT)
Date: Wed, 17 Sep 2025 23:13:02 -0700
In-Reply-To: <b0988506-dbc6-4d28-8f19-9c50bdc44f84@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cba2ee.050a0220.3c6139.0fb3.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, yanjun.zhu@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Tested-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com

Tested on:

commit:         1924f741 RDMA/core: Check kref leak
git tree:       https://github.com/zhuyj/linux.git v6.17_fix_gid_table_release_one
console output: https://syzkaller.appspot.com/x/log.txt?x=11feae42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4239c29711f936f
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

