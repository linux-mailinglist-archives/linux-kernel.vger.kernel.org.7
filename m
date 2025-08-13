Return-Path: <linux-kernel+bounces-765757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92073B23DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CBC189C3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B8137C52;
	Wed, 13 Aug 2025 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="yyWC3eu1"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEB249EB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049643; cv=none; b=PpUjBwDtkmnfJ5B97NKonieUqO7PA0ZfEMXHy804LPV8gFe5jXZjCQ8MWVlJPz5TIzXImTZzs/oeGdF4fSWeM9ddJtepa14LniHB9hBVxqcqc2K+uTB4Ww1FZY58sPdYanFwoWVdOBxsxbnO1Wook7C+4lBIR7Rmc1Lm0VWDSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049643; c=relaxed/simple;
	bh=9Pjkxu+S6YgfM6HJUTh+wQjSz/6m1PpUR4lyxg/SdeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwFgknlKbUkSTUxh9KewO4zs+mIClVpnmQNQ/k/kLEM2iW8JN1gsUFrl7opuhVv8Vy0KKlntJ+lgTgYkkuAIAiwRUYwvQVzaBDAkOu0RdyD6lBcM6svcJp/KgEemKHZshIPy8E8CSPefKB7PXwtSPoYC+KaDsSC5v2bpzUS6pm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=yyWC3eu1; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755049632;
	bh=+SPlXadqGJJJzwhlWA4852QMi5Qf1b5oYWTYJs77JJk=;
	h=From:Subject:Date:Message-ID;
	b=yyWC3eu1NDwwt3v4T0bka0XG1SfexwKNz7r6jsXjXefIEg8nzWGoFdDwPmUDKIhAi
	 77uqq9CrABDmgIv+qq6Iq0z8LM7Ty8Y7PJda9cTHyWq53dipouAMpAxi8Aet6BxrdC
	 7mc7Aq57DYhFPs8MYJ2w0Ez2Jn9FgEHy5rocceYo=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 689BEE9B00005FB8; Wed, 13 Aug 2025 09:47:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2160604456607
X-SMAIL-UIID: 6F40DA55FEB841CB9DA0A41103B480A9-20250813-094709-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_unregister_user
Date: Wed, 13 Aug 2025 09:46:57 +0800
Message-ID: <20250813014658.4404-1-hdanton@sina.com>
In-Reply-To: <689b6c67.050a0220.7f033.0134.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 12 Aug 2025 09:31:35 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=15494c34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=14b6d57fb728e27ce23c
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1428caf0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11da19a2580000

#syz test

--- x/net/bluetooth/l2cap_core.c
+++ y/net/bluetooth/l2cap_core.c
@@ -1714,6 +1714,7 @@ int l2cap_register_user(struct l2cap_con
 
 	list_add(&user->list, &conn->users);
 	ret = 0;
+	hci_dev_hold(hdev);
 
 out_unlock:
 	hci_dev_unlock(hdev);
@@ -1735,6 +1736,7 @@ void l2cap_unregister_user(struct l2cap_
 
 out_unlock:
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 }
 EXPORT_SYMBOL(l2cap_unregister_user);
 
--

