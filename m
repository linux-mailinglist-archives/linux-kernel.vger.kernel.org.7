Return-Path: <linux-kernel+bounces-688038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A959ADACE4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A05616F434
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4261F29CB32;
	Mon, 16 Jun 2025 09:59:24 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840225D90D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067963; cv=none; b=igQfow96My2QROmNZlLoV0BoSvipD9LM7E+5qXDS/abCPdm7+UEcajLUqjtC5S/4k823lwKvWoHVMf5bymRKhI+XlFwMx8MYe9FgPuBbmWF5IflS/x/MqOllCfdw3/6a0N6QR8TthvpyDKRaeuj0bIB4zy+Pk6cyU7P0ZkXSV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067963; c=relaxed/simple;
	bh=+G6cA1eoPE5yUEpvUgaEYQFhvUsFGDyIorb889FsJ24=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bs9Os/XUyMkLd7mFooBZRZ8WAWTE5TVpt65bNUH31E+T0CUTthzylLYeo+ItFEMSThZYwWRse3doUTgwa5qSUvlcP/tKXuYOx7V8HS/hWO3vZROe6xK8tGE3GYvR3J1/KlX8/osooZayYRK5Xe+4A025JefZ1G3MPwPE7SV2NdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso45206795ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 02:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067961; x=1750672761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sZdGWPFUAn9yrC9BQVibxcmCvDvTE7yLyusDrl1BjnU=;
        b=nW8dZbP+9BlYTHMEgwPhm8iSoXCOnWNkBGHGaOLFpRh/ZOm0yKY9WL5mVDLaAFAmqz
         GWWWqf0G0tKx7FVpo9bL3DmnVKnSkxiLcdFTz4iliGXhd0qiAgvc/gvmDx6Dx74ITzAO
         yolZFp5jrqWTO6Vkv47YRbC8KsKuLzg+YCb598mWcJYD+0KFbbPhbFqkk8NcPCiblCjV
         9DynNyOh+StQLB72WyuoIs+jVOegNr42nfz4EE9f5XcK9u7rT2hWH/dhX6l/FZhAvnz8
         W5roMjDhjZVQb+O1N0g+eC943FDvww9D6qKxamVLHvknlirS2MBB3mqH9MaK82NQXIT2
         TbvA==
X-Forwarded-Encrypted: i=1; AJvYcCXznofNY7h/eMLdc9M5EBYzNVw/W2/lxKOJ/UslGvPgxxeACkmigg+5/GG5v1uutdz38rt04YRhoqjJ1IU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpW+BLjeNGMf7zSQuL36ZgnJdfSYXhjnVvT6U8muwiBBc4/YR6
	RixXCcQ2WUoSz32zj8ZfnOMdVgVBxYpT0Kzy9TOYqocfyWAsiX0a9eJ32g4ftrc04lixhHgzrNp
	Ky3NP2YLPIqtgYNuPRILkhy4LjhKVr8KQ68+NTU1Cs7P4yIk7VlsQYrvDCCE=
X-Google-Smtp-Source: AGHT+IGSHY4smmsVXnxGL4aswr/oNdPMG+eiqWmOTkox/DNcsFbNYE+3vSPkrdQ9QXwIuhgu4vB/YW9gfMLheAp1bllU5DIOY1ah
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3786:b0:3dc:8423:5440 with SMTP id
 e9e14a558f8ab-3de07c4506emr81834735ab.0.1750067961473; Mon, 16 Jun 2025
 02:59:21 -0700 (PDT)
Date: Mon, 16 Jun 2025 02:59:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684feaf9.050a0220.3aca5c.000d.GAE@google.com>
Subject: [syzbot] Monthly v9fs report (Jun 2025)
From: syzbot <syzbot+list398904ba9851c202b09d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 37 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 357     Yes   INFO: task hung in v9fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=56bd5818697f0f93fdd9
<2> 166     Yes   INFO: task hung in __iterate_supers
                  https://syzkaller.appspot.com/bug?extid=b10aefdd9ef275e9368d
<3> 66      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

