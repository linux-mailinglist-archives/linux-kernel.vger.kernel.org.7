Return-Path: <linux-kernel+bounces-769161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E895B26AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1431BB61218
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63988221FDD;
	Thu, 14 Aug 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4WdoAyM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D21220F5C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184803; cv=none; b=WkTqz0+ZXByvnjWNVKbxKf0kPs8Y4+jdX/vluqWJTym3bqHexmfdCGE49TlillGWYZvsZqY5vspQPw8uJRT9lZGt/HDLe21Qc7PqXuHcB1/ODgYbTKWZAhCiRCR3igymFGDN7VPjiKNp1fouq7bnRHWUllCifKE8K/H8U8CQ1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184803; c=relaxed/simple;
	bh=Me9loLch93dkc0dpmXGYnGiHnYvadiSaEhticdiiJe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RVdFQhpSeu6NFX6gmLIsShV/1ud6x3dncJUT3d7x4eSFq0ck7blr6cp2ITalRPf+ufYM4vUjr4mnnN7zGgXQ4pW9V2QmSibYx+xhvSbk1DBOpqv/TPF7qXF/V/aJhnXnLoKdtnbPl3K8LxzxprU9WQN07vm1JzfWi0Vezvasavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4WdoAyM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184799;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHIaca87a+Lei/XHRRpk/utjyoa+VsnhzwStKO2yDEo=;
	b=i4WdoAyMhIPe95scalyzetKf7MsktcacQAws5iBPmTPBbGljFLbt+potUK2lGIu7l2YaiD
	ALhlROzZb4b+q2u+hZ7sjZbX6Ss+LaPLtpSEbHO//umIK12tG4RqXzTRLK8vnPVdPn6oWr
	giKCn4BH0K6SUa2TK8Rg93ILwqEYZRg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-DKyKJxDCM4SaIH5WQVTYdA-1; Thu, 14 Aug 2025 11:19:55 -0400
X-MC-Unique: DKyKJxDCM4SaIH5WQVTYdA-1
X-Mimecast-MFC-AGG-ID: DKyKJxDCM4SaIH5WQVTYdA_1755184793
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e864817cb8so527256685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184793; x=1755789593;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHIaca87a+Lei/XHRRpk/utjyoa+VsnhzwStKO2yDEo=;
        b=fAWmUwdmb0nME9HCo2/6PVBuCMa+mZ9jd4okyHN9KnidtMRsQSSufaIi8xCwpm/jnd
         OEEUifs+UTiDHVaaERJdjvJemHV4IX/C77AcmJXBr8Vyk1D+ohI0a6HQ5h4q6vxy9HCe
         lvdPlnN2dn/vZ+QMXSZQ04Rhbi9LSwDI0Z1c+9L7e1PlqilZAcXcT7bcTBmeOx/AW95l
         MGpmXKqr5yOngyQoxXv4QJfpLwrzN25u+YRp1MjtlislnPVWbIZ3hh0X4pjNKmeWkPiV
         8IThSPpR3Egjw2u+cqSna4yp1xW4U4uZvi99cOv515fZsDplcPp0xvpAi7fnghTadsNB
         JXNg==
X-Forwarded-Encrypted: i=1; AJvYcCXsWvHRf9IjVqnOD0sOiNO6VU17aK3umIKgLlRyQqdzD3yDv5Y3QzuBHrfh12JsP7rLhuWHrZsIcd3uMG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaN32GMVBFVCS3XIkuxZmKQr+gXi1GDqNKJzzScErGlaVl/nQ
	u18/MZFyY0yroX/ILLlsRxniBOXXOZRvZlb+H28igGvrF2Cpz3QomUD5kJM0V+x/mxMB5LNm5F9
	sFZBfc+D4YMjQw+MuGd0ZyZElP1XOJ/Op9PntvrDHQn2jtTNxT4Y+BkSqhx6R53JN9Q==
X-Gm-Gg: ASbGncsQrKocWHkx+aP4+Znbwi95Rzy/0icvM+jNoVy/QK/NLrx8CIYQFy9/ucqRROQ
	pCKmRXRKoQVwZtNJ7iLguWhIgsjUZfqsQSIqU5RmnVkrOtbYf3Yc4X7LoKDWqAd0KUcNBhVcjrR
	8yK0h/HTZinB/uvwY//klu6MnNj9vaZro/m/vgNm5+sY1gxs9g/cZtovYRsWsGvNHeL8Ub54nC5
	/BwmdRBQYcGFlJsSOqLOOZKajF/90n2JMS3IrqA9K6p8OLZhF8Toc4CDLC6v2h+l+USuOFpS/iw
	r0BXAIHleaPVKe2h3qgOiuYK76R3eYonfcynE11EQF1n27gcu1VAgOSle1zK7JZua7rXqkP3JUP
	rrr3l4ZiatPY=
X-Received: by 2002:a05:620a:444f:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e87177df9bmr360189285a.21.1755184792064;
        Thu, 14 Aug 2025 08:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbBWvamtmgCDWchP6EGpptPrCEMuK58uAggqkP3T93k3CpPZISIT2j7qtn++KMlZQWGXRgAg==
X-Received: by 2002:a05:620a:444f:b0:7e6:3e26:63b6 with SMTP id af79cd13be357-7e87177df9bmr360184485a.21.1755184791608;
        Thu, 14 Aug 2025 08:19:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e806ad969dsm1617338385a.78.2025.08.14.08.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:19:51 -0700 (PDT)
Message-ID: <3fdbd23d-cd65-453b-aa8d-78f9ed1bc4c4@redhat.com>
Date: Thu, 14 Aug 2025 17:19:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [RFC] iommu: Fix virtio-iommu probing
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, eric.auger.pro@gmail.com,
 rafael@kernel.org, bhelgaas@google.com, jgg@ziepe.ca, lpieralisi@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org,
 jean-philippe@linaro.org, jsnitsel@redhat.com
References: <20250814141758.2140641-1-eric.auger@redhat.com>
 <e3935099-6e29-493d-8587-64ceca8a20e9@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <e3935099-6e29-493d-8587-64ceca8a20e9@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Robin

On 8/14/25 4:53 PM, Robin Murphy wrote:
> On 14/08/2025 3:17 pm, Eric Auger wrote:
>> Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>> probe path") broke virtio-iommu probing and no iommu group are
>> produced anymore.
>>
>> When probe_iommu_group() gets called viommu_probe_device() fails
>> because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
>
> ...which it's not supposed to. And *now* I remember, we never got this
> finished, did we?
Seems we did not ;-)
>
> https://lore.kernel.org/linux-iommu/9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com/
>

Unfortunately it does not fix my issue. Still no iommu group when
booting with ACPI.

Thanks

Eric
>
> Thanks,
> Robin.
>
>> So it seems we need to restore the original iommu_probe_device
>> call site in acpi_iommu_configure_id() to get a chance to probe
>> the device again.
>>
>> Maybe this defeats the whole purpose of the original commit but
>> at least it fixes the virtio-iommu probing.
>>
>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>> probe path")
>> Cc: stable@vger.kernel.org # v6.15+
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I also tested smmu probing and this seems to work fine.
>> ---
>>   drivers/acpi/scan.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index fb1fe9f3b1a3..9f4efa8f75a6 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct
>> device *dev, const u32 *id_in)
>>           err = viot_iommu_configure(dev);
>>       mutex_unlock(&iommu_probe_device_lock);
>>   +    /*
>> +     * If we have reason to believe the IOMMU driver missed the initial
>> +     * iommu_probe_device() call for dev, replay it to get things in
>> order.
>> +     */
>> +    if (!err && dev->bus)
>> +        err = iommu_probe_device(dev);
>> +
>>       return err;
>>   }
>>   
>


