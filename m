Return-Path: <linux-kernel+bounces-598268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D33A8443D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8297B0052
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBFC28C5AF;
	Thu, 10 Apr 2025 13:08:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7532857E4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290487; cv=none; b=HGRCSwS4sQ4GeQlASpDkx44oeghAEr8yv1V8nMgB8ORN5WpB/nPH//opgJXKHzccO/SBvml0PfIWBo93FBrt/Bsu206tmso7LN0+AcTPtPQfGIyQoHdIm0HZj6urANNCAfxEgAt3kJYrwc8B74XGMwCV3rW7swCYtTgp7g36jvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290487; c=relaxed/simple;
	bh=JdhG3tTrQJhiNkOCK4idU/+3NMmGue4emBCL5uR6tt4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ufh0u5Q1IPw14n3eiq3iYfDD5euoBt8zoq948VgtZ/2QfrrwIHbO/kWAHM6CmCRDT3J3hnHbOaDAPLUV/dqUUA/Bdf0e+QbTqzMpUL/1Tj0uFD9d5uBuMFFgYi1z+RwZIDJyqQgHWvQkqyOD0hfwMevpf1O1Y32HYQkInNphyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so7989825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 06:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290484; x=1744895284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAM7Rl7gk8QQiNEfx9Z0fnw4DIGYAK6MNq7KFJWljsQ=;
        b=fHxZbKpc4RCfy7ttWoRkmDFQ3Qi9LC6B5wOuFGrvodsz0ClBVSMcYLil5hg573HGUv
         2wFMkW63gDIwNQxT7c9HlyZ+wt9B7JqhyCsxz2is/OFoiSJQh8GeSwFwKM6p0il51gAx
         YXd8UO0S69dzMo9ZWlThugk8pZnxjruv8lDtCxR4Y2smPPHZOwhbmHDmm1rZWSrY7liQ
         6xfGkqUuR3EnLJ1/s0KAXvT42yX++Z7RzY7HaT2GRKgNkpnIKEz0wdu3JNSqOaBlhOTO
         KaxlOrkLK5w2JB9NepplDlB2xD5zglifeOTEOOoFcr8XbUjsaI5988FSrtIBrEpnKIWP
         5GGg==
X-Forwarded-Encrypted: i=1; AJvYcCWB9fH4VKZYsxGSuLBQFg9Ne6xHnh0ZRqEZFHmY7tCN3CrqF1q/ZeqzHcpK0pPDySt42ezHdg7hfmTVhuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK1LoC0AmG606BiVIQFapbKx6jIiVqN7NPrYQAPkZgTaa1kVPl
	Mbje7qBdtMsNs96bSf6Gu1Ks3OJC9w62okrB7TURHqj95keYTzflixp6EwjAzlanfYZQbFGlyjJ
	SbL8vS+/SVp5ESgiuIitb6GKYclak0eWMeEwPKwJiSfRMqIPWREPA11c=
X-Google-Smtp-Source: AGHT+IEv2WwHH7NMuPuERfOghvKzL9goTCJuR5/dwuwfsvYgHOe0pNhL/2YDQF31nOzT+efUZ+iSKzdSlaMaI4aGK/0eWmTNs4O0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:3d5:893a:93ea with SMTP id
 e9e14a558f8ab-3d7e5f728d9mr15715155ab.13.1744290484617; Thu, 10 Apr 2025
 06:08:04 -0700 (PDT)
Date: Thu, 10 Apr 2025 06:08:04 -0700
In-Reply-To: <20250410124124.1189471-1-memxor@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f7c2b4.050a0220.355867.0002.GAE@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in queue_stack_map_push_elem
From: syzbot <syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         e403941b bpf: Convert ringbuf.c to rqspinlock
git tree:       https://github.com/kkdwivedi/linux.git res-lock-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1511f74c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea2b297a0891c87e
dashboard link: https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

