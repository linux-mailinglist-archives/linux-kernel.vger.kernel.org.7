Return-Path: <linux-kernel+bounces-823833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD25B87896
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD581656C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A79521579F;
	Fri, 19 Sep 2025 00:47:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5735D19755B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242825; cv=none; b=VRSSG304o8m47ft/x91ipz45uEc1KTj4/mWeD3C8bKy+76w+kcRB8oiTBSsjslCNpYYqeX4a+1O1eB6bV3Prv73NJIyioF2xTACmgBtlez9SF4NKRBVR1sRpfUANJOUTCH8zEg6MeL1flJ/II0fApfgqUta1oPvDABo/RHgHfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242825; c=relaxed/simple;
	bh=GAyoTGXiwJpiSJtkzq7eimtPFrQs1luy6Xcd4e7gwm4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Xp/J/Q72YigyZHpl9u4mpjtULA/aUG2tHGNC5tD31pgBGp0dUnWwkd9Yemnq6kGOCI4NZfyWfXRCq7bmvcDWl/xrxGl/OiMNCWVUH4MBrQQYfarzFOSsfiF4p+PZsw1BjOFw4sNZM8USVbbta21X5g9/vMtwfKRvzmQHBSNl9qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424019a3dfaso13762005ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242823; x=1758847623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F95r+cTSDsZmv2bsi7ZtAwmAtPSWWx5N9hZP+sQyKBY=;
        b=msWzUJuHXaPODGmKN7ECJbKXfJ1payqherbZP+tYR54gXfCTV7T5uHatfrSOLH28Jm
         Ls1fXpdICdMMTHDGnL8etI5fRciPUjfuMfH6YLgXB4O9VxzQ5WCnl2wZRYk0sCuC7LlT
         3nhTAL76ctvNacgqaeC44YnbLGeTo2oAskx08/tJMC54uyJGtJFt99g0hL8nnIjlXOxc
         txxVwRbYH9coZ61cZZxgQjy8Ccn1C6Syjhk9wNm5oVC77IiVGBCU/2J6OWZBHRz+R+z5
         +EN6cJ5PT4kdLivyvv4DM3ZDwHp2jws+9Zi1peS72kA8tK3v2CNzqJrnKezKBxroade3
         eLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzfOGIfTX2Zjnn+clnEOVDRjVpGFI99HQYrzAfpWTR7dDuEPidXeqAYgn/wINdPHlEcnDAV16rn54u4c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1PT5yBHiFAg40Cg9gp7eCbyAjhJ2rDZGGiS93Z0srL59s3hgA
	zaePo5EXGlUqINYa6WdgUp/9l0ONxK6uQECf5G9d07nDCjZ2DB79K/joGRZ5KWWS/L6XQXE3+ky
	Umzz0mabVt4KnqE5uxCbEaID0ZiXdBJD4mtY1WeXkXnksDtZ7agJZchAxiLI=
X-Google-Smtp-Source: AGHT+IFOkT2sskOvdQRdZJpZwu0XZ4v5A2KP/qDpkW3dcDHnDZoHAMhH1SUsufhBPr8jsYoRlJ6NYQ1DJz7vrsuCddqRfqGjktXv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:424:80f2:2a9 with SMTP id
 e9e14a558f8ab-42481902677mr25900315ab.5.1758242823605; Thu, 18 Sep 2025
 17:47:03 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:47:03 -0700
In-Reply-To: <68cb3c24.050a0220.50883.0028.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cca807.050a0220.28a605.0013.GAE@google.com>
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
From: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
To: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, oleg@redhat.com, pc@manguebit.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit aaec5a95d59615523db03dd53c2052f0a87beea7
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Thu Jan 2 14:07:15 2025 +0000

    pipe_read: don't wake up the writer if the pipe is still full

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175fa534580000
start commit:   46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dfa534580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10dfa534580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17692f62580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361f47c580000

Reported-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com
Fixes: aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is still full")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

