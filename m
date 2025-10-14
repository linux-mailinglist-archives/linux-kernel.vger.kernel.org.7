Return-Path: <linux-kernel+bounces-852113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 067FBBD8326
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76D8C4F8F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD3B30F940;
	Tue, 14 Oct 2025 08:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c31dqcLz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB229ACD1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430894; cv=none; b=iDrgtAHEi4FhUzF+oyPXJCFME3JlZmKBQvXhk6+6HJUs5VOQC2ULv3cR6qR9L+KzfnCwsdx3v+tPVOMYG6eR0PORH9KdeWpAd78hhHTCTrCseGMPUUioGRqTvX8ftqEHMhThGSfz+eNWs5dGYoLUH1m1WCJri9iUla8HsL9xP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430894; c=relaxed/simple;
	bh=pRsTyfPJ9UJjbA5j1H/hTOwtZY7SmFyXvGs+UofQcTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX+8oL89/pQEi2bD3ZZxrtgnHVxWaOZ+3+xCHTxYXUZgUYeY+9/6J1N0jeT2nw0+9X8AZ/1cDIZo1rIwJWcFOCE6kwsR8LpNN63F2apSXIxCa5QWMwAkqtfD4K6CECVhIZyzOVj5OBOPUQ+mZpTE4FLQeNPvSYUVGtIaLBkJQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c31dqcLz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPbpAfXFpG+F0XArG45/phfeDqh8oNdwtwM3KTn35LI=;
	b=c31dqcLzu2Khj1cMedPA6Azp+ZYVImp1pnALNpmhF+wl/V2gxBS+Ey3CdZ0vVzoRSQP8PK
	K/gOGikZqY1LbOyXa9wY3xc2OIngsK/NcghP2EBfcgecyZbyhz8rX5HBRnwXVEGJxPTgKl
	x5SzUmEds5sCh/nv2KHgSuC4iC74iCA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-SXWV4OF1NRKazgloSSdOFg-1; Tue,
 14 Oct 2025 04:34:48 -0400
X-MC-Unique: SXWV4OF1NRKazgloSSdOFg-1
X-Mimecast-MFC-AGG-ID: SXWV4OF1NRKazgloSSdOFg_1760430886
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 557011956089;
	Tue, 14 Oct 2025 08:34:45 +0000 (UTC)
Received: from fedora (unknown [10.72.120.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674921955F21;
	Tue, 14 Oct 2025 08:34:37 +0000 (UTC)
Date: Tue, 14 Oct 2025 16:34:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com,
	axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/4] blk-mq-debugfs: warn about possible deadlock
Message-ID: <aO4LGJ6I49dydw2J@fedora>
References: <20251014022149.947800-1-yukuai3@huawei.com>
 <20251014022149.947800-2-yukuai3@huawei.com>
 <aO4EniFy63IlWM_-@fedora>
 <33c009e6-0cc3-bfc3-f7e5-8227cb467696@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33c009e6-0cc3-bfc3-f7e5-8227cb467696@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Oct 14, 2025 at 04:21:30PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/10/14 16:06, Ming Lei 写道:
> > On Tue, Oct 14, 2025 at 10:21:46AM +0800, Yu Kuai wrote:
> > > Creating new debugfs entries can trigger fs reclaim, hence we can't do
> > > this with queue freezed, meanwhile, other locks that can be held while
> > > queue is freezed should not be held as well.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/blk-mq-debugfs.c | 31 ++++++++++++++++++++++++-------
> > >   1 file changed, 24 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> > > index 4896525b1c05..66864ed0b77f 100644
> > > --- a/block/blk-mq-debugfs.c
> > > +++ b/block/blk-mq-debugfs.c
> > > @@ -608,9 +608,23 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
> > >   	{},
> > >   };
> > > -static void debugfs_create_files(struct dentry *parent, void *data,
> > > +static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
> > > +				 void *data,
> > >   				 const struct blk_mq_debugfs_attr *attr)
> > >   {
> > > +	/*
> > > +	 * Creating new debugfs entries with queue freezed has the rist of
> > > +	 * deadlock.
> > > +	 */
> > > +	WARN_ON_ONCE(q->mq_freeze_depth != 0);
> > > +	/*
> > > +	 * debugfs_mutex should not be nested under other locks that can be
> > > +	 * grabbed while queue is freezed.
> > > +	 */
> > > +	lockdep_assert_not_held(&q->elevator_lock);
> > > +	lockdep_assert_not_held(&q->rq_qos_mutex);
> > 
> > ->rq_qos_mutex use looks one real mess, in blk-cgroup.c, it is grabbed after
> > queue is frozen. However, inside block/blk-rq-qos.c, the two are re-ordered,
> > maybe we need to fix order between queue freeze and q->rq_qos_mutex first?
> > Or move on by removing the above line?
> 
> Yeah, I see this reoder as well, and I tried to fix this in the other
> thread for blkg configuration.
> 
> - queue is freezed by new helper blkg_conf_start(), and unfreezed after
>   blkg_conf_end(), rq_qos_add() is now called between them.
> 
> And for wbt, there are two cases:
>  - for blk-sysfs, queue is alredy freezed before rq_qos_add() as well;
>  - for wbt_enable_default(), this looks still problemaic, we should fix
>    the reorder seperatly.
> 
> Perhaps, should I fix this simple problem first, and then rebase the
> thread to convert queue_lock to blkcg_mtuex?

As I mentioned, if you want to move on with patchset first, the line of
`lockdep_assert_not_held(&q->rq_qos_mutex);` shouldn't be added until
->rq_qos_mutex vs. freeze queue order is finalized.


Thanks,
Ming


