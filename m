Return-Path: <linux-kernel+bounces-833412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA5BA1E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2320562905
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B77322C73;
	Thu, 25 Sep 2025 22:43:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E16322775
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840185; cv=none; b=fOW74qnwo5vu+Z2gyVXzUQ26SbIcZFrt94F7zyRMEcD8ibHLhcxZcYSwIgnWdWNL09GtsIA/i29vNTUevAZEMgW4mhT+CYZcGL8KHHME2G1u3P+KqWbNUXN60vcsOKgY1N5u0PEi+3z52czBZEGn3yKSqJ780eWdOC+XrhHa/4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840185; c=relaxed/simple;
	bh=nrIZgYocibwMALWDpOMCWFLNb0pKnTH1vS9VBqGnp98=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HMSyJ7WeBHzksx0k8M0tYHFujs7sAjwaprMesmND0XOjlRCSwnIbbuXbuRH9BLa2FERKx44eZH1/TdTrOx340rkezewVZwyod6jAjv/G5wZa3CAgyM0CV4fuUZr8RELRsPeb+4ltQOJV5IO0DwC88sdhdVJ3VZGUxrW5vxIZoSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-889b8d8b6b7so303070939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840182; x=1759444982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/qEEA9sHgIdrxu4sbNWPa4Zk10/8nq/0vLv1NTf9LU=;
        b=U2Xu66/UEGx+EGpTixkUkQHw88jp2RrYakO4nljIhibZfTu0tMlG/8VErEurNVJHVm
         dIPsLzQp5Kl1MU2dEbb7QnDCDwAmzPJbW9ndznHgyWAF6FIuS/0KzxqQ6nfF3/Q8c3+M
         19u75JHCmSkJMS1QLnW9C84HZsafi4+UNOjhbDyik/2HOG4+jHBwTlGI7IDfz+oHxtJo
         NXV9MRA4iXEZ84zrcynxoyQ3wBiMN5K0V+CqFw+6oPwkKyeldTseJ+7+6vQD7lbZSita
         DWJSvRQ+uhGRWxaKOhi6e38rE3C6YDDsr6lUmeFcxg44Iu3AixoANdyHWTNkQkugKGts
         GHxw==
X-Forwarded-Encrypted: i=1; AJvYcCVetgMFzGa4UuOKZbPQMaGOL0IGuWyth43CPYAi6L0E+kalXHbS53RkLv3ApjmyOMEM2xT8xij1yOQIq/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WcD8bu+kCip5gj3HJJp2Cs0+DYU5CVuhVG7C+OvALNROACzl
	HMj1LoeSx64j/xcu1rHokx6Dyuk8iXho/P0S/zk2jUJjfHH6D/dHEEHSiluqih2huJHG0fv9/ou
	2z3HiEcstGAgu0htFe+LvOXihhjcOIWEf8x8R3iM8ad0SxrNBYsZQBwhgmWM=
X-Google-Smtp-Source: AGHT+IGjf+UW2xBaTp2Dn3HNf77BD0CpaaPObctBxmGg31b3EIcZS0FF5EMPuNeRRV1LmOC3qOz/967Qy+ercukcM5kFuwfv9A1a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cf:b0:424:86d:7bb9 with SMTP id
 e9e14a558f8ab-425bdaf0355mr62273895ab.0.1758840181941; Thu, 25 Sep 2025
 15:43:01 -0700 (PDT)
Date: Thu, 25 Sep 2025 15:43:01 -0700
In-Reply-To: <CAHxJ8O8es=zttb498nGje+T0AsxJXcEvUKWBTE1CVUrgV5pgXQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5c575.050a0220.25d7ab.00a9.GAE@google.com>
Subject: Re: [syzbot] [wireless?] WARNING in ieee80211_tdls_oper (2)
From: syzbot <syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com>
To: eraykrdg1@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com
Tested-by: syzbot+665dd2d6eb222ac6a6ab@syzkaller.appspotmail.com

Tested on:

commit:         4ff71af0 Merge tag 'net-6.17-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101874e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bf99f2510ef92ba5
dashboard link: https://syzkaller.appspot.com/bug?extid=665dd2d6eb222ac6a6ab
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=163cdce2580000

Note: testing is done by a robot and is best-effort only.

