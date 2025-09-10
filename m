Return-Path: <linux-kernel+bounces-809213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15AFB50A13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9607956495C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53E51E0DFE;
	Wed, 10 Sep 2025 01:09:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CE213AD1C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757466545; cv=none; b=gSrXmf6XQakT71RFOlTJycRDFHlbAJsTnJS5lYjceMVNgus7rrZoU+4AlPjwLEkqRZssDUuFuCeO1x0McM/qRUSgz1UYDSc6Qmq+79+iVFjeeJb6jI1HRVGhu9ltOyGQ5imQ1yaBRLf3xRUhJrjDC78XGsb+yQR8cODsEL1AsjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757466545; c=relaxed/simple;
	bh=IRizUOamOmhJEwpy2DJKRPRKP27fap+h1Kp1ltdeY4k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kXJSKRJB2lRUKvfj5XtDb5mGo2RlGFd99iZ/m7Z89JJRyMvYidqlZ2ZkqcT4gOuuxFMUodxNxI7O29QL9W4BwxiF01C0OpLTeQiAUWa9iq8BjkA13kKEq0qSyeMxXpKwafyLl4h650M/IPyH9dOXZbLyX4MJMaqIFstbxnysWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f66898cc14so82982485ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 18:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757466543; x=1758071343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXfHlpVLcixgaOaRL1866rZuesWEm9wXh/ywKGuCQdM=;
        b=JnuXvPLRG249MaMWJYBh1yStXd47wjJw4XONPxy8SNND0xUgJ8G19/wxVtYtPeCNYa
         EMuf+3DQsYZfAmH7rVufoJhhtlhL6lIvt4Gjpod8OYc3Ak3qnoUn7K+Nomq8GKr3qFdn
         H+Au4IhvL8YZI6vswbBRdvzBkZGAwozT/+ss2DtMxKL+aieGJaKmxbiaYbSOPibBrRRc
         HkEDkA63Bd9eouvUtg30CFImMeOJy1yPMHor2x0chs2JbeEADciWjUSfpoD6XjGPVXhW
         Sd/T9Ln9IhpSQWybDINUcrD9qviKL1FF4ctd0ekI3EXFBRnzC4Xvi2JmLa2IWwMm7G9a
         7v+w==
X-Forwarded-Encrypted: i=1; AJvYcCVltT7BpXjtEmOQFby6tpgm/VbSQbI5uwSgTCifCM5SBkR9SRz3xkiPYvYGyWA8hRU1/R4eBYXE2wd2ZdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAfjUS39hQthyzFRNLbSz0og/iEKEbVhlUGXJnIyuJSP4SYCD
	hoPxpyU+MgGbv9L5Lws5wm9BKTFaZ0M7lgOyiK5gXgSTj2AmZQc+UcWE2LvU/kvCSuKQQ++oRlr
	VgbmQ7J0tB+x5a+jHAgK8IKvPIWqD1YU9mOKuGFfbSG2uaRrEmRT+RoRLYPw=
X-Google-Smtp-Source: AGHT+IH9rh4e53Oa9hThsWGoOs3rdE16aJww1oo5kTV1j6WCvK9n/6U2L4SzRwkPzvF+rJMXsLDxhD+kEkapWJCAc9r/BSm955dO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:408:f6e9:6dfb with SMTP id
 e9e14a558f8ab-408f6e9736cmr136424255ab.30.1757466542910; Tue, 09 Sep 2025
 18:09:02 -0700 (PDT)
Date: Tue, 09 Sep 2025 18:09:02 -0700
In-Reply-To: <tencent_D2897063A84456F7739765A6C3B375836505@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0cfae.a70a0220.3543fc.000b.GAE@google.com>
Subject: Re: [syzbot] [media?] KASAN: slab-use-after-free Read in media_devnode_unregister
From: syzbot <syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com
Tested-by: syzbot+031d0cfd7c362817963f@syzkaller.appspotmail.com

Tested on:

commit:         65dd046e Add linux-next specific files for 20250909
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13c4ed62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3b38340153b83d4
dashboard link: https://syzkaller.appspot.com/bug?extid=031d0cfd7c362817963f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ff2642580000

Note: testing is done by a robot and is best-effort only.

