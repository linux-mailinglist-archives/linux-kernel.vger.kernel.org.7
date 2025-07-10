Return-Path: <linux-kernel+bounces-725215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C80AFFC12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E8D4E2EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21A28C5CE;
	Thu, 10 Jul 2025 08:23:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569928C2D3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135785; cv=none; b=tMZHoeq54dpaouSVbdeqkp/cir+99VWev+ghssOpBxF9FePus5OSRm3b3tQAQ6kmGS8ukvxKCT4/7es1D76fqXfzu0HV6NkylZV/stgOc/1uQcl2+jdUpFxom5W+MCD1t2mt7qtfYlYDX6rvty0Ucmi1Xqsjr99V0Fwh6Rxnz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135785; c=relaxed/simple;
	bh=HTRdX9JXkzjdE4/G8zQBCJH3UljSDAiFGMNt1gA7MUM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PXISi0qd9o+Bn2NZPYT2Sn6i2hheswzaNftJyKQv28aETb8o3VY0JAOE5YUq+PWC5bd29apBe5/IZ1MSvnYxK0h8j7+h/2SZhXJMI8JhOQX9BFgnLVA44/hxoDIv09JDDznOh97GDoK19f0oWWBISVzBhaZjeLjl6CjkmUG40b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86cfff5669bso85311839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752135783; x=1752740583;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDTcowXLJsolFMOqnIwMSKD2MghWzo41D8JtLx5ckjo=;
        b=Ojydb813p1hrjFMiTmqhFkZ8Cqzd5LXWfFv2cffADeV1LG2fKwvly0xh1CCuyP11uh
         GwYDLsvXS1a5SQXanRysgfXTuhY3f4xGmuMrwPnjHW0lj6SZAFnK4JhZ6Y0cfXE32Vcb
         fYDt3DSK7Hi7EDQaB6qHnsXCUB0iXFjQn7n/rLDHx8YP/980jxDK8yrhbsnSnc9ac88P
         pKjIvdsb5suDBOfob1040SV622RxxAyAqTrfQENOkV9P9rNbP8PpxDpXiuYzej2MOr8w
         av+CZqhp+m7ycJrSYD3wt0eRb4RiRp2GVRckD1IvSKfmmN/eBc/Rf6l808/Pqtv4q/Fp
         N3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXBph8u/HG8XS+NAsz7AhF4YqxX0C/EfN5Kp2XY7ADv7ZA29D1Ie9UtTf4cUJuBaUeK29Ch8x7T/DBPTRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8hhGoRxTmUHvf8l1zSX9Jru9J2qa85uhFoAP6Z9+IjqWTke3
	33vpOG1SAaFXWmjd9dUinpnvCPxBHzUIniFOQIAWrkW5/hXAUFxuq++5VfYtZgmSDY1GD/DPsLW
	M4a3iOkecOkVWY+4+OjnP48gDlazQVzpTD4E5kcYhwk0euprZ1UxAr9PoVXs=
X-Google-Smtp-Source: AGHT+IHFpX6xqreYhQBwMbJ3rw/SSk38OjUtZ3pEQfn02T8buMjygtC9DyD7TCWS0HzF/ACkDIqMn1VFAG6ZxKaWs0PzIc/j7JF8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc2:b0:867:973:f2cb with SMTP id
 ca18e2360f4ac-87966fa2ad6mr294615039f.7.1752135783281; Thu, 10 Jul 2025
 01:23:03 -0700 (PDT)
Date: Thu, 10 Jul 2025 01:23:03 -0700
In-Reply-To: <CAF3JpA7a0ExYEJ8_c7v7evKsV83s+_p7qUoH9uiYZLPxT_Md6g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686f7867.050a0220.385921.002f.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_update_inline_data
From: syzbot <syzbot+544248a761451c0df72f@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Tested-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com

Tested on:

commit:         8c2e52eb eventpoll: don't decrement ep refcount while ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14ff7582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b309c907eaab29da
dashboard link: https://syzkaller.appspot.com/bug?extid=544248a761451c0df72f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ef7582580000

Note: testing is done by a robot and is best-effort only.

