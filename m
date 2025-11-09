Return-Path: <linux-kernel+bounces-891860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB71C43AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2DB4E03BB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062E2C21DB;
	Sun,  9 Nov 2025 09:30:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99892C3272
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680609; cv=none; b=c9ej70pMzJU76b1raargUm4NWYugeExeVVC3abGwD7SWbKpnV/nEIozKrBC/14xEpHWu2sRlX/gojIFd/Cs8esR8Vvq0GuryRLB5JLXWP8TVptVk038GtqesKQnJOB2lOAGT71c0S0KSszpQzeTSe6/UUVIuj+ORvKzUDht6oXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680609; c=relaxed/simple;
	bh=MxQRrVQdcmK2NUSJ6VYQtbgmve94X9SD5rPAODhdo64=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HFi+xEzq9AizS5VUbEiHKGLI91Ry/xnicyRJn6H30+ZqJbBigjhZcnyMGDw3QhIGBPyGTdf/Har39LaZcRBqXSu7lowalr82cTL0MStqzUlK/3smvV462sRnb5l3FyT77UYJ0tKsTwyxbnOKRMPJqjtl8nbBdv3YnwFIKgEEIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-433689014feso9911305ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762680606; x=1763285406;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KPWhecvq3F31BPEuZrlwZgCD/Y6HmPhBps01JmYcgn0=;
        b=pmdbW33ie86KwQlXy5Q/ZFFpEZS7Aq1ugnpeHNidymr4j1NKT7FsuDhMbyg4bOwrwY
         iuenjcTz4d8sKUx9ZklzUJJKXXhh0Vmz3HrkhI5+ksblnVRHvj/ZrEdk4H0vIh9pOenq
         5mxlwnpxcp4rQE6XRrPv+q18xF430lvhd4D5Ydtkvy8mC3LIfCI2+4zZsfE4+Wae2Qde
         6256ykf0t2S5LrAWNJUyaTUy1s5VPS9Kfvg+l3WVmIgYVvaK6XZSgJtGjkuLgCWflO8S
         8ltGrA221u1dBF/dgTUrV3lzV0qcaH3ZOXi3S4qB2KjoicHXRb+MBvl2KnU23cJdrJMq
         rZmw==
X-Forwarded-Encrypted: i=1; AJvYcCWpfWhaoXnZxndvZhODmn/X6ANCLyq6h95+mJqn+X8bB7CQO+yv8pEL101S9S9tGwuGnxev7R60K4zxolY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJKZ6R00ceMgUXatInjYWrbgICxYD5oTif4XIx2wGgQJv58il
	/jpnIXv26uAZek6Qm4EGWUrgUgZRhYIffYIEncM0jydrDtwdKSEoZJk6VXtll9Zgb+gzwvs5vo6
	zovev36qxxIqkcMsKtivmcRjU968qeK1bxlfgSHFDLvT8drQEzMcrZOyHbls=
X-Google-Smtp-Source: AGHT+IGRbnZlbGG6egfbjIwVvDWeC17m3BXGEl3TEOOP9KHv+0T4GlG+t5A/cfATFyZvcW4g0P7h5VP6wbxkFyKnqWwCykLwEKSb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:433:3487:ea22 with SMTP id
 e9e14a558f8ab-43367deafd7mr79330055ab.13.1762680605917; Sun, 09 Nov 2025
 01:30:05 -0800 (PST)
Date: Sun, 09 Nov 2025 01:30:02 -0800
In-Reply-To: <20251109090808.839886-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69105f1a.a70a0220.22f260.00a8.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in chown_common
From: syzbot <syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com
Tested-by: syzbot+04c2672c56fbb9401640@syzkaller.appspotmail.com

Tested on:

commit:         439fc29d Merge tag 'drm-fixes-2025-11-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16684b42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929790bc044e87d7
dashboard link: https://syzkaller.appspot.com/bug?extid=04c2672c56fbb9401640
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13418412580000

Note: testing is done by a robot and is best-effort only.

