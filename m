Return-Path: <linux-kernel+bounces-838470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679CEBAF3CC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102852A124A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334DC24468A;
	Wed,  1 Oct 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgLmBvl3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C564AC148
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759300299; cv=none; b=l5cFgm3OKnuyxce4dTQ6CCrl5U0d9gu49NeVpG6VMmi6YcahDzEidjtHmZt5an7h8Rq8soIMtREEVpZh0kuSHNyjR7K5T/JhxbZ25jtJfkltpYBfKBbWkkrRImJZ060qc095hM2LFJjRMk0MWO1+c96vvNdomeHKLwDGkJBcKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759300299; c=relaxed/simple;
	bh=IEVlakWTGv+PJAnS8rZYIPFCiZchAVp3Y2kyqtWbXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm5drMHpXiV0jV3JZnCXX4EGqHk7ZPx8bSDOHi1nuxooG6OEwZa835Lz8W1HbN3d4RroCBDb89GJy64yX1cg1yknKsDFTSusHEkgBIVWyXZHGYZxbbZLo6nZJqnDgoJQ1JkZvCkd9KgDxl8I13sfINpKW9tBiYVEz/h6S0W52Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgLmBvl3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759300296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rz+qqYLXcweI5rmzquO5nvJ1eJ440qoev3IK/G1Kv8=;
	b=LgLmBvl3xbDEyf3xCewGyD5gevPmy1UJPxYbYW6DJAbsb/GymhDcVMxgAWFHrjz26ZF+hz
	B26YGZR5jIaQQ/XA2xdrxquLsD2l0yMo1BecchUFnNwyd9uekZ6Khm3NOLtShMBREPvHeK
	GP2NstljnpReMf28aghUu56BpMM06oc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-7MSqDb0XPg-2g8oUUsPvWQ-1; Wed,
 01 Oct 2025 02:31:35 -0400
X-MC-Unique: 7MSqDb0XPg-2g8oUUsPvWQ-1
X-Mimecast-MFC-AGG-ID: 7MSqDb0XPg-2g8oUUsPvWQ_1759300293
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F822195609F;
	Wed,  1 Oct 2025 06:31:32 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.44.32.240])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E02CB19560B4;
	Wed,  1 Oct 2025 06:31:27 +0000 (UTC)
Date: Tue, 30 Sep 2025 23:31:26 -0700
From: Chris Leech <cleech@redhat.com>
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux@yadro.com, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix usage of page_frag_cache
Message-ID: <20250930-feminine-dry-42d2705c778a@redhat.com>
References: <20250929111951.6961-1-d.bogdanov@yadro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929111951.6961-1-d.bogdanov@yadro.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Sep 29, 2025 at 02:19:51PM +0300, Dmitry Bogdanov wrote:
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> 	tcp_sendmsg_locked+0x782/0xce0
> 	tcp_sendmsg+0x27/0x40
> 	sock_sendmsg+0x8b/0xa0
> 	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by serializing the usage of page_frag_cache.

Thank you for reporting this. I think we can fix it without blocking the
async namespace scanning with a mutex, by switching from a per-queue
page_frag_cache to per-cpu. There shouldn't be a need to keep the
page_frag allocations isolated by queue anyway.

It would be great if you could test the patch which I'll send after
this.

- Chris
 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>  drivers/nvme/host/tcp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1413788ca7d52..823e07759e0d3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -145,6 +145,7 @@ struct nvme_tcp_queue {
>  
>  	struct mutex		queue_lock;
>  	struct mutex		send_mutex;
> +	struct mutex		pf_cache_lock;
>  	struct llist_head	req_list;
>  	struct list_head	send_list;
>  
> @@ -556,9 +557,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>  	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  
> +	mutex_lock(&queue->pf_cache_lock);
>  	req->pdu = page_frag_alloc(&queue->pf_cache,
>  		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>  		GFP_KERNEL | __GFP_ZERO);
> +	mutex_unlock(&queue->pf_cache_lock);
>  	if (!req->pdu)
>  		return -ENOMEM;
>  
> @@ -1420,9 +1423,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
>  	struct nvme_tcp_request *async = &ctrl->async_req;
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  
> +	mutex_lock(&queue->pf_cache_lock);
>  	async->pdu = page_frag_alloc(&queue->pf_cache,
>  		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
>  		GFP_KERNEL | __GFP_ZERO);
> +	mutex_unlock(&queue->pf_cache_lock);
>  	if (!async->pdu)
>  		return -ENOMEM;
>  
> @@ -1450,6 +1455,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>  	kfree(queue->pdu);
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +	mutex_destroy(&queue->pf_cache_lock);
>  }
>  
>  static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
> @@ -1772,6 +1778,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  	INIT_LIST_HEAD(&queue->send_list);
>  	mutex_init(&queue->send_mutex);
>  	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
> +	mutex_init(&queue->pf_cache_lock);
>  
>  	if (qid > 0)
>  		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
> @@ -1903,6 +1910,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>  err_destroy_mutex:
>  	mutex_destroy(&queue->send_mutex);
>  	mutex_destroy(&queue->queue_lock);
> +	mutex_destroy(&queue->pf_cache_lock);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 
> 


