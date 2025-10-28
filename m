Return-Path: <linux-kernel+bounces-874827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23646C172B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718D11C2204E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801B42D6E74;
	Tue, 28 Oct 2025 22:18:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D06134F476
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689886; cv=none; b=hf9koPbUWaEqf3g0eVM1s7tQ8hxe+J1MhxExjCY+EAaWb49tOESMtx9ie9L1LxW8Sa3uc8VTvnRRKxzhF5TlFFd1/UH6YRt098CdSDUchvkrXMRdOMjzpxyyXCY3497nxhDgZvaUahBzV/Ju6Ku5JYIgfFtOszhjMZCX2v280UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689886; c=relaxed/simple;
	bh=5QqmVh6B/lxiHwgxtlHDgbI04/psocGPj8eHqNd2xzg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MeIcL5V1CAoQpWYg6K6+Ks/E2xT3AetXqTPreHUZF5LSZQfmY25OIqifZp9ZPmrixvbRYuiYAi8XQupNslbXcxZ2q2IWgsTOgjC/n48nmkdITy5iVV/uCWGvFOO433Tz0OAVOAG40YLqnigvQMBb4EUThigcjWbSsQa7x/ICbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430afceae09so75839945ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761689884; x=1762294684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qj6H6kMVL4WChUArWsziVzi2GVqgIPgNeekVhQMzx5M=;
        b=O0lzTduEaPZrmzAPly7N97aoZTRc5ySXqRG+65e75I8ok/IxJiLs95CpeLszeA8zaM
         jegD45bjs009yqhwMlPF9nmNT9HAnM3x+kpdQC5CaqUscx7dedAbORX7v8Es8MpnT708
         Wu73I++zHBkyp7PbQl0D2AJmqXtYwEG9jjU3NqIRBsw4czxYHQZ6cNJFadtuVsg7rPmy
         16+wPXCM3W+2GewyFzlaRXS4nqOmbmN6KJ4r8l+OzaCDMyUuH6xqdf79kqVF+zJBDuua
         LktN/drkb+gu6s61flETUiGkgQhBhelY9GWQWoiHPtjfUvsdkfCfG3xgvLI8f75edfkZ
         l3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVcgBlQIu4yUITZSffUhP5Zc4tRSHF/brKiVnnHkY3yIV32mpwM8JiPCmV9yt3bT5+Ng7INGvn1353M4iQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0o1haKD3niRW3idxSyoU+4+xXZsMjDix7+ufE2xmaE3RVhSC
	LxLktFFEajYTToX78g/t4orkhLkgYLakyVwwIwRauQK1VcR33DDtIPuOe3HPJcMrlyVZr+yyPWt
	xQoaazFwm55Mq4uxG5WfwQVaWMZO59h868uVx8/Ku2/zBlrFcA1DnuM7rCSs=
X-Google-Smtp-Source: AGHT+IECb9yClNausSKpf5YGhGEphpfa0DaL30psow3IushOaa5ZCPJIR1NxOt8+WH27ajqfVhAthiCN9NnIyQA+eINW7LJlNjVj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:42f:91aa:510b with SMTP id
 e9e14a558f8ab-432f8f9361bmr11469465ab.4.1761689884443; Tue, 28 Oct 2025
 15:18:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:18:04 -0700
In-Reply-To: <20251028182302.s5LSI%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901411c.050a0220.3344a1.03f4.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com
Tested-by: syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf1932580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c2405120cc7eb82
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d84704580000

Note: testing is done by a robot and is best-effort only.

