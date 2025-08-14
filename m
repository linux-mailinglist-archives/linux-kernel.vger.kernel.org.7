Return-Path: <linux-kernel+bounces-769185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B3B26B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942B1AA2D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB322FF37;
	Thu, 14 Aug 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7pKTYJL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1022D7B9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185692; cv=none; b=VJObn4kuGU+DM2Ypz+Gep/rR7e9Ptz7Ds4IjLjbvnJVD4P3cJHBr+5HeuiEyxVzcYioPuwWkNwIKUGyhzcTBwdRe4o05Fx/ZMYyEtJ1WUXsfQWPH7hjpFHhLp6JF6NsmhW/wNdfODRisZI98Rw9rLI0zNR5SZjWAv/y3vp8bzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185692; c=relaxed/simple;
	bh=xvGL7DY8ZMo2Ei32WQZRQ6BKK5rxE+s60T1JZuZ1YB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mkMwrOASCDjQFALiRoFXt532mMNGW1+ODqjS5JEnQhf4GSTBHZ7QNgPGkyC2OOLeHGxTpa03PY6GtYRI3s7tRaw0KKCfhaEY6q0NRLCB8OnF5Tl+lsQd0FJpHWvk3ToxlR7RVukl4YWDyc9ZGZXxtpYOBbLjMWJgvtUCXGrtXU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7pKTYJL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755185689;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FF21Vrb0E9HgLsPo9WR8fvObdoRI3So91Rz3YvTAOHs=;
	b=C7pKTYJLxkD6YIksYuBYUWRvH63R82yq8bjLY9wFXqKVil1tStLEzoweh8NwPBUOO87Gg+
	wpbpS7AUOiM9MxQBKwuTCI54+191vPrcY/CCmFq7cyW0xU6h88stG66ABIFrwfLPwVzumu
	OydiEmUZDoawuYP6UZ8I6md3+B/Mf7A=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-uNQgqzOzO_akOk2GF8ffOA-1; Thu, 14 Aug 2025 11:34:47 -0400
X-MC-Unique: uNQgqzOzO_akOk2GF8ffOA-1
X-Mimecast-MFC-AGG-ID: uNQgqzOzO_akOk2GF8ffOA_1755185686
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-53b174f6477so573816e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755185686; x=1755790486;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF21Vrb0E9HgLsPo9WR8fvObdoRI3So91Rz3YvTAOHs=;
        b=t1WaIrMmAFLfp9Thg2/1yyR1MJaz0DB1kw5hSjCl1EPsk7ptpnWg3tP82jtBZ/YtKY
         hwkh+jRTQQrTzXzoGUO2YhuOh7TLSAjgcWMOuuaJr0fYDnFv+LA1C8Ckz5oJ165tlz+N
         q7Sd0vgm5WlKI/6DMgIR8PdSbR21oFfpUZVY2tgyRBmbL54A04ReWydjl8YcxGbMIXqa
         e5DLqpoKTHAoLe6Z6mFnSYXtwN1n/ClesmmkkQ51lEsPgw9G4aMkjhYC9KDpULNcV8Xe
         ucm0AeT3S331LHsI06iXRZuHMcafBZPYqFHldZeBmrUxNwOSoOyzSpgJ5Gwd8LJXO7BE
         26gQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5y50fbeahBWqbbxXznFmrcBWAQ7n2+zhTnvYK52eqkPrZK/3BOpjckyCJz/TbTPjiPvFV/eud3RDsjl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPG+N/XsYgtF8ToUKxH05PXRm1iCFoSJDJ8M9xpUCCsJz7vouf
	I2+sM0whuZ3opbw2TL7mmJzBgxSbmGz5HdP4u37VTU6vos18Uqv6w1nH5mldLKmVfm68Lc/yO3X
	EtDcT8qChnBPtBWwLV0BG5IjMCUnXWvtmUPzACiVeotyIBnlnv4qgkTHXtHe4toVM2g==
X-Gm-Gg: ASbGnctbVvivQ87lK4QQhTr+zjgnSBVqt2j85Ayxd6peBB8gzlOayENMNqj8Wu0IWtv
	MOKeqAuEIOPqq07jPy+TqlapSRC70vLCYMfagTnsLUatijdDTgxwhwEDtVdy29jzDQgw8uMlLu+
	Ahzyg+SgcApJodJfD5zCoGibCSSiGXVGWsrLWqxrL4cawkuOmD0VTu3MEhKT81z9rMvQsKapNip
	rMU1fuDDK+ZsCMIkVUSnp47071NGVfJYLU/FVv7j2SvHRn8HeFoRXZL9Xs/tcX458UXjOTVhKaa
	wMv+yiBwD4SmDFNdlWwbQ7afBTCNhFxFAIkU1R2hUMIpN0IBpl6CzQk399l3/Y+jlPkVtvW9k2R
	7VDRp1atzrgo=
X-Received: by 2002:a05:6102:d93:b0:4e7:5f31:7443 with SMTP id ada2fe7eead31-50fe0c158a1mr1427616137.9.1755185686476;
        Thu, 14 Aug 2025 08:34:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+/6dKe1kJ911yQbOAzRDTDCXbofqZKWFiMIThFR3OOIAtFum7vkGGy+nnE5DHeftlrWrxEg==
X-Received: by 2002:a05:6102:d93:b0:4e7:5f31:7443 with SMTP id ada2fe7eead31-50fe0c158a1mr1427588137.9.1755185686046;
        Thu, 14 Aug 2025 08:34:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5b82985sm13963766d6.65.2025.08.14.08.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 08:34:45 -0700 (PDT)
Message-ID: <e9212299-d66c-4779-93f9-3bb5833e5c07@redhat.com>
Date: Thu, 14 Aug 2025 17:34:43 +0200
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
 <3fdbd23d-cd65-453b-aa8d-78f9ed1bc4c4@redhat.com>
 <6065d82b-0a07-4f82-8b4e-9c00374d2f71@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6065d82b-0a07-4f82-8b4e-9c00374d2f71@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/14/25 5:28 PM, Robin Murphy wrote:
> On 14/08/2025 4:19 pm, Eric Auger wrote:
>> Hi Robin
>>
>> On 8/14/25 4:53 PM, Robin Murphy wrote:
>>> On 14/08/2025 3:17 pm, Eric Auger wrote:
>>>> Commit bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>>>> probe path") broke virtio-iommu probing and no iommu group are
>>>> produced anymore.
>>>>
>>>> When probe_iommu_group() gets called viommu_probe_device() fails
>>>> because viommu_get_by_fwnode(fwspec->iommu_fwnode) returns NULL.
>>>
>>> ...which it's not supposed to. And *now* I remember, we never got this
>>> finished, did we?
>> Seems we did not ;-)
>>>
>>> https://lore.kernel.org/linux-iommu/9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com/
>>>
>>>
>>
>> Unfortunately it does not fix my issue. Still no iommu group when
>> booting with ACPI.
>
> Indeed the evidence at the time suggested the patch isn't quite right
> as-is, but that is definitely the place which needs fixing. Since
> Jean-Philippe's occupied with more exciting things at the moment, do
> you happen to have an easy recipe for testing virtio-iommu so I can
> try debugging it myself?
No easy recipe. on my end I am using qemu/kvm with a rhel guest and
custom kernel. I guess it was integrated in kvmtool, wasn't it? I am
just testing with protected virtio devices.

Thanks

Eric
>
> Cheers,
> Robin.
>
>>
>> Thanks
>>
>> Eric
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> So it seems we need to restore the original iommu_probe_device
>>>> call site in acpi_iommu_configure_id() to get a chance to probe
>>>> the device again.
>>>>
>>>> Maybe this defeats the whole purpose of the original commit but
>>>> at least it fixes the virtio-iommu probing.
>>>>
>>>> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper
>>>> probe path")
>>>> Cc: stable@vger.kernel.org # v6.15+
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> I also tested smmu probing and this seems to work fine.
>>>> ---
>>>>    drivers/acpi/scan.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>>>> index fb1fe9f3b1a3..9f4efa8f75a6 100644
>>>> --- a/drivers/acpi/scan.c
>>>> +++ b/drivers/acpi/scan.c
>>>> @@ -1632,6 +1632,13 @@ static int acpi_iommu_configure_id(struct
>>>> device *dev, const u32 *id_in)
>>>>            err = viot_iommu_configure(dev);
>>>>        mutex_unlock(&iommu_probe_device_lock);
>>>>    +    /*
>>>> +     * If we have reason to believe the IOMMU driver missed the
>>>> initial
>>>> +     * iommu_probe_device() call for dev, replay it to get things in
>>>> order.
>>>> +     */
>>>> +    if (!err && dev->bus)
>>>> +        err = iommu_probe_device(dev);
>>>> +
>>>>        return err;
>>>>    }
>>>>    
>>>
>>
>


