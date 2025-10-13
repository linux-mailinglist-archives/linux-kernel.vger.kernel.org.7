Return-Path: <linux-kernel+bounces-850621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FABD34F9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389143ABA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE4C23D7DA;
	Mon, 13 Oct 2025 13:59:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410123B616
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363946; cv=none; b=Y9QJ2jwbRCEEXw3e7PGgZUdF3CFgbqTtLAr7+dab9CHfYo2jA/c4xps2AiLLI6Mao0YRmltHrWE2M4isKGgiNWJTNK/TWsHGLykbwI0D7OXiq796MCLAprvViekjZuLsbJ3iTWY9KbLWkkhGWDKuxScnUBAUNaxHacg/mM3/kRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363946; c=relaxed/simple;
	bh=7laGHJXGABBdOGcIlTJEDjBW6tb2PXe4XikAKdZ5Sig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O3ndS1Q7yRqKR8HclAnJFJIp4geta97ims0t2DoiYD1FZbXEKWcfjtddDyTggDEJ9/elsKOPja+jqcc2lhPGGbAJqYyNifI2rDBOlTL8UKE2Xgc0yoHJ1V4EYHMY+Igh4r3xt0IAx5Qnw2AvcVYf3BY4MxdFw9UH9slt0dsKtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93bc56ebb0aso2341790339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760363944; x=1760968744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jEiWNXqo1YuKeoXJ7VMl6srKM9iGuYSpJwtrAyCzyf4=;
        b=qyhnZPceCHkJyF0zdTIrhGyFh/S07VZDhwhDSuA5pSZv7dxDZQpziN5zbplUdtx3iH
         ukGQpA8JquNCDzkWUzwA3vuRVsTHqNSagl0PyMJBP+ogvjbYhZRjP0oJUZ8oY5ugxT4J
         3VVqEuwjM2J9dpfebH3s6xi+zyQuAYqw8KviPZSF4nxmhEIq+OwolUdEAoeumt+j/CpI
         V+Nk25RtPqnuMq0+jwkZMGVl1Qjm8wKY7mrlFtIlSBih23wpct6YrBepx6y/syBLZA4M
         OPjrRe0vpCiGQJxGu6T6jcSdpZ71hDKzTP09nbl6iOyfynjWDRfB4MnftCbQw3//7TQO
         loZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQhk+zXEA6dIy3yD+YW7IuvSRxHrIziGej/uOfmPKK/aMF67YYVMoLHlZoCjgCN2za+DpkDzPua7HEKE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLS5maaWl2RG1xT/fPE4r1fUKFxgEoVlrpvVJIOoxDTLefgAO
	fk3SAJK+FYpCrIubNYdNWYTyDs8SKN+ONo67PsIwQFJxdy2mwMmBNi4MNW66o32Av13Hp4QHI3m
	EElspf/zUK1AuOmID62K6qgHZ7UCqQSmYSJ/OnxOIGF7iWs7YoGY9kydxraU=
X-Google-Smtp-Source: AGHT+IFTjeGi+jL6weohZ1UohPECLPhHOrlZVrz+AQhV+0dbXpDKvpX91gyxiP5/l53cRL08tZkZFGQWmoKC8Sz8jhVJSAuCnHEr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:483:b0:93e:3634:208c with SMTP id
 ca18e2360f4ac-93e36342731mr554079639f.18.1760363944523; Mon, 13 Oct 2025
 06:59:04 -0700 (PDT)
Date: Mon, 13 Oct 2025 06:59:04 -0700
In-Reply-To: <657566348.996550.1760362721717@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ed05a8.050a0220.ac43.001b.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_rename
From: syzbot <syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/minix/namei.c
patch: **** malformed patch at line 8: @@ -236,7 +236,7 @@ static int minix_rename(struct mnt_idmap *idmap,




Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=28cc6f051378bb16
dashboard link: https://syzkaller.appspot.com/bug?extid=a65e824272c5f741247d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12089542580000


