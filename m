Return-Path: <linux-kernel+bounces-837980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC09BAE2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6992F324D64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77F530C343;
	Tue, 30 Sep 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZXiNGrE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BE23C8AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253082; cv=none; b=SF0R5L6qJpyO6cFnLEARo5AP5eRwM97/CF2rrloA+SiuPGRPbg+5oIskh9bqYZRNvnZ7lJ9LO4dk70YDPd5NmR310ePF1wvtwd+IIE0LHr92/0Jmv093q3XtnXUOifJ4J2GrCiD6LQE4Cj4+B795+pbPSQjGHme55AnGXaJuod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253082; c=relaxed/simple;
	bh=De6Kmz03lUiOPTF1oH2gIRSCbZz+JUBTGPZCHfyKHhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feUb8kbKaOA8OM5KTT7+UjBWdT2YvefKQmF8FnNume9v37t6BA2HiElrwqAqQpRWHhKNgbQ5gpv3gX4OllzuvRaCISL/BTwidIlEzoLIySzowzPtCiNVVhRIJpfoHUiR5Ng8jx+VT0KuXNRPtBtyHJbBNDeFbUuMeAN7Hob6b3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aZXiNGrE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYlp1mw2rhH9LTO0qo2r/Q1foOrUeCm2qZWqIsyWRqQ=;
	b=aZXiNGrEPqo06R7TlTYcrqLOCDTMhICxMwNlXlFMFRkIQGe6BHI7F1IDzxZOJliB5b7mtm
	kCgJjW9UDscF3LNYLs6oA7Kd4OuwrItXrL6UuW6ZAf8oZLdh34ZYMnUFp+LRjjbpTTU2Mi
	RnVYytU7pZN0pY3bi8JluOiJsymxVzM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-AmNc0NvLPQu_ETTPW38iAw-1; Tue, 30 Sep 2025 13:24:36 -0400
X-MC-Unique: AmNc0NvLPQu_ETTPW38iAw-1
X-Mimecast-MFC-AGG-ID: AmNc0NvLPQu_ETTPW38iAw_1759253075
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3e177893so38658895e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253074; x=1759857874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYlp1mw2rhH9LTO0qo2r/Q1foOrUeCm2qZWqIsyWRqQ=;
        b=MmuM5U3H1oxZ4bKWwYge0Sa9RtbPvrfO7C5oXiIG7VDfs82MtjcWKWQykX7bcT2e/7
         TmtWDBnhcGaIadFty/aY9j1HmuTk56qG78pGfiUDh6ElPXCvrvoLusKs0HfYiqTx7odk
         57dVWuz9wyoUhhy6nn+tjejjPVv1gRCUdSo5Gp629oJwiFvSVesLvaoOk9eEI+dkPlAx
         FAvq2Y3Ho1M70FLwoqRh3vC+wdBnjJ4cdrtWLj3cTrV8qTgkoCKf5mXc7L5UlSgrtlam
         CWqD9meaoiUVBplGZX0lq/dv9OIJIiwG4H07BzdPBzA6R2LbrBJYQK/fLm9jgelkSQ83
         fntQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCzG0uHwHV4IYrtpDy6mCxxiQRIkPfr5kCu2xJA1GxseLNdTPIEmqTPsraHeFnWhLyAGHjnZXSkRo8S+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQa7d4jg8i0roKAMaW60VIVYoRhZcOrPub4AmJKTvzmqVUyKNE
	wGDUeDM4Ndezla3y8sL38RSbBoDq5VZVQBsxN6VODNn33GpLquco8qZFacrbM4BngcTiNclRBF8
	gzbsCHg3ve637VR7R0+iMhK28m0bmp/LLZ89KWWyH7Y7p63vGCheCB4FRQvQ2SLa5Z0jHrt5T2B
	iED6D/ZWTIifYMgrw9vhSrMUcWgQdXNb0mCVMus5XE
X-Gm-Gg: ASbGncul6TYdKgByycF8iltd3xHBPtrptzMvOTC5HUcJK/NMgxF1kjRwBV0q+dOuBri
	GHR4fuUmfzWk/9t4TENxl4LEV9dPkMrpSD/E54XK94/tOoe70rkjtjAdOdtaSA2MGOOCOUlIBuP
	KN9LHRjM1nkk82nAhf/K6Z4zbvpy5KO5AtweZji40PskrJcqODBfmlIO0Cgv1mzIqrdAESCdVU7
	vfavLGS3nmMEB7jtLGXsLhplWRmv5nu
X-Received: by 2002:a05:600c:681b:b0:45d:e28c:8741 with SMTP id 5b1f17b1804b1-46e612cb6abmr5080455e9.29.1759253074509;
        Tue, 30 Sep 2025 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiwJ+s1jwbycrYQiV3/fTxfn1rRhWSosJKGBOEIOCuf4TauWArcItXpGP0ZCUf16PRjJaIFvUy+MzvT5eGfPU=
X-Received: by 2002:a05:600c:681b:b0:45d:e28c:8741 with SMTP id
 5b1f17b1804b1-46e612cb6abmr5080215e9.29.1759253073920; Tue, 30 Sep 2025
 10:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-5-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:24:21 +0200
X-Gm-Features: AS18NWDa88_0tEft3tuSNzxvHDSePM6Z4FpaiUyP2f6jhAmc5p_FxXq87O5HhA4
Message-ID: <CABgObfar+bUip4T5x_Y0XwgmEvZRXc33pWYd24jEieK_0BA__g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Selftests changes for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> A mix of fixes, cleanups and new coverage.  Note, there's also a large-is=
h new
> MSR selftest coming in through the "cet" pull request.
>
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.18
>
> for you to fetch changes up to df1f294013da715f32521b3d0a69773e660a1af5:
>
>   KVM: selftests: Add ex_str() to print human friendly name of exception =
vectors (2025-09-23 08:39:02 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM selftests changes for 6.18
>
>  - Add #DE coverage in the fastops test (the only exception that's guest-
>    triggerable in fastop-emulated instructions).
>
>  - Fix PMU selftests errors encountered on Granite Rapids (GNR), Sierra
>    Forest (SRF) and Clearwater Forest (CWF).
>
>  - Minor cleanups and improvements
>
> ----------------------------------------------------------------
> Alok Tiwari (1):
>       KVM: selftests: Fix typo in hyperv cpuid test message
>
> Dapeng Mi (2):
>       KVM: selftests: Add timing_info bit support in vmx_pmu_caps_test
>       KVM: selftests: Validate more arch-events in pmu_counters_test
>
> Gopi Krishna Menon (1):
>       KVM: selftests: fix minor typo in cpumodel_subfuncs
>
> James Houghton (1):
>       KVM: selftests: Fix signedness issue with vCPU mmap size check
>
> Sean Christopherson (8):
>       KVM: selftests: Move Intel and AMD module param helpers to x86/proc=
essor.h
>       KVM: selftests: Add support for #DE exception fixup
>       KVM: selftests: Add coverage for 'b' (byte) sized fastops emulation
>       KVM: selftests: Dedup the gnarly constraints of the fastops tests (=
more macros!)
>       KVM: selftests: Add support for DIV and IDIV in the fastops test
>       KVM: selftests: Track unavailable_mask for PMU events as 32-bit val=
ue
>       KVM: selftests: Reduce number of "unavailable PMU events" combos te=
sted
>       KVM: selftests: Add ex_str() to print human friendly name of except=
ion vectors
>
> Sukrut Heroorkar (1):
>       selftests/kvm: remove stale TODO in xapic_state_test
>
> dongsheng (1):
>       KVM: selftests: Handle Intel Atom errata that leads to PMU event ov=
ercount
>
>  tools/testing/selftests/kvm/include/kvm_util.h     | 17 +++--
>  tools/testing/selftests/kvm/include/x86/pmu.h      | 26 +++++++
>  .../testing/selftests/kvm/include/x86/processor.h  | 35 ++++++++-
>  tools/testing/selftests/kvm/lib/kvm_util.c         | 42 ++---------
>  tools/testing/selftests/kvm/lib/x86/pmu.c          | 49 +++++++++++++
>  tools/testing/selftests/kvm/lib/x86/processor.c    | 39 +++++++++-
>  .../selftests/kvm/s390/cpumodel_subfuncs_test.c    |  2 +-
>  tools/testing/selftests/kvm/x86/fastops_test.c     | 82 ++++++++++++++++=
+-----
>  tools/testing/selftests/kvm/x86/hyperv_cpuid.c     |  2 +-
>  tools/testing/selftests/kvm/x86/hyperv_features.c  | 16 ++---
>  .../testing/selftests/kvm/x86/monitor_mwait_test.c |  8 +--
>  .../testing/selftests/kvm/x86/pmu_counters_test.c  | 67 ++++++++++++----=
--
>  .../selftests/kvm/x86/pmu_event_filter_test.c      |  4 +-
>  .../testing/selftests/kvm/x86/vmx_pmu_caps_test.c  |  7 +-
>  tools/testing/selftests/kvm/x86/xapic_state_test.c |  4 +-
>  tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c  | 12 ++--
>  16 files changed, 303 insertions(+), 109 deletions(-)
>


