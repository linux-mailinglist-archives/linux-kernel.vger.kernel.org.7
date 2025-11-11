Return-Path: <linux-kernel+bounces-895007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64943C4CB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603CC4223ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0822F1FF3;
	Tue, 11 Nov 2025 09:31:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAB32F12D9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853464; cv=none; b=deWCjmxc05RpBENx9Cigcgh9HplFNhn88QRJb/JIsoc53RVgo6UwWt1TsiZ8ylkCQssgQSjxSlqWq1xQDckxGouJ50Qyz4yZydV6RVPmVc0kWAFx/8bWoaR9ZZJ+lOwJUw+O2Za/iJmUf2d96jr5PnyKdYVsqfI/5YeowmViIgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853464; c=relaxed/simple;
	bh=Y6icNS0enP4Futo76bokaCirVhEX/sPcgJHr1uaOr+s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kbHyqbKCXFl7esED5p4k5yyvFIhVhaUUeGJ6mG6HIhY7iPWPelKdF4YpOdX5QxHpt0lpwVuYwbPYd85p28s3Lu2b5OTWu/uJZm53hGprui8kfWIt67j8dP/xTLbc8viLgpArcXDwFAhNEZuc3fnN1Akf0h9nL8C6vkJ3W/uCF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-948bf83a707so2731539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853462; x=1763458262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sI4tqzwWKxYYCaEx+/dzCMmBwjH59LLH/ABS+K1m3GQ=;
        b=jkZmLW0496zjQ4875ND3W12TL8h0O+jldAXPb5XXdO/Ybw+ONOS55o0uk3cV1M8aTb
         S5rzP6dfdOiB+7RRQgAOm3y1naeVt0ynrRlEhvfONwIl46l8bJl7HQLTRLfP6H/Xc1vb
         IrIkj+4FavPv36Xy/NnODwH+qaIZhuFAGEhEYPMp/dCvp7LIkp0SNrirYtusACBGCcVj
         64P+j4iCTk41AESNPcp18vfXVsLEpi+F9P99DAkTe+15BmFvTH+benIrNqyu7fYq5Msr
         NBhFAyxudb3Z4Itn4jxh4lJIyXXLSpafSa9sjSxFRqqrDaZpmJKaFUYzM5glm2x0VEKo
         iz8g==
X-Forwarded-Encrypted: i=1; AJvYcCVa842RQzFDWevU3P1iE01EegsOZs0NVa6MmCCO3CkBTuby66B7305l/5DmrmMJ4z9ouhqfg2yYj53y7qM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIs9xugbZWzsCQpnV3bHmjl1WyEHfOoPxaYtBsuIdxnTKFpZaM
	LlYaTZxcnLAdSfaNtw1ZhM8mj1PyzfjiHOjxx6S2U4+8r0xouwmX/p00ntt3dl4bvuUudtjLP8A
	Wnj6fPscTXV3UAg5fF7Rq1fhsBV+4C57VTMSt3X8agesRteah9Wg/WNQSH+k=
X-Google-Smtp-Source: AGHT+IE6RpcZ/R5cig2gmWlq5MhiK2B0wT2WSYnM44Ls0SP23m6/df7vrDkDcXasvJGCTVyo6PfZN2uQlmmdYQd9NJZmcQp+Am0Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1806:b0:433:30e0:6f68 with SMTP id
 e9e14a558f8ab-43367e5a614mr127640895ab.24.1762853461982; Tue, 11 Nov 2025
 01:31:01 -0800 (PST)
Date: Tue, 11 Nov 2025 01:31:01 -0800
In-Reply-To: <000000000000bfd7970619112bec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69130255.a70a0220.22f260.012f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in __bch2_truncate_folio
From: syzbot <syzbot+3d11e35eeafe176a6c5b@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2744e5c9eb1a1090b5f61c955e934c70bfe6b04c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Dec 27 23:31:46 2023 +0000

    bcachefs: KEY_TYPE_accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d40212580000
start commit:   b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=713476114e57eef3
dashboard link: https://syzkaller.appspot.com/bug?extid=3d11e35eeafe176a6c5b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c2ef84980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a1592980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: KEY_TYPE_accounting

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

