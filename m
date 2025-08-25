Return-Path: <linux-kernel+bounces-785234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA8B347EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947A31A85773
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AA3009F1;
	Mon, 25 Aug 2025 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWYy1mKJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CE19CD1D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140521; cv=none; b=a55zY67X6JK/1BiDHlJZUQIDNRYuASt2H2Nq7A2oQuA7RIwg1TjzHyCKZb0gLis2MVFtVsGP4W7pU3yXOK14sqhfQaggkaVVY8snCwayI9YsihXuFbjYxaiGpTIqvVJqzPtSND5CZm0dZKLU/wHZ3apPih3vYvOFhnbFzOeKZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140521; c=relaxed/simple;
	bh=sMeqoUd6FjmLq6aB6gUBE4Adp5wswzjOkjSEd0t/zDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7sFqllGHgXO6au2NsvA36zXFzmJlK1pQbU8ZnZxMyMPFSvz9WzHCvacGMY1OXuqmap8nRqNiRyFYaR+OLuuWaCBODeKkpkfrN5JzjMbpcVHvpC5XXkYI+4mG+Z5o+Ljxsj/J5UdX12liAnEb+9FAyR8XWWBRRLD8ya+I81F4rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWYy1mKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756140518;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QD21BU98aewbC6c1UaooXRC6hwuubWMD4XXnjY+3yWI=;
	b=YWYy1mKJYjcrsXQp3EYG+ZFXwq7r/u1OCQ2F+hwbzO40ohrPf3RGu1rFtvd9jGKwWiEw08
	D90PcbEmwkbQetHLVjV+vYrA82j9ILqb6B2Vh/dxBZLM4v4MTI38pcaaBiWmZdEbbd2Ydt
	NrKsedRf8KPrLTCExySaQ2eu7MSYLJU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-y2yZhYtoOJuzxtweQm5P0Q-1; Mon, 25 Aug 2025 12:48:36 -0400
X-MC-Unique: y2yZhYtoOJuzxtweQm5P0Q-1
X-Mimecast-MFC-AGG-ID: y2yZhYtoOJuzxtweQm5P0Q_1756140516
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70d989082a1so70611406d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140516; x=1756745316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QD21BU98aewbC6c1UaooXRC6hwuubWMD4XXnjY+3yWI=;
        b=TkeGAR2c7Y1CwXz5ag+UNftE2CaZm1RHPw4VCnieIG4dFuq5tMs4SgAidUNPYwpkSZ
         2YYRuWI39rINI3kP3y1wloCNiBch69ohYj9cbECNxKprukpye8xgfAN8WWpWyPtXGy1Q
         EDL/lJG98iVKyB4UZAuna74FC0y+KUjp0WRp6VhK6b8m6Lr+t1I9XhtaQAyyZyIWckCD
         RVKsfi3ePK252BPEiM1mPEP/bbYZH0knQfoou2h6yA12FXXQwemwG1jYjAfpRe3XUnJ/
         VU5o69lanOyt8bjjIA3t/UJvFRSIV+jV8bPIdwx2dNYV9AUm7n+hcOgklPYNmTdOC+U4
         t3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWXZZyB9mhilOw2BNSeZYSLC/Z7Td/btdYIvOohM9d0/wiN8Ugqb/rrNziELGTvRgQD3WZE/qCcPxeBaAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4904UMJVQEv0VosupFqGhi+qyuuQSBp3CCNwtmwu84Sx0wJM
	kscURpWPczemrxN01LKEy3wnmJ3MCTWEgvIuIu0PdFvqW1eKqcPDL0AFIdcKW66RGxxHGd/q7i/
	1+B9/wf70fqOkRc0fDmnPAXqm8EX6yfmkVcbcVgq4IOrjPXeDeki0JO7bMmOheOuYgw==
X-Gm-Gg: ASbGncvUD/ViOYuoJvJOfgs9K1hgNjBTTrTnKEsUXg45ts5zWJCIzZeIxq/19/DV9MO
	PzliIdWarSkng7hUvqnsyXiplo0UHH0pLCXVbVfUUNAcGg7y3kkZSFK1lzX+0kYd83s7SUByWw4
	p9LoriwcqqHOJm7iKVfHpd8nyvW/wUOXs9igBW7c7fJjRUCSRv15EjgyduMTMcmc4U2wX2HSbJr
	smGakUX0+ubi9r+kOYTrppwi42AG17fCPBQKY59opgtWepjab4glB10dVQ4mOBhlKBtP2TMmEaB
	ujPIGa8Qx2DLPYEbGax8vUSY/Xi9B8lWn9755LgFeMP7V0s7sx8ctboBMKytGIkngtqu31JyOcT
	J+IM4IfuPPhM=
X-Received: by 2002:a05:6214:5098:b0:70d:6df4:1b17 with SMTP id 6a1803df08f44-70d9720f09fmr136351526d6.52.1756140515851;
        Mon, 25 Aug 2025 09:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIgLrQuydt0AbrtMpsMh8rXg8SBEhvciNYWkWJ8AK1Z9O2GpU0HKuMosAhvH0OpODkNPlHoQ==
X-Received: by 2002:a05:6214:5098:b0:70d:6df4:1b17 with SMTP id 6a1803df08f44-70d9720f09fmr136351046d6.52.1756140515113;
        Mon, 25 Aug 2025 09:48:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72860e8sm48622096d6.40.2025.08.25.09.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 09:48:34 -0700 (PDT)
Message-ID: <eb964959-4425-4412-beae-265fa02fd800@redhat.com>
Date: Mon, 25 Aug 2025 18:48:30 +0200
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
To: Alex Williamson <alex.williamson@redhat.com>,
 Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, clg@redhat.com
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
 <20250806170314.3768750-3-alex.williamson@redhat.com>
 <aJ9neYocl8sSjpOG@google.com>
 <20250818105242.4e6b96ed.alex.williamson@redhat.com>
 <aKNj4EUgHYCZ9Q4f@google.com>
 <00001486-b43d-4c2b-a41c-35ab5e823f21@redhat.com>
 <aKXnzqmz-_eR_bHF@google.com>
 <43f198b5-60f8-40f5-a2cd-ff21b31a91d4@redhat.com>
 <aKYvS3qgV_dW1woo@google.com> <aKxpyyKvYcd84Ayi@google.com>
 <20250825101544.3b3413c6.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250825101544.3b3413c6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

On 8/25/25 6:15 PM, Alex Williamson wrote:
> On Mon, 25 Aug 2025 13:48:59 +0000
> Pranjal Shrivastava <praan@google.com> wrote:
>
>> On Wed, Aug 20, 2025 at 08:25:47PM +0000, Mostafa Saleh wrote:
>>> Hi Eric,
>>>
>>> On Wed, Aug 20, 2025 at 06:29:27PM +0200, Eric Auger wrote:  
>>>> Hi Mostafa,
>>>>
>>>> On 8/20/25 5:20 PM, Mostafa Saleh wrote:  
>>>>> Hi Eric,
>>>>>
>>>>> On Tue, Aug 19, 2025 at 11:58:32AM +0200, Eric Auger wrote:  
>>>>>> Hi Mostafa,
>>>>>>
>>>>>> On 8/18/25 7:33 PM, Mostafa Saleh wrote:  
>>>>>>> On Mon, Aug 18, 2025 at 10:52:42AM -0600, Alex Williamson wrote:  
>>>>>>>> On Fri, 15 Aug 2025 16:59:37 +0000
>>>>>>>> Mostafa Saleh <smostafa@google.com> wrote:
>>>>>>>>  
>>>>>>>>> Hi Alex,
>>>>>>>>>
>>>>>>>>> On Wed, Aug 06, 2025 at 11:03:12AM -0600, Alex Williamson wrote:  
>>>>>>>>>> vfio-platform hasn't had a meaningful contribution in years.  In-tree
>>>>>>>>>> hardware support is predominantly only for devices which are long since
>>>>>>>>>> e-waste.  QEMU support for platform devices is slated for removal in
>>>>>>>>>> QEMU-10.2.  Eric Auger presented on the future of the vfio-platform
>>>>>>>>>> driver and difficulties supporting new devices at KVM Forum 2024,
>>>>>>>>>> gaining some support for removal, some disagreement, but garnering no
>>>>>>>>>> new hardware support, leaving the driver in a state where it cannot
>>>>>>>>>> be tested.
>>>>>>>>>>
>>>>>>>>>> Mark as obsolete and subject to removal.    
>>>>>>>>> Recently(this year) in Android, we enabled VFIO-platform for protected KVM,
>>>>>>>>> and it’s supported in our VMM (CrosVM) [1].
>>>>>>>>> CrosVM support is different from Qemu, as it doesn't require any device
>>>>>>>>> specific logic in the VMM, however, it relies on loading a device tree
>>>>>>>>> template in runtime (with “compatiable” string...) and it will just
>>>>>>>>> override regs, irqs.. So it doesn’t need device knowledge (at least for now)
>>>>>>>>> Similarly, the kernel doesn’t need reset drivers as the hypervisor handles that.  
>>>>>>>> I think what we attempt to achieve in vfio is repeatability and data
>>>>>>>> integrity independent of the hypervisor.  IOW, if we 'kill -9' the
>>>>>>>> hypervisor process, the kernel can bring the device back to a default
>>>>>>>> state where the device isn't wedged or leaking information through the
>>>>>>>> device to the next use case.  If the hypervisor wants to support
>>>>>>>> enhanced resets on top of that, that's great, but I think it becomes
>>>>>>>> difficult to argue that vfio-platform itself holds up its end of the
>>>>>>>> bargain if we're really trusting the hypervisor to handle these aspects.  
>>>>>>> Sorry I was not clear, we only use that in Android for ARM64 and pKVM,
>>>>>>> where the hypervisor in this context means the code running in EL2 which
>>>>>>> is more privileged than the kernel, so it should be trusted.
>>>>>>> However, as I mentioned that code is not upstream yet, so it's a valid
>>>>>>> concern that the kernel still needs a reset driver.
>>>>>>>  
>>>>>>>>> Unfortunately, there is no upstream support at the moment, we are making
>>>>>>>>> some -slow- progress on that [2][3]
>>>>>>>>>
>>>>>>>>> If it helps, I have access to HW that can run that and I can review/test
>>>>>>>>> changes, until upstream support lands; if you are open to keeping VFIO-platform.
>>>>>>>>> Or I can look into adding support for existing upstream HW(with platforms I am
>>>>>>>>> familiar with as Pixel-6)  
>>>>>>>> Ultimately I'll lean on Eric to make the call.  I know he's concerned
>>>>>>>> about testing, but he raised that and various other concerns whether
>>>>>>>> platform device really have a future with vfio nearly a year ago and
>>>>>>>> nothing has changed.  Currently it requires a module option opt-in to
>>>>>>>> enable devices that the kernel doesn't know how to reset.  Is that
>>>>>>>> sufficient or should use of such a device taint the kernel?  If any
>>>>>>>> device beyond the few e-waste devices that we know how to reset taint
>>>>>>>> the kernel, should this support really even be in the kernel?  Thanks,  
>>>>>>> I think with the way it’s supported at the moment we need the kernel
>>>>>>> to ensure that reset happens.  
>>>>>> Effectively my main concern is I cannot test vfio-platform anymore. We
>>>>>> had some CVEs also impacting the vfio platform code base and it is a
>>>>>> major issue not being able to test. That's why I was obliged, last year,
>>>>>> to resume the integration of a new device (the tegra234 mgbe), nobody
>>>>>> seemed to be really interested in and this work could not be upstreamed
>>>>>> due to lack of traction and its hacky nature.
>>>>>>
>>>>>> You did not really comment on which kind of devices were currently
>>>>>> integrated. Are they within the original scope of vfio (with DMA
>>>>>> capabilities and protected by an IOMMU)? Last discussion we had in
>>>>>> https://lore.kernel.org/all/ZvvLpLUZnj-Z_tEs@google.com/ led to the
>>>>>> conclusion that maybe VFIO was not the best suited framework.  
>>>>> At the moment, Android device assignement only supports DMA capable
>>>>> devices which are behind an IOMMU, and we use VFIO-platform for that,
>>>>> most of our use cases are accelerators.
>>>>>
>>>>> In that thread, I was looking into adding support for simpler devices
>>>>> (such as sensors) but as discussed that won’t be done through
>>>>> VFIO-platform.
>>>>>
>>>>> Ignoring Android, as I mentioned, I can work on adding support for
>>>>> existing upstream platforms (preferably ARM64, that I can get access to)
>>>>> such as Pixel-6, which should make it easier to test.
>>>>>
>>>>> Also, we have some interest on adding new features such as run-time
>>>>> power management.  
>>>> OK fair enough. If Alex agrees then we can wait for those efforts. Also
>>>> I think it would make sense to formalize the way you reset the devices
>>>> (I understand the hyp does that under the hood).  
>>> I think currently - with some help from the platform bus- we can rely on
>>> the existing shutdown method, instead of specific hooks.
>>> As the hypervisor logic will only be for ARM64 (at least for now), I can
>>> look more into this.
>>>
>>> But I think the top priority would be to establish a decent platform to
>>> test with, I will start looking into Pixel-6 (although that would need
>>> to land IOMMU support for it upstream first). I also have a morello
>>> board with SMMUv3, but I think it's all PCI.
>>>   
>>>>>  
>>>>>> In case we keep the driver in, I think we need to get a garantee that
>>>>>> you or someone else at Google commits to review and test potential
>>>>>> changes with a perspective to take over its maintenance.  
>>>>> I can’t make guarantees on behalf of Google, but I can contribute in
>>>>> reviewing/testing/maintenance of the driver as far as I am able to.
>>>>> If you want, you can add me as reviewer to the driver.  
>>>> I understand. I think the usual way then is for you to send a patch to
>>>> update the Maintainers file.  
>>> I see, I will send one shortly.
>>>   
>> I could contribute time to help with the maintenance effort here, if
>> needed. Please let me know if you'd like that.
> You can join Mostafa and post a patch to be added as a designated
> reviewer.
>
> If we're not going to deprecate vfio-platform overall for now, what
> about vfio-amba and all the reset drivers?  It seems that even if
> Google cares about vfio-platform, these still fall outside of what's
> being used or tested.  Should we drive something like below to see what
> comes out of the woodwork?:

As far as I know vfio-amba has never been used. With regards to the
reset driver I think this is reasonable to deprecate them as the HW has
ewasted

Thanks

Eric
>
> diff --git a/drivers/vfio/platform/Kconfig b/drivers/vfio/platform/Kconfig
> index 88fcde51f024..c6be29b2c24b 100644
> --- a/drivers/vfio/platform/Kconfig
> +++ b/drivers/vfio/platform/Kconfig
> @@ -17,10 +17,13 @@ config VFIO_PLATFORM
>  	  If you don't know what to do here, say N.
>  
>  config VFIO_AMBA
> -	tristate "VFIO support for AMBA devices"
> +	tristate "VFIO support for AMBA devices (DEPRECATED)"
>  	depends on ARM_AMBA || COMPILE_TEST
>  	select VFIO_PLATFORM_BASE
>  	help
> +	  The vfio-amba driver is deprecated and will be removed in a
> +	  future kernel release.
> +
>  	  Support for ARM AMBA devices with VFIO. This is required to make
>  	  use of ARM AMBA devices present on the system using the VFIO
>  	  framework.
> diff --git a/drivers/vfio/platform/reset/Kconfig b/drivers/vfio/platform/reset/Kconfig
> index dcc08dc145a5..70af0dbe293b 100644
> --- a/drivers/vfio/platform/reset/Kconfig
> +++ b/drivers/vfio/platform/reset/Kconfig
> @@ -1,21 +1,21 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  if VFIO_PLATFORM
>  config VFIO_PLATFORM_CALXEDAXGMAC_RESET
> -	tristate "VFIO support for calxeda xgmac reset"
> +	tristate "VFIO support for calxeda xgmac reset (DEPRECATED)"
>  	help
>  	  Enables the VFIO platform driver to handle reset for Calxeda xgmac
>  
>  	  If you don't know what to do here, say N.
>  
>  config VFIO_PLATFORM_AMDXGBE_RESET
> -	tristate "VFIO support for AMD XGBE reset"
> +	tristate "VFIO support for AMD XGBE reset (DEPRECATED)"
>  	help
>  	  Enables the VFIO platform driver to handle reset for AMD XGBE
>  
>  	  If you don't know what to do here, say N.
>  
>  config VFIO_PLATFORM_BCMFLEXRM_RESET
> -	tristate "VFIO support for Broadcom FlexRM reset"
> +	tristate "VFIO support for Broadcom FlexRM reset (DEPRECATED)"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
>  	default ARCH_BCM_IPROC
>  	help
> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> index abdca900802d..45f386a042a9 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
> @@ -52,6 +52,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>  	u32 dma_mr_value, pcs_value, value;
>  	unsigned int count;
>  
> +	dev_err_once(vdev->device, "DEPRECATION: VFIO AMD XGBE platform reset is deprecated and will be removed in a future kernel release\n");
> +
>  	if (!xgmac_regs->ioaddr) {
>  		xgmac_regs->ioaddr =
>  			ioremap(xgmac_regs->addr, xgmac_regs->size);
> diff --git a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> index 1131ebe4837d..51c9d156f307 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c
> @@ -72,6 +72,8 @@ static int vfio_platform_bcmflexrm_reset(struct vfio_platform_device *vdev)
>  	int rc = 0, ret = 0, ring_num = 0;
>  	struct vfio_platform_region *reg = &vdev->regions[0];
>  
> +	dev_err_once(vdev->device, "DEPRECATION: VFIO Broadcom FlexRM platform reset is deprecated and will be removed in a future kernel release\n");
> +
>  	/* Map FlexRM ring registers if not mapped */
>  	if (!reg->ioaddr) {
>  		reg->ioaddr = ioremap(reg->addr, reg->size);
> diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> index 63cc7f0b2e4a..a298045a8e19 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> @@ -50,6 +50,8 @@ static int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
>  {
>  	struct vfio_platform_region *reg = &vdev->regions[0];
>  
> +	dev_err_once(vdev->device, "DEPRECATION: VFIO Calxeda xgmac platform reset is deprecated and will be removed in a future kernel release\n");
> +
>  	if (!reg->ioaddr) {
>  		reg->ioaddr =
>  			ioremap(reg->addr, reg->size);
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
> index ff8ff8480968..9f5c527baa8a 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -70,6 +70,8 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct vfio_platform_device *vdev;
>  	int ret;
>  
> +	dev_err_once(&adev->dev, "DEPRECATION: vfio-amba is deprecated and will be removed in a future kernel release\n");
> +
>  	vdev = vfio_alloc_device(vfio_platform_device, vdev, &adev->dev,
>  				 &vfio_amba_ops);
>  	if (IS_ERR(vdev))
>


