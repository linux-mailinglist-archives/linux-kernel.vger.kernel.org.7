Return-Path: <linux-kernel+bounces-744936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECEB112C2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE61AC3119
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25B21FF42;
	Thu, 24 Jul 2025 21:05:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10017332C
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391104; cv=none; b=iRx+u9tOajnNQswsovCi0YcmTNsCYnQZJ6wGbgHD5vXOsnJlLNdjJocQF8PF2hWTV0T158QlAtwurDIHSAncPZI43ZH0AM2nxZBsm/OxvgjIbeO4JY+2AcDiDI342XFkmCLAJeEz0ErM7HLNot4Pps+gnV8jeIqFTGMZKldLsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391104; c=relaxed/simple;
	bh=AnZr1XZiDua1jbroBKBixVrU0BxszhyLtiWOdXL4BaA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k4Hkd3Jq1T4X1GGMW1Kzh/BoCj2NXirphPTKbJ0jKMT3yxBN3tMT1wLg4nBbyeNpZqFjT0mvvTIt43y8+zL8JXQ5dmveXBYx1gwGVDGtPNkHUziNzwbznP2UwFJqN1mzQtnce5DN68dM1pYOJSVMZbTTn+sutc6L3ODNCq1p8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c707bfeb6so140131139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753391102; x=1753995902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/N7CFgUEKqLPSSY2Fj8XKc/Pc0GgPMTtICyl0IsWQ8=;
        b=svBp+PE9XHktCL6/wA1vZCS3+VejgaRRbkFKaWdeVgCgRlIpQ8CDg6cDPiq7I4X/8Q
         xCSxovUuEPNGk3vvNizMS7KXi/syndiyaiq6q2v5ONVNS7XIcXwTcZQbNQ9Tanz6HlO/
         YOUllcjrJVL9aeYfaYN2O4uUNHu/PxDo3B2it/NrKCd7WPrMW0Rerhe4/IcUoqd0kZMU
         s13mhrLsEw1ltAM5pAv/VEaMsbvVkEAej6L3XYnwyOvi81x9yejRep94c32FkwBft8ja
         V0wSQJYFChM35uaeN9px+Ad2vOwCQeoUfG5eEAOwlRqGAh8bb8mjmHDnxw34twsK8XUx
         ncHg==
X-Forwarded-Encrypted: i=1; AJvYcCXfPcueVDE7ekDEBrC70lzv3iy95QYM5OcpvaTXzWg4VrZBHkekpyK2amCwI/QddWUzaXPNme0MTh5UJeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcmvIhM2qvohp6ATUeWUl5hOAMtXPiH6SA1buTYlAPrrjVKug
	jtF06bUDEQ0TR3LkRdNp7LiFpjRj9fxc/cyKI6Sr0x54MddIfbFUdUTFx7XA2I631toMzVpkoVW
	lu3D8dd/l1rKuSjDXBIIUtrxj5DnZVKXRSxHLyozj9TOTzsRx2U8pot4d6/U=
X-Google-Smtp-Source: AGHT+IGPHe3OdK44PO89XrU9pittenHLbHK4EaqRzRZKFZ44xqmNw+qVkNgQBzukbHwI/xystmHGcn931oKi7Ufrb1zkbzkL1HHE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c0a:b0:87c:3a02:20cf with SMTP id
 ca18e2360f4ac-87c64f4773bmr1614431139f.1.1753391102435; Thu, 24 Jul 2025
 14:05:02 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:05:02 -0700
In-Reply-To: <20250724202744.101807-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68829ffe.a00a0220.2f88df.0032.GAE@google.com>
Subject: Re: [syzbot] [comedi?] KMSAN: kernel-infoleak in do_insn_ioctl
From: syzbot <syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Tested-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com

Tested on:

commit:         dd9c1732 Merge tag 'sound-6.16' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14cc10a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7753c32e11ff6a95
dashboard link: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a410a2580000

Note: testing is done by a robot and is best-effort only.

