Return-Path: <linux-kernel+bounces-784023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23237B335AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5CF17D511
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66E221578;
	Mon, 25 Aug 2025 04:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="IG2gNqXs"
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AC194C96
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097509; cv=none; b=otnZXhUNORsPxFSty93kfdjBWzgas8KEMwhINJP453v2X/3jaHdKOH1elbCXXYtq9TFL4JfjOaUQrzowEep/gkU5OksabeWvi6yjTX95XKEqU1EJuCKnS8JA0mlzJ7/++KKgtcJkr8MybbvjRLHtlGS9IQXMywA7rmvJpaDG9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097509; c=relaxed/simple;
	bh=dp9Fc2vD/D2tx9r0fuAKbK8H7F5jAsIuxuKf5cKJEc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iop/NEPVPSduYmWXxwgPcXYklJTQkLM8d5s8Hpkzj25byfu9aLvnl+4NmY/YMst9Wd6AbCrYZdj6EVI6ydZe8OElCk3p72bXpD1Zrvmt8BsI/X3ok8z08PTlJDo2Gg0X09/9br1KaZ2Mwghqq6Yoe7VUH3ci5NN+KEHsy3sHp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=IG2gNqXs; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756097503;
	bh=umHrnP+GRHzFgPloAmwb8Vj142jM8jrJyXyKUqfqth0=;
	h=From:Subject:Date:Message-ID;
	b=IG2gNqXsZFw31GtgTwiJBfGc7tJiXO+NC7lwNskcEoA1itfY3ItCg9o3JgUCEmGRL
	 /WoIIsq/6f/YQeIn6/WN3wqYQgsulw+bee6geskZbfJnin59L9bGA3WdocDaBudxBm
	 pju+/eAXLALxDR/DRnOV4Kd0HG6ofm/9QTlQ0adQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68ABEBD4000044DC; Mon, 25 Aug 2025 12:51:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8159706816269
X-SMAIL-UIID: 8BCD43DE3C6D48DC9E925E43443F8711-20250825-125134-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Mon, 25 Aug 2025 12:51:24 +0800
Message-ID: <20250825045125.5372-1-hdanton@sina.com>
In-Reply-To: <68ab6633.050a0220.37038e.0079.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 24 Aug 2025 12:21:23 -0700	[thread overview]
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    b1c92cdf5af3 Merge branch 'net-wangxun-complete-ethtool-co..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1411b062580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=67b99ceb67d33475
> dashboard link: https://syzkaller.appspot.com/bug?extid=a25ee9d20d31e483ba7b
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14221862580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159fba34580000

#syz test

--- x/net/xfrm/xfrm_state.c
+++ y/net/xfrm/xfrm_state.c
@@ -615,6 +615,8 @@ static void xfrm_state_gc_destroy(struct
 		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
+	x->km.state++;
+	xfrm_state_delete(x);
 	xfrm_state_free(x);
 }
 
--

