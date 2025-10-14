Return-Path: <linux-kernel+bounces-852157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D57BD84EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE3133516DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F52DF6F4;
	Tue, 14 Oct 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So9vMaF3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC652E2DD2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432136; cv=none; b=nNoQAEPRxL6OzOoMDRisoe61Y6h2j4rCbbChOpMIJxJ8kO5lOLqa96AwGGo7J9K0euCxGdPyE2VcTBhzMIspgY0xNcm0cBHeYS/K6ouUhQdZRabTzhuCNsZeTil8pXvWNnT7atHumGOizxghCElFMxtG6ATB340G0hq7LWzIbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432136; c=relaxed/simple;
	bh=MMxriXDc8vMgRKXTLY/BEuuQfCNgW7+ZkriAu8GtKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeeRBK12hoNwosSZChKrEb3Cbg5oKkoX6KNjMzqGjNoaiOC4W+NACKY/ECtdpoSBDrRHdq35WynE35wq5yF+0dSONM5ijWiS23hFyNALacem0ga3MOwOa1qSyRZBRH/1hiBDpalGB9brsVaQSfg7N12+p0tW++kgbdF/rcH7hJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=So9vMaF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwa8bTOFJEQ9KZgmpDkfmjTWpRXkCxQQorAAM5/0DZQ=;
	b=So9vMaF3rwnzOylO9cAIWkAgINcUPTjlmtBDSy01rS+LQlMs5FzPXYjYYj8vUe3W9zIETR
	hsH4dZb8maBnrlsMDlp1KOXQMlcOje5Y3VXRxvSduamhhimBKnL283Z3EldIRrGUYWxI2V
	+LNWeimnLbojU0CpNxhdD1LxIII0ttM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-sYHeLI-bNr-jlEvJtrohWQ-1; Tue,
 14 Oct 2025 04:55:26 -0400
X-MC-Unique: sYHeLI-bNr-jlEvJtrohWQ-1
X-Mimecast-MFC-AGG-ID: sYHeLI-bNr-jlEvJtrohWQ_1760432124
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61E4D19560A1;
	Tue, 14 Oct 2025 08:55:24 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A49130002D0;
	Tue, 14 Oct 2025 08:55:15 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:55:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 3/4] blk-rq-qos: fix possible deadlock
Message-ID: <aO4P08Sw2YYjOYtu@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-4-yukuai3@huawei.com>
 <aO4GPKKpLbj7kMoz@fedora>
 <f0ab9c95-990b-a41d-477e-c1b20b392985@huaweicloud.com>
 <aO4L2THnLFM-_Fb8@fedora>
 <0351f07e-4ac4-a1e2-b4ee-08e49e7d0b6e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0351f07e-4ac4-a1e2-b4ee-08e49e7d0b6e@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Oct 14, 2025 at 04:42:30PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 16:37, Ming Lei 写道:
> > On Tue, Oct 14, 2025 at 04:24:23PM +0800, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/10/14 16:13, Ming Lei 写道:
> > > > On Tue, Oct 14, 2025 at 10:21:48AM +0800, Yu Kuai wrote:
> > > > > Currently rq-qos debugfs entries is created from rq_qos_add(), while
> > > > > rq_qos_add() requires queue to be freezed. This can deadlock because
> > > > > creating new entries can trigger fs reclaim.
> > > > > 
> > > > > Fix this problem by delaying creating rq-qos debugfs entries until
> > > > > it's initialization is complete.
> > > > > 
> > > > > - For wbt, it can be initialized by default of by blk-sysfs, fix it by
> > > > >     calling blk_mq_debugfs_register_rq_qos() after wbt_init;
> > > > > - For other policies, they can only be initialized by blkg configuration,
> > > > >     fix it by calling blk_mq_debugfs_register_rq_qos() from
> > > > >     blkg_conf_end();
> > > > > 
> > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > > ---
> > > > >    block/blk-cgroup.c | 6 ++++++
> > > > >    block/blk-rq-qos.c | 7 -------
> > > > >    block/blk-sysfs.c  | 4 ++++
> > > > >    block/blk-wbt.c    | 7 ++++++-
> > > > >    4 files changed, 16 insertions(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> > > > > index d93654334854..e4ccabf132c0 100644
> > > > > --- a/block/blk-cgroup.c
> > > > > +++ b/block/blk-cgroup.c
> > > > > @@ -33,6 +33,7 @@
> > > > >    #include "blk-cgroup.h"
> > > > >    #include "blk-ioprio.h"
> > > > >    #include "blk-throttle.h"
> > > > > +#include "blk-mq-debugfs.h"
> > > > >    static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu);
> > > > > @@ -746,6 +747,11 @@ void blkg_conf_end(struct blkg_conf_ctx *ctx)
> > > > >    	mutex_unlock(&q->elevator_lock);
> > > > >    	blk_mq_unfreeze_queue(q, ctx->memflags);
> > > > >    	blkdev_put_no_open(ctx->bdev);
> > > > > +
> > > > > +	mutex_lock(&q->debugfs_mutex);
> > > > > +	blk_mq_debugfs_register_rq_qos(q);
> > > > > +	mutex_unlock(&q->debugfs_mutex);
> > > > > +
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(blkg_conf_end);
> > > > > diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> > > > > index 654478dfbc20..d7ce99ce2e80 100644
> > > > > --- a/block/blk-rq-qos.c
> > > > > +++ b/block/blk-rq-qos.c
> > > > > @@ -347,13 +347,6 @@ int rq_qos_add(struct rq_qos *rqos, struct gendisk *disk, enum rq_qos_id id,
> > > > >    	blk_queue_flag_set(QUEUE_FLAG_QOS_ENABLED, q);
> > > > >    	blk_mq_unfreeze_queue(q, memflags);
> > > > > -
> > > > > -	if (rqos->ops->debugfs_attrs) {
> > > > > -		mutex_lock(&q->debugfs_mutex);
> > > > > -		blk_mq_debugfs_register_rqos(rqos);
> > > > > -		mutex_unlock(&q->debugfs_mutex);
> > > > > -	}
> > > > > -
> > > > >    	return 0;
> > > > >    ebusy:
> > > > >    	blk_mq_unfreeze_queue(q, memflags);
> > > > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > > > index 76c47fe9b8d6..52bb4db25cf5 100644
> > > > > --- a/block/blk-sysfs.c
> > > > > +++ b/block/blk-sysfs.c
> > > > > @@ -688,6 +688,10 @@ static ssize_t queue_wb_lat_store(struct gendisk *disk, const char *page,
> > > > >    	mutex_unlock(&disk->rqos_state_mutex);
> > > > >    	blk_mq_unquiesce_queue(q);
> > > > > +
> > > > > +	mutex_lock(&q->debugfs_mutex);
> > > > > +	blk_mq_debugfs_register_rq_qos(q);
> > > > > +	mutex_unlock(&q->debugfs_mutex);
> > > > >    out:
> > > > >    	blk_mq_unfreeze_queue(q, memflags);
> > > > > diff --git a/block/blk-wbt.c b/block/blk-wbt.c
> > > > > index eb8037bae0bd..a120b5ba54db 100644
> > > > > --- a/block/blk-wbt.c
> > > > > +++ b/block/blk-wbt.c
> > > > > @@ -724,8 +724,13 @@ void wbt_enable_default(struct gendisk *disk)
> > > > >    	if (!blk_queue_registered(q))
> > > > >    		return;
> > > > > -	if (queue_is_mq(q) && enable)
> > > > > +	if (queue_is_mq(q) && enable) {
> > > > >    		wbt_init(disk);
> > > > > +
> > > > > +		mutex_lock(&q->debugfs_mutex);
> > > > > +		blk_mq_debugfs_register_rq_qos(q);
> > > > > +		mutex_unlock(&q->debugfs_mutex);
> > > > > +	}
> > > > 
> > > > ->debugfs_mutex only may be not enough, because blk_mq_debugfs_register_rq_qos()
> > > > has to traverse rq_qos single list list, you may have to grab q->rq_qos_mutex
> > > > for protect the list.
> > > > 
> > > 
> > > I think we can't grab rq_qos_mutex to create debugfs entries, right?
> > 
> > It depends on the finalized order between rq_qos_mutex and freezing queue.
> > 
> > > With the respect of this, perhaps we can grab debugfs_mutex to protect
> > > insering rq_qos list instead?
> > 
> > No, debugfs_mutex shouldn't protect rq_qos list, and rq_qos_mutex is
> > supposed to do the job at least from naming viewpoint.
> 
> Ok, then we'll have to make sure the order is rq_qos_mutex before
> freezing queue, I was thinking the inverse order because of the helper
> blkg_conf_open_bdev_frozen().
> 
> I'll check first if this is possible.

You may misunderstand my point, I meant `debugfs_mutex` can't be used for
protecting rq_qos list because of its name. But order between rq_qos_mutex
and freeze queue might be fine in either way, just it has to be fixed.
Not look into it yet.

Thanks,
Ming


