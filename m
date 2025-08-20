Return-Path: <linux-kernel+bounces-778183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FEB2E24C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B365917FAC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785C33436C;
	Wed, 20 Aug 2025 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alaF/U48"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC0334362
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707377; cv=none; b=BiK4g8gFOt7Rg/p+UGaxadltf31n94YZmosOG4Z+hFe4M7TQ+B1EfTi945yFxkZkZNKhSsAJsAvzWk9VBhmSPt1Y5j0sKFaVJR3Cg7Rt1OCfeCFG7gbcX2zDNVcTXXGfLprF3NO2hFruSWSJzQy213mJKy2JcNQfVWexNrHstMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707377; c=relaxed/simple;
	bh=yB9/kqrXtMCDZeR5TGJnCTzHnaoZIdmYniYiOfu9qAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IavX1As7s/6P+1/AS+LNDUBFcbQyabzrOQ3TzVmKa8ztfyCF7pKH3OXPoI3w4bygs4Ecj/uyS5rIrPG6p/J84MHSO1OwDd3CZl3aXldsDLuwtNxXCBCBTrgKntAErAYfvCqsXYl2NmTTrFxezs5wr2OwDBhVF2GM9bojsY0797M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alaF/U48; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755707374;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1o1LRdDzqdgyjQDdaaAAjVa+EmCi41rjJ76ixV1ZeE=;
	b=alaF/U48o15+k5FmOqbz135kSJ6krLmURoe7yO82m/s2S7GZKdosTWLVEQvw40z99GiQfo
	GvTdaV6VDSLOFT7GaixPX2QXtlOMigj/MSQrgcL1/jbDpXoELVYqRt9kQtcHsZ72swF0w6
	fqjS4XRIhyb9Vr7+nRPjooeYAwcq7qE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-EKUfFeENN2m6GuvYg-fRjw-1; Wed, 20 Aug 2025 12:29:31 -0400
X-MC-Unique: EKUfFeENN2m6GuvYg-fRjw-1
X-Mimecast-MFC-AGG-ID: EKUfFeENN2m6GuvYg-fRjw_1755707371
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a92827a70so2535006d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755707371; x=1756312171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1o1LRdDzqdgyjQDdaaAAjVa+EmCi41rjJ76ixV1ZeE=;
        b=txScyiM2Lbi5Uxy9lVDUDosU9XivTWhFNqxVEjsQMs69SUET4CQbAtmeqSBVVHGiRF
         TDceAWI3x1X1dhIVqLQ7uWKA2nDtQ/giB847RvbQDNz9cAVyB1331otD5SsT47dnaOmB
         19LTBTuDpRfOcZ0rKM3ka1z4KcSUnKrLB0ej61HJ6Vb9EU1RFASKpsxwZFpC2kzM3LO1
         KiU1rS67HXbgYTxJiXp7AV8H9/ooA2gsCD7dJMwUS+prcRIONCCz8GboCQzkm6pA2qF5
         M+QoiHZM5FZxpBI+gYzBpMs8nDWPd7cNXb4xKRvAT3IrqXlQYmvi8OZWr1j+7Om1AhPt
         UtOw==
X-Forwarded-Encrypted: i=1; AJvYcCXlyTQAWEEjRsoENn3+CttSHNzLix/Bvo6F3tL6uRhOq2NGkfyy1jVtVIR+q0bd1SXI7ktPgHxUBLEKfRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqYg41XXmOCI+zBfvqJLJiWuiXOB5tvMZIOTBMZ87KUZr1h5wT
	A++/qNduhW2Xg1MP23+TH1ttzV6WuO3WJUkKbzZtoPNPR+zMwKu1CS+qDZy0JN55uCqBZCowW+S
	6lChZLA9TvVzWzLLV2bPZ/KR0ByHbI4b1KLKjKta20BsL2UTLyz+0azxGsWcbUJD7Ow==
X-Gm-Gg: ASbGncs80skXo0sKf3S6V+Mjr7fs/UpM9A+vy3An03H52SQfGaYt1qR1aCxz94xw6+9
	b2lq6xQQ61fVXy4JIzMUKjfyeOJi5cqR0EPeHvDNjk/plpElHFVMk6XoBYAqZs9EkFWz6L0Cw18
	Fp78JcR/MEPONVo72Iepp/EIs9HlCSvY8PRxMqlDr0ltPplG1EIM6DwjU42mNzy4eOVOWQ/u2lD
	M8e59Mm0IxfF5QMz7vdncrH24Q7pb8bjGfAE2amxpSn2HNWY0It4izlBkZr6my85Nq03n5Je6VL
	VOrjvXrRGMIArUv255BOTsZtgKnqpQ8T0uCezFE0T+e+ekPjdvTbZ6EOqielcGspGkHtEX8lMac
	4gAkejS2zX/4=
X-Received: by 2002:a05:6214:c23:b0:707:5063:4cd3 with SMTP id 6a1803df08f44-70d76f563ffmr32914506d6.11.1755707371126;
        Wed, 20 Aug 2025 09:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnwCLEGuKTChHLZfjZExBSjat0FfQTrxpghHqObB6u73HYU+2zCWCQp6oEaXitlLpUXntvrQ==
X-Received: by 2002:a05:6214:c23:b0:707:5063:4cd3 with SMTP id 6a1803df08f44-70d76f563ffmr32914016d6.11.1755707370545;
        Wed, 20 Aug 2025 09:29:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba902f7fasm87912986d6.13.2025.08.20.09.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 09:29:29 -0700 (PDT)
Message-ID: <43f198b5-60f8-40f5-a2cd-ff21b31a91d4@redhat.com>
Date: Wed, 20 Aug 2025 18:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 2/2] vfio/platform: Mark for removal
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, clg@redhat.com
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
 <20250806170314.3768750-3-alex.williamson@redhat.com>
 <aJ9neYocl8sSjpOG@google.com>
 <20250818105242.4e6b96ed.alex.williamson@redhat.com>
 <aKNj4EUgHYCZ9Q4f@google.com>
 <00001486-b43d-4c2b-a41c-35ab5e823f21@redhat.com>
 <aKXnzqmz-_eR_bHF@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aKXnzqmz-_eR_bHF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mostafa,

On 8/20/25 5:20 PM, Mostafa Saleh wrote:
> Hi Eric,
>
> On Tue, Aug 19, 2025 at 11:58:32AM +0200, Eric Auger wrote:
>> Hi Mostafa,
>>
>> On 8/18/25 7:33 PM, Mostafa Saleh wrote:
>>> On Mon, Aug 18, 2025 at 10:52:42AM -0600, Alex Williamson wrote:
>>>> On Fri, 15 Aug 2025 16:59:37 +0000
>>>> Mostafa Saleh <smostafa@google.com> wrote:
>>>>
>>>>> Hi Alex,
>>>>>
>>>>> On Wed, Aug 06, 2025 at 11:03:12AM -0600, Alex Williamson wrote:
>>>>>> vfio-platform hasn't had a meaningful contribution in years.  In-tree
>>>>>> hardware support is predominantly only for devices which are long since
>>>>>> e-waste.  QEMU support for platform devices is slated for removal in
>>>>>> QEMU-10.2.  Eric Auger presented on the future of the vfio-platform
>>>>>> driver and difficulties supporting new devices at KVM Forum 2024,
>>>>>> gaining some support for removal, some disagreement, but garnering no
>>>>>> new hardware support, leaving the driver in a state where it cannot
>>>>>> be tested.
>>>>>>
>>>>>> Mark as obsolete and subject to removal.  
>>>>> Recently(this year) in Android, we enabled VFIO-platform for protected KVM,
>>>>> and it’s supported in our VMM (CrosVM) [1].
>>>>> CrosVM support is different from Qemu, as it doesn't require any device
>>>>> specific logic in the VMM, however, it relies on loading a device tree
>>>>> template in runtime (with “compatiable” string...) and it will just
>>>>> override regs, irqs.. So it doesn’t need device knowledge (at least for now)
>>>>> Similarly, the kernel doesn’t need reset drivers as the hypervisor handles that.
>>>> I think what we attempt to achieve in vfio is repeatability and data
>>>> integrity independent of the hypervisor.  IOW, if we 'kill -9' the
>>>> hypervisor process, the kernel can bring the device back to a default
>>>> state where the device isn't wedged or leaking information through the
>>>> device to the next use case.  If the hypervisor wants to support
>>>> enhanced resets on top of that, that's great, but I think it becomes
>>>> difficult to argue that vfio-platform itself holds up its end of the
>>>> bargain if we're really trusting the hypervisor to handle these aspects.
>>> Sorry I was not clear, we only use that in Android for ARM64 and pKVM,
>>> where the hypervisor in this context means the code running in EL2 which
>>> is more privileged than the kernel, so it should be trusted.
>>> However, as I mentioned that code is not upstream yet, so it's a valid
>>> concern that the kernel still needs a reset driver.
>>>
>>>>> Unfortunately, there is no upstream support at the moment, we are making
>>>>> some -slow- progress on that [2][3]
>>>>>
>>>>> If it helps, I have access to HW that can run that and I can review/test
>>>>> changes, until upstream support lands; if you are open to keeping VFIO-platform.
>>>>> Or I can look into adding support for existing upstream HW(with platforms I am
>>>>> familiar with as Pixel-6)
>>>> Ultimately I'll lean on Eric to make the call.  I know he's concerned
>>>> about testing, but he raised that and various other concerns whether
>>>> platform device really have a future with vfio nearly a year ago and
>>>> nothing has changed.  Currently it requires a module option opt-in to
>>>> enable devices that the kernel doesn't know how to reset.  Is that
>>>> sufficient or should use of such a device taint the kernel?  If any
>>>> device beyond the few e-waste devices that we know how to reset taint
>>>> the kernel, should this support really even be in the kernel?  Thanks,
>>> I think with the way it’s supported at the moment we need the kernel
>>> to ensure that reset happens.
>> Effectively my main concern is I cannot test vfio-platform anymore. We
>> had some CVEs also impacting the vfio platform code base and it is a
>> major issue not being able to test. That's why I was obliged, last year,
>> to resume the integration of a new device (the tegra234 mgbe), nobody
>> seemed to be really interested in and this work could not be upstreamed
>> due to lack of traction and its hacky nature.
>>
>> You did not really comment on which kind of devices were currently
>> integrated. Are they within the original scope of vfio (with DMA
>> capabilities and protected by an IOMMU)? Last discussion we had in
>> https://lore.kernel.org/all/ZvvLpLUZnj-Z_tEs@google.com/ led to the
>> conclusion that maybe VFIO was not the best suited framework.
> At the moment, Android device assignement only supports DMA capable
> devices which are behind an IOMMU, and we use VFIO-platform for that,
> most of our use cases are accelerators.
>
> In that thread, I was looking into adding support for simpler devices
> (such as sensors) but as discussed that won’t be done through
> VFIO-platform.
>
> Ignoring Android, as I mentioned, I can work on adding support for
> existing upstream platforms (preferably ARM64, that I can get access to)
> such as Pixel-6, which should make it easier to test.
>
> Also, we have some interest on adding new features such as run-time
> power management.

OK fair enough. If Alex agrees then we can wait for those efforts. Also
I think it would make sense to formalize the way you reset the devices
(I understand the hyp does that under the hood).
>
>> In case we keep the driver in, I think we need to get a garantee that
>> you or someone else at Google commits to review and test potential
>> changes with a perspective to take over its maintenance.
> I can’t make guarantees on behalf of Google, but I can contribute in
> reviewing/testing/maintenance of the driver as far as I am able to.
> If you want, you can add me as reviewer to the driver.

I understand. I think the usual way then is for you to send a patch to
update the Maintainers file.

Thanks

Eric
>
> Thanks,
> Mostafa
>
>
>> Thanks
>>
>> Eric
>>
>>> But maybe instead of having that specific reset handler for VFIO, we
>>> can rely on the “shutdown” method already existing in "platform_driver"?
>>> I believe that should put the device in a state where it can be re-probed
>>> safely. Although not all devices implement that but it seems more generic
>>> and scalable.
>>>
>>> Thanks,
>>> Mostafa
>>>
>>>> Alex
>>>>


