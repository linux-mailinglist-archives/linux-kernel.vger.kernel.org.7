Return-Path: <linux-kernel+bounces-728721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31217B02C41
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 19:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48107A41BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 17:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E0A288C9C;
	Sat, 12 Jul 2025 17:43:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63CF280033
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752342186; cv=none; b=mBFNDriIxJ+LavSKfa8C5Lwz37mPASCETSYBzNQHvGfPZMYKBvn76tIKpZXOnTsOLrfQqBt8bTer024pO1IRMaG0FP2QUyespAWt1Omd4GUKd81fQA32Ff1qxdhwD2IUlt2rlaBzLYiUNXFnFUPIVLbqNjloU6MPkL3YsNhtDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752342186; c=relaxed/simple;
	bh=UQY4KZFTVvMw6HPcJjMKtWm/Rd22P5fvmzfo1cUhce4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FpEKEKOknFeyYsQo9zHFuAQF8BbS4QRE3LfX6Lsq0mLOEGSI1dZoz/GMzaxuKGq4B2/qGIHwNMJvViTDwQWypvZWU1BRq1lVNtHgOvxYZS1zPuTp8oK0MlcdIR8dd6fW+z5cpnZj2OwseribYxBd4GCIXZsy+XYM7RbMNBr9Rac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-876a8bb06b0so564361439f.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 10:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752342183; x=1752946983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86WJLMD2iwjNDuew6ha1FO/E5bMbxd125SIQDBz67wM=;
        b=c1iR3YOgSl9Kmp0jIY6ZWhpm1LERif+1cIOhzD+A+NQSmi14+fEWDqx9xsMNLlcSbd
         N0DO4ioh2cSgeruxrGJBAuCkwhRl4Tk9O8aEY1rO4xjVF70AQUbaSWF7paesRhBLbKcC
         rChxUAGMjZGD//uvdCSciAgfxdlh/BFqmZiATMrpc0nrF8S37wsxdnqk/Zh1apiMudXG
         +wNWGlUt5hyNsPOtswtsj+d0jFVTbIxgtSXWt9BDCT/CuO3L5y4DeD10MUACxu4kIYsY
         qWWvT5IHBRa63TpOxxUDrBGkxzlBUlzo1CjxOrI+BhsXWOeoADhzgXQ40JlOFbqEKgPE
         ad4A==
X-Gm-Message-State: AOJu0YytQ+KM0kZr8yC3WCu0RBQ+/qE2yA7hjqGAD5Dl4oBqNsJ6OODd
	Jn91BqXJCLhTPWSYkIqY+q2xgpfP0VJbCS5UCz8KL//s925xQhYcdiYruEWES3AQx/zIxItEmmR
	A8wPOZzmblIn9Oisztx1MYdP9OMIY6k8zfi7+JG5HCm1wkwY6ZA8Ffez6Y8A=
X-Google-Smtp-Source: AGHT+IHRPcPdPrmYK/C7r+KeFCDY8YlJmrfJJFpKtG4JhnGwsKyuKsVpdsLkJYvZoqGIWCpA5Hz39KvByAtJBy57tqfBgL6sOZkO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c95:b0:861:d8ca:3587 with SMTP id
 ca18e2360f4ac-87977f7198dmr1011141439f.4.1752342183738; Sat, 12 Jul 2025
 10:43:03 -0700 (PDT)
Date: Sat, 12 Jul 2025 10:43:03 -0700
In-Reply-To: <282345b9-9aff-43ed-b66d-76cf51cc0deb@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68729ea7.a70a0220.294487.00ee.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com
Tested-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

Tested on:

commit:         379f604c Merge tag 'pci-v6.16-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a2fbd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f481202e4ff2d138
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bc8e8c580000

Note: testing is done by a robot and is best-effort only.

