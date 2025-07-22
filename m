Return-Path: <linux-kernel+bounces-740878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0FB0DA90
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB85458A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9DA2E9ED3;
	Tue, 22 Jul 2025 13:14:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD74128C2B7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190047; cv=none; b=c8WyQ3RI0NxPqmkPD44HitR361tQLM+CPcyDqjijf3LdZ+r2XMU0L+0om+JDCpD3Imn0exI7MiHZNIKNfFnnkOLurb/xwY6uUOX5sl4ozCXTiJ306XtbyB+qXw3FbiVWsKRzgZH3QJnrQKTbn8+YsMOArbGF1+TWQ64NJ6/9E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190047; c=relaxed/simple;
	bh=wQL9RZiqmv2J4tT1vLX3wh8pDTuNjMTc5ALQpqpom6w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FP/jyBvD3btkWZSFkNvxcYF19dtAregWY1zu8pU9lbog2amQUfxUVsB5RnMgrr/ZAlxqUjJJqgke+TkAbyb74n4uY2ai4SoTZD9dF1hFtv2728bQtMCOmRdmOhlOan8dq05o0dyeRMnQ6Rha4ENcL2CYnnHqSrOX1YBZFJ9n/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c467931c1so320984939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753190045; x=1753794845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiR6ctww0qSKcSywG2l39+m7qh7QrL5zsr/Nu/Xh+do=;
        b=JE0nca+qbjXNLgktOj9ys25MN5/JJjDnO90SPCggiI4LhwB+jFEDnhPKXxPuv2aKP8
         kn5COmnEO5f8UwJat7LI+xaNv6vebqYDRmxILcuQd8FY/KH3mFWqodjFmMM3SvZHz2hv
         c6bYTGt4Lr/U8XDzVaFopsI3ewksZyBgnhc6Pv0UsGpB+qnLFIaj7x+cURyVOtMbSTxH
         kKPeoA0tO8jDyqBlxI4N9q22Og3SR9T2bGg/LZWYS3/koYOJJykfwNmf+wvE+xnTZ2hZ
         1bs7Em7yBp6P4nBZJuwX7l2omSxRnBXzGOFI5aK37en/eMqhjqEm7dxV4G9Y51zxcqTd
         YeZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrGkQ4Btq2K+fQVi723vgIHBavS5/gr7OUKD8u+e37yjDdl1OsZdffRAGHZfynthjK3RFoKDlc7plQDes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pABw3J+RYD+RS4GtBunH65w37mWFTi09x1pG+88K+WAIabOV
	h+OnVnU8I1R5x4HA3C3A4fBdJ5OM1fIChLE3MZnAjNULCsDK/UCR8LtlOHB6ZUk6nDZjivJmvfv
	/Qk3AOXPtJRbzLCF6XtrcetUlZYIJ/QCojRSTil9+E4TWSWGoo3eQKpmqsKk=
X-Google-Smtp-Source: AGHT+IEgkNvzb/wDkbygt3hT/c/l8powZYWGAu7q2mXKyeewStKY0dhh0A1IyDnOieB2ou3KBMKN9RtlTugwh4oGJPH2DsYkeP7n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc2:b0:87c:3417:cc11 with SMTP id
 ca18e2360f4ac-87c3417cf50mr1388116939f.1.1753190044896; Tue, 22 Jul 2025
 06:14:04 -0700 (PDT)
Date: Tue, 22 Jul 2025 06:14:04 -0700
In-Reply-To: <cf0447d1-3590-4540-932d-4be299edc432@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687f8e9c.a70a0220.21b99c.000c.GAE@google.com>
Subject: Re: [syzbot] [kernel] KASAN: slab-use-after-free Read in io_poll_remove_entries
From: syzbot <syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com
Tested-by: syzbot+01523a0ae5600aef5895@syzkaller.appspotmail.com

Tested on:

commit:         89be9a83 Linux 6.16-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ee5f22580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186272c644ef9aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=01523a0ae5600aef5895
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cf24f0580000

Note: testing is done by a robot and is best-effort only.

