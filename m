Return-Path: <linux-kernel+bounces-771009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25663B28187
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EAA3BA8BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2512206BF;
	Fri, 15 Aug 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhDz1wMM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B219004E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267667; cv=none; b=BeVEs9aWk0IETUldx+0iJehXClm7O1Aaw/QvcwDu23XELjAu2r6Ax+9ov7jFuVE6hwGfaTQsFzfG/52ijnRTfVdOBPO/JS3zzbJbt0vrANHl841PAdbQfJ1y08lUZR3DU0RRrPr9q8DL9f4RHYlu1PLTyMueY6O8KGjXcoTQ1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267667; c=relaxed/simple;
	bh=CPxucYIm7oasvzLoBrismDQsuh+/GmgJfPSHxJvJ6lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6wX0JhmJf9AP1J7aiUfsuJPAiSbG2IjTb0yLy1DgPHeDG1lnsLkxnhzDtvnmKa5sDMQMuWBsU7rU4OQWhLB+eecUnZfq2SBGSCK7XOe0TkwV6yHXTk1jCgxRW6bubpdM87DZRyACVz9GWIDmHK753xEETVmpsI5Mz0amXHr6ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BhDz1wMM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755267663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saGqJBJfNTgDTptPjcuyScrXSOaQQQGEpnWQeRSkQd4=;
	b=BhDz1wMM2M9+08m8GHP4/1XcpPhZIaFegROfSxYFnuDUfXYuP8Z+viGspOxoImoB1Wjrqq
	3gQa/E99MgjczrzyrPjx/6u1b70hgWbrrfXCvV9fvlKQhD/maRj0jT4bvblS2Fpce/w4g0
	+XUMXroCQbBqI/YFyorcSQ3D66TWwXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-7vDJsnrvPD-MtH5Nghf2jw-1; Fri,
 15 Aug 2025 10:20:59 -0400
X-MC-Unique: 7vDJsnrvPD-MtH5Nghf2jw-1
X-Mimecast-MFC-AGG-ID: 7vDJsnrvPD-MtH5Nghf2jw_1755267657
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E533619560B3;
	Fri, 15 Aug 2025 14:20:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25AE71955E89;
	Fri, 15 Aug 2025 14:20:46 +0000 (UTC)
Date: Fri, 15 Aug 2025 22:20:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, nilay@linux.ibm.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 00/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aJ9CN_oeQERVgAoW@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <aJ7wMFkuTewlyx1P@fedora>
 <abde1955-d634-29d4-d229-df8c6ebdc582@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abde1955-d634-29d4-d229-df8c6ebdc582@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 15, 2025 at 05:05:34PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/15 16:30, Ming Lei 写道:
> > On Fri, Aug 15, 2025 at 04:02:06PM +0800, Yu Kuai wrote:
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
> > > patch 1-6 are prep cleanup and refactor patches for updating nr_requests
> > > patch 7,8 are the fix patches for the regression
> > > patch 9 is cleanup patch after patch 8
> > > patch 10 fix the stale nr_requests documentation
> > 
> > Please do not mix bug(regression) fix with cleanup.
> > 
> > The bug fix for updating nr_requests should have been simple enough in single
> > or two patches, why do you make 10-patches for dealing with the regression?
> 
> Ok, in short, my solution is:
> 
> - serialize switching elevator with updating nr_requests
> - check the case that nr_requests will grow and allocate elevator_tags
> before freezing the queue.
> - for the grow case, switch to new elevator_tags.

I'd suggest to make one or two commits to fix the recent regression
f5a6604f7a44 ("block: fix lockdep warning caused by lock dependency in elv_iosched_store")
first, because double free is one serious issue, and the fix should
belong to v6.17.

For other long-term or less serious issue, it may be fine to delay to v6.18
if the patchset is too big or complicated, which might imply new regression.


Thanks, 
Ming


