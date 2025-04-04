Return-Path: <linux-kernel+bounces-588571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861BFA7BAA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30BC1B60035
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787381C9B9B;
	Fri,  4 Apr 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAiWFTci"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAE1C8600
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762233; cv=none; b=bgUqBmBZa3jxrsmutv/+KOSuWUv7dv2YiZWvWuoWrWsaXbInimdMDLfS6jsaFlTdTKn4QuMAfvK9d77EgAmlYPoAr7s2z/JkbNBhqFGtyNHvmcLCMts4opEacG0oYboM9Sl7A7FIIHkc3ThpP0WKwBFWIHwyyqyVQICbMfA8M54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762233; c=relaxed/simple;
	bh=gWphGMPeONRtVjLHXMNxQdsgAA1YrbCokB3soMFVFWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=J7hCTJ+B6i4Kx7lCGVNZ3fVJge84COUbx7mcuV4rHj3h9/O2IallIeWO3XAPxcVZslDJGpFFzTzvZ/xBj5z/z2T/AAcsqpL9fj1JOSGMQe4fY7DYotV0eG3Ysfwxsx4Xv1DHJE8/CIzJOF3VxwPvnsDlbv3il4HL0OQFQVJjU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAiWFTci; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743762230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=An4YjWIIqwBPDKwmWWV8XK1pBrP+qzzs+GxOsTRdiuQ=;
	b=IAiWFTciOmwaZejK8eN9g0J7PsttzQtAJot1+dK7/zUQE2vXRYMBdxIhJuYP9EmqgZCe8Q
	FmCGpkLhjt+q8FKcj933RXTCpRt5mPxb7tAmSQ01WFKEiXE7hUagn5rCNil5afcVQdDifl
	+k0qfRfDngLo+QSztQEzKdSS/NsmUpc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-rhhZdiZLPWyzLTFsuMltAA-1; Fri, 04 Apr 2025 06:23:49 -0400
X-MC-Unique: rhhZdiZLPWyzLTFsuMltAA-1
X-Mimecast-MFC-AGG-ID: rhhZdiZLPWyzLTFsuMltAA_1743762228
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e5be5ec846so1746405a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 03:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762228; x=1744367028;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An4YjWIIqwBPDKwmWWV8XK1pBrP+qzzs+GxOsTRdiuQ=;
        b=FV/mEvnY2WzWSR+xfRrFlYXURL7nY7EIDWVdLp/x+m6M4+XjYSUYqjYZhbxCRW78qb
         sJdCvvGDFDXcWdkn59374LI+kKBupf3prf1NpxR9nWV1IAlKakYiNukbQeqBr8escfcR
         q7KqXNG44Ek6KGNA6Cg0i6+YQZtzh/q0QSvAgHPQB2vV7EvGNUJ3Gdyg/rIrRTRUhza0
         qWozO0WVls8s5I49984bHews7HlZNkQt005SPk/3cRAgWEN+hN3Qmw2nYoaZ3qRgikq1
         pKyn38ZeE0k+waCSKpTxVVP95oUQMN00j2Mo8dHm/NFH/XAgAoxuYvHrdIfv/gp7qCN4
         e1dA==
X-Gm-Message-State: AOJu0YwbvW2t3GXFEy/HnMt41mj3lJhJuf/EDPkLe0I7TN/Tu2fiOQbl
	DwRiwFU/Gs0aE2v0qgiKs7V4a1jZbka5JJjNPOPOud4Nxo5Z6ZBeV+uhJylWduTlHasWHmlsWgi
	xA9ylmS2GneyRmRUOUTYpXbqB+yakx9Sf/QHdnyOJ//3vzoKUyiMmhdZKDNO/nWM6y6qLoX4kvC
	QTquFf87oh/erZJLKdO3xsg9W+5W8bxoO0PgKfYYF56Ip1UA==
X-Gm-Gg: ASbGncscmjm3Bs991UQUnM7rg4+sEM8ndyW+jni6qFBVliVXjwQ4TYRbSiPYOu86dCe
	5c8D6DBqFalzuO5NHDNzq6huJ5DtplfVvuLda/YfjBxTEdKE3d67g6Ob3TzZ7MUH+54/V1U0HFE
	DenkUYFtpaJ/jiIFRxFp3G+VMAoxDSIN790rt3chS/qs1TD4aPmRL+O4emmJhZOYjRRUYcH9ksc
	j0Je8nZlSMILkQ+Kohf3i4WUW68/s+iHv1dVtwzsAYLL+NzjmQejVrYKcIBvo93NKW3wM7NX7bF
	uDMoVYNvYuxZiYvd7jD4
X-Received: by 2002:a05:6402:84d:b0:5e7:73ad:60a2 with SMTP id 4fb4d7f45d1cf-5f0b663162amr1722940a12.30.1743762227713;
        Fri, 04 Apr 2025 03:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNEMsh2OHwerzBadXVfPUgWo3cu9lJw3Sv5S/um+CSfwYPELsN+T0XYt3uiiRnIG7a3CwquQ==
X-Received: by 2002:a05:6402:84d:b0:5e7:73ad:60a2 with SMTP id 4fb4d7f45d1cf-5f0b663162amr1722920a12.30.1743762227300;
        Fri, 04 Apr 2025 03:23:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.230.224])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880b9ff1sm2094295a12.81.2025.04.04.03.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:23:46 -0700 (PDT)
Message-ID: <93f75341-a194-46e3-8b01-8d75a55fbe69@redhat.com>
Date: Fri, 4 Apr 2025 12:23:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kvm: list once tests that are valid on all
 architectures
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20250401141327.785520-1-pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250401141327.785520-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/25 16:13, Paolo Bonzini wrote:
> Several tests cover infrastructure from virt/kvm/ and userspace APIs that have
> only minimal requirements from architecture-specific code.  As such, they are
> available on all architectures that have libkvm support, and this presumably
> will apply also in the future (for example if loongarch gets selftests support).
> Put them in a separate variable and list them only once.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Applied now.

Paolo

> ---
>   tools/testing/selftests/kvm/Makefile.kvm | 45 ++++++++----------------
>   1 file changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index f773f8f99249..f62b0a5aba35 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -50,8 +50,18 @@ LIBKVM_riscv += lib/riscv/ucall.c
>   # Non-compiled test targets
>   TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
>   
> +# Compiled test targets valid on all architectures with libkvm support
> +TEST_GEN_PROGS_COMMON = demand_paging_test
> +TEST_GEN_PROGS_COMMON += dirty_log_test
> +TEST_GEN_PROGS_COMMON += guest_print_test
> +TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
> +TEST_GEN_PROGS_COMMON += kvm_create_max_vcpus
> +TEST_GEN_PROGS_COMMON += kvm_page_table_test
> +TEST_GEN_PROGS_COMMON += set_memory_region_test
> +
>   # Compiled test targets
> -TEST_GEN_PROGS_x86 = x86/cpuid_test
> +TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
> +TEST_GEN_PROGS_x86 += x86/cpuid_test
>   TEST_GEN_PROGS_x86 += x86/cr4_cpuid_sync_test
>   TEST_GEN_PROGS_x86 += x86/dirty_log_page_splitting_test
>   TEST_GEN_PROGS_x86 += x86/feature_msrs_test
> @@ -119,27 +129,21 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
>   TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
>   TEST_GEN_PROGS_x86 += access_tracking_perf_test
>   TEST_GEN_PROGS_x86 += coalesced_io_test
> -TEST_GEN_PROGS_x86 += demand_paging_test
> -TEST_GEN_PROGS_x86 += dirty_log_test
>   TEST_GEN_PROGS_x86 += dirty_log_perf_test
>   TEST_GEN_PROGS_x86 += guest_memfd_test
> -TEST_GEN_PROGS_x86 += guest_print_test
>   TEST_GEN_PROGS_x86 += hardware_disable_test
> -TEST_GEN_PROGS_x86 += kvm_create_max_vcpus
> -TEST_GEN_PROGS_x86 += kvm_page_table_test
>   TEST_GEN_PROGS_x86 += memslot_modification_stress_test
>   TEST_GEN_PROGS_x86 += memslot_perf_test
>   TEST_GEN_PROGS_x86 += mmu_stress_test
>   TEST_GEN_PROGS_x86 += rseq_test
> -TEST_GEN_PROGS_x86 += set_memory_region_test
>   TEST_GEN_PROGS_x86 += steal_time
> -TEST_GEN_PROGS_x86 += kvm_binary_stats_test
>   TEST_GEN_PROGS_x86 += system_counter_offset_test
>   TEST_GEN_PROGS_x86 += pre_fault_memory_test
>   
>   # Compiled outputs used by test targets
>   TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
>   
> +TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
>   TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
>   TEST_GEN_PROGS_arm64 += arm64/arch_timer_edge_cases
>   TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
> @@ -158,22 +162,16 @@ TEST_GEN_PROGS_arm64 += arm64/no-vgic-v3
>   TEST_GEN_PROGS_arm64 += access_tracking_perf_test
>   TEST_GEN_PROGS_arm64 += arch_timer
>   TEST_GEN_PROGS_arm64 += coalesced_io_test
> -TEST_GEN_PROGS_arm64 += demand_paging_test
> -TEST_GEN_PROGS_arm64 += dirty_log_test
>   TEST_GEN_PROGS_arm64 += dirty_log_perf_test
> -TEST_GEN_PROGS_arm64 += guest_print_test
>   TEST_GEN_PROGS_arm64 += get-reg-list
> -TEST_GEN_PROGS_arm64 += kvm_create_max_vcpus
> -TEST_GEN_PROGS_arm64 += kvm_page_table_test
>   TEST_GEN_PROGS_arm64 += memslot_modification_stress_test
>   TEST_GEN_PROGS_arm64 += memslot_perf_test
>   TEST_GEN_PROGS_arm64 += mmu_stress_test
>   TEST_GEN_PROGS_arm64 += rseq_test
> -TEST_GEN_PROGS_arm64 += set_memory_region_test
>   TEST_GEN_PROGS_arm64 += steal_time
> -TEST_GEN_PROGS_arm64 += kvm_binary_stats_test
>   
> -TEST_GEN_PROGS_s390 = s390/memop
> +TEST_GEN_PROGS_s390 = $(TEST_GEN_PROGS_COMMON)
> +TEST_GEN_PROGS_s390 += s390/memop
>   TEST_GEN_PROGS_s390 += s390/resets
>   TEST_GEN_PROGS_s390 += s390/sync_regs_test
>   TEST_GEN_PROGS_s390 += s390/tprot
> @@ -182,27 +180,14 @@ TEST_GEN_PROGS_s390 += s390/debug_test
>   TEST_GEN_PROGS_s390 += s390/cpumodel_subfuncs_test
>   TEST_GEN_PROGS_s390 += s390/shared_zeropage_test
>   TEST_GEN_PROGS_s390 += s390/ucontrol_test
> -TEST_GEN_PROGS_s390 += demand_paging_test
> -TEST_GEN_PROGS_s390 += dirty_log_test
> -TEST_GEN_PROGS_s390 += guest_print_test
> -TEST_GEN_PROGS_s390 += kvm_create_max_vcpus
> -TEST_GEN_PROGS_s390 += kvm_page_table_test
>   TEST_GEN_PROGS_s390 += rseq_test
> -TEST_GEN_PROGS_s390 += set_memory_region_test
> -TEST_GEN_PROGS_s390 += kvm_binary_stats_test
>   
> +TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
>   TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
>   TEST_GEN_PROGS_riscv += riscv/ebreak_test
>   TEST_GEN_PROGS_riscv += arch_timer
>   TEST_GEN_PROGS_riscv += coalesced_io_test
> -TEST_GEN_PROGS_riscv += demand_paging_test
> -TEST_GEN_PROGS_riscv += dirty_log_test
>   TEST_GEN_PROGS_riscv += get-reg-list
> -TEST_GEN_PROGS_riscv += guest_print_test
> -TEST_GEN_PROGS_riscv += kvm_binary_stats_test
> -TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
> -TEST_GEN_PROGS_riscv += kvm_page_table_test
> -TEST_GEN_PROGS_riscv += set_memory_region_test
>   TEST_GEN_PROGS_riscv += steal_time
>   
>   SPLIT_TESTS += arch_timer


