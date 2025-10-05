Return-Path: <linux-kernel+bounces-842268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04923BB960E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 13:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFAF3B6D85
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4943283CAF;
	Sun,  5 Oct 2025 11:29:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A62773D8
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759663745; cv=none; b=JHHwDZHjLP061fj4CpJebQJ2bsPqzcBNAmVp4rf2DYckwmMe5zUERMLohuKBRM7swkbDv8McyoPnmbv3s3ipJcGzSTUw6r9mG0Q9NxcHbbpzr8G6CfyAFyv1T+MZr/9EUGFJD3PW+eaHWc8Ip6otzeR8DakxziHDyK3vMl+AM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759663745; c=relaxed/simple;
	bh=+3ga+adavh3QldonKwrNiS7b677ZNI5M3M2DkVxtglI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kM3IGsDCRZce+OoFwVA3t2Zq4jjUeM0hjhDgziHSAch3veSZsY0HgKeUaXEgIzg1hhjrELqs7CXOOEJsQ0c+IcgCTxqJQZTJBluOoLw3x6Bh9I2S4OmemXHTpCUslGk48b/Hvb/YvLKAO7f9GiBeslpIAJic8b1jgGHeALTbpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9201572ebfbso1046734639f.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 04:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759663743; x=1760268543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCIBXcxDZcsYD3PpBfrM2yKHOeYJt5eTlPmcc0BC7GY=;
        b=ctyMhB85Ddi4Hz0dpSVrFm7oJHaTdjStZw6pSSjz+sC7jOK3ahOu7xnFS6XZzUQf7Q
         dix4FU6glg9MrIrdLE2ygsi1wNB5GdajicZxVwTA9Y0qVU8dNxALIFqqRJ+ae4N5X0m7
         sUjW7yvjXJUSVsGOQ3PbbAlGpXifU68N7uoRpQs6uXoyr+6LXAEvxNMFL6q7o89+iQic
         8ffM9UWJIJDCoOyQIIgakFN9ebJSMIQV4fj7JTtg5MbS+EYc3Edh2L8GJgwVC+I19L53
         VI+/EEIuS+BZER9251UOQX/ZtfVw7kCaWCMRQTO+oRKnBIOsLgZe6Unb7mpEy2JdP757
         Ntog==
X-Forwarded-Encrypted: i=1; AJvYcCUAI6M0twUqIA+AFPP1QAMR40pOSLwIqG8n/ORLcbeP4OUvSycitvvqIdR87SIf4e0Bx20lpgXENSShVBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwcXoQkSYUkqWXa6SB0dBLhCPtn0GvivfYtAfxClLhQN3TRGu
	C3OP4NEiTmw7+QVBcMQ7g6meLI4QJu5IHrWsmuVWfnDrcBmfiNbKySbevDLE20nJrppumyZdaH4
	xSOrP9uTpaldsWB0rL7vyGf0jAdzKtNLLnXbF6pVN6Eth2mqKJkwDvKH5RA4=
X-Google-Smtp-Source: AGHT+IEJFCbtzpdawdsutKUO6wjc7Xe35dEsCIEX2mbMdowVjQwVpPo5dNLfSaxTp9UWLOC+xOOfC+NwdJ9Xaq2l5KMtlCiCTX3K
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164f:b0:423:5293:574f with SMTP id
 e9e14a558f8ab-42e7ad97438mr133006545ab.18.1759663743161; Sun, 05 Oct 2025
 04:29:03 -0700 (PDT)
Date: Sun, 05 Oct 2025 04:29:03 -0700
In-Reply-To: <20251005110307.8140-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68e2567f.050a0220.2c17c1.0036.GAE@google.com>
Subject: Re: [syzbot] [afs?] KASAN: slab-use-after-free Read in
 afs_dynroot_readdir (2)
From: syzbot <syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com
Tested-by: syzbot+ae8ad52680705c162471@syzkaller.appspotmail.com

Tested on:

commit:         6093a688 Merge tag 'char-misc-6.18-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bd0ee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f142ebe84501b0b
dashboard link: https://syzkaller.appspot.com/bug?extid=ae8ad52680705c162471
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164d5092580000

Note: testing is done by a robot and is best-effort only.

