Return-Path: <linux-kernel+bounces-892815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 231EEC45E17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E989F1890A25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642C30170B;
	Mon, 10 Nov 2025 10:19:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B62FE57B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769944; cv=none; b=YwsEOAa85s4eMn6ToI41oxJwClYLweptKyjvPgKE8AyoVqel4gWwCpJio8F158evJfCjpsVco6liR7Ni8zqrKO7BrLqoZYUEM3pIPhz0jPp0H0W7pmbeeM7A6O/VaF29kaVAKQuadSGuSPwT38kxWuqf3dIonh4EnDZ7Xb+2l+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769944; c=relaxed/simple;
	bh=4yWEq9HWs86abJ3YqI2a7YVaahD7ooqdytaBgp8RyS0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VT0VfreO8CQcHaexeRHXe/+xBAPZ077VhNjYcKzk/UgoQyPuSgwU0xP/tbE/XyidotGXX08XTc8csIakYyknNb40j/OgFSRigdrm28+1rEN6h1/jM15OfcBSiQ9MY9y/EmB6ZJZ7k9VIl8eJLBIUFrviBGdoaOfdBoS8XTwA4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433312ee468so28885235ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769942; x=1763374742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J1/jTKkgAWIytAoytJqSl2HVXZgX9pBTBqhvepkuuY=;
        b=o5vl16n3fwbuwvzwsfiBhrn77PLzFU2XHDjYKcx8n3MyX/Oh1lUhrkA1EtTVF2ZW5z
         oIfTQ+fQYs23hcAb8A6/wEgSqXC3/2Rc30ZRjo+8QjqwlgXuGKLNSDsO/S9pbtm6IW7p
         YZfPT/ABSUa5LI/LcsOcyibDOzc2B0yDWFmhm8vMLceBNohzLZZgyI1t4TIs5CiHggG9
         DbzvFWZ80MsIyRgZP+tPu5FA4Ql1fqXAK5GUkumyt86MYlCe0ohRyNFZ4Db98cBoBQjf
         /HwhSSckM1Fgn8VgVRCFKJidytzu2lv/61raWlG0pSEfosSzYq2YSi5u2sy54m+Fdz3j
         C9yQ==
X-Gm-Message-State: AOJu0YxSbv4jx1z9UWKi37ru6i4vAO/1Yv0rqzs+XmUDNnbFZmMGMlmN
	0GC/CkQ4UwkCa3mUpT93TjYYU5ZTtE+jITngwvZ7lj+yoiigzZQhnUev0wlGMgN5uWPLC+/oOB4
	LwyfZPL4HPxTxYbMh4rLWQjWiAVqhtz2ylxuR5sxbPQ+67zdW+LxmTWm/z/s=
X-Google-Smtp-Source: AGHT+IEA7tea2kDzjYtGeoTfSf5jUAut16HKOLrghVGEqBsMlqjIArGl8Mppzr2QnlhOnLZGqv4rXf43RHyKAbRm22nHPf8q7wZA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3110:b0:433:2400:2eef with SMTP id
 e9e14a558f8ab-43367e548admr124368345ab.13.1762769942260; Mon, 10 Nov 2025
 02:19:02 -0800 (PST)
Date: Mon, 10 Nov 2025 02:19:02 -0800
In-Reply-To: <20251110125137-e6946c988e9f22f6d30a5fea-pchelkin@ispras>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911bc16.a70a0220.22f260.00e0.GAE@google.com>
Subject: Re: [syzbot] [usb?] [media?] KASAN: use-after-free Read in
 em28xx_close_extension (2)
From: syzbot <syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pchelkin@ispras.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com
Tested-by: syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com

Tested on:

commit:         e9a6fb0b Linux 6.18-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1600b412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cec18221b2e23baa
dashboard link: https://syzkaller.appspot.com/bug?extid=a11c46f37ee083a73deb
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cc1a92580000

Note: testing is done by a robot and is best-effort only.

