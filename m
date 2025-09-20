Return-Path: <linux-kernel+bounces-825372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208BB8BB2E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1345A532A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E597207A18;
	Sat, 20 Sep 2025 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Kn0hvkLs"
Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A9142E83
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 00:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329009; cv=none; b=ZJruAyEPRU+jKd3DH8eWbyrd9+6uK4LBDLFAugz3Hl+KriQx8nc7PyESQFeq//o8tq21CXpGIVBjLhCtr5fl2nlb+iA8Mqc+ltd5gh+tHfq/oOvvJg749bwxx+x932BkV1dAAHJ2+nnnBi3NtDSRoobhu6mTmRY82Pd/WcJpU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329009; c=relaxed/simple;
	bh=f7o1/6fyI/Dgz29iamkumHyaL6Nr4mTXYAa2T5l1bEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJMgW8NlQFk9gZ60b0DiCnVzZY3hVdZWluC7OiYfFhAWgcY+gmWeDybMmTgxIsy2tCS5PUm4oKAbOCzqk8S+ru3ckx80RSsXSPyFqS4fRQyBJcJ0VyEPNdohRFx5/PHSmyNWn2olnn0ts1LR79ZXVJtdOaF5hA4jBVILt1tUTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Kn0hvkLs; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758329000;
	bh=eNH1ER8sQFY9wrfvTE6Za+mVUUdpcPmPX87FiDNsXrY=;
	h=From:Subject:Date:Message-ID;
	b=Kn0hvkLss46Nt0pgHGZE0D4+WSdbPQTK1e9MvdoRkRIlvJqCcFfP437jYzUsMZ6a8
	 SWYqhXIgDv+zmVQwsYOqhzczFUYvJX9YlU/2bqFECoKV9Dm5rWGb5owyRfweTRvQpq
	 7Hzq7BPOmD728YtvGM5Ixrg/lhHtMB/pKAUHrCT0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68CDF8A10000357C; Sat, 20 Sep 2025 08:43:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3220556292143
X-SMAIL-UIID: 28BFA9AC4C0640E28D7EBC84552AB059-20250920-084315-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a2250fd91b28106c37b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] [usb?] WARNING in __alloc_skb (4)
Date: Sat, 20 Sep 2025 08:43:00 +0800
Message-ID: <20250920004306.7233-1-hdanton@sina.com>
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
@@ -657,7 +657,7 @@ struct sk_buff *__alloc_skb(unsigned int
 	    likely(node == NUMA_NO_NODE || node == numa_mem_id()))
 		skb = napi_skb_cache_get();
 	else
-		skb = kmem_cache_alloc_node(cache, gfp_mask & ~GFP_DMA, node);
+		skb = kmem_cache_alloc_node(cache, gfp_mask & ~(GFP_DMA | __GFP_HIGHMEM), node);
 	if (unlikely(!skb))
 		return NULL;
 	prefetchw(skb);
--

