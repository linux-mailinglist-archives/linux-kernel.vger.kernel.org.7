Return-Path: <linux-kernel+bounces-846203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C3DBC744F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC9C19E2B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40980218845;
	Thu,  9 Oct 2025 03:09:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D521772A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979346; cv=none; b=Uh66sySIMziEAAIrwjyy2CAr6DZxECjPamDArJXCgTBAKknoz+YHzShvnwBUToK7HXJvzD2vbnrV1K1Bsv7YVLMiVWiB3Of09ZoUZ2gXNZ+jT1lAJMMB+owQvcke/j6MFAfpVfyaNR6ncdAeiPlOqalP0eQk1nWi5qZ+DN5DGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979346; c=relaxed/simple;
	bh=lpy+cAukm7PNJa5ZfnYLiEVyzbTvYOT1DchxCoboLz8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j+jUIMCywa7/tnZv6In4RkPnnIP3LIUIbO+rBs0yMvhC6B/SbcE36ctA57hbBOB/wLswtkYWyCP7gRoSMYGOPAsw7ayWuFFX/SOiuiv1ikf7w7i6s0Ovrb/608EqNxTRMM9O9pp+R1zFn5gt9gf9EbdT2/h3rhO0fbCj9j/Ez1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-937ce715b90so379063439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 20:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759979343; x=1760584143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vxLIdGWGTc6pMVOu43qkO5BzrV471hPoUk3GfZwLd4=;
        b=o8gZIrNoF6tcRA9fxsQRsGQQ26lW0OHLclfdU5oGq6UunuFB7usvxS3XR9k9oYNnLo
         biq8LK6hK+H1myTUcx43MXokNByEL+9M08QCdzpdwCy6zDx7fc+OKeEYdQnZTiTqexh1
         bI95rYSKLjhpzjDd8qmdI5OW6bV9aWf9pM7Ht5yud3kg/a3x9pm5cURn6nRNrH5Fu9M4
         nmxyxBChxLzbODPT/oi+7QIA/RXuxfhNGRXCJUzQNcKuSxd5cjans8XQscuP5mHisEY5
         NF326IYLNmdkonOQGwCudDLkbIO+3S/i6VjvwhvWXBWbO+eISfUosrgq04vLS65fZIm6
         mD4w==
X-Forwarded-Encrypted: i=1; AJvYcCVPl/zzSgkgQa2Qo2Q5J2jhZSEmn5AadJKYEdbAvrTHuIjPO0Uu643iSukrVnC6T7MbCuN7Xp4YZetDMTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tRFpMzVbI5Ud0AbCaP4BUXpDqgvcIeLOr3Q/0F+MlTzkzYmL
	4dDkDLKnapnVUsEFZABtlhJWfzBNoxl8wPYyJGHjH/rFLGf2Wy2aLoiBOzrhZhO228JwTcK7Fn8
	FwKvNvbClzO48Ln1mR2MixA9EXdHcMkBzVYqQT0DSVSHhFWfyvorogFh/8ZA=
X-Google-Smtp-Source: AGHT+IEKULW94bpMOmxDqOA1CVEAXE8R4hsqCZwXgJDV8IGayTQUQHy76hpWpO7tTOIfb/rsOzvqfsVrKNw6lAe5EUKLSQLQ91JK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:7b43:0:b0:8a9:4e94:704 with SMTP id
 ca18e2360f4ac-93bc40a9a6dmr954795439f.3.1759979343448; Wed, 08 Oct 2025
 20:09:03 -0700 (PDT)
Date: Wed, 08 Oct 2025 20:09:03 -0700
In-Reply-To: <CADfthj2CUn1dQPVaoxHZ2x-6Jppnyf5gbETxOun+-05_OmXLGA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e7274f.050a0220.2430e3.01dd.GAE@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_write_inline_data (3)
From: syzbot <syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com>
To: albinbabuvarghese20@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Tested-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com

Tested on:

commit:         cd5a0afb Merge tag 'mailbox-v6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ce3a7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513361ac097cb4a5
dashboard link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ea4542580000

Note: testing is done by a robot and is best-effort only.

