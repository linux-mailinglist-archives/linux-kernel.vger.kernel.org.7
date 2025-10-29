Return-Path: <linux-kernel+bounces-875111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F7C183B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 644F435137E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A63F2F5A01;
	Wed, 29 Oct 2025 04:24:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC025FA29
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711845; cv=none; b=hbm+VUqZlwu8/FasIzUfRAWa9vCVRm02GclM7LM9y7YuwA1cZC33NinvjSCBw8TaaT8nTMgq1RrfTCH45VSBC4/w4T2Q4LbuKfShwijm3SvPqRfHGNGOz6y8QysJGKJIv5rBk+mwW4g1N2nAxUOX9IrCcHRiOuXNXrI7SO8YXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711845; c=relaxed/simple;
	bh=UbvujcQMZ8LUmiFNvZwfWb8fqF93TIdoQTs+9b/gwnc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NYLOdoT9PgtZENJpmxaCz5H6+aSIPs5TZbdfBnIlyZ+FgH+VTvazE8ujQRffuYlzrd3fozWe7gr57iU2nSXRPgPVojdpe1fgwrDk6bbYzjiNZ2lxcgA2QD7fpgG6vpBpmNqec0yOe39lnN9t+eTnyl3tsp+cScKYZrXgXiupbKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c684035eso7435995ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761711843; x=1762316643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0+bcIjSuIlbcfy+h7iYgchQvQ3SGlGN19/Nz1UJTv8=;
        b=pAQWWQo2AkYvySTAc5GMP5zvatA5o4BARH2NLuB2ZN7XWmcvdTHK2BVeig+xay1wmq
         dUYJHCcfPUKgFEOoBmIQuEKyCBI2kbrhY7fUSsAazHzui+YlCL5OVgJU4KJJmuFsHOHZ
         zHC4XV09b6qL2gypK/JI9mE5Do7LQnft7es5REPesaCY+GbQWtZlwiZ2R1nBv3Qwfvhk
         9RINhPWaLUZ9VM2zxnRLie5TTBQ8pw0rkGN5wO8c0/KB8h2Ck5tH44VJXE2/TrWqUD3P
         baKfAEKDhuk40k94oSyXttZqpvbXdIhhTpT/Hv3vgUNYDJSWc8iPiRwh2yNa8xuTlUku
         4W+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGnKqTzH6MTv6kAdkHA+LZBVZU/xX/gBKhtjI5UytpKzmFcukCQawOjf2FwPgMgSAIPZ1REfBNMvWJemE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyduHzw8mWFNdtAmfhA1VcCTd93T59rUgUC/gnM8fKMgXwLbtIo
	MsyVwWe+js9xrpS4Hmaq3rYjnHt3DNzRyy6MHO2vPlHVYq6DzeDpa7JkXBqDdaxBV+fWX6YqF5s
	MsAWGoBczqkJYMScRrYCDY2QSSrpfOedTIcxxICus30u3jCOTq5MCJqK/ggM=
X-Google-Smtp-Source: AGHT+IF3TNOw+Nfh8K2sRqUOacvr45PJS8UO8XrlU1lvB3SVDr1gDkQvmq8ypL6ncttVjKbqGTngtKtZCMNEtJfeKWTMMgS20zBJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:431:da98:3519 with SMTP id
 e9e14a558f8ab-432f8c55920mr25195695ab.0.1761711843444; Tue, 28 Oct 2025
 21:24:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:24:03 -0700
In-Reply-To: <tencent_EFA7FBC6CC92D88645C98F6EEB2EC04C8706@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690196e3.050a0220.32483.01e7.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING: ODEBUG bug in nilfs_detach_log_writer (2)
From: syzbot <syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com
Tested-by: syzbot+24d8b70f039151f65590@syzkaller.appspotmail.com

Tested on:

commit:         b98c94ee arm64: mte: Do not warn if the page is alread..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11a09c92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158bd6857eb7a550
dashboard link: https://syzkaller.appspot.com/bug?extid=24d8b70f039151f65590
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128b8fe2580000

Note: testing is done by a robot and is best-effort only.

