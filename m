Return-Path: <linux-kernel+bounces-828895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED90B95C71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D200B1890BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBCA322DA5;
	Tue, 23 Sep 2025 12:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u8gKwvWk"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26325A63D;
	Tue, 23 Sep 2025 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629322; cv=none; b=uvcv/z7uHA49yGDoheKIws5B4GXj7nKeXSTtOZ/fEJdF3kNJtBHqcRYJBu/bhwHa9ieiGsUDJoETLJ+V6Na8Z37pJw2BWz1P2zQ2Kce5Pm71FfZTaDa6mSkmlyKjl1/QW7IPg2LVeMbSiwNWBoMOXYZh6hHLb3lisHZlX52HG/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629322; c=relaxed/simple;
	bh=XqdK+dVB52R9hO22B1Ljx9Z1OMrHcRVerGR1ZJN5DiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rk7kxM4+YBd5N/vfeNmh1jAGeXJa1qOij5Ug9Wuv+Eg1+MnbkmXZWFyEaXtTMZ0llzA3Yg1LJMM86izwbW6BxT7irqygDlJjIqgSfhwIigM8jSFgVNBmskdJcLCHVYDcX8WIeeKKJP4TZUsZlhGU8Vumjd4/sjxm2o6hNrMe2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u8gKwvWk; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758629316; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gv72N5m7jsG14hTMC17gDL8wo1JsrnxRDF65v0+UsDM=;
	b=u8gKwvWkdZqX2qJX9vl8fMqbKDAXnOmRufV6TGtpyq/QM1uH/T9ggC42qqk79JXKgzzMmImia3iIidQ4n/+vxLxAIXBwoPsG8mt7xLaaNfmJ/FnKbtdiQ6JboDDZhEDOx5W/Pmpa9u/oyoutQSsNIUImkXOAtk5cXbDxWtJRT1A=
Received: from 30.221.144.135(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WofL0mR_1758629315 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 20:08:35 +0800
Message-ID: <5416e506-e888-41b2-aea3-1155c74d91ea@linux.alibaba.com>
Date: Tue, 23 Sep 2025 20:08:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: fix double free in user_cluster_connect()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Goldwyn Rodrigues <rgoldwyn@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <aNKDz_7JF7aycZ0k@stanley.mountain>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <aNKDz_7JF7aycZ0k@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/9/23 19:26, Dan Carpenter wrote:
> The user_cluster_disconnect() function frees "conn->cc_private" which is
> "lc" but then the error handling frees "lc" a second time.  Set "lc" to
> NULL on this path to avoid a double free.
> 
> Fixes: c994c2ebdbbc ("ocfs2: use the new DLM operation callbacks while requesting new lockspace")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/stack_user.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
> index 765105f1ff8a..be0a5758bd40 100644
> --- a/fs/ocfs2/stack_user.c
> +++ b/fs/ocfs2/stack_user.c
> @@ -1011,6 +1011,7 @@ static int user_cluster_connect(struct ocfs2_cluster_connection *conn)
>  			printk(KERN_ERR "ocfs2: Could not determine"
>  					" locking version\n");
>  			user_cluster_disconnect(conn);
> +			lc = NULL;
>  			goto out;
>  		}
>  		wait_event(lc->oc_wait, (atomic_read(&lc->oc_this_node) > 0));


