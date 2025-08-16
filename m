Return-Path: <linux-kernel+bounces-771715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E482AB28AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0C0A25D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD41DF261;
	Sat, 16 Aug 2025 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Ty/yhhyu"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714001862A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755321680; cv=none; b=t0x+9+FzsVobKLF8k+N/Rb7ClUUfF3dhdEPJyQnE9hbg2/PIHhus7g0HiuOsUjOsmJrlDZla2ctVVSY4PL0alZjXjv6FR3/tDtqnHUaOJ1QnDFe8N6YM3e/pacxMKR4qAZaiUYYQSkCKvHSjP2pqOYoDJoDvfVq1preP2uoe2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755321680; c=relaxed/simple;
	bh=sn6Ma67MjR10z0241vZVJtlBs2yUz3uk4rbJEDBfsSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyUzHyK/WIMjiioFm59SHEqXHMI2qMRqluT27msgC/Y3fSDfkB5psPRDLXRzTNheJ8HQJ+9rTc8LW8jROKNVoz0GjDuPk+oVRTDtAqVnWMSyv7FMsWHMmUo81S+oK5cPcE6FDMUy1wg+XrykGm0CFlH5LqFGBFaFuBVEZjjl8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Ty/yhhyu; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755321670;
	bh=4psIGG+A/EzzJmGJeRDXlskfaP6zKa+nNyqiE8y2QSE=;
	h=From:Subject:Date:Message-ID;
	b=Ty/yhhyuHJe+P6C2DkAivuUQ0wC07P2nSE8t0rA7TplRUn+6G5gFIGJwHpc3XJqds
	 sVScl1ngeu9OBDtkhUEef86a3Oj1KZQc522R0P4PmMyWWHLPyglvCTgW5DHmZOM6Nc
	 ddBPvvpZzE5POn2G2Y/FTsjuTx3bG7CIDrQkGyAY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68A014AC00003829; Sat, 16 Aug 2025 13:18:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5820896685145
X-SMAIL-UIID: DC748C80E527414AB6F6243FEF8CF4B3-20250816-131838-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in usbtmc_interrupt
Date: Sat, 16 Aug 2025 13:18:25 +0800
Message-ID: <20250816051826.4739-1-hdanton@sina.com>
In-Reply-To: <689ff5f6.050a0220.e29e5.0032.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Fri, 15 Aug 2025 20:07:34 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    931e46dcbc7e Add linux-next specific files for 20250814
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ef65a2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb7fbecfa2364d1c
> dashboard link: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a99842580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17108da2580000

#syz test

--- x/drivers/usb/class/usbtmc.c
+++ y/drivers/usb/class/usbtmc.c
@@ -2365,6 +2365,7 @@ static void usbtmc_free_int(struct usbtm
 	if (!data->iin_ep_present || !data->iin_urb)
 		return;
 	usb_kill_urb(data->iin_urb);
+	usb_kill_urb(data->iin_urb);
 	kfree(data->iin_buffer);
 	data->iin_buffer = NULL;
 	usb_free_urb(data->iin_urb);
--

