Return-Path: <linux-kernel+bounces-881478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6474AC2848A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78CD24E64BF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044428640B;
	Sat,  1 Nov 2025 18:10:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEA142E83
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762020606; cv=none; b=s1j3Jcgon37rQ0hj07XnmfdnDF1e4rD/8hSbjCTHG18MY1C3D3cKLBr1f1q8bpPJOOmmBKu1IaPrhIlfLEz4PzuNolAcWJWRs5E+gH9AcNoNNxSt9vm2OX4ToWoeVforJIniUalEC5fGqr9PehveCNaNFsaaU8Fwn1Kud0+CC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762020606; c=relaxed/simple;
	bh=BJa9BHN3oJCk+z4w3/Rz6HQIhHwnNgY2voCSn8sgSSQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZwZJX4SkPMPVth1qKyVfbelTxTh9YjVsGJjLzNhl/ATk1ZeUbCqL51Kp9J30r7f9Q0E4dIaQ7WrW1ngphQZNAgjtSfUcKAmjsE1hvFKuM6VEk17hTmVFo3LJa7zEq4Klrc3JrmKiGdznEAMNA6gh9OkOJy6l92jfkvgOnd6kl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9483f60a7adso41402339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 11:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762020604; x=1762625404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6zpPrXCC3eE1xa3IaeBT1zE8JH2xyLfOYm9gC2Wt44=;
        b=OlG3yLrTqacVxlAK4O1AH3HEcKdUlpN/CZDLZoezDBwiYdGXWqKgDMZO1QUi7ciikH
         FD6vBhJrv4dWU3N57VSZ78FMu9atFVCT6x+RW3zPk/JzczGfw6EcuOMxR44s17hq7gFB
         UgtXBcfESipfDXiMn0IOB22u/GnTs+HIgAUs/0mYB1kgVzN2wt95eUgNdOHd9lLGt6Fv
         Fp5J4y/9oepvaUoCa1mqCnOq45Z+KHjxzw4dw6lNkbLkk4blcmpMVaBDMWF867x9Wl0X
         OZ9xRi4IsuoZ6cx2iuoUxIanMYNJy3RHDKYc5O5ruHJyVqMmG7mql8174aeR0b97qQGI
         B46Q==
X-Gm-Message-State: AOJu0Ywr/cETrmI79HpWO2EFazeGsYDrN/li/SMv+rJ5H2dTv4PAFtaK
	L0FgKi1PVTW8Xji2KcYhR+hC9qvVsucX1dte7eC7O2ncRi0FCxeTJO7IjR1onzdYAqH74jD9a7m
	XhAzAUqgfD3oJmvwRlr4mUdbqOvtGsQHdHyogLv5+W045aYt4yY+9N4DYXBo=
X-Google-Smtp-Source: AGHT+IGfX9FP7/z43hyFUlBN9BuZE1qUKzSxMihl/Fc6f+AXEw0MK6QmqhS3ix23nhJ147cVd2zrtkbfyUyCpoEAluUYC8YIKCQw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e03:b0:433:23c3:f32a with SMTP id
 e9e14a558f8ab-43323c3f362mr21981205ab.27.1762020604222; Sat, 01 Nov 2025
 11:10:04 -0700 (PDT)
Date: Sat, 01 Nov 2025 11:10:04 -0700
In-Reply-To: <CAMz+-CPTNkvMjNYNfEs3vDz=cyJ7MNwciJCpu7sGUbHbd-Qz7Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69064cfc.050a0220.29fc44.0008.GAE@google.com>
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

commit:         ba36dd5e Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1231abcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1eab7413851950f4
dashboard link: https://syzkaller.appspot.com/bug?extid=878ddc3962f792e9af59
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16913f34580000

Note: testing is done by a robot and is best-effort only.

