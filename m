Return-Path: <linux-kernel+bounces-826427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F293B8E810
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 00:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92C6189B012
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41758248C;
	Sun, 21 Sep 2025 22:02:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E5185955
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492152; cv=none; b=aRozXw9kZMAmhJvWvav0qFEwfQLW++Ko8NU6Q3pDc5R2kZFZZK6Ta8QSVqaLeRcFKMsQUTy22y5j2+upTQt+osLpYZFci/IBVsOzvbExPIReADLkbNFCfQYFUqi35lXY9gvusrBP+NrNmeYbsLBR0T0hFlt5FsJTZVr0iH0YbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492152; c=relaxed/simple;
	bh=+XlZojJtTDKRE98RhcmqipERzvJu7jEpUtHwvEI0L3s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TMobXuoT2Wh6CpPZBAZcM7k1Je6QASXfWXrTkKvqn6oZw7MWTdl4k8SoRrNSgjK0e5RKfMBAsSjR8w+EI4VeprCf78mJFxoRTChOBjUUkGZyan+9t6FpDxDlldMoI8MSW7oPILD3jN2ocC2gFjJBHreMA0fFaAG6DtHde630uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4257462ab66so18904165ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 15:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758492150; x=1759096950;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6DxhZC3m/OCA7QtH0RBYw7QU4Cim20zL6xqbEC0Kus=;
        b=Ft/8QcocA4OJGoKfUXwd3K9ij48HaINCLUqmbrJKWIhdc7BgQzX6VIIbBOaN3TsX1K
         UDIPaTX3aCYL6eeTVfxzEOjGsu++XceSPO4XObqa1aIcU8m0m1R9D3GK2uspCOetgp1d
         mIJX2bUy4yAh6n52gx5EstP0GYzBz/Xc08atGRzfA7z39QGWDDB6Pgq6tSkK6ZugoECY
         QYHPbYnJNILY+4cqByO5SBJ5rX7yORk7G5H2UMlJMce8/ul+ayLlR/QEhLGQk6pesr6a
         BQjHchrSkM/LhQKgQrV+BGuBJW/tsnc+sMiLtJVvcPpHiDPc4fbVZADyIky5jm/Y5Pvj
         gCGA==
X-Gm-Message-State: AOJu0YxP5J5GO7unUMMjjYZ+uODdm1I1yihjDtPPaPbD30UKemyWIy6N
	LolBxCQs1jO3PTrefkEaQ5FJ6PGkIG+O44VXFpP7GPX1pMAqBXW6Vyh+4J19hGMUeLp46CBDfzb
	AJWRbs9Vddavy3cvKj/Kn1fIcDMfxoPOV7STWdw4IAHj2BcZjqYoDJqJjK2M=
X-Google-Smtp-Source: AGHT+IF3EFkQ/ZnlEHk9t7xQxkHgRkUuEIBNJ0dZM3cnhV00XoYZlti0EzXvqjwN6VGsSl1HuY2lS9okIQoxd4yRn4fzxcrTX7Pq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378c:b0:424:805a:be8c with SMTP id
 e9e14a558f8ab-42481937382mr133139195ab.8.1758492150202; Sun, 21 Sep 2025
 15:02:30 -0700 (PDT)
Date: Sun, 21 Sep 2025 15:02:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d075f6.a00a0220.37dadf.0043.GAE@google.com>
Subject: [syzbot] Monthly rdma report (Sep 2025)
From: syzbot <syzbot+list76811b2adc55ba6d5022@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello rdma maintainers/developers,

This is a 31-day syzbot report for the rdma subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/rdma

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 66 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 818     No    INFO: task hung in rdma_dev_change_netns
                  https://syzkaller.appspot.com/bug?extid=73c5eab674c7e1e7012e
<2> 470     Yes   WARNING in rxe_pool_cleanup
                  https://syzkaller.appspot.com/bug?extid=221e213bf17f17e0d6cd
<3> 81      No    INFO: task hung in add_one_compat_dev (3)
                  https://syzkaller.appspot.com/bug?extid=6dee15fdb0606ef7b6ba
<4> 67      No    INFO: task hung in rdma_dev_exit_net (6)
                  https://syzkaller.appspot.com/bug?extid=3658758f38a2f0f062e7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

