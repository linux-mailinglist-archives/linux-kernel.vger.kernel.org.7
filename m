Return-Path: <linux-kernel+bounces-612498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1462EA94FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7AA3B3AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA3F262803;
	Mon, 21 Apr 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbC8LPZs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CF26139A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233128; cv=none; b=sainDV1EYInXZYaWIIbMxHhuaaWLb0wMe/PBPLxX0DgnrMAgCiq4W+bArHiIAmLjJZyvSSNfCvVBXztzdDDSFSh6uVO4GiLbznEjOkxFQHaO6/GADyDkEXDcZPtt6PrWy1FPo2CI082LikVlcC6H41tK+gBPLvCbiN7KerwByJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233128; c=relaxed/simple;
	bh=+OLaudvKCaZTfYCCqJqXytXG8sGH0hFm+3/6AndZdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPZg0RP6ZdakZUqIlzdmdTufHEr5SL8Q/VLx80k8HeDwhPRc0NKn/mmjcqEZNIUltNF0keTMLmav4j9OJMOIZ+KxPSFoahYjlk9R/tZCuYcSjLq8jsU9rFjn2OmevOpvHDEUUh5wmspLSxtbVS4jdkpVc7HEZf0nvF+AG/M1pqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbC8LPZs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745233124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plUm0aw3iqc7OZ+CZO/kAMwVPrqauabgqNB8l2inmKM=;
	b=JbC8LPZslYAc9BDj1rOKc+Fj8tjUFApNa7o4QDMl0zaFL7Mw9WUXbgI8u3XmchaotfNewi
	QPhwOMfxqFSmLQWLDgqRpYQxWXm14C/Nzb5q/aB6I3qRvRPsJU7BowQ7WG4Tbj9F7BYZjY
	PIcEaB9kCjNDIY+kDQ5VIEvMuERZFNI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-WPS54lJfMmehN8ghE-B_7A-1; Mon, 21 Apr 2025 06:58:43 -0400
X-MC-Unique: WPS54lJfMmehN8ghE-B_7A-1
X-Mimecast-MFC-AGG-ID: WPS54lJfMmehN8ghE-B_7A_1745233123
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-85c8a0d07f2so5156644241.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 03:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233123; x=1745837923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plUm0aw3iqc7OZ+CZO/kAMwVPrqauabgqNB8l2inmKM=;
        b=Txi3za6lCxyHrU/jeRpmMYKYbq+BEh6CG0FqcJ4TchisC4mEvRffvDqEXdqxWg/CYf
         LBEX+J5dbIAXIyr1oLAgyj3LDIiIxWKMdMp44QCr0qsk7iVLdQLxStszpSViXApkaqa2
         EXdy856Ghkve+A5cPiz7b72+DyfgKImFVtQSv9VpYYgZBqtbdp3EL8IxbVwNktfVJZJF
         k1qf9qibn7afKNfA5OFRIwh9tE27JP7i0xjYBPb6E6l0tIjNLFhO5TxxucocHj9YMdA0
         aanBAE/fi4iQ/NyVlDM0LqO8edu1EJarTCNlbDSeSRVqCzyANpoDAzDFcolY/Ml61Qdl
         MXYg==
X-Forwarded-Encrypted: i=1; AJvYcCUNMznDlRLUffpSQcEqTv9TtNl8Gd3N+9ShWFnKZYD3g3nVDkD7FpPYPkRQgIR6sWccZUcQk9c7ucq1xeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7gyK2g1hsiVbYZpmc5x30PCmApuXvCHx0afJyxohkuYYqSjW
	DqYsfbxB4uUNgbJyPRjPoB+QJ2pQIHxTtLXc/JinCnd+N4Pedfb81ys0GEJx0L3Fn9IeozgI/qt
	p9jcLfUIjleSXS9IMAdwj/0m+QS4PRKFvwIHFGSt3jFio1YX7n+p12YD0MgrCKQ==
X-Gm-Gg: ASbGnctKiF+/+Ns+y0f5F9k+j7fqYOXjNPwaLGs5AHAn0DVFpfJa6YghkVQL+gPUw/E
	oqoM+AnuDEgF0o7I25rLbjbGmaEza4SqQdsjv3Z6VUKsHfzWOWZldh2o9/XG9WL1ciCkKXLnItW
	KEEy09LYiBJ2MW7baXRZJdXiv7W8pFrYc9kuwsDLz0e4ctDpETlrSYF2Tuc5bqHfUav5Se/vpsx
	F/2tILleYBJu2WVircUdzpyrRjNJTf+sCVkc6tYkwrmiQuHL3yToOhUOoFlg6KFqNnqA0n3f4Dg
	HQ==
X-Received: by 2002:a05:6102:36cc:b0:4bb:e1c9:80b4 with SMTP id ada2fe7eead31-4cb7fefdba9mr5862744137.0.1745233122855;
        Mon, 21 Apr 2025 03:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMDwQ7uBvdA2v84VOyUbJ1BZFidOKJ7wtP7A1u4Jk/b7ChRbwfKpOV2JN9gU+dLj2Yh9kfKg==
X-Received: by 2002:a05:6102:36cc:b0:4bb:e1c9:80b4 with SMTP id ada2fe7eead31-4cb7fefdba9mr5862735137.0.1745233122382;
        Mon, 21 Apr 2025 03:58:42 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dd84911sm1602196137.4.2025.04.21.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:58:41 -0700 (PDT)
Date: Mon, 21 Apr 2025 06:58:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/4] vhost: Reintroduce kthread mode support in vhost
Message-ID: <20250421065549-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421024457.112163-3-lulu@redhat.com>

On Mon, Apr 21, 2025 at 10:44:08AM +0800, Cindy Lu wrote:
> This patch reintroduces kthread mode support in vhost,
> It also introduces struct vhost_worker_ops to abstract
> worker create/stop/wakeup operations.
> 
> * Bring back the original vhost_worker() implementation,
>   and renamed to vhost_run_work_kthread_list().
> 
> * Add cgroup support for the kthread
> 
> * Introduce struct vhost_worker_ops:
>   - Encapsulates create / stop / wake‑up callbacks.
>   - vhost_worker_create() selects the proper ops according to
>     inherit_owner.
> 
> This partially reverts or improves upon:
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 188 ++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  12 +++
>  2 files changed, 182 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 250dc43f1786..be97028a8baf 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> +#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -242,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &worker->work_list);
> -		vhost_task_wake(worker->vtsk);
> +		worker->ops->wakeup(worker);
>  	}
>  }
>  
> @@ -388,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  	__vhost_vq_meta_reset(vq);
>  }
>  
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +	struct vhost_worker *worker = data;
> +	struct vhost_work *work, *work_next;
> +	struct vhost_dev *dev = worker->dev;
> +	struct llist_node *node;
> +
> +	kthread_use_mm(dev->mm);
> +
> +	for (;;) {
> +		/* mb paired w/ kthread_stop */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (kthread_should_stop()) {
> +			__set_current_state(TASK_RUNNING);
> +			break;
> +		}
> +		node = llist_del_all(&worker->work_list);
> +		if (!node)
> +			schedule();
> +
> +		node = llist_reverse_order(node);
> +		/* make sure flag is seen after deletion */
> +		smp_wmb();
> +		llist_for_each_entry_safe(work, work_next, node, node) {
> +			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +			__set_current_state(TASK_RUNNING);
> +			kcov_remote_start_common(worker->kcov_handle);
> +			work->fn(work);
> +			kcov_remote_stop();
> +			cond_resched();
> +		}
> +	}
> +	kthread_unuse_mm(dev->mm);
> +
> +	return 0;
> +}
> +
>  static bool vhost_run_work_list(void *data)
>  {
>  	struct vhost_worker *worker = data;
> @@ -582,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>  
> +struct vhost_attach_cgroups_struct {
> +	struct vhost_work work;
> +	struct task_struct *owner;
> +	int ret;
> +};
> +
> +static void vhost_attach_cgroups_work(struct vhost_work *work)
> +{
> +	struct vhost_attach_cgroups_struct *s;
> +
> +	s = container_of(work, struct vhost_attach_cgroups_struct, work);
> +	s->ret = cgroup_attach_task_all(s->owner, current);
> +}
> +
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
> +	struct vhost_attach_cgroups_struct attach;
> +	int saved_cnt;
> +
> +	attach.owner = current;
> +
> +	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> +	vhost_worker_queue(worker, &attach.work);
> +
> +	mutex_lock(&worker->mutex);
> +
> +	/*
> +	 * Bypass attachment_cnt check in __vhost_worker_flush:
> +	 * Temporarily change it to INT_MAX to bypass the check
> +	 */
> +	saved_cnt = worker->attachment_cnt;
> +	worker->attachment_cnt = INT_MAX;
> +	__vhost_worker_flush(worker);
> +	worker->attachment_cnt = saved_cnt;


You mean this one?
        if (!worker->attachment_cnt || worker->killed)
                return;


Just introduce a variant of __vhost_worker_flush that
skips this check.

E.g.

Rename __vhost_worker_flush -> _vhost_worker_flush.

then rework:

static void _vhost_worker_flush(struct vhost_worker *worker)
{
        struct vhost_flush_struct flush; 
                                  
        if (!worker->attachment_cnt || worker->killed)
                return;

	__vhost_worker_flush(worker);
}





> +
> +	mutex_unlock(&worker->mutex);
> +
> +	return attach.ret;
> +}
> +
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> @@ -627,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
>  
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	xa_erase(&dev->worker_xa, worker->id);
> -	vhost_task_stop(worker->vtsk);
> +	worker->ops->stop(worker);
>  	kfree(worker);
>  }
>  
> @@ -650,42 +729,115 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  	xa_destroy(&dev->worker_xa);
>  }
>  
> +static void vhost_task_wakeup(struct vhost_worker *worker)
> +{
> +	return vhost_task_wake(worker->vtsk);
> +}
> +
> +static void vhost_kthread_wakeup(struct vhost_worker *worker)
> +{
> +	wake_up_process(worker->kthread_task);
> +}
> +
> +static void vhost_task_do_stop(struct vhost_worker *worker)
> +{
> +	return vhost_task_stop(worker->vtsk);
> +}
> +
> +static void vhost_kthread_do_stop(struct vhost_worker *worker)
> +{
> +	kthread_stop(worker->kthread_task);
> +}
> +
> +static int vhost_task_worker_create(struct vhost_worker *worker,
> +				    struct vhost_dev *dev, const char *name)
> +{
> +	struct vhost_task *vtsk;
> +	u32 id;
> +	int ret;
> +
> +	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> +				 worker, name);
> +	if (IS_ERR(vtsk))
> +		return PTR_ERR(vtsk);
> +
> +	worker->vtsk = vtsk;
> +	vhost_task_start(vtsk);
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0) {
> +		vhost_task_do_stop(worker);
> +		return ret;
> +	}
> +	worker->id = id;
> +	return 0;
> +}
> +
> +static int vhost_kthread_worker_create(struct vhost_worker *worker,
> +				       struct vhost_dev *dev, const char *name)
> +{
> +	struct task_struct *task;
> +	u32 id;
> +	int ret;
> +
> +	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
> +	if (IS_ERR(task))
> +		return PTR_ERR(task);
> +
> +	worker->kthread_task = task;
> +	wake_up_process(task);
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0)
> +		goto stop_worker;
> +
> +	ret = vhost_attach_task_to_cgroups(worker);
> +	if (ret)
> +		goto stop_worker;
> +
> +	worker->id = id;
> +	return 0;
> +
> +stop_worker:
> +	vhost_kthread_do_stop(worker);
> +	return ret;
> +}
> +
> +static const struct vhost_worker_ops kthread_ops = {
> +	.create = vhost_kthread_worker_create,
> +	.stop = vhost_kthread_do_stop,
> +	.wakeup = vhost_kthread_wakeup,
> +};
> +
> +static const struct vhost_worker_ops vhost_task_ops = {
> +	.create = vhost_task_worker_create,
> +	.stop = vhost_task_do_stop,
> +	.wakeup = vhost_task_wakeup,
> +};
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> -	struct vhost_task *vtsk;
>  	char name[TASK_COMM_LEN];
>  	int ret;
> -	u32 id;
> +	const struct vhost_worker_ops *ops =
> +		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>  	if (!worker)
>  		return NULL;
>  
>  	worker->dev = dev;
> +	worker->ops = ops;
>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>  
> -	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> -				 worker, name);
> -	if (IS_ERR(vtsk))
> -		goto free_worker;
> -
>  	mutex_init(&worker->mutex);
>  	init_llist_head(&worker->work_list);
>  	worker->kcov_handle = kcov_common_handle();
> -	worker->vtsk = vtsk;
> -
> -	vhost_task_start(vtsk);
> -
> -	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	ret = ops->create(worker, dev, name);
>  	if (ret < 0)
> -		goto stop_worker;
> -	worker->id = id;
> +		goto free_worker;
>  
>  	return worker;
>  
> -stop_worker:
> -	vhost_task_stop(vtsk);
>  free_worker:
>  	kfree(worker);
>  	return NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 19bb94922a0e..af4b2f7d3b91 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -26,7 +26,18 @@ struct vhost_work {
>  	unsigned long		flags;
>  };
>  
> +struct vhost_worker;
> +struct vhost_dev;
> +
> +struct vhost_worker_ops {
> +	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
> +		      const char *name);
> +	void (*stop)(struct vhost_worker *worker);
> +	void (*wakeup)(struct vhost_worker *worker);
> +};
> +
>  struct vhost_worker {
> +	struct task_struct *kthread_task;
>  	struct vhost_task	*vtsk;
>  	struct vhost_dev	*dev;
>  	/* Used to serialize device wide flushing with worker swapping. */
> @@ -36,6 +47,7 @@ struct vhost_worker {
>  	u32			id;
>  	int			attachment_cnt;
>  	bool			killed;
> +	const struct vhost_worker_ops *ops;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> -- 
> 2.45.0


