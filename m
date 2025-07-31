Return-Path: <linux-kernel+bounces-751888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE42B16ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72A17AB2A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32D28A718;
	Thu, 31 Jul 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="BwJqo4/q"
Received: from r3-21.sinamail.sina.com.cn (r3-21.sinamail.sina.com.cn [202.108.3.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D395187FEC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954780; cv=none; b=sKDY9DkWW55MDkJT84eAIdgcyJ4h4STQaYSRD4dkn0FnJ5r8ZyMyzGUSvkMNfe6LvwuQAMFMSq+iVyrXE3mE0oDQAOicFIWoH0b203YtLtJ8EfUYAPLveHSCcF1vlCbthRgyLMtU5iav0tPcZ2fwJ+GJnuUKEnfSqxngwjqacT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954780; c=relaxed/simple;
	bh=iq2EfbA7VqYU+6nTLb8uoj+DGC14uIjSIDiXVFlw7wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVeioTyVSYNJw2kbqI5gYKabvuJ77tSHFSxJpBbX1fPkxaTMsWVy5xeeR5cxllM5RtIi0JBAPNinE4E5dP121BC/xgF61iX7p4z59At6sivLnAN5iV/nArrbVZs8rqfYLm6OO5+/OkObR34akZ2W2DAyYT7cXCZm20wVqfzTXMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=BwJqo4/q; arc=none smtp.client-ip=202.108.3.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753954775;
	bh=HQhHmrc16kdcYrO/6MyrMGRqqwelpoTQ9DrselI2OuI=;
	h=From:Subject:Date:Message-ID;
	b=BwJqo4/qy7/0ivHsUYFTMhn/KqvBEMvcb0nqQ7/UdE2xpLboVnR979ii1wnHuOLHC
	 Hk/R5N1BCbuYHhOoTeWnkMhKi//QEbE7fFM+lHGVu4F5w7esxW7JpZGriIwZObOxQh
	 gyfktt6yFMZXbBhy77sL9goDJSBShY4thTej7jYM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 688B39CB000018A3; Thu, 31 Jul 2025 17:39:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7114546685185
X-SMAIL-UIID: 7DC28D0D66A1437A87A936D0C33DED4A-20250731-173925-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [comedi?] KMSAN: kernel-infoleak in do_insnlist_ioctl
Date: Thu, 31 Jul 2025 17:39:12 +0800
Message-ID: <20250731093913.3644-1-hdanton@sina.com>
In-Reply-To: <688b1b62.a00a0220.26d0e1.0039.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 31 Jul 2025 00:29:38 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=154b8f82580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=30a934bba3cd727
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb4362a104d45ab09cf9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a04ca2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a269bc580000

#syz test

--- x/drivers/comedi/comedi_fops.c
+++ y/drivers/comedi/comedi_fops.c
@@ -1566,7 +1566,7 @@ static int do_insnlist_ioctl(struct come
 
 	/* Allocate scratch space for all instruction data. */
 	data = kmalloc_array(max_n_data_required, sizeof(unsigned int),
-			     GFP_KERNEL);
+			     GFP_KERNEL | __GFP_ZERO);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
--

