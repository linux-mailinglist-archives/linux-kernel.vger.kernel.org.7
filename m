Return-Path: <linux-kernel+bounces-814992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E854B55D98
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EE81D605C8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE1127470;
	Sat, 13 Sep 2025 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="V+6unkZn"
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F33E47B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757726744; cv=none; b=AbSg+BJ3/PRr/6YBmBZwn+B9xvSa8cZtvJOY0bnywQmjz+6s+48EoKmImJFE8pLTN1DH2VoKaX/1Zk+6OC+4s8ADIkiaTBYln5T7xkIzTnCpkwBoyoUtb0uXIu10CAx9XtE6Hq56LtgQvnd4LQWfRzGM8lAIl/GQzU3Jv5FM+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757726744; c=relaxed/simple;
	bh=5lRR7Ul8iVmEoBGn9MLHDEYRBK8YAa7suDKBs74sWgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sojBxcZo3xcfaHMR0c3tNGY/97vHL/TiKRAyImYQIF0CDaAm014M/XIEApQsQBzTpmOqlpxpKaegBxKoYKiLbFZ9SV1LOnt2XJPdKWvciiG8mLKYiQ4z4bo9lUuFQp29DSJN9AMt+ftjCY/TAC2tnlLM1UPEDLu4fJWBGez09fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=V+6unkZn; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757726733;
	bh=gCwPDTo12ml/7P49MzS1++kQZokEKMzdUvTb31I04Gk=;
	h=From:Subject:Date:Message-ID;
	b=V+6unkZndlieacEjwLAfxd9RWr5LM98xBiHyO8cr9FNAnM4IuoHm2bwPwc7BIQfI1
	 mW+9KOa/C5FO74ikVmGvOsM7P+FetrJyWpbvoP2fSGIA9QKj+2gJ5gNBZfU9Z6iuU+
	 o5UxPhDHGhJ1QpA4R3oZnXftLTTkdJZjvZiKAnv8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68C4C801000052EC; Sat, 13 Sep 2025 09:25:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6836876816405
X-SMAIL-UIID: CD0B43F8A612476CA5294F786ADDCBCF-20250913-092523-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Date: Sat, 13 Sep 2025 09:25:11 +0800
Message-ID: <20250913012512.6904-1-hdanton@sina.com>
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
@@ -824,7 +824,7 @@ static void cleanup_gid_table_port(struc
 
 	mutex_lock(&table->lock);
 	for (i = 0; i < table->sz; ++i) {
-		if (is_gid_entry_valid(table->data_vec[i]))
+		if (table->data_vec[i])
 			del_gid(ib_dev, port, table, i);
 	}
 	mutex_unlock(&table->lock);
--

