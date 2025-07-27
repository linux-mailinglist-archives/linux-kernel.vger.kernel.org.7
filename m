Return-Path: <linux-kernel+bounces-746976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E84B5B12DC5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 06:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB5F7AE1B5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C4A199931;
	Sun, 27 Jul 2025 04:48:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE6B18024
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 04:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753591685; cv=none; b=TStPae8f5NthEkSzY+WO0razF4RmMEHUgO7KT/2Z/5UgfQq7POVC0TFWPeMreQDvfddFoof5iiVud/hkerX86C+Gn+83TeGz5OCsD2dr0YMo7VAHvahqaeQ606R32wPhV42wkfauhlZgPEcG1XcVBtiJhbB0UHlxc+e/Bg5NcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753591685; c=relaxed/simple;
	bh=GXK2aiV7h5ph47g3o2iK4WHH4kTgFpQ4IoF+qu+FNZM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YoOdVGThlCYlnCpq+OPLAIIM/tQe3dmj+mIJAIJUNMwpidnZP41tA01qsjq2kj5pcD/g7sscQgc/WlFDA9wL2dCnL8DCOkpvjMEjXjmFkfl2ZAKHy12c2yl2q0b2owx5n3Efjvfr1Wgpav56IZBaqb2EzmRitwYFcHKtLbO2fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c73351935so312424739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 21:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753591683; x=1754196483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUaJkbVp8QnJtF3KCGk8Q6sX8TKkAfKuJ/XOuTwApdY=;
        b=RxK61f2LfQupUU2usBtcEJbdQDLSzodrOqz8UwIhogYVP/LPA1ZJkAxLp4BXV3n/gh
         KyTdNEAMgLBZ0viAbvo5V1S1NRL7Zfzcjahqc9Is4UxFDN57rc/hHNNq5T2MSWHt59yC
         fn8/B0G690JgOJe+2WLwU56RoHV+M4igbEtblLjQUz4FaEjQLMJpI5Jrr00xgt7iWWg4
         8mq0lOIdRxG5bKj0IBxovohIwYFG+or4h0byLmvd2yyds2VHAaAq7y2PzHj8CHwD3caS
         aCrBMAYn6Oi7eyJK7mmjQ/VE3hwgroziIwNuAVzcfSLjJb1QIEWBH6oL11fSMrdN5Ei1
         FFIg==
X-Forwarded-Encrypted: i=1; AJvYcCXXY58hES/fnbZTLuM/uBfYhHf/MQiu8ogKhQnZdHOsmwMhfTjuSR2eHLFaX4FPTb/S9oBvdJAfPq5WQJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEp6yl26N2MN1rjDzNa7LifDmSghA1yWf5+Jl2e1CHD6BUojSX
	S5STMuh3cFhHw8Jd5owY+yljUxXm+Gqfuh1qsPVjzmWHqDTgzeOLjRCq2pEMZ3oa9HWNCQUrl5s
	PirgzWgMwNJNcs+PrVPGfAD//VVWPYY5nUYyghpiZbNurKrCoZWoAM9h6K4E=
X-Google-Smtp-Source: AGHT+IEHHv0e8NHFqeTZnxaK19VWU/stkhYiS2g+wxMHJdEHiw2q1BDc3wYbSCifzRZr7mSucc1IwHxcx6WKqdbmMie+dEaR1bRM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:3e3:b4ff:15e3 with SMTP id
 e9e14a558f8ab-3e3c4619005mr111085735ab.4.1753591682766; Sat, 26 Jul 2025
 21:48:02 -0700 (PDT)
Date: Sat, 26 Jul 2025 21:48:02 -0700
In-Reply-To: <20250727035928.3238-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6885af82.a00a0220.b12ec.0045.GAE@google.com>
Subject: Re: [syzbot] [input?] possible deadlock in input_ff_flush
From: syzbot <syzbot+ed7c6209f62eba1565aa@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ed7c6209f62eba1565aa@syzkaller.appspotmail.com
Tested-by: syzbot+ed7c6209f62eba1565aa@syzkaller.appspotmail.com

Tested on:

commit:         ec2df436 Merge tag 'spi-fix-v6.16-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1743e8a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f175a9275d2cdd7
dashboard link: https://syzkaller.appspot.com/bug?extid=ed7c6209f62eba1565aa
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14b5e8a2580000

Note: testing is done by a robot and is best-effort only.

