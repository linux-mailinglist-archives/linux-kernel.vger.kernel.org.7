Return-Path: <linux-kernel+bounces-699270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C60DAE57D2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 01:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F74C4A5687
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62BC22B8D0;
	Mon, 23 Jun 2025 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5ygN3ZA"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F422A4F1
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720637; cv=none; b=F4W7nzZsZqZfV03DVC45AcgsN2dku9BDqpvwn6wHmiT7g5q7lYZ2SyDMEdE+pcazw4LK6zGZiikPva2T0dSC7PyjlVcFEnT1XAWqixKudUXX1jtqkD675wYZPyWiE81dNL/CV1bGB3+6+9DxCv5ui4ILZOl/oA77yM3S1mmo2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720637; c=relaxed/simple;
	bh=cgrE9342uSRf63myGdouIQCJ22jJc+5tANVbegpfq3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f/lfF4E+NWIuaRiOA7EHLD4CnqgzFfjUiI3Uvhc97dNgAkK1RqGWUqvdTStRs9ZYLH8ud2E2zKCLAOOaAOonCvaS4ObsKesdWhsukjjhcDl8ipcUGeYK4IVEOxMGSU0XGYiRLNp8iBJA7edrXN/eYgOrAKbpoiXVrehmXXBVN7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5ygN3ZA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2356ce55d33so68674305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750720635; x=1751325435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2U97lvMtIgl9ojC8niuGErncTXrxip0ynV99jRG/3k=;
        b=S5ygN3ZAOQ1MufMEs6vXxCvyM9aU9+jZZJMor4bjbcXLyUSWgYUNRW/u49x5PN96FU
         M8ALmtvSfL1oy4UeJdDS9hg5gZ8wZPQLB2QlLbLey9Tcpe+xDSSOVYJrbCaRko8D3iU9
         gcAiYhn+aOkVw6gIkVyBZOqiYX83LglAZLB+M3Bir2PVAL6F/bWfOegVHUYGpcJse2Tt
         gWKqB+nKhwkT0LkAeb2+iIZYOHEVR1bF1sZ37ybA9Mj9LwtZCluikN44t6L9c/nHOkL5
         JMuokxvWVU1MRcGPh4iGLUvByT9L0wE3mu9GMuaY2vydT5mDxJPHIajSyWVTdRNB2FTg
         AaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750720635; x=1751325435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2U97lvMtIgl9ojC8niuGErncTXrxip0ynV99jRG/3k=;
        b=sjluVobtpsstSXUR1A5pHT2rFiB3PuNhkKWSqMWjY9kCnZ3uI84/7QIlisVQHAP4nC
         j48TQGmHhOUsE9YtWm3rs/ouAiXCwq7Y9/6XJnGR8J/uZ4olZM3BiJDL4N9isD7v6Hpt
         2vkriIszD3/6z5D8SXE2vz09X5o0BJ6EaLxG+eqv4yyhTgj+Q9g0ciLgpRfBEKEyIWhf
         43FIG1+xl/q+WTclK+fZVxfu9pr3faDvgyKPSQXPHW3739tRTZWuYF0IS3QS0PsdQrri
         FZeoBRh18eOFETS8D7TwSxXvEbqlWW0lmDYZFCfF+h98DLotvA8KC9MWV+bIwM8kzcFG
         GPNg==
X-Forwarded-Encrypted: i=1; AJvYcCWdDdTcY4rWWwV8fDtDjvbbS5e6r5K4B5lf6c9JP3fyPvcxBtnp07/RKm7AfobDSGGKHRBK7DiEbkcIfq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrYrAOQn4Xhc7BH9LiIHEjxZoe8xPZn1S+/o12D7Fe6ANbOWH8
	cBYMz474vPQvnia8DDqFfdDtaCFKlFNwoixN9ff99RCP9UYozHnOQavvzi6OTQwaymTDO7YD17t
	rSJQN6w==
X-Google-Smtp-Source: AGHT+IEZoYdqVNB7akE6IgP9niVgwAxNf85zpIYvFK58KzbbkMS0KPZA6X9ClqT9Lv2H6YzlKPSZHE0HEr8=
X-Received: from pjboi14.prod.google.com ([2002:a17:90b:3a0e:b0:311:ff32:a85d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e842:b0:235:f1e4:3383
 with SMTP id d9443c01a7336-237d96b63camr221358465ad.7.1750720634958; Mon, 23
 Jun 2025 16:17:14 -0700 (PDT)
Date: Mon, 23 Jun 2025 16:17:13 -0700
In-Reply-To: <330d10700c1172982bcb7947a37c0351f7b50958.1740036492.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740036492.git.naveen@kernel.org> <330d10700c1172982bcb7947a37c0351f7b50958.1740036492.git.naveen@kernel.org>
Message-ID: <aFngeQ5x6QiP7SsK@google.com>
Subject: Re: [PATCH v3 1/2] KVM: SVM: Increase X2AVIC limit to 4096 vcpus
From: Sean Christopherson <seanjc@google.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 20, 2025, Naveen N Rao (AMD) wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Newer AMD platforms enhance x2AVIC feature to support up to 4096 vcpus.
> This capatility is detected via CPUID_Fn8000000A_ECX[x2AVIC_EXT].
> 
> Modify the SVM driver to check the capability. If detected, extend bitmask
> for guest max physical APIC ID to 0xFFF, increase maximum vcpu index to
> 4095, and increase the size of the Phyical APIC ID table from 4K to 32K in
> order to accommodate up to 4096 entries.

Kinda silly, but please split this into (at least) two patches.  One to introduce
the variables to replace the macros, and then one to actually implement support
for 4096 entries.  That makes it a _lot_ easier to review each change (I'm having
trouble teasing out what's actually changing for 4k support).

The changelog also needs more info.  Unless I'm misreading the diff, only the
physical table is being expanded?  How does that work?  (I might be able to
figure it out if I think hard, but I shouldn't have to think that hard).

> @@ -182,7 +185,8 @@ void avic_vm_destroy(struct kvm *kvm)
>  	if (kvm_svm->avic_logical_id_table_page)
>  		__free_page(kvm_svm->avic_logical_id_table_page);
>  	if (kvm_svm->avic_physical_id_table_page)
> -		__free_page(kvm_svm->avic_physical_id_table_page);
> +		__free_pages(kvm_svm->avic_physical_id_table_page,
> +			     get_order(sizeof(u64) * (x2avic_max_physical_id + 1)));

The order should be encapsulated in some way, e.g. through a global or a helper.

> @@ -1218,8 +1224,19 @@ bool avic_hardware_setup(void)
>  
>  	/* AVIC is a prerequisite for x2AVIC. */
>  	x2avic_enabled = boot_cpu_has(X86_FEATURE_X2AVIC);
> -	if (x2avic_enabled)
> -		pr_info("x2AVIC enabled\n");
> +	if (x2avic_enabled) {
> +		x2avic_4k_vcpu_supported = !!(cpuid_ecx(0x8000000a) & 0x40);

No, add an X86_FEATURE_xxx for this, don't open code the CPUID lookup.  I think
I'd even be tempted to use helpers instead of  

> +		if (x2avic_4k_vcpu_supported) {
> +			x2avic_max_physical_id = X2AVIC_MAX_PHYSICAL_ID_4K;
> +			avic_physical_max_index_mask = AVIC_PHYSICAL_MAX_INDEX_4K_MASK;
> +		} else {
> +			x2avic_max_physical_id = X2AVIC_MAX_PHYSICAL_ID;
> +			avic_physical_max_index_mask = AVIC_PHYSICAL_MAX_INDEX_MASK;
> +		}
> +
> +		pr_info("x2AVIC enabled%s\n",
> +			x2avic_4k_vcpu_supported ? " (w/ 4K-vcpu)" : "");

Maybe print the max number of vCPUs that are supported?  That way there is clear
signal when 4k *isn't* supported (and communicating the max number of vCPUs in
the !4k case would be helpful too).

> +	}
>  
>  	amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
>  
> -- 
> 2.48.1
> 

