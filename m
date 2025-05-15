Return-Path: <linux-kernel+bounces-648616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B746DAB796C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 01:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869981B6801A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 23:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7B226545;
	Wed, 14 May 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNNCtkJm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB06A2153D8
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747265052; cv=none; b=uf5Spsp++FUFU/KqKL9xNtXv4a/UcgBtWpbCxkwOl+NGeZlJPtF8MDAcSxuE41q+FluRmCUy0zTKZr/5hhyVClMVnZce1TWz7H6o9z7KzPuwDmvvccx0AWcyQVUc+57bTvu6058dEvCUkFh9esXwsg/ke3br7uCVaRwRbaahG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747265052; c=relaxed/simple;
	bh=Nmp9kwZTSuh5uyM03fYV50SB5KKk+Itz81IL9dk1N44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J9LzX9hxrt6MiOhZCf5RtRsEiLm9er/SqX1IVLJDY21IiV9kEea2bITtRpQ7JlRHYiZQxcZiq4mokVmdcfIOeT9NWBzLshUerO26Qm+Ed9wTe3BjuIVbjp5RCz+kD6HkVJ9jnqYumiRHo+Zg4Ajs0r5fc2ltkNzSnnpTHeNugz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNNCtkJm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30c9b0aa4ccso321467a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747265050; x=1747869850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJfnwMvDMyYbKEUav/eMFbw+CnQxNcQAe0tdAXtp/6s=;
        b=CNNCtkJmdUPTKbYOgJTvgXIRMaDPveFFXo21OrZuLlATM30XT6d3o6AgTpA14LZaoF
         RK7+sl1xc5biU9gfbAUTACQ3Wbhlh4pOR5uSmC7dZGKH+XVAOaT0r3osiJrLEfYkyoAg
         9fSyJVOyUfdWLxBmF7xU7NpuTmsS9JBoyuFDNFCBL1aziqyenYbsCWiBxUk4/H2YBMGM
         f4PxG0X3JVqqZH0LyYAaSVX7EK7VcEk14ueeYg6vRZoGf+wsmmnysPMlSdbOO+Cdi8lQ
         iRdqnJPB+WLfakEdczmdgUlSlFeQ9+XBPaBzXYw1T2VdrpmJU89+SVa54rZWDFmN+GEU
         hW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747265050; x=1747869850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJfnwMvDMyYbKEUav/eMFbw+CnQxNcQAe0tdAXtp/6s=;
        b=Hbd7xss553FhRfMGUMQ9joRLiEx5Nud/C7x2JwIgP7qAsAohcKqyDzKavr/ZmxmcqT
         MRZgZvw6/iTlId8lCVPkLJ8of+kjug0GeQujnTW/1afe2Jf5NMr58+BTeqiyPX0ciUCl
         y4kqVAxWMMVVHzN/qW1/b6Fp8taLxBlyO65nwMV2hjXtJZBGfM35WhXXKWLRTvKD5N/3
         sDscBdsdYE2+0ZRRjK9Aatsjfr3lsfBPqwN9G06oEm3JChh/8aRX6w4c3k7CF1wGsDbj
         URKlTu8ajSvdW18C7K4/9sqkySXS7VwlALbU3x+B+VawMpcn+rgLBQ5e0vgo8TziHf5s
         0UBg==
X-Forwarded-Encrypted: i=1; AJvYcCVd38esMAlsvAjwFd06yN+BlNE0OzDMinD3lcD9ZFJuYyMD7jxt7YJm2qa3mfnoSdEbMBYEHx2XoS07G8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrRxbl+rp8QeoM5YFR6aQmJPIVxaiMVcmJ/9sfXGiYRpoXeskZ
	WqxRZZseoH1lBfduvM+SwQV12Kk4s39jJx2fZqDsPA7xctMnU7+6P+CxvYmGOGgVqW6sV4f22nR
	VHg==
X-Google-Smtp-Source: AGHT+IFwSrO5NhBZmvoRVsyrPRAz/VlvVDh4aecdu/eb1bYHiTkHDlLm1inaF+lX2qdyGijklr9h4dTHe9Y=
X-Received: from pjzz6.prod.google.com ([2002:a17:90b:58e6:b0:2ea:448a:8cd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4b:b0:2fe:e0a9:49d4
 with SMTP id 98e67ed59e1d1-30e2e5818bcmr8614984a91.2.1747265050136; Wed, 14
 May 2025 16:24:10 -0700 (PDT)
Date: Wed, 14 May 2025 16:24:08 -0700
In-Reply-To: <20250324173121.1275209-8-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-8-mizhang@google.com>
Message-ID: <aCUmGC45Pg6qC6FR@google.com>
Subject: Re: [PATCH v4 07/38] perf: core/x86: Register a new vector for KVM
 GUEST PMI
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
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
> index ad5c68f0509d..b0cb3220e1bb 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -745,6 +745,7 @@ DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
>  DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_VECTOR,		sysvec_kvm_posted_intr_ipi);
>  DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	sysvec_kvm_posted_intr_wakeup_ipi);
>  DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested_ipi);
> +DECLARE_IDTENTRY_SYSVEC(KVM_GUEST_PMI_VECTOR,	        sysvec_kvm_guest_pmi_handler);

I would prefer to keep KVM out of the name, and as mentioned in the previous patch,
route this through perf.

>  #else
>  # define fred_sysvec_kvm_posted_intr_ipi		NULL
>  # define fred_sysvec_kvm_posted_intr_wakeup_ipi		NULL

Y'all forgot to wire up the FRED handling.  I.e. the mediated PMI IRQs would get
treated as spurious when running with FRED.

> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
> index 47051871b436..250cdab11306 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -77,7 +77,10 @@
>   */
>  #define IRQ_WORK_VECTOR			0xf6
>  
> -/* 0xf5 - unused, was UV_BAU_MESSAGE */
> +#if IS_ENABLED(CONFIG_KVM)
> +#define KVM_GUEST_PMI_VECTOR		0xf5
> +#endif

Conditionally defining the vector sounds good on paper, but its problematic, e.g.
for connecting the handler to FRED's array, and doesn't really add much value.

>  #define DEFERRED_ERROR_VECTOR		0xf4
>  
>  /* Vector on which hypervisor callbacks will be delivered */
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index f445bec516a0..0bec4c7e2308 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -157,6 +157,7 @@ static const __initconst struct idt_data apic_idts[] = {
>  	INTG(POSTED_INTR_VECTOR,		asm_sysvec_kvm_posted_intr_ipi),
>  	INTG(POSTED_INTR_WAKEUP_VECTOR,		asm_sysvec_kvm_posted_intr_wakeup_ipi),
>  	INTG(POSTED_INTR_NESTED_VECTOR,		asm_sysvec_kvm_posted_intr_nested_ipi),

