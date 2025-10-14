Return-Path: <linux-kernel+bounces-852555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F173BD9509
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490A1425EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AF31353B;
	Tue, 14 Oct 2025 12:23:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836C20296C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444589; cv=none; b=LH/fObEoFHoXAGgGAJ3ZEh3nuuwNOGz/2READ0ewCt2M9d4H07Hcxm9MgOczlPlYaHhGnoOfDPhCqiAnjg6a+zr2/cixboXdMj6+/IwvTpbphfltweaK6OGoeWebOaMQQZDKLacfYIuyZ9IzJyjmtXifbJxW+AbeftB7GA6dcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444589; c=relaxed/simple;
	bh=vH6VvyKheY6dFjawkXkdm43f+zC3B5o8qm4ofBZ/OGY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dhQMyAcan9I8XOGa++NdtIR/YOGuJqVCXZWkco2owWeu6w7rzT3QOautDqwsQ0VbMCT8QIOKo6gDNSwXMFDBsCWEnjxuMQ65SjlaXk6JmNNQkRQAPGIEi3anxZEvgjD3P2J221ic9lCkQIUWYINJ/0F1itJvONbzh66enkzALBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42f81a589caso314984245ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760444586; x=1761049386;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEUEDxQ6XRGrERhsgqDQ/kbhdq8PHjMl3e4/8x+0tNs=;
        b=OJ+UFqrAy9DTayDhL1LYRuUk7LB9DvFyN4qC5ClKzzjyINYDeo1DGgYfpfo1Kwwe+V
         ThCdF4aBBmU5lX/YT2MB0yKNH/KO/rDTWFFBtxPAhI2enV/KaxYgM/17yKKzs610cR/q
         LkH5SmlcyZB44ufa09UazbJ0ZIlIRx9+C6cV+gINQ1+LMuAeqmr8TzxgNyxhh5oJGGVj
         n3fLgc0VPSsVu26t36CLWbinhcFCEEUsbqHc1OnTceD9X1ee0Y/xdLCRzs8s79nt4Wi+
         yN7t0sxVdv/iEteqXezzYXiQhn30WIcj/IdwuIMun2AOpDJwGUS934ha0HMIh8rjFPUu
         jAVQ==
X-Gm-Message-State: AOJu0Yw5ao/Ur5y+1fEM1GdnIpOyB9c1A0mBdW71BwK2ybLcGt3/FfDl
	q1VvPIxg2cJ7/CF4inznSyJ9wy1yiHXd6TPvjfK+d9a25t2+jMHcpapl17eLREbVzaSoZDTmFh2
	bCFHq2hwgT06rjSPPFWIoPOeuQxFfZjASPEqNaprZacykM+bex6zZUQIZ44U=
X-Google-Smtp-Source: AGHT+IG29iCVy9DT0dWRDZPqoAO+30mOiF6cKAHM8IjPkxRbLzhd99aUrf0I7uVouscuIFTi825fCro9qJHCgb5c+Nd/55pvqdZw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c5:b0:430:a013:b523 with SMTP id
 e9e14a558f8ab-430a013b5b7mr38887105ab.25.1760444586546; Tue, 14 Oct 2025
 05:23:06 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:23:06 -0700
In-Reply-To: <8a2fc775-e4f7-406d-b6dd-8b1f3cd851a3@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee40aa.050a0220.ac43.0100.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: use-after-free Read in hpfs_get_ea
From: syzbot <syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d2bb34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=858c39e0498e4460
dashboard link: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12cb467c580000

Note: testing is done by a robot and is best-effort only.

