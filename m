Return-Path: <linux-kernel+bounces-833613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D29BA26B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB037A852A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2006276047;
	Fri, 26 Sep 2025 05:14:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C625EF81
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758863673; cv=none; b=OVC+zX50itNRNEjjoW+S633hik5ZxcWaICLSAF33ng0ix5TZ0uh+0JaRMYldjvs2w2PnnV7UCOehXt9852aEdE1+fweaalpAi4Wtr9DzsboAAcsPpaD3UTEFWOVPJjFldnfNIXapR7jCSUhPmuLP8CdxnGpDknFT+pPQmFxLopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758863673; c=relaxed/simple;
	bh=7xTE3Rx1L7oOgBFYk71dDAN47JIjiPqupVey0hwIlLY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mZ4on4O9w2M4NdPVKmM6rKY0shwPTfTCl+HmWMY9UnPCfj16fLqSCdokl3omvysH4Q1UM6Dxc9GTWpzXSRhoHcHluapWz/MO6Xr7rHnAL8XHBEFe3YzLaa3a5oJTXedd4DNF+ex2WU/5wk37i2gC/+8+0INv694rPqP5fKoZ1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42640cbf7f2so30666455ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 22:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758863671; x=1759468471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RubBGPWU6T3hmpYOlUHJW5RbqgzcHSdZkExXWcWqgHY=;
        b=XTBYqwaIACHVe3W4KiM5rbqYXEUl5Coae/nBjUxTWP6jQeAUZNVW0RV0hMSCQPA4Ng
         O5KktoZMg3CsFOvTQY1qaH5jfyf+S2kXKWziN9xFHcfnMS1qOAUki7UeAHzXMNwmYd4e
         jpHxVkEW3Ktout+Hvfrmw67tIEnMcbdBtVmnI60iXWbpH9a4cy9DSo2HZeTtKFnBjthR
         el97OSW3RRViCARhjOqbINfU5Mf4dJ2kepjaws7xI2i/n0uwlV2EB5hkQAn8s6nj7OIM
         0X58plWVdCWHu6Ttt0FW3ZPbaF2MkWuSSFiA5uvKGX3qce5BV5wnsMIarzg/ylYFTkZR
         cVFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvAbCPL4rdzZZwgKh2V0ntXWDaq1vCnWEEpsd+aT5UDP6/C5+H2bMdRZE+tPr/t3iKysihKKdmdiUfgnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaIBdqnFBK39Z/zd+yOvAV0ZXPCRQMbZ0m+Cs6V05zdHOjE1/
	D/ZuqGYOIvmIRi2gJ9j6mgD7MqA26y+k8XIzkLS2VTrGS/jwqylzR1Vjczgxz+mhtCzdNi71SVd
	TxYeVLZ74MENs4a3fzWHA7ve/1XD5AeHE6+eEIpuFtE8/aizYqihEg9KE9wM=
X-Google-Smtp-Source: AGHT+IGIgc/06/E7PACHY/1LCNatOmj7eTgGWoSG0+izopBNDeBPZAV4tr2DNLefGdcGwQxK85V+uXMzZ04G4JIb38a7AEtDqVqy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3805:b0:426:9b42:2a06 with SMTP id
 e9e14a558f8ab-4269b422a6cmr51217405ab.3.1758863670907; Thu, 25 Sep 2025
 22:14:30 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d62136.050a0220.3390a8.0006.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Sep 2025)
From: syzbot <syzbot+list00766dc1df4db65f374b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 32 issues are still open and 103 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6558    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  4748    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  2686    Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  1061    Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  1029    Yes   WARNING in btrfs_create_pending_block_groups (2)
                   https://syzkaller.appspot.com/bug?extid=b0643a1387dac0572b27
<6>  624     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  470     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<8>  409     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<9>  153     Yes   kernel BUG in clear_state_bit
                   https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3
<10> 105     Yes   KMSAN: uninit-value in iov_iter_alignment_iovec
                   https://syzkaller.appspot.com/bug?extid=f2a9c06bfaa027217ebb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

