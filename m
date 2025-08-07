Return-Path: <linux-kernel+bounces-759189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31703B1D9E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94EE189858D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04FA25B1C5;
	Thu,  7 Aug 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VKG0OYHu"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCE264A77
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576531; cv=none; b=rC6sHZoGfBzUhDVP0DN4C6szayIa0UbHd8Q7cpVh0p7lNqdiIei8qxjjq1bPrym6jh3QmMh/szZ68QD7FI2JFe9+zZXNKBMSq945KZBW9rOUxAvZvr2ouuDMTMkwnE7aRV/jz19P08Cv5UbD/3wMHpLlEHdPI7jzffvBrO7ZpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576531; c=relaxed/simple;
	bh=4BqfYnpWvnQMSL5nhqpRk9+A0ReDfFntrkj99hrVMC8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KZ6mIHVlOTkwDp7RYPLEzDAjOOsrAf580IXAfmJZKJOvexgeLxvkrhUiUOJ78+YM5gV4YN0qidtOTvpQMzVFwtJRGL2UqyX9D9rKYaoEjrsq9yiICLVQ90Q2SqHMAvfBoETh5S86H8EwxzQ2zxVksxDKuMC39sOF2XamwvDYgF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VKG0OYHu; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1754576517; bh=d+dMpIrhJw974g6imMm8tUUBqmD/9oTQWfC9nS9Xy1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKG0OYHuhoIpkU7omRlSRXIDV3ec4BIeOrHBm4UcOvz94hUEZlmGlvIiB39dJtsOR
	 o0HxzoEkhRmEarymyH5ahs/zuXjlopY34eh67NxmCQzPOZNJo9tNyZ159Xz6d2MKK5
	 7I4orS31BU0L0v6z7H70YwhyUJLZWyjKabbejKh8=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 3F20BE0D; Thu, 07 Aug 2025 22:15:50 +0800
X-QQ-mid: xmsmtpt1754576150tyeu5g5e4
Message-ID: <tencent_12A5C08DB79240DDA95D9119784FA08DAC07@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5S3mZRam08OiXFR46p1qiXXi0WnhljyhJ+RWQj6mrUuuLHpO7GWG
	 2A1LPx0i84tWkbSu1GINfaGGIGuCjv0WJlTgjBpf+n1pGWqEoWLRKvaBLy8VAYu/kSZUxZKWAd7f
	 vDoyi8R9g9yz8WFmzL3/nS0xP+Wk8HNkQQaPu/ZrDR3yqtAyzz/NRbwO68D7eAI1fLqmtJ/z7uwQ
	 9w/ihnC9Ry1/oi0jMdVUsnw0s4XNJ0bk3RXy4nkFDlbyIS8B7ZCqKKfsLVYmQDnwV3JiUYbyCfJi
	 YcC5DAvZz6/NFEFi1+rxRk9mSofr7fw08zvtbjZSfoZxKOVX5TLvgmNSjP7X0JFVY+1fnxUrhKtS
	 KXzMhOjR4MWZM5YC0WtrCt2dbk1ZKxfTVX23iEcvfxiM7mQrbevvZudzdl4i7TVLGuYaSvcK4MlR
	 OzA8kWyYmbgpSiWXwzDdpvqyJ0IpRJH01N21yy/MXIShyl4tGR3Rsn/YmClUERxautHgPUy2X7Pa
	 kBw9MbbDWCm34Ql4evgS9SqVV5sBo9E58BNCCDfya3WZujZ9tQEMsUbvAXUlTVxa9oDMnbQMH2Xm
	 haToehZwn/96ydx0tkqiHAJ46Gss4c+FjqzMUhGQA3G60NPYIic/ZC8NOo4Hcx6D2889NXigYhDU
	 Io8TBwjI5C4cX73hPa7kKK8Vqt/wPi6pGZvZIPrcAL8SKsLJvVsn6ruw/0VnhjvOlTwWztDKvsxd
	 e9QciiQ6yF5xH4o0Bik19zJeeEL0T3YN6c39AMclVgTiqqg4dmbywAsPwXndttmmJ2eIbDI5TtG4
	 xnnEULzygTpHZsbRBwgQazj4DehaUKu82DDFHcstpzyRTLVLwG+SqyqAeqtGk1G1o6ZvcvLb/QkK
	 vemA7kRoZCoevP7dALAqEZjpEDAkN4gjLBOTH0rXApRFuCTkALnWVb+ntHpAPJixbrmxJ0rV4tUb
	 TXAdTrmGFUzcfIBJ40iQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2d7d0fbb5fb979113ff3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_remove
Date: Thu,  7 Aug 2025 22:15:43 +0800
X-OQ-MSGID: <20250807141542.3380283-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6890f71a.050a0220.7f033.0010.GAE@google.com>
References: <6890f71a.050a0220.7f033.0010.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9692fa4c3ef2..0d69572fe1ce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4443,8 +4443,11 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	struct gendisk *disk;
+	unsigned int nofs_flag;
 
+	nofs_flag = memalloc_nofs_save();
 	q = blk_mq_alloc_queue(set, lim, queuedata);
+	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 


