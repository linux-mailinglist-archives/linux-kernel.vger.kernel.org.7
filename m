Return-Path: <linux-kernel+bounces-869752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E1AC08A93
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 05:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255F2400658
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 03:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE400257843;
	Sat, 25 Oct 2025 03:55:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6E018C02E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761364505; cv=none; b=oT5AzjcqVbzY9ZoAYYELffC9cWRJXCq/cC2ofUDq/67IIrCksYcozLCYw1zeKbY9SGnSXX2u6zFW7ze4a18S4XkWF8S1or5xvMWTG3zH5pUoZFJRlJ2Rw2ksPbbdtEGM7+ZIcFInDH5lMwdp7H2m28LwVFJH8sC+ZFf2g52Y8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761364505; c=relaxed/simple;
	bh=GozhVZz+keDKXfjsd581/mSEuZr+tIyyNf/VDrajBFk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F02K7ylwGeX6hM+y0dmfx6neC0b2T+ZiETmnZeUV172u1hSZnnsw5/4mQGj3U878kKdMrNFrz3hQvGeE0d9j1dDo+BfpM4Mgx3wCg+tYVfr/XQqmIZDQfo0tH82gKoGdb89qICBdHO2qp8NO8iAKLe6zyfaQvZmN3076UL9acq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430db6d36c6so91816725ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761364503; x=1761969303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsK/UEPrxyL8ddqjyjxOlZ12wWlgjW3iRxcvD9/hb+I=;
        b=u5ICkeHSvF+U9MEMV2tlmrpVe/Gll+Gg4UuoX73tK6IbE+kYKckMzY7w8lVAAnnbTP
         9dqRBmbHX00FeoA9SSzzUX1owIjvIFyOh0NnBBmDU/Pyb46aGouSum9xbbjmfDcchEMX
         a9dE+aDK/iYXO7OPWUl94qMdY2uLpPl6c5NDR2PUu3NU/S+ia36dIQjTByWbpTWz1X4a
         d14dcr4bcMpB//Jx8wahM+ESTKXIxHCaqPeD5XjoNvFteV+Y/XPhNX7fJ5yr4MgraVuJ
         FMgAte4k2S1xACSdxR/bqo7ncM4qamGHrdZvlalCAwH9DZLuHX5HBZP5ZLSmT0hGSWFQ
         jsUA==
X-Forwarded-Encrypted: i=1; AJvYcCW9lEqF1/EgQLH5PhPyg/6NJ7TVGeTBvDFD/tmFZd7yVF7TNgYTah98jAV39+A8Vl31sN2OeB/Kq9UH7wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlL1aXeIdXqeyTcJXLt7ix/BmjuyzICjXvp4lVIlG2fYOR05ck
	RM+Ba9OHOw1c1Cwp5qbZe3E0afRaazClCnKbJIre+vQNqDrM41PScsCNDN0VsNOZUD8IQOaciJV
	1XMkv0qXF4UZna5ELxo/ZfbDqP6WU2fsVSdeaPyV8spMOtJvz/wkxwEsMq1Q=
X-Google-Smtp-Source: AGHT+IGzzZxvx2blyet6QS8+aYudqnU6FpQQC2PjUXM2s7i7zy6JZAQ81ys+7rd80A/m9wwGcwClwlS+WNbVlIynkce4/rwTfAGm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a29:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-430c5223fe8mr472889155ab.12.1761364503205; Fri, 24 Oct 2025
 20:55:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 20:55:03 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0029.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fc4a17.a70a0220.3bf6c6.01af.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_seek_pagecache_hole (3)
From: syzbot <syzbot+cb91f22d8a581fc19edf@syzkaller.appspotmail.com>
To: =syzbot@syzkaller.appspotmail.com, kartikey406@gmail.com, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13ba53e2580000
start commit:   5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=cb91f22d8a581fc19edf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10052e42580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

