Return-Path: <linux-kernel+bounces-587761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35105A7B038
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 23:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8633A2C4F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Apr 2025 21:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E787B25BAA7;
	Thu,  3 Apr 2025 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdA2cbGo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B4254B12
	for <linux-kernel@vger.kernel.org>; Thu,  3 Apr 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710672; cv=none; b=DrWvUHwPSovx2mQO0lMN9dMCpJbGqnEDt6nmJ36yv1p70RGUqMdAPHcEVAL3qB5FH12q0WKWQ61QeoSBlIyxs41BMTGubCXKqUMh0aWck2GVqEui5M3JJAnwZDdJI374hmh6w/efwUJGw2f0edEjzG6MFKTQ0kXfw8+/NeJvZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710672; c=relaxed/simple;
	bh=AH4J3DuNwTnChu/7r8I6VQ6X1tqQrfaGgbCXpv52MsY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RrUWqK7BYOHpbIkj/uEcUTDNsNj0qiVAOyQ1PXjAAzs5eem/Byh5w8WjRIQxndqRT2LFwH/ZjvIKK4N0iKx3J0KTmejaygT5xQrjDUkjLbKR5mrGbt9nnMMphsoAXiSk9DymCKSet5Jf/H0Yrk83b1dtKMz6XbfJomaEsM63UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdA2cbGo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743710669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4rtz3oVK3jnDeigZKXEGQ7kxzJIURgIIDBtTHH9UTU=;
	b=VdA2cbGow99gPp4ngscbYTORoLh55/QiZS3Q6OfNCxgiNEaF3nlfVM6tuI5FAhuTWV4SmI
	0iouTpALwAXxzU5gJgTZr45l+d7eK0FWob9LKeG58T7lZ9hpZhrIrkwtGsh8luvX455XYs
	+aAhR6Llway9hasLagUw0JSjQiAVDVw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-vNwSuMHIPZKHaZb8iVM0gA-1; Thu, 03 Apr 2025 16:04:27 -0400
X-MC-Unique: vNwSuMHIPZKHaZb8iVM0gA-1
X-Mimecast-MFC-AGG-ID: vNwSuMHIPZKHaZb8iVM0gA_1743710667
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4770cbdb9c7so30476471cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Apr 2025 13:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743710667; x=1744315467;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4rtz3oVK3jnDeigZKXEGQ7kxzJIURgIIDBtTHH9UTU=;
        b=jwj3ju1LDMfgvxomW8f49A4+UQUY6sbdnBibgXhOo6CZlsbe0eDslcM/Ux/b9Nn158
         Me+SsQVebBkFT0jRxsfWHHPsDu4LdSN1LJY++H3yR3bc+DX2HyThbmmWLkbyIKTvUbzA
         DsIQ7p5p6AyDE3gW2r7W+x0XgflFHl1OTlSIw2Fvw1kjJ6vEJtY6gL7Q9wgSXZHz+yi3
         fS67n+2HoVYlTY8v1sLXxlGuke221SqDA+xL+97PogV96CorVL35i2p4wRQbEfrFFZHx
         RQIAmQZiYg1bOQS6nrF6ISP7JzeMot0kHXM4LQ45fyznWVWw/I7EOvAgUuqX4AMhg42R
         i8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVESWuKsLRu8LxwuZ/OT4ZR7d0chDAVXyTVfnka1dbZXrbt8PrR2J2JXEk08Mgq3grEGIvGwaDbPFjxHBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLm/5gVdjpWBuc7IXGDMvJUyk+XHmn1NgyK7IZYbNOLPbo62g1
	D5YFChPAF+HvK6WGUgiZO6E9BJ8Ij0/sre7P5oP8tyYX2SF0IgoEKglEuT3D5eDKzQNa7pfsEFC
	ImlGdv35i2RtX1yrjyzd2hGSFlJNQvB/WEX3jy1rVojKQ2gcY7H98Y7ZMVuQuxA==
X-Gm-Gg: ASbGncvOZaecWBc7945A0TpWyvvsvioMFH24xt9lAYH2Yhw5vAA+RnZChUGOGL/zIBK
	hJ6D+3lybbgNZ8ywyvyV3jVghvLLfd1oKKpx1yQoIs2l4Km+Di0Id8NXo0k3xtXFdCvCCA4WRyK
	HXQTI0+v0xB2QvBU2o/J313YnsHYKRhOdyl4msXJ8vet+DdQdsxky4bOUn54WSUZGSSQ/VrbWUu
	2a4Cahq9UzGB0kDDgpNzs89GctStysiBW4QkZ4yIasZqr26jCfDoFS2m9Co5NTpLb1D+YIcJyMS
	xMpvOvvgw8vUBvk=
X-Received: by 2002:a05:622a:448:b0:476:8288:955f with SMTP id d75a77b69052e-4792490fb2emr11018941cf.8.1743710667014;
        Thu, 03 Apr 2025 13:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo9LOR/QTdiYbvtlfOeC04oRbI9fAMuBy7hvGsx2K2DNOTFI5IS0fHaCtTn4DM15/wrGnywQ==
X-Received: by 2002:a05:622a:448:b0:476:8288:955f with SMTP id d75a77b69052e-4792490fb2emr11018581cf.8.1743710666704;
        Thu, 03 Apr 2025 13:04:26 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b0719b8sm11733041cf.24.2025.04.03.13.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 13:04:26 -0700 (PDT)
Message-ID: <26cedde1e10a210556aabf7510b1d08ee73dca0a.camel@redhat.com>
Subject: Re: [RFC PATCH 07/24] KVM: SEV: Track ASID->vCPU on vCPU load
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>, Sean Christopherson
 <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Rik van Riel <riel@surriel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,  x86@kernel.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 03 Apr 2025 16:04:25 -0400
In-Reply-To: <20250326193619.3714986-8-yosry.ahmed@linux.dev>
References: <20250326193619.3714986-1-yosry.ahmed@linux.dev>
	 <20250326193619.3714986-8-yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-03-26 at 19:36 +0000, Yosry Ahmed wrote:
> Check for changes in the ASID to vCPU mapping on vCPU load instead of
> doing it on vCPU run. This should be sufficient and more efficient, and
> is needed to allow generalizing the tracking and making it more
> expensive.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> ---
>  arch/x86/kvm/svm/sev.c | 13 ++++---------
>  arch/x86/kvm/svm/svm.c | 13 +++++++++++++
>  arch/x86/kvm/svm/svm.h |  1 +
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index ddb4d5b211ed7..3ef0dfdbb34d2 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -224,7 +224,7 @@ static int sev_asid_new(struct kvm_sev_info *sev)
>  	return ret;
>  }
>  
> -static unsigned int sev_get_asid(struct kvm *kvm)
> +unsigned int sev_get_asid(struct kvm *kvm)
>  {
>  	return to_kvm_sev_info(kvm)->asid;
>  }
> @@ -3453,7 +3453,6 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
>  
>  int pre_sev_run(struct vcpu_svm *svm, int cpu)
>  {
> -	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
>  	struct kvm *kvm = svm->vcpu.kvm;
>  	unsigned int asid = sev_get_asid(kvm);
>  
> @@ -3469,16 +3468,12 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
>  	svm->asid = asid;
>  
>  	/*
> -	 * Flush guest TLB:
> -	 *
> -	 * 1) when different vCPU for the same ASID is to be run on the same host CPU.
> -	 * 2) or this VMCB was executed on different host CPU in previous VMRUNs.
> +	 * Flush guest TLB if the VMCB was executed on a differet host CPU in
> +	 * previous VMRUNs.
>  	 */
> -	if (sd->sev_vcpus[asid] == &svm->vcpu &&
> -	    svm->vcpu.arch.last_vmentry_cpu == cpu)
> +	if (svm->vcpu.arch.last_vmentry_cpu == cpu)
>  		return 0;
>  
> -	sd->sev_vcpus[asid] = &svm->vcpu;
>  	vmcb_set_flush_asid(svm->vmcb);
>  	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>  	return 0;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 1156ca97fd798..e6e380411fbec 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1554,6 +1554,7 @@ static void svm_prepare_host_switch(struct kvm_vcpu *vcpu)
>  
>  static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  {
> +	unsigned int asid;
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
>  
> @@ -1568,6 +1569,18 @@ static void svm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	}
>  	if (kvm_vcpu_apicv_active(vcpu))
>  		avic_vcpu_load(vcpu, cpu);
> +
> +	if (sev_guest(vcpu->kvm)) {
> +		/*
> +		 * Flush the TLB when a different vCPU using the same ASID is
> +		 * run on the same CPU.
> +		 */
> +		asid = sev_get_asid(vcpu->kvm);
> +		if (sd->sev_vcpus[asid] != vcpu) {
> +			sd->sev_vcpus[asid] = vcpu;
> +			kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
> +		}
> +	}
>  }
>  
>  static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 4ea6c61c3b048..ca38a233fa24c 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -768,6 +768,7 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm);
>  void sev_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector);
>  void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa);
>  void sev_es_unmap_ghcb(struct vcpu_svm *svm);
> +unsigned int sev_get_asid(struct kvm *kvm);
>  
>  #ifdef CONFIG_KVM_AMD_SEV
>  int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp);

Makes sense, but I might have missed something.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky




