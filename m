Return-Path: <linux-kernel+bounces-782995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC68B3281F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093C01897D42
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E757B22AE45;
	Sat, 23 Aug 2025 10:07:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7829B0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755943625; cv=none; b=Xo4YWXyrSKfqfi+6SsYZkDasmN06JWPQuRZVT0fJM/QJuVhEfwut7Uq1LGBGISneslOxTV+vorvX9x85gANhEwMrIHX4uA1kEe310a0vlILynHeK3gOsZKHRxzqd18PnXwRKTo2x4Wp4uoVwg+6/wmFgCJcq1zXZ/JydhJXW5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755943625; c=relaxed/simple;
	bh=bqcATWacn6gXzz/X+R4Pk/6HAkxkziZb0XMvvg+XUAU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=if1dU+WyAmsuhnLIzW41QUnWnjdnuZbEOtwX1qvMaAO8wverQ8YF5AzggzvT/umypVMu/bE9DaGpmNZcrHunhRi5ume8kI4urUuc1PtYfRnVhlA8cL/F6/gpn+jkGky1d0siTeS+DcWcz36qVX04iwgWSzJhiebmsABjwO4SNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e911fae022so51839985ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755943623; x=1756548423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g57y+BXiM5Nz6Zfhj6gnwRUDluuGh19e+iCzrzZgOfQ=;
        b=stdh2xzD24E+25tWPyEGDJwYEWfdTiSpDrrSgXJU8wqP9AYveNG4JKdrIzH0U73TKt
         N65hQBO0eRtiEkVt3XbJqU+QTYMIxbyUQHjLaTo91uh9ckqWZMpSKVOaPDzV6/JgnBLV
         10DiwRRNGKq1MUJJfvV9HOASsLSl1mOsEyxTLOMkwkDxv4z7wVDKWiJg5kw7kYk019xE
         VMiQOQq+ckL5MsioaTpw57zmuZgEwUGrlvxYaQUzlxvAVLDVmZabskaHdNGpTs0nOrDE
         ZQxfVhw14DxC+s9DG8ZpAgrIVWA95ZuL1Nrlle6OdvGvuT6CH6x9Qtnt/UeIW3YuNpG9
         PutA==
X-Forwarded-Encrypted: i=1; AJvYcCU4YPtii2KkHG4/hUxRLhJRAqDlMZSZirdhBYeJPzmjJkAOui28+L0q9qbd4GR2BNsqKuENkBKwM7H7RBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKThY+Oz5YQSwdwAWiNrPymEdKD7Ll+lT0pHf/LZaCrmjXYYSl
	dfYIr7diuMrFFaNqCjXU2AD6VaqX4f+iEzxdsWv8zqKMP7zFwXyeiple5tG/mY8fod+6ilfok6M
	1mLpmbmx06/kZcf8L2DIVRCKX3OCGGgDamT0Ll0KqThWPG4S+4ljpwSdE7PM=
X-Google-Smtp-Source: AGHT+IE3skUWEnMKyLZOO8urIqS/9CCXnPLytkg0m6C2twwwl7YxixAzYLgadoNjAO2+nd5UfDj30t+SPhBYCNGRCCWR/vtS0+gx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:170f:b0:3e8:906b:1ece with SMTP id
 e9e14a558f8ab-3e91fb2de2bmr101909455ab.3.1755943623245; Sat, 23 Aug 2025
 03:07:03 -0700 (PDT)
Date: Sat, 23 Aug 2025 03:07:03 -0700
In-Reply-To: <2387bd7a-0abc-4c3a-a547-cdaf101cd555@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a992c7.a00a0220.3557d1.001a.GAE@google.com>
Subject: Re: [syzbot] [erofs?] KASAN: global-out-of-bounds Read in z_erofs_decompress_queue
From: syzbot <syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com
Tested-by: syzbot+5a398eb460ddaa6f242f@syzkaller.appspotmail.com

Tested on:

commit:         e64b452f erofs: fix invalid algorithm for encoded exte..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=13f26a34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=5a398eb460ddaa6f242f
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

