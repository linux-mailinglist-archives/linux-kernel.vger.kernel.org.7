Return-Path: <linux-kernel+bounces-845062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39280BC3664
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 07:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1370C4E1A22
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 05:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A32EA723;
	Wed,  8 Oct 2025 05:52:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FC2E9EBB
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759902725; cv=none; b=l9ghP6ExvTBj26zpsaNaXizPEQQDGm8gXyuaNtHRjqnXwk4VL7KrTX8Z19SIWD9FCRglnsa+FZ5CA00rByYvhpP7wg3+Lvov6sB8dLiMhHfQclpflmbZXP5oAAXeHkn7D4rMOvYBTwVVgi5HMxsjnrLLSaoQ6V5+3BfSn9wZSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759902725; c=relaxed/simple;
	bh=rISreA05oSPphUeXePaG+iNGh6KKZHmaHX0gxIZn55s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Qdt1v087n0J6/HzPQ4QKbObIIMgj4MSvS9zsNdc/ewGHkC784RAIFHoRedB5gE5kg/y+aRX/SP0Ma/L3yeV8pX/5KrKcdrmo47ErfbHhG0mlvRrrYQwgw4X75CcvInb/KC9ZetBtVJsDxpxxtCGwGgyLF1SFzrQDnOEckZzaKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f8a89bb47so4736585ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 22:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759902723; x=1760507523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2A6jgIs23tCx0rnkILPWDEiPNOjzuEXCnKHJ2BUu/Ow=;
        b=tCGLp+UKxp1Kmvx/odls9Ijkz+6yULSM6BOc+2o0sP7f58qklP0KBbP6vNX+q/P2ts
         VcIncW/aGykdYcDx7uu2iouac/XMoOMbWAnFqqOko36n0Lj70s1TIEBjnhNgcx7kDqUf
         bV9mluSVW+jhinsvlYHMZFdxPTXaqKSFIx6FqRPKw2EfL94GfHD4QSUNe8Gt7aFyEyVG
         SbHQGUrWYleKbim7oOI+c3cS/q9Tp43XS+fKm4G+9lAa7Sw6aQuKEevGC6W4gMfnX7/h
         t0eZFPecNqdk/B+iJY1MhW6/pZsFj/Dyo3vrPPDGangl2dD8x1/MilbGNsySgpNJRSwa
         z2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+0lXrAhjy+zcx5AdC1TO4gw97Uoz0vw/W4O6IN30xdJ7P5KOkoc/Npbw9taCk1skIfIJk+XDudp2lLU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+KGw6zBWUGt4dekvE9VHuiNGctw9oOH4sqJS3PUf8x/NO/ZPl
	UllsUbcfqoG1WHDl3oNFJCvD0vFa4crKBnfaQj497ILr3KHS18XPCdGlLK1i0hJX46ro9PVNd9V
	3Uiu2k+a3G3huWI87VOyNhRaFK1TVQd6XnGnoJWEY5LXf6rqWmtAaRS0Y4Nw=
X-Google-Smtp-Source: AGHT+IGptM0/W+RC8JNNbvxwbL47syZs+ieVCOeFF3bOYyE+bsCsNYCyWyGD3xDDyj9zvgbuTmomwlV0EBz0plohKVovC+Xba1uN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d98:b0:42d:7f38:a9b4 with SMTP id
 e9e14a558f8ab-42f8741b733mr17558735ab.31.1759902723031; Tue, 07 Oct 2025
 22:52:03 -0700 (PDT)
Date: Tue, 07 Oct 2025 22:52:03 -0700
In-Reply-To: <00000000000054d8540619f43b86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e5fc03.a00a0220.298cc0.0488.GAE@google.com>
Subject: Re: [syzbot] [exfat] INFO: task hung in vfs_rmdir (2)
From: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
To: brauner@kernel.org, hdanton@sina.com, jack@suse.cz, linkinjeon@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 79c1587b6cda74deb0c86fc7ba194b92958c793c
Author: Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat Aug 30 05:44:35 2025 +0000

    exfat: validate cluster allocation bits of the allocation bitmap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1695f92f980000
start commit:   4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=42986aeeddfd7ed93c8b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a5b3ec980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103820f2980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: exfat: validate cluster allocation bits of the allocation bitmap

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

