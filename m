Return-Path: <linux-kernel+bounces-882129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF45C29B51
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 01:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD5F188BF21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19900157493;
	Mon,  3 Nov 2025 00:43:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D698BEC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762130586; cv=none; b=I0EEGDDNI0dLqYGTCzQZcPni0277QLsR4ZoP9DuZiHKYCeCh3sudnI/HzGf/fEcFEzo8Qlxy4e7UUrqnZK3cpLwTUNivMB1GC7EiZn43zxPjsmPNL4amlCqkWfRLryQQm5K6/dWf50LCFzu6yUwReBN93h85VCrOTRok9P8z94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762130586; c=relaxed/simple;
	bh=rzuQ2IwGQu2vGH0Cb2K/9/sOVr+Ce5jdccc22FuhOzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A0MERrLIvmqOjYrJo5yImFld+zFu2WoLC+wjtf9w6vqsd31pYgwwPQipEGcEbOS4xxHmjv+uPzgvhvsiDC4Gva1ITS1jL7thS4USVFEzkuFoiVbPafaEGBIBonnsID5R6JdNqow9o8X2bS0+ShRns8YSQ63ZQ78+YDvsq0bSaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8839f138so393112239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 16:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762130582; x=1762735382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUbdcTw4VhhGQ51DNJio4yY6+yjI5cWbQg754sQwc/M=;
        b=I/XmnzR3u/+FYwsBmz923zow1qcqjs5tZw7K0D0RUbIWleuc2vB7GCaVWUPrG8VTqL
         HsI5zfuIF5Lh8UzlGC58Vjdec/1zNii2HboVd1GFvwrMcM7HF9adeFcNYw8LFYwJ4/c+
         fY0OWE6SP7hS+cndQ3zBnZpqJH0iEYoTHs+jJmya4TbUBK5DPDbiqiMtzLuyPewwymrM
         WHN4sTDhMJIQxxJr2H7Bt2iPAYk+bBs5S+ObXgY5dQcyBH3HZFtuPs78n9jQ6DyBvZd5
         SAZFdleBlYR+FrcpOpLACVvqpArrmZaaUq4Z9cJNIb6NLHYgMedbVqhAM6J4OpAwtL9n
         t8QA==
X-Gm-Message-State: AOJu0YyOJxCMnnvWzMpTpTOkqpDz7tYt+bgpBPUrHbp747RRnPWUI6Q6
	Hb42b+lMkiBedIvx7r1zAFr6x1oFUzZQUm7GNnF7tyIxAhpRAKa59irUE9KTaHoZBRzdk1oo+Ag
	7hwx/R5Lq/2NX11Y5nwLtORQj72BCtZmkPz6tXBpUMnvnRw8QkTy01CGyWyk=
X-Google-Smtp-Source: AGHT+IGZDNHVRoeekTneCv3hA7bm/UIS3AretQExtg9lsC5D077WCVd+YhpbvB3D60szPOjotwts4uxif0082rfxPqDRCt9RHSbJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3110:b0:431:d093:758d with SMTP id
 e9e14a558f8ab-4330d1f5a08mr154713395ab.22.1762130582263; Sun, 02 Nov 2025
 16:43:02 -0800 (PST)
Date: Sun, 02 Nov 2025 16:43:02 -0800
In-Reply-To: <CAHjv_au+-9FMB-XUZvRyHP=GVfAxEPN_N2Z6pyJV2=FpPAQEwA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907fa96.050a0220.29fc44.002d.GAE@google.com>
Subject: Re: [syzbot] [bfs?] INFO: task hung in bfs_lookup (6)
From: syzbot <syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com
Tested-by: syzbot+e7be6bf3e45b7b463bfa@syzkaller.appspotmail.com

Tested on:

commit:         6146a0f1 Linux 6.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1683ee14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c614fa9e6f5bdc1
dashboard link: https://syzkaller.appspot.com/bug?extid=e7be6bf3e45b7b463bfa
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=111dee14580000

Note: testing is done by a robot and is best-effort only.

