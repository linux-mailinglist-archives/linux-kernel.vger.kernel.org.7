Return-Path: <linux-kernel+bounces-842922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD234BBDFBF
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45EC04EB232
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B827A45C;
	Mon,  6 Oct 2025 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of76DJpu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB7273803
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752736; cv=none; b=M/iDp1k29KvgQN3pdqWWcwxTAZ0K1zMW1SFu5LAl7NeADptzclodO3k5xmBWOILpNsQbN0eVSEzZX/2sJpA2fMt6jA6jMsx8hoN1XvQiF+WxJ/BrB+7OywmRyOVxd1yzht4tP2VwgOx6nMqLKgtPz1mzr/3O8d5gtd0ky5ojnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752736; c=relaxed/simple;
	bh=yaoH4khG0DjlwqNkd7YX3jJb3GPLRkY1UKpAzntpYEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuyGTCPdHFlQRsFJbB+SrOzOnixHBezhSlkvASrg/NqPxoTohrLBpmKt8jFagT4v2qG2/rBeCUmDc0c+Pbvau2Vnob7VwuiF29LVej6lZtHlRS1DP8RiGXAbUxLYsyqNKZ9a7TXHp7iCEMrH1gxpv//+lgRgcs0m4tweOINAPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Of76DJpu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759752733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kw07H6x36aqx01kWk75/03VGfAQh2QY2hSk25YgF/CU=;
	b=Of76DJpuK7tFHlT1q1FE5xY+ztDaUZKrfIKMEENKFjXVsWyfSs4lxZaVe1oc2iEhSuc6xw
	x9K31OC1FMd6YNphiO3XzfgBgUzMUK3nNXHDpHaqQau4Oam2YSqFIT858hMP8bfNq9Xkbq
	8Am0MU6Yyb5U086+YN/c6n7INuTq07c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-dsWMr3kKNeyJIrY3Amuj_A-1; Mon, 06 Oct 2025 08:12:12 -0400
X-MC-Unique: dsWMr3kKNeyJIrY3Amuj_A-1
X-Mimecast-MFC-AGG-ID: dsWMr3kKNeyJIrY3Amuj_A_1759752731
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f93db57449so2338228f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 05:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759752731; x=1760357531;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw07H6x36aqx01kWk75/03VGfAQh2QY2hSk25YgF/CU=;
        b=PK2ixBuksRPbYXst/pW/2Y8Lt/tRZ/k4YR2Jj1soW5rCEiC5qf1vMGcCltq0zBOJog
         /o80gqTbiFZrbofqzF8RhQuqCyteFgUbA4IErT9jbGMz0omA2SZ+q4r4G9vDA9YjbH3p
         xuACOZv9xzA9Lyof/9uSYSC83N4uegAEKMjbtfgdUOzTjtCAIjzR4qhFyOaSBXMXYjVK
         Z7/b/6ZRvvN91cU70WiHB03TpOYk5hPGQ5wQq1j5Osqer2cciDTcumQGmlEXufvJcooC
         zLcpRnVCYjvNdQDOfUs5fAqNlSqofV5uZYAr/quNRe69UQEJEzcyAAhltcnZ+/K4xrFK
         EDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOe9fkGo+qWBCyiUXe4YFLNb/sVNuhvMEW0tkpqc13210zIWzr7GDTdOxhkt8nDhoFrHw/dkf+vAh8Z90=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqwq5necsQz3yrkR8eQoovNuv/KJoiVJ6F+IRnROfT5ASgvR6x
	TNEU6seZB8OdkG/Pl0yi/tgrbJFsi2AqmepWxZGTOILYXXEze912XjUqLYwKGn1aa8ivc2XzDgE
	l3hiZRzZiHn9CU/zBP77RlRZJcwxlT6CYvRSinAupyfsPG8QXQiTL1gcyzZC96g4xuQ==
X-Gm-Gg: ASbGncv9zpNfIG7vaPZCbVwzQi+R4+TcUpdDYigj5W8Q9B1JQFfURuGWQ/chsJokHNP
	4ieq+G9Rjp6pZpBLhVLWT2+MBxcRTNadL1kpSH6EYEdDkSDEw9sr+x4JpQ2FJmZFdteDMQJTnq9
	yIgzAJnTdIzvse8kxwf4UXmroh+wrwm0RfBmWCsBhvs6uz1d+tlu1l1oFYI4D1acxFQnFSmYiqB
	ESVqotfuO9iDAYCIs8N+/HvDHAOdovCB/o43qVN7z3Aa/IMCbKFgSz7j+ujFsMywO/fycWOrnw/
	+OKrhNdYKyiYUe5mEgLqxZMSdR0uxt4g4unJSU43k3nhojWU8TUw+h1q2GmaUKfZwzh4PJGUcLq
	k
X-Received: by 2002:a05:6000:26d2:b0:425:7e3f:f091 with SMTP id ffacd0b85a97d-4257e3ff147mr1236085f8f.37.1759752731201;
        Mon, 06 Oct 2025 05:12:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT3pE7QBaoXj//zl3PFIqhVe6yVrMgD9mgTKp6DhlLo/eugYakVmoXsI42kb9G7RQA3Ix11g==
X-Received: by 2002:a05:6000:26d2:b0:425:7e3f:f091 with SMTP id ffacd0b85a97d-4257e3ff147mr1236065f8f.37.1759752730815;
        Mon, 06 Oct 2025 05:12:10 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.70.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm257170315e9.10.2025.10.06.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 05:12:09 -0700 (PDT)
Date: Mon, 6 Oct 2025 14:12:07 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/deadline: Derive root domain from active cpu in
 task's cpus_ptr
Message-ID: <aOOyF3EvIG5HKEel@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929133602.32462-1-piliu@redhat.com>
 <20250929135347.GH3289052@noisy.programming.kicks-ass.net>
 <CAF+s44Q4SDXPRfYc4Ms5TcJgRU07QJB5H5VOHvyrZ31x9z49nw@mail.gmail.com>
 <aNuEpt8IkvtkH9na@jlelli-thinkpadt14gen4.remote.csb>
 <20250930090441.GJ4067720@noisy.programming.kicks-ass.net>
 <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45e40d5e-f0b9-4c77-af1e-6ac915518acc@arm.com>

On 06/10/25 12:13, Pierre Gondois wrote:
> 
> On 9/30/25 11:04, Peter Zijlstra wrote:
> > On Tue, Sep 30, 2025 at 08:20:06AM +0100, Juri Lelli wrote:
> > 
> > > I actually wonder if we shouldn't make cppc_fie a "special" DEADLINE
> > > tasks (like schedutil [1]). IIUC that is how it is thought to behave
> > > already [2], but, since it's missing the SCHED_FLAG_SUGOV flag(/hack),
> > > it is not "transparent" from a bandwidth tracking point of view.
> > > 
> > > 1 -https://elixir.bootlin.com/linux/v6.17/source/kernel/sched/cpufreq_schedutil.c#L661
> > > 2 -https://elixir.bootlin.com/linux/v6.17/source/drivers/cpufreq/cppc_cpufreq.c#L198
> > Right, I remember that hack. Bit sad its spreading, but this CPPC thing
> > is very much like the schedutil one, so might as well do that I suppose.
> 
> IIUC, the sugov thread was switched to deadline to allow frequency updates
> when deadline tasks start to run. I.e. there should be no point updating the
> freq. after the deadline task finished running, cf [1] and [2]
> 
> The CPPC FIE worker should not require to run that quickly as it seems to be
> more like a freq. maintenance work (the call comes from the sched tick)
> 
> sched_tick()
> \-arch_scale_freq_tick() / topology_scale_freq_tick()
>   \-set_freq_scale() / cppc_scale_freq_tick()
>     \-irq_work_queue()

OK, but how much bandwidth is enough for it (on different platforms)?
Also, I am not sure the worker follows cpusets/root domain changes.


