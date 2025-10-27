Return-Path: <linux-kernel+bounces-871063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E9C0C5EC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2A518A3238
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F452EE268;
	Mon, 27 Oct 2025 08:42:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144982E7BB4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554543; cv=none; b=TOOck4cCclcWVAC5tl5k8fOWH5qsTF2U5gMtBOIMm/uKnuGUqhL+96kmXDyuHLSiqlzlEzBS0SFxa1vtw3EaEsptSJiB88i3PAxczn92PkH8S5Nk+h1uxW0EaYGu+QMw5yRkL06Xgrr7TptzJnmH6YhOGxlTbLY8Ea7Hfz2fDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554543; c=relaxed/simple;
	bh=0j4iQRRfZqpAVxJqcJV6E4wRpuAPGKPN/djThwQJHSE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tt+RMyo/UdmmcCLTgcW7coNlwIwDULZUgB/n67Xq/ByTxD5hxMNt8zoR7r9s6DA1LTxiqQ8BU0VkC/62XAcodFJ3L3tGtLssYK3vJc4OHm5ODsH+BMsYebQ0Nb7+s6IbLsS1JEaHWTeWP8tMcBA9b9WFS9TFinTralaN1x0aj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-925332ba890so1294182239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554541; x=1762159341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3yl8mwSqIydn38Gqbj9A81bRGICRkGUONk8EvM/+f8=;
        b=IR8Uuy60HoDbWao6NZj1FevYpBpltJ9A8U8kGcvONh/fs+nzs7E9biIVUj9ThNrHcI
         6IfC+lcrC232nKM8w0+g5wnS5flaifbGRkWIf1b2ANNLo7bo0n/NhTUh++zu2i/k/g7I
         fVkczyzM/y0moiGiwwu9SNP3IV1IDDJdG67KCnr+Oko+au/xZ7Q+Mx6zSGEm6YmGi74n
         QbYsny0DNj5n8RGlhq48mB8IMjsy4nUEQD1e8QLxPPdYMWINg5ILpfbs6B3s6lpOx5QV
         hlcMZnOuvzf/JzwPv7CHIeVg7EMr0mFH2M0MtFEm6GDcKvSBNK9xXzzb25AJ31tiFBQZ
         so+g==
X-Forwarded-Encrypted: i=1; AJvYcCVy7N2mEXCoUYVAWV4wI2PXe+lb3cHgMtxkpGrb62+jkQg1KuxkSp7Ml2crjZ3WIi5h1pm7PKGP9NQ8YQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FVh5dQFXoeBIMLt/8E9RILBiHqA5wGEcUeoh5wnIjj6w0KsL
	RD3FZ+Mq5bsRgPULruxOx2iHZJ4I17N/74x+w3+TVL4fLG6Gt9f3Fs6Ct7EvOrktpN7ksjGUDKh
	CFr1L0fo/BlPfQK0+TNR0ruwst0pJcpKXE0vFRJrHhoRneWTo/V02rewFaK8=
X-Google-Smtp-Source: AGHT+IGbVtRxMs1qwZQ9UkiW0GFSdSxRykYBvlFCLjmSzSfDatAFwfdmB/JRq8LiS9qGjV4tq8HF9j3xQTmn7DUDEEK884cpIEDv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3f92:b0:945:a220:e407 with SMTP id
 ca18e2360f4ac-945a220ea94mr706328839f.16.1761554541141; Mon, 27 Oct 2025
 01:42:21 -0700 (PDT)
Date: Mon, 27 Oct 2025 01:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff306d.050a0220.32483.0012.GAE@google.com>
Subject: [syzbot] Monthly dri report (Oct 2025)
From: syzbot <syzbot+list323efb805515fd92b304@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 33 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2362    Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 515     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 333     Yes   WARNING in drm_prime_destroy_file_private (2)
                  https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
<4> 74      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<5> 42      Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                  https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

