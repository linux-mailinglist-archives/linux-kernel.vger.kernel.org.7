Return-Path: <linux-kernel+bounces-809718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB4B5111D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE81F1C23B15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7670F30EF8B;
	Wed, 10 Sep 2025 08:25:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA931D372
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492706; cv=none; b=ZOiYyS+fyieeuqdEyAuV0Lqbn+acdiDoNM6mTStLjYsaCx0h6wKfOkE1IVQbYE/Tz1TUE5HARDZke8X/QcnUk8RbjRJmxtBG9tvUr7qdeWQJDMRSgofKJ56nzjIpoxETqoMPOV4ljcqJLa2TB85UjfAMlpdwox82wcxDMDHOZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492706; c=relaxed/simple;
	bh=vYGZDV+ca7/kM8qh5pnLulAaXwriIje65ajLrL4lgYU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ezh+1pYryCAeOctF2RkdKT423RXH/j+PZYldfIo3vU1Vtgk6vS+HSnSZSsnC9MvzZkglVpYAWdvSBvkUAfXEIKmkG9sC7h5wn8ZRuvBM/+W+1W5ECF0e+Nej6uiqCG7sb4JTijzkbyuJJCao3v9ajd1sG1rAWI3ZLyarwmRNGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f90a583e07so44984355ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 01:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757492702; x=1758097502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxc/JtKgRHZU0gkUlf9aCALhtXAK3Tp4d8mrq81N/6g=;
        b=wvvoHq3N+MRQZZNTLR7twkwFEpbvLATPx1p8iyOTOYU8zXYg4/UPDSWvUN045eoKQF
         p7QvoSKfgjOmi/OlFWXpqWduEQUK3L0HGWhn8UKARp+fWZi7evYrah7spyar9EmC3rk8
         v/RKZ8rjD+YYOelB+NixxBwQrC0Bxwm1nRDL+WAajZYHWaqwKs8F0y+qpv9QFYAi5Tzg
         DB4Rh3fGMW3jY9Tj/H9eJ1zq3oW00vPn2sVHZCw/4odSjH9QvVFf0zuYuHBCVzJkW0R+
         f9gW3cLAKdbp7Q9MYtRH6DinogQPLy7NLUUOIW+bwXmdPQq9B06lRmdRtSG2iyPs/z0e
         7IhA==
X-Forwarded-Encrypted: i=1; AJvYcCVQatAvnzgHguvkEEerKGaZdparsuYY64sktB4YOYhiJ2omqS809uL7ojSObZWJjlzb3mTU6bedb/4sCwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6R9dRUsuyIaQdiY3Few/TP+W63wrVmDQxOfV04jd/BRNJ8wFy
	hJoBY7/vhK32jQq/kyZ9dpX6PUmd3X0uJM9Ym8vxLxnEPFEoYsSXzrWUFBvQkKNWMZnosFSrDcY
	e1iFyqbPHxByXVvDcAeYFKcZ7V09614op/IoHRO7lvui0XsccrOmLoRD2olU=
X-Google-Smtp-Source: AGHT+IHAnUHV6J8O/T06NJEqAmxLdN8PYws2buCV0rG9JlZLwkfMvBYOfSOLQ6n6pKsRHj28HodUh1CDUPHfcBRGOv89LddVcUG0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3810:b0:3f7:8b02:285c with SMTP id
 e9e14a558f8ab-3fd88115010mr258419125ab.29.1757492701777; Wed, 10 Sep 2025
 01:25:01 -0700 (PDT)
Date: Wed, 10 Sep 2025 01:25:01 -0700
In-Reply-To: <8ccaa1f0-3263-41a9-b2e5-bf540be979c7@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c135dd.050a0220.2ff435.0009.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in clear_inode (4)
From: syzbot <syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com
Tested-by: syzbot+90266696fe5daacebd35@syzkaller.appspotmail.com

Tested on:

commit:         29c29fdc f2fs: fix to truncate first page in error pat..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=16da7562580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=edacbd86461ffabe
dashboard link: https://syzkaller.appspot.com/bug?extid=90266696fe5daacebd35
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

