Return-Path: <linux-kernel+bounces-864926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E55BFBDF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69294E3B38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3B34166B;
	Wed, 22 Oct 2025 12:35:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F41F2BA4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136508; cv=none; b=CC4ZNBvqj9a7SupwuK/riUtzaMdpcZZwRuEU25v0TwU2CrMahazP0iRokZEgVFu37yp7ye5f/SQJuDFVcbqLvMC5H9eq4t5xrjaTPpBkYkz5NaXixMNZ7ZBE8FQfzy1lT4zLSWld4FU+zsXzw/JxzH2/uOn1jjMFBbIEZiUGXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136508; c=relaxed/simple;
	bh=Yf0j/+qEbrwnwzJDU0rEuCQnUw54MRNdxLQCcnHmg4o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=osNBhC4j5iA5Ep3Gj0i0ETyTsn0nOFLfUgKGkSXbHMMGk3+kMUgezRbUuLvAupiGl43eKN/tqeqsKhiI3WX5IkpJbQfX3RVuJ0NYjcdMrDuTjE7KGcq/IgAzwmap3bSxoQWzC97+IMcYui5UXHQ8d+cmNoyFC3E/LSt0wQNegJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d003e87eso189633055ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136505; x=1761741305;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PV4BZrX3AoRhuqg0dhvxq1dgZwuu8c+iaK6pFWSTu4=;
        b=gVU701tsqKWVbAOJCMEoDbE5fP6XncNRuowOr78NPSULS/jwEPalnHG7t8ZAEGvan+
         pLL3A0nedjitAXpdzrJCsmOBPTo7dDi3T0ikwTcjEXx4Q32798co9FfoUOXD8joIDlti
         MZDM4rkgPLFmpWHYEKUAOXSXWGgf+2iALwJO5rOH53IMz/a/rogyuz/i374XHUFq48fQ
         QxlHbw8y73lC0f1mCkgQN4dOVzents1rDyiIdsHydK/f6195ck53U1SwzfLJF3noGXZ8
         WoVzCxGhT/miMHnYCrMd/7N2BjcYHXUOAFaOU0UWknyg83hMFoZd9EWuf6Ey4WaNlLft
         N84Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+uEufIUYgWOnba5UPHuF+AZVd0pMwvPgOi9yFc8Vt1MrkPHI4PA4KbbqeVTODMuYE+mPdgAyl83aTucA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3MQv6yeWIMqX7CfFqkeJZQ9AHa83ul+SGZfMdnxDjHJXTAtr8
	SPpdSYq23ifPSqUJ9sEj7cj1BXmJJvCqdyj8YNDxZPxeCkX6RWBhOJgLQ2jYK2aVPAm2fZvlU01
	RygeYpvvH7s5pxKrMO0Zg6cc4angMQ1Riw4lGEudajqZxgbnj3JyVpWf6apc=
X-Google-Smtp-Source: AGHT+IEgTgo4V3aD3O77n2yOC4kDVs1bwe9LOksnYqm6TEGTMZia2Q/VyepZFT42cUKwWP5CB/t8JfJYU4myRHs0ItIHm0KMgpzE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2702:b0:430:a8c5:fdb7 with SMTP id
 e9e14a558f8ab-430c52092f0mr310952595ab.3.1761136504739; Wed, 22 Oct 2025
 05:35:04 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:35:04 -0700
In-Reply-To: <20251022121135.b09g-%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8cf78.050a0220.346f24.0049.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in __ocfs2_move_extent
From: syzbot <syzbot+727d161855d11d81e411@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com
Tested-by: syzbot+727d161855d11d81e411@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10b03734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb89820a01e5d251
dashboard link: https://syzkaller.appspot.com/bug?extid=727d161855d11d81e411
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dcf492580000

Note: testing is done by a robot and is best-effort only.

