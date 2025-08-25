Return-Path: <linux-kernel+bounces-783847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E0B33375
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498081B222B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909CF215043;
	Mon, 25 Aug 2025 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="nghItWsS"
Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3043208
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756084396; cv=none; b=R59w0eo6GZTQr0FaHWPDXqTmMLcqSG+y+pr4VWT699PdJ6nEH2a+FuhLRSyYgz31MXFytFrkiWyRQUsCFfXhFsdA1HAShaDHjiBhaxwt4qwa+rDjXXNaCbfr+/ZPWqYpkpwhy++uXG6c68U5PFOX5YA8wXy7hs6fc8F+RXYQkSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756084396; c=relaxed/simple;
	bh=hFVXrWJgUXiSDSuq7Cgea1+PHI1Kq8lsi44+zsNXp4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPNJq76VVZXvk8cdZlO6H8SrE/eTjUk5BWqZUwZtPTknE9Cg9uVCjk6lmnI1vnpJTpWAdtaVUajjXKe83C1B1/NlDNErZTVFEtvxBLJw7dCk+VNOhgDTmXRrXbyJb8prfKLERJUAJcTuzzr48jTb8gG4lN/inqVsLwTrCpN8B6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=nghItWsS; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756084391;
	bh=ooEcsGGDShrqtVrRmOwdaQYkvWjcH1LuqBz2Uhp2OH8=;
	h=From:Subject:Date:Message-ID;
	b=nghItWsSPC1LGH1Y+7FAbbjCDtW+u3/aEksZBU5V9xKCEW9YuvjkSU9I3XqlkYau8
	 Pjomly4R+RxiaJZXTnbrO8eosremSv0NhZLfQY5HstG789mblBExhIdjggv1jodjH5
	 IDut0KDjolpdFiAfsb8D+Fp6aNT3gqibxqPDFpL8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68ABB80C00005760; Mon, 25 Aug 2025 09:10:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 483996816236
X-SMAIL-UIID: C734A9DDD959444CBE3B1D7F9DD27C8E-20250825-091038-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a25ee9d20d31e483ba7b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in __xfrm_state_delete
Date: Mon, 25 Aug 2025 09:10:28 +0800
Message-ID: <20250825011029.5339-1-hdanton@sina.com>
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
@@ -615,6 +615,7 @@ static void xfrm_state_gc_destroy(struct
 		put_page(x->xfrag.page);
 	xfrm_dev_state_free(x);
 	security_xfrm_state_free(x);
+	xfrm_state_delete(x);
 	xfrm_state_free(x);
 }
 
--

