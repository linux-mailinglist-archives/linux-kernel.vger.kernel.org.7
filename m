Return-Path: <linux-kernel+bounces-825011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD83B8AB45
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF563A3458
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07253218D6;
	Fri, 19 Sep 2025 17:10:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE332129B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301806; cv=none; b=JbFt3Hn3tVOpQvklEEnDfY+t3uPRBEttAUdl9sIvECuwE4tlwq+f+Ix3PAf/j95NogsTfQMWGGEYbRwgCZaBeRHgximZVIVHSPuHQW89ZcnKI2fwj4u0Lk6E9xd33o/qeXy6Qgi/VSSyuTCKJK5Xjssojv8RGbsn4YVK7TKAIjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301806; c=relaxed/simple;
	bh=C+qzOHCIrbETtZN7+tSpoelBJO9dquwBax7WUhd5+sw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FKihPkUHgf0eQq4y3AyfAsmr4iD3Iay9TVZGj5gQhetSWIbsKSCCS7Vo2YyR83LQSFxC+2p4HOHxNf//w4Dw0FxsImlOGnNmOiIlpL2Gw2CAgivOL4XI5gWYNmLCg6mTFI5Li0jU6+e9kz7zaG5gGu5YThuONsNrgidW82RNBfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42408b5749aso47135065ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758301804; x=1758906604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCwmxXBP5j5JxsKkQuSIJx/M3c88GeLXM9q914Io0aQ=;
        b=dvYggDJkbOj+id871iuBhRFeVWQ9smagJ3uU1Mggb7zKniJYoVshqB3nZ0lLOe7qCg
         ekSRkFyeOXWHHV8Y+WF03Nx4MQSqOUDh7z3P89yBGbJf/ydFxIDluLO6a419rLrOl27B
         z8cwz/4h0Ss3JnvqFIAP5WNO4fnfbBAsDZR/MXkO/lTCInQGG3K7XB578CgSE9eP4Glj
         0y1swWjfPh2WR3RA/vx6rrdfQ7gEiMbfvWUf+/t49pHhw5J6niLEpOot6U4eUR1QNpTP
         o6aXqJMEjdBTdFkUmhzXhFhfcYa5Uin6xsB20+gohh4lHEECdkF4Z6iKhZwJ+yWrrmHi
         OQIA==
X-Forwarded-Encrypted: i=1; AJvYcCUj+vUgnWYC+rqkGRWcrtA/JKOovTI+CjYYJr8Ff8uVk5f9t/J9inn//z5YPUfRS89uI7LXS5nbgU0KHPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQscGhX7USxnmKWfQBzscQmNcVzVKnUzZyoSPtQKAyaASX7LV8
	Hima47oVZQ8YlSBCTJ3GDCEY+mP+6BaGHrMLjGF7YH6V9Je0P/vHm+BIOysKsW+BmpKCeg1SChz
	S16YEFQ4lo2/0ohuTopuzUVNZHxth4O50LwAyLsS5GiFe6j8SMDPuklfoPAU=
X-Google-Smtp-Source: AGHT+IE0QcP6OfRtVstXQFKvrUTXkJLW43DdUpKWGrEkRn30P7UEDviwhnboU81FTyq0rzQ9ZoHZCGa5PrDOd0ypU4mAn3X6M97N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:422:a9aa:7ff4 with SMTP id
 e9e14a558f8ab-4248177d49bmr57629205ab.11.1758301803716; Fri, 19 Sep 2025
 10:10:03 -0700 (PDT)
Date: Fri, 19 Sep 2025 10:10:03 -0700
In-Reply-To: <20250919152337.47803-1-hariconscious@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cd8e6b.a00a0220.37dadf.001c.GAE@google.com>
Subject: Re: [syzbot] [tipc?] KMSAN: uninit-value in tipc_rcv (2)
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: hariconscious@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com
Tested-by: syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com

Tested on:

commit:         e8442d5b Merge tag 'sound-6.17-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134fc712580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b093ccee5a9e08c
dashboard link: https://syzkaller.appspot.com/bug?extid=9a4fbb77c9d4aacd3388
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e79c7c580000

Note: testing is done by a robot and is best-effort only.

