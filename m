Return-Path: <linux-kernel+bounces-868342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE048C04FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72DDD4FF065
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50987301463;
	Fri, 24 Oct 2025 08:09:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE72FF175
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293345; cv=none; b=s74GkEV+DsFj2fT+JGsQuqBCaXLCu0kGUZ5CY6Ht07Gg1eNV+2PzGhoKeYJIrW9LuQVBG3uoumAjtEl3SLXqicJB1iNpvkZ+i97ZjRCKUL7QvDcDXipGN6Iksr71EoJRMqwGCZzKpt2c5Ntf8U6dstprFCPQRwV+aX8Gz3DcGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293345; c=relaxed/simple;
	bh=rorKJKCPfDBSTRCdvgITbZ2ychhIA3Rdei6bR0TGFRQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PDm5HPolsZwt7LPs1WCfjs3rykBD21H1gvYyZ36wRh6f0t2BwmTh4gIzZXsLynMKd70cS5fgRVAu+jD0/MstOENjoaxwpn6o7eoWGzLiSickO+DaeGWPHzXy4KDTR3uSLjYr+JiFWrMoXIC8buThwycYjJZcXwzIuyYam7G7Wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430c6b6ce73so49570065ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293343; x=1761898143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpW/02V9RyPlymQ4fgjeVyFanbojHMUkzJcfqiYRnoc=;
        b=eSIeVEKEP5v4Q+lt6lESunH6MX5nebFiIN3gM07PfRidfUsZc0RgEzKVW0yZpUIrq2
         dsrJwB7UbYshbFsFjlaKCpaApJCfph/jC1UZfQLg26IYWh/wG4eUghjNGCcZUGriYS4e
         WjbIK6/qEzQon+0HOAX596hK1F18Hee7xud8OiZiaTjABNPAlSdC1583zH6BEFsId+/S
         txh5v8gNDAIcB2tFEpZYYt9/Onmws36QC7cgrFlO8rZH/r6EVikzwFX7XTVAXG2YaFk7
         CKguiQuUBNGH3g6vtMC604XJbj8ydfLVbal0zRT8f/LhluO6fwI0tuy2AN19LWyUfjm4
         Qjkg==
X-Forwarded-Encrypted: i=1; AJvYcCXS9q1qNcVGP/hMCIGzs5zvtYDzHtnXXp+IciTNpthBdnbcriBVGU57ONaj03/6M0qPiYbt6BKh+sxZpNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLplv8hZy8pCp6oixmW4OdFRJ1h5UqrlNS4AqOBsz7hdImNgo
	+Ny760mHvySar5NiMPH9tDsOge2q96HgXkXjZVh2GEJ2rqpForOmADgnlqouhhuPh6c2urP48qk
	20+6MTdwqdRrGtSAZJ/LEyYdi4/mKGC/pH8qBtR/shhPOpyFfL09hhFy3XGQ=
X-Google-Smtp-Source: AGHT+IG2TL+5ckrgJ/4a4dCGyZwAIM5TTpq3E3YwBP6UcWUDKG0g73Dd+YcCCIi1UHwV6EKgKfuY8mJIDTdOOwlwU5K5WMAg10ca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4506:20b0:430:c8ad:81d3 with SMTP id
 e9e14a558f8ab-430c8ad8410mr319273685ab.30.1761293343617; Fri, 24 Oct 2025
 01:09:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 01:09:03 -0700
In-Reply-To: <20251024071518.JlvGX%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb341f.050a0220.346f24.00b0.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dx_dir_lookup_rec
From: syzbot <syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com
Tested-by: syzbot+30b53487d00b4f7f0922@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=16a3c614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d92b13f7aaac42c
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f28258580000

Note: testing is done by a robot and is best-effort only.

