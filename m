Return-Path: <linux-kernel+bounces-771700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BCB28A7C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1971D026AD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 04:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E05154BF5;
	Sat, 16 Aug 2025 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S51iCyCQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A81192D68
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755317140; cv=none; b=XXXLmqZ3smx4s7+rjfWU5OD30E7hUZ1ndBTmWdyHhI5ozNp2S07e7FLLyjKNL3zEE328RgHQSjlVddcuh5QrK4IMVcH9T/UnK4Ubewbd0iBTseKL6Jm3vLdpcepNukKDGyn+owow9wL1+BVz/ZudAd/b/yZ6ZPhyn76pNj/w938=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755317140; c=relaxed/simple;
	bh=9MraKFbbVF3ZG1giR43/4Qfnj03Tvr0GDhYuIA6QRrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mn+hGN7aF1yaQiyjXPI5yUIfG0hAKcmcH97mx/AGtotRiSu1v0j2CVEGd/7E/FmWEhMLICWGVi4J8zzdfDcI8N9gbHMJZGBwMniQWZymT+NB9ARdcCcb2i8ElIdmo70nHSu3vkolkEd5N0cj9lx1B32eGDEE1qGf2KISYU2vnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S51iCyCQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755317136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be/x7kdTxHZOOjJPiYl+QftUIbBdfgZWPH7ZWtutGaM=;
	b=S51iCyCQeeyvHKA0CWkK94MZWJWyi98mHwB6aYQOvQdtx3eRgU6MG+Al3aD2hnSEqDMZnK
	Q1cCKqoUJ6ZuJY1HhvYnPnnV74DUC3ErxrBukTvmHg8hdRP/m5mxoRDBurHGF+AXz27xtQ
	ImsId2g1dF9/4CCPjZzCOoAcExQKiZc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-Rt3GOwvDMkCOA0BzFAluyw-1; Sat,
 16 Aug 2025 00:05:30 -0400
X-MC-Unique: Rt3GOwvDMkCOA0BzFAluyw-1
X-Mimecast-MFC-AGG-ID: Rt3GOwvDMkCOA0BzFAluyw_1755317129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55B4A180047F;
	Sat, 16 Aug 2025 04:05:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A481180029C;
	Sat, 16 Aug 2025 04:05:20 +0000 (UTC)
Date: Sat, 16 Aug 2025 12:05:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>,
	axboe@kernel.dk, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 08/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aKADe9hNz99dQTfy@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-9-yukuai1@huaweicloud.com>
 <c5e63966-e7f6-4d82-9d66-3a0abccc9d17@linux.ibm.com>
 <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af40ef99-9b61-4725-ba77-c5d3741add99@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Aug 16, 2025 at 10:57:23AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/8/16 3:30, Nilay Shroff 写道:
> > 
> > On 8/15/25 1:32 PM, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > In the case user trigger tags grow by queue sysfs attribute nr_requests,
> > > hctx->sched_tags will be freed directly and replaced with a new
> > > allocated tags, see blk_mq_tag_update_depth().
> > > 
> > > The problem is that hctx->sched_tags is from elevator->et->tags, while
> > > et->tags is still the freed tags, hence later elevator exist will try to
> > > free the tags again, causing kernel panic.
> > > 
> > > Fix this problem by using new allocated elevator_tags, also convert
> > > blk_mq_update_nr_requests to void since this helper will never fail now.
> > > 
> > > Meanwhile, there is a longterm problem can be fixed as well:
> > > 
> > > If blk_mq_tag_update_depth() succeed for previous hctx, then bitmap depth
> > > is updated, however, if following hctx failed, q->nr_requests is not
> > > updated and the previous hctx->sched_tags endup bigger than q->nr_requests.
> > > 
> > > Fixes: f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
> > > Fixes: e3a2b3f931f5 ("blk-mq: allow changing of queue depth through sysfs")
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-mq.c    | 19 ++++++-------------
> > >   block/blk-mq.h    |  4 +++-
> > >   block/blk-sysfs.c | 21 ++++++++++++++-------
> > >   3 files changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 11c8baebb9a0..e9f037a25fe3 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -4917,12 +4917,12 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
> > >   }
> > >   EXPORT_SYMBOL(blk_mq_free_tag_set);
> > > -int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> > > +void blk_mq_update_nr_requests(struct request_queue *q,
> > > +			       struct elevator_tags *et, unsigned int nr)
> > >   {
> > >   	struct blk_mq_tag_set *set = q->tag_set;
> > >   	struct blk_mq_hw_ctx *hctx;
> > >   	unsigned long i;
> > > -	int ret = 0;
> > >   	blk_mq_quiesce_queue(q);
> > > @@ -4946,24 +4946,17 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> > >   				nr - hctx->sched_tags->nr_reserved_tags);
> > >   		}
> > >   	} else {
> > > -		queue_for_each_hw_ctx(q, hctx, i) {
> > > -			if (!hctx->tags)
> > > -				continue;
> > > -			ret = blk_mq_tag_update_depth(hctx, &hctx->sched_tags,
> > > -						      nr);
> > > -			if (ret)
> > > -				goto out;
> > > -		}
> > > +		blk_mq_free_sched_tags(q->elevator->et, set);
> > I think you also need to ensure that elevator tags are freed after we unfreeze
> > queue and release ->elevator_lock otherwise we may get into the lockdep splat
> > for pcpu_lock dependency on ->freeze_lock and/or ->elevator_lock. Please note
> > that blk_mq_free_sched_tags internally invokes sbitmap_free which invokes
> > free_percpu which acquires pcpu_lock.
> 
> Ok, thanks for the notice. However, as Ming suggested, we might fix this
> problem
> 
> in the next merge window.

There are two issues involved:

- blk_mq_tags double free, introduced recently

- long-term lock issue in queue_requests_store()

IMO, the former is a bit serious, because kernel panic can be triggered,
so suggest to make it to v6.17. The latter looks less serious and has
existed for long time, but may need code refactor to get clean fix.

> I'll send one patch to fix this regression by
> replace
> 
> st->tags with reallocated new sched_tags as well.

Patch 7 in this patchset and patch 8 in your 1st post looks enough to
fix this double free issue.


Thanks,
Ming


