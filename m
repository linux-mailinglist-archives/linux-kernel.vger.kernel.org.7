Return-Path: <linux-kernel+bounces-728864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10034B02E3E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45DB448157A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 00:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4E44A2D;
	Sun, 13 Jul 2025 00:21:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CF10F2
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752366064; cv=none; b=Kv3aBR64cQEye20hFcYHLLmgFClrDhvz9hi0gKJv+X8qZz/HzOemhAurd4ZkHQZB5riTBDXRDvkvyQtwegEy6q0SiFNslQcCDpCtX57evPN4XEXgxnBhnI/rhPWbXcNp5Kz4/idPiMPtcfpudzmMrD3pqkitD8MTae6lx017IA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752366064; c=relaxed/simple;
	bh=5159Y/sbutNSOrqTUkYVwoxX5s2sJQxCjqS8W7fxYII=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qHLImMHhXriBROmcx1qp5MiByqF4lvov8T7fL0cBGt83/+B+kgw2UOl43kBC9Mr/G+hdjA8CCYiBVlRdUFmVCFWiDKWq3qp4UKlbopI89U1uJwm73UOmKTTRomFpQGBAjpTHD8qUWQW/4GHoKMwADeWS0xp5B0tyfskWz0zSEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cf89ff625so301740039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752366062; x=1752970862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPE4Dt+RSZgKPOgjfqgmJZy83vVyA/rT23r7nzw9yv8=;
        b=U+Wsh69FOKldHlwsP7vQQq8e7+yRGd/Mq+lG9upoySMa42qlFbDJpLa3sqYoeNapit
         nkdZH0noP7ZNwbq7AciKMOcvfpy1ng68uPRADYwUh4ca95RegohDg60OYQolh4SDrE4I
         rXd7sYmfpYe30rBcoh/2ZvVNYT9p2Dm+kEAPWzwUgD6PyLFKnly76mtH3dYt+xzxQHPb
         eaxH0hcHtyGO9UEdTKWMGagzE1YhB5PENTbuTYxhA5zoqoxhjkzGV8zSmGtGBUJ5EL4T
         OtnVHholQjYFnQs2k00p1VNV2BhnPfV+2SnmB4skIWo8SsDFPChDYB9oSgaDD1BDsGM/
         G+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXzo5m/FFvlMOg12tgLV7gkq1MTVe2PjW/Blv5efBcSKRNmScE43Fj9UMXzBGBoWiBu94rnlS6IWSlzcz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyppuj+ThYJsqAXv8O3uwscztygnpkbEA02mAHxjapjBMhlhQa/
	X2KkbcWk8+bJtEc0Jd/POCW+JIlrxiqYjHS7NSSg2h7xbMc6ouJ2YOf5OpRAzTh3wU+4AVV3Vl5
	4wK7ZaG8BtxI7HG5Sm3FOtoRQh+X43RZbRE/vUYN/2YoiZlNBttdek+GdEI0=
X-Google-Smtp-Source: AGHT+IGEGxlXRsywQc8/yCnZcbCXgrRkevaQPHkDIWOkCPPhv8BNjxVxqj8pp8B0y1jLGyoZy2un4MBd2YF+0LYSEjGIJXUpwcjq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a96:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-879787e2f72mr905008239f.7.1752366062657; Sat, 12 Jul 2025
 17:21:02 -0700 (PDT)
Date: Sat, 12 Jul 2025 17:21:02 -0700
In-Reply-To: <c29ab7eb-9007-467c-a694-f64837e870e5n@googlegroups.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6872fbee.a70a0220.3b380f.0011.GAE@google.com>
Subject: Re: [syzbot] [kvmarm?] WARNING in pend_serror_exception
From: syzbot <syzbot+1f6f096afda6f4f8f565@syzkaller.appspotmail.com>
To: kapoorarnav43@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file arch/arm64/kvm/guest.c
patch: **** malformed patch at line 13:  




Tested on:

commit:         15724a98 Merge branch 'kvm-arm64/doublefault2' into kv..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git next
kernel config:  https://syzkaller.appspot.com/x/.config?x=82bd3cd421993314
dashboard link: https://syzkaller.appspot.com/bug?extid=1f6f096afda6f4f8f565
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10844e8c580000


