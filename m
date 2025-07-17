Return-Path: <linux-kernel+bounces-734511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A814B08298
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B217AE3D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0781411EB;
	Thu, 17 Jul 2025 01:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LKrfkFwP"
Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFFFBF0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716813; cv=none; b=HpKlbVyu8B39urK7/Dl5YtTO19IW7oKUDuWgP0IZbnwhG3tiyC9cuvZpEU98LqRTNp4LWiGtvgiJv6sY2QHtWr5KyvdCsTyUbvxL8yh4tOEpR9DmVmDUqE769QGmiYjViqpeRqnCtavSDJ/ZqRcsAp3P2/AHI0244i8aOxfLeo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716813; c=relaxed/simple;
	bh=rZuZEi8ru9DFYqryd7WMqO74U03DQMjX49DdzRPFTSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTgH+e6hVclqfcb8xgIubsRLSD56icjx660CcnZvVHD62elhk/NJg4ZH4NSpt23hIf8nXIL4quzk3eaAg+oBKmrgKx/0XjL0AmX6zWrLRjd5zpLWmhlUndrD+sz0PFgok3eAx6p2DDMupyIfIu/cS8yN9L46rJmabG0E6QZW78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LKrfkFwP; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752716803;
	bh=56+NgUcqvRAKd7G491K/UhHeBO36pKLvh4OxxjLDzNE=;
	h=From:Subject:Date:Message-ID;
	b=LKrfkFwPci8wAK1jiiTJrMT89EA5CwSfHsTb1pssMssya/YBxnvoSXxv5LZNoPqNx
	 3eqGmijE+dHo9amW1AsBhJV+se7VtLiVDht6XaNZLJTb8LTLwh9IUeX6YmS8wVn0Jt
	 at6IYLiwEvshBz8ZU2IvCzi6vy0x7bmqCACpR9ZQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 687855F700004B3B; Thu, 17 Jul 2025 09:46:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1450606291993
X-SMAIL-UIID: 83C944FE99224B9798F339031E6DB7FC-20250717-094633-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ebfd0e44b5c11034e1eb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot (2)
Date: Thu, 17 Jul 2025 09:46:21 +0800
Message-ID: <20250717014623.2253-1-hdanton@sina.com>
In-Reply-To: <6877e797.a00a0220.3af5df.0012.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 16 Jul 2025 10:55:35 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0be23810e32e Add linux-next specific files for 20250714
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a9a7d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=adc3ea2bfe31343b
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebfd0e44b5c11034e1eb
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d0658c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dd858c580000

Test Lorenzo's patch

#syz test

--- x/mm/mremap.c
+++ y/mm/mremap.c
@@ -1112,6 +1112,7 @@ static void unmap_source_vma(struct vma_
 
 	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
 	vrm->vma = NULL; /* Invalidated. */
+	vrm->vmi_needs_reset = true;
 	if (err) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_acct_memory(len >> PAGE_SHIFT);
@@ -1367,6 +1368,7 @@ static unsigned long mremap_to(struct vm
 		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
 				vrm->uf_unmap_early);
 		vrm->vma = NULL; /* Invalidated. */
+		vrm->vmi_needs_reset = true;
 		if (err)
 			return err;
 
--

