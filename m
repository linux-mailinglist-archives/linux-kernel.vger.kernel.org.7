Return-Path: <linux-kernel+bounces-649044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD8AB7F25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 09:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD578C2A08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2328030E;
	Thu, 15 May 2025 07:46:39 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03371A275
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295199; cv=none; b=JNb1H/TbXqUb2XLk5fMkwQed3/upm8MsaOVbSyh5Fs2G54qGqH/64gRvV1N+vPSLFDzvlQa0qti9qQbKT5YuPho40c2RmnXsAVf8Tw/wQVWlfWVX2bs2htmKlK44vz+V6zVLLpAqgDhax8BTHFs756U0BEnyhUjHd75/LbM023Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295199; c=relaxed/simple;
	bh=3dGv8gYTC13hUZq24+Pm38bZNTwUMvkg0Wuz6L+YRyA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VRAGTNoAKVbR3CBz2hS7AF69TkZsZ2KEKxSp9r63udvbkGaTW+2taFVHB1eaqxBYU91QKRMfuGc1jP1lUyH1AAQX4yJ6uVpYdeCFE7LtdaZy2Db9UNZrrjhNh63YeoQvOo4wzRWP0xUF9wqVrWPktiXhT9vB+TthSNSRZp9rb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85b3b781313so115146939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747295197; x=1747899997;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kt1NDTppGe89OAg0t76R11zo1Nd69AtJT250Tah5Zk=;
        b=FcPF5AVSE8DHBMUK6kWR4VaEAsvd/svzBXHDAWmPDKiZIBW6xljfD8uY18MHtiT6Kx
         /nRPeTDENM3vWUjHdrd5VEXYMmnoomitexjh5PgJ8Qem5AptIXbRa21u+YNK++mAzZg6
         Z8UVwcGN0fLNx+X4AqkmcBPDiyIhsLYLmLVlKzmKDWKBXVty1rSffQEkk80GwL+QHDod
         3H8epzooddkXOTJzij317VRMCP5cSYV0jXNxaidA5m929du03OOI9eO+gIbW2i+QjKHW
         YyteHtOEPl2ymqC1s6I2ywcG+MBg94iUvGDi5S0CIfNRd10oWw3sr9qdXtOpqfN5aBYj
         fzjg==
X-Forwarded-Encrypted: i=1; AJvYcCUYdOBfRiCtgApKKIQYWGMZhW05k8Ug3wqM3t+RccUYbJ7Pjl6h69MBvm+sq1pbk3I3a17v8kawENmX7pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYPOcYeHcZqiuKdALvFuE73hLxklLg/5v4MewI1Ag1Rr4cJjB
	5UrgVLvQvpbpvu8hsWJoTt29E8C245BNyhnw83XTByJK8gxGMBvwgCUiS/v6meDWEKIK4wyaGJ0
	o40YDVkl9dPFfOYGGqL4kmFsKlSMyRiJVltYKe6u3Vw7PZP7eBZg0D7U=
X-Google-Smtp-Source: AGHT+IHmrp5WtW7OQYEkkGxNt8FveewheaKCyS0ubzmg2KufxpEWcR8ntchdMkUWoHlQGTFZbBMAYHFWXHvcH5k3dMC1yvVj8moe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4a07:b0:85c:96a5:dc2c with SMTP id
 ca18e2360f4ac-86a1a10192dmr179809339f.14.1747295197045; Thu, 15 May 2025
 00:46:37 -0700 (PDT)
Date: Thu, 15 May 2025 00:46:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68259bdd.a00a0220.a2f23.0199.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (May 2025)
From: syzbot <syzbot+list9b8c66749a443c063719@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 58      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<2> 37      Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<3> 14      No    BUG: corrupted list in p9_fd_cancelled (3)
                  https://syzkaller.appspot.com/bug?extid=15a08eabe3d3838fb641

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

