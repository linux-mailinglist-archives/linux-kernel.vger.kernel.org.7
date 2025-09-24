Return-Path: <linux-kernel+bounces-831177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803A0B9BC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B874C6D88
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBED26FA4B;
	Wed, 24 Sep 2025 19:56:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3519AD5C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743765; cv=none; b=U0ujE4yVCA08qEVpNWELzWU6tm1riRcefjVUA7Q5/7mEDuj5WjG4Mi7E7Xn70ctC7tU34l3DEpLb8mAs9pAQI/zEzbRrj4Hv2f4AlUB+YDmRjI4PwMQr45nR5vK6N7DyR0hiAXS5OCxyG760rI0s90uIlO29+E70YYGlDnir4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743765; c=relaxed/simple;
	bh=K3eVRQZmSwvbSnufQyjrkz2pJdbRmiKXuSOJJvaARXE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o8gEakteMUDzgPSE+aBSsXE+lSfieWtok2/KwiRPkBDz+LsCb1qTX3DS9vJ+JWEw8rZNHqyeFfVf2SMK2nh90pnfpgsgxL3ZoeZWphwqMRhNuZO3x6sF1TxYbdViZJwlIBlyoIKc++46/eqv78Hdqp/MDfRTJgXRtpxJBTsfuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424861a90dfso3802435ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758743762; x=1759348562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmbNO5RGJXrxxpVOV8aTFLXQJqcMb0RpnL6EwQF+HBw=;
        b=v810EfsCi13/+RgsirYiKjaYeaVVJUGxkb+itaYQQvpvaS0QWmB5HwJ0Wi1W2HUho2
         8nbk+MTgbr/S4JrNyuz0+KxKkfa74UAeJlasB0exPtyFRXQWNOzJ2TWgCXW3BaXNNa+y
         23NsvlG9t938mherjH//mnynNTOqy5HelNG7P+JOPnbOdWGvQYSPff0YJ56B7FrWnL+K
         yDL/+rIpnsXsJSZ1293epH/fIDVpvga6Cv4qfNIAD8BagOFiIZG3mXvxmq12nBm6s9CU
         FtPLwWJ1Drf8FMrioG0htmEKREPj3kXwPH7efXHzMlOgerZxg5F7ltUarbv9WAfcS8gI
         s1kw==
X-Forwarded-Encrypted: i=1; AJvYcCUgF2tjw6eaCVHfHJ2AKDQs4vDmHlOj43CX7xUVU5T09e4RRBLONxKcaFg2ku/eujioJl4F3AHds5Fq2OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/sv37U9oeQVkLFMyELZ4IWZvJnxIIkcxvLhAVpaChXfD8D1x
	rmwNGvW0NaKXAjcoEF33uOezXPHL1TWXRdVLoQUv3GXa25pYR6kw8+dY32gkxbMSdzre9jP1rgv
	p9Kw9K1+0EtJy4jt4X7a142kOxHOA7WKUWsi9Jo2SMVA2KVlMhEZLVh1ZMFc=
X-Google-Smtp-Source: AGHT+IEO03i9AAEhE3tzuQ5vB71OG/rCwjnUUqZRRwwasipEyYNuDHe3c7/xq8uQmeAQvTOEuOHSRQAoM5s3DVlObKRorljsVDNb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:482:b0:425:79b4:9ef6 with SMTP id
 e9e14a558f8ab-4259564482amr10777605ab.27.1758743761939; Wed, 24 Sep 2025
 12:56:01 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:56:01 -0700
In-Reply-To: <CAHxJ8O_w8ewga16ORMaoM8MZj_pbh02ZRV1T_z1B6i8Q=9AE6g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d44cd1.050a0220.57ae1.0001.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in ext4_xattr_inode_update_ref
From: syzbot <syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com
Tested-by: syzbot+0be4f339a8218d2a5bb1@syzkaller.appspotmail.com

Tested on:

commit:         4ea5af08 Merge tag 'pm-6.17-rc8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149bad34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=0be4f339a8218d2a5bb1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14251ce2580000

Note: testing is done by a robot and is best-effort only.

