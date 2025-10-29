Return-Path: <linux-kernel+bounces-875482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97473C1924D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44DDB584F49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECF314D24;
	Wed, 29 Oct 2025 08:22:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AA92DF68
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726125; cv=none; b=sfNcQfJD/iaKmkanVLWhWH6tzIPUwN/JgWD31uGudDwmit8cglJRpvqc4L4AUi3KYAYCcki7eoPwoNVv3Fi1aXI8Wjsyk74i6yCzoHQeRyNm0Yue/ZSexLadxI3Cfw5NiW3ac+8WoabWS0u58crxhWvkUxl8/ZoXolzXN5DsYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726125; c=relaxed/simple;
	bh=hGnLMO4Ejfe2ROb3dj9LkULwUqjgwn6DokHUIBIwEaI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W74NQI14k8it8W8klDjFmZQO1F2tdgXqsydUX0OVsi1yuM6WS7qHE45XHQ91i+4uvvUdkzYqJ+k6f0A1hpJZkocyvmuo2EX/8mNE6RGAHE7hFtsU7e+YRnnNWw3Mhs6fVFYtx5YjxLeBM+amRxPOp43S1RSwGgsiyaP7CLB9KSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c684035eso8819875ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726123; x=1762330923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsL5p8dpWlBLgJ5DSEyO2TC332KM5dBqXBVJ3uDpJ9Y=;
        b=t493G0FE0VQzTSmDHKETp5TxSKZNJrxKIkf7LzoERh/x6WjgyF5vjPNWXjM3yu5Uew
         GUqxBKUNjT+PFEd2y2LFFIS2SKVWWx2qhCb6Bmt5Rsaa6DFNgFmea0EkjVCSReTuVCBH
         5P/LYBatqiK9Qm6fJX17fn24yEyfIaY5O6JHbfy1nOD5qdywevDA3hFg+wgbX0xdPxbL
         eCgNEFvbf0P/rgWpB8AnBQPwecYb6A7w9Zl/ZJbFTv0ELNoOIcvKGrH4nGVy8k1GDoTQ
         bV8AB3aJvWoz2Ba114Dq92+iMX4CHwGOPcWuJdJEq3b45hEntz69og+0BtKLS+xPBBGg
         6Yjw==
X-Forwarded-Encrypted: i=1; AJvYcCXI2ecbSDkoILZvf6kXB667FS5bBy1o02ZN/BfYHatiaG28Qavj/e4NXrqRFe5VKtv2bAfDaPmTeIxmTIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyksia6ZagTGFTvA1cTniozHG+7HiZP/1gAq3vq/pL+1YCdH5jY
	DQBbTdQODOiC/1DRxNKL8B+Lsr2Qu8X9CoTh3Cbzyqz8NhuLrTJtDM/KcNjcpR36c2094khNckv
	G8vAD8RKG1waEeyNvhPdQxtOkVhjjly3wfyeiPeCVZlPirZgn2eGuD+XrwZ0=
X-Google-Smtp-Source: AGHT+IG0K/QjEf+FKduqoOaTZLipgca/lZQnE2YMVgqGlt3bTriUxz/OStrtDeyISdl0soyZzCgdb3nC2CioUzZchTnJzTyuCuh9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2a:b0:430:b2a8:a9eb with SMTP id
 e9e14a558f8ab-432f8d9e806mr27050455ab.1.1761726123599; Wed, 29 Oct 2025
 01:22:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:22:03 -0700
In-Reply-To: <20251029062548.aHv48%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901ceab.050a0220.3344a1.0416.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com
Tested-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=1482bd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c4111dd2cd8811f
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14059f34580000

Note: testing is done by a robot and is best-effort only.

