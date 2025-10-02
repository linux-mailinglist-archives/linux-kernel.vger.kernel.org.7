Return-Path: <linux-kernel+bounces-840341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C89ADBB4264
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CDB24E22FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD5311956;
	Thu,  2 Oct 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAvrC8Jn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B961957FC
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759414352; cv=none; b=BWB6UUPAZSefFfU5r/da+RPlVLQY4n+PaqGtmOAcGPVRy1PZ6FAj/hod8Kd9isJbTQ+41xUMLRs/XqdxjtStYDIlRM1xmokKNm2h5eAHSdkoEtAUK/wf0moTsnAmb6u8yjFk/IwlPU01quOfTcS25HnRZZDc6/DDV9hznp/G7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759414352; c=relaxed/simple;
	bh=wQ14PHbXnmpznc9zmi/+CrYVN4TgoFHRNjEt9lhheyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrmuiW2ZveHxle6fdUnsydW9UegrA7WfjIwyOOB2e6XbWY1Dsy9UIv8CEQpXAfsTP/MlyRs+esuQUKrLUBEDeXiYNJmLL6Dn71AKpm7xR8VmfCWE8GXcT00XkMUlgA/YKRzP3AdID+mUEdVd/JJ0nEm+W/6h5zltmWfTKa9tYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAvrC8Jn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759414350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pK7RryGiFNI3dqfCiJ0uOiLkWQ2Jcw/ErZ/tIXr5pSc=;
	b=gAvrC8JndpUUe6WRX+OvcHKIgvJFfKxRZA68PSO7REvYDb81Rd6rZJO9kNB+3ElU4HyHRI
	htVKt/SeRH4sptalCSqyUVcuxdvfyFYe8hAoaOk5xGCG1JhFmwxUb3RrbYYIkqH0E8TNRm
	9HkDG5SJua3wl1NLCQWSfKPBrgibtho=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-eZiNxOSuNcitLeV5eeIMjA-1; Thu, 02 Oct 2025 10:12:29 -0400
X-MC-Unique: eZiNxOSuNcitLeV5eeIMjA-1
X-Mimecast-MFC-AGG-ID: eZiNxOSuNcitLeV5eeIMjA_1759414348
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-827061b4ca9so193490885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759414348; x=1760019148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK7RryGiFNI3dqfCiJ0uOiLkWQ2Jcw/ErZ/tIXr5pSc=;
        b=Ym9iWjTKBOI8gWLoXB+4PADj0K+1kgBe6Y17UBprs6YEzrHd+hNDS3HSkyXyGWJDbL
         K8bK29+P2m/hZ1IBHcCBkdJPkR34WPnPX+GNjMlnDUF0zjk3A2qYlmEj76ulGociILjV
         H22jOKSciRGBY2RR3TVb1ckBxpGKkO8WStDjUkdAH/ZE4znvIid85jo9gmp01zZ5uEwD
         dxXOCwGxJ48vKGPhzaoul6E5Y9N+3S3w4tTXrc2KEAUw7Kc4LXooH6lBZogUiSDz2rWh
         8BqU2/iHSZ2hmasChvJwHo1B5WRWsPQLcsO09OoJDiG2tBBMsbYPPnPOeq8KGLmN3Eqp
         kS5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhf9O3NN+hgMlZt37Hdr9styQF1y2CZ3D/bb/KnM1pQVjkFDP3muAcOv2EDRa0D47zm+iPo08vDTHPxvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRsN93ja71+I5G/5NBKDNLyx7DiIBuUGQWWJxJIs0nplsb1j2F
	v4bJt6Fn+lMGwM8ekKbjh49KIWKqxtE0tSxiIXiafQAZJWnMBP75n+43PA90oFw/GXWUcPNpkTj
	lz3hBVugSSadkjCkJEvC3H4PAeI/IvtHUuouDDOSJ+TGoCNkBWxN+aDuisn7YIDBTPg==
X-Gm-Gg: ASbGncvB1Hh4RYYEfOJyAE1znaxk2zVNFik1P3mzrPTnc8DhTl/Xj0G0pO0I1gDGE+U
	xpa6ANDLl1MlH6pxEf3J+L807UINLjX1PQaU2M6m7Vx1lEl/jEJ5/S030+M/GKbGmPd/XeT84dr
	kE/3KninUi2OOSTij7VlTWgpQOhYawJnVQdf6CZc7TFjcLjGApjMxzsx7/7Ef44Zh4qAEEAkg9m
	y6UaFsfcM6KWzDFPXrq10addO3HYg+3KPF0boNti+1AUhQ53ASHlq1jdS5huXH4qKvRJDHv85IA
	yYWMlcxlU7CAYs5+b7gKwUl0ADLcQHu7+T4Xsd8Heif4+gjmCpI0spJ5+AIXxJxr3RegNMXqGtJ
	5Bzxv+X3/fbck/NkZngShvxE6
X-Received: by 2002:a05:620a:4411:b0:84d:26f0:613 with SMTP id af79cd13be357-87371450e6amr1081007685a.33.1759414348241;
        Thu, 02 Oct 2025 07:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7NBLnYmHFbnJ/ct5tFBmWuu/9JdpFXW2TqHE7fEMVoC8T3UoiMpOPkGlATLH95I/kPu3FSQ==
X-Received: by 2002:a05:620a:4411:b0:84d:26f0:613 with SMTP id af79cd13be357-87371450e6amr1081000385a.33.1759414347696;
        Thu, 02 Oct 2025 07:12:27 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fcdsm214321585a.13.2025.10.02.07.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 07:12:27 -0700 (PDT)
Date: Thu, 2 Oct 2025 15:12:23 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 04/24] sched/rt: Move some functions from rt.c to
 sched.h
Message-ID: <aN6IR811AtfIUsWS@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-5-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-5-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Make the following functions be non-static and move them in sched.h, so that
> they can be used also in other source files:
> - rt_task_of()
> - rq_of_rt_rq()
> - rt_rq_of_se()
> - rq_of_rt_se()
> 
> There are no functional changes. This is needed by future patches.
> 
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/rt.c    | 52 ------------------------------------------
>  kernel/sched/sched.h | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 52 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index a7d063d2303..a599f63bf7f 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -168,34 +168,6 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
>  
>  #define rt_entity_is_task(rt_se) (!(rt_se)->my_q)

Do we want to move this macro as well, so that rt_task_of() doesn't need
to change?

> -static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
> -{
> -	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
> -
> -	return container_of(rt_se, struct task_struct, rt);
> -}

...

> +#ifdef CONFIG_RT_GROUP_SCHED
> +static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
> +{
> +	WARN_ON_ONCE(rt_se->my_q);
> +
> +	return container_of(rt_se, struct task_struct, rt);
> +}

Thanks,
Juri


