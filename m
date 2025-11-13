Return-Path: <linux-kernel+bounces-899040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A78C56A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2546D3BA4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B73203BE;
	Thu, 13 Nov 2025 09:33:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94812D9786
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026386; cv=none; b=NPWWGxR7jNk0xCcPKvDD2ev+aqN2vuwHMXOmX6Z6TB+7cC0FA0k6kjEoCe26YvvEnvYclzCEAVXpxD8iHrsKR6J/1i+TX7gyNo5KsV/lGpKJtN2AiT375UvL4iSSnkrJKEcZpxNAcjSMzvf3yLgNcuLlpp2RSL/MVGxI4okkSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026386; c=relaxed/simple;
	bh=i/gJ9OdcSlL2P2pnDCmw1Iju5BSX0Wns1jv1nn8Sn1k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XtZIJfnXHChDdmIviuodT7BK5IcUL/L7GUb0Ar3jaGzH2Fc7dnyFwK/71SK0krsmdrMe8TeemoV8gL9OHZlgAR5MeUviAa+5gUiLzfu8UTazadNEWwr1lMb8JRsWjHIVqbhid9Pdl/jxw3sl0sghSmU1u7wWyrpHd1jvyWT00ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948610ae935so56167439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026384; x=1763631184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AnQbfy3BP7tZ5yQYDmEOKUZd+jMnHCYAe2SJPFPgL10=;
        b=xPISnaF2TV2M/Lu5vvmVGPzUsR/XjawtS5C8ndivxzKDDHQOT2fXyVD6nwRb3Pp9XJ
         JhN4rKG7jUf96ouBWElIn1G5SmWB57EwJKnzF2tdpTsNeEDIwpdIqZPBmSHsOeehYa3N
         0G49b9KnKrNSFgTPUus/09nS+AVQjg36KgdHcGMQ7qSsyQK2iK97JkV2QlQ4rXYcZXDk
         Cs4dUtl0W6L0SrcmRFd1G0Wexv3QhgoySEwc9ZnVWS+7+7TPWx4GJ2zl5JYXjGl/N6/G
         nmJAGtLuruzjpQ93FrbOlUYUpKsqMgsZSFumPmAt8GjrojS3miTAWruVBW5HJee/hLR5
         3/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjnU1NE93+Mxp9sXCbPYsYlp1PtxFZCCwE+Uv0zYOGCLSfiqM60OE/oDuuvA6e1ee1QMvIqYYfhEPNdv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+m4YQuQME0c679JhlXuLYGLcImRbUsuG6pvk+Vzve9n8wxbk
	tepsvUdMuJvHFA7ZYdKMKA6W/bcLPP4iujpf01rM8NeoVV9OFV07pTDJuB/vjZypnuhJGgyzsIO
	b7SDD1CxjaiPImxKMjSfElGkrVTmCsX5RdcTw6mHDpiexosRBSYqu1itIRz8=
X-Google-Smtp-Source: AGHT+IFx/ByR1aVdOKGyVe9jmEMOK9B8X6NWIRr5k9C2ynZaFrg1uVQjjbQrjKW99Za+5V9uS/2k2Fp8j5W5mOS9Ph0LCj+ruzEI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c1a:b0:948:a115:db85 with SMTP id
 ca18e2360f4ac-948c4561832mr789905739f.2.1763026384162; Thu, 13 Nov 2025
 01:33:04 -0800 (PST)
Date: Thu, 13 Nov 2025 01:33:04 -0800
In-Reply-To: <67886ff3.050a0220.20d369.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6915a5d0.050a0220.3565dc.0023.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in netfs_retry_writes
From: syzbot <syzbot+666a9cb4c41986207cdf@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, dhowells@redhat.com, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, m@maowtm.org, 
	netfs@lists.linux.dev, pc@manguebit.org, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 290434474c332a2ba9c8499fe699c7f2e1153280
Author: Tingmao Wang <m@maowtm.org>
Date:   Sun Apr 6 16:18:42 2025 +0000

    fs/9p: Refresh metadata in d_revalidate for uncached mode too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15831c12580000
start commit:   a2e94e80790b Merge tag 'block-6.17-20250822' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4703ac89d9e185a
dashboard link: https://syzkaller.appspot.com/bug?extid=666a9cb4c41986207cdf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d5062580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e33fa2580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/9p: Refresh metadata in d_revalidate for uncached mode too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

