Return-Path: <linux-kernel+bounces-833435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A83BA1F47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A314189E842
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F172ECD27;
	Thu, 25 Sep 2025 23:19:56 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBFD2D24B4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842395; cv=none; b=aD28gOMZHkQAfV/FjlKkMN2bRasczv8PngfOapR//CvQQWxfqxrWSk+S1K3c/B2dsmrcw/ofdNuWaGwABxSnF8wmuA/TQ3NumyON773orCUqRA49yKgmB3LTLaEdqMjpAmoRuE4IJHWmdWDkMQ5SovE8qL6UTe9sS45o1wj8CWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842395; c=relaxed/simple;
	bh=V/CdUada7iXZR4rEyz9RDA2ZDVmTnpw3JSIv64HjZ14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jPeNV+0yH4qfy3qClJkAPoS6QzlxLPOXefLwhgOibx3TvLIH91jtOO5PlBsKhj5IAAmJxOHe26NAcb5Pv0WO/0yXECXHmtu6uPVljqKl0j5as/TInPzd3lhRmtOZtRdNZVTaAGMN2HAW05yXtAWv8p4M+djdq94iR8XCyx1Cqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42594b7f2ddso23232495ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842393; x=1759447193;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUY5B0L3NTVJlK2+SN5PD/Pw6QTKWkT/zpDzKOEtagM=;
        b=hcZAfc4oGblIDwUwk1DjzaeyqJlsI6nS66EwmcYnbHCADBRxs5viRB1D/HDo+96G0o
         cIMLOFrLFughhgUtCDFXZJDGReE9l63Iz329UwsH2Cpjgx4joB8FVtfuZzePvBtPuapw
         zEoPWKPlG/XaixEFSJn+XS+kAE989FBhA29V23Ave+zM8TNTQ6dLje+as8WowsbnOmvF
         P43PLqQU03yDNls4hyr8HVb1skkKv2MEQF+zdARSUjM1CbIVakfSCKorumvnVEZqF8F5
         xet01W7iZ4z8gLwKi2rnjpnMme7hJ6WVpcAgZKSAUe87KyMfxjHPXPmZrM6lJmFvwzC3
         hUqg==
X-Gm-Message-State: AOJu0Yyx3S3FUBGfWA8wKxlfdSzs3FhhRGLjL27WHjLLiIrYG9wRjDoQ
	FI8PBwQRyIv9aR97bOuRT4ILwCKuqJ+3sbwZexz6rZ55OCM7FsYBXXlovVGSe5Nfa88i1dmgGFK
	C/zeIF4aol2MbgWcZyixlGOFQQapBSdD2vSrDtFa0/+AQx+QrdjsHoqt8YaY=
X-Google-Smtp-Source: AGHT+IHqU8gEjWWSwr7PAqNkjEg7HeVdHAUSc1Nol4Vx+xDhqWqJs3SqOVYbxybAXmZDLo37gGlbM6V5pxwrikZtBvIt4r/tch7I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4514:b0:424:cf7:7d04 with SMTP id
 e9e14a558f8ab-425955d0128mr75602705ab.4.1758842393660; Thu, 25 Sep 2025
 16:19:53 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:19:53 -0700
In-Reply-To: <68d26261.a70a0220.4f78.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d5ce19.050a0220.3390a8.0000.GAE@google.com>
Subject: Forwarded: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
From: syzbot <syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb=
_vmdelete_list
Author: kartikey406@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t master

hugetlb_vmdelete_list() uses trylock to acquire VMA locks during truncate
operations. As per the original design in commit 40549ba8f8e0 ("hugetlb:
use new vma_lock for pmd sharing synchronization"), if the trylock fails
or the VMA has no lock, it should skip that VMA. Any remaining mapped
pages are handled by remove_inode_hugepages() which is called after
hugetlb_vmdelete_list() and uses proper lock ordering to guarantee
unmapping success.

Currently, when hugetlb_vma_trylock_write() returns success (1) for VMAs
without shareable locks, the code proceeds to call unmap_hugepage_range().
This causes assertion failures in huge_pmd_unshare() =E2=86=92 hugetlb_vma_=
assert_locked()
because no lock is actually held:

  WARNING: CPU: 1 PID: 6594 Comm: syz.0.28 Not tainted
  Call Trace:
   hugetlb_vma_assert_locked+0x1dd/0x250
   huge_pmd_unshare+0x2c8/0x540
   __unmap_hugepage_range+0x6e3/0x1aa0
   unmap_hugepage_range+0x32e/0x410
   hugetlb_vmdelete_list+0x189/0x1f0

Fix by checking for shareable lock before attempting trylock, avoiding
both the assertion failure and potential lock leaks from skipping VMAs
after locks are acquired.

Reported-by: syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=3Df26d7c75c26ec19790e7
Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchroniza=
tion")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
Changes in v2:
- Check for shareable lock before trylock to avoid lock leaks (Andrew Morto=
n)
- Add comment explaining why non-shareable VMAs are skipped (Andrew Morton)
---
 fs/hugetlbfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9e0625167517..44943e97adb0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -484,6 +484,13 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgo=
ff_t start, pgoff_t end,
 	vma_interval_tree_foreach(vma, root, start, end ? end - 1 : ULONG_MAX) {
 		unsigned long v_start;
 		unsigned long v_end;
+		/*
+		 * Skip VMAs without shareable locks. Per the design in commit
+		 * 40549ba8f8e0, these will be handled by remove_inode_hugepages()
+		 * called after this function with proper locking.
+		 */
+		if (!__vma_shareable_lock(vma))
+			continue;
=20
 		if (!hugetlb_vma_trylock_write(vma))
 			continue;
--=20
2.43.0


