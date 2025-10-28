Return-Path: <linux-kernel+bounces-873209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED548C135E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F37564072
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A623823EAB8;
	Tue, 28 Oct 2025 07:49:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDE1E2614
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761637746; cv=none; b=lX63clUWDmGV4+iQKk4iKrNvSuEXYhGFCWr4j0n4pdn1y0jbV6kWZxV8SIaI0r18HFY8X3QdsA35t7XTkalnmmI1Z1MH0vXYVyoAsUF/N0nkaQL+tMdlPluVPkvbEyef0Y9GPD6Ku6ZG0q/ZDHMi3WNSEdSos6OZBmT48mJoqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761637746; c=relaxed/simple;
	bh=WOku76Ozy4VOy+vEQGLHt6QbINTquMKuLzAIb5AnGGU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZVetvLKWCJ1ZjI9Cc3+d8n5WbON7bWnbaOukn2gmRYk0r5T4BwfllRHYgpyVyxxoaiG7k/odSxeLz5CSBB34RwWf9I0R6+Bz579JK+BakdafLhWkhMM9fyfRn1MQ7gj1HBWFSVzb9R/AQ4j3xwp3bqSY5hLCVt+eXgQkS5bqS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431db4650b7so78095015ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761637744; x=1762242544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+2sV0+PakweGHJ8cHVLpT6AoKkt4teywwfFIuJ1p9k=;
        b=LA6DSsiTGcWzsJ6j8gsUWeFyyl9sDHcnlnF/IqLM7OX8K8bpr9y3tw6c9VRxn31mYj
         AA+0KH2GH2jbcYHY8RyMeBzlzFzBIRqRYqFGUIuwWPXzKiHr/apzmS/Aaa+n6YctV9kS
         6gZSAyLjrBRjm25ppFXSSEEpJ+kOaKX5xtZB/Z4JPF4VvZKyeMyIN1GiBG+1GxSbGSyC
         I7HVev7ACKVILU0DTeB89DIgsO0n20i+vQj3l6MDm4fUU5yZ396Q7vAC6KLkvHbu7iMN
         HB7erV+/SbHd8sAv/YWGfYhO0DOu8dWlXuNIg33m5vGKuu66qYraWPs/KsCw5D6rc13L
         XVQw==
X-Forwarded-Encrypted: i=1; AJvYcCVpfBw+TPIPmh4Fo0MrRW6mo2y6rHzHf7CvWtA4Xdcn99efou+Ro02ta+YxhoXz7byFVjdwpfRY0HdHtQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhcIKjCMAsuKpBWDgPb0CfnvMBBd8l7xsRMlRKaWo6Qi/z87Km
	1YGCfFKtosHrAZXJDaX4z3z1GGrYE22o7/6BFgdDW4AOe2JBTwd+WomPRBRqGkUS1IFm36tYbT7
	GDvjGIpBtoqvB3sZjHGB62Ejrfuz/sWqjtUSnSZdeWbwtg9ru1XNJkFLqjLs=
X-Google-Smtp-Source: AGHT+IFcAKKVz9X7gQf8MJaUU1GB9CPQgRphyvpM//HV0VGepFSUuIXYoAlVxva53REWTTmnXl8Nxz/cyD7UGQzLw8BKahfyqZVw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2608:b0:42d:7dea:1e04 with SMTP id
 e9e14a558f8ab-4320f842fe7mr37060215ab.25.1761637744001; Tue, 28 Oct 2025
 00:49:04 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:49:03 -0700
In-Reply-To: <20251028070157.yQX9a%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6900756f.050a0220.32483.0138.GAE@google.com>
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

commit:         fd575722 Merge tag 'sched_ext-for-6.18-rc3-fixes' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=164d832f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cdd0ccb22d6e441
dashboard link: https://syzkaller.appspot.com/bug?extid=77026564530dbc29b854
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152d6258580000

Note: testing is done by a robot and is best-effort only.

