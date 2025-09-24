Return-Path: <linux-kernel+bounces-830028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6217CB98816
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D24C0B34
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4FB2701CB;
	Wed, 24 Sep 2025 07:23:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591E226FA4B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698585; cv=none; b=Xm/w8CJkItKRrb+hDDSSQC0Zrr09/oVsIbhGjVQkvTNukuYA42QNae7MEwOvE3aiNX35KD8jRRuFH5uV9rK4zCSRrH5qmJ3P8imx5v+8TpYireYzY2+ig2T8Zoboc2P6Ly5Qa7ZXHu9VO1n6GLLDR9q7hLNa6duct+6EpmyM9cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698585; c=relaxed/simple;
	bh=2/qtqy1r1jymg+DGuk+/9h/JzIjW29drAHW4m5IBIjg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Lfh2hpYkxNOnPZK0PA1iijRjVXT50p1SEox1nblFpWqP8nNEV9D7YMHJe4ZPhIvZzbC9OzVFwATxOziClv/ZhpsaZxdNeqKkqQ7ZSdEcX+yB9OclbyDsG4ODG7vp04hBi+oiUd4ahDVVzzJidzXSFAa6dRrxqfv5uTTnPQe2oMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42590870dc0so8803175ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758698582; x=1759303382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8HRADEyxE2c7TAYRcPxc8lYrubmRAT5hgZ4nauEQXk=;
        b=Egu26iHN4NXccczakW0+xtbpmvLdVMVusRJt5T4VlHbsuNsNoIazXV2OP+Snjlq0Ez
         iW9edzsSTFFNHJFZMgFW3FEy/pAAbCyez+giZA7b3avFtQKRbaJZGSZqv9ur4Ge1x0nW
         Q0W86X4M3D96DQsshAP/5ULjJjdwSCQkWiUQImBx2vgmZKehOo51Zhd+xaenLlXo1sAB
         Mst7ADb80m5TERWscEQ1Wc8ScPCB3oPCdwKKjr9s51YUjhF8CCAn8vUS6PDkYIWlqq4U
         Vi4XQ1xnIwZg/seRMt06/mDGsyTr3GPJm7uqtsXH/xHfxStYdlueN5X1j70EWETzjA02
         0N5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrjNAXdlLItY0UrttGElo7U0KlrycBM2zd0m5pDgTQ6Lua7AVj64x0rvNSE46VR6t4vDbiDFfK9uIwBVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAxwojHw1+tnGIs99HhnTMS80yR2KASr9vPIeNqKOcxyACXen
	eYTu0UOBIp7RcDDw529WaTb/RxwcgqrpcSDa1ZdxRse+BQiHWxdPBBRy8nj6Xlt8xVWvSnYaP7e
	BOY3HfREKgTEq/kihZeMqe/S8943uH6o3ppUzdejnE2+ozUNvcLt251eswSQ=
X-Google-Smtp-Source: AGHT+IHGIbfB2unzijK5gMOw759Om0Rf6Jeus8P2wqUolAjqSQplEmNYjeM9qDA6HXO5/1Y5zE64m1y/4Q2kjRlhI+lnkVS9e/65
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c248:0:b0:424:2d4:5844 with SMTP id
 e9e14a558f8ab-42581df7123mr74903355ab.5.1758698582570; Wed, 24 Sep 2025
 00:23:02 -0700 (PDT)
Date: Wed, 24 Sep 2025 00:23:02 -0700
In-Reply-To: <CAL4kbRPJhQq7r8Ts_iuqW0c=__eWgdYvVmBLCx+DCj8RkEEf=Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d39c56.050a0220.139b6.002d.GAE@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in device_move
From: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
To: kriish.sharma2006@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com
Tested-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com

Tested on:

commit:         7595b66a Merge tag 'selinux-pr-20250624' of git://git...
git tree:       http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=16e38f12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce6bd0b8c05c11a2
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4e278e8e1a9b01f95f
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

