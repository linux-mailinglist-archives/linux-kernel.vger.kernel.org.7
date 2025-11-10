Return-Path: <linux-kernel+bounces-893760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9439C48489
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8553B41A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3052296BCC;
	Mon, 10 Nov 2025 17:18:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F322367CE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795084; cv=none; b=G5Rkv5HZ9fVQOe7CC+xdEm/KhkNDNpTNyB/Nm2FlUU6dDp2+jncXCSEm5F/8tREa4+dopewFFKqdQuWOiwA5+mR9c114HboZRZAXQ3N3QRX9YTo9jOFBhRKifcVrN4M1DfhQOXRqYtZf7WuR0mFm+21wlfVatP4IR1SIOSKzaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795084; c=relaxed/simple;
	bh=n9nKrmo69XRnARCUa+7036LySLCjOcAlTKKrhuOyab8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SK6AFnhv/b03yyA3755/uwVlkwK7wdhZN2OW1Vg/j5SsvbkhVq+8rKow3Xt5VL9ZHc4iCw1DGg88HjZtwZ+hgqenUe7UTvwwyGcbMqM6paMfykYiKVRVp7h1P5I1AwdmKsNvJCpl4AnMYMzHg1RUWKjpyAE2KdQ+AE/pNLo8f1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433817220f5so9950925ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795082; x=1763399882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UaaRgjGqS93XeS1cwQMSPuJGy05DrevY4VPPja+ISkE=;
        b=Ii/zALWEF9g7hR3oj/YmcXqMvxMFDGjvJlnj4+KjXQU4wZkqe7e6eJC3kKamHjriVd
         UwHkGuxHi1oRAviz8qNQeXL199fas88Rsa1oNVDepuwQ7hn/xESlmlrpxw6aPLqo6S2C
         Dtt4511Tn2x7bdty3CBM/DGY2vbnSMIgbbSvrtrxaY/6NZq8DoIdd9Dn14JUyK2M1W+g
         jpjjqddU8r55wpw4/OtOU7V7TKVKFhF9sN+yrn2d+wdgWemMyuxvsIoJn+80wMB/lLn3
         Pk54ZJXj6rL5EFB2/dazlbhQvPvz6buWCDj8NfJeddjRclPLDx6w0HjWC2k+81IjGYhr
         AiMw==
X-Forwarded-Encrypted: i=1; AJvYcCVgQm+5lueLxVbGDnTQfkj01Ze/QWnCYL5o3+OgrXgqUT3zblakJcIa5pJ0F5C9MYuu437OKnngiaJ4xtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8oEYoq7hozDmbJ5IBF4jpfqurow3yAce5uTyPbjkb9TTASICB
	yZK7rJls78/dV5jJ7nSSAc17Hx18jMtBzIJK6f4DXdD5ZOYj+DF9JRA1Y2/liNkMHFf1+2HP1WY
	FXy6dJsvWeOqv9985NjwC7z7JZsAPvRDnq4R+zr4mTlE2/myy7AXQG+q8ZbM=
X-Google-Smtp-Source: AGHT+IFeIIZNnSTcqc/TEnxm8q5FiTr5/IMW2NpeqQBAWsujJ494vN6KDpRFPyN5leJsoKtybDX+9S+78R+ONH/g8MSQt4Bb3XrR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c9c5:0:b0:433:786a:5203 with SMTP id
 e9e14a558f8ab-4338bee4453mr1763695ab.10.1762795082069; Mon, 10 Nov 2025
 09:18:02 -0800 (PST)
Date: Mon, 10 Nov 2025 09:18:02 -0800
In-Reply-To: <CAJ9gUkHct+WE_cZN48BcNRuvcVnwf+qeOFxMCF+t263KqZAetg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69121e4a.a70a0220.22f260.00f9.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in ni_rename (2)
From: syzbot <syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com>
To: kshitijvparanjape@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com
Tested-by: syzbot+4d8e30dbafb5c1260479@syzkaller.appspotmail.com

Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11508c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d8e30dbafb5c1260479
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174ab412580000

Note: testing is done by a robot and is best-effort only.

