Return-Path: <linux-kernel+bounces-876682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A963C1C03C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697F319C2089
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89350312822;
	Wed, 29 Oct 2025 16:15:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEB345754
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754507; cv=none; b=SvnDYlE9rnS9A7vRt+4y0byxDCVOsD5insZBXMnGhEtPFRvtCQIxyPkSxT/6DHv392OU8sqWI6VVYOIHn/f+B3bZ9H7bxIVw90yApYBpVmNHppJM3CGZ5fNeshFZy4YeusOLxc9V1YHG6kXJeC4ZyGFH2yGGbnR9DXY4Q5oDU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754507; c=relaxed/simple;
	bh=XLJBCvfnU/2+fQa40bmCPt+xP96A+sxD8DPQAK7qr5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mVwvRY3+bIVk2eRQdCnYY892bEmd8qsO6GueFrgEZIxYhBZ0mLL4K0X65SYuGNBQ0qul3M5vCB4KAxZnWAn0k2M/R6kjI/WopWKhWaIRbWByXXIeb6vSbXUC5Su1e79pRs8Qh5REQGUy+th6rMGj2QPCoBcYxddcMYuTzWDCIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c9176acaso1135685ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754504; x=1762359304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbRZdr1gB7riUGYFIHvlkpAaC2FFLvU2w3RLVOpncNM=;
        b=DiubnFZ/HK5yvint3u7h+sWX6RT/smBD7VNh4ncbi5G8tUPkhLeTrMNoCMv/cfYLvB
         d33tdccUReRlgqFwXUAqosBC4h6rIVoonAd1/zYEO6OVcAiZraRQY49P186BamtvP1bv
         MrieOGG7WtNThmlGCIlHfrNIFx5/YQXKGYDtZuNVJEu8s1j/82OmxWoA0PEeHFK1bApY
         XpJBRKPgEAxg2DltLPpmEGgb/1enJNMLJzRI3C6fUxw49d3IBj+eu4RIxZH2bvJnVAPt
         eVx+SKjeecv3L098vJybMZ9j4t7IofHniJ0ElOvPbTOOV85sTXb39YpDzQ+DCZ8cnat3
         DbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAdAzvDfDh8+ce6t+30vMFjpz7zUFvazKbzsXhHoIkz/XMZi+maNMsYLLjYxg09UcwmZ8Kok6Cg8ou9xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRR4RqyxTnRMFWTNr35ipqQsA/+zxyElzM5jyBgYMrds2Ixen
	LqA/CsbwFPL8Iy93THxDXTP+yXbhKNQCJA+ZlXeZRFqHhfI2UZg7yd5sj+doTaJGpyz4he1s2al
	9LzmxIplS0oS+3jETKTc2ljTvXtHP1mNZlWo0sDdTTfFVdcfjXeI8cFwJ/GI=
X-Google-Smtp-Source: AGHT+IGIMr00ayiB6Zl6Egd8G/U5/gZVE8ZQADzywLeF8ddkpGFsbRyrSAMnj8bxahcDDkntQa6t+N43yNxVuhdRhnHSb4QVaY2m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180e:b0:430:db6d:30f8 with SMTP id
 e9e14a558f8ab-433011d47e2mr2592545ab.4.1761754503761; Wed, 29 Oct 2025
 09:15:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:15:03 -0700
In-Reply-To: <20251029062741.5wX4O%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69023d87.050a0220.32483.0213.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_set_new_buffer_uptodate (2)
From: syzbot <syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com
Tested-by: syzbot+7aef76bdb53b83d62a9e@syzkaller.appspotmail.com

Tested on:

commit:         4408a3d6 Linux 6.12.56
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=14310e14580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=7aef76bdb53b83d62a9e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11db6fe2580000

Note: testing is done by a robot and is best-effort only.

