Return-Path: <linux-kernel+bounces-891144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E3AC41F20
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CD253B7BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D062130FF3C;
	Fri,  7 Nov 2025 23:24:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C932F0678
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762557845; cv=none; b=FQEhPqQrhLyvn11f29qjcPMsqWmFyB1lZLl2fKTHDXNsxKr5NucoSVl+7lzHDL0w6if42CpphdIDgT9YvNZp1iPIeYl/iLK6FrbA6sEaHGsdGa7Ak3Bn4xhTu07AAwnFvLb7LEDqhdkBpyKeck1MRIHslM+GPmLJ6P7oB9E+7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762557845; c=relaxed/simple;
	bh=waTYczCQEgp17pu5N8pY2p4t7LpMf8ihAJm6REHY4gs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f4fa/efaeKR1/Za77qal/4zUyF0tKInxIA5lYuu2lbbF0bU6BfTuc8Tsu0GSgzVRIKSQTJGDYL98TgtCM03KQ8uC2pe3h/MuOjFysVBZb6XaS8xYNxMREqDFRMBHOQE5Q0bhwiGs+JpdSXOKF2q6bdNlSE8BaOH8l/6cpfSCPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-43335646758so15028875ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 15:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762557843; x=1763162643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fzLpJRcmjKGxH9fQR+AOad1wVu2LzjX8BEl1l90zEM=;
        b=w1oQQGCjA9KfJMWiT6qLW/BXK4iDO6NMq2a8UWvzl5wnXH/7xTswQ9UVtGZEYztW78
         yw1TUIEvq7pRQEb8i9D2Srm/21GOdNiR+IG4JC00Dw+jKqglgZeHKpBhTp86e6A4Dyvh
         v1N1wQzN5qSxPxu7wSw0hUrAS08OG/meKvxGgLHRUTXgUNpAl5Zhh5rbAX2SMvtC8jii
         /2SheatvEE2WTFEYCNNF3iWD2K9pZFJ9dWFCH3SUcNHp8arTP+z54vr7aJKIkO3xrU4c
         Os0QPquTENUMpEn3ZVIkx5V/qXakIQgY7V8HYMirA7shPFv7TPkNGL7DdXpukvADWuZr
         OGGg==
X-Forwarded-Encrypted: i=1; AJvYcCWp7441FfuLr70fje7OvEpZZY+Cc2WDmA1kYJfto0DvxuWNQZLiutQmsyFL34OvYmqHW30mWYYijaTryrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydu2gT3HYnNJFeibEsjaXmEyN4y62i2JXrgtAyF50l/MLPdk1a
	KazMel7EKgPhfZnEgrZnbw6X6XVTql2BujFi+lTa4y1fzNwzhHCggX7Wn2eb3e9wojF7SC3s69i
	hkJ6z1JXcLmDvvGVAMgmLk2oyoanWC1x+5YK1SBWe6VEgsPgUmhxrHzQlxTc=
X-Google-Smtp-Source: AGHT+IGV0J6I+DXJpQfF6fhES1GNQ/0RgjaURIuPZSNGK8AGa3ZXgVse0VcqsgsbPM/KO2jufdcsY4DjyxH+Xk1q19cuIKHo/m5L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:433:306e:2c83 with SMTP id
 e9e14a558f8ab-43367e6744dmr15574045ab.28.1762557843164; Fri, 07 Nov 2025
 15:24:03 -0800 (PST)
Date: Fri, 07 Nov 2025 15:24:03 -0800
In-Reply-To: <68ac2451.050a0220.37038e.008b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e7f93.a70a0220.22f260.006a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-out-of-bounds Read in igrab
From: syzbot <syzbot+a77d690840e60bc2ddd8@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmantipov@yandex.ru, heming.zhao@suse.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	mark@fasheh.com, ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fe7a283b39160153b6d1bd7f61b0a9d5d44987a8
Author: Dmitry Antipov <dmantipov@yandex.ru>
Date:   Tue Aug 26 09:51:06 2025 +0000

    ocfs2: add suballoc slot check in ocfs2_validate_inode_block()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c14412580000
start commit:   6debb6904172 Merge tag 'drm-fixes-2025-08-23-1' of https:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1e1566c7726877e
dashboard link: https://syzkaller.appspot.com/bug?extid=a77d690840e60bc2ddd8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1248cc42580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: add suballoc slot check in ocfs2_validate_inode_block()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

