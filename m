Return-Path: <linux-kernel+bounces-834838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038DDBA59F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61787A598A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08996271457;
	Sat, 27 Sep 2025 06:30:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCB7271468
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758954604; cv=none; b=ner3RRbGD03T0ks0bNLsS2XQuc4JEUoguXzmK4V9WPWX+JJhHxByue/2KOOGOnBjUjq81aHWgvh0HuHJxehrwVok5Q0iRqTj2p2JIMoVUkDyOEqxw3/c9LEQIrYgeySR1YIRl9NXOfMh/zZEPmxMgY+xpjNrBv1mfg1aRGSm5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758954604; c=relaxed/simple;
	bh=vwqbGfviG16ZJa5U+GBvkxqR4+N75+AJf1A1CFI3aDc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SW9xJzf2mpStouEOKzJmxBsyBGelNiczIhTm37fOYFN9054Jwc2dPi9d3BRH+i2aQCXvOGwrSU20BONBOOk1eyvvARr0uh6tCqL95anOGiQqONp3F4uAb1KKBEXP/wi2XD9pjghit/o2GZfjE/APeKpULe80M7MKXHd5MPmLTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-429278a11f7so779025ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758954602; x=1759559402;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sB753CgxL+L7gfuoyWbB8s2sP3eOhSLkS+lu3M0m0rs=;
        b=HnHyJIMEzYR+ANc3Nd8QTTWIWUqA3bZNnCvzQZzP2kxdErnUgSt8ZGIPLrAYhT6JPz
         pwygzob+yjAW9sUVRZq9LrLoPMZK2vpFxqMDhhTsyz4sNqTOgaS0FI7X3EkhngE2vJL6
         Uy+rV39Xl8Ht4IUsP+CMMOSS3bCEbahhevZDpRC6Vx0KFzyRcrX3IGmj0zUjH3QnjPqe
         0jDJnL1AG7MZ63RZ6Pys//YVEOV9p7q/yI46dvJxri1zmI3wE6501Qph9HbYXQikDVEb
         ez0RaYtgjop0pONJlJ7/e819OoU702YFjzChx1G6nDhh9qg7RtFYg99oEA5XFqYiFZCS
         Vphw==
X-Gm-Message-State: AOJu0Yypj/OAWegC/X8f9dzZD+GLcrHo2pZNjkHlvvjQ9f/isK3J2cvJ
	DbsLXMD2hyxoUMIxpLW/EkL7pDxlrrbsDDfhcBYcaySbWhYSr715QzuZKqW2qshA3aX7ST54XUS
	k7fk+bHfHABBDg1KPuth5IxXofjTry5NB/XgaA5m3FgBldAXE/C6EOHgZQpU=
X-Google-Smtp-Source: AGHT+IE64rK2ub6OCcsW+636VEK9xuWSV/7gD+TobBprYBEZYAmxKDKbTIEa+T+1CeNELKe3jWbTEgvgRHR0k1zt4S1JX5fy0sws
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1807:b0:425:6e9c:9443 with SMTP id
 e9e14a558f8ab-425955084b3mr145350355ab.0.1758954602337; Fri, 26 Sep 2025
 23:30:02 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:30:02 -0700
In-Reply-To: <CABPJ0vgpY+hEG3oGEYiJuN9+zLDjFPZJtYNciKw1g33rDPmQzw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d7846a.a70a0220.10c4b.000b.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_strcasecmp
From: syzbot <syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rampxxxx@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com
Tested-by: syzbot+e126b819d8187b282d44@syzkaller.appspotmail.com

Tested on:

commit:         fec734e8 Merge tag 'riscv-for-linus-v6.17-rc8' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=169a02e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ba89aa9f9bd9ef
dashboard link: https://syzkaller.appspot.com/bug?extid=e126b819d8187b282d44
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f832e2580000

Note: testing is done by a robot and is best-effort only.

