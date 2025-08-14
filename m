Return-Path: <linux-kernel+bounces-768199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA87B25E30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85125721FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CA26E153;
	Thu, 14 Aug 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao2Z9Edk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79431288C14
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158072; cv=none; b=qCIU4dfwymqcLKlJ7kAeKfr8DpIyi7dYc2qnouJa/E9JzhKOSet5bS74S6pmC77ONhxH41zEZpUz7tZDasKed6aRh4byFYw4Ia/G2fBP1Dwe46VozNCYgS4yg4wALldYpdwhanWaeZPy2zJTuYJA9mXuuGEQ7dADoPq/VKSeR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158072; c=relaxed/simple;
	bh=gFxsN1xHXuH4aYODzZvCn6y9twW0wvYlwEoeBLVoaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROpWgY3uz2R8GGIOoHZMPu7vLOFcqZD2Xrx6XGvcCZLaZ9u6qYunLoE6WNTW44VBFc21AYM5ygbFI0AAslBv3Mx2vJiBUX7UDOfwOsYDYrsx13ExoCYEv8mLz1sWOyD4ZpQ7Lbn9nw2duTzheU7LhpQy5yOergNwXSiul/DXp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ao2Z9Edk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755158069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gvCHjnpcSAUaN7gXzwggkNMvZ98WWP2pt/inhjEHLms=;
	b=ao2Z9EdkSpjAkdmeL8YpZfoM9fQI3IWm1t5QVseJNASHEM1cnNEA6y0fQcOpfyKf/h4u3f
	7SsiyBi75egEGkoNZwDdWlzsxUirL5N/T/fS7ydL2cI0eUMZ4BeJ0qnfxoKmfCT12VjCi1
	5gxstf9pw6bSxhbhVGWpgv34eVWMMO4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-bu6aYrPAMeysp_9OCXCHZA-1; Thu,
 14 Aug 2025 03:54:24 -0400
X-MC-Unique: bu6aYrPAMeysp_9OCXCHZA-1
X-Mimecast-MFC-AGG-ID: bu6aYrPAMeysp_9OCXCHZA_1755158062
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BA711800298;
	Thu, 14 Aug 2025 07:54:21 +0000 (UTC)
Received: from fedora (unknown [10.72.116.148])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 805F019327C0;
	Thu, 14 Aug 2025 07:54:11 +0000 (UTC)
Date: Thu, 14 Aug 2025 15:54:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, yukuai3@huawei.com, bvanassche@acm.org,
	nilay@linux.ibm.com, hare@suse.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH 00/16] blk-mq: introduce new queue attribute asyc_dpeth
Message-ID: <aJ2WH_RAMPQ9sd6r@fedora>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814033522.770575-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Aug 14, 2025 at 11:35:06AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Backgroud and motivation:
> 
> At first, we test a performance regression from 5.10 to 6.6 in
> downstream kernel(described in patch 13), the regression is related to
> async_depth in mq-dealine.
> 
> While trying to fix this regression, Bart suggests add a new attribute
> to request_queue, and I think this is a good idea because all elevators
> have similar logical, however only mq-deadline allow user to configure
> async_depth. And this is patch 9-16, where the performance problem is
> fixed in patch 13;
> 
> Because async_depth is related to nr_requests, while reviewing related
> code, patch 2-7 are cleanups and fixes to nr_reqeusts.
> 
> I was planning to send this set for the next merge window, however,
> during test I found the last block pr(6.17-rc1) introduce a regression
> if nr_reqeusts grows, exit elevator will panic, and I fix this by
> patch 1,8.

Please split the patchset into two:

- one is for fixing recent regression on updating 'nr_requests', so this
  can be merged to v6.17, and be backport easily for stable & downstream

- another one is for improving IO performance related with async_depth.


Thanks,
Ming


