Return-Path: <linux-kernel+bounces-874536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01383C16888
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2824A1C21FED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A27434F47D;
	Tue, 28 Oct 2025 18:45:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D734F46F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761677106; cv=none; b=AatxZXycNXuz98AZYL5ZV+/IT39X0XQ0s4tqGXoDvr5pM6FKSRRIA+wOpEeJ3ofc646MDNKYkRyJxm17Rbhj6uLtfacSXwbev//CYwkdgJ5N8pl3Ku8K2gsEcknDcIe54H+pTHR8ze17KhcoYJBZpLyOr80fHJKyMHABntftn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761677106; c=relaxed/simple;
	bh=nsoffu1aOeJCq1kg19pytjZNUvL0rohP8CRVLRui/SE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HQDx/alXuadHRszPzGnUW1jd1sYirtimMaPGLhum6U0yTE6DvQRj/i/CGZU4DhUqoOLzzxSiyTHojVeVgaA8A6OIFDV1Pfo11ZDzJ1yuC7IgpOMUaxNBhcrC2QcWOUnI9iOEw0BuxwbdMQEi199uoU6cT+6QbKzLn05plb9Xm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945c705df24so30071239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761677104; x=1762281904;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yO0KNuzqGHstmx2W835CxxpqpvqdYc61p4t+wcqE9g=;
        b=fKr6VCEd4ZU3vKB+TpWrf/Gsyg9d+JDnsVpvy4ueZxIRu0jrT47hJIj64uA8tNXDD/
         we9ELQejS1idMKkJw13bwCsNRDdYP92weTta8IKJqQTpIv8QQCBuHcUSuPVWmYsZ5dd8
         j4MRJMcbpNA6uTYlZFKBBcg73huEIEbrXztFWjMtHMWTAutFPRBDUIlHB4eOVo6HsHiH
         SbOvHWhvV39nrtoL/Zry0M4A7L/PhDwi/QrFLiV8cfZf6yarMG+BJfTWi2JpQGm8cxaD
         DEKY/0PKVYGmd7+O/Jkf8o0l6E6JcHegMQW7GnOVX8e686sGhmL+A11lpNUQtxg36z88
         C9FQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5TlTG1cLI4eOt27eD/Z+9MINFtL98LNCQwhbYPeTUJMcwIQVwI2nbbcTifTUjmg0KUS6FVWk0GnXQMu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyulzJf4mWuIpLrymA53AD0mLqbYyIGG4UECqZji5jqXtw7Y//X
	cPYU9BEqTchUv78efFT590jK3eUJUuqBvmqaSqNjpevDE/pulLABKUXRww0DM67rUEWHjKAl/hb
	gwF7rbDCE3b1jLECWoiGm+Pz+6MyWwqxlxVwDKQd/KEZQYOIqhjb7RMSY5B0=
X-Google-Smtp-Source: AGHT+IE+eS2rjsmiOCn4SugH8rC1Pu8co9lT/4vMVUu3t6T/FMKaZ76uaYNNAvQj3cvcfd2As1vEbNgMn5878dPQNy+3Dz/1Kbh9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3e8e:b0:430:afae:fe24 with SMTP id
 e9e14a558f8ab-432f8de6605mr3926485ab.8.1761677104144; Tue, 28 Oct 2025
 11:45:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 11:45:04 -0700
In-Reply-To: <20251028181940.ToDVf%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69010f30.050a0220.3344a1.03d9.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_prepare_dir_for_insert
 (2)
From: syzbot <syzbot+ded9116588a7b73c34bc@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ocfs2/ocfs2_fs.h:474:40: error: expected ';' at end of declaration list
      fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:502:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:489:40: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:646:26: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:659:16: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:807:37: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:943:43: error: expected ';' at end of declaration list
fs/ocfs2/ocfs2_fs.h:1030:39: error: expected ';' at end of declaration list
:646:26: error: expected ';' at end of declaration list


Tested on:

commit:         d3d0b4e2 Linux 5.10.245
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=73696606574e3967
dashboard link: https://syzkaller.appspot.com/bug?extid=ded9116588a7b73c34bc
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101d3614580000


