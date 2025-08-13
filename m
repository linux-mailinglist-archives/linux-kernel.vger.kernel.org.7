Return-Path: <linux-kernel+bounces-766695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78067B24A17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1152188C4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AE82D9787;
	Wed, 13 Aug 2025 13:03:43 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9242D12F7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090223; cv=none; b=g8dxKAaB6JlWSQ1cEM2PvfZc3VwUTONE5NL90CRvO7DIVPAaCL4Ks1NFdOLig1KMC8ihDk8s7xl1jsm6GkVV/MXy+AQhwhI0yNoriN+bAR212I7jQwG0IpOnXlRHGID+FKdc+AkDAQ0I4WD9YGWchvzq+81zKetINg6UybHLMvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090223; c=relaxed/simple;
	bh=net+YE3QHogXlWlMFec/YsoynlXNSNLvWhpeUn87aUs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YTctdFCvDnb3ASneFk3WeifJZ90DzGXQ00fI65Pypdhd2R5yl76ZVJYEfiue64TAQ532BUj+m12ebrt8L2na4Je2Wpowii7xhyavgmTF49Z/GYKfdLwX0fD7LGZjYJ/7jZmwcuP0nxdMg8cq781GEy2ipCLlywxGTyLDIKW2/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3e3ee9c77beso58074695ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090217; x=1755695017;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTlbQ+5lCWedkmmDM5wgqDgXpwjKjQenhY9Z1lVFSds=;
        b=cqolMM8eHKLj30F5jbU5IZjhnUMW/NEc8u1TxBZLugGkFoyTbvwHR0jmOQkjt7YTcj
         OEo5TQ+7k1JdOvDqLuGnLpWIGb7NXKEg/yiwV211hqeOyYYMgzV8XkfIZwf6ZuPnOHZP
         IgPTo3Qu/Ym0pYtPIPH3iZYJM527uVsV06WgVJwtSZ8BCZVVdUokS226p3xAlHqYPYM4
         Gl7lEdXXgMt9uo1HiCa19nkm7fOhH5o8RD8CQ5IznkkxaK+5Scc551m8qgoaMGqcJPSv
         3mVmB+Qp+VYrYt5A2TU996umJfUM1SnwxVJRbYhYyxf7LPwvM6RQXsjoV+2qdL8tLtd5
         BFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAWCwCyjKOPEjY2cbUaGAeA8GPf01CYF4TCoM1UuyxHQHjYuDyUupasAPzkXMgFgBbnvOSa5LowC2qZl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2QOhVS43gmc1ZplJh2p61iGhU1oVYe7vz+tFbWMaOCRDAJh7
	WCUa9J7GGi6GIRZ62YM/ndC0ioWyX3Rv+ItSw2wtjVEd/FOTkW7iqdvkQ599CuVnzO8w3izHASF
	kkaIbPwt0ehcoZk/f3bduh8lOx/8TBci+h0QjsWg62+yS6oJCgu0vvGzDatk=
X-Google-Smtp-Source: AGHT+IEoNILpaXFApHt3BIrf6vNHnYzECVrgkPRxUncsquk2HrblXm/Nk+BZ0Knd1pLIpK12NtT7NyEcNp6sbzhuITrihoOQiJMv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c89:b0:3e4:ac3:ffd6 with SMTP id
 e9e14a558f8ab-3e5674a6c2dmr47859725ab.20.1755090184133; Wed, 13 Aug 2025
 06:03:04 -0700 (PDT)
Date: Wed, 13 Aug 2025 06:03:04 -0700
In-Reply-To: <20250813124145.4469-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689c8d08.050a0220.7f033.014a.GAE@google.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in virtio_transport_send_pkt_info
From: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
Tested-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com

Tested on:

commit:         8742b2d8 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136725a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c575a2580000

Note: testing is done by a robot and is best-effort only.

