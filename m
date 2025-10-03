Return-Path: <linux-kernel+bounces-840890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA963BB5AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 02:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD1119E3BC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 00:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7F172612;
	Fri,  3 Oct 2025 00:18:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E5B1EA6F
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450689; cv=none; b=J9Zq52ReXPNx71zp7AkwVp4vmvk2x9bJfoG6pya0LH2Cw26LWHcUo2wlpXmi7A8Wv1yNp4z4qfK+L3G3V3Zh2Aan09WpzaiquiRMbhLyAig0W4usze/rFtW6BpFTxxyGo3OoZfpJkRJ2YcXKdM6CP9Qlj3bGui2pj7SLM1UCd6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450689; c=relaxed/simple;
	bh=2cbF7kt/xV2a6bi1CmKNjeapIMJABjccozJwKy2CFH0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tqDH0O39WZxi+YqP4NQHqhdSQ2dr+AazfnX5q54vJo3hCOUIV3vkelZZepXR6U8zZJ0cm78XP9bxagMZQzY4eHFkYmy1pfVsQ4GaiIWNM1Rr/jDdjyNOnbKz31l8EkQuMHVHNL4NTBTws1glyRJFWXZBxIpvP2gacJPITBDS5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8ccb7d90c82so203047039f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 17:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450684; x=1760055484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6I/tsMURAhmMAcvWuQOFYWCU5p9EUObCHssy986mSE=;
        b=FbslcedZsGp0F/5/DjGzo+kb0FxEp2S4yIJHDXbGIeo1TML242J8TjCBkPGLI4rhcm
         nDLYSgJu7WVjRIYQW70QgEx6fEBO4QG9rk9/zBlmMTYfMvszyJQ3ke8vbsWFj3fjj1+y
         16aJzxsgMoXteM7P1gB6y8HOFy79YxFTmZfSuwzjap++H594zYPwE8L2zM4vd1kiNjf7
         P7NO4E52bE9szi9uACSgPMQZs7dbh2M4VyPSIBXu5zJ/NK92NJ8tfIDFyJDWNtgWKYBZ
         paMGO5P4hUBhlo3+jiKf+4X4mggwOjH9uhkpQBpbmyUwxrLy6NHRWYY1zthoR2ChKILT
         Q4vg==
X-Forwarded-Encrypted: i=1; AJvYcCVwbv2ZYc5f8yjOLHEHTL2PeUWZn2VaxF+647kwk5HFB6ZF1g2Tt7Q6zqBlQ2Y0PHdswQaUfmW15wqa59k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgvLORB93qRVl7aYd1fN2jDCVDnP3auFJjiN725wE9P3Y2ZBK
	fyAaQC9Ls9/gn9QzPHC8WWWZpFr4BaDJJ/n3qbM8d7MVsxGA2DHKYjLVn1QESciNsqQ5AMCjuUm
	BcRGjonAJwtjySXd2yiGKIEDWkSdd3WwJLq7GOwBkFSR6QLxB04KEQtPnDtQ=
X-Google-Smtp-Source: AGHT+IH3sa8X+CWAZcaHp0HgbhrZEuHb0j0EjNdc2qqKGrOLF424eCAj+H6p1bBfwpr9n9Afgi+lJ+tANfnQpdMgTKJHfau/tmII
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:425:7526:7f56 with SMTP id
 e9e14a558f8ab-42e7aced705mr16035795ab.5.1759450683955; Thu, 02 Oct 2025
 17:18:03 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:18:03 -0700
In-Reply-To: <aN8RBYdn6lxRz6Wl@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df163b.050a0220.2c17c1.000a.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com, damien.lemoal@opensource.wdc.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Tested on:

commit:         e5f0a698 Linux 6.17
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.17
console output: https://syzkaller.appspot.com/x/log.txt?x=160acee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11089334580000

Note: testing is done by a robot and is best-effort only.

