Return-Path: <linux-kernel+bounces-875450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC415C18FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AA8A355544
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891EF31BC91;
	Wed, 29 Oct 2025 08:17:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5A31AF2A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725852; cv=none; b=X8DA1dudF2pGKKT/UztKIFQ6Rdvf+4swfn8Bjajsl21Y2nibgd/UkAridcc9m20HSLPEmDsjq/mo/NnR71TlmonVLc0L10nzoBRMuLXrwVI8ze1t4/1kA0oo1A+PbBm2bD+bnMR+wOY+7zabVpQBbNMJWvEyHSriH2ZLrKlvfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725852; c=relaxed/simple;
	bh=5J7pPRHYEURZpuEtPNXmCIlL2MfRU3A/Ry8C8XJYL6I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=px0Tn9dXOlUT6ZmzqXMSa1mxZCPPEFfyYcpWeRyL1VOhfSZUcgkB97CenX53q1MHp842ZY5v7uwlo5awrmSCVuCUzvjdoB8qz1JqnKTz3wuI9FalDHjSP8zX+tUPVOSb+fzmVhXjFUt0KiOihUyas79fw5bdWyt7letxV2MV/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e7f4f7bb1so613552839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725849; x=1762330649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cg3J/ZPEstQ6lphhsF9bUJIEUQGME+sZe3A4/zAy0KA=;
        b=oyz9MADuJUVZQvnYA9pqcDwRKjnJI9J9DZImc0CaNkScAYOQXYConTIUIS1HVZcuQo
         HEr3hMyZp7P0UjL/m3oqGGilhLPwfYyD3no+m2AuR/PUlHTQE9rn/qTZA+5Sjw+otjL/
         fttmFTYcKJDEg448Z6AA4K0Im/iKDIPwthKDBjnc6HR3rLxbsxEZQ0yb3kkmhL39r7Wu
         rLXHeSR78JxkJJj82zQLJ+5xWR9yebXucV99JKq3vM4Q7FgsmCVOeXAo6qPRl0SYhENt
         Um8rVFUV0gx63LQ5ASNjd1bnwAE3v7KGPG+nlXkUGAhiQSUtozhiqwzG0UF45UlCcfFA
         Pr/Q==
X-Gm-Message-State: AOJu0Yw96+t5vavXqg0S4stHc+BfVvUq08jcFCJyRlDWsLCC4YEDgRkY
	CHWizQOfHGd+9+PHVNyfpj6RgZL6pAn4KK6RPdmu5lxh3s+ixuO7kkph2IU2dYGLVLas0e3XNcs
	k5Cn1gLFBrhooy12neT+usa9YyssZ83VQqgn9NJCpgf4y2YlkotOikQw7wKM=
X-Google-Smtp-Source: AGHT+IEhAj4tNiq0VpAOQwYr/5usSFFjzgdecvFoQ9QdWw+Xvy9lN7ibN1wXCAhrED/9w6jimSlqITwYzVhr0RA6AbeyP9yu+ayH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b07:b0:945:a438:a0c2 with SMTP id
 ca18e2360f4ac-945c96992bdmr305700039f.1.1761725849411; Wed, 29 Oct 2025
 01:17:29 -0700 (PDT)
Date: Wed, 29 Oct 2025 01:17:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901cd99.050a0220.32483.0204.GAE@google.com>
Subject: [syzbot] Monthly virt report (Oct 2025)
From: syzbot <syzbot+list4a3dcc12f136e3f13f92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello virt maintainers/developers,

This is a 31-day syzbot report for the virt subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/virt

During the period, 2 new issues were detected and 2 were fixed.
In total, 4 issues are still open and 58 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 334     Yes   INFO: task hung in __vhost_worker_flush
                  https://syzkaller.appspot.com/bug?extid=7f3bbe59e8dd2328a990
<2> 73      No    KCSAN: data-race in virtqueue_disable_cb / virtqueue_disable_cb (5)
                  https://syzkaller.appspot.com/bug?extid=9d46c74b27b961b244a9
<3> 1       No    BUG: sleeping function called from invalid context in get_random_u8
                  https://syzkaller.appspot.com/bug?extid=705049704a8f04f9ed46

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

