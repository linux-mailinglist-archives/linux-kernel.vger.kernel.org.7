Return-Path: <linux-kernel+bounces-661677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E548AC2EBF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 12:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 140D24A7109
	for <lists+linux-kernel@lfdr.de>; Sat, 24 May 2025 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3951A2622;
	Sat, 24 May 2025 10:05:36 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5A1991CB
	for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 10:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748081136; cv=none; b=bJcVF4qv2a+/N/fqV5lVghVmMWMitt7jmzkcd2dbN9BliPcQWkF2/EYlUl31Jvm+J2+ST2dcDghhQuXoBE1rnLUqmPn8mFYg30Wy0HXatSLBFu/Qx+vkOf3/XPjQnN1QPGX9sTtwRbwK5IDEBvO7uAOyboChMERnMJ/6YwBe4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748081136; c=relaxed/simple;
	bh=yI83KbbXPbw/wz1OBc9AsfgSFLnZ+S5RUfACEYNLVwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fc1+7c3ZJE1NM+P19PzTwwQlHUcyWoICGPPlU51Nsn8oqv5DvARL8sMi2tPR6cHnhlgS6GGZ02pdcLGI/0CLSpD8dVXK7CI81kAdAlvmi5Jn8yCELDoP1qfOALKSCFk1T2WduxZenu4DciQY1ko1gV3A6rv6Mo2WZJoM9GQYR/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-85b5875e250so58623739f.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 May 2025 03:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748081134; x=1748685934;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72TZzeVz5pIx3nUCa7tp8y8rlKNxxE5AJjqfDXw+Knk=;
        b=f9I4D06hLAk979l5nDSPmXaiP/LiXKG1fHDMoJXcZzC6LnhoO6VHFcNgDmIM19pilq
         T8wOJ7asdvRDxRqws2VFzvpJiKPKKE/StPDoyNsITA6HBTuoTxUnTutr20VWb+bR5xph
         /pVBhh70XhO9ahOXKcAF2hzeEd+w9a0DtsIz5/5pCsAi/dD25psTJhV3XA9Iw+hNkQ3U
         z8anroxoslc4NL/hG9XT39P+ZB3X8SZeemYjNfiJckHs8IZ9O4odCTb9HCDZeRuOtBie
         WaC2sA6lz7VryDZxyiuufVzrPIqbCRi3Y03ux8erKmAvCX7yZm/04lNVYzgQUj4gXo7l
         UiCg==
X-Forwarded-Encrypted: i=1; AJvYcCWWzirosvSNKG0x4m+DJrvLknaoT+3cg6aSWxQl02h9gWwWZ0G6P4ZJBz312u0rw8OMJeY+QrFrzErjH9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKL9hHJ6GF6PiRf7Tokh8o8COfaty+CixDveUm1mvSertxkv8
	wQfroH8r9KqJ4iVvS1zBpjaen2p3VH4+Ffo9mccugw7ibW294cIiu4JyyejDXFyJwpRT2OUhdd0
	0SZFAMjYOmTrgviZf7dDn6kp0l7uhiGWtC3NEviUs8Dw9rUAzuzDpJIbm8Jg=
X-Google-Smtp-Source: AGHT+IE2W+8SxVjfsp0YbiuxxaOKuOc9bD5kO0FMWoCBPaw8KYGj2UP21WPi/8TGuDevm9Pxobije/kOXXMcPk4mt8Rnp1SsPAWK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c0f:b0:85b:3677:fa8b with SMTP id
 ca18e2360f4ac-86cbb8b0274mr248890039f.13.1748081133968; Sat, 24 May 2025
 03:05:33 -0700 (PDT)
Date: Sat, 24 May 2025 03:05:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683199ed.a70a0220.29d4a0.07f7.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (May 2025)
From: syzbot <syzbot+list0342ea7ade476232fc00@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 99 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4130    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<2>  1280    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<3>  816     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<4>  604     Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<5>  430     Yes   general protection fault in btrfs_root_node
                   https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
<6>  416     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  408     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  302     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  240     Yes   WARNING in btrfs_release_global_block_rsv (2)
                   https://syzkaller.appspot.com/bug?extid=48ed002119c0f19daf63
<10> 145     Yes   WARNING in btrfs_put_block_group
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

