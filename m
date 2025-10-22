Return-Path: <linux-kernel+bounces-864139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41768BFA03C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BD43B27E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA54E2D948F;
	Wed, 22 Oct 2025 05:00:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1862D73A8
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761109204; cv=none; b=tCS9BvhaCkLbLuMJ8giSYhti9V5t8DmuOjGWaBOpHc32jq02xVuewkky6a7l/h4En0s6vHus7Lczua6p2udSvW/dLSkf2Br4zhE6tvsjABPDSwHuKOlqLRm0zTPiWGH8EvhppyyEhk9h3rzW9WxslAXA1KSQkmLFGVPsQEyHYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761109204; c=relaxed/simple;
	bh=olrsvGKN/ki3uJ43d/jr7/CC+LIwwWaj/N7eL5WCa4M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qo8/WA0+L09nUkRSmoIkIO+g/h7wXEydK2TJIlGlOCMxQ4JmVT7DSxe3glIJLFGzadi8RGgw5k/qx6EAvP/ZJyKEFecVnM7Vpqrbri0sH8qMNEJpMYhyH54JQysNlanCLwK9MZ9+aYyLPSikv0ZVmO2vtefz5JFHXShagBuZRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430da49fcbbso43761905ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761109202; x=1761714002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=103zFPCR3uWgLK0Pe1IkQNrYF2FkhOeam32t3VQr3aM=;
        b=mRCL9qwzf5Cp9neQXKe/6aJgtkwEVUxaSTdrFSjYA5Pz2a0Do36ao+k6pZZx0E8KkX
         UJis8gJHlWWfe6QSZSomE6gHzpIEd+mpNd/mLIiLOeisFnBKr/YqmqXWZiqPtX7JT8xz
         8kxD9nLF+WVFKALpNbZaZi1N/KExm7d8jgiugRts7RkHZLzuI6cU9nr+7jje0N7fXuoY
         g6P61TcWnLFAZOnwqLaBP2vQY4dCLkvvJvuH5f7eG9TiWNvmXW7jBe6GCLtxp15FK2lw
         p6amEVzEnzrw3YSCGwwdvIjvg1v/qho1zlaO8UbEyHgrDTP0mmidiUf2JCOAApOG4mia
         3Huw==
X-Gm-Message-State: AOJu0Yzfo6CPB06PK3AsQqiGYRZLQkA7jy/jNAt/idpURfVVeyOjsH4N
	5fFXs1SVw3HwEKkGn1raqx9Z1NHlps4XOld+1MJ7q1JtadJtJ/nNZxgsFJzivxRUEB6JRYUSyUk
	MU2GlVf7cOfhAcrJBUkRTTPcZwrR2KTTxlQyxhPFMBfWSFqGe/dkgZvEZb/g=
X-Google-Smtp-Source: AGHT+IH4F2tJOyJEuUM2t5C8GLE2x3Q8i+jakBu5YC3MHJpa2sreApI8w2mtArB8yzaKc7LpL1Bojf+UMvsWXSAcr+cOprB3Keev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:42d:86fb:d871 with SMTP id
 e9e14a558f8ab-430c52b59bdmr237098265ab.21.1761109202019; Tue, 21 Oct 2025
 22:00:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 22:00:02 -0700
In-Reply-To: <CABGqKE0_8PVTO6HUtCRduxpGK5p_iTFUYrErTfdvZAP6bugT8g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f864d2.050a0220.346f24.0032.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
Tested-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com

Tested on:

commit:         aaa9c355 Add linux-next specific files for 20251022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11042d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23800dfb58d22855
dashboard link: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1742d734580000

Note: testing is done by a robot and is best-effort only.

