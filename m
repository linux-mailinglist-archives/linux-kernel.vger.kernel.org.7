Return-Path: <linux-kernel+bounces-722673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71492AFDD9A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8290A4E5AAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB81C861E;
	Wed,  9 Jul 2025 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gVGuTAkj"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE808F9E8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029005; cv=none; b=F88gXgc4Iq78qzrHwHsK+t0qNSkeT038Iv1tFvdNmKCmTsMlQjwxDaxK+PUqMasUdgJbeNFKfVrcpwojnz69T5WsH988//zzBED/nI8ruke2cl9Pr9O/hvNE0hJfe82jj2zGqlkfXsJQ+rF/MYY9oVk36U6vx39vqdesPeFRM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029005; c=relaxed/simple;
	bh=+q5YowaNrHmVTA3FzQx2MD/NXyusuSCSPxwoW/EMkZU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MxFVAkfC1IqLqOxV/uqEnZh725jtrZzfqkna9kAgCBY49XHcDhzt2p+ECjoqRafPz6IwnjBPA71STlxnFc/2nbMDPz6LdzhhvCoUT3qu19EIQqYXAC8rKrk+GQCJ+dejKE/6eGD3qNbHHAhBRuwZb0MDqHTyXXqUmhfDxelZVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gVGuTAkj; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752028991; bh=tQL8jiUZ5ScuPbAHCmx74TBipBdcAwCoQ7D4u/wW0A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVGuTAkjLynQewqOQK1aZBVDeniaXHsJWZJsMN5t9qXcl1OHJnySflu2kTEI6soaq
	 VU4vf1Q6bRF+m0ayKAPDs1E285leWsJSZW1JMK221sPpc5lP938w771RUns/mO77Bf
	 D7ywDX+q4X+KTtYcY2G48bOnorcB0htpXgWR5+rI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 5A70A8C0; Wed, 09 Jul 2025 10:22:39 +0800
X-QQ-mid: xmsmtpt1752027759t15kfukuf
Message-ID: <tencent_1483A44448B76A9774E6C953790367296005@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jHc3GuY026C6soFeyOyXJcwo+p5oqVXIcglSv+qWo0G+8UBaIy2
	 o1Vr9di6i3oe9hDTvnN0AB7wWdvrKglZjHe37+65q+g1fRr5MombvqGef6W0o+ggK0ci2eCQugAK
	 zJxCXUJ6OfPM0+2wyOBohiDqtHPAhIbnsRyt/Datt+dPtetvw9bhCh117vUafr8rqylf4XkXquQW
	 1mvmuXPMh54ZTJAcRlkRcRhILx9tdpHd5yHu4/R3PSxQS3/+sa2JRLyW3oh+v9z6Rfy8aUhFI/6F
	 /jSHc+/uDIksMVI58tSjME39Z9M4KaNUypJjT9N8qsfZpl1m1E+Dk2HP3ZU+0RqtsTui/OtcLnYt
	 G1C49PmbN2B/x26nNwpOJl3YDhMcWHwzZC6cBH5GOY5vlISVEhPTx9eGG/zMn2sV3eE/WE3/EZaL
	 JyV9MuA+4iCTHj3miTJ7pr3gn9/A7YiLFlyJc24K1/kQ9IrQpNH9dux0TaQwrSq7ZMKiKX78+0FD
	 BR5uZklm+bLVZa/IU4ahAo9xqp0c02QN0I8GKYohERu49irR5nOddXagwv9aGCNIBcmlHvq5yov4
	 JfCbPjtSKQA8aHXkrzd6K/H5UxYoyEYl1bTHBRw4ezCelf/eO3ArZ0vLWz9Jx3pdXOQio023liW8
	 NvnuKEn4NmbqqdQgtYy/qWqMV5FtSfc87S7oFITyQt/3Akbc/xNeY2QlKlPjODjsIcgpFrOlTOqm
	 r7QZ3ebz4qKZu8dwKY7qHqqxHxdOGgOfO6w9BL91jqCvn4iCY39/4/piFzYUH+yVIzRLOGjn6X9r
	 zc8lPIQLaf+/2ER2jlboWfO/QmwBYi+WSoi4bq/WXYs6++4C6wx+9JT8+71uzIiAun+3O5fPQWs2
	 bqTv6aHbNl/MBZlTecSjt/UDSa3HCwN0b6IBLMYiCfa2onwMC2Tph5p7p5yuoXlw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a6ffe86390c8a6afc818@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in ucma_create_uevent
Date: Wed,  9 Jul 2025 10:22:09 +0800
X-OQ-MSGID: <20250709022208.437753-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
References: <686db3ea.050a0220.1ffab7.0028.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..762c96d5d9e2 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1506,8 +1506,8 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mutex_lock(&ctx->mutex);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&ctx->mutex);
-	ucma_cleanup_mc_events(mc);
 err_xa_erase:
+	ucma_cleanup_mc_events(mc);
 	xa_lock(&multicast_table);
 	list_del(&mc->list);
 	__xa_erase(&multicast_table, mc->id);


