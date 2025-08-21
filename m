Return-Path: <linux-kernel+bounces-779746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C63B2F815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663891CC6101
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AA830E0E1;
	Thu, 21 Aug 2025 12:33:36 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE319E83C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779615; cv=none; b=rfB6nl6G2mgXbVw/iwWammccYSvtO4j6ggtNjYOpygWjLfF18oIUyCrXhZ7m/Y7xBKHilb6xEHRuLoj5qUfkeZX75ZMEWsIRlAYKI+Kxmn+/XRQDAnz+1fWmlb/noPCfubSMFnjAmyHVZzhdibQta0SpDQ9y73uyv6P8gwkx79Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779615; c=relaxed/simple;
	bh=x+Hm+jlpve5bhMsoCyS9BQA1Kt5xXfpBC/IqW4ac0us=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vb/d2ER1H1N9zCvnuoc2ysy62O2Nz254kuz21cjgYcUELPpOlCQDVpsEFCgOHGDUuU6BouVNJay/VLcVv2nFw9J+aQ1dE1pbB2UBkdA0p8+XLpf6DJBK5rZs3b3Po4HnQSDScAkH4Tr5vEdf1q+EeZyPi2DirvdxtuFwNVqphUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-435de7c0722so1514553b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 05:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779613; x=1756384413;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzZRRGKVVE9scqFqMUJIdWTgztlx3eiucU/EMi2gV+U=;
        b=FXdg5+hsvtLcjBqaS9UUTbV50u+zkaQZj9RKLGilXZ/qO8C0mRDJgV+hmKm4zZ3mIc
         u38d2NZAg8LYGETLf44BI6wbGUOx01ocHkJyEnk0mrFdIONgh2YJLB6EQ+AcOrKhr1uE
         YjCZyz6YKKyd5pV/8chH3zuTGNvvWrc4tTjjrN2wuBFMRa9fO/9oBIScmL7YCR4X57v6
         z5LEnKKfoI637sx8VL49nhEQZq/wHjGPviGKtVcYVWSKaTdmyOfHcZVSjFHH+xC8L55F
         KduAgUBU4uPNs2sqN47EocOXwX2Gpl0tSEA13tpUwrPrkLDBSv2SMPJPO3mrZh+/nO5O
         j2Mg==
X-Gm-Message-State: AOJu0Yxc86fsHHg5CS2xk9rnV41ZeIYA+ChuAnL0iG+tw5hQTKn+MzeA
	EaxrRYl6fZlUkwsAXbLKePJJcZbl+/vsxaZSlTWSNmuGiz4Jw+J4N620NRJNb5h4BR2XxZnb7fy
	2W4Th06XWH9w8DthO7CG2TnhoFIyc0EHvsB5IS6inxOHCyFhpy0p7pe5ysls=
X-Google-Smtp-Source: AGHT+IGs+jx2/q3II9+0bk/3Agl8Uiev1mygp+Gevet8yBXKJRz3qHTlp2jWodu3KRQNAlEseKcvqVpZmf7x/lDC31V9kb8WO1Ju
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2394:b0:41e:9fd0:bd2c with SMTP id
 5614622812f47-4377d701a5amr822447b6e.18.1755779613539; Thu, 21 Aug 2025
 05:33:33 -0700 (PDT)
Date: Thu, 21 Aug 2025 05:33:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7121d.050a0220.3d78fd.0026.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Aug 2025)
From: syzbot <syzbot+listd166d65ef55e86d38882@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 65 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 567     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 403     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 79      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 55      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7
<5> 43      Yes   WARNING in gid_table_release_one (3)
                  https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

