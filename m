Return-Path: <linux-kernel+bounces-747282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874D4B131CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 22:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF006169913
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5002367B5;
	Sun, 27 Jul 2025 20:32:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AE1C84D0
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 20:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753648325; cv=none; b=A58Yy/zIE78TcbQ/7/MNkCFT1oExuoZyX8ecdiZyDsIMiVypyeEKfpbsRHDrHERxJngrKPQIv9yePbsYJIq/akA6F9XVl3sacSlQduhYzFJR0GUTcKAvUygipB0gYZF6uhkp0g7GWVGet4xqX9tQnLMcAKUfEw/KDDSJlqqGpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753648325; c=relaxed/simple;
	bh=qKAXajC08QtdZO+u88RUEpQFoL2vBrwjC67UWh4RuxU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bRRfOCu7naggodLQoDudGYUKAMoguaasEJOIkKvzL+vwPDu/6tKy6iYcBy0kRHbS+xZgEJpk61h2xpUNFNVWfQNaBphtlnUBaQAE7SexYem8F01UzSlM50cy59QxTYpeQZ4u1T3E10265CZ+DckzhgFljv81VcVYbFOv3szcwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddba1b53e8so43263555ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 13:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753648323; x=1754253123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVZNm5iHyf+ldpfRzaDP+2CJP6KflRVaMuSTT3zfTzI=;
        b=Lh/p2dXLjQVv7JCmPHhiz6AP7yrN6NZqfDpNXr/KHRSg2fU57HlSEXJkwE9rFoWvvr
         KxvDgDTY9XQZUM/5MKaAybv8rgwlJvBWt1GNh/T0lExjPu55nYK3aqBSMesy2sVz+LC0
         WX1KB0wPyQLGuvKu7BnMjCGIKfWOVnlkcGrAYI0E/Z2SYr6WozA3dkGfDJpybfg4+q3V
         zRCwwuB+uJ0G0XmevgLGJ2+aTQ4sTqSXg9bZelNdi2ojHjkcBMvyUGELDdESBYdcinqN
         NUxT8TqNnOy1dQvt4SB7i+4KV7g5OvlXwXFj/bGHGPutp9tZWnlH4rzaSLTAMTRtzTXR
         1k2g==
X-Forwarded-Encrypted: i=1; AJvYcCX0D84hjLpPJWtqw43oBbo5TSeYG1DSu426mO3rtmUceZuBM4ZH4/qVRno7i1GNn6QBt8WYzrFxbzbdGEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb8eqTONFxf3JCPUc22jjQshtXJ6yzusBRn8xHOXXyycAzzrN9
	mn39amTNya+fSchA01pobh+Z7+f20UV2MRbUIttk48LxGv7ij+11tAaMyOZXTgP8IcwhIjbE5Bk
	7H7/pUzL93LaJhIIjcZKTeMMO9+uTbjmViyvywoq+/fZYqE45VX4VG3dv8sc=
X-Google-Smtp-Source: AGHT+IGqs2mNZZdeseuYEnh5d+XiBsrOzuoLvpQSrtSyw5bf4JZh36TKNJKETVMUGSS7WfXHh4onGbnoawTR6SHO+Wlv0ECsHv+B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3385:b0:3dd:d995:30ec with SMTP id
 e9e14a558f8ab-3e3c52bc2e2mr191014375ab.12.1753648322859; Sun, 27 Jul 2025
 13:32:02 -0700 (PDT)
Date: Sun, 27 Jul 2025 13:32:02 -0700
In-Reply-To: <878qk9csvy.fsf@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68868cc2.a00a0220.b12ec.006a.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in ah6_output
From: syzbot <syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com>
To: charmitro@posteo.net, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
Tested-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com

Tested on:

commit:         d4017cef net: ipv6: fix buffer overflow in AH output
git tree:       https://github.com/charmitro/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1560a782580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d80adbc1e1d0bde4
dashboard link: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

