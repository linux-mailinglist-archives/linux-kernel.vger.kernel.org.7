Return-Path: <linux-kernel+bounces-813162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F52B5415C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34491C8266F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BCE1DDC2A;
	Fri, 12 Sep 2025 04:05:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334E175A5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649904; cv=none; b=hv79FolkODT3vVzQy3R/KZ2LJyjvDZKunKm1n+OK+oYnxENlPxSGFXr8v/PG+7V+yHgJgxbypOsuI4QQW+PAGnvZyZLXiBj+eOH/pe0Z5tCrnju2f4p59QGCZwAmsztTNUSlW4Qy/BX1gSnmAvoF8P3FD3UkT2pMV0slQvQKNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649904; c=relaxed/simple;
	bh=+JGzhrBZAujlsghefMnRU8pHvw28TwMMdyWH4AK19Dg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T8SVEQ0LxYPI215oxZLJ2FC2isvSd//o6wG0qhW0z+ZkmkUCwnh7g0hzprC8iTT9nJ1cWiSKWJMxEWInE20V/Tl9hBjsC/JtwTgo5BeFJq7VmzL6wgFZcdytjEAO1vx6h8H+YRKX7E1bnbq/kRvtCdc50p9o8ZMNJYlbHxhINXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8875a8663d0so161735339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757649902; x=1758254702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xez4JXkzssMHMXUOts4YL36GvIfgCpJod2HTcx12PJQ=;
        b=X7oVhqSsGZ6ETP4LZVyCfod7ggWDs/+/1uvT5z6b+cXGoyjqsQp7H6kzmf9rFWZlls
         ci91PfnvJIZuMEBRyM6SyTe+U9fk/q8aib+71XTG1NhQSHz7Fk5zUkU+1iaNWH3Bg7q9
         duIXLG2WfN199toPtVQSXnJIx/daLzdd0hHvNuQy7V9iA3oquJCUlk4vtWddbe+sQABe
         LnjCq4LMuWGi9xPw4scM0daPH+ZQ7IsS/lePi27YdlyJev6GWQex/BLNSJtZB4IUNa0O
         Wgf4LG2/2mWkFK8IkFPt9vvREwPgP3eJi8OOGpJld0ECBqgBurlhl5y5Q34UFakb7993
         TJog==
X-Forwarded-Encrypted: i=1; AJvYcCUI2Xm6LJs5F79e7tWl/f31wMZxRW3MTvDYLMx+ikPTH+737bRoFR+QC6RC9Idm0LZtFdxLbKPEPQMCNfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVGRfiRKE6Zz39D4lGgOFvegTGd8uWPL93xmr9qOxuKlCfVry
	yv8IZtr9IC1azWogVi4sPeZM1aAkkNzBAyoo572gkRy4ulcNLZOqsTVqanVkR2GAbBm/sYeTNO/
	rDcfL4QLhSF7knIDJY8smp4UOL7YSZxxrG66aGPkq8gEeygTG3YgLI0yHY+I=
X-Google-Smtp-Source: AGHT+IEAaOWxFkOZCA7HHXDGfEiEExHLDiT8g1v0UrYwKyoMDROM/DNLAxD5+xcfbfJdo6WFwdk8NHWUnqDD7mGSP3uJxWSq+MuQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b03:b0:419:b24f:30e with SMTP id
 e9e14a558f8ab-4209ecfcd62mr29863295ab.10.1757649902512; Thu, 11 Sep 2025
 21:05:02 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:05:02 -0700
In-Reply-To: <20250912033912.6788-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c39bee.050a0220.3c6139.0048.GAE@google.com>
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
From: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

mm/slub.c:3960:27: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]


Tested on:

commit:         8f21d9da Add linux-next specific files for 20250911
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168ba362580000


