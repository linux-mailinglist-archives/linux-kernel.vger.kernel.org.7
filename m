Return-Path: <linux-kernel+bounces-752453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92681B175BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8171CA83462
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E3262FD0;
	Thu, 31 Jul 2025 17:40:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECC5243379
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983605; cv=none; b=DYosg9KvmhYs1tqCaGcLXmmfYb07O/JQ5nDLWAdQN8CuPpz28pKaILfYXhy6vHnvFTyb1kX1RUNp9ITKiMgz6edYZQXLQ9b3Y7KvdWslqvCoHBgWd2QSWZPUdUIV9aAoDgw1pQpmQPFG/mZLtuAM3QxAdq4IeY0rTv85ObjG2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983605; c=relaxed/simple;
	bh=182GhIsQN8ufpl0dRaGP36YX152jIJP3Vk0dHL9Debg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o1+qR1BLiXkGa3sC3lUFEw131cRLXKO7088tFglqP0GxFh7eLEsrLW62WJRiLnB3a64pUuCx947bdVUotMzBrqyDUNgXfAJ/Z6zdVzHwEDvL9m+QFRGqlqYbn/56oNPqkuWQpfWE1IU6GIA+24wh+Zi9McQDhrctFJgEGpKg6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3d0bcd48fso564665ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:40:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753983603; x=1754588403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsbaK4UHLLqAAYfeDZ3fwAWkCQLI2GYeUxkK5qld590=;
        b=YDuJL3isEnqzZE2z+kCRqwTlmKbAEQcvxz7EQIrlvbP7SbGrpMetsbpxsv0eUFWpLq
         oXhx9Mxa4nLaFx49Hfb4pLiuevU4YSubniYva/FTYRb0awgvI3pzeyLGvPlRDu8rrq0i
         MXOEjnrscqw3ozeFeT7w+YpoFkw9tJwBvS84dLQu32hEW/hIMYZLyd14pFIKv35nZR5Y
         BrN4uX9urllnRS/slzOwJnXskBGQGJ2OTLJkA+BBeWvFk6OyRwOIpIP1R7/7gc3K3Jfh
         c9VSauPGZdM1S/G0EVpk/BqtYAV8y5HKfq4dBQdMub6uW1sKluiTeB9nyJ3uAMYE4+03
         YXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtlVtbAS6e/gGQPVcglbKPPhVi7b3GbQNL3wPjs8CtmrgXSdKtfrkC5vQ6kZ+BnEyaMPuPQFsG/rDaaU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykVdhexPFyntkqAcsglKD3RSwPOPo3NGurIuGKYkZdlFuFvy2a
	cDN3rKfwLe34lwmOTEVkN0ZY6Xmbn0RAoDNAMju1QHJvdYwSyMIsYanK0WYZE5zrowamyjFGpib
	Dr/pL/1qKnUWhp/uxhLrav8OrZl8+aMzSWzWZrWWTsSi2wrCWS10H4CY67t4=
X-Google-Smtp-Source: AGHT+IHkeGT8uAnLkBmTcq3jrBYn8/fUlear18NYlhGgZjjLPXX5VVJNdDlmVMP4WOZQgF5dLHEIYPhtIfuKmwZa0MukoUfPXD4M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3802:b0:3e4:23b:498f with SMTP id
 e9e14a558f8ab-3e4023b49b6mr63898685ab.14.1753983603016; Thu, 31 Jul 2025
 10:40:03 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:40:03 -0700
In-Reply-To: <20250731171729.46432-2-moonhee.lee.ca@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688baa73.a00a0220.26d0e1.004c.GAE@google.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com
Tested-by: syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com

Tested on:

commit:         126d85fb Merge tag 'wireless-next-2025-07-24' of https..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=1104acf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e0aa2ee2717f461
dashboard link: https://syzkaller.appspot.com/bug?extid=d6ccd49ae046542a0641
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128ee9bc580000

Note: testing is done by a robot and is best-effort only.

