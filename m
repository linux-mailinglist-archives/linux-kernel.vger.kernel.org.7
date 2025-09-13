Return-Path: <linux-kernel+bounces-815079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FC6B55F1E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13BD3B0577
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D802E8B91;
	Sat, 13 Sep 2025 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="cXscCqrs"
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B592E6CDC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757748364; cv=none; b=WbYllcVB/59sBjRpBR5JoFzxSCleT9sFGbOme8mBFibxa0hmt6IclcwXX5Vm9g/bjSFyemNkzU2ThwpIkcpGV1nMH1hblU0ctj46VIywjOPJY8zw1Otx4EUDMGCQmLfwkOXknRmLmM/PBRmesNzYO6XEyloQgKzErw22iHd/KzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757748364; c=relaxed/simple;
	bh=P6TFZjAqDseJT+tXMzceV/tvr25A+CwDo4eT+ljekQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cu+wYnvbR34iAF/EWOBwmLjBikq6rGpD5nrBX8At8Q+vPk/LuOKYv4WZ3fciw0OXQ7FZAB0pcL9P6buuLHi4+gXzh8sQ71w7IPcWS1U5XvZbpC/KaqNqvt4e/NcuORpQJa3gy70eMMtL03DBuypw8KGnj9Ctaj1ljxhbxHINfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=cXscCqrs; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757748360;
	bh=jNio/2uPwk5raRzHVYLLmrSDmiqV8FUFtGPHk3z+lw8=;
	h=From:Subject:Date:Message-ID;
	b=cXscCqrsMGn4oWfJ9a2UtLE98RCChk7Cumi4k5XpB+w0+jE8/++7njFGY9dMVXgGk
	 DQO9GrHKWhD4Azc/OP8VS4hlykL0Py6FBz7YfuidRgdiLgkSPELKatlclKRIthA32I
	 DjwosZTWVdslDkuCzByjLHT5/J7h7mNbkw0kA2G8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68C51C7C00003A03; Sat, 13 Sep 2025 15:25:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2718776291955
X-SMAIL-UIID: 494D5D53BB6B4E81B8955608FC419FF2-20250913-152550-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Date: Sat, 13 Sep 2025 15:25:39 +0800
Message-ID: <20250913072540.7012-1-hdanton@sina.com>
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
--- x/drivers/infiniband/core/cache.c
+++ y/drivers/infiniband/core/cache.c
@@ -393,11 +393,7 @@ static void del_gid(struct ib_device *ib
 	write_lock_irq(&table->rwlock);
 	entry = table->data_vec[ix];
 	entry->state = GID_TABLE_ENTRY_PENDING_DEL;
-	/*
-	 * For non RoCE protocol, GID entry slot is ready to use.
-	 */
-	if (!rdma_protocol_roce(ib_dev, port))
-		table->data_vec[ix] = NULL;
+	table->data_vec[ix] = NULL;
 	write_unlock_irq(&table->rwlock);
 
 	if (rdma_cap_roce_gid_table(ib_dev, port))
@@ -824,7 +820,7 @@ static void cleanup_gid_table_port(struc
 
 	mutex_lock(&table->lock);
 	for (i = 0; i < table->sz; ++i) {
-		if (is_gid_entry_valid(table->data_vec[i]))
+		if (table->data_vec[i])
 			del_gid(ib_dev, port, table, i);
 	}
 	mutex_unlock(&table->lock);
--

