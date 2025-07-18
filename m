Return-Path: <linux-kernel+bounces-736964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B0FB0A5DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FDCA81887
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E59199931;
	Fri, 18 Jul 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I9L2T2ED"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7014F9D6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847740; cv=none; b=qolSlqu6INQu81VCuKtR5M8pNPOMfhCW+gWVfMOcC7ju8o23L6k7qWooU/Vb0ApVdS3nk6DwsVdb461ujq5W8lNEiKfl9mtyl38ztYCdCGBpgVWDxQQStl1Hryrp7M7jjn5wfDLuho5UoCv55eKi9lcah7zzgGnoEGRFWxURvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847740; c=relaxed/simple;
	bh=4KkgJNk5IKBDnqqV8ChFfKhYDiW5DYDxtEJieQoTUaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XdSm90IW30rJR56cL4mnVjPoA1tYfOgqWbl3QlHIYz0QRHA9CkNvUFpPJbSi0zigjuCH2tPrjKZNqZH0Mj7ndEPnNn4kR5MTWtdDSD21imrO6/9bSLfCEjjp60uHF7xbZCYJMA+oTS+5kbmwe7445ZU/Fc8Ke+PkuL4XIbDZBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I9L2T2ED; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6075ca6d617so379013a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752847736; x=1753452536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hpRnpabeJ+d+nZUSSIYnyBidRgDnsyJD8sy92pgASEA=;
        b=I9L2T2EDUQkXveGkIi+lGYqidGplDcQXGWkxQ7vD6J3oTqJYZi/4444a9qoUQWP6oL
         uX32TdIbYB2G6iSQ0Q+9Lt0Uayu8OcA7GtI+iGwRuOqYdrUiLwmuMSZYfnkS+Pm/ZCvs
         V9P7PaSy0jiAl5+SsfYqNqjvLk5cgUAJ5kVxZ9O0ctqJFqqeH5rFJJZ2+EyVB1wxGzc2
         OabUOMLlYg9tca/u7+LOBekqe8Xv6Bnlv3VtpI2IZoprkYJRlyQJd8aiidS52qSyBiPz
         aRpobXCyiLzCm844V7pCXeiNmirc+jBy3edZCJjhqDmb1Gtcnrz613CZk64XAU9FYSUI
         Titg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847736; x=1753452536;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpRnpabeJ+d+nZUSSIYnyBidRgDnsyJD8sy92pgASEA=;
        b=j3DA6Bk1xl4Vfm/fxxXmdJX/4Ncu/JGgbcKlimcPVvc25x0O8OkjH716Flpt++MqJF
         XE0S2ADJOXeaetYs2K23UIlVqXSGpPjlY+MNrvmuQkE91MHxFSQaTRmV6FNz4cBVvus5
         fz2VIL9NHudGsbkiM+TjS1NmNIRitE2xc3+GJd+lGyCSOIbGG4CvL+UhWq1eZAc5x84R
         XKNf4hnn5jSd8zXbXPR8OuqiMj1/62xYST4FibvDLNrQsezBSPFv8firzq1Hd6qF6D0o
         JO1ZjAHYBrKsgNPaMHjFzhY/68ehaAS23kFqvcKZ1eAFTsdcyAnFnKo72AB08FYT4y/b
         yGcA==
X-Forwarded-Encrypted: i=1; AJvYcCUs1qUKC7RjhJu53nBjv0D49aTuM8Zx0k97hYVeJdgHLGDfhQqK5S99mAO6dwJ/U8DsjRZ28Z/v23tBVHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9jpqS33ijGIN+H62vfEQoIQugXwHmTCb7ROs/wJ/VoJ4xQAj
	J8fRppsspowabiR1saZQ5BFGLwknwPk1Dk45OA4nploPyjFN//iqXXRZRhM4wSbvU44=
X-Gm-Gg: ASbGncsz0v1ly5xGi8An/MI1iW0tU/QHtrOT9K5h8x8xELHVu12lgDecYV81B3tW8qB
	NuhUlxCe5Di9kuvwjmxwUgbglGWH+/1f5gOjrAmVuQbOjdtt/vA0xeRmvCHlNr88Icni2fYuS2r
	jJhWg53AjBmeXU1ntZBV1YsfJ/0XTqPe6o/PfszIuQ1A9zXxGTXS7F7YAch6dThL/7kws+fAudG
	THYMsMscg4l/s+1Y26+189l+GCedq4RFmcTeVWPcT2mYxJRJWLbGbqa9LZmrVpHjdGDmFVOD03d
	B+7vGCVO/vjbtHRiFUQBGgDXL+Qqc+KJEAWM8DaMRu2KfWmD+1WYS5Goaeyq+8xZdT+tmM2MkBA
	fq2y91k810HFpXDe0ZduiodhTEyaKPngZOqI9062W4Q==
X-Google-Smtp-Source: AGHT+IHdJfKr2ruFjWvuFsqj9m2u06sbJQ9Sb8CsvhrUUwibMgaWfWnbqe8XPWQrApAIhC5wTeEO0g==
X-Received: by 2002:a17:907:78c:b0:aec:5047:bec8 with SMTP id a640c23a62f3a-aec5047e3c1mr222536666b.5.1752847736319;
        Fri, 18 Jul 2025 07:08:56 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7d347sm128825866b.128.2025.07.18.07.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 07:08:55 -0700 (PDT)
Message-ID: <96a17356-b233-4438-be79-25bf56696bc8@linaro.org>
Date: Fri, 18 Jul 2025 16:08:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: Fix missing GENERIC_MSI_IRQ on compile test
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
 <nikhil.agarwal@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20250716064903.52397-2-krzysztof.kozlowski@linaro.org>
 <20250717133358.1541e5df.alex.williamson@redhat.com>
 <20250717144037.08e88ab6.alex.williamson@redhat.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250717144037.08e88ab6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2025 22:40, Alex Williamson wrote:
> On Thu, 17 Jul 2025 13:33:58 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
>> On Wed, 16 Jul 2025 08:49:04 +0200
>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>>> CDX_BUS driver uses msi_setup_device_data() which is selected by
>>> GENERIC_MSI_IRQ, thus compile testing without the latter failed:
>>>
>>>   /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
>>>   build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_device_data'
>>>
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Closes: https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org/
>>> Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/cdx/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>>> index 1f1e360507d7..3af41f51cf38 100644
>>> --- a/drivers/cdx/Kconfig
>>> +++ b/drivers/cdx/Kconfig
>>> @@ -8,6 +8,7 @@
>>>  config CDX_BUS
>>>  	bool "CDX Bus driver"
>>>  	depends on OF && ARM64 || COMPILE_TEST
>>> +	select GENERIC_MSI_IRQ
>>>  	help
>>>  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>>>  	  exposes Fabric devices which uses composable DMA IP to the  
>>
>> This looks incomplete to me.  The Makefile has:
>>
>> ifdef CONFIG_GENERIC_MSI_IRQ
>> obj-$(CONFIG_CDX_BUS) += cdx_msi.o
>> endif
>>
>> The call to msi_setup_device_data(), the conditional inclusion of
>> cdx_msi.o, and cdx_msi.c itself were added in 0e439ba38e61 ("cdx: add
>> MSI support for CDX bus").  That's the source of the issue, not the
>> Kconfig update to build under COMPILE_TEST, but also the Makefile
>> should be updated to statically include cdx_msi.o.  Thanks,
> 
> Also, we may not be philosophically aligned on this, but if CDX_BUS
> selects GENERIC_MSI_IRQ and CDX_CONTROLLER depends on CDX_BUS, then the
> select of the same under CDX_CONTROLLER becomes redundant.

I don't have a preference for that. I imagine that they use/depend on
MSI independently of each other. At least I could imagine such code.


> 
> Independent of that there are also some ifdefs in cdx_bus.h that would
> become invalid if the entire CDX_BUS depends on GENERIC_MSI_IRQ.  It

These ifdefs are for cdx_msi.c which looks like quite independent piece
of code from cdx.c.

> really kinda looks like CDX_BUS expects a use case that doesn't depend
> on GENERIC_MSI_IRQ and I wonder if the right answer isn't just:

Yes, I agree.

> 
> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> index 092306ca2541..3d50f8cd9c0b 100644
> --- a/drivers/cdx/cdx.c
> +++ b/drivers/cdx/cdx.c
> @@ -310,7 +310,7 @@ static int cdx_probe(struct device *dev)
>  	 * Setup MSI device data so that generic MSI alloc/free can
>  	 * be used by the device driver.
>  	 */
> -	if (cdx->msi_domain) {
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
>  		error = msi_setup_device_data(&cdx_dev->dev);
>  		if (error)
>  			return error;
> @@ -833,7 +833,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>  		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
>  		     cdx_dev->dev_num);
>  
> -	if (cdx->msi_domain) {
> +	if (IS_ENABLED(CONFIG_GENERIC_MSI_IRQ) && cdx->msi_domain) {
>  		cdx_dev->num_msi = dev_params->num_msi;
>  		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
>  	}
> 
> Then I suppose vfio-cdx would also have the option to either
> select/depend on GENERIC_MSI_IRQ or perhaps get away with stubbing
> vfio_cdx_set_irqs_ioctl and vfio_cdx_irqs_cleanup and conditionally
> building intr.o, depending on if there's a use case without MSI.
> Thanks,

vfio/cdx/intr.c unconditionally calls cdx_enable_msi() and entire code
looks like relies on MSI. cdx_enable_msi() stub seems to be only for the
purpose of modular builds.

But these are just guesses...




Best regards,
Krzysztof

