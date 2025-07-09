Return-Path: <linux-kernel+bounces-724340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C9AFF190
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C04D27AECC1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823623E35B;
	Wed,  9 Jul 2025 19:14:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904D23D2AF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088444; cv=none; b=XVIRFiaAVq3+cJ4byf9Tysh7ydJeTqDalwWrpP1Yvy4UMDNuXvXsJX46BNmPghdu1NyUZEUcXOAIYEZIaMnR2+Rc5I2UaiqcL2jGtwalFfZxC1Ztfy8WiurR38vzR6/SwOkgjtcnIl5JCzYT9yLdFfyKGKEvLY/JmtqlBv3VWjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088444; c=relaxed/simple;
	bh=IBZvWe5v0+tZuavBkOb6LIgX+7A3E9DdlfIm8D9KD3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CbGb9GbC7M1w7sWXD6Tk7x87sVpmC82uoXR05kDz64fQdP3iHHwdhezHPBK7VGhteLr+Hp18o/Y1isqxHTerdMPwEI9gxtIe0CzjOyyYBI0MesNyL9vZB/odl7xmgSsMEBDUzAHxsqVnSDVO0QTL9/WCLBunoSBzrX1wNnLUktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-879489ddf11so43132639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088442; x=1752693242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoW6l+OZAhzewDHHcv3t4YbryZC+MbFr7eVEWAulksk=;
        b=wnOIKwIiIYMDO/WKb9C7xjK0QJ38EivR0+x5yYNn7TogLfmorxGAZsj66ZikhhcAwJ
         Hk5ocs+ctSTNv8UdhSuHB1xbQXQwM0awMYkkhDd/kxi1VMOMfUoLyC8DWHysn7eRXZ+4
         mqle4Y5eGZyyPjzq+fUHUuFy2GdzpFqe1WefYRpj2zq/eTZYyb/tvhnnC8E71Vc6Bgvf
         +hSQSxDNtblD8YeMrgysH64ItpTkqKBv7pbRTS+SYUYGMeEWc1KG4jr1ugnQmeelKgzg
         sPX6GlitvEE16KkjQ7onr815RNPr4SwTFm4J8wpNvTXvNRMfedZ63jE5mmlxLtyoi5Sv
         A9Hg==
X-Forwarded-Encrypted: i=1; AJvYcCWOoURc41PdQ7TgIRTTQA4GgHUoksi3YLCJLB9fLXWAsX+xdktf9vDIYBiy5MNVgJ82cZiudzcZCZ1Go9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pu/27ajePFI9rHRbJZa/OKMUtTInw0YhpyP/RDwWqunQzIwD
	0HD9GfKeEQgnJbmonZt335pWhWuVP0F8Ne+WHKt0aZRCci0+7DDaEToaoGurgeRkS7khS8Mq8G2
	9OCUImo71CvETKRMCDr+iFxniHi6oHSG4HpK2pDophYvt7Qlt6ErC57vQbf8=
X-Google-Smtp-Source: AGHT+IGODqUD3rUCTEtLxEtHtv1wy8fB573HKB260TORWsv5EJTr3Y+0fE5994dBX/VFGdl/ou74ecL0iZYX+PJubO8i53/5q1WW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3419:b0:869:d4de:f7 with SMTP id
 ca18e2360f4ac-8795b17fd88mr451616339f.12.1752088442602; Wed, 09 Jul 2025
 12:14:02 -0700 (PDT)
Date: Wed, 09 Jul 2025 12:14:02 -0700
In-Reply-To: <0e14b12f-5568-4b5d-857d-2d00def63b51@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686ebf7a.050a0220.385921.001d.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in dtReadFirst
From: syzbot <syzbot+2de68371153f0da8af8c@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2de68371153f0da8af8c@syzkaller.appspotmail.com
Tested-by: syzbot+2de68371153f0da8af8c@syzkaller.appspotmail.com

Tested on:

commit:         73392339 Merge tag 'pwm/for-6.16-rc6-fixes' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16eb1a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd2783a0a99d4ed0
dashboard link: https://syzkaller.appspot.com/bug?extid=2de68371153f0da8af8c
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=170c00f0580000

Note: testing is done by a robot and is best-effort only.

