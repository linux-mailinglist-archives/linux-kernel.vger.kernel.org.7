Return-Path: <linux-kernel+bounces-860430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 41110BF01D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98D544F38BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CD82EDD41;
	Mon, 20 Oct 2025 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT0Qw3A0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286E2ECE9D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951540; cv=none; b=T+GxarVFJT8y3HDe1iWn+6SmX7tJmDjwFlaKjV6Jo96SJcZFNnifo3mnrHlh9l9SDKvgsN4CzqT57w3KkRQiJeliIhfgrtIpmvu0pBmTwVjz0927rau342FEXKAHih9L14xzStIXFYyP3ht4se2DmycTLhUbb+K9S4ypK9App5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951540; c=relaxed/simple;
	bh=ta6LSkk+9A3FVM3mm3iDzNK4zuCKnQq6jaHDvp/Xdvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYbFHPN48Z1xhJ6R/SaVGxB5Ed59cpuebn4njGQ68hpj7pw6sl1qLGR3/PXDg3prVoOirGK+OdDHw5Xs9xSG+C/ukkPmAA+aQQ9lyfksr90W+jg4RfMVBk/GA3NhtistT+VFPV54KyW6hZ2MvlOxdopc2js9hMT+zAh8p2Y2HGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT0Qw3A0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760951538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ubitj5/uevHZU/7Ly6xrweyvQaOv3M8jgDaIwUyJNQ=;
	b=bT0Qw3A0AJuull4wCyXQW2wT13oo9ED27LBcV8o7PrT9kDQYq12n81ojNMCRb/95cdqIzZ
	Zo+8KBd48YHapjuFyvPjmaCKtbjAm7gKasOXqIXDkTtyaV2C+4vE+8MRoWL+TuYblUJFsj
	QsAT0+WW28GyIaaqwU/6JiCsqzlTang=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-mfu7_9UAOoaCwJWhrL5XFg-1; Mon, 20 Oct 2025 05:12:15 -0400
X-MC-Unique: mfu7_9UAOoaCwJWhrL5XFg-1
X-Mimecast-MFC-AGG-ID: mfu7_9UAOoaCwJWhrL5XFg_1760951534
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4270a273b6eso2077755f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760951533; x=1761556333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ubitj5/uevHZU/7Ly6xrweyvQaOv3M8jgDaIwUyJNQ=;
        b=ma601LtCFv99kV66ERjq5BVwTkxl7c1N+PVE+kPRD73toteUn7K5S72wLWjZZ5fzdW
         rHKV/aJfUvVO7x5+5117EOKHoIUSuK54/UO2jLVMT3MhkRuTZtNmoMnJNwN+fhwLxgcd
         xRbs24On1EnckWPIfoiN7/UGzo2tWYGeWs/JVdJSQa5kjza2PUZnWN6/+M+aOvAVa91y
         q3T1bVtWNJ+5ZUeNjIZD6qerYEp26WTb5nXg+s9MV7YHHf9TNOwBPL2m9U94io5ceKVx
         6Mh6YjnIzZf5M4ekij7gadxT8Ql/zZkq61WaXYCC9InVurxm10AQRKukz6WGRpiErLGc
         Dtrg==
X-Forwarded-Encrypted: i=1; AJvYcCUPErm8K0Y+HL8BMrLpTB8Z0E00UijDLvn+pyC2oeLn+yPpkLy/d19jd8reeHbOkC7LfiG0/so5kcq7tAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQO9hKtXQOKkyWLKgumb3/f7yMvm6T9RYKGUQhUcCjwn5mL1hk
	Iah1fDuU6RbuRnVZLZ17CH4maDooEde/8ENQU+1YIQLe7OKxHN8gk/f/MRGdZlbhnQ+dH8X1/tG
	WjSYroqVFu1pwPMzl4SpBUAR1YXb//5CZs/rK+ivQiqHDQLKUZ4z46wY3ruTgrxQFcg==
X-Gm-Gg: ASbGnctzWOqqyhxPP2jf5mQ8/OmUHg3Nt6H+pSLpC0Tp+j1iolgounghMvtvkYdnkAu
	7/Nfzfe+FPuwWnhcv6ZUfIDm0t1NFm8PqZjvxi+ZbyVY438otFasLCvc7922xQdoIzU6uFXpE14
	lsskRwCSIgbdnGXl1S1MgUYeqbeshQNNuufbEY0UgI37YqgH+mIhFTIGqAQZFC/n7EIqjpooz2u
	gEsK2AkTQHPM9R3/PjSiMMRlO99jSTn7UcjuAnol4DZZrMoq+L75yhNWtEDFkJB9ts0rhEGNKnE
	iWTyrq4DYLpY6ggf1gaggV/ieZeGB6cfJYNnTApxzdId/YDUtkTjqXCfLFsSwKtbi9KjEweTJEm
	pd6edgiw7ucF4iJcRHG2qtvtgpAvSoHg=
X-Received: by 2002:a5d:5888:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-42704e0efc6mr8234679f8f.60.1760951533503;
        Mon, 20 Oct 2025 02:12:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1x7pXYq8e945UALV9q1YHdxFAo/gpZoHmNBgsdqAAWXDZS350AGwm1xrETAUHltalmZTxLw==
X-Received: by 2002:a5d:5888:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-42704e0efc6mr8234649f8f.60.1760951533088;
        Mon, 20 Oct 2025 02:12:13 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm139474055e9.6.2025.10.20.02.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:12:12 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:12:10 +0200
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
Subject: Re: [PATCH 02/14] sched/debug: Stop and start server based on if it
 was active
Message-ID: <aPX86h9lSEZh0YP2@jlelli-thinkpadt14gen4.remote.csb>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-3-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017093214.70029-3-arighi@nvidia.com>

Hi!

On 17/10/25 11:25, Andrea Righi wrote:
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
>  kernel/sched/debug.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 6cf9be6eea49a..e71f6618c1a6a 100644
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
> @@ -376,8 +378,11 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
>  			return  -EINVAL;
>  		}
>  
> -		update_rq_clock(rq);
> -		dl_server_stop(&rq->fair_server);
> +		is_active = dl_server_active(&rq->fair_server);
> +		if (is_active) {
> +			update_rq_clock(rq);
> +			dl_server_stop(&rq->fair_server);
> +		}

Won't this reintroduce what bb4700adc3abe ("sched/deadline: Always stop
dl-server before changing parameters") fixed?

Thanks,
Juri


