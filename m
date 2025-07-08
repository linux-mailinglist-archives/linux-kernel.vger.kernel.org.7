Return-Path: <linux-kernel+bounces-721481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37662AFC9CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9F3B30F8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187762D9ED2;
	Tue,  8 Jul 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTW/vkwS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905682550D2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975072; cv=none; b=lP6hNBwU6+4Sr29drJDoXTT1fKIkBTe1usIBpgkhuTQP6sFrQyzox+U9XcvT34awQphMlmqA8mcWkZt9Z1uekmTc0fZdSbRM94f+e4ZdGW+cnDqs67kSv0Mf70ZKQHaES9+E+n36Ic0nyDv8H4iOHPmbB62IcIDPpicsDwn4Lq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975072; c=relaxed/simple;
	bh=pL9rmfJsKvRYfQyNEOmEdzvoqUDgB7LsXNxd2rgrLfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZGoOYW40BpGbUr4zy7NB3h40U+6SxlByTCbHKZeVzRCrMB2gOjRHbx/NlOXoSMLA8A3VH23nkCK8ugm5D/myQPK3qfRXeG07mEh23lHTiVmOMHu+PuFJw1jyB2MafmCGdfgdKo+2N8rjxCx+dUlLmSZWYygktxY/95qv6kmemg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTW/vkwS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751975069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuuxA3sNaMM/TdNAzR4QDI0SymmoEq6hpQp3Rqw/59Q=;
	b=QTW/vkwSbE+nuNtCbjsccNG41DFzOJ7SiwDIK3TUQvbkFChhSfetHr5S2L7YrxT5hzeBMp
	m/+shooBSIh7kI+OwfVNhcxgeSUkbh/1RQ+Y4y7WstAbthT3IctwPCipS+I1SAbQ1ZkcJB
	bUOOuqiAkRlC5DhHmzFwd4CrjbqQhGw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-GQZNVHBuMCaNKj61Hi9JMw-1; Tue, 08 Jul 2025 07:44:28 -0400
X-MC-Unique: GQZNVHBuMCaNKj61Hi9JMw-1
X-Mimecast-MFC-AGG-ID: GQZNVHBuMCaNKj61Hi9JMw_1751975067
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b4a0013c0dso972635f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975067; x=1752579867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuuxA3sNaMM/TdNAzR4QDI0SymmoEq6hpQp3Rqw/59Q=;
        b=I1d1K0SyMfW0T/A8A9hdYznLsZuqg0XcKBYwjst0fEN7hTCchRSe4iYXFQWdn995IB
         4YupM2cz1z4nBXQVmhOUsFpaV+svZF75MsGCZq/FXF0NUsjdN3Jh1GPNVZnndZLQ0znu
         lo0f/wrmc6uxalUI1tf3GSon2hMnRabYrlXJvH8da+fTgtRGaVS7AIo15zo5G4kQXlVJ
         B7HpzjfXhu76Qoeerpw3HefSN2d2NIF2aKt4juHMqVmNJJbLvN7OFtIW5Ytv1cHIi5PE
         2m0YkupeaJkSvH9tVRFK9cpA/NA/2dD6jwatyRoISjr0jvaacwY5yFLNgEuU13bVlbQA
         z7UA==
X-Forwarded-Encrypted: i=1; AJvYcCUB4ovc5b1lf0varsx1JXk5vDPhvjOTe9GuKb/YNlprbxbthaJ2CgjpsVxrDWNmH7iLwrmA/V1oiFbZsJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzSMMameZVDglIDMtSsDzUSKyc7Wy33DNKFLtG7wVL5Ly5UHA
	FqSProK8uOyasY3d+xtXO1pda66XqFMqi8WJnJq7SgAY5vZUzgXculigjsN4i1aA/CoGD/kYwJc
	jsvt3/leqIQiSGBz2zuwnTANN1XabuaW6/2kI49BXiL/2CvXd1rP81/VjPIq3N5C87A==
X-Gm-Gg: ASbGnctaHnQ3d1tY03l3V5QCHZG+0pwEYKypwCRI1LhDFWld2dG+o0MpK6Ipx6dXzq9
	o3o37repvDXtOkcTX6rlaRNvzaZ11715CHCejVajamPuIeJ98C3K9XZXCxpbRvQIdSDP8VM25g8
	A0CQtNRAYE6F/rbWvYaHeda0POwEc2lUs90b6ljimIWqusqgwNvBZ/LD353cqubsZ+fX13Slp6h
	Zb2qyN2R7SvET2UoKKpISTgkBNQOjUz0Dm5lsz/u6xilb55SqxiZN4FXTo2mKg1nZvPlc8V2Kz4
	YzE/1HBTQnimP8eJ2AgdK71R8kqjvamX6Zr1+BKKUh6/u3buIaOE+pyPrBzhgatCteu365i44KN
	p44OCYF4=
X-Received: by 2002:a05:6000:3104:b0:3a5:3b93:be4b with SMTP id ffacd0b85a97d-3b4964c61d8mr12926271f8f.25.1751975066870;
        Tue, 08 Jul 2025 04:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiLo1zx5OxYNQKDz3UvJne72gLe4O73JBmF0OpEUs2KEiCASOUEfHCjYsExNWGMd9YCQY4cA==
X-Received: by 2002:a05:6000:3104:b0:3a5:3b93:be4b with SMTP id ffacd0b85a97d-3b4964c61d8mr12926254f8f.25.1751975066374;
        Tue, 08 Jul 2025 04:44:26 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4943bdsm20055205e9.20.2025.07.08.04.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 04:44:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Leon
 Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org
Cc: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, K Prateek
 Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v3] sched/fair: Use sched_domain_span() for
 topology_span_sane()
In-Reply-To: <20250707105302.11029-1-kprateek.nayak@amd.com>
References: <20250707105302.11029-1-kprateek.nayak@amd.com>
Date: Tue, 08 Jul 2025 13:44:24 +0200
Message-ID: <xhsmhldoyq547.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/07/25 10:53, K Prateek Nayak wrote:
> Changelog v2..v3:
>
> o Added a check to skip uninitialized sd that can cause dereference of
>   sdd->sd beyond the percpu boundary (reported by Boris).
>
>   Tested on the trivial case using the QEMU cmdline:
>
>     sudo qemu-system-x86_64 -enable-kvm -cpu host -m 20G \
>     -smp cpus=10,socket=1,thread=10 -machine q35 \
>     -object memory-backend-ram,size=20G,id=m0 \
>     -numa node,cpus=0-9,memdev=m0,nodeid=0 \
>     ...
>

Urgh, of course directly using @sdd is not like walking up the sd hierarchy
where we end up getting a NULL sentinel... Sorry for suggesting that and
not thinking about that "small" detail, and thanks for being on top of it.

> ---
>  kernel/sched/topology.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index b958fe48e020..e682bf991ce6 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2403,6 +2403,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>       id_seen = sched_domains_tmpmask2;
>
>       for_each_sd_topology(tl) {
> +		struct sd_data *sdd = &tl->data;
>
>               /* NUMA levels are allowed to overlap */
>               if (tl->flags & SDTL_OVERLAP)
> @@ -2418,22 +2419,34 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>                * breaks the linking done for an earlier span.
>                */
>               for_each_cpu(cpu, cpu_map) {
> -			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
> +			struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
> +			struct cpumask *sd_span = sched_domain_span(sd);
>                       int id;
>
> +			/*
> +			 * If a child level for a CPU has already covered
> +			 * the entire cpumap, build_sched_domain() for the
> +			 * domains above is skipped. Use sd->private to detect
> +			 * levels that have not been initialized in the CPU's
> +			 * hierarchy and skip them.
> +			 */
> +			if (!sd->private)
> +				continue;
> +

So this works, but how about using a cpumask_empty(sd_span) check instead?
It's IMO a bit more future proof than relying on how sd->private is used.


