Return-Path: <linux-kernel+bounces-826426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AADB8E80D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24AA43BB75E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D9C284891;
	Sun, 21 Sep 2025 22:02:32 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468B1400E
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492152; cv=none; b=thIy+ekZveEcpIajaxaG2Kkj4M76cmajvEUcKFq1jnb1dlLLdg/KO9sZZSLmMcxdm8WMsnKVuMH+ODzGjnGZCiNUW96t3rC3Rwat5rOEpsuRKStEojEdJgrm73bWs7kSyEy6ZctLBVs3AkEJ6l0FOVmnWYwzCtFhpkd+lR1iQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492152; c=relaxed/simple;
	bh=VsUkHhF68cff8/AHZ04R72gC7GTZC3Y5IsrxdvF/Sr4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r0mGWa2/HDKV9i/5zvQ3M2OMo5cHoXsHtEbwFgVCG9TJsR911NaKwC2QuRE7TVnvLlmBHToH6oowHos0toHFPZEfHDpkCoBRINs4NEYzHdwVcKVW9xVqZBk1aK8Tl0Qo+dMFh4yiKaa8kcu4SA9HjC9gqcGP+bZr49hXxfUh0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-425745467d1so9498015ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758492150; x=1759096950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skU/vYmvoIGL8QnH64Wc2Vz3FYqQnJfrcQBRqXYYRXs=;
        b=GikDQyItprUsQpJ/pl/vjXVgrHbQQ4p4bBdev61o09fE+YHN9EuY/Fs0c0qurHGoZH
         Y1AFgrSD7h9CF20cj+k3rVLK+qFmEoB7ENuE87Bg01IpjJBVXn7qCbAX6vkRQlWm+nDz
         SaZlJtmNDfIEbCA4JEmhtM3/dzglkW0SSwlkfzZKuKBgtJyxcx8RLqqJoZs6TZks88vy
         1Vrkev3sXaNOey7fQA2IxprrheaLGxadyGe+Komptz2tXVMCFvKZkRKcMpcV4UjHxBZM
         LB5nWfT3yhiPt5frh4Bbjb6H6dqx3OFBmP2zyQXwwPF3h22/RFbkNr2oVzCxX+/aBmc/
         yYdA==
X-Forwarded-Encrypted: i=1; AJvYcCVzaVHowVhiEcJzsKbpSvNFCJZYrdkd2exyZJGYBa9MNccHv3L6zc3uO1UbicbXCVVbv3/cBv0nxVYLdjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXCNw05pWi1tUdbY6vEkFSZXQkK4tSqGS3J/19E/sBdaqIYf4
	2mXE/tNC6i8kyjRDD4BMUwP7xeV6tgbe7H99bRlgvZB+Rw8690JLmp4xB/0D8Mv3lZWc1khEpQR
	YAPzjdUe9uuZakxOGzNTz2IGxUlmuJQuygMcfZKxtU+wCSFS775Nne1eHdqk=
X-Google-Smtp-Source: AGHT+IGi8Bp/WVBn+SQUOchEZBtkSoRc62fX9ItZ9YXTcXRaCeLvXeJBuZ8CSM9XyY1h6rykCpbkHPBxNIBrCd7GhbtoKCb7bZCt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:424:6fe:43c1 with SMTP id
 e9e14a558f8ab-42481968974mr151196685ab.19.1758492149962; Sun, 21 Sep 2025
 15:02:29 -0700 (PDT)
Date: Sun, 21 Sep 2025 15:02:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d075f5.a00a0220.37dadf.0042.GAE@google.com>
Subject: [syzbot] Monthly arm report (Sep 2025)
From: syzbot <syzbot+liste38cfc5b51935cc7deeb@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 6 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 13406   Yes   BUG: workqueue lockup (5)
                  https://syzkaller.appspot.com/bug?extid=f0b66b520b54883d4b9d
<2> 232     Yes   WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
<3> 29      Yes   INFO: task hung in truncate_inode_pages_final (2)
                  https://syzkaller.appspot.com/bug?extid=760777ae7038cad77437

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

