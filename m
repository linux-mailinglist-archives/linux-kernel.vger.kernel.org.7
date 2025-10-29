Return-Path: <linux-kernel+bounces-875362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4FC18C83
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B89F4FB4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACFD3115A1;
	Wed, 29 Oct 2025 07:45:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEA3115A2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723906; cv=none; b=V0Rc4X/9qdXNb9EOhMjlF4grdamDf0qn/sfTMBkr0IcjEuHDew/M4+pHq5Xb+GcKT3yqvyqyZ79BeSQ/yJl0xpR0bSnMlyjrwYFrXiOh9OaDJpzD/fG3gXRmJOts2dZTzk5uMWH6x/ZFhbd4mzOoq5jNpQT7OVauJ9xPUWezZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723906; c=relaxed/simple;
	bh=qASbex8b1tAbrTcI/aYaKyIrH18AOotcSFk76cyXWGw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BdOvfQIYHUu7uWIHbQwD3BkkB0NoM0tm8nzVAMJ5oywY1Jht058zcnbThNrc+1MfNdyDz+dcX7ajTeUngo0k+pLzLDjOnpxL9iXcAdbOyDGLStCi29JrQQUoHVKQ7WUP8wajSDk++bss6HzFrNaS7sbDN/aKC2pulLKaOoW46uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-431d3a4db56so296636925ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 00:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761723903; x=1762328703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXNdLyaf6D2T6miP73TejKPSKX6gKB4yjizUvPdh6hM=;
        b=hvcyLfqvTGbdAWUZn5nB907nPAfQ7skfyzVRtHGu7Dg+b4g031oxeFhddQE2SDI85e
         MAIPk1G5V4dylBsjSyo7ztLZ3JeVyZf3BGINVWPcBXM/rjZ6iX4a9MJpmtBn1d+LlhAN
         YqAUfrAd9A9q8nIW8EHEHriOld1A9MStaNVp2bgvaQ1e3Pvzzry+WsnDV0ujOjfAS8vj
         FaVTxk8bl9Ywo3xogwY1lnzYcgj1gYOS1aDsS8lVOOCgaWrI5+gLdVt81ukCwayies9k
         5hDB1i/L/YsMCRfzTuZOd/eFZ2WDTLhPQ8Q787ZJmC/Ydl7VKzF+dODJdgX/2BeHZ7G6
         J+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWf/AaXRDVBoIlg2pDY4D02rrLwc6W4KCBToz4jbYDYvxTGq4RHcHwtaZro56v7mbMT2+5KPNf9GIZjx14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4wbHLKP2F9lviBVQ87mV0SmD/Q2Gpkdl/4UHbvfjitgQX2KC
	STdTSRY+MrPcxa3cAjB/1Gw/k8c3qiZno9xkRYMIV9lEqDG5nDrR1UsJjPOnUEVqO/izte5bYz+
	Iu7AVDTn082N+OVCobVh6CJ0yzQ8URLoa16lwicLwovhYeaSPcHHDkvVCkYo=
X-Google-Smtp-Source: AGHT+IFWlQkFA50EIxytQHq4b0G8iN2+v5aAREDZjZRbBnl4mKZYo0RtsaOgXH2/CUz7oMkAVu283/Y9nRDOSYhdr8Jb1jLP33RX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3042:b0:42d:8acf:a6e2 with SMTP id
 e9e14a558f8ab-432f9028b7emr27217705ab.15.1761723903731; Wed, 29 Oct 2025
 00:45:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 00:45:03 -0700
In-Reply-To: <20251029062547.rwhxA%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901c5ff.050a0220.32483.0202.GAE@google.com>
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

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10d76704580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68b0957bf02e2346
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12db6704580000

Note: testing is done by a robot and is best-effort only.

