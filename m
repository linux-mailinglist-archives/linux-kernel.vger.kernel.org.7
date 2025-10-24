Return-Path: <linux-kernel+bounces-868100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A22C045C6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C3818C7654
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402C24BBEB;
	Fri, 24 Oct 2025 05:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrEj62U+"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB21F4262
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761282435; cv=none; b=XMSkKcSqwRi8taGfrtqpIyHbxbAKmr3JDdVgPW/d6cxYqvpsTHrhSJJXsFBjtCsM2kUpg3YsKZ5E5yQtSTeu5pkc9lSpweVWL10PHaCNPTe2Pgc3Uq+Pf953DwtN+2skfEYl5390hpMU4OLUbGI5n9QaOdBOCvWy+v7C+9NBo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761282435; c=relaxed/simple;
	bh=KOf5eTT11tPiB1wFmIqqQb2LaNMmdMl4equqT2XQSgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5eN5IW/hEmgtcq55f/QTIszP6Cxp4EH6YoyBxFnszxNesSEcvWQeV0cMc7NcVCdJ+iJFf+GMG7E5BowJ6rQ7Tmlh+oeuC7CKffF0uQ9y5tOlWttDH4mSBmqpFFnuuzYTbySeqrB37W1So2IE2lQMvj1KynQBvPyouZy6d3VzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrEj62U+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78118e163e5so2606430b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761282433; x=1761887233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4dG92IcCVVEabZWYsVaYXSiYtILZo3vNbT6RrXxXUAA=;
        b=KrEj62U+wZCAW4o0pOqJ3kxshHA+YGyvNmEmi9+BTecmG32HaeA38Mi/UNkUstlQEQ
         ErApVwqZsVg2gFi36uwH6suFiTqt/F01iuQyCkLQnJK15icYyfhGhKQmX8EXL/mU2q7A
         /tgwmSrUG1O/6x99cqtbjA/Nho3+gSNNwY38qq3q+Sm9pqZyFEVrFBs2An4OPrg8PPvI
         +EBbH6iUVsakG0PoE8FlwkZs5xzqV2LJ1CRhR4luzD4kFT1xGmjJFPUkUwSU+zh/1XM1
         nh0S2sFziglqDoXYYNY7QjpaIcvuw+oMuuNFtC68Bf3whNX4I8E9shCRnxyCiVx2tVay
         UY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761282433; x=1761887233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dG92IcCVVEabZWYsVaYXSiYtILZo3vNbT6RrXxXUAA=;
        b=FkoFQkYTXndom5ZwBw/e/vkyVo5z5T8plZkfthD3NLS5oVtdqH6OGVvKx6cVPV9GL9
         baEbQT2MzZzgfeS4AJ66znx9Qio4eWfNblvlXRhqW2FeaO7iM94qcFmNVzLEqQW8JMrs
         xKdjh38+/ft0JmFphRPuvX6W3nejYngE5hVgh4pehpwEVcWucnXHW0v5dAEeWkDsWc/Q
         5NAJ7k1Bp/8V2bxJyxH20fMQDTk79AbePYcOnC+FIYTz4e7PmFKLG467oqabU7a9l/kM
         i5qEQjsCWX2V2MV3u2uxlA8EGQi4GrOrT3i+m0sWDtwy7cAtoK5s6s9Ko9iMNGLfmhbg
         r4Pw==
X-Forwarded-Encrypted: i=1; AJvYcCU3EVQFwqPRiGSZNrHD4tnM53xjv8gHSaNMPgDypCJPQWoYTY34EkV6Gii3neBBTkckCGMuJ2xabK00Z/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKdL70qmtFp7DBwvwOFUbR7MbqXccr+ip6mDDHYKCQrxiP3vTT
	Z/pTjQOGY0+h176nYLZU7FOQzXJzhcg/z7VYBuvNWM9eODuY5KrPmpJ4
X-Gm-Gg: ASbGncvCHXZELCZxx/odmBr+ZeLoDmqZmc5SYi6L9KGtORdnQvx5vn6X/BYrFniO4SY
	c8AWFQuCzm6Qo4G8xrn7qBeRXD2zcCBVRqvKHc/y2F84/xLnBrR1vmR/A+VHC04vNgSN6vDwc4H
	WNVrHv4bfyfiejv9ZhOx2iDY07Jc/VZkhpAuRvEL24pBr+zNMCIBZBgDL49N10yD3AVdT0e4bLS
	sCDDMyppQ16XVF1KAxCEa685poWFEfZjToGnFj9RFi3oQNehqx9RDXzvrUlNt2t4fazTCF8m8EQ
	tpQMZnZV/bYlc0iG1xDaJdp47lXIeb6BfS6gIh95R9OQS3I7kqtpAL1ocsUFqHIJ30JLr3zGsCz
	sSQWC+6r0abJ6E/ajX2L9SPBP+YgLoGHqZq9bRO20SIBUX6vP1GezBWUehoGUn/hUGsfoD1rCAk
	FwiqVvqfMHH56ROjv3qMChoBcsoDFD6HwD
X-Google-Smtp-Source: AGHT+IGBgs2rmcQIySneHl58HLdSVRyoiObGynjzZrftZshrhpjwRJbzVvC89kZLGHBalw0a0P9C5w==
X-Received: by 2002:a17:903:1ae3:b0:267:cdc1:83e with SMTP id d9443c01a7336-29489e10c88mr17625235ad.15.1761282432595;
        Thu, 23 Oct 2025 22:07:12 -0700 (PDT)
Received: from [192.168.1.5] ([27.7.191.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e9dd105sm40716945ad.24.2025.10.23.22.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 22:07:12 -0700 (PDT)
Message-ID: <cc3ff4ce-1ea5-42a5-810b-c330b1fbb3a4@gmail.com>
Date: Fri, 24 Oct 2025 10:37:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com>
 <20251020142710.GA576827-robh@kernel.org>
 <46aa84cd-63cc-4263-9061-021fa3205b87@gmail.com>
 <CAL_JsqKH2NTvXGPoimpVp=-yvcQgbXSoxKY6AO16WgJHSeOT5A@mail.gmail.com>
 <879da8d0-1ea5-4495-90e5-03b55aa91362@gmail.com>
 <CAL_Jsq+ZmvVHvmLYKQD0fn74+9WcnmDVAqC1Q48HFLVN35tuFQ@mail.gmail.com>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <CAL_Jsq+ZmvVHvmLYKQD0fn74+9WcnmDVAqC1Q48HFLVN35tuFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23-10-2025 23:52, Rob Herring wrote:
> On Thu, Oct 23, 2025 at 10:40 AM Charan Pedumuru
> <charan.pedumuru@gmail.com> wrote:
>>
>>
>>
>> On 20-10-2025 21:28, Rob Herring wrote:
>>> On Mon, Oct 20, 2025 at 10:44 AM Charan Pedumuru
>>> <charan.pedumuru@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 20-10-2025 19:57, Rob Herring wrote:
>>>>> On Sun, Oct 19, 2025 at 01:04:36PM +0000, Charan Pedumuru wrote:
>>>>>> Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
>>>>>> property typo for a DTS file.
>>>>>>
>>>>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>>>>> ---
>>>>>> Note: The property "ti,needs-special-reset" was not removed from DTS cause it will
>>>>>>       disrupt the compilation for other compatibles as the node &mmc is used for all
>>>>>>       compatibles for some DTS files.
>>>>>
>>>>> I don't understand. AFIACT, "ti,needs-special-reset" is only used for
>>>>> the hsmmc driver/binding. But this series for for the sdhci
>>>>> driver/binding. So shouldn't the property be removed from sdhci nodes
>>>>> (and the binding), but kept for hsmmc nodes?
>>>>
>>>>
>>>> Yes we can remove that property from sdhci , but &mmc node in DTS is common for all mmc drivers and this "ti,needs-special-reset" property is defined there for one board, so even when I remove it from DTSI for sdhci nodes, the DTS file still contains this property in &mmc node which is also common for other mmc drivers, so even if we remove that property for sdhci node, we still need to define it in YAML to resolve dtb_check. The issue here is not removing the property from sdhci node in DTSI file, but to remove it from &mmc node from a DTS file which is common to all mmc drivers.
>>>>
>>>> Here is the DTS node (ti/omap/am5729-beagleboneai.dts) which contain that property and is common for all mmc drivers.
>>>> &mmc2 {
>>>>         status = "okay";
>>>>         vmmc-supply = <&vdd_1v8>;
>>>>         vqmmc-supply = <&vdd_1v8>;
>>>>         bus-width = <8>;
>>>>         ti,non-removable;
>>>>         non-removable;
>>>>         mmc-pwrseq = <&emmc_pwrseq>;
>>>>
>>>>         ti,needs-special-reset;
>>>>         dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
>>>>         dma-names = "tx", "rx";
>>>>
>>>> };
>>>
>>> I'm pretty sure that's not how &mmc2 works and you are confused. I
>>> would suggest you do a dtb->dts pass and compare the results.
>>
>> So, I can remove ti,needs-special-hs-handling and cap-mmc-dual-data-rate properties from a similar DTS file along with ti,needs-special-reset as these properties are not used for sdhci-omap driver and are no longer in use, I will remove these properties from YAML too, if this is true. Can you confirm this?
> 
> If the properties are not used in drivers or .dts files, then yes they
> don't need to be in the schema.
> 
> I think you just need what you had previously and just drop the
> changes to hsmmc nodes.

Yes, I understood now, thanks for the clarification.

> 
> Rob

-- 
Best Regards,
Charan.


