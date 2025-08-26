Return-Path: <linux-kernel+bounces-786105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD28B3550B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C717855F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0D2F6571;
	Tue, 26 Aug 2025 07:13:36 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562F2F60CF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192415; cv=none; b=n0aMPs4GU1dA+DTr545canpq9Tw1o8GytIH+v1xY6oHkPFa8oc6kbdFyrBkQkjRk4jlJ/iLthDae05oHj+yi9eAeUwD78cTiWWKDhjRAFm+C9qxZsE+jWUAaNoNnhg/A9fbK7gAP/LUxhkogdT5AnBae3+ezY0/lgtTzs7Rbq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192415; c=relaxed/simple;
	bh=ztmg8NvkeECnbDbIaWKbTAmg7kuu7PJy9Zp6iC3CaIM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P3d3KTxwZGsyzMUKC9QYRQ4wqW7227I4flZb0FOeGtbQP2l9rypFz3dK2mpBA/IzekskBnbxp0W0GOK8DOK/rJrP5JNqDmuUbczmoXm/wvi4RZTdfAwyH9sEmZqQX4Rl0vuPEQJljLTMcZlFd+fEiNoMXmNoMXXiywx6W0bgHc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso747117539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756192413; x=1756797213;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGecIXFYhnQ2n6KxVp+NizCLs7j3DYDA1Kg0vFKuV0o=;
        b=Kopl3kKDWKNp9MDi6WrGGQcyUDjXrhLEGUGpSW7a9JHBWI4uYsbOHBDmvKMo54ObNN
         qGBondQpheU9M0porhK9EXLB1iO2HbZR0uxVqs6rLicMyEHCyoI5JOWM27858qsgseZF
         2hMSs92SSlv+Ul6W+lGdxeZ36cUmnXlql+WC+DjG9UsdC7sOfHTftijG6WwW2KFldb0n
         ohBK5pYmXCZheVJXNvXG/lCyVH6BV03eD8sWHz1MVAG9c4gsfCn0c0cpp3eEPidP3OuN
         EQ5fjKuj3Sczybfwo+YfqB3/IDSxT/vDP8na8FE0Homzq25i4zUURH5Vm11ERHRxc+QP
         Z5OA==
X-Forwarded-Encrypted: i=1; AJvYcCVwgCqP62lxzDYl5bd8hmKuF81MqUuKArrbqRWDfqaX5ogH4drjfYKJSoP6uWvL+74FKc/coWYp9wCw8TM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYPY33Z+UUwf7m2F7UpslZcPfGwDZbjGXnpYJDt1wJIx8aC/W/
	tf0jPdLThNPTlaStTfTxlB723zpYKUoiOUF1Dja3pzpZ9V8u4kd45IP9v6sI2vtple++0gni+sV
	I1MyBWlYLlEQ2rIifhCrEZui/fzK7IIX3K74vuUIdmzUdpreLARdFC4Nn8R8=
X-Google-Smtp-Source: AGHT+IFFv/ZlXTHe873XhXQC5IZFfNTguk+KAkxQHNL4r1vgGYlw5QhVcScv99RFyH2d0onoX5zpI4/w0ej7wd2M1i6ehtHhVMWc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:470f:b0:3ec:98b9:ebd with SMTP id
 e9e14a558f8ab-3ef087645camr5440855ab.5.1756192413518; Tue, 26 Aug 2025
 00:13:33 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:13:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ad5e9d.050a0220.37038e.00ae.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Aug 2025)
From: syzbot <syzbot+list33243a939288f65f949f@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 37 issues are still open and 102 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6554    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  4619    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  1803    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  1023    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  1008    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<6>  612     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  610     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<8>  467     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  376     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<10> 163     Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

