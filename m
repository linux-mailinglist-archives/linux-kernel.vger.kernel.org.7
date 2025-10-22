Return-Path: <linux-kernel+bounces-864937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C98BFBE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2394084DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0F3128D6;
	Wed, 22 Oct 2025 12:46:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC3328B72
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137168; cv=none; b=ryJqz/5r2kFlR1E/eSkDPp0EPuYpUpFclit+nYrVbyIIDvJYzWf78Qt0GluJB1aHeC+Q16qPbhbPD/LqjOiZ5ogSQlEu1U8Nitt0BgWOpH4YYinQjCYGdq58PdT1fyuH5tDUv4rXysByB5O8Di+IQuR9b0Q9V6O6SMH+F505kCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137168; c=relaxed/simple;
	bh=uYD2epnGfHmcsrCtzKUjpOnxGFZpNjwpseI5tfx0y74=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C7hmXLwsVGuvwuGLvq3/yrk5nxin5FsGn6KraOvJBAF3szc/LXPkQQJQm7lKb32WddqDTEESUk2X33wMIVhAVrA3ImjFTO86T09cKiJtQn5vcbVLPTekWAEBcaqN8BJ1YaM0ciPlcwmuwglzBwf6IIAcLWypWK+BqnTXmGMbMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430c477fe44so72955085ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761137163; x=1761741963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S94NaKR8U+mNnHpDMaxABLmzY6NgKhvMARNG966a4tM=;
        b=CIE+S8VkvTMzolA4wH+W5g+g+tFgIEhhapYhmNaxbPh0yKtUoSAUvRzWQevMaaJs/u
         uA3YHM42c/G/Vyw0hW9CDhFeNEPL6WGjXfL4QzlBQXQ1tDUO3zRaPJUxAX5A5dZWr/Ex
         XDRcWO6VTen3d75RCCTV/1DwxTozWf9lNas/jTmMK6u8rmPIzTwbVsoO8HnMRlTOwFOe
         OpGyluB/IuVpNUqyLpWzGAixwGJ4CcpCfenzQbE6eobei23z8u/0y3qdKnlKypVcTBjf
         LIgqKOM9llwIB60kUO+IEXEzliFU4/dV2h2LMWm2wi48rLl+Xsx09Mp3JoPVzrdRFXkt
         QIMg==
X-Forwarded-Encrypted: i=1; AJvYcCWwxUDyyL2HwyGuDZjit+JMV8VQIz9kYplQVWmSH7R4+awM2AKwRKz/TJh6QFBp3Ky5hhG5M8ulec0Nj5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Eo3oZWOuRZNppSsCv0gghOYHNVwY6uQfFs56FghDMG/5+3Vv
	bqC5jJkZP+B3cNm5WGy0zF/KC4REtriF4terwgYOfNDHr65StviOCc7oYibXXgHj+/7IdBA7c/r
	Leqav3AIGM+ZPx80fZ4hc9lsLlT9P1C3M9rMHwrfWadmgognBSQLYHd4uHDg=
X-Google-Smtp-Source: AGHT+IFqgcZfwwP6ZBnYO9boLIBL1pf0Wy7jfWQtF0LJiBawgzi+mL0rwOJQUI1vfFbF1gzsooTlW0ej8GhAkwmYxu/zOTcoIQiF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:300a:b0:431:d864:364a with SMTP id
 e9e14a558f8ab-431d86438b5mr8572065ab.17.1761137162957; Wed, 22 Oct 2025
 05:46:02 -0700 (PDT)
Date: Wed, 22 Oct 2025 05:46:02 -0700
In-Reply-To: <20251022121312.jibxD%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f8d20a.050a0220.346f24.004b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] UBSAN: array-index-out-of-bounds in ocfs2_block_group_fill
From: syzbot <syzbot+77026564530dbc29b854@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com
Tested-by: syzbot+77026564530dbc29b854@syzkaller.appspotmail.com

Tested on:

commit:         552c5071 Merge tag 'vfio-v6.18-rc3' of https://github...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16944614580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ad7b090a18654a7
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10a44614580000

Note: testing is done by a robot and is best-effort only.

