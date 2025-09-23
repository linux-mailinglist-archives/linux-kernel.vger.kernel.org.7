Return-Path: <linux-kernel+bounces-829280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9FBB96AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B034172560
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42B2E22A9;
	Tue, 23 Sep 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJLKhIWs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14726FA6E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643092; cv=none; b=VSu01BZ/I1i4attKWh8PTyhc7uFwQ+UEEnJ7KYMiHKsvB2StXEK94qdE2Ps/gBm32sOo9aVdNhvbJlmtVMBB6U2b4gJ1Yz53EPWO28wNz/MmCPfyYZwCeaoX3awCVtbgyT+A10L6u9Y2EZGThFzT+tL6muAT0mYqgn0jLONVxPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643092; c=relaxed/simple;
	bh=WZ4DNaxOgyOrfwIlHPhd6A559fN5fAE3al+C7vhTkk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVm6p0mRd6sebK+3W7w94OwxmB8zafBY/++nAUnp4mdCcIyrNrZcqs8BMIufE5GuLzIbRZVyIP9E3BIjv4OuGb16i12jAQ/Wd2BcYownJkGcgP/SnMjav+jmY8fGL1Qjvk0Uy3RZj3UsiHdGMsd3HVhXtKWhfgJSecMMTG0MvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJLKhIWs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758643088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9d3TNqf8jlkrOIuDlAsCdAmPH3oYtwyKBL88rvuUbOU=;
	b=MJLKhIWsvOwoekgHejDo2FrjrYX9suyZ3fXgPV70RCAXWX6lWEtQWt4OFhj2pC7H/UT/sz
	hXC+pcwrhFfT86vBXY//lbg66EPM32d2h8qt5B0EQltlSK9bwF9D7WCqTCU+MMx2pGN4VO
	sjVOmTT41rk1k11fimlpJyJ8MyXLoF4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-sHq7xlW3OXiN4mk3VWHWeQ-1; Tue, 23 Sep 2025 11:58:07 -0400
X-MC-Unique: sHq7xlW3OXiN4mk3VWHWeQ-1
X-Mimecast-MFC-AGG-ID: sHq7xlW3OXiN4mk3VWHWeQ_1758643086
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-632ee8486fcso1909702a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643086; x=1759247886;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9d3TNqf8jlkrOIuDlAsCdAmPH3oYtwyKBL88rvuUbOU=;
        b=EaiL+r5QMaYsMGUR5Rn4xh3dbfvNpHxbL7tm46xFh0iWr1WEKaadMNGt6LMmRhPiuW
         IHRDDxoZ7EKGqU4w4yFfJAPCkxSnjTsljzNDSW+WLqCeoXL73QF8dlX30LDI1FqgBRiv
         /gUjU3jkoa77wyZFiHAAX/n0zn86RlVCKp11Q2Tvcexfhh87bQhUZU/SuuWG5E790yYZ
         oyMZSm5xjMWQzIMxFu4Y209ps2qvHf1tBDR0c4m3fM0IYgWz24KFSoeiTrJyPPNJ2Gmz
         DIhfmtVpfulmsc/D/Yn7ShDIQed/jKs2E/322PsCqVyecnp8TpYkBohEUKQfmJNdtNPq
         ZxRw==
X-Forwarded-Encrypted: i=1; AJvYcCUmc+g5zuMzhYUF94pI9GDPZ3S4PjJed/kTzTg9YD2u8KDyYp+dlii6Rx4CrgTKl5DXipMcszi+BoOnwVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNeb6vsJItjFqaIwwBUqUjyTE5MZx6mqMiFubSzkqaLDn+nWtF
	ogRYBXfxrQaRD2UOqihqm0EnB6NjfbJDxAawcmTluMGQL6/lOVvFZxJen+cSJBjuqvH/aCLXOx3
	zZFv03ajdrEY3XdDAEuDo6vUbeqH+GGxGpiU0uKyBCG0A4+zr9AyNhBhJgQV614/FyA==
X-Gm-Gg: ASbGnctC3QM1ksV9px6C5Yzil9U3IOP5v0WMw6hU74EvJdNobARArNd5hcJ8L5XD+rh
	pPzVtDWZcmkScr21oBgeKJStIyAsOvC1gKcIxHD+b/eTt9Sta9MyQDU5TsbJA7obGHThv7GLlb8
	uDTV29lmrVJFHOU+7v+J+vlZCJOr0HTZjkci0OV4SGoWz78X/JyX/s2eMMjsGDPWR1JPnjVIhL2
	hBnqvXrw7eBUlNr02C31ZcvNrkQ85a2ZCgFZ6Gp31maBLm0w8WULH27zBjmFS1GPoWVhlRUtwrk
	MUuICssyfJPvN+EnJ4qhTgmTitfz01/fgLHunonSsktSs/OaEm4hyTgDVMUe/RYnOeP5etcu3T6
	pVXLvHaott0TgBQqojOYM4YTecDIJx7z0r4vNwAKxlDretw==
X-Received: by 2002:a05:6402:35c2:b0:633:7017:fcc7 with SMTP id 4fb4d7f45d1cf-634677b58fbmr2614866a12.10.1758643085840;
        Tue, 23 Sep 2025 08:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGETODyvlWeYh+fQuYF1s139fQ8a3Y0NNeQNJi+UjfqyHNfq+hya1YJmAC8wr2k79dPO2rLkQ==
X-Received: by 2002:a05:6402:35c2:b0:633:7017:fcc7 with SMTP id 4fb4d7f45d1cf-634677b58fbmr2614836a12.10.1758643085325;
        Tue, 23 Sep 2025 08:58:05 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f27640sm10916316a12.39.2025.09.23.08.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:58:04 -0700 (PDT)
Message-ID: <7c7a5a75-a786-4a05-a836-4368582ca4c2@redhat.com>
Date: Tue, 23 Sep 2025 17:58:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Fix a semi theoretical bug in
 kvm_arch_async_page_present_queued
To: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20250813192313.132431-1-mlevitsk@redhat.com>
 <20250813192313.132431-3-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250813192313.132431-3-mlevitsk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 21:23, Maxim Levitsky wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9018d56b4b0a..3d45a4cd08a4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13459,9 +13459,14 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>   
>   void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
>   {
> -	kvm_make_request(KVM_REQ_APF_READY, vcpu);
> -	if (!vcpu->arch.apf.pageready_pending)
> +	/* Pairs with smp_store_release in vcpu_enter_guest. */
> +	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);
> +	bool page_ready_pending = READ_ONCE(vcpu->arch.apf.pageready_pending);
> +
> +	if (!in_guest_mode || !page_ready_pending) {
> +		kvm_make_request(KVM_REQ_APF_READY, vcpu);
>   		kvm_vcpu_kick(vcpu);
> +	}

Unlike Sean, I think the race exists in abstract and is not benign, but
there are already enough memory barriers to tame it.

That said, in_guest_mode is a red herring.  The way I look at it, is
through the very common wake/sleep (or kick/check) pattern that has
smp_mb() on both sides.

The pair you are considering consists of this  function (the "kick
side"), and the wrmsr handler for MSR_KVM_ASYNC_PF_ACK (the "check
side").  Let's see how the synchronization between the two sides
happens:

- here, you need to check whether to inject the interrupt.  It looks
like this:

   kvm_make_request(KVM_REQ_APF_READY, vcpu);
   smp_mb();
   if (!READ_ONCE(page_ready_pending))
     kvm_vcpu_kick(vcpu);

- on the other side, after clearing page_ready_pending, there will be a
check for a wakeup:

   WRITE_ONCE(page_ready_pending, false);
   smp_mb();
   if (kvm_check_request(KVM_REQ_APF_READY, vcpu))
     kvm_check_async_pf_completion(vcpu)

except that the "if" is not in kvm_set_msr_common(); it will happen
naturally as part of the first re-entry.


So let's look at the changes you need to make, in order to make the code
look like the above.

- using READ_ONCE/WRITE_ONCE for pageready_pending never hurts

- here in kvm_arch_async_page_present_queued(), a smp_mb__after_atomic()
(compiler barrier on x86) is missing after kvm_make_request():

         kvm_make_request(KVM_REQ_APF_READY, vcpu);
	/*
	 * Tell vCPU to wake up before checking if they need an
	 * interrupt.  Pairs with any memory barrier between
	 * the clearing of pageready_pending and vCPU entry.
	 */
	smp_mb__after_atomic();
         if (!READ_ONCE(vcpu->arch.apf.pageready_pending))
                 kvm_vcpu_kick(vcpu);

- in kvm_set_msr_common(), there are two possibilities.
The easy one is to just use smp_store_mb() to clear
vcpu->arch.apf.pageready_pending.  The other would be a comment
like this:

	WRITE_ONCE(vcpu->arch.apf.pageready_pending, false);
	/*
	 * Ensure they know to wake this vCPU up, before the vCPU
	 * next checks KVM_REQ_APF_READY.  Use an existing memory
	 * barrier between here and thenext kvm_request_pending(),
	 * for example in vcpu_run().
	 */
	/* smp_mb(); */

plus a memory barrier in common code like this:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 706b6fd56d3c..e302c617e4b2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11236,6 +11236,11 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
  		if (r <= 0)
  			break;
  
+		/*
+		 * Provide a memory barrier between handle_exit and the
+		 * kvm_request_pending() read in vcpu_enter_guest().  It
+		 * pairs with any barrier after kvm_make_request(), for
+		 * example in kvm_arch_async_page_present_queued().
+		 */
+		smp_mb__before_atomic();
  		kvm_clear_request(KVM_REQ_UNBLOCK, vcpu);
  		if (kvm_xen_has_pending_events(vcpu))
  			kvm_xen_inject_pending_events(vcpu);


The only advantage of this second, more complex approach is that
it shows *why* the race was not happening.  The 50 clock cycles
saved on an MSR write are not worth the extra complication, and
on a quick grep I could not find other cases which rely on the same
implicit barriers.  So I'd say use smp_store_mb(), with a comment
about the pairing with kvm_arch_async_page_present_queued(); and write
in the commit message that the race wasn't happening thanks to unrelated
memory barriers between handle_exit and the kvm_request_pending()
read in vcpu_enter_guest.

Thanks,

Paolo


