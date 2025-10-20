Return-Path: <linux-kernel+bounces-860613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA24BF0824
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C94F17A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEAB2EBB8A;
	Mon, 20 Oct 2025 10:20:46 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D61D618C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955645; cv=none; b=q1zvLHr3pjhec93Eftf3qAwmtXKIda+NWqepMhT6wxVe7Yq+fqj154W/lfIMB+1Mw//kUdA0m2800DEIne20/bV7vTKu4d4IUPs5jY9yFtxwH7QxrBAOUxxypKHyGidFUXhd6/35WueIOaKT4Cb+q7tPI3hdhyPLHfZuO2dia5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955645; c=relaxed/simple;
	bh=q8iTwWxV6aAGQRZoQ5GTvOeC/Ir3MLyotU2BKkvhx64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqAxIvmz+8dQT2OugMef4YZh4AdUENLErzsBlk3uRtnBGbhe6QGP6y0KFpwC3axfL7HQGNylpe+lvJI6GV8JsoroaBuSxdBRN1hY1hWiqM3GHNm2u1n+HinM/HVSvGgoru3x97tNRkQlwD9fwxDnjQQQllLRCyEY6j/Wt9Oa800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e7ff77197so904060239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955643; x=1761560443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8iTwWxV6aAGQRZoQ5GTvOeC/Ir3MLyotU2BKkvhx64=;
        b=kqo3uVpT9h4kFhJOfEAseSvodatkI9EfBfctGj31+wNtsbM9ZT3TVIbbwISKeIE+wz
         NP0jX0sdWOYJzkt02lVcdtCjcL9w7reXJ6DMwyM3yrlXh5TKvaamwSb5O3Retk6+4z+7
         gz9Iy1HJiIZYTtfaKu9EaR31ODDSkktNVhZezAwolp+taXQarrEjVFzxaRlIo1lzjVvo
         077mzNifZuX10hgb5+2vzyHXKdh1iS2I0S5moVCTUOc3ZvKxLzzgwOgF0GMV/SN5amGJ
         Wsyjq8kNdUKz6gjASBNx5lEwrcZ3gJ5K+nF9wWQnn09o+7u+VKM76usbi8W8fLX9B11c
         9trQ==
X-Gm-Message-State: AOJu0Yw537iffoPKpD0fIE3sks5vy2FwbtYj3VbQ+USDlP8jxluGdoVk
	YsjnbbSKzGrdnusYxC3bQ/9rC8Pef+8sUwOjsqAA428mlrMvaFGJv+UM0tCHXQf9EAipmqZwdbi
	uNVNA5YFy3hdEgwETNTnqN1wPCNRmCfVbwXnPpQDdZuilRg0pJZwictdXsYo=
X-Google-Smtp-Source: AGHT+IHuf2EFSoC8LB6lhBv3R6MNKxYBmU40EZcbDU5Uhkks6BpxFoekKSE4t/5hnbQE46pwm4dzYRdSeBd11LfMfO7m+3eFTtI/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13d2:b0:940:d275:fe17 with SMTP id
 ca18e2360f4ac-940d276002bmr758843739f.4.1760955643214; Mon, 20 Oct 2025
 03:20:43 -0700 (PDT)
Date: Mon, 20 Oct 2025 03:20:43 -0700
In-Reply-To: <66f86aaa.050a0220.4a974.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f60cfb.050a0220.91a22.0442.GAE@google.com>
Subject: Forwarded: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 211ddde0823f1442e4ad052a2f30f050145ccada
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 211ddde0823f1442e4ad052a2f30f050145ccada
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 211ddde0823f1442e4ad052a2f30f050145ccada

