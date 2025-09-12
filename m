Return-Path: <linux-kernel+bounces-813606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADF2B5482A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0AD017D557
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05628002B;
	Fri, 12 Sep 2025 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="YieV/pAW"
Received: from mail3-163.sinamail.sina.com.cn (mail3-163.sinamail.sina.com.cn [202.108.3.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1727CCC4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670170; cv=none; b=g4tMb4w915RyaXZAxED3O/EZaTrY4780zMTANz1qQRcykH4mJTmRkrgBa9nnppmAEfqXli3jIef/vKZI5J9yBkVicIXeqfizJV8McsD4d3RoS/LiZSDvroelsJCb/u7gCiXr9U3tW3hbi4eLyATHRSxVioLzMAqyZZZUpyvOSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670170; c=relaxed/simple;
	bh=jzNKu2lXSx5ScqDbHaQ4Zr6soQdmnqh0vwtPLuRv+Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLLw17eYd5gHkt1wU/u1Pd87AqkEqgDrk+hZ2mcu4fgRJ9Ge5/vmWTtlHH9I7a6R+3Y5B7yHyapxwIM5ExbntOjilTLB+qPjW+k3nXoXwUPt2JmrQefCLTP0/SByxR+ph/3d603V+gwiY7eNhdBJJc3vT3aFHWNeEz3zK5rhMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=YieV/pAW; arc=none smtp.client-ip=202.108.3.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757670165;
	bh=QAQawdjdxUnCmKK2sv+xDFgHaY34kb5syTH90unbTeo=;
	h=From:Subject:Date:Message-ID;
	b=YieV/pAWIjnzRR+c7uHrbuKoN4xT53FsfWMJkx0oCS3Fwz51J/qlwBNWR88LP20hq
	 7w1mR8mHHA5ow3aldL0B9efq1QYSDXBczok3FPkpPBo/PrtENslCZjWu1XxF+WNJ0t
	 I6P+MwA92+Tta2cYDm+HDoJy2g8BT45IKffrTwk0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68C3EB0B00001F45; Fri, 12 Sep 2025 17:42:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2507956291935
X-SMAIL-UIID: 6E9BFD48481A4147BA84310774573E3F-20250912-174237-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one (3)
Date: Fri, 12 Sep 2025 17:42:25 +0800
Message-ID: <20250912094226.6866-1-hdanton@sina.com>
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
--

