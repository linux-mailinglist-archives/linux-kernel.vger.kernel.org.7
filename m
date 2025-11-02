Return-Path: <linux-kernel+bounces-881985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06991C2960D
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3319134696E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3011A1E98E3;
	Sun,  2 Nov 2025 19:58:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25113C3F2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762113486; cv=none; b=YALJuY5gPRMJwwmDG9AoNDlkoq05BwVUZ/JaFN3oO2qub8MyLjRWAPlXC3QD+jj/QivSyq1LVPIg/EsZnuOyFJN+/fcqyN4GtGMXynH939GDzwGdHGKg3P4iukQOdUKsVsn8UeAzhGECYN/ioWsI926kciVSrZiclBpXL7NOcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762113486; c=relaxed/simple;
	bh=sIvjlZyg7OtT5BWGfiUDjsCCNYn1/m8YkjymA3U2lwo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mSdq98LN8AWiPzMgSVcv0U2Vw37DmaSh3ImNmEcQhaynJQPg1XEHttqBSmA0EuROwPWk3NG+Ry/PHAyCED3jzptuDPsFMSbhCYYrV+gj5ZRsx+G6ujl/NInGHGyAc9V6kPKz3jh6dvVAvVCwUH9+IEelFJjv1kLGQ63bxYlePm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-4332b83308fso3967395ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762113482; x=1762718282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3I2l94pl6AxhffMtjdusUVB/ZHOcF0Sm84iLrIzy4+I=;
        b=b6kYR6wOvmT0yFezb3d8cHAiED6TA627ME3zhwzJb0NK8jmZIp7Cm5RATBE1WRWJqw
         0VvkQyXS7IN4MvImnlsYtT7ejKdQ84nqIbuzdPYxM7HRDS9aP+6SGjCKpKrvXDgyyngN
         7xT13coK2i1DYEySTlnPJmwb/qNvynMVx8XDVU/8AtuqcbvD9mFUb6hFfeHp/5NqNR2G
         hfDfaGJhCpdhS1bcGs2ncLX20LyAu6bdnpwgc+NSb0iLHE3HEVeFr6fXmbH+eUYDzPs6
         3qY5G95VYfgSOxOytzwERPuwCeZo1UbghHc2e+JJF0RqiM8LNEor01bxS3VgrlOPtlf/
         5ZBg==
X-Forwarded-Encrypted: i=1; AJvYcCXowj5dznuWQeFPBi2Z1E4Po/65/SBLeRGn3hmbVCpyW55ogSfnaSsP6sFBcUbi6/BtNB+TLbb2a/i0Akc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROHgEodN996quJKFnlCnSvbDiydjZfpj8AVTZdhYWCiwpnE7z
	v1b7B/Gzu1lMGl6N2HU4zMz6WbtYuJpN91Q93qwc2XKpABFyYonFHBEYAXIMIW12sO+/8LuEu6K
	OjTwZ9nOOTUmmkoE1CMThOEbZOAnebDVqPEoSI05bM+f39QjZxxoPVDTTaPU=
X-Google-Smtp-Source: AGHT+IHlpCihH3J5OV0ajcQnXIS/HRZdY1cN7bQ5BaSZZNoKxuWH8X5kf9Qq/v0DpDOdqY3Md+IQM7SxdbumnwQ/1IDF3IXHqJ9e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3789:b0:433:2cdf:6457 with SMTP id
 e9e14a558f8ab-4332cdf6556mr22057155ab.12.1762113482478; Sun, 02 Nov 2025
 11:58:02 -0800 (PST)
Date: Sun, 02 Nov 2025 11:58:02 -0800
In-Reply-To: <1136038322.3472008.1762111329562@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6907b7ca.a70a0220.37351b.0011.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_new_inode
From: syzbot <syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Tested-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com

Tested on:

commit:         691d401c Merge tag 'spi-fix-v6.18-rc3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147c132f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72f4d1bb6e3e45a2
dashboard link: https://syzkaller.appspot.com/bug?extid=17cc9bb6d8d69b4139f0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b1d704580000

Note: testing is done by a robot and is best-effort only.

