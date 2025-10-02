Return-Path: <linux-kernel+bounces-840435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469F0BB46AB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD193219F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C32376FC;
	Thu,  2 Oct 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMl3xww6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583EA224B04
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420701; cv=none; b=Pw2h5dKSMaVmTF2u4uK7hxGDEEFZQI/ues/rL2RAYvOYr508N/WMve53rNaG6C6B+4cBykKwB7eEJEeiT4Jj+1yYBsokarRkduxph4w/N6/CiBI6TH/6srt40yc3CF1guF/ASfuELXak/IgZ1+20GeV7Ae41I7LfX5RCrBVWny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420701; c=relaxed/simple;
	bh=QMXO1ARpFj5i2tdQ8iqyQ3i5TkqMbm6+iJ72s+a9dxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnId0Sb9vqor8ezi8zBK6CE/mkiiPju2yMxNb/ohCVSzJHNBKWEljwZWrz6rvDPsBu/CR/HuyooOzsHBJkI6RfTCNPpEUsFWYQPypTTUhx2ZeSlQbRF6uBACvn8/5zLCs6SKJfr8U5FQSY4Um/g3fJmxyZYIgUc+2gjeVGsrvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMl3xww6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759420699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXBtpwETLI+jBpdu2E2601YOaq+kblf45T0yBW94FwU=;
	b=AMl3xww62DQBykos6tCm2zhd7EjoMLtHwdlZzuz1I+fU5X1wnAwAlS2iajxCCfxkXLyrkM
	gPEQ59dD1s/ZzaVm75iUIulaL6FMt6jhC9Yg9oRsEz2BnWTdVEec3TgEtmaJfdI7WVKySQ
	j+uX85OK1rD8SdyhaTuNGjMcdAk9Wlc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-YRxX-TthPtWxR2GGy_76Og-1; Thu, 02 Oct 2025 11:58:18 -0400
X-MC-Unique: YRxX-TthPtWxR2GGy_76Og-1
X-Mimecast-MFC-AGG-ID: YRxX-TthPtWxR2GGy_76Og_1759420697
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4deb67c61caso34194331cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420697; x=1760025497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXBtpwETLI+jBpdu2E2601YOaq+kblf45T0yBW94FwU=;
        b=v9hN7a9f+wNm5pfmYDs23+h5v7boNF3f/3Nig0XH4F2k190GIMIGu9XrIp2UCW3tE3
         lkoHr3enoMm0gB7sJVmtr7L+3aEmMYdWe5OB5GtuC9l6os1xTmJYHTgXVB/OQSzPROHG
         Rl2jRtM1Fqle5ZEywNSGnT4lGfIer2LYihi+m8NpsYAMLapesl5pNm8NEIRpBQTzSmQu
         HK897Ru/F0gN7Ud2kllOrMTA0HudnDdKUzNdyS86HZKzKhBe9bvYHbhUB+3kbQ6Lfcvi
         CvJIRiwrnOazWrDOh6DEWtrQrlvCxbETbBmpINdrJSW7u3Kz6UM32jXgzKQnqmQVuBKu
         1dvg==
X-Forwarded-Encrypted: i=1; AJvYcCVoq2mdYxykFwML4ztAoc03XTg6chSEyXjeJanr/YM+iVTyQBRAg0+ldM/pvvRl27Vbn67IjOqelBCbjIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz58eImFHrOksw4Dq1g0WIdYLtQ1e2Hl9G4KlBTtTzB7J/1JdX
	EVYim2QQCKJW1XBU2+5RK3cqD8YWohMPkjBMOFJIc1/D5Jc6KPBM72kNVwETvvsCJ7udawSogwh
	yQaWAMRIZDzjboInv1Q57PAxL4l0CE6Xe87LHzU2sETE29rjfPo9kEUiy3FRcx7Gm2w==
X-Gm-Gg: ASbGncv1SeN0mOl1AKJoJf3WvJXTIAbzQCEENGCynsNiPhh00e59eiRf0DnxOobVhbN
	t3hoeB3ZE8LjTR0wwzBue51l82ZJtbUr4r2+zGR/KKV5DDOvO6IL9qpaXVAS1qJ8YaVx9iIeFDo
	w/SdsTBSR4sH9USORgHuZMCgS3a5HXjAqM/+gZmmWuAyUDeAHXiXh2TsZQgucrrl43QI4Jdh30J
	tywXYKY/IDN9ulMtVBtcAuy262jLwYw7FhRQkpeArlxgxUlKThDZM0wiTbTzmxOd8bYqZaqQOPP
	NsVx29YbpKjTJKaFyIlTf5ySmHK94Pf9Vt5zWGuQJhT4PsTafs8/9fD+UAsr57T3JA1B3e+zsTH
	AW+duREpx247z52RTMf2ms1DR
X-Received: by 2002:ac8:5d07:0:b0:4dd:e207:fc7 with SMTP id d75a77b69052e-4e41eb10860mr103518091cf.72.1759420697404;
        Thu, 02 Oct 2025 08:58:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo2lHi3yp0+SiJkdd3C2ZfXGjc5+3r/yXfS6cOTJQiNLBY0lzKQJBvRbY9azRqWQgd0XQN4w==
X-Received: by 2002:ac8:5d07:0:b0:4dd:e207:fc7 with SMTP id d75a77b69052e-4e41eb10860mr103517671cf.72.1759420696886;
        Thu, 02 Oct 2025 08:58:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-6-60.as13285.net. [80.47.6.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129478sm227641885a.1.2025.10.02.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:58:16 -0700 (PDT)
Date: Thu, 2 Oct 2025 16:58:12 +0100
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
Subject: Re: [RFC PATCH v3 06/24] sched/rt: Introduce HCBS specific structs
 in task_group
Message-ID: <aN6hFCYJy-XjROFP@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-7-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-7-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> From: luca abeni <luca.abeni@santannapisa.it>
> 
> Each task_group manages a number of new objects:
> - a sched_dl_entity/dl_server for each CPU
> - a dl_bandwidth object to keep track of its allocated dl_bandwidth
> 
> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> ---

...

> @@ -467,10 +474,17 @@ struct task_group {
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
>  #ifdef CONFIG_RT_GROUP_SCHED
> +	/*
> +	 * Each task group manages a different scheduling entity per CPU, i.e. a
> +	 * different deadline server, and a runqueue per CPU. All the dl-servers
> +	 * share the same dl_bandwidth object.
> +	 */
>  	struct sched_rt_entity	**rt_se;
> +	struct sched_dl_entity	**dl_se;
>  	struct rt_rq		**rt_rq;
>  
>  	struct rt_bandwidth	rt_bandwidth;
> +	struct dl_bandwidth	dl_bandwidth;
>  #endif
>  
>  	struct scx_task_group	scx;
> @@ -817,12 +831,12 @@ struct rt_rq {
>  	raw_spinlock_t		rt_runtime_lock;
>  
>  	unsigned int		rt_nr_boosted;
> -
> -	struct rq		*rq; /* this is always top-level rq, cache? */
>  #endif
>  #ifdef CONFIG_CGROUP_SCHED
>  	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
>  #endif
> +
> +	struct rq		*rq; /* cgroup's runqueue if the rt_rq entity belongs to a cgroup, otherwise top-level rq */

The comment really wants to span multiple lines, maybe above the
pointer.

Thanks,
Juri


