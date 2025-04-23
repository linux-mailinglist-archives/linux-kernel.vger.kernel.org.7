Return-Path: <linux-kernel+bounces-615730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE555A981A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 09:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012551B6136A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD2227466A;
	Wed, 23 Apr 2025 07:50:43 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9526FA74
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394643; cv=none; b=Kz/xENZI+Adr7Wq8FcTdGmLYDnK5mOjRyvRnwGk1BzD0tbFYl5FPxqsJILXidz4P9mOMfUua7bZAvyowc1hhTao1gSeqf+PW+iDOgTRXCVTgwalHTGqT/ki6x9oySDL+83lLwngDYwz1kfLEAnOSOupvk5QF0SgzkYj2yWocdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394643; c=relaxed/simple;
	bh=BoARJzZ83zs+7xeIkdRvKTuWiSeHFhy64y4LbK2mO/s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kMkcCHJS+CnuTVmPhPamuMKtqKaJ8j/d0Km6BhV8Rk3eoiO81hqyR3pCbIKb8V3PZ7S6/qZ17b9MQgy7yFGcozFokwB6qUv01wXAAOOwW7ecqHHTSycaggXSxkYfv2NOUHTBjCWl6K6Jw+Tj6RVSZM9YL7fo7J7bld1LwCPrA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d6c613bd79so62886585ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 00:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745394640; x=1745999440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFGA82u+4y4eg+LttsMRjQNKedgrA3NrpNTTw1eRL0A=;
        b=oRDB4I2jSDsVs7YNjv+MSWuqfsU2OztlJWwsqfj+XS99OROaopbTUupyFskjOsD/gN
         5bWXzelef5ipeNYSuRDLlpTZdHv0Qdb/BVGPOduozCM/28sQG8zMz2PWKeNAGa4vB9sw
         0/cs1JKmYBaF/0N/YQMMqqFnkCg6Rs8tUwQ+RbFAI3hdhvy2Q9sYxhGtuQ2CNkSOITAK
         0pnl053i2yXyA5dd0ox5pmjYVLMCU/0xqEM7u7sWe6jKHMSE0zUh4/AzdMaNy5HcrMAA
         eDHeAMt8wUUNnuRkgsGUsEweH2T8kSfXkFRA8y6msJWJmI8SISQWGt3ZgWREo2CqOLXn
         28dA==
X-Forwarded-Encrypted: i=1; AJvYcCXATxgrk4p7e04Es+z2127N/gWAFjkKUFMctD59qUvRaWCKX+OTE8y0zJdPO+X/t0yqFlAXROZj2zw9UhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzue5r7+OaJDGh7QaIUe6T1lEx9WELlvGh2X6Kuiajq2/uzyNnn
	7aaV/+I+16+nS+Aka7KKwPdFOEn4oF9klgkf4ZXlYP57J/R049CLN93RTphuA5spcyW+hEiqICc
	j6jxHArGyYeVDZuFRzWPycrgITsnzFBfwkFtCxGXByfKcf5BWI3pj284=
X-Google-Smtp-Source: AGHT+IE9Cn9WVzXJoCbu7c0dmeAUYdFEyATBRkXaPE0R46JDxfOGDNXnlpfeBZKDNpbcX9gOd8dnU1PE7+rb5ImF2KThHAnNDU+A
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:3d6:cb9b:cbec with SMTP id
 e9e14a558f8ab-3d88ed7c3dbmr195966975ab.5.1745394639869; Wed, 23 Apr 2025
 00:50:39 -0700 (PDT)
Date: Wed, 23 Apr 2025 00:50:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68089bcf.050a0220.36a438.000e.GAE@google.com>
Subject: [syzbot] Monthly udf report (Apr 2025)
From: syzbot <syzbot+list5bcdc263eb83fc6a717b@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 36 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 10129   Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 1049    Yes   WARNING in __udf_add_aext (3)
                  https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
<3> 37      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

