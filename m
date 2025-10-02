Return-Path: <linux-kernel+bounces-840498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA4BB48C8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DA23B13FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B3261B9C;
	Thu,  2 Oct 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYI4osjP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC8D18FC97
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759422814; cv=none; b=AzMnwJZdnNMs75LyMkJ3jvZOa60u4JU50YTaT2svr+OEqWUW9RMOwA/QDAbxOFYWrVPcY0qxYFiVoC8sDSX5rlaMvJLjmfT8cvTi0ekIp8oO93nXLtUgp+4eNMQ6/1pUgWDo6CZMexFVB+96lH8b4PFvCngl8ssJSgAzzxg5/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759422814; c=relaxed/simple;
	bh=w6Vxrk6KdcgYiT6lXdu/kreSX4FHrdn9P+prLxY9ozI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Juc2rANWR+/oE4wJmneKRoUtR9WDiM+xSGNnwaMEuaLl09PTfQ9OVB3vKk3vKn2CR6R2BqYxbcf2tEtntYqrmAjmUu3M7zBt2qlKv/5x4MRnf4SRr5uJH7HNiaxXGasOtoV0g+nN88u312JhpRSWTGmAEbvAzOkvrCNDoylpHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYI4osjP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759422811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YdR3NzwrosX/m8eq+tUtYGt+iZF+C/ngXCOZthrJPXY=;
	b=IYI4osjPlywc1+Hz2TbYukWX2M/K3n963Z+kRG4GtWFoKRZBUI/40IHJ72i6ZbDPrAuYEl
	dOCSX7GEOqjFWYuvXwkgTUSYIIq/0g+fUpTG4vtPbx5TK871ahH3lQ6F/kxi2PKd+0UsP9
	g6aG2NJ6DDnlwWvPfFdXiLxSLpn0QiI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-IJvQo6zaP7KOjg-a91uQMw-1; Thu, 02 Oct 2025 12:33:29 -0400
X-MC-Unique: IJvQo6zaP7KOjg-a91uQMw-1
X-Mimecast-MFC-AGG-ID: IJvQo6zaP7KOjg-a91uQMw_1759422809
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4de53348322so53518941cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759422809; x=1760027609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdR3NzwrosX/m8eq+tUtYGt+iZF+C/ngXCOZthrJPXY=;
        b=iNrj+F18fwkUa6uiZhxyoNjnFvLHXgNsWMWXqohKDi+FnGDXJ0UoGSuUC9ST1vWPHq
         C8Lrmku7HhK4Oiu/tAykvbeiMG2ZiQ3CZSk+96CRolfn62Py+l9v/UHQoBR2T6mK9FAN
         srC1hoPuQoBLyGfiaP/p/CzLUwGHRWtPSsuH7Z3i8fxUmHg7KJ4bC/B6QoYbwoVtzf04
         ICfCL+AAjR9RDUK3Rth7SxAL29FCCXWUfwvF5GtzoF5LSslT+jqt0i6kx8BGJ2kngRS2
         w5Z9HrfK7ljLg6iyuxyMNZZg4kjCxvhb9Qh35AvLhOUYdk2znFcGhdc87KKks2Tj/F95
         K/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH+XxRJqlVrsZjSXE8a7rpWb8Rc+UayNUGcRYREl0xWAX8PUCnDaWOGet42EwIXS3jJdE6Bq8gGww2HH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc8lnvHUdCC9LXGC657gLb3lnCepjXiGxXK0qKdlCA5hn/72/j
	k21QiRL/9Q5TjJn3vG3BAPYG/Ij8fYVc7EbpLR42kFXPzybET0BYqsh6lNloKwIKMo2LZZfseVl
	om0cpqZcJDZ50oVAmyizc5adg95nzgCMlB6SfnkygwPnsxwAzKi8pr+pn4CXajxhhhA==
X-Gm-Gg: ASbGncvDtDMpV7yaqd3HsoAeBe1pLiDZ5R2YET7YOMZSpbL1Q3XM9x73kXaRSFUwAdr
	Cx2bGrLxgDxYuBLLPXWw0+gCjACJsADVNKGfl9GkImv9pKFArPVGWA3dRBLaI3X7kNTpcSQfkVe
	TTDUXf51z/TugIFmsNOa6djFm9CgmRon+Y/fdWjkR5dNgJ1TQH+Y7ylYad3YgEoLcOKiLts0RK9
	83koVYw7Isf1LOsw0ZVPt+HDPW574/z34Fa0FUdKwy8fCF/YHu8MWb0g6xqVCHTaGmOWlO9RQpe
	Mi/E+rIVG8YROLKpat0aoCPs7Y4tesPP5xWS8TcQB3nnvH5cVg1E8prfh6pael6I9O/D45kd9PM
	+ALiUpO34T3rxNBURV16WMzmB
X-Received: by 2002:a05:622a:1249:b0:4de:10a5:2c7f with SMTP id d75a77b69052e-4e41eef65e3mr124173091cf.84.1759422809211;
        Thu, 02 Oct 2025 09:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9XFDVHze3B7gqhGWPlrpQWvqd3Rxv66AFPb3iUUWuRrW0a/a1sVRExcO2QP/ShbWzAgM7Wg==
X-Received: by 2002:a05:622a:1249:b0:4de:10a5:2c7f with SMTP id d75a77b69052e-4e41eef65e3mr124172541cf.84.1759422808769;
        Thu, 02 Oct 2025 09:33:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777892eadasm236072185a.39.2025.10.02.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 09:33:28 -0700 (PDT)
Date: Thu, 2 Oct 2025 17:33:23 +0100
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
Subject: Re: [RFC PATCH v3 07/24] sched/core: Initialize root_task_group
Message-ID: <aN6pU3aBYT5V81jE@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-8-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-8-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Add the initialization function for task_group's dl_servers.
> Initialize the default bandwidth for rt-cgroups and the root control group.
> Add utility functions to check (and get) if a rt_rq entity is connected to a
> real-time cgroup.

It's a bit of a nit, but this patch does quite more than $SUBJECT. So,
I'd say please either reword $SUBJECT or consider splitting it further.

...

> @@ -3077,6 +3078,21 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
>  	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
>  	return rt_rq->rq;
>  }
> +
> +static inline int is_dl_group(struct rt_rq *rt_rq)
> +{
> +	return rt_rq->tg != &root_task_group;
> +}
> +
> +/*
> + * Return the scheduling entity of this group of tasks.
> + */
> +static inline struct sched_dl_entity *dl_group_of(struct rt_rq *rt_rq)
> +{
> +	BUG_ON(!is_dl_group(rt_rq));

BUG_ON() should generally be avoided, if possible. Could a
WARN_ON_ONCE() plus returning NULL work here?

> +
> +	return rt_rq->tg->dl_se[cpu_of(rt_rq->rq)];
> +}

Thanks,
Juri


