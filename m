Return-Path: <linux-kernel+bounces-809588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4EB50F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CCB1C81F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0630B533;
	Wed, 10 Sep 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="byG4CkLa"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE8307AE0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489591; cv=none; b=hQw4Xl/kVmIZKNirlgmi0c5XbRjbCRrRSC1FSSpRtCHG20uVnpd72vaj2tLcYfL7PhgZBLIsEwKdOCo5MPBKDk4sP9isH3/nGVUbqo2/UFzh5RNAxMfJnxGaOd+5yJsVJnW8xeVpzl+AUWRxNHJM8RBWX9P8NznaRKy/YvdficQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489591; c=relaxed/simple;
	bh=AVqDPqve3RasHTz2rv5yUVcBYWln23THZbycgvAjHRM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZqPY4EX2SWX6bck3IzW8JUQQR0mMqHbgj1LW6ucypum4i9l8smmeI/gJEQmKt+HSKy6wEPiZnSACClXqpOl1WqQwlhyJtd9wFgvN4DaaaBsSccy9JaGhAzVhToriJsL0rBrBsHV6LGfjKC2FqriR9tQpdx47xFBTXkm54f3rvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=byG4CkLa; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757489584; bh=w63wQU3paIocMOKW6dFd9TDyKaaRVt53EjaM+0ehhYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=byG4CkLay93M/uuWbyaM1p65NIytiJrXixPYlacmIUageyfbuEgZ58BxOi9wd2nZ6
	 B+G6GsxQ0y5ILbD+ki5GsoCVC3sqwzR0R+IxG0khAUdqJOJYyu5YoOuQoHceVudUm2
	 gLlCxKM0ofWe9Tvd3BYbTgCW2+x2XHl5fC755pBE=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 84231222; Wed, 10 Sep 2025 15:33:02 +0800
X-QQ-mid: xmsmtpt1757489582tujif69h6
Message-ID: <tencent_4CCA0CABE7C1C6EC12C0064989A0AEEF6E06@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9ur9PjhHYY+2mxTTNxa8jKVsRnXq9JTwMMTFga7zaa2iy4KlFiY
	 qyqcCj4fPvCGScUVUnmybIK2X3lF51VQgTKYyk/zekFFMZwxLRxPck3waIjB62bOyRuxFmamxfmp
	 d/nY7XPOGMUwRUmziXvTr3nYsS8crLkqFvyGC5DLZhdeDTMziwxW0H4mfnb+Oua1qWl+OhYVncZ3
	 BKSJD/FAaLpm8TqsCxGXoZ3Xck6QWJDfFeksklUel/qURC/WdpXNdhOv2lV/jzbM7RJyTsTwJe5c
	 yeuxukFkjhUge6RMssLxfG7rohdTazcRxUXWZvFVGqApJosnBCmXm1FzZl/aAuP0DCsKQZx/25NW
	 kkszbw5/4uQzN0IpuhiyuB93tGlMO4d/XLDY75fez9mmQ05dHH/QLaLXBJRDpnuZ1X3W1ANX9pcU
	 W1FIDGyx+aSCHj6y6IdZ2I18D3+7OH6e5YgOUWcl14hnWcLdt75ws6J5FHjSbNPOqIq+NJjkzbgj
	 3Ld+WxZXRjR72PRdMvcQDycKqTvhl3CRT5omicjVBAeAgSiQKnFgl+3pbv7y2ZbUjBcoLT0m2OpO
	 k9R1uXtY8yWagxK/Ku+XYGij1GimNu6aCUWV5ksIDvxAcOgr0Yu/lCzJgAgVhcXg7eiKFSJU9BHj
	 2drEMZpJYfRAhfM8I+7mOhHbCnW6hkABkE83ztUBRXbgqrWwukq8/0wLNKwuwJy2kloSvvmrXYK8
	 FYRlDkJW8fV9tdu/geDcRa61DwArjv3jPsQzFiJTvD+3P5/etAe0tRtrfSDoi6vM5I24bPP7AcZJ
	 3KAoYqq7C5L9AyQ+/bJRNkR9GxRbUZBEWRo6m/vmnGZvXjX1NqxNYv86tydk2RAGbXy3K9jCQ4hI
	 uUj5qPtV4FRVYlu3UMh/J5GVcNqE/PZ9AhatifmZhU8v+8tjDesenz90CvEHvyhWEtot4YO1Bae4
	 spPwDLguOnoilaR7CMtDcspmRZmAmc
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b6445765657b5855e869@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in sysfs_emit_at
Date: Wed, 10 Sep 2025 15:33:00 +0800
X-OQ-MSGID: <20250910073259.1457516-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
References: <68c118e8.a70a0220.3543fc.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index c3177034b779..f441958b0ef4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -119,11 +119,11 @@ ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf)
 	guard(mutex)(&usb_dynids_lock);
 	list_for_each_entry(dynid, &dynids->list, node)
 		if (dynid->id.bInterfaceClass != 0)
-			count += sysfs_emit_at(&buf[count], count, "%04x %04x %02x\n",
+			count += sysfs_emit_at(buf, count, "%04x %04x %02x\n",
 					   dynid->id.idVendor, dynid->id.idProduct,
 					   dynid->id.bInterfaceClass);
 		else
-			count += sysfs_emit_at(&buf[count], count, "%04x %04x\n",
+			count += sysfs_emit_at(buf, count, "%04x %04x\n",
 					   dynid->id.idVendor, dynid->id.idProduct);
 	return count;
 }


