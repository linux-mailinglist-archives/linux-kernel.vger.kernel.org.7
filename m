Return-Path: <linux-kernel+bounces-829559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE136B97569
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670854423CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05A3043CF;
	Tue, 23 Sep 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gptIDx1O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C272273D83
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655745; cv=none; b=Iqb6STKIrijSe1jwen1O6qGBoVZg/vqfgB4e/7j8REID33tdkVyk5DoIAK/UIkscFgtW3+jaHA4DYFfZpCS0EhbRIA+uBDaGfufECsYWn5XeAinnBxVzWQNOn7eWGMSASvRCAoe09cGMQREyroAZ2gIWvhJs+pqBwmCEe/2gCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655745; c=relaxed/simple;
	bh=sd6VAObrBzzzEowZBcw8e4ug303YzqZT+i/Pp2dtH0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBFoknzM/WbDL16p7RIir0VcvYkLc+7dZXcjIgsDgjru3fZoyRRhB37AFWsd/ojstHRyDSzN5R71hSY/mNVYJjjbxptqMcYFRXyN6LHXwZLPzSPe5bprcakuEQYK2onWjC2ZifkX/DDXrNHXhUFgwTvoMI0k9u6Xsn/OXGELYWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gptIDx1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758655742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TNQtlDw4FEjV9R6iQt9meK1BGnFS2n1mV6dUS+jU7Uo=;
	b=gptIDx1OcmWLjcufQbPe75pUHp9hIt8rYNe6IWt0kEtQ50UX6tZUpYaKsuIvg2iMVXcflB
	W9gAF1yE1+XKFFOk7zdymWguZt3G/GrgQL1xnMU4NrUl9Rj19aooLo4F8EsG7tRdSArIxo
	JIltMahpSxoGpU4pcT4p7Xh/RX6LeFc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-BqhOGkW0MWS3Z9tcuns2lQ-1; Tue, 23 Sep 2025 15:29:00 -0400
X-MC-Unique: BqhOGkW0MWS3Z9tcuns2lQ-1
X-Mimecast-MFC-AGG-ID: BqhOGkW0MWS3Z9tcuns2lQ_1758655740
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b049daba3deso19769766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655739; x=1759260539;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNQtlDw4FEjV9R6iQt9meK1BGnFS2n1mV6dUS+jU7Uo=;
        b=MCR1r8VOsm8apnWkZYmBXBno1GA3mBqo8ha+OBplZ5s2A8ML2iGIO8TNgTtrQPIiC9
         kjnhzoshB7gOkUP1/i8YQYY2Lg638mjm+9lnpvULSjLcR/HuIvKG1WVIYVUlpLyBDmKW
         0PpBDhxggH+OcxfgUMgQebDz9PrRj0tOPChPTbwD0RcnkL9C968ISWkkFpIEyINjtLEa
         JbkWaAAEnd5nUj+zGU4slLRZRZPZjLxHlMTjEs/Y6uq77FF21fRiv3KlOPYwrU7GvflV
         9dKWGkaikSSMEYQsSFXlJIaJRuZ3bDNSygZehMGOCxclEINTDGVxj7PSi4ybSKwOOavH
         vqAg==
X-Forwarded-Encrypted: i=1; AJvYcCWzXziDYmq4DkWoduObZaAeYHApq5p7xwKIeMJpUe1OwZMT+w+FzZPwAFd6oKThVp1j58J6cpJfIgh4Vuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr61WHqa3yV8eh6Tos7EISxI93zmUntXyl43FOQnP6JBNuNEV3
	N7i/6JbdFL1Aj3fBkJUBUg8ELUWrlDZUwa+v4w5k5EEpUOZpBEDm5Yw4F7TaearlMGuZK16wsOw
	ROqmGku98HD6N+QVwdzLoQvCeoOH/Le/lJQvnXa9Fi5NIV/bnY9CHuQsUZsEmSIIuVw==
X-Gm-Gg: ASbGncvWXWDts2lAId1NOPGM/Qr9+UpBaHRl7jYB1qMOat2r/HZ2iT7QvgQ43P5j8Vx
	X5FwXZn/MhcjZNruENuPp/Af6jS8DLXD/HMlXlr49PyLAKXrKEX6lfZmh5K5txNfyFdlQLkQvie
	zXLz6krSJHtKhDpMPKL78PWXof0Fd2kmdehCrvAqnh73drPLlcUUutQhMZHidW/t6sGUCy2iUm2
	85DB3cAxS1rgCiWqJ/O5Ec4wdR3KUeEzELAud+N9XYm2Zuk3EZcq+3VNT4Kl1zl8nm17fKvDiEC
	CBftQ8d34C8tY5fvZ5i8J5l6nCi1ekFNmRPNJGoImMsNlDXl3RfNAA8lo6DlGUc6d9D1nBLDycD
	OJF1t1FA9aYol6wrRbAJi4xivZG9T1fy8bIWB3TVauMWAlA==
X-Received: by 2002:a17:907:6d1f:b0:b04:7eba:1b55 with SMTP id a640c23a62f3a-b301c949952mr378892366b.19.1758655739432;
        Tue, 23 Sep 2025 12:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwgK+9y2tnAvcbijCMOsN1/IJbEuP6rc+Zd9Nsg0/Zt/SIt7mt984i4E7/P5V+usRO7zCuRA==
X-Received: by 2002:a17:907:6d1f:b0:b04:7eba:1b55 with SMTP id a640c23a62f3a-b301c949952mr378890466b.19.1758655739062;
        Tue, 23 Sep 2025 12:28:59 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b2adc17af3asm676542166b.6.2025.09.23.12.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 12:28:58 -0700 (PDT)
Message-ID: <23f11dc1-4fd1-4286-a69a-3892a869ed33@redhat.com>
Date: Tue, 23 Sep 2025 21:28:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Fix a semi theoretical bug in
 kvm_arch_async_page_present_queued
To: Sean Christopherson <seanjc@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <20250813192313.132431-1-mlevitsk@redhat.com>
 <20250813192313.132431-3-mlevitsk@redhat.com>
 <7c7a5a75-a786-4a05-a836-4368582ca4c2@redhat.com>
 <aNLtMC-k95pIYfeq@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aNLtMC-k95pIYfeq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/25 20:55, Sean Christopherson wrote:
> On Tue, Sep 23, 2025, Paolo Bonzini wrote:
>> On 8/13/25 21:23, Maxim Levitsky wrote:
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index 9018d56b4b0a..3d45a4cd08a4 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -13459,9 +13459,14 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
>>>    void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
>>>    {
>>> -	kvm_make_request(KVM_REQ_APF_READY, vcpu);
>>> -	if (!vcpu->arch.apf.pageready_pending)
>>> +	/* Pairs with smp_store_release in vcpu_enter_guest. */
>>> +	bool in_guest_mode = (smp_load_acquire(&vcpu->mode) == IN_GUEST_MODE);
>>> +	bool page_ready_pending = READ_ONCE(vcpu->arch.apf.pageready_pending);
>>> +
>>> +	if (!in_guest_mode || !page_ready_pending) {
>>> +		kvm_make_request(KVM_REQ_APF_READY, vcpu);
>>>    		kvm_vcpu_kick(vcpu);
>>> +	}
>>
>> Unlike Sean, I think the race exists in abstract and is not benign
> 
> How is it not benign?  I never said the race doesn't exist, I said that consuming
> a stale vcpu->arch.apf.pageready_pending in kvm_arch_async_page_present_queued()
> is benign.

In principle there is a possibility that a KVM_REQ_APF_READY is missed. 
Just by the reading of the specs, without a smp__mb_after_atomic() this 
is broken:

	kvm_make_request(KVM_REQ_APF_READY, vcpu);
	if (!vcpu->arch.apf.pageready_pending)
    		kvm_vcpu_kick(vcpu);

It won't happen because set_bit() is written with asm("memory"), because 
x86 set_bit() does prevent reordering at the processor level, etc.

In other words the race is only avoided by the fact that compiler 
reorderings are prevented even in cases that memory-barriers.txt does 
not promise.

Paolo


