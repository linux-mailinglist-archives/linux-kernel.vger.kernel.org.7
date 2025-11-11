Return-Path: <linux-kernel+bounces-894666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66CC4B8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1971890503
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 05:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F712798F8;
	Tue, 11 Nov 2025 05:34:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4AC192B75
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839245; cv=none; b=HUE5PrSuanx8Wl1LV/YnUDfa4ZARvcUYT66yEtx8PtRdM4ej2FuFfLkANaX7VmKA5iaaMTPOEmQ/ojVycdFIuxvAbZOu2chKox09JMiy0wMKKHrRjB1JSls37Rvp3Po8wvirA4P4ztGNucX+0hP7Jfb+rPStUzWZNWst/WrrIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839245; c=relaxed/simple;
	bh=kcnJe/qxDrgkLVegeYQOZEBQu20xSmHc7joNFiQcpiA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fa43vDB4Ks3gq+3Qbf0Q9rW4z+CXSHiDMmeaZDa3XQJZG97QdnGM5mMxeISLmT9tooZFazfVBV6Mo7st7ZwP+FDF6wR65CAoAtp0/KbyEc1X0Zar0FPTQxSiD8YofWP0+WZxsGZQDhLDyyo+bOHlwN5Cg2F2ZBNhn403qOSahlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4330ead8432so40249835ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762839243; x=1763444043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nhRyTj2G047/3uBt6+yLJUxiKTuUMgLJjAez/5UPPoI=;
        b=gBbSmCJHxp2oYOiPk2J5I2u9fcnv8TiG2infyPItlbhWv1QXEXj1WYMhTCaPnRN+9Y
         qglPlE1tG/T9JnKuJ63sPDA7A2GZ55B/e2SLWTXDQo/fnowhOL+KLTLmhTqB+MEFIXEr
         yl/L3MMpDhVUhFaXgx7fzdZ6BuWZQKISvb/7HteT8Ceg23KeoxjfxSKiLxgwD6pJFvui
         E0LmfT3RGCtp/pvybJe94UJv6xpisxxkJVcUd9IHEB1sTksOgMgfgPiNEs7sQsbE1nok
         nfQzPOKaKhhFbDrXxSlp5Dogsu2orMEBjydFRTF40wfMjteXZCpWClrlxhBa8ORSBVZF
         p4/g==
X-Forwarded-Encrypted: i=1; AJvYcCW5ytR5zXJ5eR6z4caWzLHcPJ+qtrAafzIDO/5cJgq8Rd3tMqbac/nxKERd7xrLysN3Om9byyeIl7wIPts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5Dj8WApxdYZr+Yo0Ur+9CuP08rMoM64yuWQJaUxJVUJvvZ+2
	vpc3wh8rHr10JTx0J6ZUpUtW1gPwzq2/NXiFCtcYE45JzlScbdHQ5xBEH/i679fFsgeoyqdherZ
	3AXTaHMtV2bLIhwVGxR0m/fzi6yiq1PNpny9AmlsarNrOAEVhgp+OjaHxmow=
X-Google-Smtp-Source: AGHT+IHiEj5c2ECFyXN66aLi10qa5ATKo5xbVGhH81Erx5squCFt+WSaYdOt/mVmuqSlcgqYy4tWF9y66k6fdY/QSYnUj8y2KLCH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:318b:b0:431:d726:9efd with SMTP id
 e9e14a558f8ab-43367df03a9mr168409485ab.12.1762839243011; Mon, 10 Nov 2025
 21:34:03 -0800 (PST)
Date: Mon, 10 Nov 2025 21:34:02 -0800
In-Reply-To: <20251111042938.2015551-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6912caca.a70a0220.22f260.0128.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_listxattr
From: syzbot <syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com
Tested-by: syzbot+ab0ad25088673470d2d9@syzkaller.appspotmail.com

Tested on:

commit:         e424ed99 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac6c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=ab0ad25088673470d2d9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a1a7cd980000

Note: testing is done by a robot and is best-effort only.

