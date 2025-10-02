Return-Path: <linux-kernel+bounces-839685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33496BB226E
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9987F17A2A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBFC42AA9;
	Thu,  2 Oct 2025 00:36:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAAF3BB44
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759365364; cv=none; b=dShnABv6HqKzHb8SxV+lLdXXhx6XFj2qF8FM9o+Ny+BcemYyBGsagaX+UnoT+m5lBpyvCiHHDA8Br7UxLSk8Noh3DhQuxdyQfIPW2RtXPhs5FmjemQtyTCtRppvYLrR28ktFHLa6tj1kNjdFHtyS7TjPkVnct7j6aX5L/gkbTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759365364; c=relaxed/simple;
	bh=bwpYwQaWtgYV/4EIa9s7E3W0KQxFM5fsNFsckMwQ0pk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=axQ/9A87LrrJVBr6rBG9XcEGTqJ4lMh5wrtO59rV1Zr4+kSg4kPHAUlGRhNvi6ZK0hENlWYSKZIfu/mtt6Z5D4oPVpDI+BEd8WNZvLDN19UBuKrXdet3xjEFVQZOWqMBa6flJw9xAkA6d7MR18rOIukW2Moc8rloO7VSbkfA2ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42af09092b9so13820875ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 17:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759365362; x=1759970162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHjq+mkQyvQNovkB/35GuHldARZ4D1Z8sn8JCi337hA=;
        b=UenkRfDaNYCEHt1OGpC2nklt+vFPry8ZAWwLf1hWnOKW6YwB284i0iyW8Cf+kZYsme
         o6UvupKLTJpCfS73z648anxC+UkFeJjz8IMqYULQucZkAMwqqRMysEpqqBVecAZYqva6
         6owILUj9FmSKPS2JAxlmvjF7gLAaSguZt/BwAN05A1gnEz85yiIvmT1s2gYvu2/Tz4CB
         2z1CWi+HTjr5Q+KM1P9DN4L0wvnao7eTz7m878AfbmYoebMG020oRVQDn8UR2oBCGmwn
         cBqNqRf7kRPowMh5SNgXCypWhSE2KjESXZ0eXfDPgxSPknrMen5r49Rc9rLJrIOXGAnX
         BC7g==
X-Forwarded-Encrypted: i=1; AJvYcCVb9TbUsjZ6hPeANNIgmHqCLJJ9VgHw6IxsyDAbd/1nCKN5H9ad/jy/depcX+mknr2lRSS2Ku199qZM9/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZVselcxE8tNkILaNRo4qug3EhLRyel8gOnE/DeGXAA1FTnao
	9Ui3DP50gQ0u/mN67BSHVDQGPGtBQYAz8rhVoO2azkhZQldv4mFI8qqpczcJjfhwNKDGzx5EqgH
	OfaCTtrbISU7dODiFNgFqcFvZvoqTS8it4968/E1lWbswYXHK68ejHciFlyw=
X-Google-Smtp-Source: AGHT+IHr0/UyySINkDzvXpwmevkcUkSEy9O2KIxlQeVRtgQ+eu23a2o1R3xWxV/bl8cEXYFF6e/j228AP+4aMgSZrUAeR9zoMqwP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:424:a3e:d79 with SMTP id
 e9e14a558f8ab-42d8160eb1emr67401455ab.21.1759365362471; Wed, 01 Oct 2025
 17:36:02 -0700 (PDT)
Date: Wed, 01 Oct 2025 17:36:02 -0700
In-Reply-To: <20251001235909.7921-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ddc8f2.a00a0220.102ee.006f.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
From: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Tested-by: syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com

Tested on:

commit:         080ffb4b Merge tag 'i3c/for-6.18' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12dd46e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a792dde4ff127ac
dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1696b858580000

Note: testing is done by a robot and is best-effort only.

