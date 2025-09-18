Return-Path: <linux-kernel+bounces-770936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94269B280AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C0AE00DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9929301031;
	Fri, 15 Aug 2025 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3sTvj4L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE7433AD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755264984; cv=none; b=B7nH1GZ54mZh899Twi53HoPJPhafm9UmzUL1bAuF/FjIofl4+zbNv9xcSw2pffyGTvG2vANYcIWGkrB/oV95knnR2KhzaAsUnid/dqJuT5P5TwvG9L+Q1LOYUQ4GzqyDMQuwmUiF/PtedZhMs54TYGpx2/GIP6ViC9zKDDAkHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755264984; c=relaxed/simple;
	bh=e/MmYHmiptHc5g1Gj+UVkH3E6JVS4Rq2n51K0nbcYA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEn6c9tZWJCFBBqD0A6fPoKGzE7SoulF9xMutVoGTE0LWEsF4ExiCPsJA/abiw5azzg/5gF4ZyDUJkGqkb/7arLFCGr7o1kIqghxnoEG+b9sygwryfqFMmVZO5eKRn953Npiq9OtOGPIGF62Vxafj4DTKxBD62MweFhk1lBSrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3sTvj4L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755264981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pz5Sv77P8vdnGiinZMSyzN2Z8Duxxge99+zGb/FiXvI=;
	b=K3sTvj4LTg1fh3+Knz2s+x0MLniCHGPX0aQpg+AWS4cXZ/ileRIgb4d4m8Ma5ibT7i8rs/
	Z4+VSPViOak3rd1v+oi9GbJPrO4QbpA8MmEXsH7G0OnjvG7QIJYvNykaua9V6FKSr5Rggn
	fQ2F14PUZ/xcfNQjyhPqqcZ9T0lPWUA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-7Rvv3kpMPAy0quI9VBvc9w-1; Fri,
 15 Aug 2025 09:36:20 -0400
X-MC-Unique: 7Rvv3kpMPAy0quI9VBvc9w-1
X-Mimecast-MFC-AGG-ID: 7Rvv3kpMPAy0quI9VBvc9w_1755264977
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 984DB1955BD9;
	Fri, 15 Aug 2025 13:36:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67EB019327C0;
	Fri, 15 Aug 2025 13:36:05 +0000 (UTC)
Date: Fri, 15 Aug 2025 21:35:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, bvanassche@acm.org,
	hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 03/16] blk-mq: remove useless checkings from
 blk_mq_update_nr_requests()
Message-ID: <aJ83u94pHXGlaoD1@fedora>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <20250814033522.770575-4-yukuai1@huaweicloud.com>
 <97b63163-a122-48f0-805a-a06cf792903f@linux.ibm.com>
 <31a567ac-180a-b2de-2233-e758a9a977d8@huaweicloud.com>
 <bbbe1889-38e8-4ab9-bce5-a4371b976433@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bbbe1889-38e8-4ab9-bce5-a4371b976433@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Aug 15, 2025 at 05:29:01PM +0530, Nilay Shroff wrote:
> 
> 
> On 8/15/25 7:02 AM, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2025/08/14 20:23, Nilay Shroff 写道:
> >>
> >>
> >> On 8/14/25 9:05 AM, Yu Kuai wrote:
> >>> From: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> 1) queue_requests_store() is the only caller of
> >>> blk_mq_update_nr_requests(), where queue is already freezed, no need to
> >>> check mq_freeze_depth;
> >>> 2) q->tag_set must be set for request_based device, and queue_is_mq() is
> >>> already checked in blk_mq_queue_attr_visible(), no need to check
> >>> q->tag_set.
> >>> 3) During initialization, hctx->tags in initialized before queue
> >>> kobject, and during del_gendisk, queue kobject is deleted before
> >>> exiting hctx, hence checking hctx->tags is useless.
> >>>
> >>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>> ---
> >>>   block/blk-mq.c | 11 +----------
> >>>   1 file changed, 1 insertion(+), 10 deletions(-)
> >>>
> >>> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >>> index b67d6c02eceb..3a219b7b3688 100644
> >>> --- a/block/blk-mq.c
> >>> +++ b/block/blk-mq.c
> >>> @@ -4921,24 +4921,15 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
> >>>   {
> >>>       struct blk_mq_tag_set *set = q->tag_set;
> >>>       struct blk_mq_hw_ctx *hctx;
> >>> -    int ret;
> >>> +    int ret = 0;
> >>>       unsigned long i;
> >>>   -    if (WARN_ON_ONCE(!q->mq_freeze_depth))
> >>> -        return -EINVAL;
> >>> -
> >>> -    if (!set)
> >>> -        return -EINVAL;
> >>> -
> >>>       if (q->nr_requests == nr)
> >>>           return 0;
> >>>         blk_mq_quiesce_queue(q);
> >>>   -    ret = 0;
> >>>       queue_for_each_hw_ctx(q, hctx, i) {
> >>> -        if (!hctx->tags)
> >>> -            continue;
> >> It's possible that hctx->tags is set to NULL in case no software
> >> queues are mapped to the hardware queue. So it seems that this
> >> check is valid. Please see blk_mq_map_swqueue().
> > 
> > Ok, thanks for the reviw.
> > 
> > I didn't notice this, just wonder how can this happen?
> > nr_hw_queues > NR_CPUS?
> > 
> I think typically having nr_hw_queues > NR_CPUS is not allowed. 
> But it's possible to have no software queues are mapped to hctx.
> Check this commit 4412efecf7fd ("Revert "blk-mq: remove code for
> dealing with remapping queue")

It is possible in case of poll_queues, for example:

modprobe null_blk submit_queues=$(getconf _NPROCESSORS_ONLN) poll_queues=2
 
 

Thanks, 
Ming


