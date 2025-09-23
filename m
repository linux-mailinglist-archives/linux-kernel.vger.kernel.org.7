Return-Path: <linux-kernel+bounces-829326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13AB96CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1601417A888
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB6321F32;
	Tue, 23 Sep 2025 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bcke/teM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4410331E0E4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644642; cv=none; b=sAMPN+IK6Tu8KRwmS5WNEa6Yt4e6unvDUWr6QjNnA53NVlDKJCeyS5IjmZ/Y1sB9RIdz5jCtU3nIrd+CV7coQVL2Adu6ddXu6+V/lRW6OhKmKSMkG3a3Pwv6EJaxeYeS55iMvhqRrXUH6fYYBBmHjbU/bKlTzoi/65tNEp+adQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644642; c=relaxed/simple;
	bh=46Hpujpb3Yg/Ko6xhlDEcM4c8sFMh5gMF8zBpzvj+xE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KVn6ZPYRdZGczY4gFxPoNZIxNVMQCQ3pHayv8o8iWBmmVA39vSonwtXD0Pyt+Ou+nVminYjXTkrG84e5Hb+7FsIDxK7//IRutbD6v/x01B4jP64z7iXAqUPpxwpKtItHbAQJIePuO6CmSH49LXVYxWj2VJAQZGu6ORqOsK/uSpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bcke/teM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758644640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bf7Jy8zNah+w6pHv/TY1gyNEsQr9dQbaScDbApDmfLo=;
	b=Bcke/teM/7lNGLY6H690QDRrqQx4tXQfRzadoR5P9i/yo59XJlaLS5AqvfzCCDER8vwvrb
	CEs2cn0bC/yQUSD7OHE09lEjF5VDtiK+9DPnSOlCdYR4RSEJgfLpFVKw6JcWPPw01r4aU3
	siJJeRMyhXT58FoZb8QTj19sLbL3bWY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-bQFC0N7mNzGxqZghpokbQA-1; Tue, 23 Sep 2025 12:23:58 -0400
X-MC-Unique: bQFC0N7mNzGxqZghpokbQA-1
X-Mimecast-MFC-AGG-ID: bQFC0N7mNzGxqZghpokbQA_1758644637
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b2e9653a35aso241729266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644637; x=1759249437;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf7Jy8zNah+w6pHv/TY1gyNEsQr9dQbaScDbApDmfLo=;
        b=h2xvvdj0iNY56itTxYMt2t1Yc6bzx0wqMf4Aizy8/HrvBgqcu1G/wtzm6yk16R0021
         JRCi9EIROuyKUcAWMaI5I9iPilLPNx/ysNw8ze3DwfNU1xqosG8EpFQ/iVLUQUz3BWD4
         szKem8xVXpkKB3qD5+bR1chOLkWOGKqywhzouPk+nIArqjAqP2Dxox5+dIS+BOIUJFt+
         9RXVTUr9MiEh1SIsA6tsHxrNWG9HUuTUzr/Y6QRPedHtPbEj8YOapfWRwsO5UjC//Neq
         EEmiR/9a/WucafCdTRjoV4mfynpXG/Xi4BIIlaPJCcFshxGBjO2+1ydeoZHR5e4ql4qd
         HrTw==
X-Forwarded-Encrypted: i=1; AJvYcCX2GfEOZGrt95PFfVNLmGB2T17P7AWUZ8nWndAWEq4xDL4gCeda3j7rXDTYMnhUeknLlvWiUk3Jz7IEHOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSBf2CcVMW/ThB2TaistLJNWJkJh2jzVamdyvBZ8vBGjoLJdr
	ttmzS9LErtuU4OywBzmmRpFbXv5yDxVkus2VJN8dpCGLPw9V3YNxCzNFUAnAPQEJnTrmOhX5Hcf
	6xDofGK/V7MoJPQ8/sYvjscwagIg+GbayQPcsUyv6a+r0Sq0q64FOLYDvw/MsKZyFdg==
X-Gm-Gg: ASbGncvbvQ3iXsoZI2MOLr7ot6PdMAoiRDsA6K0iXlh88SMl2rgVQUOAoF7aghmgSc5
	KGOJ/vx3LmKG5GzKX9wvxTeFqyZt5cOXyls0+HBgp2Q5+gHJt+GLem+FCj1xmaJgrYcxpRiXvqW
	u/jaCOdnUG2ZxJdbkvsZFOq3r/3u3waWYuhxyAAsnAtmDEr4suVX5apcyXurSnQr/D4wtViwbXm
	VfEc/qHJmyQKLUpASIt5u/IVq3RTzgXvnfFkfovS9FnZoVxz5o5YEX8eTyWNgcqqpeO9yQpwsU2
	Y5Yut5m/1xx6Iuae0zjNvHn6E2eDS2XTORzEnOD3WTm94Gi/0Qg0GZkTkZDxMfqLRUchjR347n0
	kg/PT9hSMRgKB+SsyKUJXbH78DedYXtKEESVID/LFkNyNaQ==
X-Received: by 2002:a17:907:2d93:b0:b2b:a56f:5434 with SMTP id a640c23a62f3a-b30264ae4cemr297622066b.13.1758644637376;
        Tue, 23 Sep 2025 09:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfqMxrsi0q9jO0bT83aJR1r0S1NuYUWRklVtzCQF38jGBEw6aqUXY17Fo/2nvK5RVdqh0BOA==
X-Received: by 2002:a17:907:2d93:b0:b2b:a56f:5434 with SMTP id a640c23a62f3a-b30264ae4cemr297619266b.13.1758644636876;
        Tue, 23 Sep 2025 09:23:56 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b29912fb4d2sm744651166b.14.2025.09.23.09.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 09:23:56 -0700 (PDT)
Message-ID: <4f8b0d49-f81c-4716-a60f-2a0d7042badd@redhat.com>
Date: Tue, 23 Sep 2025 18:23:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Fix a semi theoretical bug in
 kvm_arch_async_page_present_queued
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20250813192313.132431-1-mlevitsk@redhat.com>
 <20250813192313.132431-3-mlevitsk@redhat.com>
 <7c7a5a75-a786-4a05-a836-4368582ca4c2@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <7c7a5a75-a786-4a05-a836-4368582ca4c2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/25 17:58, Paolo Bonzini wrote:
> - on the other side, after clearing page_ready_pending, there will be a
> check for a wakeup:
> 
>    WRITE_ONCE(page_ready_pending, false);
>    smp_mb();
>    if (kvm_check_request(KVM_REQ_APF_READY, vcpu))
>      kvm_check_async_pf_completion(vcpu)
> 
> except that the "if" is not in kvm_set_msr_common(); it will happen
> naturally as part of the first re-entry.

Important thing that I forgot to mention: the above only covers the race 
case.  There's also the case where KVM_REQ_APF_READY has been cleared 
already, and for that one the call to kvm_check_async_pf_completion() is 
*also* needed in kvm_set_msr_common().

Paolo

> 
> So let's look at the changes you need to make, in order to make the code
> look like the above.
> 
> - using READ_ONCE/WRITE_ONCE for pageready_pending never hurts
> 
> - here in kvm_arch_async_page_present_queued(), a smp_mb__after_atomic()
> (compiler barrier on x86) is missing after kvm_make_request():
> 
>          kvm_make_request(KVM_REQ_APF_READY, vcpu);
>      /*
>       * Tell vCPU to wake up before checking if they need an
>       * interrupt.  Pairs with any memory barrier between
>       * the clearing of pageready_pending and vCPU entry.
>       */
>      smp_mb__after_atomic();
>          if (!READ_ONCE(vcpu->arch.apf.pageready_pending))
>                  kvm_vcpu_kick(vcpu);
> 
> - in kvm_set_msr_common(), there are two possibilities.
> The easy one is to just use smp_store_mb() to clear
> vcpu->arch.apf.pageready_pending.  The other would be a comment
> like this:
> 
>      WRITE_ONCE(vcpu->arch.apf.pageready_pending, false);
>      /*
>       * Ensure they know to wake this vCPU up, before the vCPU
>       * next checks KVM_REQ_APF_READY.  Use an existing memory
>       * barrier between here and thenext kvm_request_pending(),
>       * for example in vcpu_run().
>       */
>      /* smp_mb(); */
> 
> plus a memory barrier in common code like this:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 706b6fd56d3c..e302c617e4b2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11236,6 +11236,11 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>           if (r <= 0)
>               break;
> 
> +        /*
> +         * Provide a memory barrier between handle_exit and the
> +         * kvm_request_pending() read in vcpu_enter_guest().  It
> +         * pairs with any barrier after kvm_make_request(), for
> +         * example in kvm_arch_async_page_present_queued().
> +         */
> +        smp_mb__before_atomic();
>           kvm_clear_request(KVM_REQ_UNBLOCK, vcpu);
>           if (kvm_xen_has_pending_events(vcpu))
>               kvm_xen_inject_pending_events(vcpu);
> 
> 
> The only advantage of this second, more complex approach is that
> it shows *why* the race was not happening.  The 50 clock cycles
> saved on an MSR write are not worth the extra complication, and
> on a quick grep I could not find other cases which rely on the same
> implicit barriers.  So I'd say use smp_store_mb(), with a comment
> about the pairing with kvm_arch_async_page_present_queued(); and write
> in the commit message that the race wasn't happening thanks to unrelated
> memory barriers between handle_exit and the kvm_request_pending()
> read in vcpu_enter_guest.
> 
> Thanks,
> 
> Paolo
> 
> 


