Return-Path: <linux-kernel+bounces-757649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92300B1C4C1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB6B16D73D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44A260566;
	Wed,  6 Aug 2025 11:21:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33D24293B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479264; cv=none; b=mJykOI/JtSgzj7SKuJyswogXkvU+OS0hQoha6ZJViDg1u5Xz6zTVkPMe3PLj5i6tDp9mK7u/sY5hgutqAuAzxaPP8s0/CuXybX+oTspB3xINtTzL4dMUREJ18hFwSfeD7l/hN/tdzmO3JawOf0xiEks41E3Na8BDWU/bm41R+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479264; c=relaxed/simple;
	bh=mgmJRhfO7DYaJq9sSgn/1UlpFRFY5x1Iv0jvdN0g1EI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JQQFLfh8eQV9wwHJUxfXjFZHi9KId6HUa+b4x3aLVq6zwtnKiwe2Yn4bP/owMoygKgZ0CPEr0GxpnBy1tcR3xeZKRvS7tmIEM8H5xuhi6MJ7QDD3UG5IFc1qb9VJN5cceEBwgX/A6paaAEIE/hjCWpTURpseUYXsHElWgjKsVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88178b5ce20so659458539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 04:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479261; x=1755084061;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBh7Fm82e/83X/4sbQZ9G+dmHp4LzfEOu4jtWqJqSlo=;
        b=Fa6ISJa7Mnh6f7SBWXpfwQYQI5mBBj/OQdcQoaHd6rNXDhnx/F2JxtQCzfiR/oAlin
         trdlobqkRrQ5NMKDO+ssJJCPW2Pqi4Z0vU5UK5kWQUfpSTNjtLxFnLAbnsCb6fqfa/QY
         Z/OLpltaCYqCAba/kPBlTlB+pHcSIGYTgcZKwsawu4XKIpS95SrqN/plVZftw1ig7iqQ
         3rOpi9M3ucX79chab7q3xb3Tht9oMEO2gBVidpcZD+9uP3RFwaXxOq4m0U3MjO5FOGev
         9Za7C/IOi879YfhpnI776VBdBAFn+W8JwP+thaWbWPPxKV2gUFCXGiaFNyY6UdJExPuU
         udpg==
X-Forwarded-Encrypted: i=1; AJvYcCX9mt0eYGzGfHYurY3jfGLJYZK1LHCzUKaRdRyvZS/vmRKDTJfHw7wVvG0sCfcuYaZNu8IDwicaY6cDzsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNe5/vJP55cZ2vI02uZpmKGOPnY6/ZC4HAhZ8O1Y1bJcERdIWj
	Z9xCX9DlweMnmozcVGYtECc8jWNkKVUSBT8eCmhCqTPPOhERek+w+3RBdFHucX3fA96WGLVGiqv
	oY06PoEiPn15aVxt+rwDlrMTSuJ4f8hAGjOIBnffJvq1hxbm6aMfA/mzZB3Y=
X-Google-Smtp-Source: AGHT+IEx/DgJCgjIzJR79zgzfgVyQw3lyABlgLRbYTaTNizDWSCd9o/LV1CtahpQZ7i0DAFsFnRtPKyE0y4O80UQXgd2oHAIlNyJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3ce:b0:881:8e2c:9995 with SMTP id
 ca18e2360f4ac-8819f113408mr443196639f.11.1754479261627; Wed, 06 Aug 2025
 04:21:01 -0700 (PDT)
Date: Wed, 06 Aug 2025 04:21:01 -0700
In-Reply-To: <68930511.050a0220.7f033.003a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68933a9d.a70a0220.7865.0004.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in follow_page_pte
From: syzbot <syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, dev.jain@arm.com, 
	jgg@ziepe.ca, jhubbard@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit cac1db8c3aad97d6ffb56ced8868d6cbbbd2bfbe
Author: Dev Jain <dev.jain@arm.com>
Date:   Fri Jul 18 09:02:43 2025 +0000

    mm: optimize mprotect() by PTE batching

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c746a2580000
start commit:   7e161a991ea7 Merge tag 'i2c-for-6.17-rc1-part2' of git://g..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=102746a2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c746a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75e522434dc68cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=57bcc752f0df8bb1365c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126e85bc580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161a22f0580000

Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
Fixes: cac1db8c3aad ("mm: optimize mprotect() by PTE batching")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

