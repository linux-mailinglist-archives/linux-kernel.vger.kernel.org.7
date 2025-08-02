Return-Path: <linux-kernel+bounces-754243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11628B190CB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59683AC0F6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10402749DA;
	Sat,  2 Aug 2025 23:28:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417515853B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754177286; cv=none; b=R4Nchw+GBJntzpRPfK9wTgSD65QobhQADlTn4d8kKH3W3nCAxN8XWzfMLpmxViVUQfuWHump2fOTPeLN8fwiYNwQBu9kqijmMqSqrOyhCUv2Tdyc9MggrqLXqIvLP4VO9oaok8N189heTpeMaMjTmxNaHVuauTK4Zo4mIrrEGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754177286; c=relaxed/simple;
	bh=FdyinRXZyLxJiWZztjOfUGGgawYXifvy038V3yslXHo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UbTI92rkqpavmdcUutFwAYjpQg8sPra5RoS+luSvED3tQRQdt3UZcMlZwlCJnUjnF4DZxw+/+c/JNFUkToPIqNOrR/1wL8El+Q62quv4fWRklSKDQxF1fHc934vPzoOHvdKkDAVlJO9NFLiDVdUPNs8/TCR/tu09rlqhVeKSQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e405c4c009so45923665ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 16:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754177283; x=1754782083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOLU46hT/abcVNxTEpj9bqCmJDoTxn3JaYV4Nk11Q0E=;
        b=SbcuQl6Br9V/VFgfEgQV/LK9fAh0z5DCfOysCZv7GcRwTnLe/Wq0xPovtSgmzktUHN
         rliX9VfPAVMe6pIThKZZJc/jVE4bFbM+Q89Uaki3fsomgp1hPDGP5oJNpPRGAS9AkoCF
         1q9rjfn5VBjCkMoxrGnFR0Unv6fYOHYOnkl1zCPGWeKwp1CrpmJW+HwLYn+luORXhbr8
         MKuOUmDKgtcx/aqCba2ptl31IDjU65bXNZ6pzDE4zCKuGABirD2HlwFUbbS4Ou2KCOgT
         52pxrpE41QQsbp35VgG/djPorQyqOEHVfqz2Vv66WXvXLZDGW5Kzl7wWLRUyt+TleNI3
         noZg==
X-Forwarded-Encrypted: i=1; AJvYcCUTYOsLhKHVol80UJrFgjePM/d6a6aJIfXc/X5aa65l2aL4yah7CLKGk1cYjgpJL9Ue8TJPRAyTShuTZNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vVjcv9miNehOlT4nsjJk63Gl/PUEfKM3G3Hpmf2g499YfiCx
	9cg+H87GeUVGQU7dHuzD/iWXp5LHaBe8PUQS8Dxva/jdJVvFFpf01RjdkdwEklaq0whFcSRT5NC
	JrUJdgmNJwWAtF2aNADFqx/ROTIlLo1nMxuwc663FI1FgAmEglzUUhqJiW7E=
X-Google-Smtp-Source: AGHT+IEu3s62Peomsx6pDDlcoraetlrSqIZu/u9BYpb26zzFCF1YR3C6bpF62zezjQv7rgxaJmMta5EDA4bF+DX649rhhwW0f+Se
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:32c1:b0:3e2:a749:252e with SMTP id
 e9e14a558f8ab-3e416109acdmr81849845ab.4.1754177283363; Sat, 02 Aug 2025
 16:28:03 -0700 (PDT)
Date: Sat, 02 Aug 2025 16:28:03 -0700
In-Reply-To: <20250802230940.3712-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e9f03.a70a0220.249f57.000c.GAE@google.com>
Subject: Re: [syzbot] [net?] WARNING in __linkwatch_sync_dev (2)
From: syzbot <syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
Tested-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com

Tested on:

commit:         186f3edf Merge tag 'pinctrl-v6.17-1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14043cf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aea62bbacd7d2de8
dashboard link: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17963834580000

Note: testing is done by a robot and is best-effort only.

