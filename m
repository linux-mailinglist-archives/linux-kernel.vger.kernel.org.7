Return-Path: <linux-kernel+bounces-818553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ABFB59347
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E054D1899B21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A87F30274A;
	Tue, 16 Sep 2025 10:20:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0329E114
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018006; cv=none; b=Et69amCcs/XuzINF0WFyIXO3Cfl55FyuKC6CFMexMUP414+oi+fsCouwf2IdBVREK29Vq+MdAsAuWjVNylbsOYAilDnbysVVCrpwebwfdxjdghw4OZA6qpnwS5wgc6r1lyHIrm/e/XFw/vK8m7K+XTWYyXxynsBnI4iGCHkZD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018006; c=relaxed/simple;
	bh=9wep2Xa4yem/ncItvnA6XXzOYC3HhI5y4ziWijFwdgU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TfCEnWJ4TZoi2YZer7H5fdObwtDPiQEVdHZYdRS1LwDHjQkju1KiHud/JBEk7u3F8rGEfaIZvzTk/3JFd429Y7iS+XVmXSfuV9IrM8x/cd4yShBElWp4tV9Yj3XzMwoS8Tm3smZs1R9Xc0YCjfNYwjXavjfhvphvndDsua5uQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-400bb989b1aso170341835ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758018003; x=1758622803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7c8JkY/GUid1YMVZeWpRbyf0waDEIgonB/zzS7yfMNw=;
        b=GJ9+hFLUnmcwgpiFChVrNyjamhUu6G4JgGrTmb0wIgtU15zBeJYTz3wHbzrjnRxu54
         VjXYHcJVgOZXWjo2GH/Kl8gJBHWzVQcQi9PXa+Pa3rYx7E8w13esWYhbYzVmhUx9m63N
         f5xLOoJJHUjKS9XYZKBeQgfk8LEY7XkNzr0Yn/gCo9uX3kW9RzKp1uHef9lYZJpSIOGt
         zch5rGjbmHRr3vC89J72vWtBfedc5jCW/8ivm9ogQ8xWb77EAzQ6TFBkctDPmG0bbjX+
         qvLm5Y1ONdH5BT4BSAnbUtRiVcuA/Ok57c0vZH/7tvwzIOUgQBThdPYcf5TmBjEXZ2Nn
         lkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdWDQmfnI1nl8B/TLFWkbGXQRkciSH7Iyh1xBr0X9oZln647cHn8E9GoZjHR+CyhRV/tfWadTnobGqQ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJd9XBf8O4fKW4SoGR+UJXqrJDND2MRa9Be6e7qKMkB4s5h6x/
	7QOITkUHQU41OhLCldKTp3x6UH6IXwYPp7x5dpr41R5WzsXl0z+4QlJYQTVOs6qPX0IHgz3VIw7
	5CxwOwVlD86YmJeVfS5GlASKDFBkwUiLmtG5m1ZQ8nUHB3DQ9s+cKJ1pi/PY=
X-Google-Smtp-Source: AGHT+IHPb9dEa2aqys8zPKvutWnrsQsrWSVi/yzmuvFOPlooaZ1Ez4wiwgVNLuay0xMubCLH4nZZGpwr6y9njmTYwk3bpmgPVIbY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c6:b0:424:30f:8e7c with SMTP id
 e9e14a558f8ab-424030f912amr81143825ab.10.1758018003674; Tue, 16 Sep 2025
 03:20:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 03:20:03 -0700
In-Reply-To: <68c85acd.050a0220.2ff435.03a4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c939d3.050a0220.2ff435.03c1.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING in maybe_exit_scc
From: syzbot <syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	henriette.herzog@rub.de, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, luis.gerhorst@fau.de, 
	martin.lau@linux.dev, memxor@gmail.com, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d6f1c85f22534d2d9fea9b32645da19c91ebe7d2
Author: Luis Gerhorst <luis.gerhorst@fau.de>
Date:   Tue Jun 3 21:24:28 2025 +0000

    bpf: Fall back to nospec for Spectre v1

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17753762580000
start commit:   f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f53762580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f53762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3afc814e8df1af64b653
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104a947c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14467b62580000

Reported-by: syzbot+3afc814e8df1af64b653@syzkaller.appspotmail.com
Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

