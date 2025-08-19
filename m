Return-Path: <linux-kernel+bounces-775353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F058B2BE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8475D620ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94731B13C;
	Tue, 19 Aug 2025 09:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4/pPz6I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FFF1E5207
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597522; cv=none; b=O1WTLed2z9YhSXXaJCtBCprHiwXXHTg3DbeAqsPxHh7tXq9MlFDZxkZibhc4zDg73MoQ+hlBtysHszw8GUNHb3GvrpQNoNPieMWLiYfjLu1iZSmOXm3RgS+ErkID65s0J1JyhJqnPYQr6pp3NGUPdwFw3U7v2RENS5NLjEvvfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597522; c=relaxed/simple;
	bh=sQ6/tcXzx45H4od67c10FCsVm8cOMVqLD5Z3dBKapwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuKEjSwHPZ9CdKMbWDdIyJQnH0AHzHh7uuQcD+gFuRSTQ1IA/j799xIKIxU0XhHHsGHMmhOHecTDUmC8GRMHrOe4cmhFi24szH9bZ120XotSTySVMgUBB0sl1bXkkqMGIKRk3Bp0cLueKBvoiNL3eVIomYca0P3lba+jda8lgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4/pPz6I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755597519;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxidopYvtBYBSDXNlSF3PIBralIAf58Gt3+cUKvGLaU=;
	b=S4/pPz6I2Ud3MUgk3W/+Uz4AphZXSAvYhM+Z9Hz+uY1BBg4fPQ41je0+AmwHbwTg/QurMr
	I9iEZnrXtk3x7QL7Zvf/58gXMqISHou23bqyC+1rQpMt5fof/OTroksdcQp5EmK3+eWDI5
	qIrZrFzy6VmDiHlDta2Y9t7WgiGNVUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-8v4-bzxxNje675v8i19UPw-1; Tue, 19 Aug 2025 05:58:37 -0400
X-MC-Unique: 8v4-bzxxNje675v8i19UPw-1
X-Mimecast-MFC-AGG-ID: 8v4-bzxxNje675v8i19UPw_1755597516
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b10418aso30051245e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597516; x=1756202316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxidopYvtBYBSDXNlSF3PIBralIAf58Gt3+cUKvGLaU=;
        b=AHm0rdab58swVBJ0solyeAj3niTKPURAHYyNirkJ0NP5bS5t1En14Vr2YpLgR0MBap
         oBdltgvys70nmgCAn/mM1cB9mxlWEgf3JR289NjHb7SIT1GVjPJxr3ml0y6Fzk5zP2SL
         dlAIPDkzIeaO9gxw9vjGK1YR9VqMn1iI9T9MYapYyoVZ7xdVAPdIwFGtdPcHQHu57u72
         Ct+zOCkK5g7ZWJxkInlZRDOKhdrw0FlIH3Syk3JLrSUcVkyzbaPPGIIlloq0bz7PH8d1
         pqT5Xw2FgANrPbu04DLoQ9bJ/CjMdZt9ux62YK+FiKuShSHg4M8Zki+kUcNNCExoDKwF
         3AGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjQkeMiJPPVA4jbgg2TGTi8HED31vdoWHvvb5LITEMX5wDPmiVPGpVyCYN4Di9bHFmC5dKj+6NL/IPdW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFh5ypqk81hMMO/F/DUEGFFgrCdiVhID9GtZS6Bc4N4449Q7kh
	12GB0wnqWjg/4TibVE629sWrjyc4GjHS7Bu/Te1Vsoax0P8ywUQc78axA4TE2C+efJdh2+cA2Ey
	AtdtxIxgo0xktfzhuD2QVRiffqVTlj0jWibqyfvqsOgjLdyV2539FM8mQLBmqOnlDIFsxDz/nLQ
	==
X-Gm-Gg: ASbGncvKFOtx3+dQoN8byde8shbAy0iefpPU8DcnMuzUBrZgZNwV6Kd1s4++WtSn6DO
	aNU+G1JQZrnG7HbLOaCsIyMFqitwTaPPp3gCE0wbgBl7VVDE3zxWg51U8eWptK2lsLFJ+avmmFg
	bzFhKioHU8JhP+uXn5XUaKXP3MgUj/VMWfqYE9V/xMm3TVO+WjCZ3JICii4+pIl9YYB0IS9D7Gf
	w1gx4A7y0DaBzFixJvuZMv4Tef8Xg3Ew1AiBF4MqZTP+mSfAJ2wwztjMTGqHmZOlPCOgXW1s36c
	flFjLB+UvSAz3HqbcI/AjTqH+jsyol5y27jCOT86jr4P
X-Received: by 2002:a5d:64ca:0:b0:3ba:c0d2:3985 with SMTP id ffacd0b85a97d-3c0ea3cef57mr1620622f8f.7.1755597515581;
        Tue, 19 Aug 2025 02:58:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETKJM0Lx0P2KeZ9svQmo/bIxhq07BDsJl3YcUCuFjLNK+9A+rKmaTnKCDeiQKIVNGcr46XHQ==
X-Received: by 2002:a5d:64ca:0:b0:3ba:c0d2:3985 with SMTP id ffacd0b85a97d-3c0ea3cef57mr1620595f8f.7.1755597514982;
        Tue, 19 Aug 2025 02:58:34 -0700 (PDT)
Received: from [192.168.43.95] ([37.167.50.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43947sm3200958f8f.18.2025.08.19.02.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 02:58:34 -0700 (PDT)
Message-ID: <00001486-b43d-4c2b-a41c-35ab5e823f21@redhat.com>
Date: Tue, 19 Aug 2025 11:58:32 +0200
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
To: Mostafa Saleh <smostafa@google.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, clg@redhat.com
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
 <20250806170314.3768750-3-alex.williamson@redhat.com>
 <aJ9neYocl8sSjpOG@google.com>
 <20250818105242.4e6b96ed.alex.williamson@redhat.com>
 <aKNj4EUgHYCZ9Q4f@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aKNj4EUgHYCZ9Q4f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mostafa,

On 8/18/25 7:33 PM, Mostafa Saleh wrote:
> On Mon, Aug 18, 2025 at 10:52:42AM -0600, Alex Williamson wrote:
>> On Fri, 15 Aug 2025 16:59:37 +0000
>> Mostafa Saleh <smostafa@google.com> wrote:
>>
>>> Hi Alex,
>>>
>>> On Wed, Aug 06, 2025 at 11:03:12AM -0600, Alex Williamson wrote:
>>>> vfio-platform hasn't had a meaningful contribution in years.  In-tree
>>>> hardware support is predominantly only for devices which are long since
>>>> e-waste.  QEMU support for platform devices is slated for removal in
>>>> QEMU-10.2.  Eric Auger presented on the future of the vfio-platform
>>>> driver and difficulties supporting new devices at KVM Forum 2024,
>>>> gaining some support for removal, some disagreement, but garnering no
>>>> new hardware support, leaving the driver in a state where it cannot
>>>> be tested.
>>>>
>>>> Mark as obsolete and subject to removal.  
>>> Recently(this year) in Android, we enabled VFIO-platform for protected KVM,
>>> and it’s supported in our VMM (CrosVM) [1].
>>> CrosVM support is different from Qemu, as it doesn't require any device
>>> specific logic in the VMM, however, it relies on loading a device tree
>>> template in runtime (with “compatiable” string...) and it will just
>>> override regs, irqs.. So it doesn’t need device knowledge (at least for now)
>>> Similarly, the kernel doesn’t need reset drivers as the hypervisor handles that.
>> I think what we attempt to achieve in vfio is repeatability and data
>> integrity independent of the hypervisor.  IOW, if we 'kill -9' the
>> hypervisor process, the kernel can bring the device back to a default
>> state where the device isn't wedged or leaking information through the
>> device to the next use case.  If the hypervisor wants to support
>> enhanced resets on top of that, that's great, but I think it becomes
>> difficult to argue that vfio-platform itself holds up its end of the
>> bargain if we're really trusting the hypervisor to handle these aspects.
> Sorry I was not clear, we only use that in Android for ARM64 and pKVM,
> where the hypervisor in this context means the code running in EL2 which
> is more privileged than the kernel, so it should be trusted.
> However, as I mentioned that code is not upstream yet, so it's a valid
> concern that the kernel still needs a reset driver.
>
>>> Unfortunately, there is no upstream support at the moment, we are making
>>> some -slow- progress on that [2][3]
>>>
>>> If it helps, I have access to HW that can run that and I can review/test
>>> changes, until upstream support lands; if you are open to keeping VFIO-platform.
>>> Or I can look into adding support for existing upstream HW(with platforms I am
>>> familiar with as Pixel-6)
>> Ultimately I'll lean on Eric to make the call.  I know he's concerned
>> about testing, but he raised that and various other concerns whether
>> platform device really have a future with vfio nearly a year ago and
>> nothing has changed.  Currently it requires a module option opt-in to
>> enable devices that the kernel doesn't know how to reset.  Is that
>> sufficient or should use of such a device taint the kernel?  If any
>> device beyond the few e-waste devices that we know how to reset taint
>> the kernel, should this support really even be in the kernel?  Thanks,
> I think with the way it’s supported at the moment we need the kernel
> to ensure that reset happens.

Effectively my main concern is I cannot test vfio-platform anymore. We
had some CVEs also impacting the vfio platform code base and it is a
major issue not being able to test. That's why I was obliged, last year,
to resume the integration of a new device (the tegra234 mgbe), nobody
seemed to be really interested in and this work could not be upstreamed
due to lack of traction and its hacky nature.

You did not really comment on which kind of devices were currently
integrated. Are they within the original scope of vfio (with DMA
capabilities and protected by an IOMMU)? Last discussion we had in
https://lore.kernel.org/all/ZvvLpLUZnj-Z_tEs@google.com/ led to the
conclusion that maybe VFIO was not the best suited framework.

In case we keep the driver in, I think we need to get a garantee that
you or someone else at Google commits to review and test potential
changes with a perspective to take over its maintenance.

Thanks

Eric

>
> But maybe instead of having that specific reset handler for VFIO, we
> can rely on the “shutdown” method already existing in "platform_driver"?
> I believe that should put the device in a state where it can be re-probed
> safely. Although not all devices implement that but it seems more generic
> and scalable.
>
> Thanks,
> Mostafa
>
>> Alex
>>


