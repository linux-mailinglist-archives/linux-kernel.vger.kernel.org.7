Return-Path: <linux-kernel+bounces-876050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E31C1A824
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B241A66DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB634DB7E;
	Wed, 29 Oct 2025 12:43:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A72E3AF1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741787; cv=none; b=pV3UX451eDlDk1R8Fq05ZJGSRsp3COvjM/u014yHii5yyE1UkV5URO8AfJ2xPesgBluBdJBSJpiZAmPCiFSMaNu9zE7pGkSJtJydprcDuZS6OjosBZEWC1hif33IXwc7m0Dk1wLXcRTOQdUM9Pdr0qtGnCoPCAbZZzxZZuJv1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741787; c=relaxed/simple;
	bh=IuXwzrlQ+OKm/w2fe0r69WRmc/Qp7Af9V8zRXjm4zfo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jMe28uy94/2Ve4u5ZYObdLd5I0Qsk28KJYJPt1morYc8A9F0bYTexmnN+aq99HPOb9HdXgR6xe464oTmKl76/4P/nmMZS9P22CoRPbKht6lSk7Gb5XNAOaepHdWGdvgtvfK/knyKyn6Hj41U7oCWczw6Q3t4MUwPjQQOKRzAVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e67e2427so97891115ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741784; x=1762346584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lJL5TV/QDmuuXoFS2H2UJcGrCaqoDoVEQE/pDFA20E=;
        b=Vtwfa6BM4DffpnG/5kgfLWAtZ7yuqCBBDlDqWLtlBvH+LCVV9cAnkytTDdCs5e5INN
         sNWnH2T9qNecpc1GkQp3HH4ml8in/uP7hCHV0NPOLhG3/F5GAcEkpBnLkVhPFt1kFJl8
         Kkx5HPxN2HwgDMa9H6gtcDzZ6wE9rOITO2qLlKP0HkKdPB4usJd5wk9sSpP9/B76/0XA
         pA36gsgy5p070EKwEL1Gf2k24skHJxW3nBHmjDG1AKX54rBA7IXHhhqekrfeL3Q4mH75
         iC2b4Osx8Oq9drGfB1iaIpSFLaJiz6+db/61YVmjNxbDmpc1+dnXShRBgxi3R8/qA3rv
         u6AA==
X-Forwarded-Encrypted: i=1; AJvYcCVwLKqwZ5JppYDrxjG64/+8vzuS+00DeQUlXN1e0zINUrjCD7xXdx9f7b8aKIJ5M2+PeZpwHjv15C1Bju8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa6eAJ9RZyi4RcBR0xmefhlGXNMB74MldLgjnfcPuhFiwuEs9B
	0O3C/aAJyGBZvM56YjfVhFs3YM4f/h0mKf0p4k5g+x0F4LfOcgYB0vSRv/tVt6WUWfTmGlVcudt
	aE5l5jrQdoSps5sxJG7DlZGG9iQmw+V+w9iUERun9ewF+DX1IJ41yv/09MEE=
X-Google-Smtp-Source: AGHT+IHQYm0ABVbZSnSjW8hVJpF/tk1xtrjHvJHkFFGBYQsbZ21oFAuwZf53OJ1KNDy7HExknP15+0pZGKWNnJEGY9zajN+T3XnF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2283:b0:430:aedb:3719 with SMTP id
 e9e14a558f8ab-432f8f80fb3mr35930285ab.4.1761741784389; Wed, 29 Oct 2025
 05:43:04 -0700 (PDT)
Date: Wed, 29 Oct 2025 05:43:04 -0700
In-Reply-To: <20251029062544.q4Amh%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69020bd8.050a0220.32483.020d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=15483fe2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e2d28458335b118
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1314bd42580000

Note: testing is done by a robot and is best-effort only.

