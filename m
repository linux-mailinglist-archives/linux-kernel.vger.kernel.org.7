Return-Path: <linux-kernel+bounces-897886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7D0C53E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 133CD344371
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E442634A76A;
	Wed, 12 Nov 2025 18:16:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11232347FCA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971365; cv=none; b=eZ/WX7wcMWINxRJ/pP/PAwoV3EMKmgB9EzvLPRlwtboGt2yDHp51Vb9Zs70j5YUB5xet/AimjeuoEVdz8V4tfzSXJbPJE7XU0fNDuR6GSNAex2cZRs1vAAm77RlsP8ShE5+/0SE8T+wwEm/82AeDA7SPJ/vhsxfJ2kd0IQNdE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971365; c=relaxed/simple;
	bh=3WTtf+KQd3gI2bbvCbo/K8XQCalCRFJTX4TLjhq8LH4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VxhTBSHAhCBKXLv/8mflC+KwcSq9xo85f+1yo3MOUKury1SwZerGEuDyBXc3upHyv9nYMjHkyoxfPfilah6O1gIrA6e0VgRCnj4rNz5neQYg0OWOt3gcsWri7Td3CsM87rO2p+pTb1TIxWy9LRotrS45rPiARLQhETQ++DTh7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433770ba913so12165655ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971363; x=1763576163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MN3d6zV9Jgqc5ycADDUsSg8KFdeAu+LKkALlMOVpPoc=;
        b=O2Nu+OmJkBkOKxhwU1pLQ6M5ssWyDWqSiKserjVlS+OZwszvBc18TZANX72w6ZHlVt
         kANbtw7+tTEbH5VqQeeDKUPYALPRSF+enY90aCnja0A4vp8LONh+eItSI8Eo4Ex/v1+l
         gp9u6VTNJ7MnApzF33ZCYoTk2M4hbqFNo3gH4sdrtK1TUl58wFEh48jdA+WHdW0Wfyio
         yE+4R3znkjMH+14Yi81SAH0cokz08KQnPBfZKThZzN/nS0DdQ+5pU3iQlN2qXRIurKpC
         AD6sQ1g5SF9RiyxKVeft8QeEkO3aLgWM8jwrdbmi393mfPGeLt8UMypuURnSwDt4Yr0L
         wN5w==
X-Gm-Message-State: AOJu0YzcLggsOricUr/ujAZ12qybYDyBUF2TwMBujg0GO/exMpwmrAnO
	Alu91H7tsd/jfQTwsnPelLFD1bOYGfLSUwyK1l6DoOBBQaLaZY2R9kFutTrWS8AKw3yNPRdUCZW
	swnTMTY8AUYaY6VXeb918KR9InadHdPWK94Og2Zmvno6i9YUpsFIufAWydoQ=
X-Google-Smtp-Source: AGHT+IGclRo9s4+U7CiwnJgbnrPVvUOcFYb42GcV3Qq9kOWGDhAeo9ChPSVB4isad6PzM8sIB3pxYzvpvJKs9S2SbKjC5UtnmEL/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3093:b0:433:7641:5cda with SMTP id
 e9e14a558f8ab-43473d52c98mr56974875ab.9.1762971363116; Wed, 12 Nov 2025
 10:16:03 -0800 (PST)
Date: Wed, 12 Nov 2025 10:16:03 -0800
In-Reply-To: <CAMz+-CMWQU1XQeyqT33fX1tiyiJnG=tk2kTn3e5-wuWp0TR4aQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6914cee3.a70a0220.3124cb.000d.GAE@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in cfg80211_classify8021d
From: syzbot <syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	vnranganath.20@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com
Tested-by: syzbot+878ddc3962f792e9af59@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12156b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1eab7413851950f4
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11238212580000

Note: testing is done by a robot and is best-effort only.

