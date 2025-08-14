Return-Path: <linux-kernel+bounces-768297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 030F4B25F72
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C4ACB64A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A523D287;
	Thu, 14 Aug 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuVReLob"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D5820013A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161203; cv=none; b=U1AyeObLSqPrRKZWKDJuJKVVwoCLceJ2pJM0VC+DaDUkbA+3nF5IjNBRU9nz6G3xPBZpDrp/adGjwm2SA/mPw5fnODlInTdM4ge6xZkgHvBy6vMe+EWHbHPjOBrnZa9WrbifUNvhN9hWftJGglGg/FDXVxI0Ng3X8rI43xKIwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161203; c=relaxed/simple;
	bh=nkf5Kv6sh59NWPCgxO5gwvDP6PYDVETVqOs8Tzl+4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgkH7KqYfxAipbzZ/EfjwRx8ypX8aPWQ4i5BYJYddKNLzfbyALgYtguvjaN6BzhETH7J/Le8G6lWt0ElbMaI4glvoSWbQ13u48hkrzSZ9NNC/b2SuXmf0nlfbvPOh7WQ1X3XIM6xKD01Ub3UwRH0nCZqmUDLet09XZ6/JOrxTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuVReLob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755161200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnedLEQut04nXYZ6pySdP18cN8eWthaIoK2HqFHHYbU=;
	b=HuVReLob7C/6t/zphROpCzgWivKMfKOFlWkK3eH6X77tKl0IhRj3J/EWyXiFI6rlKDur0S
	SG/ADPutxuv8FSJZU3TVOxvZNPH/o6KiZgJs8B9zYa/3spFceD/rRFVR7EcsCq6NOcpGUS
	htp0jclDd+m9+NGMhXeEj+ek5b/Fi4A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-dow1iXJ4NUKu6-UUnKRFEw-1; Thu, 14 Aug 2025 04:46:39 -0400
X-MC-Unique: dow1iXJ4NUKu6-UUnKRFEw-1
X-Mimecast-MFC-AGG-ID: dow1iXJ4NUKu6-UUnKRFEw_1755161199
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e8705feefaso191053485a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161199; x=1755765999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnedLEQut04nXYZ6pySdP18cN8eWthaIoK2HqFHHYbU=;
        b=lyeds7BuA64djFY9mgTajDd7rfKgCyWzHVoko8WbtYr/oyQq3qwK8Ep3OpYon8A4Mm
         l23oI2W17FR0EF9UHpE0GQsYRgwthzmTcInaEd/51PLeUC3IGyNGIHtKaVqeezbceqgG
         Y+TL1WYUTVPKB+jhiQA8PxMfPoOtZUKub5kfCakxV9Xlip3wI8dIXgCIS04jWCnw5nfp
         RGO2YHr+w2Q87t1M0Q0hy8r0okNG/hQRC1bKw9i0VP80dSBOZe2RK2x7ZSXEAb5wcHFg
         LEQ9entVTwN5G4/8yQgF9gNOl8QSGWZ0oWZjT1qmQdQfz76aWy1QW6uQ70lt5WHqPRU7
         XbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsVGu5Cut4Dv7eQ8NhQhTVFpDD9vg0cMi8YLW91DTVinNT70fDKwB6lerCKByDE2MiTLicXenaQeu7iIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUMK02OK/ZVTFAAGxznsRb1GcDfB98Nuqk4uBqIinU3gVruZR
	Hhg8hYdKeqvpKIFL6rd0YBe/iawmcYrJBVSJCV6xhUqC2WAfESAYBTSLnoXApc86BC1/Xc8mNoF
	XqZTd7aPz26wJa6du9lTz44KV98BiqQnJHmb410imxOB7/IxfOVyczX7E5SOVPQXdPQ==
X-Gm-Gg: ASbGncvx3s8ZfmPAfwm9cBgnXoBsEMwzPtUqFURnzBaHqmGUNPYYOMjf19Luvr9zt4w
	VY+YyCP80r3XwsBP5p8IQGTXJ5nIuyJtWjmq1u+ZeVY7dmcY3naQ/4P5aE7+xW+3KRBZvtvJh9b
	6DsMhXcr7Qi0admA4Z3Ca1KsqXDlxlrNmDGKnpztabcJJA/3pSer2+Xr1WJh4xDgrvkHQwiYKws
	Zpp+RLwCA0dWHuOeffO5ZQ5tIyeGeWE/SVcxYkHeiMzlL1hvDMWUJimZN4QI87Um5mkMz/GUHIJ
	VYyeeW8hJF2UjRwSvtX1i7/hw6udQ5Ir/hFFnPz8j7C1SpX5Zy6NCBtccIPqxBFk2G84
X-Received: by 2002:a05:622a:205:b0:4b0:6da6:aafb with SMTP id d75a77b69052e-4b10aad17e7mr27403301cf.19.1755161199139;
        Thu, 14 Aug 2025 01:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF657St4z1hCJRc4ylw2YOLg5YWIvNkjJ+QuuTl3Mk0KpaDhti1jKf2ktN3PMQvhdp43xxWEA==
X-Received: by 2002:a05:622a:205:b0:4b0:6da6:aafb with SMTP id d75a77b69052e-4b10aad17e7mr27402931cf.19.1755161198481;
        Thu, 14 Aug 2025 01:46:38 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.57.34.72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b06787441fsm153973501cf.28.2025.08.14.01.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:46:37 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:46:30 +0200
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
Subject: Re: [RFC PATCH v2 04/25] sched/rt: Pass an rt_rq instead of an rq
 where needed
Message-ID: <aJ2iZvioSRRlu_vE@jlelli-thinkpadt14gen4.remote.csb>
References: <20250731105543.40832-1-yurand2000@gmail.com>
 <20250731105543.40832-5-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731105543.40832-5-yurand2000@gmail.com>

Hi!

On 31/07/25 12:55, Yuri Andriaccio wrote:

...

> @@ -383,7 +383,7 @@ static void pull_rt_task(struct rq *);
>  
>  static inline void rt_queue_push_tasks(struct rq *rq)

Can't the above also take an rt_rq?

>  {
> -	if (!has_pushable_tasks(rq))
> +	if (!has_pushable_tasks(&rq->rt))
>  		return;
>  
>  	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);

Thanks,
Juri


