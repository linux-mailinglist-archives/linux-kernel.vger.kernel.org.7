Return-Path: <linux-kernel+bounces-728461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025CFB02876
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 02:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6521C486F8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF5A13B284;
	Sat, 12 Jul 2025 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pLl6rK+S"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4A47F4A
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752281890; cv=none; b=pz4yjUoVkTqqXDWTWmAHbOhHlFiToKZqBTjxL78KD3GEegfm2gfalD8glaBjZp60Cmrhxv8VE4s19bxM3LCqVnF1poZGFzhCjCnD/36BRFiYTIcLUaPNjt0KBUN4iimp8RTRNmVaU8aZ8/F+SYVRAZ61EmmtpWaj1FZhjNZWWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752281890; c=relaxed/simple;
	bh=tAPVmD+1I3vsUPp1z9NyH5/brv6Ji48O5kH2bUFg/w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg6qf5q16GYiZWK6bYplBsM9iW6FrxgktNHwoC8qy3H811RreAHfBfDZvRCL1hX8F2YEgvUxsOk/7SP/G3w6GuUU80v0wYrg2HzNqPBvh95a/qrFMkB8e6D7Nc+stJ7JRDq2UTBV7ev/HbTnWjF5w73h0KKsmAEMsxV4CloIH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pLl6rK+S; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752281885;
	bh=kKTgaaKM4z2BoRD007DNe9K5mhNzZK4QT9NuZYKKZrk=;
	h=From:Subject:Date:Message-ID;
	b=pLl6rK+SCCvYvvrpG1zQXJuZzt0FIylikg+02DlrFotzqBkVIA9RC0EyRNECW72rk
	 RHy4CrilEizmy5Sn9s+++hqsm+L3TeE4PhsCZX1RIE8TnUnn8snCpTRUq1xYKk3B9P
	 1SYb18Vdb4C6h6TZ5oSdMxQ2nbo2Q4M3VeymHogg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 6871B3180000461D; Sat, 12 Jul 2025 08:58:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2164766816326
X-SMAIL-UIID: 9273892E94EF419C9C63765A0F66BDBC-20250712-085802-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0ee4da32f91ae2a3f015@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hams?] WARNING: refcount bug in ax25_setsockopt
Date: Sat, 12 Jul 2025 08:57:50 +0800
Message-ID: <20250712005751.3574-1-hdanton@sina.com>
In-Reply-To: <68712da2.a00a0220.26a83e.0052.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 11 Jul 2025 08:28:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    faeefc173be4 sock: Correct error checking condition for (a..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=157b9c04580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=eecd7902e39d7933
> dashboard link: https://syzkaller.appspot.com/bug?extid=0ee4da32f91ae2a3f015
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15875398580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137b9c04580000

#syz test

--- x/net/ax25/af_ax25.c
+++ y/net/ax25/af_ax25.c
@@ -694,8 +694,10 @@ static int ax25_setsockopt(struct socket
 			ax25_dev_put(ax25->ax25_dev);
 		}
 
+		spin_lock_bh(&ax25_dev_lock);
 		ax25->ax25_dev = ax25_dev_ax25dev(dev);
 		if (!ax25->ax25_dev) {
+			spin_unlock_bh(&ax25_dev_lock);
 			rcu_read_unlock();
 			res = -ENODEV;
 			break;
@@ -703,6 +705,7 @@ static int ax25_setsockopt(struct socket
 		ax25_fillin_cb(ax25, ax25->ax25_dev);
 		netdev_hold(dev, &ax25->dev_tracker, GFP_ATOMIC);
 		ax25_dev_hold(ax25->ax25_dev);
+		spin_unlock_bh(&ax25_dev_lock);
 		rcu_read_unlock();
 		break;
 
--

