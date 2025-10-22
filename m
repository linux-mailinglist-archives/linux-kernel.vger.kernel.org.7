Return-Path: <linux-kernel+bounces-865961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FF0BFE6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3013A61A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49896302CD5;
	Wed, 22 Oct 2025 22:33:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A055284672
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172405; cv=none; b=DXsOPJf8+uN6zOBMPcx3WLXK0Ugl0kGSVIs09DW+mi4HVidjNWoQsesTbnPwNsibQ1wOZaw9bdz9YMdTRNsfslPopE7IoFp1kQOkLtQ4BkMyqLN0vFbNMbFWxVHhlOmO+1c9PLWO8ZvYLO9kSMVO4BJr0WRlE8jqOiaP0YljbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172405; c=relaxed/simple;
	bh=FAMtB3pFMDhUAXoN6RwSd3gqtSmMwSBnCumiV1IXSV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ze81g4MpoDeeXkRSNiOBH/D2AjSc540iSnFkRL0LC6str7z5tOA9RdTHBAPUiT9ifrDoQVOIB1jEdckajYkmKWMef+CSdHxDYHGKv3sM4NLkK+NZSVu2B6/t8YLCH8BO8FApftR3SzFXgDugPRL1K4Jzw4tiuduG8y+YXO21BzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so8112505ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172403; x=1761777203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAMtB3pFMDhUAXoN6RwSd3gqtSmMwSBnCumiV1IXSV8=;
        b=J8+ckkrs/BVJ1ar6TUFtf+caCRTvl34+y3PW6gZfrSyGG2wufaQ57yOKtfPugejKBH
         e0ZCcGIMJfI5M4BxRw4wr5eky0IZaqxV3Q8FqC/2XPkfJ6ckDLNjIvFEzj4n6ZTzcGYs
         Lpdr/odGXcRCe38YHdMVA4/XmVOq4Q1TjrEOy2xuZ6JdnAqKk9lOI0ayLBnLkaGPC/4e
         CmiyL3eLGM9zCWomJQCnKBxyrhTjaPcrLHrMfGYXS+3pyZgzrIuOXx2Ydwih5m/PV5qu
         xTjdzYoV9SBgrgsVSs0FxbAXRnItEzuDQESlzWNAJMiUn5uXf23MVHDtgMzNBTA6hBZt
         0EFg==
X-Gm-Message-State: AOJu0YxixYC59YE22GhbKrBr2+CsuWJ8wjKx13r4ivClPYjB5YkoHfVO
	4KxWtwKEA6SNF81dyzjXg1Y6jfBv+WzNcqSIQTNQQXi96NSGbZhs5J1LrvuSafohXwZ+eu1ZwSO
	zPKWUrtLguKn8TU0rk89rdX3WKv9sRHSHBV94158GtafsDwJC++SsnoWN1JQ=
X-Google-Smtp-Source: AGHT+IFb/dIpvOd2pC7orH7dmjr6TmKG61OnmE3nfgeOsN2e1sGpIiqkHcpDu3N72kSGpCQ1NaOlzYBhTXIwl5dx+yCJruLuBZ7N
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:430:a8c5:fdad with SMTP id
 e9e14a558f8ab-431dc139f37mr6478345ab.6.1761172403506; Wed, 22 Oct 2025
 15:33:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:33:23 -0700
In-Reply-To: <68f6a505.050a0220.91a22.0455.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f95bb3.050a0220.346f24.006a.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [gfs2?] general protection fault in gfs2_thaw_freeze_initiator
From: syzbot <syzbot+18b8ec796f5bcc9ea482@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_thaw_freeze_initiator
Author: agruenba@redhat.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
for-next


