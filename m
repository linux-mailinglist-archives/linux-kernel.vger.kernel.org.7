Return-Path: <linux-kernel+bounces-892792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7269C45D19
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9129C3AA7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A726301010;
	Mon, 10 Nov 2025 10:09:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05CD4A33
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769345; cv=none; b=LmXWae8OmnwCDXKq9Mo4ILU9APdGVL3gA1SIBfR46JUxgpWAkR2aR2XqLAksNyHDzCyLQVysUy45KFUoV7sGHCHBa3QVHO9aB3SS8fOrrjQikG1SzQihgVhX7cHifmuE6k+ThvhsVi8RaHVVH3oBBt++xoBo6+zuWqV2/BsGUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769345; c=relaxed/simple;
	bh=zFAcacTaxgVY+nkDsQEaiKvwk5rOtVVTi/qxNz978hY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=M0tY3FddpZoIeZh9wD9lqC3zKtTqUQsdTDNnoNkF68zkzFH/74rVbe/XPHT6XNgQRMyf3NgrJpSqSebw618mb89WWC9gcJBdBQvh60N9MXg7H5ROTMrj50jiig+GfNmFBSwbx226XbivZfFn9zpNK1YQxWfsrlCEMgZ3u8gxm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43323ffc26bso21522705ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762769343; x=1763374143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6uY+EM8i3DZwvN2wGbaARDs/Dgvk4ylCN2HCgZAGvvk=;
        b=Y6bG4WOASOLjdCNOZ+8qBTNl2JqDk4Y55zrwRY4gh4aOlVlrzv6dbrW6/W7RffRZmq
         ruC7IKzEdTFW5OsUQdHxeIceURrYaRn40f180ij06JHo8GbIyhTvRq7DBdqg9G7Ta/Qb
         9VEP+rKo+YM4qf5btJPaoE81yLaMNRt29sP3ySNhKQsj95dogzJHkOm3XJYgTrawYxNs
         eGpmGS7SZGRUYl+kQ5P7uBUmpoqDQoExN0wzPClaJlzoE6Nf/qV+4G2EfJGprdAHsqp8
         94GH87lZr2+AvdRPuLEfvwaPRc6hTCfauvB9Qd6BIr/YPOWuGyzB0aLxRg/pkPsa3S1v
         KVHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHyd/z4vEnynNVaXahkPMboiXkIXBx31G+cuMhEbttiqnRpZqk9dkGvzTxJiclvRSn4qMHc047gjWgx6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLzEPX/Fw1xDgP8mlsF5GrX1XSh0x8k+qseOKxceqGwd1cEvx
	G0vxWrbxS6I1MlGl56SpI7UyWQTvOvkD/d+VOxBevmu8LEqqWIjtbeXYtA9yxP1lfp/n1G+wB+o
	6rXdc4D6psm6v+HvmuRLKPmdlS/nQMsVpQSHUXSCA7adF10jj2U7iSQyfeNM=
X-Google-Smtp-Source: AGHT+IEC5+mGY0Xr1vqRvkCTPSHWrdzVoW0gyIb+l1PlDK52bcDj3mJeKthrwCwcyT9+HpfbFYmRyBqlkI40h/19RzmapLzIzguH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:433:7ec4:4b7b with SMTP id
 e9e14a558f8ab-4337ec45086mr42790115ab.22.1762769343095; Mon, 10 Nov 2025
 02:09:03 -0800 (PST)
Date: Mon, 10 Nov 2025 02:09:03 -0800
In-Reply-To: <20251110-hufen-klang-9cf8ec9dda59@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6911b9bf.a70a0220.22f260.00de.GAE@google.com>
Subject: Re: [syzbot] [lsm?] WARNING in put_cred_rcu
From: syzbot <syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com>
To: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com
Tested-by: syzbot+553c4078ab14e3cf3358@syzkaller.appspotmail.com

Tested on:

commit:         80156be0 ns: fixes for namespace iteration and active ..
git tree:       https://github.com/brauner/linux.git work.namespace-6.19.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=17fc5412580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e31f5f45f87b6763
dashboard link: https://syzkaller.appspot.com/bug?extid=553c4078ab14e3cf3358
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

