Return-Path: <linux-kernel+bounces-770464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C288B27B14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F711C87925
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634D1E51EE;
	Fri, 15 Aug 2025 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xu1/0V9y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43491519B4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246660; cv=none; b=pim+lvDa8dZicsTQRGSOo/vcQI7tspbZQvUE0CwkV3Gh5/I2uubEjD4Vko1Eu8TeAPnCi3h9QpNhKLFDwbL0Og932qQWYL/fm3R2c/I/e0tr5EvMfws/Jard2Uo/nmxR4gI9IqhmbGDZI/fYQtZGXmIiPZvTcvH/R2WhY+wqGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246660; c=relaxed/simple;
	bh=UQcJChL1z6SPalX2fGTv92LMBnWLGK7AcpH+aKksyfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW8GqKDnxqbF+Q+u2JZfSxSGXS9KpWCJakAe3m/sGS2k8Dd7bNlEfo2LOZ57Kjegf/AOflswW5mSbQiQskfT4mfNSn9m5yTrYt/G2DZUWJ7tFSaJSeGWHTRDIXsOfh0KFkXwn/JCXqnBBrfULmg1Cd9TZ/MhwK5GztxYdfIhea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xu1/0V9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755246657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0hSepW5WjWx+taheJm8TbQB80RTQNqQPc4V+jMToCU=;
	b=Xu1/0V9y+5xoMniNpaA7u0Mp1JuXmaK1psAQ2HAnEUx07UAVl4t+ez2EwWGjWvq4s3wgSJ
	bnFtTBHnmf+P/gSRZrDxjBIM/35QEM9tlUx2qVUGxHR2OF2OU9UzKHy9GtftM2NThYTHZN
	JC4hvmTbYJb4pmKsa47W5viKua9Rbp4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-HsaJxG8tOzKH5gBR2XGoOA-1; Fri,
 15 Aug 2025 04:30:54 -0400
X-MC-Unique: HsaJxG8tOzKH5gBR2XGoOA-1
X-Mimecast-MFC-AGG-ID: HsaJxG8tOzKH5gBR2XGoOA_1755246652
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD73D1954228;
	Fri, 15 Aug 2025 08:30:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.153])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A07EF1800447;
	Fri, 15 Aug 2025 08:30:45 +0000 (UTC)
Date: Fri, 15 Aug 2025 16:30:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, nilay@linux.ibm.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 00/10] blk-mq: fix blk_mq_tags double free while
 nr_requests grown
Message-ID: <aJ7wMFkuTewlyx1P@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815080216.410665-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Fri, Aug 15, 2025 at 04:02:06PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> In the case user trigger tags grow by queue sysfs attribute nr_requests,
> hctx->sched_tags will be freed directly and replaced with a new
> allocated tags, see blk_mq_tag_update_depth().
> 
> The problem is that hctx->sched_tags is from elevator->et->tags, while
> et->tags is still the freed tags, hence later elevator exist will try to
> free the tags again, causing kernel panic.
> 
> patch 1-6 are prep cleanup and refactor patches for updating nr_requests
> patch 7,8 are the fix patches for the regression
> patch 9 is cleanup patch after patch 8
> patch 10 fix the stale nr_requests documentation

Please do not mix bug(regression) fix with cleanup.

The bug fix for updating nr_requests should have been simple enough in single
or two patches, why do you make 10-patches for dealing with the regression?

Not mention this way is really unfriendly for stable tree backport.


Thanks,
Ming


