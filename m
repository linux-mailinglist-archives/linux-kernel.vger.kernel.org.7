Return-Path: <linux-kernel+bounces-610022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 260EAA92F51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 03:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766F38E3DED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 01:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1D61DA31D;
	Fri, 18 Apr 2025 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW13BAId"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56E1C3BE0
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940168; cv=none; b=hmDye5j7Gf0JeW5Q2dq3/HeWOGQJ12/qXIwQF7gw5hY/b6fVJLOQxfSKI7jod6qbcX313txGjY6V/++3l4cSjVEONccOXynjFip+bJXO7ZDvsZXweR7zGuib8oz3Dkk0Jac4Vlb89n7nPNWpVveovNVJnxa/PbJsXvCGov4B87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940168; c=relaxed/simple;
	bh=k8J7hG9/vrA9FNCiw18EaeVhil9DtKEoGVnqQ893A4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6fzb9pxpHdUqmEQn0u6P3VRVMmnjHJ4kcqsdmKPCVlsT2k6GoimbMt5476kpbhrYFAxntBkw/nFhvq7Llx/DLG7v1RMkWYP9ACRXF2/rxR327ubNIY0fEqgX9Gsxs6sHG2DOgylot/KYRA4xrIg5/1CdzrsxaAsKWScxWSjMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XW13BAId; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744940165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=StCEkDFSO5ad1eauSPUv5vvsP4duU0OTrS4bvTblyrI=;
	b=XW13BAId1guUQeOmDyKgJrO89k/AmUgdxRWK3MUhS7bVzg0BnsRDGO5i29nCC+Cim1Giud
	rIgDChzjEJcxJ1ilIfpdiIy0nKEswwujD5UqLfVe6PdWqq0RfUlkZ0e0/jhZomROzaJsAA
	xnVXf+tZPofFicWFXkD70oIwUy2ywp0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-srSt5sSRMIWVBoaQR0bU1w-1; Thu,
 17 Apr 2025 21:35:59 -0400
X-MC-Unique: srSt5sSRMIWVBoaQR0bU1w-1
X-Mimecast-MFC-AGG-ID: srSt5sSRMIWVBoaQR0bU1w_1744940158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FB511955DAF;
	Fri, 18 Apr 2025 01:35:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C936319560A3;
	Fri, 18 Apr 2025 01:35:53 +0000 (UTC)
Date: Fri, 18 Apr 2025 09:35:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] ublk: mark ublk_queue as const for
 ublk_commit_and_fetch
Message-ID: <aAGsdAdnkAwTRWg0@fedora>
References: <20250416-ublk_task_per_io-v5-0-9261ad7bff20@purestorage.com>
 <20250416-ublk_task_per_io-v5-2-9261ad7bff20@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ublk_task_per_io-v5-2-9261ad7bff20@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Apr 16, 2025 at 01:46:06PM -0600, Uday Shankar wrote:
> We now allow multiple tasks to operate on I/Os belonging to the same
> queue concurrently. This means that any writes to ublk_queue in the I/O
> path are potential sources of data races. Try to prevent these by
> marking ublk_queue pointers as const when handling COMMIT_AND_FETCH.
> Move the logic for this command into its own function
> ublk_commit_and_fetch. Also open code ublk_commit_completion in
> ublk_commit_and_fetch to reduce the number of parameters/avoid a
> redundant lookup.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 91 +++++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 4e4863d873e6593ad94c72cbf971f792df5795ae..b44cbcbcc9d1735c398dc9ac7e93f4c8736b9201 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1518,30 +1518,6 @@ static int ublk_ch_mmap(struct file *filp, struct vm_area_struct *vma)
>  	return remap_pfn_range(vma, vma->vm_start, pfn, sz, vma->vm_page_prot);
>  }
>  
> -static void ublk_commit_completion(struct ublk_device *ub,
> -		const struct ublksrv_io_cmd *ub_cmd)
> -{
> -	u32 qid = ub_cmd->q_id, tag = ub_cmd->tag;
> -	struct ublk_queue *ubq = ublk_get_queue(ub, qid);
> -	struct ublk_io *io = &ubq->ios[tag];
> -	struct request *req;
> -
> -	/* now this cmd slot is owned by nbd driver */
> -	io->flags &= ~UBLK_IO_FLAG_OWNED_BY_SRV;
> -	io->res = ub_cmd->result;
> -
> -	/* find the io request and complete */
> -	req = blk_mq_tag_to_rq(ub->tag_set.tags[qid], tag);
> -	if (WARN_ON_ONCE(unlikely(!req)))
> -		return;
> -
> -	if (req_op(req) == REQ_OP_ZONE_APPEND)
> -		req->__sector = ub_cmd->zone_append_lba;
> -
> -	if (likely(!blk_should_fake_timeout(req->q)))
> -		ublk_put_req_ref(ubq, req);
> -}
> -
>  /*
>   * Called from io task context via cancel fn, meantime quiesce ublk
>   * blk-mq queue, so we are called exclusively with blk-mq and io task
> @@ -1918,6 +1894,45 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
>  	return io_buffer_unregister_bvec(cmd, index, issue_flags);
>  }
>  
> +static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
> +				 struct ublk_io *io, struct io_uring_cmd *cmd,
> +				 const struct ublksrv_io_cmd *ub_cmd,
> +				 struct request *req)

request argument can be removed by getting it inside this function directly,
and it is helpful to switch to retrieve & store it from 'ublk_io' later.

Otherwise, looks nice cleanup.


thanks,
Ming


