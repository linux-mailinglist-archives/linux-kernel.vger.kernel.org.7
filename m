Return-Path: <linux-kernel+bounces-787450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62837B3765D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6113A1B65395
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A41DED52;
	Wed, 27 Aug 2025 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNh3EhjC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDD1D63DF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756256307; cv=none; b=SFt8udV49+WjzVqRm2f3PcT5UB0BtsC9QVflFKq9Rqbnau+gJh1GseddJ/4MEiXqQzGho5SSJ5gcIjN+Ez6ik0nySNiV15j0tGTLUDz9sAyJ6F/UFnPjLGhCX7d+j6lKulO8+cC0PINWZlt5q8UCoDpbTQbDgBqd3fwUqismL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756256307; c=relaxed/simple;
	bh=pJcb+Fht6vB+reX+TqG9R4aKlunq8AvYtB6xYR2vnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfqbQY3DJETfdRofKXQxfpsmYym/kOJ3On2o7t6dr1DYc9xQuPRpqkHgTLGnXmmXeGh8FtaiZ0ULyhdJ41XvSSN/vTcgc6k6DMQEVlAz5HvQdiHFqPliaZZ5aSPq8yVjgNh1B2urKo7pTRIMLMqUioO3DBeM4j1R9QDX2Q8wauc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNh3EhjC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756256303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Vds8El0nHCfAOchscouR6LADiC3NFwfPcPYTHIEQ4=;
	b=GNh3EhjCbepf2VLHaBfbfEdtJka/gJuoiytdOAhCRt7ytvIK0FX/ie60mWQ5eyzBlYz1dq
	nPaFcd+OjV8koJ9RhkQTgjMvfk6yN21M5PZz6/sxRb1MSfvcdhtK8YDgoN0VZnVX2D/lyq
	7Te0PBN4mDwQ1AtKTfTHiWn0kwvLX+8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-2asWDuvsMGqG5usYVPu2Zg-1; Tue,
 26 Aug 2025 20:58:21 -0400
X-MC-Unique: 2asWDuvsMGqG5usYVPu2Zg-1
X-Mimecast-MFC-AGG-ID: 2asWDuvsMGqG5usYVPu2Zg_1756256300
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCEB919560B2;
	Wed, 27 Aug 2025 00:58:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23BC519560AB;
	Wed, 27 Aug 2025 00:58:12 +0000 (UTC)
Date: Wed, 27 Aug 2025 08:58:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linan666@huaweicloud.com
Cc: axboe@kernel.dk, jianchao.w.wang@oracle.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yangerkun@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] blk-mq: check kobject state_in_sysfs before deleting in
 blk_mq_unregister_hctx
Message-ID: <aK5YH4Jbt3ZNngwR@fedora>
References: <20250826084854.1030545-1-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826084854.1030545-1-linan666@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 26, 2025 at 04:48:54PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> In __blk_mq_update_nr_hw_queues() the return value of
> blk_mq_sysfs_register_hctxs() is not checked. If sysfs creation for hctx

Looks we should check its return value and handle the failure in both
the call site and blk_mq_sysfs_register_hctxs().

> fails, later changing the number of hw_queues or removing disk will
> trigger the following warning:
> 
>   kernfs: can not remove 'nr_tags', no directory
>   WARNING: CPU: 2 PID: 637 at fs/kernfs/dir.c:1707 kernfs_remove_by_name_ns+0x13f/0x160
>   Call Trace:
>    remove_files.isra.1+0x38/0xb0
>    sysfs_remove_group+0x4d/0x100
>    sysfs_remove_groups+0x31/0x60
>    __kobject_del+0x23/0xf0
>    kobject_del+0x17/0x40
>    blk_mq_unregister_hctx+0x5d/0x80
>    blk_mq_sysfs_unregister_hctxs+0x94/0xd0
>    blk_mq_update_nr_hw_queues+0x124/0x760
>    nullb_update_nr_hw_queues+0x71/0xf0 [null_blk]
>    nullb_device_submit_queues_store+0x92/0x120 [null_blk]
> 
> kobjct_del() was called unconditionally even if sysfs creation failed.
> Fix it by checkig the kobject creation statusbefore deleting it.
> 
> Fixes: 477e19dedc9d ("blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues")
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  block/blk-mq-sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 24656980f443..5c399ac562ea 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -150,9 +150,11 @@ static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
>  		return;
>  
>  	hctx_for_each_ctx(hctx, ctx, i)
> -		kobject_del(&ctx->kobj);
> +		if (ctx->kobj.state_in_sysfs)
> +			kobject_del(&ctx->kobj);
>  
> -	kobject_del(&hctx->kobj);
> +	if (hctx->kobj.state_in_sysfs)
> +		kobject_del(&hctx->kobj);

It is bad to use kobject internal state in block layer.


Thanks,
Ming


