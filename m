Return-Path: <linux-kernel+bounces-648595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDFCAB792D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 00:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7FD4C6DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02D5224AFA;
	Wed, 14 May 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JT9NQioB"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9E21C163
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262913; cv=none; b=mcjFG7kFEi1B6o19wVm5YCJpPzSOERNGRkxfDqBO7/SAiz+dYAZProgsow6t796Nu2GEIengUDtLBIOc6M7mzlZjdCYduWILAjUNLWjfrg9FxHE8WVcsajoifEl6W/O6+O3ocCjvOLD91QB4g83SYL6Bk5PfMOu0OGn36BzNRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262913; c=relaxed/simple;
	bh=fw4ASR0dC84nfQEf3FUe/wm41N26f7aWrG3iJtseeR0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eveXQBrfXX5he78flGz7jICgGoUT1+Yrlsm7azQ3nFuQn5m0ByOihI1kHvA7L2ZPSGmO8bdLjhdkBJIJQXTe1JM/vwC61j1+57iwMbit4ILAMgN9HU+HuNGzKk6IV11a0eY9DkySGA3ItN/TxVhzyiUQgDdIku1y5mcvosmg/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JT9NQioB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30c1c4a8274so322306a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747262911; x=1747867711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UgYJ+Uk5kzzZuLLJjG5/CvuJkRdqBhrdQNgIB/qPRsA=;
        b=JT9NQioBd/xWwaOrtayCcz3BLySw6ZeAsts9BDUOwtyBSpKcCgveom/0LKwo4KlSsy
         GRGnmRxx8OrnRUxaYDsBB6kiEqvngGZsyt3WkmFlQx25bTavzKSdQ+z8gponfkQ4E1JI
         sk9ZG6zi3cJZ/atzqw9KA0ISIpduqFSaUYrECKLLuleJx8hSitSzJX/fTihtk0grgvlm
         sPhx0PaWhghKeZarEQp6bdgzYghc2uZHnBHHC3u80M7kkNu+8LLBhqpx1vDbBELR18eE
         GjO9H2v/R8L271+ghupAqx6ddC3pVt30NcOuJblzZQv0Bc3I9SSaRIXoKJ2PPmVELYlz
         QVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747262911; x=1747867711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UgYJ+Uk5kzzZuLLJjG5/CvuJkRdqBhrdQNgIB/qPRsA=;
        b=DW1jxfKvaBy08ZtOcRFAPZjJjZJF+ZnPrT+XsTf/ez8G7LHmAzHrVswunevmNaQffl
         Tr2aZT4U4KcX+othXX8JsHZNlQDiNx5SRnBUcLk8SmLC0k16Xvt4/IWxibdDeWtOwiIv
         cPnZPrGaRtFWexlquQbr9h0NTvVFafPXxSQgIvg5PLYb5RoaKi1GvyOx9FB5sTH+hmn2
         FJL0Y0FbCf1gx2NNFkXojYfQt0MAYZ7gNXuthdLByYlzlh5Lwl6qLul5HZPyj7XNRFAQ
         8AunAj9R9Qx7x5OsCKEnAUFpwEMMi64sD5yNVAL0yx5LG3fsYjQbRYI5skSRVodK/K3O
         H0lg==
X-Forwarded-Encrypted: i=1; AJvYcCXnKr1DCuNmqc/SMwhyEI0BkhNy+fdE/9IDww9kNFxfzNJJhL4XbiZnG27K3IpuEIe/7T+1bbTj2diMI+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRn+p6S4S64LTqY0MBt7NFRwQ21Z3pqBMG3RAgXA+P4FrfXEJ
	F2L0wxyN3g+9TMtKrmYEe3kzmEBrL4kznLiZgKXAwp2jB7QUMXQzPhxG+doJlSJeZb7TdJ6mKBp
	Z4A==
X-Google-Smtp-Source: AGHT+IG10+Iq5L5Cda3ijuQh+2a54en45CtzZHeDe6mY71MnV/tUAELSpjY7VbeAe1Lg4OZmV0PYigFgkQQ=
X-Received: from pjbsh11.prod.google.com ([2002:a17:90b:524b:b0:2fa:1803:2f9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b43:b0:2f6:d266:f462
 with SMTP id 98e67ed59e1d1-30e2e68a300mr7400689a91.35.1747262911047; Wed, 14
 May 2025 15:48:31 -0700 (PDT)
Date: Wed, 14 May 2025 15:48:29 -0700
In-Reply-To: <20250324173121.1275209-2-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-2-mizhang@google.com>
Message-ID: <aCUdvaM4xkLzRF8J@google.com>
Subject: Re: [PATCH v4 01/38] perf: Support get/put mediated PMU interfaces
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> +/*
> + * Currently invoked at VM creation to
> + * - Check whether there are existing !exclude_guest events of PMU with
> + *   PERF_PMU_CAP_MEDIATED_VPMU
> + * - Set nr_mediated_pmu_vms to prevent !exclude_guest event creation on
> + *   PMUs with PERF_PMU_CAP_MEDIATED_VPMU
> + *
> + * No impact for the PMU without PERF_PMU_CAP_MEDIATED_VPMU. The perf
> + * still owns all the PMU resources.
> + */
> +int perf_get_mediated_pmu(void)
> +{
> +	guard(mutex)(&perf_mediated_pmu_mutex);
> +	if (atomic_inc_not_zero(&nr_mediated_pmu_vms))
> +		return 0;
> +
> +	if (atomic_read(&nr_include_guest_events))
> +		return -EBUSY;
> +
> +	atomic_inc(&nr_mediated_pmu_vms);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(perf_get_mediated_pmu);

IMO, all of the mediated PMU logic should be guarded with a Kconfig.  I strongly
suspect KVM x86 will be the only user for the foreseeable, e.g. arm64 is trending
toward a partioned PMU approach, and subjecting other architectures to the (minor)
overhead associated with e.g. nr_mediated_pmu_vms seems pointless.  The other
nicety is that it helps encapsulate the mediated PMU code, which for those of us
that haven't been living and breathing this for the last few months, is immensely
helpful.

> +void perf_put_mediated_pmu(void)

To avoid confusion with perf_put_guest_context() in future patches, I think it
makes sense to go with something like perf_{create,release}_mediated_pmu().  I
actually like the get/put terminology in isolation, but they look weird side-by-side.

