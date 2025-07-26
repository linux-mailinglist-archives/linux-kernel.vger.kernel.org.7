Return-Path: <linux-kernel+bounces-746729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A15B12A89
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080AB4E48AD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DCC244669;
	Sat, 26 Jul 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gxBQj7IA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80F243376
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753534587; cv=none; b=ffwm7EAE54iFMQcjoX8+tMZYCP8cemsD9AE2Sio5M9Jgo5LK6VIjTdCN4O4nI2ISzons4J1CEVttDOxr/1+ZyGbtM33EFpYe/cvl/KAvNqdsV5XNVjMlT/whklPs/HLr/jlw9zqvqRwy/UJqz5jukOl3JRDvpgbzJovJoqhu0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753534587; c=relaxed/simple;
	bh=2s2R/UOkxr5JqesTnpu8H8gMVEpM0R3qzK7yClKajVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GViqUAcHluTFPk+6Wyxyk6WQdQbTYt1/PgAp2KG8JUwD191KDlfn0T5Iv9wxpL2teOH47p9PbuE68Kjkrep6Sdl7HuzKDlzE9JsUgepcHgliMy1cgQ0yQLDiqs7PCfa+bLoHC+d24o/6zXncjzXDA/OxY7gpJAZyN+R1QNEY0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gxBQj7IA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so38917f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1753534583; x=1754139383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oVd7AMali/jsi6H1hzbMRMOEHFNbKvjmSzlnGm24Ac0=;
        b=gxBQj7IA1HBi+YRu9BuwmFox9nam0KLfaoU+TLvxKbm+mhFqNI6Yejpt56o1wW7H1l
         X9Y0YR8hsIfd2j+PvqineDMFRR8oZY+0RwX75mjWNSZl71XUz0aWbK6P2woI5+DP3vid
         xCfwvtcyteNq41gKuep5G5VhurrI/CR0HrmfgIRgz9WhIhIHnLGNvrPJEP9o2mrswIt0
         6M0UfMCvmxb/6F04jE2ycgBD7N4hqYF547YycKSc8ySN8RPd2+dsm6hnXXaHq3yrJZvM
         xcHR4l7avQbJmiJGtC7zKiVy02KXcXJ+aWb691cWzmh3LGjEeh0UUanqEFaLrhjqcgD3
         CiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753534583; x=1754139383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oVd7AMali/jsi6H1hzbMRMOEHFNbKvjmSzlnGm24Ac0=;
        b=xTj7b27+glpEH7gZ+6GKayEg/053SkQ5+OdFrIrFNoOslWyTEQXtRUenbV0EBgmKI+
         ZRka+hbrcyqV2ARKlLWpMx6Gq7G+BUt7dl3bYqK47jKdVPu4103ZDs24MtnLnbZfW1Py
         c8d6KxZrtDMjYBs2ESOD+J04BB/GEjcpmxWkSQGcHwPIyxZk2+dHZClHicoRUU/bM3iX
         mAUJE2W2ViOEKcBueJzEZd7/ZyHqr2zAz3C0XX11ha636+Nc7GAO/YMVi3qJBa0dG6U0
         KOyhvJuYQkIjw0wZKPMAIef5Gy0g3ePyu71XQVc8M2SRa+ChPfMvRy49sdzIlb2ETbpU
         +13w==
X-Forwarded-Encrypted: i=1; AJvYcCWc7XNzt8ob0yIK1VkPUsJOYuRBj9PxLKT/mDg1/YZO+ROZDwLniMxgkWaawRrhSXYze8R29LVx2c+vIcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR0U6BFJ5kcLfSURKd21LfekyV85L12BcdJauIa48p7ALMcA9R
	MYJNPFIqh2eOXOI6Pq6ZG8fnI2fqnKMtlGIwEClr88HUGaJJNHDLPN3ttgpleZ+2IQw=
X-Gm-Gg: ASbGncv2vduDVR1MGlAUvC6GA/tN88eQP+01eFLujdVjTbEKFI68Ywre2JTm+Yz67z3
	4vt6IcPd5P5o7O4lVHSvPo/3bw+mOM6zgYRvpg/ohX2FK+PQ6NVm0AaYT8l2bka3mBFxNiAgkUR
	hyzEVwjLZ0iSI4JUcaU85pEm/Qm+XpDNBwhCQAFrdbptlyFu9Um34ayFWY+EdrhtEJhDYG15nDL
	IjUZ78B6Ug55lww5B0dmbCjlSSGfdIuzntolLWXtxerD4idTkOeePjsaUooPJiGM0JK/kAaJ335
	GXF2U/AoERCjd37FKaVcOGoEuY2EXcjfp8X9d3KYPFqsnrN4XrPuoth6D83QxZ0LcRMhXnDOCIw
	r4AqmIvfh5+R/KtpmiKUjrtmC8ktzl5YtZq3rYWNBznYA5KPztqG3MHjLbd4lYOMMFLtjW+EYrU
	Fd40MPeOS47Q==
X-Google-Smtp-Source: AGHT+IHcdmZgE50L6D5Uo+PeD640vgCbTir0gSC0WUCoG2jj5zd6WbBnoWPwULzq1pOtJHDErCHGfw==
X-Received: by 2002:a05:6000:1445:b0:3b7:7ceb:1428 with SMTP id ffacd0b85a97d-3b77ceb1730mr1042661f8f.8.1753534583420;
        Sat, 26 Jul 2025 05:56:23 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6206:d100:13e7:7f4:965e:e5b8? ([2a02:2f04:6206:d100:13e7:7f4:965e:e5b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778eb27besm2791649f8f.9.2025.07.26.05.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 05:56:22 -0700 (PDT)
Message-ID: <681b063c-6eab-459b-a714-1967a735c37d@tuxon.dev>
Date: Sat, 26 Jul 2025 15:56:20 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] net: cadence: macb: sama7g5_emac: Remove USARIO
 CLKEN flag
To: Ryan.Wanner@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1752510727.git.Ryan.Wanner@microchip.com>
 <1e7a8c324526f631f279925aa8a6aa937d55c796.1752510727.git.Ryan.Wanner@microchip.com>
 <fe20bc48-8532-441d-bc40-e80dd6d30ee0@tuxon.dev>
 <848529cc-0d01-4012-ae87-8a98b1307cbe@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <848529cc-0d01-4012-ae87-8a98b1307cbe@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/21/25 18:39, Ryan.Wanner@microchip.com wrote:
> On 7/18/25 04:00, Claudiu Beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Hi, Ryan,
>>
>> On 14.07.2025 19:37, Ryan.Wanner@microchip.com wrote:
>>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>>
>>> Remove USARIO_CLKEN flag since this is now a device tree argument and
>>
>> s/USARIO_CLKEN/USRIO_HAS_CLKEN here and in title as well.
>>
>>> not fixed to the SoC.
>>>
>>> This will instead be selected by the "cdns,refclk-ext"
>>> device tree property.
>>>
>>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
>>> ---
>>>   drivers/net/ethernet/cadence/macb_main.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>>> index 51667263c01d..cd54e4065690 100644
>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>> @@ -5113,8 +5113,7 @@ static const struct macb_config sama7g5_gem_config = {
>>>
>>>   static const struct macb_config sama7g5_emac_config = {
>>>        .caps = MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII |
>>> -             MACB_CAPS_USRIO_HAS_CLKEN | MACB_CAPS_MIIONRGMII |
>>
>> Will old DTBs still work with new kernels with this change?
> 
> That was my assumption, but it seems it would be safer to keep this
> property for this IP and implement this dt flag property on IPs that do
> not already have  MACB_CAPS_USRIO_HAS_CLKEN property.

So, this patch should be reverted, right?

Thank you,
Claudiu

> 
> Ryan
>>
>> Thank you,
>> Claudiu
>>
>>> -             MACB_CAPS_GEM_HAS_PTP,
>>> +             MACB_CAPS_MIIONRGMII | MACB_CAPS_GEM_HAS_PTP,
>>>        .dma_burst_length = 16,
>>>        .clk_init = macb_clk_init,
>>>        .init = macb_init,
>>
> 


