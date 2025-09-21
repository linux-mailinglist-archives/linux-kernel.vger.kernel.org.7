Return-Path: <linux-kernel+bounces-826147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44BB8DA5D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD3D04E0F0D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200252C0F60;
	Sun, 21 Sep 2025 11:40:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464631DFF7
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758454805; cv=none; b=mLtbc8yZLJ5FLeohn9Jc9TZz09rHL4Ebpd3V+n5kUTUY/9Yhv9Fgpiv8VIf2r8xq8aH2enmxZhp8B0KkQRxTLnKCLb1WWuowEwOvBzO+Mr77ZZAd1qFw6G55EKjMxtviq1eHaXKZ0Oh+xJGwLJH0wEosqlCU76PWGQ1Nt8EsZkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758454805; c=relaxed/simple;
	bh=2j9ic3I7kw2JVIDds/0JGrX5w9vZa5podp1+K1aNMK0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NBBuVON1B2jroc6IhHGMIjSc8q034hxJ2Yhni39MsTgeR0fCFP24AAG7E/bzaqxSVQ66uibWm3rhsHRY629+WOceFJjMvzsP2d8VAH8281RtFCNTMxTHt377UhbjRKMaw1tQiKGe8wzROI7YQLmIDTSRbIpvBB/16W3mZp5vYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-4241c41110eso82039895ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 04:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758454803; x=1759059603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKwTtye9EhEeRsh8asAO5p9oyWCZKPna8mDfbb+PWTQ=;
        b=iuefv8w2Sh9s9e+CxODd+0YLMNZxH9v6ljQhEmTj9pKCi21xLH+Sn5RYgDYF80jYM4
         VFQyogivJQpLqM2F2cwK60HnamXLtDEVlxc4kKKzmLm1QVaI9a2vs1WSMUn4D+MOUpT0
         26S8W4oT+41neb8aFajj0RuikR8WYYxjH/wRD7Kj9v6J01oAznsSeRXh4oHMe5jrMEeW
         h+UIh1O+hwN+DulQxGDA0g8mALOgZ9NZGWpE537rzusy/KagTT7xCPZaoMKoysO1Z0V4
         5TcWl7U8ZPfVcwCw9p0L3XpJ7+LWUWI37ylw6CypNgM+hEZxtivueIL/KoDk57tSZECY
         N8fw==
X-Forwarded-Encrypted: i=1; AJvYcCXlqKh95jY7Qntci9YAGjiTwN8y+6Z62xuXZDZJNjEHlV9O6H6DJF1rCRLhvUL542AXogUNffLc5JeAJ0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE1nUBhshy8IhStjCNvfRHsZgBDqeNGhpPwtn3NM6qDh9oN2CE
	46ZCG22+9p3ZChcxSMhPTHHqn0t3yrw7lJKnFC4u+jMdw/aiEIoH3xCUvJ/6XVnhznwnfYckdVu
	oows+7RbnRWXOx7SJmYLK4bFFeK66fdGukA0EMhJmqf5c72n3ENctH9N+ZqI=
X-Google-Smtp-Source: AGHT+IEdaza3w4YiK46vtMn87ixUzfMzo5Xuqiyzl/UM8FhAqyCr47dBukudVIfRWmFxt6pTHU0mjvfES7Bu7Xxo3WtWBJhCWMgR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:425:73c3:d25a with SMTP id
 e9e14a558f8ab-42573c3d2demr20398115ab.16.1758454803508; Sun, 21 Sep 2025
 04:40:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 04:40:03 -0700
In-Reply-To: <tencent_F5FF2568BA75BB0C33479E6F1BAF4B4B1B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cfe413.a00a0220.37dadf.003c.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
From: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/comedi/drivers/c6xdigio.c:246:35: error: expected ';' before ':' token


Tested on:

commit:         f975f08c Merge tag 'for-6.17-rc6-tag' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104f50e2580000


