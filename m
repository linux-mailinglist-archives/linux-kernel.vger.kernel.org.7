Return-Path: <linux-kernel+bounces-832507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EDB9F8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98D81C20F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D524287269;
	Thu, 25 Sep 2025 13:19:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EE286885
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806345; cv=none; b=p21Z/Qwwnd7FYY8EsVwmWX7JUNYdkft/JrwUCrvGmi8Lu6zLXDJagxGKeWrMjP5HVAkEbGZZVxQ7ZZoFyRuug/ct3WrldSg53Vdxtt/4oz/Fvw8X3QBTIrjgEFtBcUyNtfV2XGW/TpXw7kI6xzn1gMcT7KiufnW4FBGfRC/xuIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806345; c=relaxed/simple;
	bh=1eal/MI6PV2m0B1vOQ3IFfDPPZ9xXqaHDf27MfcN9Wg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fs/ze4GQ/oWiEMtEhcBeo8GXFSYqNQ4egMP+qkozrt7GjUC52L13b8fsvdxu5Y3kvJtN4NYWpEwSjqrpfOq/oRniiiRUz4R+/aIjyTafHoBlc4B40AcwS5Y2DnFtS7vhKsD6ofDdHOc2xpOxk66zGFPpQsdf9T4uBVnLV84bes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-426cbe6a23aso960375ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806343; x=1759411143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iP/lIznUl068KwO69h4nIjqfPnsv7+xUnomETdWsppI=;
        b=v/qLCbwqT94mTQbUSPCgfCl8sRJf+WZ0Bg+4MzfBkpjYgRlW3lL2OwLUSQ0fGKIrCC
         4Gt8jEOo93e6UNOHBDJtEMJyCqcd3HVxWJryTXTFoqlFLMmUcj/Gf4Y+w26wQF7hvIh+
         /2f0VdUfsgsXHX/PGxWFFPKcfMwDqOXdneG7gHwmJjCoUlFVkSZGHgBRoFtkbcDZWOwx
         JL0oPMaKP+HDILUnsWxityXWoHNuGa+yG4us6q4t5biPDdFcZ4eMRKnzi7iqZgFWJd2/
         /0dd5/5DoheroKoEez/GuIePf3yfV9FPIHTCfa8EincZFN4w6vhKpd7y5JuIdx9/xb1J
         J9aA==
X-Forwarded-Encrypted: i=1; AJvYcCVVwQ7HEsTnRZPWxhFue0xhCMM4L4lV5C7Y+plD7hhineW1dJT2pbM1x4SPjMMyj/xbe8JnYaUk7uqEGng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMt5sCV6/uF09HUdcWOoPsSS4ilY1KPxQc5AoypHzarAaGqPyu
	BMamSXITfyNwQUUETyowRto6yyWiw48H6GBJ2L9VmncVT04YrOAslFahjNEOcwJN1DVrxpXUK2e
	UYYMTOnAon2pabiCIb5GzCv/dyEntbRRoGhIykuGf5avwsYp/o849/cYe0bs=
X-Google-Smtp-Source: AGHT+IFkw7Z8tUEQOkiUwfdGMHtbgvcRnaObXrt/Dr802JvKHHLfkkNPp17DLVcDA3VFOZN9Owi3i/jXCc6FyaR8CIdEvbCg6tDA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:425:8744:de7d with SMTP id
 e9e14a558f8ab-4259566cf61mr48013715ab.30.1758806343332; Thu, 25 Sep 2025
 06:19:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:19:03 -0700
In-Reply-To: <20250925104041.33750-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d54147.050a0220.25d7ab.0015.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in hugetlb_vma_assert_locked
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Tested-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com

Tested on:

commit:         b5a4da2c Add linux-next specific files for 20250924
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f734e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=841973c5ab4f4157
dashboard link: https://syzkaller.appspot.com/bug?extid=f26d7c75c26ec19790e7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1203ed34580000

Note: testing is done by a robot and is best-effort only.

