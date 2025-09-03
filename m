Return-Path: <linux-kernel+bounces-798856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B728DB423EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2655E2DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27020213E6D;
	Wed,  3 Sep 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmJBTmVy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBD1C862D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910609; cv=none; b=dDVho+85U8AwSVJ10VSDJx1GwPREZ7ffruBS2Ec5K+7FE53JskQJcjqNHx0I8w5cOIPEzj3gVzD1IGi21xzKANHFNIA6Jtfu4o9dMx4XRU2mIDlIeAKBOIQRLt1NvBRh+aut43hVum8BrRgkJQtkIEVcJjUpCpZpHpmdDrI1QdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910609; c=relaxed/simple;
	bh=qsg5b1hCS0TH3mz58QfmV5A/hWbcjsLvlIP4yl/lCZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nay/B8QOm8Afwq1nyIDiRNQU6HeM9Js57CnrIGO+waFkMnNmlRO6dIjL71tSiWlNNvhKfZRQbFU8abZVCVBd2jvT2ezwosrhMIavnPNmGDg1vnwjFHZDWN8/55Hog9KMHfujmg2WSpUIDt+9MVoybnRgmft75Z0Wvu9+9YiNFDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LmJBTmVy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCtH6GLs0daKTSTUdfVUnTaEI5cKFQFkvOMaqMYTXws=;
	b=LmJBTmVyKqKPQ3ECDftplN2Y2AuI+53jYd9LzYW2IpGcTpUWg42P7Rj5P+xOeTNBwFlxIc
	14vTVEMpYWmQ+3+2wuuvCtUv2H1TOMvYfVUlWhd9EzgyyjWjbpvrO5jTG/1MmpiqHlFfOw
	k9c6SE1twA3gYsnL9w+Qh78DXJmbAAU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-WtQmNRSeNwijBPK-1NPpDg-1; Wed, 03 Sep 2025 10:43:24 -0400
X-MC-Unique: WtQmNRSeNwijBPK-1NPpDg-1
X-Mimecast-MFC-AGG-ID: WtQmNRSeNwijBPK-1NPpDg_1756910603
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45d6c770066so164075e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910603; x=1757515403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCtH6GLs0daKTSTUdfVUnTaEI5cKFQFkvOMaqMYTXws=;
        b=l9PQEVMmV4QIP+9KMldFX+WlF2HD5C1a2zozWayl5NXVmT60sEzsbnRbPG+PrRifzH
         LXb5AK1zr5YzSrWFgLJPymyvjyLbNCkMysy5AVKwB1Y6pZmOUwngWSRun5PgT521ewf0
         ksuOkiO8qKChultwKZdPVr70igmhbQSvDtvohG100+RECF5MDs+7DG9bdJk4IptX+YR3
         njlIvN8rhNlHjzK1ncCQQMy960PcurZ+z5z1lEv12PQYL3xM6PQduCKvUuet9wo+Mcq3
         xkO7EVd06cQoz02QX+QPyYl4kzi6Cm9c5UCtSL/BmYLwiSloabLNlQashTFf6ZXzoUzM
         YFTw==
X-Forwarded-Encrypted: i=1; AJvYcCUGRsFnaPzSwZgTArYmMXBfcvpq1600q2OhkZwd18vqVr1NzesReaBGTvKCEQ2gDCMT2tZpXionwZCayEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQkQjRyl4nE0x+OJgPxuj2fWtVKTPHIEiJkTBt25aqYvMJ+hSA
	xT5iu7bJ0jk1jQTXrK5ClDJCNBLHJiGTNPfGww6JRztIWqV4XmPZBZLZzoa5KBnGikEVeIsa3cu
	a5LvoUVylAT5IkJdpjBYhOmr09hSF8XOdymwBIERcALpVMgyrfAmlPyWTVSzwBNyBFQ==
X-Gm-Gg: ASbGncuR2JqPLAE9c0iyS8TaEru2hLwf97Y8xwntcCOuut52d7xlnqRpkkD8fzuWr2D
	3YCPEvg8Xedb1vJrPNn4zWcJ7ioSL5/v+I1bTD/087e797Gyt077oU53cmsFoyYTPV7l28OAOt7
	P9J/kAgzLkgVTWQ5OuedOU462UoyGwU2zyx8pz2ggBWpqrT8XBtfMIFyV06di6MLe9ueuCXqCbQ
	ndNuJnH8hARZs/hhaTzXWBUUe8FwqQIibWEvu9AQ23fLbWGCf22i5jCjP8vHK2zA7+0JJijMvDs
	p7kJz8lFtoSLxPD9Kdg9oPq2wfj4j19PMBD3N53SQ1XCTIcq0Rfw3pDKi6t6UAgJ2jtCrO8=
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr108070825e9.18.1756910603001;
        Wed, 03 Sep 2025 07:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF69gAChxFwcluBRYHF0+z51FCVtEVCadQL0dqsUkUmSsfKqXS/cjr5c0WBKbduX2OT6RRehw==
X-Received: by 2002:a05:600c:1f13:b0:45b:8ab0:59a9 with SMTP id 5b1f17b1804b1-45b8ab05bd1mr108070485e9.18.1756910602534;
        Wed, 03 Sep 2025 07:43:22 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b72c55c1bsm342903985e9.10.2025.09.03.07.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:43:21 -0700 (PDT)
Date: Wed, 3 Sep 2025 16:43:19 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aLhUB86NwnaQ8bMf@jlelli-thinkpadt14gen4.remote.csb>
References: <20250903095008.162049-1-arighi@nvidia.com>
 <20250903095008.162049-4-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903095008.162049-4-arighi@nvidia.com>

Hi,

On 03/09/25 11:33, Andrea Righi wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Currently the DL server interface for applying parameters checks
> CFS-internals to identify if the server is active. This is error-prone
> and makes it difficult when adding new servers in the future.
> 
> Fix it, by using dl_server_active() which is also used by the DL server
> code to determine if the DL server was started.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/debug.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index dbe2aee8628ce..e71f6618c1a6a 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -354,6 +354,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  		return err;
>  
>  	scoped_guard (rq_lock_irqsave, rq) {
> +		bool is_active;
> +
>  		runtime  = rq->fair_server.dl_runtime;
>  		period = rq->fair_server.dl_period;
>  
> @@ -376,7 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		if (rq->cfs.h_nr_queued) {
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
>  			update_rq_clock(rq);
>  			dl_server_stop(&rq->fair_server);
>  		}

I believe this chunk will unfortunately conflict with bb4700adc3ab
("sched/deadline: Always stop dl-server before changing parameters"),
but it should be an easy fix. :)

Thanks,
Juri


