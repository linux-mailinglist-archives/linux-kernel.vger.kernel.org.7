Return-Path: <linux-kernel+bounces-605093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20273A89CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 697993A5726
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 11:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409B292937;
	Tue, 15 Apr 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CuF3JQhw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0D28E604
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717360; cv=none; b=XESLTlG9Z/No/gsK7AIIvjyrgk7OvaH/SO3nyCaikKVuf2LQSZqHa5bZHWQNZqBbweiQY2S8ArbROIAgucZHD33Ldl2iAlvjY3h2GCK+C1IxiMzCny8KxZLKoOYfHxXoxLQ9fC21q1rINnOdfa6HBycAY9lJxjV09EbcSxuHZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717360; c=relaxed/simple;
	bh=kGHt4Afde1omI4nmqg2jcNzajV+HMy/TkkjZtuU0bQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t03YrnHU041+rvc33zLLAVeaJ+rKd6k5GJuJTwvrXBnhpwljZY+Cr2p14VW6rCOsKKT4wIh+l6QKEiaPx9Rrz4bK2GcgP2Zqfk8+oOMkRHhaQuayOENA2AGFujxnwrKsQbIC1siEiHSs7kSWbEFzzoHTsBCVo9KBzgGIBt6CxSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CuF3JQhw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744717357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=21sufny1Dz2xylrlxmH87I6QNpgSN7tCAQpjobld9eE=;
	b=CuF3JQhwMvIZo5BuobeuzPoS3NUudthjsSwytSvv7xNHR22X6ga0/n/+9UJTVa2CMFQByT
	iWgWfdaGt2Zs1k0wmWKZC0Y4ZcV19+/jbM0KzbgpTt4hBlBYvbdjWM4wwse7MWExeIX7BU
	72FDlOXpB492oMu0VYg08Xj0THj8j2Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-opxIclUqNFKaNREi3gHBYA-1; Tue, 15 Apr 2025 07:42:36 -0400
X-MC-Unique: opxIclUqNFKaNREi3gHBYA-1
X-Mimecast-MFC-AGG-ID: opxIclUqNFKaNREi3gHBYA_1744717355
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so33852025e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 04:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744717355; x=1745322155;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21sufny1Dz2xylrlxmH87I6QNpgSN7tCAQpjobld9eE=;
        b=hX1SCcHgRpTlJdU3rcveyclJ0BYTanmDzloHQeVvAyVOumWtqgfkCzth6JBLe1lKSJ
         WqamAYZVBc6qeADn/6REbDgZ4pfeCllp94w1LULrIkTzNU6eI/vvLOY8js/q0c9Ct809
         Ui2moUGBxmzbSHE9DhHGwd6TCldet38A8Kyu0AEUoO9NdJdtHrJmrtNKj9FH8gTksvc7
         vhrX+TD75XRiXR79IOegJO2+s4FgrTC8g8j1phP9lTfsoz0+KA3K0MoYu68kwb+bHvkb
         qTPJI/wfpMG4lSkYoCySm6HPhNdiaGyOxiO/JkJCFOKYgJgrr85A20cffxaSL6TNDZfn
         GSZw==
X-Forwarded-Encrypted: i=1; AJvYcCVy2YhUdx51V83i2//EZmb6WalS75v1Sq9oMg7ciak5BLgtF9rQjhZptCWQ+eVOvGvZ0tDhYm8DNUunnmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCn8Fz2DmaI7nMoB76tdPan2tNVZCqmMQdn/3BSJazKXV0ocs
	PJS16vA2x9bJh0XSflLIr3ajEnND2OeJp/fAPYhz5pHTPV9QXIbnNLmz8TUVjqjTFSanSDlB1XA
	UEqvnELVTbIPFtEcVD5rqKQDCRqMdExNk6Y9ptAFRsma0a5qh7of+UXAGcY/9Pg==
X-Gm-Gg: ASbGncsZhIgiau01DaJaXwgCRLHUnEzguRBHZlto0KAG0T4WaoKlJrAObS3t9/thS6g
	alybpY2dQn3J2YtvwzW4LXVjEwd0pgXbATR7fiTrhKeopAZl+jerJcq/nu6ZZ9G+ejMdx3W9M34
	SArqBynumuoG6EoogDOHqt05vMBJ+UNuiUoWCnOVQThN2HYMBtWp/vGNgL8hLFyytxmslzhPZhJ
	zw3ksHGCKUqDU5M/hiYejbsgOFkoJauP/tsW0EQSZqRVmNyJwNpuhhIj5SZGZpbhElUnF5MVnSV
	3hYENPklwqOH0aTt
X-Received: by 2002:a05:6000:430b:b0:39c:c64e:cf58 with SMTP id ffacd0b85a97d-39eaaed2d29mr12784967f8f.55.1744717355473;
        Tue, 15 Apr 2025 04:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOEK9OlZm2HlwrtOSS4aaebl8dVeZW7yEvXuCXhTSQfqaHyUlXVO19zQoEuFcqOOz4aNSlrw==
X-Received: by 2002:a05:6000:430b:b0:39c:c64e:cf58 with SMTP id ffacd0b85a97d-39eaaed2d29mr12784946f8f.55.1744717355136;
        Tue, 15 Apr 2025 04:42:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f2338db88sm208832245e9.6.2025.04.15.04.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 04:42:34 -0700 (PDT)
Message-ID: <1b29eed0-fafc-427b-bd70-5dd087f2c0dd@redhat.com>
Date: Tue, 15 Apr 2025 13:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/67] iommu/amd: WARN if KVM attempts to set vCPU
 affinity without posted intrrupts
To: Sean Christopherson <seanjc@google.com>,
 Sairaj Kodilkar <sarunkod@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, David Matlack
 <dmatlack@google.com>, Naveen N Rao <naveen.rao@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-7-seanjc@google.com>
 <0895007e-95d9-410e-8b24-d17172b0b908@amd.com> <Z_ki0uZ9Rp3Fkrh1@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <Z_ki0uZ9Rp3Fkrh1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/25 16:10, Sean Christopherson wrote:
> On Fri, Apr 11, 2025, Sairaj Kodilkar wrote:
>> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
>>> WARN if KVM attempts to set vCPU affinity when posted interrupts aren't
>>> enabled, as KVM shouldn't try to enable posting when they're unsupported,
>>> and the IOMMU driver darn well should only advertise posting support when
>>> AMD_IOMMU_GUEST_IR_VAPIC() is true.
>>>
>>> Note, KVM consumes is_guest_mode only on success.
>>>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>    drivers/iommu/amd/iommu.c | 13 +++----------
>>>    1 file changed, 3 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>> index b3a01b7757ee..4f69a37cf143 100644
>>> --- a/drivers/iommu/amd/iommu.c
>>> +++ b/drivers/iommu/amd/iommu.c
>>> @@ -3852,19 +3852,12 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
>>>    	if (!dev_data || !dev_data->use_vapic)
>>>    		return -EINVAL;
>>> +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
>>> +		return -EINVAL;
>>> +
>>
>> Hi Sean,
>> 'dev_data->use_vapic' is always zero when AMD IOMMU uses legacy
>> interrupts i.e. when AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) is 0.
>> Hence you can remove this additional check.
> 
> Hmm, or move it above?  KVM should never call amd_ir_set_vcpu_affinity() if
> IRQ posting is unsupported, and that would make this consistent with the end
> behavior of amd_iommu_update_ga() and amd_iommu_{de,}activate_guest_mode().
> 
> 	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> 		return -EINVAL;
> 
> 	if (ir_data->iommu == NULL)
> 		return -EINVAL;
> 
> 	dev_data = search_dev_data(ir_data->iommu, irte_info->devid);
> 
> 	/* Note:
> 	 * This device has never been set up for guest mode.
> 	 * we should not modify the IRTE
> 	 */
> 	if (!dev_data || !dev_data->use_vapic)
> 		return -EINVAL;
> 
> I'd like to keep the WARN so that someone will notice if KVM screws up.

Makes sense, avic_pi_update_irte() returns way before it has the 
occasion to call irq_set_vcpu_affinity().

Paolo


