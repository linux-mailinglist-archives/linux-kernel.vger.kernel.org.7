Return-Path: <linux-kernel+bounces-885374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6DC32B88
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C04F4E236C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8912DFA2D;
	Tue,  4 Nov 2025 19:00:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7A2EFD86
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282838; cv=none; b=okyBYobBbqDDxJ9+EVQzAJnZnprjrRNd5hcgyQFWSWhYHUitD8j/P/KZCb2bOJ9WWSTzthgoM0oloRRNm9PfPWPaSDA1Sw7UH8Iyd3xgsynRlWta8UAWBkDWdxcEr/jkRy7l13UX4C1ivhQaZwtoCiPGVFUiY4c3mZeqI4zoGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282838; c=relaxed/simple;
	bh=TQkUXBYMtHdj8Uuf8ogDAIk5Qt6M/mCLAJwqkR9B5cg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=fVvHH6Htk/owCW53G16dKUOFopnXMuFuuwfIoqtPahDUZptB1eO0I/j0rSgj9SU7bwzjNUuzwYMc4FZBfKWX8a/Tp4nXJlwiTfh9904lyHSFvDlRjecPrOq8+TI5UjzMOLKLVomSnE+ofXNaZRWaX/VZkJ+QORTS4V7QAToofUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-4331d49b5b3so127013015ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762282828; x=1762887628;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQkUXBYMtHdj8Uuf8ogDAIk5Qt6M/mCLAJwqkR9B5cg=;
        b=jP6G4odN31GnZ6vdZgceHOgeCmGZa6xu+9rZa4ydvNb0KxtOGtuNPPB1cedjJ5WKq2
         soQBPhargOasVIb9WM+HIc88cao3DqGdP9hZEeseZ/HWRJTzJ+VZi5RJwt0pvOyD/OAn
         7EUPwVIeHPo1VjnG7okPO7n9YayPWBIuBhN8O8816STBoo12AoeObE+VTgZ1wu34YGrL
         GfRdPPXvfiADP2nb9tYKYC1CGCV5xpu/KndynUM49Xo7vyABHjjHs4gAGZ05mF80aJfm
         6p9FafDHLW1m0A+FbIpdTzmfKAnxDYHbBSL+737TAQNojPGkJkQN6fLiG5Fo5uSUG45V
         nW5A==
X-Forwarded-Encrypted: i=1; AJvYcCUlAOOC2nvNH8FrayxEuYJ1V/Y+bAZ3uB9YNeY0PDcIgdy2HaSg1F2UEMq6mN50T28mnAJogXA6zcWjO84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBmx1o5XD7HsyaDj/+h9MkRcJTuiPgX98HXvAqUgoXnCR+t5V
	+1ROcwAKKcUsVcC92D6ftanPKFG0dxvc9idvq2qgZzLlGS7SUoYrKmU824X+29ogpud5m1rCpqG
	a3UYUqeU8xe3YBZcQqBDGwZLnUMGoWX1Rbz3voUURUdURI5DlNlYWYK8eEjY=
X-Google-Smtp-Source: AGHT+IErBC+zaP2NTyj77GIov+pGSMFJctSmgWOIrpMr3kAee9G99FTMWvPLgv/znf3++Y1uZ2XbrSDRqsz1C7i0+rzmP+LWmRfT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc1:b0:432:10bb:4126 with SMTP id
 e9e14a558f8ab-433407c08b6mr4339825ab.19.1762282827746; Tue, 04 Nov 2025
 11:00:27 -0800 (PST)
Date: Tue, 04 Nov 2025 11:00:27 -0800
In-Reply-To: <CAPqLRf0V5Mpi4941KKH8G9y2SdD2Tz-QZR7K+D3TN+Wf5B-ccw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690a4d4b.050a0220.98a6.00b8.GAE@google.com>
Subject: Re: KMSAN: uninit-value in bcmp (3)
From: syzbot <syzbot+0399100e525dd9696764@syzkaller.appspotmail.com>
To: kubik.bartlomiej@gmail.com
Cc: kubik.bartlomiej@gmail.com, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

I've failed to parse your command.
Did you perhaps forget to provide the branch name, or added an extra ':'?
Please use one of the two supported formats:
1. #syz test
2. #syz test: repo branch-or-commit-hash
Note the lack of ':' in option 1.

> master

