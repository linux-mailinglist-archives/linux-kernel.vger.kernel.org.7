Return-Path: <linux-kernel+bounces-763262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413F5B21278
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54830189A8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0B1296BCD;
	Mon, 11 Aug 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="de/EJevO"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B191DFDAB
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930458; cv=none; b=QafqyiDT2wiVyEv9HNWCfQuVz16FKEENwKa8oi97q5xCdQKL5mCj5SgHwn2VDmTdyhSXuHW5IV+prbAEYgZlz+FLoWV24K+GjszEjvPNd4oZz6Ct4nGZer/vI6IgrmwebBGRjazfjcA3IpeFp9NzOUOIibaLhrzKExPRkt+Uzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930458; c=relaxed/simple;
	bh=lrErPlSj13yeFJFUN8Q+kC49+CUkgmgYn8aKCHsxA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGVRs/7CSq5YqT1X45CIMJctRtsE81Ly58kwoz+9n2wg0U7P/xTd1vnEtDtN3qPkXjfXlqbHhnQcwVPCRYrlXrM4dCvGvV+HPlFgaMB88oBKoQdPkYBrRb7+DvNqSELkzqif9Ab+Hod9x52ZRuCKGXz8iQXeOzBeiM3sTlUxTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=de/EJevO; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754930454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KNDajDqdLKrAEXDEBtkk4JWlF60OExIU365++ZNVha8=;
	b=de/EJevOJMu6noS+TC2khMQmxZEZYD++D2WCoMRVnIueEVBjT0eZ6IshQFPcxYsTu1XC2h
	myv7TLHmSR0Q6XtSIwxxAvLiMaHgW0VFUj3HVH20Wc7QOmVYvmWXLXHO0cROKYrFoHkXHf
	uG7WNFN/xX7JluXTCIUpBo+d901c0ZM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/sched: Remove redundant memset(0) call in reset_policy()
Date: Mon, 11 Aug 2025 18:40:38 +0200
Message-ID: <20250811164039.43250-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The call to nla_strscpy() already zero-pads the tail of the destination
buffer which makes the additional memset(0) call redundant. Remove it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/sched/act_simple.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sched/act_simple.c b/net/sched/act_simple.c
index f3abe0545989..8e69a919b4fe 100644
--- a/net/sched/act_simple.c
+++ b/net/sched/act_simple.c
@@ -72,7 +72,6 @@ static int reset_policy(struct tc_action *a, const struct nlattr *defdata,
 	d = to_defact(a);
 	spin_lock_bh(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(a, p->action, goto_ch);
-	memset(d->tcfd_defdata, 0, SIMP_MAX_DATA);
 	nla_strscpy(d->tcfd_defdata, defdata, SIMP_MAX_DATA);
 	spin_unlock_bh(&d->tcf_lock);
 	if (goto_ch)
-- 
2.50.1


