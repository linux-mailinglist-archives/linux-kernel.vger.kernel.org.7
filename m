Return-Path: <linux-kernel+bounces-825467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B0AB8BDB9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70622A0627D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C7207A18;
	Sat, 20 Sep 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="kIZIEsVv"
Received: from r3-18.sinamail.sina.com.cn (r3-18.sinamail.sina.com.cn [202.108.3.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6810F1
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336978; cv=none; b=HKYkK7cCu4KUsc4o3akkDKRjwD7UnC1qDko03p0xDwGsOYOcI3+op5gIPfuyr69BqL6/oCJRENqpHbedeL6S5nypWnO+KdrU5JfaFW7aiHXDQD4Bc42rQIM98eM7T3Xw9nEW3559Uv/F3JSkk3ajM+ZnUhpxMZeQnbmb5SJ85mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336978; c=relaxed/simple;
	bh=7NK7iEd451B/LJGLhYg27QxKUrY13QcZzWrpFuD1MPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVCMmKqqAzUide+P8cBt5ylcoFUcYHtiIaDzTw/WfYfOAT3sfgoil0gozUBuFXhpZhqDGWu+xdDyXVXAl89dHAaG3L74q2evgOSvo5FpLgJtHopVdAksOTAHsH09+NrALFGreRP5sdHs8CLrEocvyC1v7AoJZ6Q97TWKqwn9vF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=kIZIEsVv; arc=none smtp.client-ip=202.108.3.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758336973;
	bh=sLq9wdq9US8kGL9XX9xchRU7kncVV956CqsskTxYAhc=;
	h=From:Subject:Date:Message-ID;
	b=kIZIEsVvE6ADW3dqaL+0I34fMumqj5v96E5Ypi726a0Go3zZosQbYxM8qg/948x2Q
	 hYLDuacEAP29qu5zJGb50bT0E7H0eqc8w00xmV6KeI9wn/uxmomM93BJMfUANYeeKY
	 y9kbiTWXSaLJcVkWFkmJxQU7VTtUZWXp/Q6k9T1k=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68CE17C0000069FC; Sat, 20 Sep 2025 10:56:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4071354456619
X-SMAIL-UIID: 46266A8BC4D841EC905DCB69E96A96CD-20250920-105603-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
Date: Sat, 20 Sep 2025 10:55:49 +0800
Message-ID: <20250920025550.7294-1-hdanton@sina.com>
In-Reply-To: <68af7ed3.a00a0220.2929dc.0004.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Wed, 27 Aug 2025 14:55:31 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11fecc42580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=5a2250fd91b28106c37b
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c94858580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea7bc580000

#syz test linux-next master

--- x/net/core/skbuff.c
+++ y/net/core/skbuff.c
@@ -594,6 +594,10 @@ static void *kmalloc_reserve(unsigned in
 	 */
 	*size = (unsigned int)obj_size;
 
+	if (obj_size > (PAGE_SIZE << MAX_PAGE_ORDER)) {
+		obj = NULL;
+		goto out;
+	}
 	/*
 	 * Try a regular allocation, when that fails and we're not entitled
 	 * to the reserves, fail.
@@ -657,7 +661,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	    likely(node == NUMA_NO_NODE || node == numa_mem_id()))
 		skb = napi_skb_cache_get();
 	else
-		skb = kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA, node);
+		skb = kmem_cache_alloc_node(cache, gfp_mask & ~(GFP_DMA | __GFP_HIGHMEM), node);
 	if (unlikely(!skb))
 		return NULL;
 	prefetchw(skb);
--

