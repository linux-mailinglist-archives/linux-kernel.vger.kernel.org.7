Return-Path: <linux-kernel+bounces-773695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D65B2A608
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E63173240
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 13:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF31326D44;
	Mon, 18 Aug 2025 13:25:40 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF82322757
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523540; cv=none; b=Ug5WHg8haWHisvN72cPh4GsWfrY5rneDZvFHH8EGP635NVN04FfZhhTCmSmU2hzBu0Dyakl0PnNurmv5W57IWLZkpKasRj/jptmwmU8hRQUWQwo6WozhZfDX7vEL+hLEVXqW/fcDud7++znxzJRozZOzQVqrdat5024Nb8OJll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523540; c=relaxed/simple;
	bh=NFC4rDjWt49RV2YrszLSI351599VGmLwqN1VTO4QPbM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bb6LPAg/jPbIm3FKQv1JYkYdV1x91BXP63otGHdzkltXyCsQxnWn5rK4/gY56i8u0UsaPggRGzzgX5ptxP313qYDc0eyANJ3/wI7uVRMfYKCsB79xYGW550VD+EalVOoCWAqNjjDQ22fxbOtsCHz0gcs00c8Jy97H4MG+edmS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432cb7985so1119080039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523538; x=1756128338;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buVrXnLbiUfXOlmQ5OxmbqCNm4uwO1BGwKJJdtwt5t8=;
        b=PFOJOHLULybddrOwfgGhcYpZVOf6kVMBmBUtzJxqAEEcDWR5DGbGai7cbzE68OQg6H
         pROVgAUi79dHVClWTWDB9Nlx7FGqonwi9McWRq7ZDFwe0JwogFtHlOjrgQnEHj+P9B8l
         ZQNeHFcR8WA9qLr7s+AkQ2pkOaj9jbROTNv73dViZi5pvkxEk+ZDvVGUPCbkLZuY5AAK
         R1EKWmO3IJn0Gv4Hw/MpdyFuZ69pL0uInHrUsCS1X/uI9WlKZT/8kCsEM6c5vQ0d7n78
         LGkUy/BPJbk91Dxs+SxgIv9Y7JTZG0Cmj2+1PUmWHd9aPAp3gQXOnThcoJZjw0f9zS7g
         ln/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUs3hXzENDyL+NjZmGT4V6G2Q+aFLNTLYs0+PL5GZbRv41zyIIsvc4nA4+U35dDWmgu9ahLbq6GnHA1T8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ6A3fS9ya9wvsZcGjR9AAdkZlUA4scWEiE+b0fzUDRYQPYOmn
	UGt8teT/zFLp8rlsFkOFmU4ufGGRnd2yiJlKPdPGrDc2nDSypG/nSx6HVPn2m3xDIvOWDgY581H
	jqHnGTNZGtEw7W4GgYLr44XQ7zjyp9f2CzUsk1aF8TpvZK4U9Ywn+teM0k3c=
X-Google-Smtp-Source: AGHT+IGDJ1IFJp0mWrBuEQafKJ/BcwQEtblJCF2eT/di6EdS+WEiAj/bZfDdJqvCIntYVSPSDkvxsgPl15kaaJGrssSOoRKXQhLi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:86c:e686:ca29 with SMTP id
 ca18e2360f4ac-8843e34cd35mr2395798539f.2.1755523538112; Mon, 18 Aug 2025
 06:25:38 -0700 (PDT)
Date: Mon, 18 Aug 2025 06:25:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a329d2.050a0220.e29e5.00aa.GAE@google.com>
Subject: [syzbot] Monthly smc report (Aug 2025)
From: syzbot <syzbot+list2777bcfe69a1c7125c95@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 431     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 113     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 16      Yes   KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
                  https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

