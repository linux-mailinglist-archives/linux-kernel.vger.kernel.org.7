Return-Path: <linux-kernel+bounces-857981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01663BE8721
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE63C4F48C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CC332EC4;
	Fri, 17 Oct 2025 11:44:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A37332EA1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701445; cv=none; b=LChVDhO35lji6nhf75kiPjBTvUmRwY42EDv80vHDkFhtxDykRVGioH4/nmJKf644meryJmLAUd/+p8n1NFPavGuptZ6OJdRXsexQVbVgztyj7CTH6albgfOOWEAwJ8ppwOKAJnNgX6eOemPpSjslwk2ZBS0DJtt4R4SZaiHysqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701445; c=relaxed/simple;
	bh=VA14CuVaucwmHDdUOPES6Dzam19GPUrzkUs1CKPa+i0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u8sqzCdAF1Rqdq/f1o1EShJSGWDmJaA1VhBR7TqMI7lHDCD6bY07wYp6SyrE5tigTc/Ra3psGkFlGuh018R5EKyyDZH1VVV2OCWPYRM+iv46FbGiVBBFQBymdCc3Z2Ca3HWWOyB26TYq8p3u3QLkstz09hbrlytx1ROeK7DFalE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c523ce49so13982145ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701443; x=1761306243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCYrzaTr6InjFT2ivsLTaDpWElCGPJrtTxSNKYQX3N0=;
        b=JKT55kpUrtRK6UJ+Se5UI/I3XX2454O6G6mr/yPuv9s1s8re4MKHlzNjD7NvZiVFaq
         V7OQcNd/MBwaZHNSF762UTVdFeRjWaUGtpZ3So/vPflO7ASThAUTO+isAUz3OqrT0Sn+
         t7VcqjYB1qMqoijnATE6bTR7RYjQCIPg2zCLRjUvj8xvIBkHCsNzrRtjNAGNRWljfzCq
         3mfKG1afN9moregY2NaGc1evaS9rWWpYpkyZW+wlmojIwQFld4Nj7jVgz7G5t0+EeJJH
         DJpP9KJ79UnXbsv1IaEXsfk95X+xchC8fraGMXJ+pLgDF0trHdcaSFUlL0NvaOWJw8Vw
         rhvg==
X-Forwarded-Encrypted: i=1; AJvYcCVnrHuPWmPMju5h82Y+lq13nxr9h4HqjwfiGC2e0mWOW5oJDZNzKWCrtelpxfzhgB3EVQP0MJtzM74DFl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVEeyu1tJR0JYYL/6uKJgxzt035GGYlvAzVodcvcwt/5ZXEOUl
	/0cM8h3XV6xPOTKrGEUYrG1akoiihk5B/bm0mi8sXof6toeb4YOWyK7GCd1CTO2GK1jfjvGQqgk
	C3jMIvLO25dAQfX3b56IrsWI3SAItjWdEI6Mxv46TMQ9S+MgKs5lpmHKcScE=
X-Google-Smtp-Source: AGHT+IGs5iNuIY5JP2lJLX1ZGKji/y/z9c6cTUlVLgXH8ChZyl8GJ7aUQZWgY9ugydkIuZ5yN56STnwNIB/57GWyxXgdCC5ehzCT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e03:b0:42d:84ec:b5da with SMTP id
 e9e14a558f8ab-430c5226e7fmr56388885ab.10.1760701443199; Fri, 17 Oct 2025
 04:44:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 04:44:03 -0700
In-Reply-To: <20251017162359.1217053-1-junjie.cao@intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f22c03.050a0220.91a22.041e.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: global-out-of-bounds Read in bit_putcs (3)
From: syzbot <syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com>
To: junjie.cao@intel.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com

Tested on:

commit:         0242b25b fbdev: bitblit: bound-check glyph index in bi..
git tree:       https://github.com/Junjie650/linux.git fix/fbdev-bit_putcs-gobounds-v2
console output: https://syzkaller.appspot.com/x/log.txt?x=17787dcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce567f861793202d
dashboard link: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

