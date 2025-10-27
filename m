Return-Path: <linux-kernel+bounces-871593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81545C0DB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D006A420173
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870F62571C5;
	Mon, 27 Oct 2025 12:50:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D423D7C0
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569428; cv=none; b=Rj/eUuU0D/EeZm2dmH3k+rjuE+o11pgiMdB/aV4gx8VutPzDUC4VYRXeWBu0v4zkhBFyU0CkRaT97D4V17y1TnsHqFBQTeBVo8PCkZ+ytk9EV2hdmwse1Eg333fesyJG6895H2UazvN50Nj2DwhlAVfqkUTXqbUFW+xz3H0aF4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569428; c=relaxed/simple;
	bh=2VjJ8sMDkCHmRqjZL6d1XSWSqszCfqqWrG2N6XOTTwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HsB3gxulUddd56L5XsM71zoX872/EZBVy8azMTS/1ICKc6vdVwb/jkXSqA326qjgOET3aBuCEcx/v4bPiW0K8g8GfACq5g0910OOMtrR2GIOWbsU5HfOXKytlcpyj16ifHR8oGZSFIyd9TIcUKpSszMCn1RmoB8dggjwvH5yj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430c8321bc1so58514255ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:50:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761569425; x=1762174225;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtFhaNmyTGw2XBAyhOizrKXPPDjjzz9Izp7uPIiOQ9A=;
        b=h2tHCsjRxaTYBUCjKLe3NplbDzP2WadX1AfRAyBxG5UftO+0OIt2SG5rRH1FaGkFZk
         +4ziB0WP/XuyZhInTQPcr/AuzoC9jAse4NfmJbx+zidJ762+vwHhVz1wYcwBVK/xq95A
         n7c/CMzb5gwkLJ3Y+4hqQClWfJxqx9M3XFOfdB4RsL9ffUk+HDKtTDAn+cbVkQLm0CB3
         Xh9GbEDzEBRC5yvMDninbOcU6RLq85Uq9rKRIYRiSdczoK+FA6udEwG2cgCEJkVEOMoc
         g/jq8SmYCVITX/dvxZxvEz/Q0PDIOITP/s9BDrP88yqyL47aPJmxWhmhKN60Wqu9cpt3
         ZifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhAhT2HsEqJolbC/XoEp1iYc/xh7MbzZ1hUCeQJwxmrbCtA+IFS9lKOa+I1IlH3H+gb7B0Cy3/Xzvtf+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCYagaTB75uru5EvPDaYzVLf4Mozo1+JKQh3IKPnh2aVcSyN5
	pTWJufDl92Xbw6mFzu51f/ugZYSvk8L1DoiiaGXtr2Wp1TkRMfFSwSQvHp8II0LjNeHMJ2l0k5y
	zCFcNBezjFY33xVee1m80FhO3bdA+uVIAxVeYSCBpy082qxxE4SSpvU1tvWA=
X-Google-Smtp-Source: AGHT+IGu3bk2hiWiNXZTfm8L31A8IlrlIqfMTnM2z9kq5SyYmISkYZGhYoS+XrnnAvp3JxEcfTdgGF/XkrwcTNc+Eig+3QrDhdqn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:42e:7273:a370 with SMTP id
 e9e14a558f8ab-430c524bd83mr506139415ab.5.1761569424932; Mon, 27 Oct 2025
 05:50:24 -0700 (PDT)
Date: Mon, 27 Oct 2025 05:50:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff6a90.050a0220.3344a1.0395.GAE@google.com>
Subject: [syzbot] Monthly udf report (Oct 2025)
From: syzbot <syzbot+list2aa8cf8a51429940098b@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 14478   Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 1386    Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 626     Yes   possible deadlock in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=d472c32c5dd4cd2fb5c5
<4> 114     Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<5> 59      Yes   WARNING in bdev_getblk (2)
                  https://syzkaller.appspot.com/bug?extid=7f94fe3ce0f6613e12b8
<6> 17      No    KASAN: slab-out-of-bounds Write in udf_write_aext (2)
                  https://syzkaller.appspot.com/bug?extid=4e1da0d327b65949fe1b
<7> 5       Yes   WARNING in udf_fiiter_add_entry
                  https://syzkaller.appspot.com/bug?extid=969e250fc7983fc7417c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

