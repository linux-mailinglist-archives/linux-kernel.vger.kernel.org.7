Return-Path: <linux-kernel+bounces-725972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2E9B0061D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FE85C30B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2D2750E8;
	Thu, 10 Jul 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTnL6dtH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31A274FEE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160236; cv=none; b=SHoaFcmN9j0P02Z0SrMxENI0BATj78cdM1aRH3cfM67f4fIzwcfUiSNXdMDKigm1TsvGEvRcp0xwoLmR6fcgZgUdirkByWpGFxxa55vG5yXiwkzL+xxTEMJx62aqUqrx01MIhBxClXcYmq4f8vVP9ujnyyhZ+xE28Gs+U0wLxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160236; c=relaxed/simple;
	bh=LmNAwWi94wP6PHMsyErnFFJsx0K547rxJJH8yH1wV+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cNKLWAs9HyGZ+EKGMU/L7Pj4TcE5Cyn0k8i14ESbCKOrGEuK+CwAP7xQT8Vx+3Vsb898b/wJJKpSZIfnZ94Venn7rQUfogIPv0xQowcc0K83rLXjqmhz5SmHBxs22nwoYpClXLYiaiXosMEc4e9fyYoYPL6tXgC2u7DG1Mv21iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTnL6dtH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23636167b30so10781965ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752160234; x=1752765034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dsrkO1JC49yMY6Xu9/9qVt3IZgKl70MxobLMW2IxqTQ=;
        b=XTnL6dtHs25byi7BAou3EKRAcv+HJfyOXrPIC7vQxenEdB4Zdubqna8YHyJB1QYVGd
         9vXKnO8A6QOAyFJZcQcxrpMoPT+4ZX8vljOrCM9N6Z8Rd0+VZ58LWTeG8AT4L259EkkL
         n4RNKTK9hDbra4VFEUx0uy1RIFYyJRtfHrWhAN9O0Je6fVtcWXWf9ma6g9UylYw7yy2b
         zyrkxSx2+lGU1y5n9GV9LZO/2hfpX7XvpyIjav01BnPapX4NHdoWoCexH5r03g55Ztk7
         o0Gvd37M3Bp/Ul1pgJmoy4wI3MRPNqnnJbrm60QfvmN/DW+ZeCg4YSa6PNQ8q9y5DY1U
         kiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160234; x=1752765034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsrkO1JC49yMY6Xu9/9qVt3IZgKl70MxobLMW2IxqTQ=;
        b=h7djjNtwZCXpovwgIpq9TQ9QFeO74M7M0NcVPOgDng3j+p8Wim9Fi9PRTP4u3e2z73
         gQoIPLiKnkBk2pzrRJX9SwczCbaW/yEmaYbQoLI7M3P86Ub6BJYO81zZ6orF66w0pl5y
         0kTrJsleEVrMhS1lYhu39trsThrDBWjwNEfyvX2V22zMLVOSD2/L9DJcRr+I063fpsii
         QU+im9umy4BaSYyPrzKkPegfnxVUio4ZFqVU5S0ZnPbN3t39gddMR5z1bC75e1naI6XZ
         pHSkMfgsrjkfpL6bWO4gnAHoCWgEOWWbHfqmH/hrvhh1XjogNaJTrjiR8x48mGYE6b5Q
         1j2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUc3vLdcB+3l6iGp5+yoKqsCokju6ChycXYERr+7dV/C8m8MzI1bsv5NmTVS1bjp6R2CAWOxu+wTslzOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFPAwbN04T3Qzl56XG15THa6xYdv7h3Sb0sjp7pImMf9W2J+3n
	igYWSnZnQDBBT1Tvlcbi/++Exg2MWRCJcIu8FQ0MBy2+mKd5wMdsv9AXwrO6LH83
X-Gm-Gg: ASbGncuXSX3RYkM6aWnDJDQsU+wAbU+UcQdjwmnoAttqekfI9AEE3E0DfymRyXjVkQi
	5KPLZY45LJHUHTx4jKkp2KednCBwKdTCrBvxPJ5wzUzsWVvsqBJyiANO3wpxFj9pSjvZN/77cZe
	V+BRkD/KlLf4r6V/JYw44GeStgSo84mpS37wD8rAm7xPjo4oZtb0u9dYjPvv8iWTaS++/s1Zup+
	224kW6ddIwVyJD2+4EqA3eQOHSWHF1KSdPLgGhJ6Bh2CrzwB8awIzFlkuEzF12FPHFcokjNAUsa
	1cQEWogRKT3SITJ3qr24nUlxVLkuVNl6vdiBPH0zouR1N779HaSx+48VM2tW/SJToYoQbMO+5Kn
	OZBiMkalpOjjs5tDu7MWtIvjerOQnGdo0TUDK5ag=
X-Google-Smtp-Source: AGHT+IGUZhbP3pRxpi+Rblq9vAaGFn2rMI07JujZ1Prk8ojIW91mdoSUqIrBrc5vvS8yvqfwqBMtAQ==
X-Received: by 2002:a17:902:ebcd:b0:237:cadf:9aac with SMTP id d9443c01a7336-23de24d9376mr72601785ad.29.1752160234341;
        Thu, 10 Jul 2025 08:10:34 -0700 (PDT)
Received: from ?IPV6:2409:4090:20a4:5c0c:c48f:19c:3b62:c592? ([2409:4090:20a4:5c0c:c48f:19c:3b62:c592])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4343e48sm22862495ad.190.2025.07.10.08.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:10:33 -0700 (PDT)
Message-ID: <8af20362-2ec8-4d56-b5ea-fc226775c37a@gmail.com>
Date: Thu, 10 Jul 2025 20:40:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firewire: ohci: Initialize payload_bus to avoid
 uninitialized use warning
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250710073906.24105-1-purvayeshi550@gmail.com>
 <20250710125227.GA25686@workstation.local>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <20250710125227.GA25686@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/07/25 18:22, Takashi Sakamoto wrote:
> Hi,
> 
> On Thu, Jul 10, 2025 at 01:09:06PM +0530, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/firewire/ohci.c:1514 at_context_queue_packet()
>> error: uninitialized symbol 'payload_bus'.
>>
>> Smatch reports a potential uninitialized use of 'payload_bus' in
>> at_context_queue_packet(). If packet->payload_length is zero, the
>> variable may not be set before reaching the dma_unmap_single() call,
>> which could lead to undefined behavior.
>>
>> Initialize 'payload_bus' to 0 to ensure it has a defined value in all
>> code paths, preventing any uninitialized access.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> 
> In my opinion, we should pay enough attention to the value of
> 'packet->payload_mapped' variable when considering the issue.

Hi Takashi,

Thank you for your review.

The change was mainly to address the Smatch warning, which reports a 
possible uninitialized use. While it might not be a real issue in practice.

> 
> ```
> $ cat -n drivers/firewire/ohci.c
>       ...
> 1385 static int at_context_queue_packet(struct context *ctx,
> 1386                                    struct fw_packet *packet)
> 1387 {
> 1388         struct fw_ohci *ohci = ctx->ohci;
> 1389         dma_addr_t d_bus, payload_bus;
>       ...
> 1474         if (packet->payload_length > 0) {
> 1475                 if (packet->payload_length > sizeof(driver_data->inline_data)) {
> 1476                         payload_bus = dma_map_single(ohci->card.device,
>                               ...
> 1485                         packet->payload_mapped  = true;
> 1486                 } else {
>                               ...
> 1489                         payload_bus = d_bus + 3 * sizeof(*d);
> 1490                 }
>                       ...
> 1496         } else {
>                      ...
> 1499         }
>               ...
> 1506         if (ohci->generation != packet->generation) {
> 1507                 if (packet->payload_mapped)
> 1508                         dma_unmap_single(ohci->card.device, payload_bus,
> 1509                                          packet->payload_length, DMA_TO_DEVICE);
>                       ...
> 1512         }
> 
> Unless the variable has true, the dma_unmap_single() is never called,
> thus the issue does not occur.
> 
> 
> Thanks
> 
> Takashi Sakamoto

Let me know if you would prefer addressing this with a comment 
explaining the assumption, or if you believe it's appropriate to silence 
the Smatch warning in another way.
Alternatively, would you recommend simply ignoring the warning in this case?

Best regards,
Purva Yeshi

