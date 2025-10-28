Return-Path: <linux-kernel+bounces-874673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53FC16D43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED531C23798
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B632D876C;
	Tue, 28 Oct 2025 20:53:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273026C3A5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761684787; cv=none; b=uvGgku0N2la0FjVUoUfyXmjmyPfoecmKlvhlCPh1N+dYkL0TZap24oXUIvhGZHhiYuh1uyqNgb85VorSj/VEFo+LQQ3eMG/W7kh9ATMV2bLp66sF8wbmCFv/GWwmzHFqoZcTXHoMJDRFfGMCPyfWdLsjmbT25Y+JJE2tzT8GXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761684787; c=relaxed/simple;
	bh=cuIRHBk9jiaXkdIt7BPenNALF7hqgODbonkUr579i+M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rI+eJAaTDOSZpDRWvMANBetcWMuyA9MGVMWDgMS7IQHEdHImXtxWUNZN+QPEJcwkgtfJNA86jDNqrGKcvXvcsWRl+I039vsGloU27H2wlqwUKC6Z1jRF157p/5nOoc9KUZZXR559Uhuo0GrrmsPLzb00m3eiuY/6VJA0CRra8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430d83d262fso256185435ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761684784; x=1762289584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXx26fgs/g5IzVz9nkMkva4ddqDOtKiixQUq8uIgCDc=;
        b=QOjrDsxHpoqwtBja1MqbM+BBclxZhXKULSiSb9EEmnGHZ5hBreJrR/eQnKnd5lg7BJ
         WevnJCYDcdIwNV9lrKpUXGdsbwNU472gmUXLZrmn/y9EUkLLD954SX5Z3db8DNEILJ9/
         8yhF2ITmta3/vE5dH9371hXmwBzkZyAnzakElw77dAIYOIIReh47AisEOADVdp2vr1BY
         QL93fIEo7qrmAu7qilM90DNUcRSEdwBtDwpB14UpCuG9J1/u0gssc6hSnTP+Ci6HktEz
         4vxHTnWkhUAFyIhhYcyqRm8LTZe2wu4NMaYtoVWQPFZk7LfAGTZdyLkIfk3PdDqLUh7V
         Z9Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWGvOjUJ+5dqaY5/y6rF3SImrWDCthe/9ZHEbsdsx1jvINd0NFZnVYjUhZlNJzDUVrn5vsh1l9T7zL6sEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxQZ/z0zAkKfdmLJUhWf0DYQCxfjjJTpV7aAIMbDsFqeDus3v
	wsGyF+7vsjG+MXugkj8UX1bk2zIgU/HtVYch4HCvhwF25nqeLBMWs6YpNsIlrSYvGOrto6BiSWH
	7N97YzfLYN8RYtV64XvyBmUoueOHPOEQ993Z6UCk2QEPJMMXyiRlqUZfUxO0=
X-Google-Smtp-Source: AGHT+IHnpaDZRiNT1tyQ1IL0UTXGzE54YP5C3I7bFbmgXP/xPI+pRgcolEjmi1yEwVLZPUztKuMBEPJu6KP/uRirqMoLHxQqw+Bc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:258a:b0:430:b5d2:1a97 with SMTP id
 e9e14a558f8ab-432f90860fcmr7383515ab.27.1761684783900; Tue, 28 Oct 2025
 13:53:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 13:53:03 -0700
In-Reply-To: <20251028182111.sA3bn%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69012d2f.050a0220.3344a1.03eb.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:472:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:487:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:500:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:644:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:657:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:805:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:941:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1028:39: error: expected ';' at end of declaration list


Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ee6932580000


