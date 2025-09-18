Return-Path: <linux-kernel+bounces-776980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325AB2D3B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1542616E77F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0462BD582;
	Wed, 20 Aug 2025 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XZGhbgJA"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BD22D4C3;
	Wed, 20 Aug 2025 05:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668423; cv=none; b=P/14dfOHWDNQIcPHVdK4Rc6xTXj/5ENgisSlArOGPye+E6VHpRgFFJV8Y/bs0Qvsxa7ZcmuFxClTx+IOKzm+rKLq7NMRv/dQU9Ozi1kDyQDtFTSMEddxFttWtnsC72X3WxZ3HpCfLqPSFEU1JuBRQ/qlEgAlETV455EiVhYAkcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668423; c=relaxed/simple;
	bh=ILaNbJn5HNYKVnX5VFPhvmllfQaHUS+n+I/U4jSWibA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFheiY6C1febQTV0lYFvVd5F4L7FXR/R9j0mvAk39Jz65pGx5xYYX46M+dWyy80DeUpWZbsCO96K96UuyeoRgHkEWh/xXPtL8jyPs95q/ew6ysGxRUaYEOJ9yc9s5a0G8uJat9eOUhx7Gta8PX7bf2akJpqvk4CQDfPxRG9EJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XZGhbgJA; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755668418; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=G5p+r4JljAf2GgtlwI0TDUe77jYdbD2CY8bO7sSENRI=;
	b=XZGhbgJAXAP3R9eOUKz8O52YOV95BKcEUhc16FJTdfN6AftoCQAREZBWcvBOdu3oHaWvCcCkc1zn5fjBzkgqtAM8GESSKJ4Q8MDV6WehQNSzPZGMEnfHVP6zZ6wMBD5v1awKeZJ8dyz61ad8iwxLACEmef72hAwrmvqzZ/2SLag=
Received: from 30.221.144.123(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WmAN9rA_1755668098 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 13:34:58 +0800
Message-ID: <e1d33394-c6c9-4f0e-a180-af743772a1e3@linux.alibaba.com>
Date: Wed, 20 Aug 2025 13:34:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: remove unnecessary NULL check in
 ocfs2_grab_folios()
To: Dan Carpenter <dan.carpenter@linaro.org>, Mark Fasheh <mark@fasheh.com>,
 akpm <akpm@linux-foundation.org>
Cc: Joel Becker <jlbec@evilplan.org>, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aKRG39hyvDJcN2G7@stanley.mountain>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <aKRG39hyvDJcN2G7@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/8/19 17:41, Dan Carpenter wrote:
> Smatch complains that checking "folios" for NULL doesn't make sense
> because it has already been dereferenced at this point.  Really passing a
> NULL "folios" pointer to ocfs2_grab_folios() doesn't make sense, and
> fortunately none of the callers do that.  Delete the unnecessary NULL
> check.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 821cb7874685..162711cc5b20 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -6928,8 +6928,7 @@ static int ocfs2_grab_folios(struct inode *inode, loff_t start, loff_t end,
>  
>  out:
>  	if (ret != 0) {
> -		if (folios)
> -			ocfs2_unlock_and_free_folios(folios, numfolios);
> +		ocfs2_unlock_and_free_folios(folios, numfolios);
>  		numfolios = 0;
>  	}
>  


