Return-Path: <linux-kernel+bounces-874603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64865C16AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDBB74F139F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C12BE020;
	Tue, 28 Oct 2025 19:51:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37872264CC
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681068; cv=none; b=iN/nNTxhYKSqnlnz/vLuDndnzDvVvD1Baej7lrp0I2cX8GWWgV2QUk18uXIsanFS8DCIAyr3tAX4QGACZb+tqCTI2VhahAVoJLjUL5XgcQtY24YppoxUJ7woyHh/vsRr+pkybLsWAONu8HW6duxFiXODYCNb0v4mBuqo/SqRyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681068; c=relaxed/simple;
	bh=zlOxXjStvazw+HIDVIJrsZrO4IZd+5XWEhYR2TuzQoA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JwPrB49iB09MuLVTNwQ6hImx9SptaZXp0LTrm2XbozWoWmj8OPfKt6QU4ZE0pZ4TbRHaPuR0/QAZGZ9RRWq9oYaKaQ8nMsfVG7kbAxOQ61JJCDkWr4slWzpN1dK0axj80N3viUfR0Fv+tyqxRarKjECIzWki+XWScDgc53Tq+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430da49fb0aso178097555ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681066; x=1762285866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ktg8b7RrjRxT9a8pGC1gLDdE60z5t3F9fC1pPJ2FifU=;
        b=hBoPXldrFPhxnixKHuuozLIGVj2gNKoG4xDY5ZMCPKlkAEDA5zG9f6JRt+lPIKS43U
         jajkcRmmcvhAzsbmWB0f3rUmNILPgSG4UP5eMLmX1pRyEDfdV13jnOi6LFXYCGn5Xab/
         ze+NTgGw1LY5hcDt0E8CpfL2sgtM4+I8Jgg5Oj8wj9GhsBlmoKuehCceopbhN3cS0qIM
         scRNk9InKblDo31CBfjiCSQyfXaMQfQAXyhzfj8k+kqsHB44A8qBAY02XSXCtl+mpI00
         IRyEwmZR/SUrcEzqHUdirBL5V8zWC0SJdQAVXD0Rxch9GyzpPp6ud5ampVeL0TscX6LF
         +ybQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/4tfBMHKpZtLOQYLZ5tCdl+WrJthSRpwTcIzTKIvpGXpn+swwj0MOcqi+HvEhz65KC121CC/IHx5/nT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxopM4du7DEFYlhG9q5+7Z5gEtnUn28aNz8YipsXr24o510dV0o
	iCTBpN89sZQnXDKP0FoOKCSm+qr3Tno9VXchRoINwUQ41Aq1n1YC1fOKU5oHXcUIMlGamvNaLkF
	8pFZXDdJJ9XnC9jpE2OSO4H2W0c+rLCD8Dr4BlALQbj24DZnE8PcA3wLEz+U=
X-Google-Smtp-Source: AGHT+IEMnOgitIyFG5E0bVNeEpG9bJdb5nuAXAjTHBvbPGrkh/1+5x4F3T0zdqBJJdtFyHvBEL9M1B1QYKRuG6ksGCFaXYqQU0M8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221d:b0:430:e5a4:6f33 with SMTP id
 e9e14a558f8ab-432f902b57fmr5640195ab.15.1761681065943; Tue, 28 Oct 2025
 12:51:05 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:51:05 -0700
In-Reply-To: <20251028182251.0GoZ4%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69011ea9.050a0220.3344a1.03e1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com
Tested-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1192432f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe7b438dcda9b036
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149d3614580000

Note: testing is done by a robot and is best-effort only.

