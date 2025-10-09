Return-Path: <linux-kernel+bounces-847446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A1BCADB0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03E4188ABB9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49185275860;
	Thu,  9 Oct 2025 20:56:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3452749D7
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043366; cv=none; b=OjiSGZ8qC7cBUTQ/icI09Q32daNDt8JJ97z2mRBL7TXN1weC5Nku7DplvfNXooCkAPOZNjZ/qtN7+MSATEdkEqAcyvDSP1BlAfcF4UfST42XhFH281ZR9xvi+r9HYO/a0ndyReTJANCx/Tpky/sc/nwHxiuK8PotImkeu/6BxEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043366; c=relaxed/simple;
	bh=GfmPq3HACCp8o8RV9X5r7hr9CR4rpOel1xO+LMrzOZk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sVQWheap1Q/Epjan8fRO2MbtudU/unHWaywJW9MAw8BYSgt6kSb4M6wsMYsNiYMGQl9MD9gO4PRwuijlIM+wQbC4IQ4diBHee9L2k1B70+3mbVfNL7FvU+/3V3XOFEJePfoD7RxrF5jsD7leRWWywEHe0rDDlQWUUaS+rwZ03xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-90efeb58159so282703039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 13:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760043363; x=1760648163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hksci9x2jx44nWzRfyFuUH4NBDU7N2pjE2NiMbKpeC0=;
        b=f+Mo4b2dzWNZ03VtWRf3AEcH4EOdpxN2EiEKcyDMmh0ttRfvm1DZZsaDjWEZlt7lTa
         JU5NGihuOShRt7oJZMcvVkJrjglpkDE8BZ7Ic+TETetJ91pOPw6eeUl1rS6Y3DPCrxw6
         dWSJSrt6x1XL6dzLHUmQZ3F3sBM+eTYftwQxAOD45KJ50kyGlLgdJ3ZGm7B1KEIQe6fZ
         60/BwBlAKVKL61P0d5Cb++mz3ivFcl8RUeDoon+qqqmi8Bw1716PIQU0ubXq87gFnbTh
         WXZC08ziX+K9Qr4DUoXNOPjkhxoYKQHkTN3olsv6037jTxg+ILtYKfjBT+61+11BDgPd
         9AjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUifYweWfZHtvKatbR56XOGgKwgcmvnjuw1WMvkpnhK47yiEsaOM5sjmmQnroc9ssKz/tXb9rMgRUvf9L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiiJP4Y9tXvST6O+vb9UYnPPBqc0Hz7JmuymJfyRU9szogPo4O
	3IC4KqNH2ucUrDYrcczAhByKPbXif+NzXv3FYivwfq98WgPF4ObP6cdcQR0Eh7L+I9DJfjjhDgC
	OaWxAi5Rsrdc8bYe5SOcJHcAP4oyWqa5i46KbE9nCfzTOMhifBlh4kMb1Iig=
X-Google-Smtp-Source: AGHT+IFYtivfCGpqnWFo4z8EgycX5Hd412zY/vm1trt1fBFKxZT7ktTkYJX85FlbrPlwX8RsxqMKMjwyJRG58lCrZszYaKW0qsQH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1652:b0:921:2f68:fa0 with SMTP id
 ca18e2360f4ac-93bd1851614mr1049241739f.2.1760043363452; Thu, 09 Oct 2025
 13:56:03 -0700 (PDT)
Date: Thu, 09 Oct 2025 13:56:03 -0700
In-Reply-To: <68d32659.a70a0220.4f78.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e82163.050a0220.3897dc.00a3.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in hook_sb_delete
From: syzbot <syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, gnoack@google.com, hdanton@sina.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, max.kellermann@ionos.com, 
	mic@digikod.net, syzkaller-bugs@googlegroups.com, twuufnxlz@gmail.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2ef435a872abc347dc0a92f1c213bb0af3cbf195
Author: Max Kellermann <max.kellermann@ionos.com>
Date:   Wed Sep 17 15:36:31 2025 +0000

    fs: add might_sleep() annotation to iput() and more

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1092ba7c580000
start commit:   7c3ba4249a36 Add linux-next specific files for 20251008
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1292ba7c580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1492ba7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa7a95b14b1eaa
dashboard link: https://syzkaller.appspot.com/bug?extid=12479ae15958fc3f54ec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12280dcd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111d852f980000

Reported-by: syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Fixes: 2ef435a872ab ("fs: add might_sleep() annotation to iput() and more")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

