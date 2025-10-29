Return-Path: <linux-kernel+bounces-876777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF66C1C4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A93E50757C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2B2D63FC;
	Wed, 29 Oct 2025 16:53:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEB138F9C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756784; cv=none; b=Xy74wUVPqJHxFGzVXMnOHKL8cM1hhAU/pBA19cMu9+eu2V7W4fs3mP0+F6KFUuK2gyZ18pmGTGs5Mm7k7JK4A4/+uOKxqcDDr9/E2BA2x695nt4L6wjz3Xh1NIHxsjcGFQHoYShUnZ7cKgZI0asKo+f51KU4gVCr7X8mNn5hnZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756784; c=relaxed/simple;
	bh=tfgOABjWm9SCUcHhaJ+8DmAOrDUg2w4abDXztS+XyE4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XrxnVG4ybdtOLVkncg0QVBmqruc6UOg5mixXEKjdWnFWhvbwUZ/KAAicoDZxNARnOJ6F0jMLziIiYPZCsK2RIrUAUlfhjjEyNuufvtL/0O1vxfVzOEiyFXLF4Jy/D6U6SCve1J1/QVLs4TOBS2vAHVxC7pPIt7LOeHF1qoLAyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c9176acaso1770285ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761756782; x=1762361582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OicD+fqpLpVn41wTNfvd64j8RYgmh1jr+5Q6pOPVfo=;
        b=kdGnTV2HlTMW2Lk0VhwylKv6lJ4RZRgW+Em9+1zVVhbYbZz/OyxamA+uRWUsndBq4E
         EAjJBkfDf46ap6Y5oez8GW751Dm8ar7H5/PVFVxDyu7pSPfMDEadcL11q9TlaOLX8Q3/
         OuQweNEfsHAX8rg+AC+WZ8/Ehz8nly5jPmNpkBj9/0zSUSvLaieO9wPCFF6UtUxhzSiY
         H6Qj61WP4LhU0ON7ITxF76iIZNP2HEpEOZesr5+Z2ZoaLYrWTLFRJ63nK43Qt5tzNhJC
         D23naIij7jaqMffjF7WE91mhCzS0QqyKtTMZs6Ktdg4+dh5lh/Eg9JTdXn6VkblqAaaQ
         UlQA==
X-Forwarded-Encrypted: i=1; AJvYcCUE1CTPUTs92TRNuQC/zs+4gZldvJUMQO19KB3sX6x6ccQjdJ3iOyCQpGXzL4gm8Di/fQRSAAdQomE5YQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgadMMgz18h6PpCFmXF9NMfUwwMTCrLypwtBoDezbFoYQqvfXC
	hYEuaFJKenM52ZfsMNb7dukexElrfUSBwjdY+4f2Gan74JZAQlacBF6oCZqxzi3nwRO0vtIxeNI
	SQijqxx6nGeAYeD95KoJb9mg9D63tW2gbKl2U3sxqZvArvsgZfEx+qRMtM7I=
X-Google-Smtp-Source: AGHT+IELUFfTp2qER7cJfESIPtYFDp2CpyJ6+DEnlQmpLvj4LzMlNjC/Tq9JVse4e+aZGS3eyr5JL8k6tDMBatJQEJ2VrbW417Qf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:3649:0:b0:432:fc40:f323 with SMTP id
 e9e14a558f8ab-433012237c8mr3104855ab.10.1761756782288; Wed, 29 Oct 2025
 09:53:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:53:02 -0700
In-Reply-To: <20251029062744.33bTD%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6902466e.050a0220.32483.0214.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_fault
From: syzbot <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com
Tested-by: syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com

Tested on:

commit:         4408a3d6 Linux 6.12.56
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16c23fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=a49010a0e8fcdeea075f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11059f34580000

Note: testing is done by a robot and is best-effort only.

