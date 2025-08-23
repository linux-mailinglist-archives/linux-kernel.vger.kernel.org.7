Return-Path: <linux-kernel+bounces-782803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E910B3258B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2291CC6E7F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FEC79FE;
	Sat, 23 Aug 2025 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ACQ4xLxk"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74650A55
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755907710; cv=none; b=dZOvexREKHO87KBYTKCso/DVsuX/6+VcuoGX+7Hg7ROoYOVNU0o35O5MvwnJ9wvCjPdSuDWZ5vz9rVvm697gesPwFOUVJKe7m2GDKX+ZPiDe0GTU18sB34DdKAky6152KCgfaqpykl/wTyZL3bPtNlMHhzuTxP3Q6JVaSP78Kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755907710; c=relaxed/simple;
	bh=+1mzfIZRx9dLFi4vN8VxKVwYq9AcE76C1iIRMV59evI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XlMi6kpZAxtI3ZGw298UJjSHnSZKZieEUpDfeITu+TQpc+Vgx5m+WosqQesQY6o0TjWRnZGOenh0WlM/ky6lrOpY1T40E9DvaBnC4sMhzd4KsiAvlJRfGswytQWRyORCgEoMZaQku4YGamqAVSNZ1igZ4Pzw5gtuY+EEGGDEOAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ACQ4xLxk; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1755907697; bh=Yw+yNClRXQuOD9ZupgdvkzJGGV7YwzsVK0Qs6ZeVvac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACQ4xLxk7dfCUUgimHL3+4FE7zWWbgJdg9pAgtV7goG5vkkoiQFlFshushiT4Ycvx
	 LobBF3sZJXvIbg2iWTtVj0rwDcJ+u+zYeU+cMfDQkxRRabHX7+OQh+olv7mYmQuL4Z
	 rUxJ8IAHfmfG96i559hak93RTZSS/F0q8yQGbVDE=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1C02506A; Sat, 23 Aug 2025 08:07:00 +0800
X-QQ-mid: xmsmtpt1755907620tvl1eu3xw
Message-ID: <tencent_3F826C402D156CCC96B0EA0AEED6CC7C7B0A@qq.com>
X-QQ-XMAILINFO: NmYPxqSo4aXv9XtzDcSL/pJrkTASF/4zfNEO75WALQnJA+ShvahkXXqpQQiUCE
	 DyCaynJiXLk9/Za69XDXi7n0XyMzFdiYBuApOjgkWYu6Q9PGY98I6TaTlPBLC+1ZkvaQSzP6KYX1
	 EM9uVuMq0a+oIeAi6Gz1UB5yJ6egldFx4+D6gExY3VJcUqiTkvd7AhP5KCXKnNnc5fk8q6bNlgtC
	 5E6UV1tYwRFrVm5ZZbLjUox9xy8IfAB7ZWg/RrTIEzbcK7gPWqBK6huoVVKHD4IwBmty5IImOStu
	 pSXBxWHOfSadKGZraVqFBxasp/r2ZXet+fDUG33AfEoGmmmab9f1TRu9SSXNTEs++wE/IfDpqq10
	 XszuBZJ29OP0Us2CmUgZLhYTXHC57N1H5MxUJo+UYf1c4U0e6M/I8KHaDA4ZYhoPujfuMSaEENrG
	 j+dHpUoyIVEO1as9Zx5nDIHjHQfXLd1CThg5QsoaDe8dEmwpAEGS7whl+jnFxizt6o0yHSw6ly4Z
	 kgGdIFZbnDQ/bIbzc2xpJY0SFs30MzvRhsjJA1WfoGiN5sEsgWPawX6JibDjstwExdzkS/Krhtgb
	 8RlnMpHabtuqyoRdMJSaLdOCY5CcCcOOtmLpBuLakJ9QWQvXBm4i44aQJID92op1DY38Zs+sKL5s
	 TKaeOSgS289Yx7c+wYIkSRKltl3A4GmQFwZnonbI1t355uunkrzLgbZrhTgB1FVOhkqEGJilwUu2
	 3zE29mmJzDsErjwAM8bXEymXzB/digRHBdNgxQrkpYeTIot2b0uEjIVJdt4TLH/UHUni2l8FIqIR
	 WwQ7XG4Y4+Kp0JKsc8g1P7f6UlDC0AFNlqLvXuFeXC9B0LsaZTrJFeiJDbPyWhlAi1v+xbPFMP9z
	 NoNESNyibmkgzYPsapjU/xkxvNasLi5wOzXOFvyiiZnH+XZ2qeqKBKKzZm/EeuksMW2GLcMevchY
	 cRK+z2naujw5cFFwxtddM6Rt+pVuA7dIXNfvOWko4XsHOAKIQQvkBXyPeUdl71
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] KASAN: slab-out-of-bounds Write in fuse_dev_do_write
Date: Sat, 23 Aug 2025 08:06:58 +0800
X-OQ-MSGID: <20250823000657.2554798-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
References: <68a8f5db.a00a0220.33401d.02e1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..5150aa25e64b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num) {
+	while (num && ap->num_folios < num_pages) {
 		struct folio *folio;
 		unsigned int folio_offset;
 		unsigned int nr_bytes;


