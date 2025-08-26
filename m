Return-Path: <linux-kernel+bounces-785891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B50B35238
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138F77A9890
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4752D1F72;
	Tue, 26 Aug 2025 03:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lAsmwa9p"
Received: from mail3-165.sinamail.sina.com.cn (mail3-165.sinamail.sina.com.cn [202.108.3.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59619F137
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178869; cv=none; b=CnTSHko2VEOAjkf/jWKvIjMrSVHfDmPnXFFDZusZ6u+in3+Gfh+O4qFrEamCrZUAFk6WsgmUqj0JTUvfnlNATtO0a28eHevx3V9wz63cn11d/IeQo0pIiuU42JOE1kjJEBw7m6HZ78M4yYK3fQW/0S+7lovrhthWfmNaeEXlvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178869; c=relaxed/simple;
	bh=B3svkU2f3qi1zev2tHvRBHlzdaEn3brBzjYFCbPORMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIaNoHXu68+/XqLaxWZZUw2IVTxZLGl4L+10pefGMoiwfc1cW/9Jz/n2gTthbFh392QdX8LBNgQxWmCz6iGkAvB2V759gXKWxBmjx373uNMAqqdIlXkrtHpjNepIS3jefOS1InP2BY/FHee3yKb0CpMnfkktb0FfHvRyle6lM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lAsmwa9p; arc=none smtp.client-ip=202.108.3.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756178864;
	bh=HEB2ddPtmZydgAkVYcyzE1MWrXQ3XUMD61CA3jfW3A4=;
	h=From:Subject:Date:Message-ID;
	b=lAsmwa9pcpK4nVDxIZTX2soTZPtgg9bXtt0e7PTpz0Yzos5uBpPefd2yewc2PrasR
	 n3LLRUiG2NXl8LcTnxk+J5shgeZND22t6kZPdO2dRyArdVuR6wiySqs2DgMOVhh+RV
	 ylwe4ZeIDzB/Xat2FDfswNLCUqk81UJRvuvh2Mno=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68AD29AC00006C35; Tue, 26 Aug 2025 11:27:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5665576685014
X-SMAIL-UIID: 46B1E8821D8749879616F6C2938F4607-20250826-112741-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Tue, 26 Aug 2025 11:27:30 +0800
Message-ID: <20250826032731.5585-1-hdanton@sina.com>
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
@@ -798,6 +798,7 @@ void xfrm_dev_state_free(struct xfrm_sta
 void __xfrm_state_destroy(struct xfrm_state *x)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
+	WARN_ON(!hlist_unhashed(&x->bydst));
 
 	spin_lock_bh(&xfrm_state_gc_lock);
 	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
--

