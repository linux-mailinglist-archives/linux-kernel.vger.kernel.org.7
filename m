Return-Path: <linux-kernel+bounces-840855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 381DBBB5958
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122F7426969
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E9238D42;
	Thu,  2 Oct 2025 23:07:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49892188580
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759446424; cv=none; b=hRKx5aXU7EhaWaLa5eXMSh4AK2a3IRzqbmOQbDg+ZR9TJN1+6TrF33SaSTA4+s2AgS7WsYH2ky2NZDTW4F5QPsKZ6GcaLVBiC89B0ywF9v+ZD5iPhqxbzIsWqn20YJn6d5YMVCM7vMoSvD2mMKInc5Krjofkqc9EKBpwNRKKjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759446424; c=relaxed/simple;
	bh=Z9kkvCO3Fo9CR5hdv/6ab0/Y6/u9Ze9zcu5nUu8ZCP8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dz6b1Rpy2BXnAcsJrRTb1DELfhLlWR5qDeljRPQcfXFqZux8jy8D6RdOSkxmDj45HjNBQ8K0WY2KN/g53y5OLpcJ2D48GFfAeH9avAHsSgWToLLmUrYXw797QXhNKlr2e6OCYMZpgEtS2+tBFNx+5JlW863ctOl+KoOVfkbtFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42d8a33a27aso39904555ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759446422; x=1760051222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwtASbyQEVAWzxL/IcFrhfAs7DM9Iuum6y1AqgrBKOM=;
        b=dq/TNb5QvM/Tx2N0C3bZ5wF5Fz7ZfBQ6gKF1/B9VyfQCNV7hJNxLjgjrkISErfyBc8
         yFedpqsSG+loTnAcFY6Zs3q3+iRQ4Fpv58aoiO0wjnprdNjHa0m5nK8V5z/fYCXzcvHo
         oh55gdF9yt/siT8UmKm27MdQ7RScI41aWJf95u0fygbBxItfxjGFvdHaDS21DpZbQSjh
         63EsTh4e9JyZ08nAZqsL9Y/bLetrzmDivH7h60OtQr7F2RwER1Mwk4I3f4RW2NpMJavQ
         HudtgRDuz8PszA5cvn44gKBgVm6/ujE0HAa86KvYvKD+07uKQCcxDGkY+ZlntxBqRUVV
         aBNA==
X-Gm-Message-State: AOJu0Yy5bNWWfvjVooLYQao1cNlV4XtdXFqaGqoibb471ij3NBVgLB0c
	l+PkcqoIZjOBudRQOcSViZ0Hxdp8niVOMu4W6+FCURXYS++zrVv7xfikuJ4ar5S3jv1IXIDQsaC
	PHqxtZaQl9knEmDz7Pj6kJbsnASzG4rIeM44MZKrJpsEvdVZl6YJOn6ArQCc=
X-Google-Smtp-Source: AGHT+IGQNbStNhr1enXUfRRjd4xmmeiAhRHJ4K/CBulIX8SRELNfp7pIoIxK5Hh8bu4vFAhVO9w7moyNUHunWEM/gxeSX7ghTMow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c247:0:b0:428:7f76:4ec4 with SMTP id
 e9e14a558f8ab-42e7ad6ff73mr11351275ab.16.1759446422353; Thu, 02 Oct 2025
 16:07:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 16:07:02 -0700
In-Reply-To: <CAHjv_atb1zciSTdLViGkwMsEeFTEBSmhYN_0yZn3YZtOUhFzeA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df0596.050a0220.2c17c1.0005.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com

Tested on:

commit:         2213e57a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10fffd04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=714d45b6135c308e
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c51214580000

Note: testing is done by a robot and is best-effort only.

