Return-Path: <linux-kernel+bounces-890239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FA1C3F95C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2313B7EDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEA531A803;
	Fri,  7 Nov 2025 10:51:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A531A045
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762512665; cv=none; b=a0pj+o7UVi1zrGbEYEocwquJ97+e973wzXkI/1N87jplbce15ieccUswspxO50kLRfWKh0bguDBIhkt1FufY5upFt9WqQe4P6fhSX9X45jaQulWgcBH5HfsPe0SIfC/hnf8ORIkBKGrcxqsRyRZVZ4vDQE2ZLFA3zZZn4Ni/sS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762512665; c=relaxed/simple;
	bh=I58UenPXXjykTQ/36tsncbMKAPc2wTvR4qjUy6u1prA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BiSL9r1KgyrgdiXUD5WOW8aDpwNWgeH/ZzQI5Wz7k8bS13ln1Sm+ZBmB2zGv7WYG1L7o8X2dq/xKuHwEFlcnA4KyQ5TGw8FZtCf8rjjkgTBkeWsR7SFK4yJuwezQ7fYmKmmJKm0V+Hzi4kd+5mTkEiXWOWnH2Ql7WJngCRu6zLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-43327c30cb1so5367365ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762512663; x=1763117463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3c2rFLlSmZCcmNS8jakqnPK+WyxqUV1vnKCv0Hu/6zw=;
        b=ozwGCrpgjrTqp3Pcg9zzR9cW8wzS9Pf7G5Wg+fdxBtXdJvRnQI+t06Iq0NCbwiyf6m
         fOn+Sa3AA4SPK2tvrekPIjTPzmQRYfhRQtaoSsnpe1tcxRFDCjPp+UXiElfM28QuSfFJ
         ee8oZOtwIaXCP+NejBxoej4ZksD5mgxEJPTUAMPe1qDGIBxyzr51tOO+e0/RiM8TbgMR
         FJhMF4fU27KIUkEgCH5GeNv7zsZO1mgfPjQ4EUqwoS3obPXNaq05p/zEi0FZHTHBrxk/
         +Aj9DNBzKf4Fyth1D+o/sSrIND55+FFYIFNUpo21FqXitGhutAJz2LABIa32FmeEbY35
         OT4w==
X-Gm-Message-State: AOJu0YzEJljJlYXzweN9FElUa9zst5qa08NjnwQOKTMmwbpOejaiibR5
	50b7ya4ubqM58267TELj5IAsZXkW2/OGWovClgDI5VWfJGxrCjDkVV+4xPZo2foHFwkaifVBcE+
	bpXJs2OA+w+jCSouk/NjC4nVKWKaiStq2PvCqqJ2NgTQKtZu0TaTryVBB/3Y=
X-Google-Smtp-Source: AGHT+IG44UtjuJDYWZfpepJnLKxvi9omGcb6k0eHKK1QI5OYHE7WRUa4fw8mfzlF0Q2oI6TOpQkgP4BxAm7P60N57XJnzLh+4gDT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:433:22fc:bb9a with SMTP id
 e9e14a558f8ab-4335f3d327bmr45428055ab.13.1762512662849; Fri, 07 Nov 2025
 02:51:02 -0800 (PST)
Date: Fri, 07 Nov 2025 02:51:02 -0800
In-Reply-To: <13e57b6f-438d-43cc-9ad9-b58da9121d3b@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dcf16.a70a0220.22f260.003a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] BUG: unable to handle kernel paging request in diUpdatePMap
From: syzbot <syzbot+7fc112f7a4a0546731c5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/jfs/jfs_metapage.c
patch: **** malformed patch at line 6: diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c




Tested on:

commit:         dcb6fa37 Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8b659f0cab27b22
dashboard link: https://syzkaller.appspot.com/bug?extid=7fc112f7a4a0546731c5
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1729e17c580000


