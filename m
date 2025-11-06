Return-Path: <linux-kernel+bounces-888298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF8BC3A738
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D3873A5C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA5A3009E9;
	Thu,  6 Nov 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIDZMW2J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IF3ECAUS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D42EDD4D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426804; cv=none; b=kyMJVWiG7kgqK6tawWhnbOiwxItgAy1WSbd2qq1/CqX5DIMeEvtfdrEvwjL0BjbdgP561ZhZGEABfBIfqA6hz6tYtF1x6e69wXL8gZuTWliw1opcUZqyaPrs4hWWzx8/e9T76mZQ8us9WRfsbJSmovwTom4zfB0nCmSpan/zXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426804; c=relaxed/simple;
	bh=XhdNPhgcKwRHGpsghZqwpvIX6EwSAeLHReIqHW0vxw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW0X4O+j6wnnT68ztmQXpxv1wrhI0CDrk2UwPsO4fBfDeTklf2K9jwwpEm+ZTr7afgIXaRQUe6MYDrEXYVS3y+L4f6GZmzeqBVyTwbCjXh/9wUZD7fEqPX4LeCObhZbPe2GqpiSh/WsinReFYOTtpCQRhdsxLWw7hg9V1Ohyj7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIDZMW2J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IF3ECAUS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dukGyhpRYfvrs4wKeywqzuHqeO7YctCXQ09D1HJF/+g=;
	b=GIDZMW2JS75Pw/fGgcTollMSKE+ODzslR+Jd4ZJgv8HsL/Z3fkEiVDh1PPm1TkuJivDK9o
	X3K6G3dAzcNWc81NRKce2OW+3plewbq2EmU41lnz9gao+uvsMWTeGl8xBgRycNboYF6V34
	XdT1p+fpHJWx/oPMdApHxCbc9GCOQyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JqBMNXjdPC6zOJ06-yJrbw-1; Thu, 06 Nov 2025 06:00:00 -0500
X-MC-Unique: JqBMNXjdPC6zOJ06-yJrbw-1
X-Mimecast-MFC-AGG-ID: JqBMNXjdPC6zOJ06-yJrbw_1762426799
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471001b980eso6442075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426799; x=1763031599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dukGyhpRYfvrs4wKeywqzuHqeO7YctCXQ09D1HJF/+g=;
        b=IF3ECAUSWeDyV/25tkrAbjsNpvCNNM982mYfKLtbKr7/FCO70Xrvejj3iwbhJEkiYI
         TLwbiYVTxohYBAfGJyUROF44uuaPEwf19tYsUW+0WfER3dNwnntVSUtPcXct/wQVHEgc
         T4EIUecVelSYcwmrn7EqhfxAZOgO3YI5qDzM3R0Ay7E/uh9NLtFLjys1qcR/72GGfKZS
         3MKuMVk20RAAfnTy+LnUwyqUjl+HfMEC6ie3yl0fNFJW2t/zt74zq5nfXOa8esbByOS6
         bo4BcsxcyoQ6vkkOjYiE4xBqlcxknzQTCYLrIi96mo7jYuUY9ND6/9//Lc04Ope2kWTf
         Fh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426799; x=1763031599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dukGyhpRYfvrs4wKeywqzuHqeO7YctCXQ09D1HJF/+g=;
        b=d9xv+piVZN/gRbQ2zJJ2vJgUrYvEv4HEmX0hFNwSCa/gcB/hImMQE5HfUyW4SSLr8O
         vI7Zr99zaVWfdPICOqpNzcyTYgXSidWRG5KGdkVlnxQ5tNqBVEnIj7ZfoO7jSR6rxahI
         NI+aLBF74z71EGtsp1KwlECz9OZW2gq+3kjqVeKajRFFvbuFGl25G9U6pv01xU+y4C6U
         BBRn7paczBAyVXcjHVH1OXqa/+U2rRpA3Y+3FZVzwOZmoLX7BostgKQA5IFyhSp8rG49
         Gg2KxNykfFrF8TmcU9KY1vpt0BU2KwVkBt2Ta0SZ8n7zK7pM4HSzJJP5kmN5l6RE67ZT
         CnvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUumxWERYJKx2JR3UZfAx0kpvT+wUkRFxOBghYlWWfNa9y7DNVAlA5sZZ87zWRdqfBtjeTj80wrPpoXXlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZOGcrloVwRy2WSklrBaKRGTKX2i4w759gbLFcebbHesXsb9cm
	FV0JsAmV8B2IszlA6pPFRcqPLy4IIRHgUP7HLP1RUIFt1NexIcN+6asOrcZjLehimhGuKaOdFJw
	/gDEBRiyuqi7n7m9Mpr+L+iLAB9H1eZbbWx/jonHriNA7bGuKpaPgddEhfb3PXW8rNA==
X-Gm-Gg: ASbGncvns+UBzkMCVl5bPCIz9QE7TEPmzj3ABS41gvepFya7U7DzxgfX2hX6jKBWfG8
	SrabngAbsySCulqFcdxaecA2W2L5e/GIuRM8fwglKkTf5kMAa7V1toJnwzYKqLChyYaGj2LIFgD
	I4RsiTg0azgVbt+vlVSMBqkq0GyQ2urdwl4BnFpF16FZO2JBudvFrnIuqPgHhEU/D5eDehSe2jd
	9NTBiic4deRWGXddvwx2IiQ0lNwS4xj2BlftPsxRV3ihcT8qDnz8dmXCbqaCzURQkmAREIUUo/3
	ct06+OKFPzZ9aLfL0Yz9ulNvp9M9EBrLxAeyehPUtlIRH8ny4PyRFb51xuxLnZuVrTygJ95RtJs
	OZJzdCINuodyKbWoxUkXH1eBEzZPODA==
X-Received: by 2002:a05:600c:4e88:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4775cdad71bmr51439645e9.1.1762426799385;
        Thu, 06 Nov 2025 02:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGW1NbZGtrlA4TV+fO55QhvpfF+mYk65ZcCXIRCNO4lkLe3raDP0AR7WU3owI3VJ3NsULGBOg==
X-Received: by 2002:a05:600c:4e88:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4775cdad71bmr51439335e9.1.1762426798983;
        Thu, 06 Nov 2025 02:59:58 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm108508305e9.6.2025.11.06.02.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:59:58 -0800 (PST)
Date: Thu, 6 Nov 2025 11:59:56 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Luigi De Matteis <ldematteis123@gmail.com>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <aQx_rJccmaJEOAUk@jlelli-thinkpadt14gen4.remote.csb>
References: <20251029191111.167537-1-arighi@nvidia.com>
 <20251029191111.167537-7-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029191111.167537-7-arighi@nvidia.com>

Hi,

On 29/10/25 20:08, Andrea Righi wrote:
> sched_ext currently suffers starvation due to RT. The same workload when
> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> processes to stall. Fix it by adding a DL server for EXT.
> 
> A kselftest is also provided later to verify:
> 
>  # ./runner -t rt_stall
>  ===== START =====
>  TEST: rt_stall
>  DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
>  OUTPUT:
>  # Runtime of EXT task (PID 23338) is 0.250000 seconds
>  # Runtime of RT task (PID 23339) is 4.750000 seconds
>  # EXT task got 5.00% of total runtime
>  ok 1 PASS: EXT task got more than 4.00% of runtime
>  =====  END  =====
> 
> v3: - clarify that fair is not the only dl_server (Juri Lelli)
>     - remove explicit stop to reduce timer reprogramming overhead
>       (Juri Lelli)
>     - do not restart pick_task() when it's invoked by the dl_server
>       (Tejun Heo)
>     - depend on CONFIG_SCHED_CLASS_EXT (Andrea Righi)
> v2: - drop ->balance() now that pick_task() has an rf argument
>       (Andrea Righi)
> 
> Cc: Luigi De Matteis <ldematteis123@gmail.com>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

...

> @@ -1409,6 +1412,15 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
>  	if (enq_flags & SCX_ENQ_WAKEUP)
>  		touch_core_sched(rq, p);
>  
> +	if (rq->scx.nr_running == 1) {
> +		/* Account for idle runtime */
> +		if (!rq->nr_running)

Hummm, didn't we just add_nr_running(rq, 1) before gettng here?

> +			dl_server_update_idle_time(rq, rq->curr, &rq->ext_server);
> +
> +		/* Start dl_server if this is the first task being enqueued */
> +		dl_server_start(&rq->ext_server);
> +	}
> +

Thanks,
Juri


