Return-Path: <linux-kernel+bounces-872839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B017C12268
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 01:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791E642540F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A82157487;
	Tue, 28 Oct 2025 00:15:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8914A60C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610505; cv=none; b=StK91MENwkYw80P2f4A2v2OiXdC7y1mfNGYnpCVAFBX4I3dvYP/tPQWxIaAv/YzVdqQeAWeK1bzEthjjUPGFDqLpwYy6wRB8b/yanYiJiQd+v76n8G3xvjC2wKVBJM422y3V14LevmPSFc+0AQXki+eq7zyeUEt/nZ3KLmu6KTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610505; c=relaxed/simple;
	bh=uzfnWLFxIvMtwFrEBCgYkHpW0/Ml5HKc3AfKArq9gC4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YpgideHk6Vg8n7qAktnxjPPVvG5SBwyjUaiG8E7+kgMJfDT+p9Kyt2vtR0plNwtMx1EmxSs18USq4+EIbF7Z3D03lsf+UtTVUMOLhawNBa89s1YCzUbuA7KqtfzvDN/0duqr4tGRWwZMK3tuc9WrNkpfzamdBkfEb73yjFPXsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430bee303f7so181489865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761610503; x=1762215303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWf0kDp5y+5z/noBRXEEOc1QSCxShctYJXY20kNSuso=;
        b=CnbwTVNJWAZDOQN49YQufwgnVuHPRYQ7BqzelyHLjxCdivzZwQlLhUZtlFAc6Wj00e
         vVDlkMqxu6uFRUm2J02kkI+3L3/msxWew4OKfaJWgmgnQN3ZJd/NSqwHZSiNuRVM1i/K
         fi7djNpoC5EtOp4U3BDYeCduTROCZ13A71WDqHNdH/2+wAugX6utEwji5SWnZI9d0l0c
         1mOffWHJMEtzUEDKLq70eRa3UDV2NHpPt1Wde+sulFeTghwKGyWPnUwAfb65t88efpDA
         hfob9OG/4bvQlf/pEzxoyMoi2kTKMg7AdA4OtfHwsZMFAZ0+VHA/6MBrYhgOvwTpthbY
         JbPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6nPdxDcQpfTI358KCvDzK9A5PwVaQcTQf66WgdVllmV2NEKk3yMiq88pUr6Gg5DCMj7tRD2jDU1GjHh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOme8Oj49WaK1+WtiR0QSg4fqFgDGjlRlMMKb4RZmOPFFppF2
	rDGHQm0rVRiQf+Nix3bLPXoJOxFcv+veu0ib6mpjgo4DnOFXXSA/Q2NsAOFLheihslFBBQfV3Vz
	yomN1dYqWl9yiDwXIz5E33n7Vru4ZFd3z0dlMk3u9V4Lkin1DUWgLIl1PpNs=
X-Google-Smtp-Source: AGHT+IF8CRJR1Iq8jPLjLMyPyrQUhbuWJoFMgf6BuOjoav38DajO1FcHJDoxD76vNlMPiIuXp17VmZ33Ezqng1wzdfsvWoSMyPLI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdaa:0:b0:430:a530:ede2 with SMTP id
 e9e14a558f8ab-4320f842c93mr27299765ab.24.1761610503213; Mon, 27 Oct 2025
 17:15:03 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:15:03 -0700
In-Reply-To: <20251027222454.8795-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69000b07.050a0220.32483.00cb.GAE@google.com>
Subject: Re: [syzbot] [io-uring?] INFO: task hung in io_uring_del_tctx_node (5)
From: syzbot <syzbot+10a9b495f54a17b607a6@syzkaller.appspotmail.com>
To: axboe@kernel.dk, hdanton@sina.com, io-uring@vger.kernel.org, 
	kbusch@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+10a9b495f54a17b607a6@syzkaller.appspotmail.com
Tested-by: syzbot+10a9b495f54a17b607a6@syzkaller.appspotmail.com

Tested on:

commit:         8fec172c Add linux-next specific files for 20251027
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=140bac92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9da2d5fce59079e1
dashboard link: https://syzkaller.appspot.com/bug?extid=10a9b495f54a17b607a6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148753cd980000

Note: testing is done by a robot and is best-effort only.

