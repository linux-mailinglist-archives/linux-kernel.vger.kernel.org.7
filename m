Return-Path: <linux-kernel+bounces-863498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA7BF7FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF3B582F28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC58338903;
	Tue, 21 Oct 2025 17:55:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C823EA85
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761069307; cv=none; b=VLFoKf1BxJC+x+H8lyP2qErQkkRqU0Iybl4yyALJnsqUlQd62oPIE0kPxmTzOWimasqvkkgEcskx4601T9emVuBwvXnZe5klV/H4yN05a+R8obfNK5Sv9eRH6/8AvrzkRAR3EUKLpTPye69OYwxtCw3f0bKs8Zo8xVGq3RyLvRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761069307; c=relaxed/simple;
	bh=d+lG6AP3eFraayHRHDB/uxEDVCrV0RcOnUM/rBbByaM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yq2pJ6bs4ewsd1zyLawOqGMKv7nBeNMTQNiF5it1AOZwupGrAqA8HtmEi7VidtiCCQN8rD9Lgg7NARIOqRhNmEXA1SOHZ9sf+XC6nWwXjKRRHC/2NLgOYXyEyGCVvdk5ZFkAeDBiGFwYXFKRHY9Zz5LAEohk3F7kOpiNtjaFiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-93eaaa7435bso372375639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761069303; x=1761674103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5++vOccw1NiBO7NoWhAPT3F8+dn0lZGqCwukjfC6YQQ=;
        b=spIaiE8hvIZwNdTRNxzOSFxnXtA0aJW/SCB0o9oU4VjBBTICT1yeGcCLAROxAc0p4x
         EFR6mAI50FlGZYpWGNfOVQNxLDybWGlcgd3W3xXCuctOVQ6sdEevnbbwou9Hq0FsSNxN
         /cTros9s1VsUnr2HjuKHSqakYsnESGMZbyHZNcQLaOjWAqrnzA7KAqNkjB+hUw3EJui2
         QPVbURD5OpUC3apnbcy7hXlU93F1T9TVzIkSZI+lmxI4mMBXW0w1w5MyIj2qcLTPvmh9
         DKTzuSmue9LyrB65O4KAelbqVedOlvjTHeOv34K2VNkj+Pjp8VWOcZkiHaLfg6HAa+DO
         p2Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWBQ9eCyvsWYI/3jriB4FpQLLz7IoI2cTNpIzHCWVORiTefB0ITpIecpFvP8KY87bApuAfc+47bs7AGXGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnBsWhy3TCkR9Z7DoYiXCmlqNPXi9tqUlhuE+LC3klzn2QOPq
	6LrCt45J71wiuettVQVuU0o4B4mhQUfEKhqTBz7tTG6K8QGaYJCwZ9muCNH+thSOM+hDOnIIBud
	V+VMZfkfVtfexRRysUzzSsvBQIpIwepPGR3iocff2sZO3bggC14P2dXxNYtM=
X-Google-Smtp-Source: AGHT+IF7E20MKmPjKNUa6/gqvP9W5QSxcxmsJU5rDYnJTj+juhx3ulot9ni57lsjLUquPgv9Cs4rR+1o+Qa1sl791lnDJPQpuF0q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1514:b0:940:e0bc:c4a6 with SMTP id
 ca18e2360f4ac-940e0bcc51emr817677839f.1.1761069303510; Tue, 21 Oct 2025
 10:55:03 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:55:03 -0700
In-Reply-To: <aPe0RRti8OSpeCEL@chandna.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f7c8f7.050a0220.346f24.0023.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in bpf_bprintf_prepare (3)
From: syzbot <syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com>
To: chandna.sahil@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com
Tested-by: syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.com

Tested on:

commit:         1c64efcb Merge tag 'rust-rustfmt' of git://git.kernel...
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=10d003e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=b0cff308140f79a9c4cb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f15492580000

Note: testing is done by a robot and is best-effort only.

