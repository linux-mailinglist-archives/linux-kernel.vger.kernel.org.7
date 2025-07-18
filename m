Return-Path: <linux-kernel+bounces-736927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DAB0A53D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B1AA41271
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A442AA5;
	Fri, 18 Jul 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="piOeJZRE"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531927453
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845671; cv=none; b=LhqcpAZ4B3OU52u1yKP6wr7d4gd+WrvP8iNRP18AXAd3ihPOl8DUJjX5ocjDNckAYoratXylPELjw2mZJI2cv5qHmZDuBhLbiGsLfFWfYpG6NMkpYemCeW9UKQPwFyvaQH34QwmBSo9K+fMFoOm9goYpKjReHl1RA3VEQHY5Lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845671; c=relaxed/simple;
	bh=kJKUfXmpmXz000ZeJNNSN1dyb3vPJL3qfwNseW5k77Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pp32u7c2j1u/b/c8ar+a4KX5FWl2h6pwWWDjlQ8Te45RExxrrwx18/2Ga40A+wZEnz+XILPANlEykBOMCwrIKBtE5Ow/BLBhGjnxxHdI8os9k7y/iYXbWbwS7YIF/6o59nhtA/uebQk9IN/ct11wUWW9Ny2yG0XxMuK3nVy38tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=piOeJZRE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a524caf77eso252352f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752845667; x=1753450467; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cbTEEEUM3ixZn8p59clb1wOUqAaPHBe8GyIvlyaQkHw=;
        b=piOeJZREALf6NNcewtuW4UbQiD0nskf4H/AHg3/6H7ttD8IzKmAU2Y0rD0/Pz8LzbS
         D5qmQyXMNf6CDznJwc/qSTAhdll2jiBK5fEC3Rhn/3STFQjqkZpDy1xmOlvU+dQdRRfw
         byGodR4zJJRw13JhJN4axSGdaawEOgryUIlx/oeTmMdEoC93OQLqWcCbLOO/yuznEoT1
         FA03AB6JwFj9xd4l79zThZ2KphYyP9dDy7UrybrlN5RkCfCg+HydJxRd0TSl+hKvgPgQ
         e2DyR0evZhVDKADNaKascTuSlfmyyT1lLPyfb0tdbIpiAfXtvrHrfMpPmqaHu2Bo+fXg
         ALMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845667; x=1753450467;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbTEEEUM3ixZn8p59clb1wOUqAaPHBe8GyIvlyaQkHw=;
        b=FQSCn0POb0uCAqvVzGYTGma35qjJvitodGEBLzn52/KfJzr6QTMA9VFPnWYisOFtf9
         NxzcAJTmHh+XMKXDWW5PfNBZHQ1TYu/uUDVaCUFG5Tb70BPn4wjelUCkvuaQ21x4ZiJM
         nchJclpIFuizOy2arIC8SksddSf3f6yCAuwt4/0yntPqhhl0sNsqfNm4A3ED8c9krhVM
         7taneEeMwAoXCmk34JEkcbroUUMv8hyoBsPvfKnXazLzDs77CsvQaxl1saRASZHZVxxM
         5r1TFHz9tS0HKgxmVOpwXfiKabQnKu0t29cxwWxZaQ8yFNTM1IkwSnG9ndE5zi5pkuce
         yTWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeQg2T6ujpqUgVUZfuwSyxaefhfpaEWPhW7jinaevQHMFdK6g07hwYADU3anldnzLnPBK8zoJvxD+nh5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDizLORmafoNxoKGpqB+HWfrtqZZZREzU+6Tlv3uhKLzf9GLHe
	mCHAkZ+mVXSZmODR7gtwY96MvoGRCEIAZBFbd0rs94lHqj9b5Z558qQr1zNpDO4sx1V1kOGwy09
	mN6k+
X-Gm-Gg: ASbGncuNsIogbp32f3sApe3+362sR91ZasfNa4f31poN54xo3zu5KNXSuYdSQOdXTwj
	Cp8lvH9xuc6HBGxt0Ook7g9EQ+Ofge/O4TmtU+fuiTXaJp4duvarTpy3XuAvnP/bbr52X8rRVK4
	+oiFYXPGfUW0n2ETEEul/HLC9hFlmrHfukG3cE4sSEyE48nOhUYohQMu5LIhbqXTOgsckgFbJL1
	gbZZ0SAWrzceoq2aAjARhVGtrb4bPt+hr/jTbjiT4GEXYkSUmTGs1HtGamAWAy1sXu4+CcpvOLp
	9jqwZA6GOpbnRAWR3afCvru48w6JGHDKmzrLjXfkmQujF68Y4p+6aTYdEKjsoHeMQCl4qY8IPKl
	2bxXgfqUO07i1mvnJl8j4HURr+agbouqW8qQwaw2omxLqDzFZuMl0
X-Google-Smtp-Source: AGHT+IE9SJQ0B9t7CJW1VfTFg7B3JsUsW1d9zGnQIyq1KVK+ATFRN+L4aZf0DYKbzhKbY0yCqwIfGw==
X-Received: by 2002:a05:6000:23c8:b0:3a6:d30e:6fd3 with SMTP id ffacd0b85a97d-3b60dd73b66mr2815285f8f.10.1752845667401;
        Fri, 18 Jul 2025 06:34:27 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563f7c88a0sm9801805e9.2.2025.07.18.06.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 06:34:26 -0700 (PDT)
Message-ID: <3b39e24b-6221-4de9-b45b-464c666da8ad@linaro.org>
Date: Fri, 18 Jul 2025 15:34:25 +0200
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250717133358.1541e5df.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2025 21:33, Alex Williamson wrote:
> On Wed, 16 Jul 2025 08:49:04 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> CDX_BUS driver uses msi_setup_device_data() which is selected by
>> GENERIC_MSI_IRQ, thus compile testing without the latter failed:
>>
>>   /usr/bin/ld: drivers/cdx/cdx.o: in function `cdx_probe':
>>   build/drivers/cdx/cdx.c:314: undefined reference to `msi_setup_device_data'
>>
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Closes: https://lore.kernel.org/all/b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org/
>> Fixes: 7f81907b7e3f ("cdx: Enable compile testing")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/cdx/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>> index 1f1e360507d7..3af41f51cf38 100644
>> --- a/drivers/cdx/Kconfig
>> +++ b/drivers/cdx/Kconfig
>> @@ -8,6 +8,7 @@
>>  config CDX_BUS
>>  	bool "CDX Bus driver"
>>  	depends on OF && ARM64 || COMPILE_TEST
>> +	select GENERIC_MSI_IRQ
>>  	help
>>  	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>>  	  exposes Fabric devices which uses composable DMA IP to the
> 
> This looks incomplete to me.  The Makefile has:

Just FYI (because there was no public email), Greg applied this one, so
whatever we decide here will be on top.

> 
> ifdef CONFIG_GENERIC_MSI_IRQ
> obj-$(CONFIG_CDX_BUS) += cdx_msi.o
> endif
> 

Yes, this should be dropped in such case, at least with my patch.


Best regards,
Krzysztof

