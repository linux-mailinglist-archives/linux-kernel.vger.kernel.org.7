Return-Path: <linux-kernel+bounces-655092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA837ABD0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 09:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF957AA1D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 07:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0DC25DD05;
	Tue, 20 May 2025 07:44:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F325DAF0
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727075; cv=none; b=kWX7ODkUiJf5ATQVA3uaxq7rNsuWaW2NvAY9i6rWHC6LVk38oLD4HZ3fSAbzu6NK1zbduB84mng0alIpsnqezQ7/KANhDCcbK+5zygWps1MkD8EwShEy4Pgs3QWxDNAyqsKqkyZSvFsxaVPgTk7a78JkAVGtgCOO5yGbXsozkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727075; c=relaxed/simple;
	bh=E4uACfTAz0MJuk2mr0l6hE64Eeu49Jl8qxtmdtaSits=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MwTecSrhczkAWlcqPOTYeC9KbGrdZIzWnooAnTW8exCGOjmcipEUcjq7sToRea5LeBFjPqINYKiIAzX9gRaMSQD/Pu0nBEIOU+I60pVJ2m/OiN24OrBi5/3XdG1AfBQTJHoARv5ejWFwvjUKbz5IAOyQuYP8CmFZesHCPiZZmNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86a3d964d9fso172599839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 00:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747727073; x=1748331873;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9etdKII+Xd7yjzPdX6DtY4eVU4vcKzOAV8VxGSqiZ8U=;
        b=P7sKZ+NVD/NCmWzSbra63g7xfYIeQZssTQyic3DZm9mNaxiSdzHvP3m04gPjH1en5I
         TObSOxFlbEq+vVqR6T6hb+9MCkUmwOQSE4NZVhqg1sN/X0D8mcX0rluN8SlDbwBJeJl2
         xfz0F6tww5xP49oC9vElckiZoL7jOUSqDuFGwyyJNK5hihzMDRWOjtCnxdOmW8btk25y
         K4JFdANSU8NFOaNj+SALln5u3z1NZOWbPLRbvfIqKL8H6DSMVl4c8yHKhpuFoNWKFr6K
         +OGKAqUWWq8NWlGX2POw7JO7c5sW9jmwQCSMteXDGkVgkxj16cqFXbj+B+NiHCHI32l6
         ZVNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb6doWiHD1T+iG9v0mmH7h0+KXgIdROOC5rtvvaqfWd6sZRCe7dXBf2cwf+1r74ODB9HrA1FRDzZbBfj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4I+D9++t9ceMTVRABeCITlxVzx1Myi3IXMdUFbUrp4aqP0Vm
	iMYRbB7G8LhF8WW/cldw2c1D1fIiCibKZOwh/vNUfZ4q/gUrcZfU015LWrHyzHSwJVyXtRGNZIh
	0AqTmQwlbLAd/X2a+23wtUqP1x+kBg5w7sbpejbstarCk60WOReyyihPwmls=
X-Google-Smtp-Source: AGHT+IGlAn6KQq+4218UvUGgAPATNp0Gpb8ky9lQM+mV+haSuS/HwGgMKH5bQRTd9Tp8tk+hCPSKCY55Yfs3jNqkHsbE/U250y1a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:f40e:0:b0:85b:3ae9:da01 with SMTP id
 ca18e2360f4ac-86a174c1798mr1581221839f.4.1747727072979; Tue, 20 May 2025
 00:44:32 -0700 (PDT)
Date: Tue, 20 May 2025 00:44:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682c32e0.a00a0220.29bc26.0275.GAE@google.com>
Subject: [syzbot] Monthly afs report (May 2025)
From: syzbot <syzbot+lista6cca35c0d96ce88bf4c@syzkaller.appspotmail.com>
To: linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello afs maintainers/developers,

This is a 31-day syzbot report for the afs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/afs

During the period, 1 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 48 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 522     Yes   KASAN: slab-out-of-bounds Read in afs_proc_addr_prefs_write
                  https://syzkaller.appspot.com/bug?extid=7741f872f3c53385a2e2
<2> 25      Yes   INFO: task hung in afs_cell_purge (2)
                  https://syzkaller.appspot.com/bug?extid=750f21d691e244b473b1
<3> 9       Yes   WARNING: ODEBUG bug in delete_node (3)
                  https://syzkaller.appspot.com/bug?extid=ab13429207fe1c8c92e8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

