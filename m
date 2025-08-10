Return-Path: <linux-kernel+bounces-761297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F8B1F800
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 04:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2957AF47E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85EF35947;
	Sun, 10 Aug 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="PE65wsII"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536FB1367
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791391; cv=none; b=FzJ1OuoJHC0BolPH+vzLZtn6rm/nQY8Mhr5KqJBy0CLPZYsy1KA3bSsyeF4/3KIE97wClg3FIqQlqyfGzjrnyJnejUrLEoMgPliqeLH4rmK0Ujgbi1FWpjBbrFlTkbUd95R7gGe8HJkqjAP/GNZio9dqsKHpRQXknSeG3bQsZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791391; c=relaxed/simple;
	bh=6inV4svQ72bNNiz/L/XG+2xkCcIyfhYUcqpmS7rFVE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLY7Vpwow0tD/U8WRecrhE/kb8iP5Lu8cQG+4Jhm4/n5unbL4lMMXGUKX801k0Bs9nRcvqp6577U7mUYUu05PYn84cl0KXtWB8GXOoXWvf8p+i5vlS/PG4QWO8SvrMJeqAnjPAoVMNguPOB7J1rvVuKHwclsR2Z9aZZxYAGZTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=PE65wsII; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1754791387;
	bh=GCD2ipAZU5JSrHXmy98iHMYLyBQXF53XydJX0hwrmyM=;
	h=From:Subject:Date:Message-ID;
	b=PE65wsIIa3/VVK+/eJ8EFg2rkHN07SNILMQd57hKg+kBAV4hZggPpctcWmO8D4yjz
	 EuHm8kNq4rBkCMwXebYu0D3w0+CFqGbSHmkqpZED333EF9JRvSsaZssrcPGyWRDWRE
	 JgK2aSxdYIwhx9fAJ+hPnpcB/zkGAeLUcB8udDqk=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 6897FDB200005BDB; Sun, 10 Aug 2025 10:02:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7453574456655
X-SMAIL-UIID: 14971485016643A19FBB9DCFAB249538-20250810-100227-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+63859a31071a369082b1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in try_to_migrate_one (3)
Date: Sun, 10 Aug 2025 10:02:16 +0800
Message-ID: <20250810020217.4151-1-hdanton@sina.com>
In-Reply-To: <6897b156.050a0220.51d73.0082.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 09 Aug 2025 13:36:38 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0227b49b5027 Merge tag 'gpio-updates-for-v6.17-rc1-part2' ..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=1422d434580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2ae1da3a7f4a6ba4
> dashboard link: https://syzkaller.appspot.com/bug?extid=63859a31071a369082b1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117c72f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ab7ea2580000

#syz test

--- x/mm/rmap.c
+++ y/mm/rmap.c
@@ -2366,6 +2366,7 @@ static bool try_to_migrate_one(struct fo
 		subpage = folio_page(folio, pfn - folio_pfn(folio));
 		address = pvmw.address;
 		anon_exclusive = folio_test_anon(folio) &&
+				 pfn != folio_pfn(folio) &&
 				 PageAnonExclusive(subpage);
 
 		if (folio_test_hugetlb(folio)) {
--

