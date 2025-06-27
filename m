Return-Path: <linux-kernel+bounces-706381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D2AEB5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 13:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1359C7B4677
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA75F1EF0BE;
	Fri, 27 Jun 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaLdDQQX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224F299AAB
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751022271; cv=none; b=YTtoQfY+O3css7tlznsO8ZpbNS/Q0s61RJalrazJ4Z4Zj/y67GQBrRDL9R9Ef52FBaD+WTELNCZB2xZfEJ2ciS6GvwqEgulHYNHqJzEO6zt2MFbVntQMtbqPhM5kVXWftjm6EPa6oYaViNbRTC60YhIG6YOElAXzbEBHotQwLdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751022271; c=relaxed/simple;
	bh=fjH0JhH6D7x/OD2TdOZ50ouYuHiuH5jEFF3eIdj3weA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMZN+TN0vY3Z8Hjk1UHZ9UQ6u4Qys63YExRaoKzyzF0lxgdEV4zznyntTZBAxyPs6mA+Lnj4N7i6M1YI1/6fplJRzlb7D3ZvKIw6YbBsHjUVJcCTldmpJb4gefuFL6wDjiZq2AM3psC2xCCh45VIp6tyPgpJ+myVXO1SFs0O/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QaLdDQQX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751022268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpNlNCAbYqrGZEBTx3NoAjbHoc60DnHuxuxn14zXNOc=;
	b=QaLdDQQXC+vfjbJeWlcqsUl8dTRMdHpYVdKLfvCttysV13dQ4r26LVJYZVi45i94vi51bg
	AfMOY+BcDaC/ubLnbdU+spQPpXs6VXW+40O0FrXTRSAcucRE4xjUgZBwdJpjYeFRjiFcZp
	zfnPSGBMNZP67ps+7wBSXqWR1zmqN7U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-NRJ_f5qoOhOeG1mpRRY4XA-1; Fri,
 27 Jun 2025 07:04:24 -0400
X-MC-Unique: NRJ_f5qoOhOeG1mpRRY4XA-1
X-Mimecast-MFC-AGG-ID: NRJ_f5qoOhOeG1mpRRY4XA_1751022263
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0DD618DA5C0;
	Fri, 27 Jun 2025 11:04:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.105])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 683E830001BC;
	Fri, 27 Jun 2025 11:04:10 +0000 (UTC)
Date: Fri, 27 Jun 2025 19:04:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
	nilay@linux.ibm.com, hare@suse.de, linux-block@vger.kernel.org,
	nbd@other.debian.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
Message-ID: <aF56oVEzTygIOUTN@fedora>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Jun 27, 2025 at 05:23:48PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> The deadlock is reported because there are circular dependency:
> 
> t1: disk->open_mutex -> nbd->config_lock
> 
>  blkdev_release
>   bdev_release
>    //lock disk->open_mutex)
>    blkdev_put_whole
>     nbd_release
>      nbd_config_put
>         refcount_dec_and_mutex_lock
>         //lock nbd->config_lock
> 
> t2: nbd->config_lock -> set->update_nr_hwq_lock
> 
>  nbd_genl_connect
>   //lock nbd->config_lock
>   nbd_start_device
>    blk_mq_update_nr_hw_queues
>    //lock set->update_nr_hwq_lock
> 
> t3: set->update_nr_hwq_lock -> disk->open_mutex
> 
>  nbd_dev_remove_work
>   nbd_dev_remove
>    del_gendisk
>     down_read(&set->update_nr_hwq_lock);
>     __del_gendisk
>     mutex_lock(&disk->open_mutex);
> 
> This is false warning because t1 and t2 should be synchronized by
> nbd->refs, and t1 is still holding the reference while t2 is triggered
> when the reference is decreased to 0. However the lock order is broken.
> 
> Fix the problem by breaking the dependency from t2, by calling
> blk_mq_update_nr_hw_queues() outside of nbd internal config_lock, since
> now other context can concurrent with nbd_start_device(), also make sure
> they will still return -EBUSY, the difference is that they will not wait
> for nbd_start_device() to be done.
> 
> Fixes: 98e68f67020c ("block: prevent adding/deleting disk during updating nr_hw_queues")
> Reported-by: syzbot+2bcecf3c38cb3e8fdc8d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6855034f.a00a0220.137b3.0031.GAE@google.com/
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 7bdc7eb808ea..d43e8e73aeb3 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1457,10 +1457,13 @@ static void nbd_config_put(struct nbd_device *nbd)
>  	}
>  }
>  
> -static int nbd_start_device(struct nbd_device *nbd)
> +static int nbd_start_device(struct nbd_device *nbd, bool netlink)
> +	__releases(&nbd->config_lock)
> +	__acquires(&nbd->config_lock)
>  {
>  	struct nbd_config *config = nbd->config;
>  	int num_connections = config->num_connections;
> +	struct task_struct *old;
>  	int error = 0, i;
>  
>  	if (nbd->pid)
> @@ -1473,8 +1476,21 @@ static int nbd_start_device(struct nbd_device *nbd)
>  		return -EINVAL;
>  	}
>  
> -	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
> +	/*
> +	 * synchronize with concurrent nbd_start_device() and
> +	 * nbd_add_socket()
> +	 */
>  	nbd->pid = task_pid_nr(current);
> +	if (!netlink) {
> +		old = nbd->task_setup;
> +		nbd->task_setup = current;
> +	}
> +
> +	mutex_unlock(&nbd->config_lock);
> +	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
> +	mutex_lock(&nbd->config_lock);
> +	if (!netlink)
> +		nbd->task_setup = old;

I guess the patch in the following link may be simper, both two take
similar approach:

https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/


thanks,
Ming


