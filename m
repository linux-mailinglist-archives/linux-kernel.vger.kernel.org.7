Return-Path: <linux-kernel+bounces-778948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4C7B2ED08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07E81BA049E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51E2E093A;
	Thu, 21 Aug 2025 04:32:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA5280325
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750725; cv=none; b=uf3/4aM+dOZBodks9rjlLgM4yiTI9thU/2tAkEN7QCl/pyus5EbJclEjaTozZyIz0sU5DezuJYEmkIM11wCjKa6OlXWnJb5YUlMZVeZcskDw1YbDAklknT0BxmadKHfZtD8ogP/sHsGHwl0oeNHb2lznuPPM2JnLB1hxaG64M/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750725; c=relaxed/simple;
	bh=mnFf5Isj80moJw5eKowoxDq9BMeSxf5fOOcUS6udiLw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QJP/FfeYGtSrvfOCav4Px77c+ysvUkzpOVn5f3bu/ZbEEau/9xp3q0zA62B/lGnykI8itid5njbawVw1nl5q5F9iFQVkiXKcnTi4N3yZaWMm8V56vdC6g9CbB+YyRmYhVdkc9nALP4SLq87iMdmrbmNn7Uylh/yo7976yL4KmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88432e3c4ffso57019439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750723; x=1756355523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t83oR121fIfuWD4ievhPG3RfXQKyHGYPVX8fG//IpIw=;
        b=nz+F2hlnE9A260NxMG/DfTbfRYvV7wQ2kMC9P/8I7lxYNW19Qc8YdlnfUhSDEpRVdT
         v9mS2hlGHn09PDS0ry6CDssOQtjjFIDgPaAuZQvOGv7QOpyrhrSsmiMzx859FCCOqwmK
         /wEaeyh9XttzVCGdZX/K6mJAOCUJEbskYfwgNodTUVsXqmnTHx/Qp0wU6FEI1YQ5m56o
         NvuJ+l77+PZ7M7FqxSNiCGlLvuGyYn1Bnjtvuw8AtYAkBkt5UTsF7wqGf9Ia41a+c6fS
         YlmiEDADihTMFKLyROpzNMtpXun91qGajZ8kE8TOfVbPPZ3VIpO6WDWsLRfxUWJJMway
         uvvg==
X-Forwarded-Encrypted: i=1; AJvYcCVFiPwYd4QsyXXqX0QppmZNpTDIu1hdK1CQEIinzh5vkxCa0nvQHij6ONQqKCj3UVwNFu8DCMc1cTJqldQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGChc4/ZlD2uYdTSQ6PIeJbivCXjhECxCy7DwKbdeoBpdW/oV
	XBmlB4nDblz/rMQ1LsT7AUzQT0gs/GlVdDfr7aYJkwgB49XPUlr7ZW5mArauHYIZqwqV89eZzai
	BScAX0w3znKJI8My2LZ1wmjYTiDGlDswAt0cdqeshQCgMPydAokPfpjHzVEk=
X-Google-Smtp-Source: AGHT+IFv9Fm/dgk84jwrTaEYz90E3vi013WGcrvOGHqIcZzSOyLnWAMFQhLwhXiyFa/I3zjpPekynBBvFBni0f1STGcNrWo5hBZB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc1:b0:3e4:2ea:bbf5 with SMTP id
 e9e14a558f8ab-3e6d89bd2f6mr19443275ab.21.1755750723217; Wed, 20 Aug 2025
 21:32:03 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:32:03 -0700
In-Reply-To: <20250821040350.5170-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a6a143.050a0220.3d78fd.0017.GAE@google.com>
Subject: Re: [syzbot] [atm?] general protection fault in atmtcp_c_send
From: syzbot <syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com
Tested-by: syzbot+1741b56d54536f4ec349@syzkaller.appspotmail.com

Tested on:

commit:         62a2b350 net: openvswitch: Use for_each_cpu() where ap..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137cb3bc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a58f6518808151f2
dashboard link: https://syzkaller.appspot.com/bug?extid=1741b56d54536f4ec349
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ca8fa2580000

Note: testing is done by a robot and is best-effort only.

