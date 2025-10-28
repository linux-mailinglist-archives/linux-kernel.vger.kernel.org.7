Return-Path: <linux-kernel+bounces-874515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5601BC167BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D53E3BF33A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23934E741;
	Tue, 28 Oct 2025 18:27:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D5934DB68
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676027; cv=none; b=mACfsi3fL2ILL9hQvp+HbQaw/5sUalCP/JykQA2tT3Ka9wZxgjScRWsK+Lyzz/8vjz8L0AarMu1p89fJKS4oanG5uE+TojNLnCXwM5DmPD1OSl8ksiD4S5Wpvw3pcbXZ1dCmJhEMPrADOV3YPI9oVhRaouVnwE6Stwdh3egcTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676027; c=relaxed/simple;
	bh=fPSR9kfo+jVa1TvldM4cekLXCMxGrTXefxCYbUXFAwU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A8yO6zAnOBNbb38rWNqBZHywQEgWaUYx2cURNST1pOaLy+0GCsxxUpuzWxcOJ7Mg+At7uzaZjVR7L6IufO9YMpKU4sdRx31qqKMxwEvSGugbXTj8NArmgr1W+hzCFoTpcZPwhoXCnAWup1mY2xDMPIQRBjhPKbCew7L106U+aH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e67e2427so86085535ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761676022; x=1762280822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofECm+Bu89gIv/gnqyXiqTgVqMjgCEe+wA7ItGedI5E=;
        b=ek80Tnzsaxr9fH6XEzxOZX7+O4ebIqc4kPKul9qMuQ6WsvUyHDdJv4sPl6v2WH4LnO
         rrwVlybEmPnaCu1IWcTBSJj16MmD7rccKC8cn2do3WEAXiqrU0V1ZP2hx8tLxNFlG71m
         7hxburSmlNMHMtJwYrxOz2cpIksvZNhlctbV5nRYW3VTcbrfRWNR/BJpKlATsyTTjGPd
         eYIFLz9V256/hQkSlYFxDz5CZdSOvpUpQ89w3yM0qDiIIH44KN2Pua8Lac6p0elrqNeO
         YPEijUAJYRAKRbqfflT9kHggKzGXnIX9nJPT3+u/Mxxsgss/CSCaBx66HgaIGEZXtbnX
         OZZw==
X-Forwarded-Encrypted: i=1; AJvYcCXGqvE43xM8EclJUKdX4V4RLPXGaAYqK7QST/zaoAv0LVilM7NRobQ1qwh8GEbDh0cZNJwnCrGxwJodrFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFa/z+V68kizz37FmWJWt3COkadptXdjqEAeSY5tYxA4Hzdb4P
	yFWDpFleTb53kNICvC0cUFgjNtcRe8bIu6+TuG9Gnj1V1DaYJ6GbGU3v0+LZhonclj79q7QInHP
	UFshDzdKKZWHxp4pRgpiIfet5BfoQPhSYMpLo8GLPNTh6RBQnMC6lTqeMt6Q=
X-Google-Smtp-Source: AGHT+IFhI/dhI2DyBqUTaNvSzM5tCeG8yUFJ7VSLPc8foeq2pxHkNMRfUGLDioR7AE6MGqycVkfW17ad9RMPuYtdLmoL2UZbbA9k
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a07:b0:430:b27a:7702 with SMTP id
 e9e14a558f8ab-432f8f80a8dmr2854475ab.3.1761676022639; Tue, 28 Oct 2025
 11:27:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:27:02 -0700
In-Reply-To: <20251028181930.boW79%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010af6.050a0220.3344a1.03d5.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13984704580000


