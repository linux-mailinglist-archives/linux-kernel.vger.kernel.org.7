Return-Path: <linux-kernel+bounces-813445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BAB5458B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3710E1C867C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46362274B39;
	Fri, 12 Sep 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="DPoC1twA"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A5221FA8
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666068; cv=none; b=qfaia9+Wg+f2fhQnr9eSjN9nDI5j14cJ3TCAclksQK8uxyHz4gnEP9Qz1Pz4iYRjjaycyFkf9QecOWNVsHt7+827up1mDlupzhf4CEFnxcRlDv+SjIOULJSuB4rlVP4SkGUoVfm4YIQV9FRxxBgmnuvPOt5pnaU83ssYn+vjTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666068; c=relaxed/simple;
	bh=C9/8Q/OtCQ9S2FKVlqcJdKIxrj42kDG57z6IQjeEHpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZjtoUXviiEoD6zhdLsHeElNA2+6LvAVSndwG6U+kOLCeJ9+ec8tWWIIUcxOjk+eV/uf030He83USuthOQU/SKgPomhAsNJSwygzbBykqxrQcWXqWxC7VP4hQbTerfhomgPyo4v/TWCuQJgdQbiRMcsJSTabo4W9rAviU27LhKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=DPoC1twA; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757666061;
	bh=yyyW7NFzPQDlxRW4KQEmjwCxkqSvDeoduXOyOBSoUFk=;
	h=From:Subject:Date:Message-ID;
	b=DPoC1twARq1qjeKjYxbhvrfzMsiWPh+4c0u8OUYvm4xFCHvzAtbDtE08kQIr5W598
	 qFbPLUuI5rbEmKq/9mZFLvqsMU+wMtGPFPCgbkfCeQ5DxKK9ipk9H28C9WhF2KCq8D
	 3bHMY9hr8I61TELdnkgCdn1eCdh9vdN77yvNEpeA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68C3DB00000004E7; Fri, 12 Sep 2025 16:34:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6119426816419
X-SMAIL-UIID: 679110B2D10F41B998C8F75B501D44C1-20250912-163410-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Date: Fri, 12 Sep 2025 16:33:58 +0800
Message-ID: <20250912083359.6809-1-hdanton@sina.com>
In-Reply-To: <68c2ec01.050a0220.3c6139.003f.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 11 Sep 2025 08:34:25 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5f540c4aade9 Add linux-next specific files for 20250910
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=157dab12580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5ed48faa2cb8510d
> dashboard link: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b52362580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b41642580000

#syz test

--- x/drivers/infiniband/core/device.c
+++ y/drivers/infiniband/core/device.c
@@ -506,6 +506,7 @@ static void ib_device_release(struct dev
 	if (dev->hw_stats_data)
 		ib_device_release_hw_stats(dev->hw_stats_data);
 	if (dev->port_data) {
+		ib_cache_cleanup_one(dev);
 		ib_cache_release_one(dev);
 		ib_security_release_port_pkey_list(dev);
 		rdma_counter_release(dev);
--- x/mm/slub.c
+++ y/mm/slub.c
@@ -3957,7 +3957,7 @@ static void flush_rcu_sheaf(struct work_
 
 
 /* needed for kvfree_rcu_barrier() */
-void flush_all_rcu_sheaves()
+void flush_all_rcu_sheaves(void)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slub_flush_work *sfw;
--

