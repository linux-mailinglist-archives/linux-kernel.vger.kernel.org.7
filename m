Return-Path: <linux-kernel+bounces-800312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD574B43620
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773435434AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D12C11F6;
	Thu,  4 Sep 2025 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YylTH7b5"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB92C3253
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975270; cv=none; b=QodxcvUvGFe9neWvFKloq3ozxEwsVCx/nYr9pmGFvvu4hvsr9e/5L77nEjmH3F5ZhrcJs3HYtvqJbbop5PMhAjnKnDPCVC17CNgWM0MBYJzDzspd58uvoaZRQgNEky+KW/yWyzr/wGig4SW6F+unOhA2mYJBvIAg8fhd/ZpiZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975270; c=relaxed/simple;
	bh=uqVF2zCTVUyeZmwclF2VVh08YFSgsrbhBwwKOCZN2fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/i+EzYGh/DyDtvX1WtHm6eimLDo2jYNi+ekrEtSgyBfpqQCtbfj2cGOeJqcZHuSbi1fkH6Z0rvLCI9l3mXCmYJ5GhJOY7f1XsYEjz5ugDe/RldbpV591X4A580Tw0B9YmaUxA5yG2iKHMFI1xdCa7PSFFI3ZOkbDjOs/qrJ0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YylTH7b5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-329a41dc2ebso504016a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756975266; x=1757580066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yENvHy2nJH2QTtGqh89SqE3NL1bzL7okzcHiQO8V7aQ=;
        b=YylTH7b5sNeU7ktEUg78GRdwEE4F2J44yUpeDYnIq4wXv5ESpTSiOlnHl1kf4vA1wN
         Eqqx0GiP3zDEgHh83RdD1gOU+7+/BKmEEHGQF8yhfVBl2jeqJb7uweKkNYd8DhM7JMbv
         hZjmYO5g3BG0rtYBO6Ph+pYjORfHX12Yyd442ykn7EM82WYdwqseD0GnU3fNGibav+Ux
         80O58WrnVJz7SDeeZt9mTUfDsbd1+qyBznEJqaYplBaWxuIqc/nuerkG1eAsnxpvy/xP
         l+sCfcX0jTQB7wHh9zaluU9oJiW38DSeU/5KVfyxmvnolKQ6/fGbVRJALjwEfmvAP8uN
         ipiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975266; x=1757580066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yENvHy2nJH2QTtGqh89SqE3NL1bzL7okzcHiQO8V7aQ=;
        b=WNX59VMCKWb6X3iWUDUz29PtVYwMbHsX2JZH2+OB2tgzy/Fo0SNgTIMPoPZ87MPp+Y
         z2rJWiCOGypagudzzBLRgFQT+P4m1s+Jk+TlVgOciVVVvjG9Nu5QwOdxKdXaztGCBOqT
         sA1FHQjoyM3ltBz3rflZsgN/QStlvnmSz6tHpCsCPhLIoRVHjSAHvlJm01ehmkS+UBvP
         hrKjL617la2/zqew4pAO9Z/vyfTmQPU2vCrYizu0POM35kuvwAmsq0b1Z5Q+/HWWjdEK
         FUUjvocE3ySIEgF1rxKFYAkQo7JToDavOmTaiAyy60mtXG88tKffWar12TLtWcfc22do
         b7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCW6q9sDa4voSSO2xymaaPATyUAQUYkEYZgTUaIEKWKHqUdVtwcgIpWPPZ8VtKuJEPemL8wz6fEmpQvoCYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYzKoXDwgCwln3/+7zCKzwPgPZyUaIqe04OOCCPtLY5r4UqF+
	vuuz96s6uer/GOi7FxLVoF3qZmM7QYpb+UzIx06VaGy5OJBfPTx63wA8gIRH0UbwTQ==
X-Gm-Gg: ASbGnctsa+cVsvt0+AFEXKAwUT4AoX4MgLV3wfhWAp9bU7W/+nRxM729KHWAPAxZTHU
	zws5DffHhoAhlpDuE0x3zHyWqJ8x1HCLSPhXu+WFh1u7YGuN9H+Yk2AXM7Ad5x0Rt4FvTseWQdD
	+TYevHbPA46/AmuUqrYozKCvgEinu+ZgizlZO47JzMdJlG21/192Blo49NRw9/GBFRNYjC66WRy
	/a9bH8F5mxfusHjEzgRVVtM9DJi3vnBHLw9osU6tLMiT6qKnU04C1zklVUNQUiTZu1Pq7+xbrrj
	8360517fyYlyIeyEH8lSVeKox7QZwvbAk3+uZ2RvVwvO8tX0Hjonh3f7dKAt3yF4DtAPMNp461j
	gfElorUJHyINw6WXRB+4sUAKqk6L5Bpx7eCO7n/wEptLXnmdXoqWT8Hnm2KCw
X-Google-Smtp-Source: AGHT+IHfKDpkAFF6yjvxqglWtDQw2lue3aYCaeJ0+ggkYytXSgQ94Oa8WACkYfkeFk4fjW1nfWinQg==
X-Received: by 2002:a17:90b:3952:b0:32b:87b7:6dd9 with SMTP id 98e67ed59e1d1-32b87b7706cmr4114306a91.12.1756975266268;
        Thu, 04 Sep 2025 01:41:06 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b4e27902dsm5508591a91.12.2025.09.04.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:41:05 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:40:56 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
	"liusongtang@bytedance.com" <liusongtang@bytedance.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"zhouchuyi@bytedance.com" <zhouchuyi@bytedance.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"joshdon@google.com" <joshdon@google.com>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"xii@google.com" <xii@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904084056.GF42@bytedance>
References: <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance>
 <20250822110701.GB289@bytedance>
 <20250903071410.GA42@bytedance>
 <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
 <20250903101102.GB42@bytedance>
 <13467b08-96a6-478d-bb97-060b7d8887e4@amd.com>
 <20250903113551.GC42@bytedance>
 <bb0f7d900a7e50d173ad462c6ed9f64a4b567785.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb0f7d900a7e50d173ad462c6ed9f64a4b567785.camel@siemens.com>

Hi Florian,

On Thu, Sep 04, 2025 at 07:33:03AM +0000, Bezdeka, Florian wrote:
> Hi Aaron,
> 
> On Wed, 2025-09-03 at 19:35 +0800, Aaron Lu wrote:
> > 
> > > [..snip..]
> > > > 
> > 
> > Just want to add that with the above diff applied, I also tested
> > songtang's stress test[0] and Jan's rt deadlock reproducer[1] and didn't
> > see any problem.
> 
> Thanks a lot for taking the reproducer into account. But: To trigger
> PREEMPT_RT needs to be enabled, otherwise the rwlock in the epoll
> infrastructure (that we highly stress) won't sleep. Just to be sure:
> PREEMPT_RT was enabled on your end?
>

Yes, understood.

I've PREEMPT_RT enabled when running Jan's rt deadlock reproducer. I
also run base and make sure there is hung happened in base before
testing this series. Normally, base would hung in 2 minutes and when
testing this series, I'll give it 5 minutes to see if anything abnormal
happened.

> > 
> > [0]: https://lore.kernel.org/lkml/20250715072218.GA304@bytedance/
> > [1]: https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/

