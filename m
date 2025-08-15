Return-Path: <linux-kernel+bounces-771068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC9B2826E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E793D188968D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8D277C86;
	Fri, 15 Aug 2025 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dstUBnNF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6461C22ACFA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269293; cv=none; b=B2Hcp5ZHNHH3Avwo6aKz3/rEjvFn6uZ/SSL1pwbjwMvMzHkZVAlhgsV53GTBwAiJjPlpnkWuvLNOrwNRCooYyJMuCvTKgrVFtOSNaaaojNIRPeKfvPuYE+dCmYmJwHas7aHodWRfrS9RmpmTzmUtBeTcvzz706KIyqe1Fxbr6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269293; c=relaxed/simple;
	bh=6p3tH5dyDYB5dW9LDS2LWwvBo8AewBArfanZDC9eIx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYNe8I24irbGV+kvxs9WBpJdwbTC/uxEz0zBFBfMmd8LNEolwLORPO4khRvC8SbkKkRGWOS3m8cTI54Q/KdvweQSBFBAOlTSBgV8iksfJ0Xzkgt3Yeumrbw1DYfT7QImU00r0saHVq3eUYNHtPF0OATk5k1kS0LJvsU4aq+8etw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dstUBnNF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755269290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B0lsi7uNi+Pjd1zai/fmB5p40xmZGFkcZlTsakj032U=;
	b=dstUBnNFD5lnB5GgcoNOpxBmRToRn5LEwjGyfyDOLY5LFN0rJEg6npqKWHwVWnMwTgsfvM
	M8Wq3yl/oMyrzdPa+7IBi29Hb0W/rXoeIEGIKbbgbbyxihu0iHPZmVkpyYZdo6sfQ8rI+v
	3G+eYgnhbEdNBWl2eIDkExyjb9N7+UQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-GSw4hUj6M9W3qPpdmb6ZOQ-1; Fri,
 15 Aug 2025 10:48:07 -0400
X-MC-Unique: GSw4hUj6M9W3qPpdmb6ZOQ-1
X-Mimecast-MFC-AGG-ID: GSw4hUj6M9W3qPpdmb6ZOQ_1755269285
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22526180035F;
	Fri, 15 Aug 2025 14:48:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A17541955E89;
	Fri, 15 Aug 2025 14:47:56 +0000 (UTC)
Date: Fri, 15 Aug 2025 22:47:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, hare@suse.de, nilay@linux.ibm.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: Re: [PATCH 04/10] blk-mq: serialize updating nr_requests with
 update_nr_hwq_lock
Message-ID: <aJ9IkylydqSNZqwC@fedora>
References: <20250815080216.410665-1-yukuai1@huaweicloud.com>
 <20250815080216.410665-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815080216.410665-5-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 15, 2025 at 04:02:10PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> request_queue->nr_requests can be changed by:
> 
> a) switching elevator by update nr_hw_queues
> b) switching elevator by elevator sysfs attribute
> c) configue queue sysfs attribute nr_requests

 ->elevator_lock is grabbed for updating ->nr_requests except for queue
initialization, so what is the real problem you are trying to solve?


Thanks,
Ming


