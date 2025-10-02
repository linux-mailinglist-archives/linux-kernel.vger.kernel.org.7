Return-Path: <linux-kernel+bounces-840127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86081BB3A19
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457833A9DC5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41F7309F03;
	Thu,  2 Oct 2025 10:32:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4DF2797AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759401124; cv=none; b=TvhGm4Cycdj11ZTk6TJbTCVM7WzVYnVcEXefzNuFw7s7voFdLHDVp1EeTUp98IOCyFSV4l3X5fW1GiEWlIJRs2r28ZUGEsFeYq5qBSpHz/Bka3Ide887h24pHQ/d/aJR9+rlJi7qjAyhv7d1Ly7LYWPiU+EXhcAKUYlDBP0f3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759401124; c=relaxed/simple;
	bh=9MSJ18BfBtumtAq/Y5KyoUEUdF5Lu8GkDjtw2vddQcs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JWUMItYjakmFdop6xx+CfrjnbrgdIxlhRoYQV6fp2Mfn6uUJrUwCOfiQBMoQwCYRZAKRWLKlx5YkExjki6W1GYJ4/vvuu8E5GaKNX/BbvHGVjzMn9+LAq1+qUwB5khtjaPMRYTJCeGwSyVDOAl5lKYzPrHkz7440i7UvGP5xYn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-91b3cc5aa6aso215019539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759401122; x=1760005922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHziL1qyJnGE2F3WzEGGHMrZ45OgeGCnP7pcQgldFfE=;
        b=TBOANW9YKPNOUGnYHRIbnMT+BXixiqX8ATUjNo8T9qKvQ82OhbIyqAMNAOHLaUV+Ne
         0EgSe0X/yfdHmxmbrKFMqhpNMW0QG2xOA23d/gEDIp4CBLj/U36szjlZoktQ0luLSOA+
         SsRteqM7WXX/cL6yyQeJIrTLHAK/aQKUt0bBR2M35ufIeOZzPDi9F1LBXDj/j+r3p14l
         uFKAA5eXnup7527tKte4Kh9qHdCeJgnyGgsFfKp0kPbhkZY/3whJbJY+kb0LesbcImUt
         pgNliY6kcXdfs+1Rdea0cgIC/YiGYkrHxq0dUJKGuI91q1P8/Y25C0vqGyVmj50aph0K
         OJxA==
X-Forwarded-Encrypted: i=1; AJvYcCWvZR+LKPlQJmtN039N+epnotEGcSBssJiAjYsD3dZHX2ApN2ta83xFYN70tR2ANTiAggakNti44bZi0Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/oE8c6kjyiGvLGR8XrZne2qq06vZ/U15H2gC1UmUYpIFxhWjY
	n+pEHhaSb1hWKLoSo9DfHFEEBAcE3zgosEc1NTLhsdI+ZL/qhEBFvEf3qGQtzRiVn9kDEplAZEI
	vFQIABFKO85MnqWOc9fLvkYWf/QqDr+WmPgqZuxrxESW1ldaCPXylLZCZpqs=
X-Google-Smtp-Source: AGHT+IHD20XaNSCfacAUZcKUdlOTndll3s5BZsbV0BgG08aLgWs/MbJgdkQpysLgyPMqRQ1gfwwhOaxuZlI/ChOvNtMBjmodSHfX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2770:b0:913:48f3:27a3 with SMTP id
 ca18e2360f4ac-937adb622ccmr886674139f.14.1759401122106; Thu, 02 Oct 2025
 03:32:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 03:32:02 -0700
In-Reply-To: <20251002100108.2390216-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68de54a2.050a0220.25d7ab.0787.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         7f707257 Merge tag 'kbuild-6.18-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175d4ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0364a9e4a291ab2
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162fe092580000

Note: testing is done by a robot and is best-effort only.

