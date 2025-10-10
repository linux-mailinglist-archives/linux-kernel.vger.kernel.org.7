Return-Path: <linux-kernel+bounces-848169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85265BCCCB5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38A344254CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9408285CBB;
	Fri, 10 Oct 2025 11:44:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220704414
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096693; cv=none; b=eJbI301p4/ipwk2Ckuhs9Iib8r3rtjLzsJHn3bqYH3M/bGIAxslTij+n8xgZgBL8M0ghTaT9YrSWu7qC2NOZQll8O8FBv/SGJqkAtU5kKt2pQp21jGOH8SSe6uvobazF6d5rJXBxzC0O2+xrekXSps2eldLYaudkJf6JPnpTOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096693; c=relaxed/simple;
	bh=TL5jMOTAeFsRvHAwOtmEOLeCIjnhJJpPxhu6/rUezI4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JBMQ4U4kBoze7SwDcf7lQzXIniEkVsUqFS7jQAUP9bmXpvbsRqMCtAwPD4qZ5iCYFIYW18nD75VQAUEpZSW7eK4nQMHNSvKrePnlaOAq7AXeW0yAmz97VGNcDmVtJ2jhKva1dBzxwBDXAIZ/kq+SeBmvOzXkqQAk4eGCdm0yv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42f86e96381so53066575ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 04:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760096691; x=1760701491;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TL5jMOTAeFsRvHAwOtmEOLeCIjnhJJpPxhu6/rUezI4=;
        b=Vx4L7u+2Q1PUcU/LO/TrlLy350mAmq0KWE1bnQfJMjangbRz221jqnGv+5EuelUY0a
         VoZAljX4xB1YuynPpWWnT59VqUbnZZKfMBVG/bJgI6JPAzrP9OiGnHZvNMHppkzB5Pya
         oSqHQgZhkgp2IT4j63Pfqj8ymL9M2owuLqvA1AlDVMaVvIi3m155YvId70WXSrvX74A1
         NgqSpuQOXN4aL0XyvXuL0zxqPaxSSM4GqylITmgdhD+ZBCoK0y4Y/Iz3xqhH4f/x9yCv
         STGh0nvni6a3NhpyuwdK4ETEHBKcHr3a/cLzzzz1Vy3qllNnCm76D678W88YtAEFVJRB
         DXyw==
X-Gm-Message-State: AOJu0YxiC7jf3GV6ApeHGAqvEOPxLG1x6jX8YcEBjD8ZD1I39oNTqkRQ
	b1giqCVtaBYpJziu0kZJexLoIaP4st9qiTMDBTZbpwFQGS3+GBc/ivA284sA7XBslQIigdhC8JY
	MYLkctGV+GVXCqkmN+J9N7D3X/BztGx0aEaq/9eRmFocLjWT1QN2GjFgzAxk=
X-Google-Smtp-Source: AGHT+IFnmW23il90FNDqziOI+7qb5W+bTbzlG6ny95BtM6VSypokNQCCGkW/wKUbpEqQCipshufXzSBe4cGB2buQOUcz5i/SJDU9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:427:b642:235 with SMTP id
 e9e14a558f8ab-42f87374f3bmr115826455ab.10.1760096691193; Fri, 10 Oct 2025
 04:44:51 -0700 (PDT)
Date: Fri, 10 Oct 2025 04:44:51 -0700
In-Reply-To: <67afa060.050a0220.21dd3.0052.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e8f1b3.050a0220.91a22.016a.GAE@google.com>
Subject: Forwarded: UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: UBSAN: shift-out-of-bounds in sg_build_indirect
Author: kshitijvparanjape@gmail.com

#syz test

