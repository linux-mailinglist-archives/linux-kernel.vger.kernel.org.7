Return-Path: <linux-kernel+bounces-728026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB992B022AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F9AA443B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380292F19A3;
	Fri, 11 Jul 2025 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mn46eXaz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529401B4242
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255485; cv=none; b=R6tKkPC/maQFBT9Pzh+XbSpEXjNxvvhwyW6yE1xFRdP6UtHLWUCOMKqJ6dTRiwIGiZRJVvH/WK7gi/IFIo2pX+9vTVzxQK1VnsQLjChYOB/1Gylwumse1sbdp4JDqZIwhQLpVtZqXCGrbWBQHF3tKhqa2wb6q76s69fLsz+EQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255485; c=relaxed/simple;
	bh=27qRB0esI060a4/jw1Adcpqa0B9pgnupwADBMBp8Ayg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IgJL6DdoSHwdVyBdbPknFeHh8gFc77V+/NlIYBkgutGq1X/6HGCvj15qjJjK2S5w2zcYi/nLe2x4LP/ML3PMPX1o9wVIKb+1JH7RZfLtozKZKhoeep4OQ3/ywXcb92lwfolgqPN9GcJqxh/HJdkeUyG/9JYu7QScwng/6mjnqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mn46eXaz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-235c897d378so23846735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752255483; x=1752860283; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sbuIKyi+MfgvMKfyXYj7WNH0ie5ZWZEBBT5ECwepWTY=;
        b=mn46eXazLUgjmze51M2qudTezy4cV/vBMpkd9nLPCSReZK6hAKn1qd4TIjBaU26zo7
         fM5BbJYUU8Ewg1pJnx104cGyQyUhutyO+kTopkbb7SNuz6ksdqhF6g3Jih3m4b7Q0U2a
         bkBLBahSASGx7vT3kLz9gks3jdNFp6TvGkb0rAdeCGkbDi/3NppC7PXbNmxGZNcEP24B
         GArxpPgknkAg8et3G5/zuUm6862XCq5F8Ia/Cyr8VcUp9+ADIA68PoA74dR4r3LxHCuw
         9T747zzv8BxzbRzLHN0tlTct8WfN9Qjr4SyLuV0snLg/SGv4KllzaAJ3SawPyzakpGXR
         RYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255483; x=1752860283;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbuIKyi+MfgvMKfyXYj7WNH0ie5ZWZEBBT5ECwepWTY=;
        b=Z7Aiwo3ggsp5O6Xj2CKz2lPiejq9mA1jsu3UxQJBH/P4vomTS5i4n8TAiKM/yiI4Vm
         6K1v9W676A4rQQFO4CktzV8ryS7gcbFK983/njOQzKvCbAfaUqMTFCiDZS351WuR6sEb
         1WuR6Lnlnx35F2W0Zzjr3WezP/q0ADbvhFQWUEP/52FxFJH2SG4+jqnObnzRAa+swvsz
         aTa4ADIWaX5fol7C2XjGX9kSUnbxmI5HnTI9z5CYjF7Z4HAkkREYp+Yehlrfj+CQm4CX
         NfYhiNhxLPktyS/8+76cOuP7VC1HsxgrWgGcrIX05Lpsbw888Z8VtsRnjMGfBeIGkBWx
         Fc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkUibLCWlPRugxtZNswGUcsBCIpPNPhyRalxhabiXNRHQygNpMuoYf+yuG0SaY5ZS/Zay4SEUMymcLTcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSR2Sjy9vyTDjOAW95VpfKeAhyPgQCjpvfXvvZZhUcUUipDBSF
	RlXfeIwOdGW63LCQ4bwDbG5FanxkJIMa1MEvzi1VMvNsrnY0MatAX7395hM/TEIOk3ggigPD1sl
	62lXM0w==
X-Google-Smtp-Source: AGHT+IHPZf2sNFkisUa9X3++bUjxOogTN/IzAXZHWztCupoH08hlXsip0gsryYc3EdrVWikP1DkEvsEbOgU=
X-Received: from pjtu13.prod.google.com ([2002:a17:90a:c88d:b0:312:1e70:e233])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244a:b0:232:1daf:6f06
 with SMTP id d9443c01a7336-23dede94c3fmr61666755ad.47.1752255482578; Fri, 11
 Jul 2025 10:38:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:38:01 -0700
In-Reply-To: <20250711172746.1579423-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711172746.1579423-1-seanjc@google.com>
Message-ID: <aHFL-QjqG4hDVV4I@google.com>
Subject: Re: [PATCH] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 11, 2025, Sean Christopherson wrote:
> Emulate PERF_CNTR_GLOBAL_STATUS_SET when PerfMonV2 is enumerated to the
> guest, as the MSR is supposed to exist in all AMD v2 PMUs.
> 
> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> Cc: stable@vger.kernel.org
> Cc: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---

...

> @@ -711,6 +712,10 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!msr_info->host_initiated)
>  			pmu->global_status &= ~data;
>  		break;
> +	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
> +		if (!msr_info->host_initiated)
> +			pmu->global_status |= data & ~pmu->global_status_rsvd;
> +		break;
>  	default:
>  		kvm_pmu_mark_pmc_in_use(vcpu, msr_info->index);
>  		return kvm_pmu_call(set_msr)(vcpu, msr_info);

Tested with a hacky KUT test to verify I got the semantics correct.  I think I did?

  static void test_pmu_msrs(void)
  {
	const unsigned long long rsvd = GENMASK_ULL(63, 6);

	wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, -1ull);
	report(!rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS),
	       "Wanted '0', got 0x%" PRIx64, rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS));

	wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, -1ull);
	report(rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS) == ~rsvd,
	       "Wanted '0x%llx', got 0x%" PRIx64,
	       ~rsvd, rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS));

	wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, -1ull);
	report(!rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS),
	       "Wanted '0', got 0x%" PRIx64, rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS));

	wrmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, 0);
	report(!rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS),
	       "Wanted '0', got 0x%" PRIx64, rdmsr(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS));
  }

One oddity is that the test fails when run on the mediated PMU on Turin, i.e. when
the guest can write MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET directly.

  FAIL: Wanted '0x3f', got 0xc000000000000ff

Bits 59:58 failing is expected, because lack of KVM support for DebugCtl[FPCI]
and DebugCtl[FLBRI] doesn't remove them from hardware.  Disabling interception
of MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET creates a virtualization hole on that
front, but I don't know that it's worth closing.  Letting the guest manually
freeze its counters doesn't seem terribly interesting.

Bits 7:6 being set is _much_ more interesting, at least to me.  They're allegedly
reserved per the APM, and CPUID 0x80000022 says there are only 6 counters, so...

