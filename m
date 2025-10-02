Return-Path: <linux-kernel+bounces-839696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F11BB22D1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 02:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CA33BC6F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D336FBF0;
	Thu,  2 Oct 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="U39cD7qz"
Received: from mail3-162.sinamail.sina.com.cn (mail3-162.sinamail.sina.com.cn [202.108.3.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA9EEDE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366503; cv=none; b=QdXevbWSlRxQUI4eNJ812YR+fcTghe4wX7qbmCmJ47CzWhC8QeFZcNnF/Qa1RhRZpUuc7kUbkNyf+phKKCXJW0jE/rxTzr/Hnx48NxbLaco2Un9QGavpa4wP5eP34o0WnoRX4qD4CmsRXwCIR86NHtQEeiWlMdFGSG3peDgTRxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366503; c=relaxed/simple;
	bh=J47abRQclryr6Mqqv3H5NP7QJGsndEuo7nRE08MZNr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHR8glZeJB+wkwzrNGpekEYKTXgnrS7Cl6R6GP+N3CiPaKjYBLRhKlqiWNJcFDF9Y5Vp8owg6bgv7QlUYCeeGZjjjJvB2uvBWhRcIgSaDTT8wuIcxmrWih6Qz1NUTjDdpYTo8ACFW1khevfieQeq3OvUjd2wdfzKZDXdn6dA5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=U39cD7qz; arc=none smtp.client-ip=202.108.3.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759366498;
	bh=IXPpZ1XolwI54l8PCtR6dCgKDc4IwnVpgxe3jJtBRk0=;
	h=From:Subject:Date:Message-ID;
	b=U39cD7qzBoMovYWEHvgcYMMJe4XWirSmXr+8E/ThGqb7a6iP4q0486tZo2rmYFbua
	 26lyrwinYj9eXBM2BXNIvt0gbNsGklmK0R+BJVm3vYfSvA7M5mjxZD/uKtcT1/Xkaf
	 SEnQiHZ+dsBjrSj6JaFobfBtIc2Zm8cwUs35fnnU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68DDCD5C0000149D; Thu, 2 Oct 2025 08:54:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8819496292001
X-SMAIL-UIID: 9F09B8E6ED6C42C1A6604C5970F7CD43-20251002-085454-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in free_mnt_ns
Date: Thu,  2 Oct 2025 08:54:42 +0800
Message-ID: <20251002005443.7942-1-hdanton@sina.com>
In-Reply-To: <68dc3ade.a70a0220.10c4b.015c.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 30 Sep 2025 13:17:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    449c2b302c8e Merge tag 'vfs-6.18-rc1.async' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b43858580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=595e5938a1dd5b4e
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d23dc5cd4fa132fb9f3
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c9ad04580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160bf27c580000

#syz test

--- l/fs/namespace.c
+++ n/fs/namespace.c
@@ -4165,7 +4165,6 @@ struct mnt_namespace *copy_mnt_ns(u64 fl
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
-		ns_common_free(ns);
 		dec_mnt_namespaces(new_ns->ucounts);
 		mnt_ns_release(new_ns);
 		return ERR_CAST(new);
--

