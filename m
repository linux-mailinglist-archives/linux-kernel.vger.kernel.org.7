Return-Path: <linux-kernel+bounces-811140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B12B524DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036511C83A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F412C27A92F;
	Wed, 10 Sep 2025 23:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ODTfIHH6"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5B24C676
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 23:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548782; cv=none; b=rQG9WLCkUEkMjv4E+H+4/Pz320TZlHZFogFWj3Xsd8leMW1nk682PYPycSUc3RvFzqu17/Mo6MUT0SM68zWEqOKcdGhvjOTjsnJr9tVe2j0gaTx6ejDdDn97sIDfZrqPKCBCYSvGxRpDQm4bPgMbD119CYCYX1U/eMq2FpRc8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548782; c=relaxed/simple;
	bh=z7UryU07ZsIwZtTkCIkX9YrgpajQBelPNfH3xWVgSdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KyfmV/bhNeWj674MmdkFHWgLdpjvYAntSOZyQQ/lUjj7MiVN+evoSlCuxDX84tqRgOzPuEgWCHGpwvFsABbllKWhvUPvNZtjdYhtshMknLYG+kYodyNITL6gMM6MhdXTw9851jlcNY8H+h9ZVt0XLW+zp0Hj7VRBiS0NipFjuaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ODTfIHH6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4fb59a89acso129784a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757548780; x=1758153580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx7kGraOjUOSMIvLZNOPm1UobesU6sM8FVf5K2vcg1I=;
        b=ODTfIHH6Pglhm17wuNMs8IFDU74HORq9zuLdtitoUeb98WtRoEkfkBw9e+EidwX27I
         7dKhntUXcQr5u45MEn9fsBmm+ACrhfxZEZBgP54Y1QFWtr5A/5DvNULPPZFScZM0vVZr
         HKmc2eCQJgdAcaXYkdPbJ16zTHogwkBNnVCbn74dRTvjs6tNkTEY96d0t24Ws0xBO5yE
         bw7n1Uo8vgyA7sQMmlBkp9PSpgyC4gtpccmuSRqSeM4jrxa97zWn6lAq1pFi9MFXuoCf
         baATsMDKIc7PWzUc1kI/lamay73vRlnAh1JjXSzmz2MHN5Qap7OcleQYp++0u24g8NtP
         dC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757548780; x=1758153580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx7kGraOjUOSMIvLZNOPm1UobesU6sM8FVf5K2vcg1I=;
        b=XsSyALJKIdNO9flVjMQUg2O0LUao4a7yOpCHohc+2o3MDAGZIrf51MleUlRz40XlQw
         ckVMW61Y7BXw/RZsENVb7LtOKThEni18WY5c0UM+BvC7vBfDaTgrfNpngd5kR0Nsub6f
         Y8llLt8Pz65EJEIIg/2Lw4bdUzU75lDVHAF3Vl0ImCrBae7bevi/MIZYrPzVCOYmJJuB
         2VYclfNg68Lpx29Ny4GpVFnML4SLNWQMUP21h64CDTH0SfbKi5jdiaI5jqHaQ5cWGs9Y
         UNtaxZvw7DpLaf1wq1z1QOPqWg8AeXfp8SpWHzCfTZCkgikwyToerrZvJj9mhMuzWMuQ
         wv1A==
X-Forwarded-Encrypted: i=1; AJvYcCVCiQb6PWDB5Uy4K58eqMApLa4H/5oBZMMtpYDz3Kc6ibymF/TO8CtyfpIX1vvnC5NDLwID6OVreBeWCFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh/P7jkLxoLiUvTNl0vUzegJD5Be0NJ2aGNQhm7Ldnbb+U9IR9
	WdzxrYWdDY4w6U+lcXhVh1XrvyPK7de0oDaBWYIsXTKKZb3371EQgBXTbklqmylHcNYduR/wSbv
	SEHyUFQ==
X-Google-Smtp-Source: AGHT+IFXfL3DI67mRFPeAT1+CJ61sTKzncJWkG1T8gDfTqa+a3NU9eacPijxo/6T0aQQyrMbgCaPjQ5/M6w=
X-Received: from pjj12.prod.google.com ([2002:a17:90b:554c:b0:325:9fa7:5d07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1343:b0:32b:58d4:e9d0
 with SMTP id 98e67ed59e1d1-32d43f98ca9mr22293045a91.23.1757548780201; Wed, 10
 Sep 2025 16:59:40 -0700 (PDT)
Date: Wed, 10 Sep 2025 16:59:38 -0700
In-Reply-To: <20250718001905.196989-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718001905.196989-1-dapeng1.mi@linux.intel.com>
Message-ID: <aMIQ6vxYuHA2jVuN@google.com>
Subject: Re: [PATCH v2 0/5] Fix PMU kselftests errors on GNR/SRF/CWF
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Zide Chen <zide.chen@intel.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Yi Lai <yi1.lai@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 18, 2025, Dapeng Mi wrote:
> This patch series fixes KVM PMU kselftests errors encountered on Granite
> Rapids (GNR), Sierra Forest (SRF) and Clearwater Forest (CWF).
> 
> GNR and SRF starts to support the timed PEBS. Timed PEBS adds a new
> "retired latency" field in basic info group to show the timing info and
> the PERF_CAPABILITIES[17] called "PEBS_TIMING_INFO" bit is added
> to indicated whether timed PEBS is supported. KVM module doesn't need to
> do any specific change to support timed PEBS except a perf change adding
> PERF_CAP_PEBS_TIMING_INFO flag into PERF_CAP_PEBS_MASK[1]. The patch 2/5
> adds timed PEBS support in vmx_pmu_caps_test and fix the error as the
> PEBS caps field mismatch.
> 
> CWF introduces 5 new architectural events (4 level-1 topdown metrics
> events and LBR inserts event). The patch 3/5 adds support for these 5
> arch-events and fixes the error that caused by mismatch between HW real
> supported arch-events number with NR_INTEL_ARCH_EVENTS.
> 
> On Intel Atom platforms, the PMU events "Instruction Retired" or
> "Branch Instruction Retired" may be overcounted for some certain
> instructions, like FAR CALL/JMP, RETF, IRET, VMENTRY/VMEXIT/VMPTRLD
> and complex SGX/SMX/CSTATE instructions/flows[2].
> 
> In details, for the Atom platforms before Sierra Forest (including
> Sierra Forest), Both 2 events "Instruction Retired" and
> "Branch Instruction Retired" would be overcounted on these certain
> instructions, but for Clearwater Forest only "Instruction Retired" event
> is overcounted on these instructions.
> 
> As this overcount issue, pmu_counters_test and pmu_event_filter_test
> would fail on the precise event count validation for these 2 events on
> Atom platforms.
> 
> To work around this Atom platform overcount issue, Patches 4-5/5 looses
> the precise count validation separately for pmu_counters_test and
> pmu_event_filter_test.
> 
> BTW, this patch series doesn't depend on the mediated vPMU support.
> 
> Changes:
>   * Add error fix for vmx_pmu_caps_test on GNR/SRF (patch 2/5).
>   * Opportunistically fix a typo (patch 1/5).
> 
> Tests:
>   * PMU kselftests (pmu_counters_test/pmu_event_filter_test/
>     vmx_pmu_caps_test) passed on Intel SPR/GNR/SRF/CWF platforms.
> 
> History:
>   * v1: https://lore.kernel.org/all/20250712172522.187414-1-dapeng1.mi@linux.intel.com/
> 
> Ref:
>   [1] https://lore.kernel.org/all/20250717090302.11316-1-dapeng1.mi@linux.intel.com/
>   [2] https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/sierra-forest/xeon-6700-series-processor-with-e-cores-specification-update/errata-details
> 
> Dapeng Mi (4):
>   KVM: x86/pmu: Correct typo "_COUTNERS" to "_COUNTERS"
>   KVM: selftests: Add timing_info bit support in vmx_pmu_caps_test
>   KVM: Selftests: Validate more arch-events in pmu_counters_test
>   KVM: selftests: Relax branches event count check for event_filter test
> 
> dongsheng (1):
>   KVM: selftests: Relax precise event count validation as overcount
>     issue

Overall looks good, I just want to take a more infrastructure-oriented approach
for the errata.  I'll post a v3 tomorrow.  All coding is done and the tests pass,
but I want to take a second look with fresh eyes before posting it :-)

