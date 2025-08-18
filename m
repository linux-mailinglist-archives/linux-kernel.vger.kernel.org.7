Return-Path: <linux-kernel+bounces-772719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A009AB296C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0982201B12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D024468D;
	Mon, 18 Aug 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpCBvhnm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA324469E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483132; cv=none; b=koDikBaWzezi57WtyWhCXHY5/OL4fcwi9CJ3IVSPci4ZBfDe+/MNKIYzKSFzK4XcqQpjC3rOxRajtd0ABEP1RyzRtZBY+BP1myxVvN6UnDSBUMF85mgU89r4NUFkv6HnFQymEXBiJVOWKqNUKCGaQheBVeGnsY8KgUlEmBb6m58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483132; c=relaxed/simple;
	bh=g6EpkcvxwypuvcqaVvQ/jri2Ix8bJ+hfN3ReO4gMVLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/ALZud+Idi4RP/a5RIWGmR+PPTOCv83d6STP0xyE0CdzedgBs50ottk7FBKy3cyvWHgnmN6Z7WoVOeOfRad4GSTVnMyQI3ZdYC5eLhs0RkB9ugVBRAx1LygHp63t2n3YQ+kDZygORkxuEOB35ngRrm/nhOLoYQJFevW3ih7rLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpCBvhnm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755483128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alDJHar97uTUIzscnGEjDMX65jecx5QK/CNwmeLCaa8=;
	b=OpCBvhnmq/xzN31s6IlvAG6wvKzs4F6icKQg6tlwtkVs05KLc4kxKrTusctcv6/nY10Pxk
	nV/xBhwAc9aq/pXwtMFTL9WX2z/MWVXwDh0EX36NLM/0HeTQqvlHvz1QI1QvAjqdsnw4Eg
	GIqrOBb9u2Zn3iVPZu1+spsotdr/6Ak=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-ugGD62AZNcSuHSawhgPOYg-1; Sun,
 17 Aug 2025 22:12:05 -0400
X-MC-Unique: ugGD62AZNcSuHSawhgPOYg-1
X-Mimecast-MFC-AGG-ID: ugGD62AZNcSuHSawhgPOYg_1755483123
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF4CE18003FD;
	Mon, 18 Aug 2025 02:12:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.112])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8858630001A5;
	Mon, 18 Aug 2025 02:11:55 +0000 (UTC)
Date: Mon, 18 Aug 2025 10:11:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: =?utf-8?B?5L2Z5b+r?= <yukuai1994@gmail.com>
Cc: Yu Kuai <yukuai@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>,
	Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aKKL5nL4gf2bnXUd@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com>
 <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
 <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org>
 <aKADe9hNz99dQTfy@fedora>
 <CAHW3DrjPEHX=XmPCQDBLJoXmnjz3GKsht33o-S6tH-tNb-_WQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHW3DrjPEHX=XmPCQDBLJoXmnjz3GKsht33o-S6tH-tNb-_WQQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Aug 16, 2025 at 04:05:30PM +0800, 余快 wrote:
> Hi,
> 
> Ming Lei <ming.lei@redhat.com> 于2025年8月16日周六 12:05写道：
> >
> > On Sat, Aug 16, 2025 at 10:57:23AM +0800, Yu Kuai wrote:
> > > Hi,
> > >
> > > 在 2025/8/16 3:30, Nilay Shroff 写道:
> > > >
> > > > On 8/15/25 1:32 PM, Yu Kuai wrote:
> > > > > From: Yu Kuai <yukuai3@huawei.com>
> > > > >
> > > > > In the case user trigger tags grow by queue sysfs attribute nr_requests,
> > > > > hctx->sched_tags will be freed directly and replaced with a new
> > > > > allocated tags, see blk_mq_tag_update_depth().
> > > > >
> > > > > The problem is that hctx->sched_tags is from elevator->et->tags, while
> > > > > et->tags is still the freed tags, hence later elevator exist will try to
> > > > > free the tags again, causing kernel panic.
> > > > >
> > > > > Fix this problem by using new allocated elevator_tags, also convert
> > > > > blk_mq_update_nr_requests to void since this helper will never fail now.
> > > > >
> > > > > Meanwhile, there is a longterm problem can be fixed as well:
> > > > >
> > > > > If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
> > > > > is updated, however, if following hctx failed, q->nr_requests is not
> > > > > updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
> > > > >
> > > > > Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> > > > > Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> > > > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > > > ---
> > > > >   block/blk-mq.c    | 19 ++++++-------------
> > > > >   block/blk-mq.h    |  4 +++-
> > > > >   block/blk-sysfs.c | 21 ++++++++++++++-------
> > > > >   3 files changed, 23 insertions(+), 21 deletions(-)
> > > > >
> > > > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > > > index 11c8baebb9a0..e9f037a25fe3 100644
> > > > > --- a/block/blk-mq.c
> > > > > +++ b/block/blk-mq.c
> > > > > @@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
> > > > >   }
> > > > >   EXPORT_SYMBOL(blk_mq_free_tag_set);
> > > > > -int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> > > > > +void blk_mq_update_nr_requests(struct request_queue *q,
> > > > > +                        struct elevator_tags *et, unsigned int nr)
> > > > >   {
> > > > >           struct blk_mq_tag_set *set = q->tag_set;
> > > > >           struct blk_mq_hw_ctx *hctx;
> > > > >           unsigned long i;
> > > > > - int ret = 0;
> > > > >           blk_mq_quiesce_queue(q);
> > > > > @@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> > > > >                                   nr - hctx->sched_tags->nr_reserved_tags);
> > > > >                   }
> > > > >           } else {
> > > > > -         queue_for_each_hw_ctx(q, hctx, i) {
> > > > > -                 if (!hctx->tags)
> > > > > -                         continue;
> > > > > -                 ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> > > > > -                                               nr);
> > > > > -                 if (ret)
> > > > > -                         goto out;
> > > > > -         }
> > > > > +         blk_mq_free_sched_tags(q->elevator->et, set);
> > > > I think you also need to ensure that elevator tags are freed after we unfreeze
> > > > queue and release ->elevator_lock otherwise we may get into the lockdep splat
> > > > for pcpu_lock dependency on ->freeze_lock and/or ->elevator_lock. Please note
> > > > that blk_mq_free_sched_tags internally invokes sbitmap_free which invokes
> > > > free_percpu which acquires pcpu_lock.
> > >
> > > Ok, thanks for the notice. However, as Ming suggested, we might fix this
> > > problem
> > >
> > > in the next merge window.
> >
> > There are two issues involved:
> >
> > - blk_mq_tags double free, introduced recently
> >
> > - long-term lock issue in queue_requests_store()
> >
> > IMO, the former is a bit serious, because kernel panic can be triggered,
> > so suggest to make it to v6.17. The latter looks less serious and has
> > existed for long time, but may need code refactor to get clean fix.
> >
> > > I'll send one patch to fix this regression by
> > > replace
> > >
> > > st->tags with reallocated new sched_tags as well.
> >
> > Patch 7 in this patchset and patch 8 in your 1st post looks enough to
> > fix this double free issue.
> >
> But without previous refactor, this looks hard. Can we consider the following

I feel the following one should be enough:


diff --git a/block/blk-mq.c b/block/blk-mq.c
index b67d6c02eceb..021155bb64fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4917,6 +4917,29 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
+static int blk_mq_sched_grow_tags(struct request_queue *q, unsigned int nr)
+{
+	struct blk_mq_hw_ctx *hctx;
+	struct elevator_tags *et;
+	unsigned long i;
+
+	if (nr > MAX_SCHED_RQ)
+		return -EINVAL;
+
+	et = blk_mq_alloc_sched_tags(q->tag_set, q->nr_hw_queues, nr);
+	if (!et)
+		return -ENOMEM;
+
+	blk_mq_free_sched_tags(q->elevator->et, q->tag_set);
+	queue_for_each_hw_ctx(q, hctx, i) {
+		hctx->sched_tags = et->tags[i];
+		if (q->elevator->type->ops.depth_updated)
+			q->elevator->type->ops.depth_updated(hctx);
+	}
+	q->elevator->et = et;
+	return 0;
+}
+
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -4936,6 +4959,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	blk_mq_quiesce_queue(q);
 
 	ret = 0;
+
+	if (q->elevator && nr > q->elevator->et->nr_requests) {
+		ret = blk_mq_sched_grow_tags(q, nr);
+		goto update_nr_requests;
+	}
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->tags)
 			continue;
@@ -4955,6 +4984,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		if (q->elevator && q->elevator->type->ops.depth_updated)
 			q->elevator->type->ops.depth_updated(hctx);
 	}
+update_nr_requests:
 	if (!ret) {
 		q->nr_requests = nr;
 		if (blk_mq_is_shared_tags(set->flags)) {

> one line patch for this merge window? just fix the first double free
> issue for now.
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d880c50629d6..1e0ccf19295a 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -622,6 +622,7 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>                         return -ENOMEM;
> 
>                 blk_mq_free_map_and_rqs(set, *tagsptr, hctx->queue_num);
> +               hctx->queue->elevator->et->tags[hctx->queue_num]= new;
>                 *tagsptr = new;

It is fine if this way can work, however old elevator->et may has lower
depth, then:

- the above change cause et->tags overflow

- meantime memory leak is caused in blk_mq_free_sched_tags()


Thanks,
Ming


