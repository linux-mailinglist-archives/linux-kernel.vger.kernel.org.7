Return-Path: <linux-kernel+bounces-852803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6596CBD9F34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4E9D346D81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DA825BEE5;
	Tue, 14 Oct 2025 14:18:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6C1EB9FA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451487; cv=none; b=KJhHd3mzAvO7pM7I6A2tEeWVIqt+1P5WttMCO6p5rJOy0BAkEnkojiAxow1nTZKb7tE0VY3wMwRzQlrL+ZGUMvpWwQEs6psm59mn+zy4sx9+O690/SzwO9MIKI6/fLD3AkYf+0lQGXibS3+qZVP93sKo7iWa3JXEFetgphJt0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451487; c=relaxed/simple;
	bh=jI5+RcK9kEFfoDiS7StDuMdQUD8Gs1gTQE5zlFriK6o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dIe7zZPvAES207F+D/uquAiW2psuI+ZFZbOTnj3V6Kj3BBLum/+89Q443uGD73QR9opUs9r45SS5eqoftTA9l/jdv0+VZ1JwAKjeN/snZRzyhn6Zt0VX6LFMuls0C9RywguoFogwpF9mjR8UbyxXUqnBprSXGEX0AX98XDQDahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-92108823369so2333615639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760451483; x=1761056283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykDAsAHgkUyjMMBy+uD28oUZ3+4v8mAXB6LioHx1H38=;
        b=fNAVo4A4gNyvzGa+xOEDHYNDFJo417+ksrfl8uPiA4Is2EtHuEgZzk9uYFOZefoCUZ
         B0rLeXriSlxeULfSkVYDY+YS3znmjCimLL+iU3MhxPgFXexZqkghoKvSgx6eyEPxfZE5
         lhlWGXutiifPdpzpZj9hQW4KZ3eZGC1WpEYO/eG6tyUuuvLU1vQwQwIH5tNeSjtu/hLN
         6nDrUaU+fraWqRBRGFndyALtYAWdZ6BahSq6NY719yR/c0/t1Drwc6WyDJIupe5Z7MPs
         y0bm5A8EmMGNuqGv4DqKo2en+MHGP0LU0TzYBDOUtzn7zA7i2kmpIFdeS4ANFeS8xcUC
         0trw==
X-Forwarded-Encrypted: i=1; AJvYcCXiEEkqAA1iYtu5KlcrzgSQJ6RmBOYy+oUWY0hmd0tOAffCG9R+oacuTFDlgFKrBIi4rVHeqc2doyxqE4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+imXZvtU5Cn7RUgyXdU7Xp296rouCXy6vw80aQCk+An0fOxHM
	5hMDhivXLtI0eSwYw34qqCDtTgdJPnu5uJsQfSo78n/gsPmns471tVp70hmE+vEq7koszoAo9m6
	JJ5dCOqwVsQn1vGRVCcTF4ITSvGihWLBor4Jhz+EWbDBupyIix5kftMwUQhc=
X-Google-Smtp-Source: AGHT+IHhZ0Q9FM2hVQYaLNV9FV6jCS9bGBTWU+Tytu359tFi4SC0lOoie4QjVk0VjEnbS/Js9vANkNPJL8OXpHKsT9K9oL6ER6lu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a62:b0:430:9f96:23c7 with SMTP id
 e9e14a558f8ab-4309f962567mr53147275ab.4.1760451483514; Tue, 14 Oct 2025
 07:18:03 -0700 (PDT)
Date: Tue, 14 Oct 2025 07:18:03 -0700
In-Reply-To: <542627898.1138059.1760449012976@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee5b9b.a00a0220.361615.0004.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rmdir
From: syzbot <syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Tested-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c7e52f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69c57c2b3206cecb
dashboard link: https://syzkaller.appspot.com/bug?extid=4e49728ec1cbaf3b91d2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145a5dcd980000

Note: testing is done by a robot and is best-effort only.

