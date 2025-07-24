Return-Path: <linux-kernel+bounces-743575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26807B10063
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB54E67E9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 06:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38942066CE;
	Thu, 24 Jul 2025 06:08:58 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3D1EF391
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 06:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337338; cv=none; b=kCOr2ASvI0cLyEVtsbtJ7DZK0djHZJfRWVQ4EF/s1aaPa7HcfQ6KzaAq98OL7jQ9HHsA+8UKIR5Yq+il35ijtsweRqkGThtETUdtfKLtnPtbGqYqHnmbuROukIj7PKD/ij220UwgW3kZEslWYJnFV+CR55q9z7p0FSFbjK4WQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337338; c=relaxed/simple;
	bh=OFKTeQQR7Ob25FU2x0QQRypoM5GpQNimii57zsifmLU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=X74/rGjLhi/pN8CRAbjwBw+Zbtn9aOR/auk+aYDqXdSWgmSOkTeW+QwZRhqFvWUNLkzx/ZYnWxp4oo0JHXdfE1VN2Us4SoKVYzY3WPSDBwg9yeYQbxNLz/HcN3VIyAx0HeTUFIE737L0L/mZ4r8zlhH1IQVf5OjINUfCD03keNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87c41047044so146224239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 23:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337336; x=1753942136;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFKTeQQR7Ob25FU2x0QQRypoM5GpQNimii57zsifmLU=;
        b=v0jw6jXtDjGyLaxFKxgKUKY9ylOdSB40ypDkNWMDerHKyAjbyd1CMewbizbWDdWLZ6
         sqOBAwm1mCpc+de3O0cg7LytXgmdeDzBRxIVdOKoe3XKHjLvt54+YVsCqz4YHX84VqWr
         ugdIqbL2ngcePsfyjMpEMVptgVxiC+uDlp+uMQ9UT5+wwB63ILEEVbvnRaLp1IDFVraW
         ZCdSkSa5Y+30e177sSvOwU3MhHeiaCfWLLqoMNEixIPfvxRD0JsEJ0o9CATmcbDA2Plg
         qVrh80YSHEqaKkm3WKyRKZTPHLn/mSXVkj1Ami5fitMcuwkZshnhgc1s4vQv3D40Pqxh
         E+XQ==
X-Gm-Message-State: AOJu0Yzz8ozerRJvOT7pkTHaA9cqe1FyPO1vtvfkvPcrXUstFn1khucL
	81zP8SsMANZ8gS+VAOuNV7F0EVZSlN/7xPsiFB4q+T4z9a4BWhHRQSP6EORrgOYR6iZSGdrBJIk
	LKkoq91u3s3B4X7aLMak2GxtXwz4YuG1ur01QXqnCx0Hn4553ZqfSuFmZjRg=
X-Google-Smtp-Source: AGHT+IG6ctxVIuRjvjPsXppNQDqYycyJ1Q2IDj7guA86AmQvyOLqO29p624CTqZM+XBVSFAEKMSVDzB3Ah9qZ5bjgy4UR27010VT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6a8a:b0:875:b255:e6af with SMTP id
 ca18e2360f4ac-87c650434a3mr935596239f.10.1753337336014; Wed, 23 Jul 2025
 23:08:56 -0700 (PDT)
Date: Wed, 23 Jul 2025 23:08:55 -0700
In-Reply-To: <CAF3JpA72uvA4=hkHxbGui=2shumVZTSAUmyha_0AAkLmx-xcjg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6881cdf7.a00a0220.2f88df.0011.GAE@google.com>
Subject: Re: [syzbot] [fs?] [wireless?] general protection fault in
 simple_recursive_removal (5)
From: syzbot <syzbot+d6ccd49ae046542a0641@syzkaller.appspotmail.com>
To: moonhee.lee.ca@gmail.com
Cc: linux-kernel@vger.kernel.org, moonhee.lee.ca@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git

want either no args or 2 args (repo, branch), got 1

> main

