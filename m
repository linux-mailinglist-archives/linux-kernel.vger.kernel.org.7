Return-Path: <linux-kernel+bounces-709117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52004AED97A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E4C177E66
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC32561B3;
	Mon, 30 Jun 2025 10:11:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6A2550AF
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278294; cv=none; b=DMgt3Iz4PKDEQw17MYBjRZZ2Ms/DavL/cjjCu8IVNAKpaKyZ6+nr1Xc6E01tIB/3GzFm8QgiSbSr4raDAvDbXpcrBx9QJcMcloDQGtjUxYgNHHrCMakBwTf0k2xCu6569+9gXWWMGTljQ32g6Om+hrIhQCedk5DU2lKgIzeBtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278294; c=relaxed/simple;
	bh=VCXKrRSd2CpJaoagZoPqOGMjsSSSy+qFo9PLjXhB7FI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O6tUg/TcUVicKwO61yC4SdZLS7LhGRDn3+5PML7mMmdl9QNV7P1STk1+YfW9UPmL0YFbaswCXnoA5Qv34ithDlmcmPP20SCSLPnvz0rPXskWo7CScS3+eu1CYVNT9g/eLVx9vCW5E1Cn+pxFpquGYDMJb+MJ1U0iSxe3Efm4LIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so171170439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 03:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751278292; x=1751883092;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zKf8t8VNsTOPB7f/2BZaxEBK4BZFnLX2PjQ2WNNVbQs=;
        b=bjY0uaTLmgGjjhOWfq892YA+fqrbrGmwiu1phsMhiUm05VKa0Mq74EJfBOEDgXR6dz
         QJ+J/4GHaipPHA9r2uSVmis5xe0z6FOAp7sruD2muRELdqE7icVYnJOr9LmbkEzTgVUc
         79dT/AiEcW8jhcESn2VSOxmBHF+uJbX4QQH8UR8+Be7MY41oAdJO1FCzdBMTLkjvJlIg
         Nuv389ZTavHr6fiKNqU0xAsXLbw0AYyMDfArEWBUFM4SQtyJohsPSLgmxeoG1LUbvmQJ
         +jq8VajR36p9IQwj3x+rZA8o2WnjbvGUQ45GPDVYDTinCoc1/0ujLljWDAczRV5Z3Puy
         +/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIoPTWQ32XTvOJ9Jbg3hF1lS0+40sy92JX4DtPAT4OB9tny/lT83aYGuVZAxCgSy/uI/4wxsVtKRdzz9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvL8xx5XTJEf9LnIbgS23rCqYpzaBhEyM/gGFupcZOnt/EygoS
	YCWkV8Wo/xat3BNmnuF/ggF105APlQCtBzrP+/S4FMVa1JAae1xvFxN7t7BpsoO7MYpP/IGmIY3
	djNJy9pukJ7sdOR11uqaQMhINsW1x5en/PK1/+00Ln8TZqjHiCMOd/nvyZ7A=
X-Google-Smtp-Source: AGHT+IETtP5L0eB7lb+QCOerQPj+ZJtdwT5xUzB95f9FWfz7MdArtJs11cRmz8dA1pVRX6a5Cb5mXpP3PS4OY3C9FVwboM99+jhY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:3df:3afa:28d6 with SMTP id
 e9e14a558f8ab-3df4ab56adfmr131218195ab.2.1751278291992; Mon, 30 Jun 2025
 03:11:31 -0700 (PDT)
Date: Mon, 30 Jun 2025 03:11:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686262d3.a70a0220.d08a1.0003.GAE@google.com>
Subject: [syzbot] Monthly nilfs report (Jun 2025)
From: syzbot <syzbot+list293dd5cbecebc40b22f2@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nilfs maintainers/developers,

This is a 31-day syzbot report for the nilfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nilfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4       Yes   WARNING in nilfs_btree_assign (3)
                  https://syzkaller.appspot.com/bug?extid=158be45e4d99232e1900
<2> 2       Yes   INFO: task hung in find_inode (2)
                  https://syzkaller.appspot.com/bug?extid=6646318bbcf419411bc5
<3> 2       Yes   INFO: task hung in mISDN_ioctl
                  https://syzkaller.appspot.com/bug?extid=5d83cecd003a369a9965

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

