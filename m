Return-Path: <linux-kernel+bounces-864999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7D1BFC0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F362503E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5EE340277;
	Wed, 22 Oct 2025 12:55:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B63446B2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137707; cv=none; b=Psc4occ4J4lJ3BGNufgT9krQ2gHAoGGZ7xY3Cfk/E2AsYmvfvBkgofkYLuXRgvW5EitiXSIQ3SP6CqWe+S4suTQF4B1dguo5rgOfK2zdUdYO+0kAmvkFvJ/xYKnIMg/jTvFsfwEK03ggTxrEu2oEtqPgZKXZu7zKAd6iWSVEMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137707; c=relaxed/simple;
	bh=JZjb0uLnZO8F6y9uQPm0t/r0kBPRsP5YmovYw7pgjHA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WthhcFvUNVRE5OYKT9buIMZY866sbw0g6UsU4O/6XCiLBHMXpgix5Vk9sIKC4SHK8bQ+CouCiRrlKlIc27cMppledG5jZ4utj9vI1wFPWy/+nBTLMcZEqTzw+jLaVZopegdreDl+pf3z/UUKHM34Mkagz9/X8hfYbOwpacc50is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430e67e2427so36384085ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137703; x=1761742503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2l86WK2Aj5HQTfvqKxGfOtxnDihKE2nJ2wMAw8WQ3H8=;
        b=cRNCV+crtJTu4WHJURvYCvjd8d4gDQ94MMglmvHJnC2WUXAPmPgtpb+jNEUzvnM8UK
         +hNsX4eco0whC/VLro80o2fHKg0Q9Rxcs5835BmekJ0G68eM0OP2W9+jhmmJQacHTyZr
         ABpSDJjdf7CytUeOrTAtwQkHtDvjBcDPpzdsNRurL3cIMc7O7inA3JAp+Fa6Tg3Jeqj/
         FjB7Xj4nK4v/PHYOJEENsd8kBk3htyIk6EQ3BJpMOPg8p79GuRRyxGyQVsH9s8BsDMGh
         Fh6wjKY7WEYtI/fR5s/Yy2gyY1ljufVevNo30jUdy/4V/buO9HmMqEhuF4mNCPRknU0j
         q7JA==
X-Forwarded-Encrypted: i=1; AJvYcCVwU5glh85w9tfR7N2c36Nq1GQb4TQQNoqzyXrJUNyS5O6XlUZpWnNpjC7X4++0YZ7CWmQlHoWH9AJMfME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYYKAqkLMjipTQ/Q/0lpCjpKNh345ruF0tDuvSDa+FITNw6no
	RjuPip5g76v5xkQ8EQcaoab4no3lnXYTjMFkyXe/9dPELcJpzMbIM8ditpBAYfNowh0DdDtrX7A
	9SyPlK6Tt5ewEzbwu+Mg4pHqjQVQLDqUYGp1JTU0W9n0p3zNV11c1uZYq7x8=
X-Google-Smtp-Source: AGHT+IHTRmSwuG0V0hOekotFvM+mzhSta24vDYS0ArC/cKXplBDlJJ0llHUuJ/uZIJkl6AzH+8FX4DXatybWrcJWkdKQ4fKS/sSF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:424:1774:6915 with SMTP id
 e9e14a558f8ab-430c521f957mr236563665ab.8.1761137703061; Wed, 22 Oct 2025
 05:55:03 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:55:03 -0700
In-Reply-To: <20251022121231.xCumE%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8d427.a70a0220.3bf6c6.0018.GAE@google.com>
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

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11ce9b04580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb89820a01e5d251
dashboard link: https://syzkaller.appspot.com/bug?extid=30b53487d00b4f7f0922
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c2ce7c580000

Note: testing is done by a robot and is best-effort only.

