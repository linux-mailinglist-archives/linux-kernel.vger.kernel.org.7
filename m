Return-Path: <linux-kernel+bounces-710924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CBAEF331
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 11:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953104442CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007726B771;
	Tue,  1 Jul 2025 09:24:36 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EAE33EC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361876; cv=none; b=MQGmSNapguE0hhiF9sNnDlXNEFPZDRKszlquy8mEC9gqEwR+f8Pe5MBVnEFDAUFwT7nn7YCdgNDobGf2T1mnyH8ANnWCB1o9cEg1iXvM9Ck4cntH5PGI3IlU7KnHYRvNSNC/LV8GHAsDDdrvV2up54B12eGVgtmKVQ9mow0GITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361876; c=relaxed/simple;
	bh=Xv2iW2gtvl6CNf/i0me7nJrYn+6nAhbJzbC+kCbet6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XnLy4FVlfR0YregbLM0qPYsAplociSaREqwAwMV/+o5yGj5WZ89lM64vboXbp211MS+Y3Q+Uxbgqj4QC5jSrRXQ5vjPl0fM7Ohxby2wZn+FBtWglCQ80liMgZP9BXWbeh9LlmKjb09G8nWBA9ZZk3eee+OH7vTagSUB7aH0Ge4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86d126265baso536094439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 02:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361874; x=1751966674;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HQkRjM+wMVmwrM75e3vmov9+3qgHon/V+9yiB5mGt8=;
        b=HgZgZ/iEX50uB6tImYxMDhmZJq/QCnU5XERdOZ8aBg47TTJZs2FC6mIB341KzFHnbj
         gX+lDr5SaTpPan2CeRj7SHTwCfYHhbWWCdsrkYsDQSlZD1G9SNNwbHRjg3+a57I2MMg3
         GW+pY4nygeYRxHsyDS7ppc0oNPzD7XWhghpUD94b32ThGjjbl5ML+Ww3iMngCV3t0qOE
         WN+zxXxE+Fgz1HUmPgqo0ISJyqT2A37xLSZZA9hg+hcF+IfIa9LOhOHm/r4FCWhvtpQc
         ymiQKEieN7vnaIx1MrE3OEZbrVweoOLsGsEIpTtGv6gRaLHwR8pwY+uPfrr2+0LpVyLz
         aKVw==
X-Forwarded-Encrypted: i=1; AJvYcCXqM/gtsbhMG2q9Gjkp5vHEtaGFCvX0XRTM5Rqf0xYhPCGLCf3+vBY3gpmEnJz7J684Wi3JX/tNdIVOe/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwh+uvCW8o5OKxcImpmRvcSrM9q+FpRyTjezwL7SN4lGEZI0WW
	OrQ8JcJrWSlERPiaUBPZkw/NcgXGeNT+WZLdI8LyNlTSnndP1pAlhvXEcABRGv7/3+3dbrojbwT
	TcwwfKnp3BYRVlWYVIPoKW79OhKW56tb9ape5rRj3SUPrqYSiZ2WUYalVrPM=
X-Google-Smtp-Source: AGHT+IE6c+AGnTS3ZbMGH35CG/yju3u/WvJ2LXQ90c2nXToItc6Ymhz58/GBqgiJSh8iXnNkDFwQH247cEdand4Avtz+3PNng2HW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d82:b0:86a:24a7:cecb with SMTP id
 ca18e2360f4ac-87688580104mr2075632839f.4.1751361874347; Tue, 01 Jul 2025
 02:24:34 -0700 (PDT)
Date: Tue, 01 Jul 2025 02:24:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6863a952.a70a0220.3b7e22.18db.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Jul 2025)
From: syzbot <syzbot+list8c6bf11f7f6a30f5a841@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 2 new issues were detected and 1 were fixed.
In total, 14 issues are still open and 61 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4275    Yes   kernel BUG in f2fs_sync_node_pages
                  https://syzkaller.appspot.com/bug?extid=bcdfadd9bda9988fa52a
<2> 1277    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 796     Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<4> 34      No    INFO: task hung in sb_start_write (2)
                  https://syzkaller.appspot.com/bug?extid=b3fba2e269970207b61d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

