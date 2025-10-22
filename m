Return-Path: <linux-kernel+bounces-865095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A9BFC3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343EC6254E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A9C348876;
	Wed, 22 Oct 2025 13:35:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090326ED33
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140110; cv=none; b=Vc/8i93cHNZQOQAsDrAMcd27RC31PrVOAcZ9B9WTWalMsU116iQwPHaZdaf7kCTW6APATCu7wmFGPo4sDeKTXp8hmsGti6RYqa5PY19uOAQYT/q+Ghw9OCpDRmow4wbrilavPbuhQEuO/S7SYa9RFo+XOYYszR4g6Fif4Z8w7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140110; c=relaxed/simple;
	bh=lK/Vo/VU0SMszuYMfYx3kvgwpAW/LqkuNrzRkrjoB3w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C72DOrkGHbSx41XvP/l6ES9o8rG9d13vR2MYkLfxYvhSXtsy0bRJLF0EbyqqHx5wpeMS45E4F5C2KJcuZ6/Jxlw6q5tinSOF46905zpbZgTB+8OYdACLr1KdMtIAWfStfb0kg/c7lYmsV+QjbbLuDakv//Aw/3Q3SeLo73Qpn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c684035eso10632645ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140108; x=1761744908;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhLhmED7VJFSgoGUHqQHvaS/w8sblzEDPQPMhzB03NU=;
        b=wa+MzpeIwHPaKC/IQ1Uf5oKIGRrAc4gdwb1uPTl/0592gJhQnCU5y/gLAlUk0kGL9Z
         LmTTkkn//qKfO3aP+WUZ+1/Ii+P04zK5su6+uJTuoDglFraD7uZLUuReYkS+LJcqxxuh
         Vb3Tsb+ZCwmgFB5LSYjMCfshwO+jmGdqs+Ti8KfOTvrHi5hXw7PZh2Tpet1iDtHlt834
         XPT0v8EhR0ENE6S3mGT8aYW2pIn/cAPa7h21sNvacGrhotFCVEkvgXYjTeyjm0s2yvLt
         AoLXU5GzEQLczz4NtPprqaJItjJJ0DahtqearXQFvD7TF0eJ/64AWuSWxjfszc6ji6Su
         daWA==
X-Forwarded-Encrypted: i=1; AJvYcCUD0XuLQEHsMtoy+rSTVJAIUPQyq1R/JfQBT59GgClOKNFLbMyttPfUTXPsM5HwpIVH6VAIQZCFxy1M2Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJgtC8lXKaxSY8DQ0oDu+EztsKd7S9XSm6ncLPYxcdUFtSJ2I
	n1AEBc+sDQeq8wIy0tYqu+eVrvzXKmTjOsarXqVqdF/GX1C2eA5YXLzupv4Bb8upGGGrt8FNvLR
	IZkMx2a/Qe9j1QyyGovDvR/bl3eDt8xEd4i2GYaL1Qfe6V3WAZgVUdPhUrjQ=
X-Google-Smtp-Source: AGHT+IEuEn/CCiiPcKzIdHjrrW0t8839edBXUgPcOe2tja6La+jcFki+Jz3/kvihYUWBMUDtQTtA++P8xc3oZilnioaB9CUhcAaH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:424:805a:be98 with SMTP id
 e9e14a558f8ab-431d31b765emr36466015ab.9.1761140108180; Wed, 22 Oct 2025
 06:35:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 06:35:08 -0700
In-Reply-To: <20251022121340.cwsPi%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8dd8c.a70a0220.3bf6c6.001a.GAE@google.com>
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

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12f12d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb89820a01e5d251
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156ce3e2580000

Note: testing is done by a robot and is best-effort only.

