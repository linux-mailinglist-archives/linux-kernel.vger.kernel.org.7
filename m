Return-Path: <linux-kernel+bounces-804597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136CBB47A46
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B443BC8E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248D5223DEC;
	Sun,  7 Sep 2025 09:56:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506992940D
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757238966; cv=none; b=AxNy83JJrgve6atn+7VOdtvHFRADuWZjRlkqviaEI+BsUs4nIuv6OPG1eNx6bTH4v0gEz1FFHNM+817j0r37nnXrtxxQMQCw7lPJUdE8fUOCJJcH0pyIeeB4to75ch7oO4zP0kIKW3fPMsfc26Hkgsmo1PhfRo+8FNuYT90G6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757238966; c=relaxed/simple;
	bh=+SPGQ2JglVISMz3OFkLXEkAOErz7UjnwcAn/P2bAG08=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iI2iVlzcX8/T7aO1CqwtWepCxpLPrjhBHTLmuAeKiVd9pXw32X97lB6azuCIY6nGvSVURrWKgLqgKSSPy0RDdnc/040hNKMt4hXLUYon+YkxZQbS8Qu+YIoheuV7+sMiUGHeLBrYJcu57XxsWkqVUkKjwEffiaw69beKjNhzls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8876894f35eso754331339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757238964; x=1757843764;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ3CuxLLMONJuEakd/kDhX9uUypLqLvB6mnnSZNpRYg=;
        b=Fhdg1T2Q04Yc4+6td4HCDdZawVnogJebNrnoclN7FRT5Hv4kyeNqvAQ4eJ/JxzFXNW
         1Or4QyewBZfsrF34wuslYO+3FWF3CS1hFtfJUA4qFGIQqx2AtabtYhSeJq/8KsPNCcVh
         2Rrc7/+uTtO6JIqvvZjrVq9kqAMUF45Q7yyp6tGSZInmVDJ0e7X95L1+4BQYQG6+Dvl+
         GH6fxJLqIqcxUv6IjIwg5PuwsQe6prgV1BKVjgauO4Xg4/ZycjLgcw7UjQ5BoQRhcLQ8
         aYahsW+gMT4N+cNmysep0sY3QpfBak0V1L9XrzHoJHoEvBDl/PdMF8MX+xAa7u+f9ldr
         MbRA==
X-Forwarded-Encrypted: i=1; AJvYcCWkG0Mp4lj9rz5C0QBTP6jUmMRqVEvoIdI7L626vKzCFIF/DI7VDlfHgSPnD5Jjj5k/w1yTjrx/XDYOEKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiHyfk4n8ji7k5hATcLZcNUU1/qvHO2qgtGqc9QnJAb70PEpk
	OAw0UwcUP0c1jS51EShtXMvI9ErY6Fmn2U8PXwZ2+GZl8+yf180LyVCoxEI+YyJl3+R9q1ztHMO
	ppr8zZ8weP839qKRsYGeV2cpH97ktxEUGK6cRi+edXRMtd7nAtaOS/xJxiWY=
X-Google-Smtp-Source: AGHT+IH37gshcLCbzlocS98RootjusIOSYgE+BMwWgtIk8q1YOrj9NqN7F/0t+dLk+5du1BoZIfideUn7EB9P6WrOjcO6txxEnY3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1602:b0:887:333d:4f0a with SMTP id
 ca18e2360f4ac-887776b6d3dmr654946439f.18.1757238964471; Sun, 07 Sep 2025
 02:56:04 -0700 (PDT)
Date: Sun, 07 Sep 2025 02:56:04 -0700
In-Reply-To: <20250907082649.263400-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bd56b4.a00a0220.eb3d.002c.GAE@google.com>
Subject: Re: [syzbot] [media?] BUG: corrupted list in az6007_i2c_xfer
From: syzbot <syzbot+0192952caa411a3be209@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com
Tested-by: syzbot+0192952caa411a3be209@syzkaller.appspotmail.com

Tested on:

commit:         b2369207 Merge tag 'rust-fixes-6.17-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158ab312580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bce5d4c1cf285a6c
dashboard link: https://syzkaller.appspot.com/bug?extid=0192952caa411a3be209
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12418562580000

Note: testing is done by a robot and is best-effort only.

