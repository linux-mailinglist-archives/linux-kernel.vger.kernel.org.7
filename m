Return-Path: <linux-kernel+bounces-848429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C97BCDBF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0CD50071D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2D2F83BB;
	Fri, 10 Oct 2025 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHNVUNKV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B32ED854
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109090; cv=none; b=fR5bhiCCkQkGgCd6fc7Xa9KPDhpE4lVFGQm+mI/hVQ1N35caq/IvC0Xv5UeR3rqC407bxkgQ8jsDQL3eqG5RgbGaR8kSBK62UPCtoPdUlnuikHH3M6QMBbq2hRZ5BIC64XdBqMwmt3KKrgwCQXvRloHMS/nZBEO/vXoPYNTNKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109090; c=relaxed/simple;
	bh=uf5XLsTnbArAQB7j/DtV3w+8KyRvBY+aPFm2soSzcrc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=teNn4ILjjVFDpD1xZIoYczsST/hTk5BN03fKyLDfmBSLqrYRwORqS4BB+eMy9fVnj3QRBVHxs2KNsMyRmZI+Y+srK6Q+2VYfFRiofzkXauUp5w5V1JSDCal9oth/BATmlZtmlLa7rdDCmyYlaRamflP04DkCPFuZxkSK+mOGq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHNVUNKV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760109087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Hkwe0HXYTdkIs3L64rGDlFlcugiInGwyJxYOBEB+ivc=;
	b=MHNVUNKVwgTpchk51ad7d2FWQ33KCNJ4TakwQPSSMwivTBpGLO+JVqafGqi/0aKKf1s5EX
	CErmj0tM36xwMJutkkUW/TzBVHQmiudx9unZm8VJ/1YkOjO5hsv/m4R4oT8IfZX+VorAea
	D+dPgrks/NGeP8Vnx5pRtBAMKf4uE34=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-7kbsAIoUM8egW-kb3SsjoA-1; Fri,
 10 Oct 2025 11:11:23 -0400
X-MC-Unique: 7kbsAIoUM8egW-kb3SsjoA-1
X-Mimecast-MFC-AGG-ID: 7kbsAIoUM8egW-kb3SsjoA_1760109082
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB7E61800295;
	Fri, 10 Oct 2025 15:11:21 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.90.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32A5B180047F;
	Fri, 10 Oct 2025 15:11:19 +0000 (UTC)
Date: Fri, 10 Oct 2025 11:11:16 -0400
From: Phil Auld <pauld@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, pauld@redhat.com
Subject: Boot fails with 59faa4da7cd4 and 3accabda4da1
Message-ID: <20251010151116.GA436967@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi,

After several days of failed boots I've gotten it down to these two
commits.

59faa4da7cd4 maple_tree: use percpu sheaves for maple_node_cache
3accabda4da1 mm, vma: use percpu sheaves for vm_area_struct cache

The first is such an early failure it's silent. With just 3acca I
get :

[    9.341152] BUG: kernel NULL pointer dereference, address: 0000000000000040
[    9.348115] #PF: supervisor read access in kernel mode
[    9.353264] #PF: error_code(0x0000) - not-present page
[    9.358413] PGD 0 P4D 0
[    9.360959] Oops: Oops: 0000 [#1] SMP NOPTI
[    9.365154] CPU: 21 UID: 0 PID: 818 Comm: kworker/u398:0 Not tainted 6.17.0-rc3.slab+ #5 PREEMPT(voluntary)
[    9.374982] Hardware name: Dell Inc. PowerEdge R7425/02MJ3T, BIOS 1.26.0 07/30/2025
[    9.382641] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
[    9.388048] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
[    9.406794] RSP: 0018:ffffd2d10950bdb0 EFLAGS: 00010246
[    9.412022] RAX: 0000000000000000 RBX: ffff8a775dab74b0 RCX: 00000000ffffffff
[    9.419156] RDX: 0000000000000cc0 RSI: ffff8a6800804000 RDI: ffff8a680004e300
[    9.426297] RBP: ffffd2d10950be40 R08: 0000000000000060 R09: ffffffffb9367388
[    9.433427] R10: 00000000000149e8 R11: ffff8a6f87a38000 R12: 0000000000000cc0
[    9.440562] R13: 0000000000000cc0 R14: ffff8a680004e300 R15: 00000000000000c0
[    9.447696] FS:  0000000000000000(0000) GS:ffff8a77a3541000(0000) knlGS:0000000000000000
[    9.455788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.461535] CR2: 0000000000000040 CR3: 0000000e1aa24000 CR4: 00000000003506f0
[    9.468665] Call Trace:
[    9.471123]  <TASK>
[    9.473233]  ? srso_return_thunk+0x5/0x5f
[    9.477258]  ? vm_area_alloc+0x1e/0x60
[    9.481020]  kmem_cache_alloc_noprof+0x4ec/0x5b0
[    9.485647]  vm_area_alloc+0x1e/0x60
[    9.489235]  create_init_stack_vma+0x26/0x210
[    9.493605]  alloc_bprm+0x139/0x200
[    9.497104]  kernel_execve+0x4a/0x140
[    9.500779]  call_usermodehelper_exec_async+0xd0/0x190
[    9.505923]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    9.511670]  ret_from_fork+0xf0/0x110
[    9.515346]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    9.521095]  ret_from_fork_asm+0x1a/0x30
[    9.525035]  </TASK>
[    9.527225] Modules linked in:
[    9.530290] CR2: 0000000000000040
[    9.533617] ---[ end trace 0000000000000000 ]---
[    9.538245] RIP: 0010:__pcs_replace_empty_main+0x44/0x1d0
[    9.543653] Code: ec 08 48 8b 46 10 48 8b 76 08 48 85 c0 74 0b 8b 48 18 85 c9 0f 85 e5 00 00 00 65 48 63 05 e4 ee 50 02 49 8b 84 c6 e0 00 00 00 <4c> 8b 68 40 4c 89 ef e8 b0 81 ff ff 48 89 c5 48 85 c0 74 1d 48 89
[    9.562405] RSP: 0018:ffffd2d10950bdb0 EFLAGS: 00010246
[    9.567634] RAX: 0000000000000000 RBX: ffff8a775dab74b0 RCX: 00000000ffffffff
[    9.574774] RDX: 0000000000000cc0 RSI: ffff8a6800804000 RDI: ffff8a680004e300
[    9.581908] RBP: ffffd2d10950be40 R08: 0000000000000060 R09: ffffffffb9367388
[    9.589048] R10: 00000000000149e8 R11: ffff8a6f87a38000 R12: 0000000000000cc0
[    9.596178] R13: 0000000000000cc0 R14: ffff8a680004e300 R15: 00000000000000c0
[    9.603313] FS:  0000000000000000(0000) GS:ffff8a77a3541000(0000) knlGS:0000000000000000
[    9.611399] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.617145] CR2: 0000000000000040 CR3: 0000000e1aa24000 CR4: 00000000003506f0
[    9.624278] Kernel panic - not syncing: Fatal exception
[    9.631463] Kernel Offset: 0x36a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    9.642244] ---[ end Kernel panic - not syncing: Fatal exception ]---


Reverting both produces a working kernel.

I have not looked into what the percpu sheaves thing is actually doing but
this is an AMD EPYC 7401 with 8 NUMA nodes configured such that memory is
only on 2 of them.  

# numactl --hardware
available: 8 nodes (0-7)
node 0 cpus: 0 8 16 24 32 40 48 56 64 72 80 88
node 0 size: 0 MB
node 0 free: 0 MB
node 1 cpus: 2 10 18 26 34 42 50 58 66 74 82 90
node 1 size: 31584 MB
node 1 free: 30397 MB
node 2 cpus: 4 12 20 28 36 44 52 60 68 76 84 92
node 2 size: 0 MB
node 2 free: 0 MB
node 3 cpus: 6 14 22 30 38 46 54 62 70 78 86 94
node 3 size: 0 MB
node 3 free: 0 MB
node 4 cpus: 1 9 17 25 33 41 49 57 65 73 81 89
node 4 size: 0 MB
node 4 free: 0 MB
node 5 cpus: 3 11 19 27 35 43 51 59 67 75 83 91
node 5 size: 32214 MB
node 5 free: 31625 MB
node 6 cpus: 5 13 21 29 37 45 53 61 69 77 85 93
node 6 size: 0 MB
node 6 free: 0 MB
node 7 cpus: 7 15 23 31 39 47 55 63 71 79 87 95
node 7 size: 0 MB
node 7 free: 0 MB
node distances:
node     0    1    2    3    4    5    6    7 
   0:   10   16   16   16   28   28   22   28 
   1:   16   10   16   16   28   28   28   22 
   2:   16   16   10   16   22   28   28   28 
   3:   16   16   16   10   28   22   28   28 
   4:   28   28   22   28   10   16   16   16 
   5:   28   28   28   22   16   10   16   16 
   6:   22   28   28   28   16   16   10   16 
   7:   28   22   28   28   16   16   16   10 


Let me know if I can provide any more information.


Thanks,
Phil


-- 


