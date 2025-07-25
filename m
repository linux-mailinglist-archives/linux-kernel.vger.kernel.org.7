Return-Path: <linux-kernel+bounces-745790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF05B11ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553E75A4921
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2904C2EE261;
	Fri, 25 Jul 2025 12:39:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78A2EBDD5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447174; cv=none; b=Zqavde7lewO7ijrIwQuRYhnNl4jpeGkMOnaTMclIPvvnbFc4bC74NE4Kxl7vVHE5mHjvOarJrot4NQoZ1R5gUMXv5io0+VbnYaVm9qbVYnnjP7zBPjBngCx7Ls3p2Y4MJHumfaszoXVZVmei5ha1utxQR1dmpQXVlHE9s+G6WjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447174; c=relaxed/simple;
	bh=5kFZK6jbXDGRL7BERYJg2CT4puCOtsTtf9R2ux1amKo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Td3sXSHge4VkKLecY/Kqd4esSM+3lryiz2QgqAm/kkCN3CIvGNTn1q1zdTkv1/NwU0bpZpaJqDYH4a6+oHjwpSpxOZ9eYE+Kr2tipgL1Sy+jF69paHv7pk7pPrPpkEu67vBKYruyp5F9T0ErXh68gEE8HrLoymmgPlwPcYud6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87b89891d5dso356943139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753447171; x=1754051971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IXz9KTBY7+EoVCIlZ/sPfvy8wLEP9/nh5FnTUB/si68=;
        b=H9J+cyevmMZC58a22jCqsMTetrcK8PzzqQcmHeuDNdIiiw9KK+5Mtw6P++mWVe69ct
         f3zNDIHhW8n6zALaIwckP6JzH5D8PR5zZ20DWvSf9QoF4WZfr2zIlWh1WKe/Hg/5+uJ4
         kGjxE2UWcfRHQL+hWKwVAKDImp2Ni6Ccsk684kU1alsb8GYnF9vrbZMuy8kTLjM4uWAZ
         PvDreI8pA9KdhWYYsmlSNUlqa1xhm+/uazoYfQ0kyIEc56f4NuaQb+KUNpNCtoMnnOlS
         0g8LY1CnXsQ0nXxbiTrnGIUaVkMU/SlcE2vWO3QMb9Qsk2Ow2FoYaZqeIWudcFl0KPzQ
         CxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9UpoPSet8YtGxECJMIbAHnq8SHw7BzFvwiessweW1mUnfZFNU9lMMc2GP+pGIE1j1L70ZrDd5ZmVrMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZCbHiZe3g8UfKHz1BN3v/oDsd2YWXbX8yLhxCZpEUvJmWP4S6
	xKTH6Q9inWWeHmzD8dcYrwtcWT3BEWbYqxfQBPvy6Nk6WMGP7gSpzvEgPlZh4jR4kZVK8oafTD+
	PskH85CkKOTV0tY5dheIwzNo3Jy132Ipdp/aCymTnWHFAAyaabEmt13b2SFE=
X-Google-Smtp-Source: AGHT+IGbt8uT3+2IqdfWSjTjSOPO0spt6bo95zGsbwcMI3tudDKzn9qU6kaajG9+FNbiQRJjJgIQbvFhcqxczsHoPomb/rpU1xOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641e:b0:87c:34e3:1790 with SMTP id
 ca18e2360f4ac-8802290ec6fmr261154939f.1.1753447171073; Fri, 25 Jul 2025
 05:39:31 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68837b03.a00a0220.2f88df.004f.GAE@google.com>
Subject: [syzbot] Monthly dri report (Jul 2025)
From: syzbot <syzbot+list90ea762fdc6ccf92e714@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 32 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1688    Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 465     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 83      Yes   WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<4> 72      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<5> 36      Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                  https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
<6> 30      Yes   WARNING in drm_gem_object_handle_put_unlocked
                  https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

