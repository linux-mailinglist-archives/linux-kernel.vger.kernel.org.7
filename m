Return-Path: <linux-kernel+bounces-867304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38262C022F0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35201AA23EE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8963733C529;
	Thu, 23 Oct 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoO3daVA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87799334C23
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234046; cv=none; b=ImX4kZDXqGt6Voormso/FyUY6dQPkZebKQG8CGfdR1EOYSdXVBheSCqlGGJZq89HCFSI6d8m4qTg3sBjHKEAaCOGyTIzxq0m94w+c3y+U5aSadai53D0hNbjfuwvJzsbqPgdbpcvQ3F8XQa9e6yADUrLlzGAkQVW23HJDfsiAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234046; c=relaxed/simple;
	bh=wo+q7gVJ0lDPvk3xTlIPPAEgAAs6cPPFBZRIlPTAefI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxgFQkWs/G+FZyrRpQ4VvEycktrcQPAKcGzUJA1ouRrxrMNRaCSQYS7AWi2139rL71lmjTI5QZDDSvGJhBX8FumTlSSA4m0o+k5POf7kgyNhf1effLfqi3N9Qvmir9dSnTAZfyLl3qwCNOWkJWd2+ju899qsUh/w/H7q0cNrxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoO3daVA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27c369f8986so8016525ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761234044; x=1761838844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXJXpPmoDUJ02UXvoOXxjG7CEpQb9FPd/0KUDwpNI4k=;
        b=BoO3daVAWDIewXv5Dr8Qdw/6c/vn/DDn+MdJhJKnXe1cv5cSM8DnCml/O0S+8l+pBp
         9IYxqKArEqk93D4Dt0XEI4CqYEdt4BAXd5Hu4d4JVhpJQ1HtSTsiz03v49P2u7VLidJR
         hy3w9moHuSsdiq/yujrnclIQ5zeNv/uKpfE4rNGoMxQhmksdqsf1/AaQYb8R6ImC6FiP
         ii57HM3zmPP1lbGtdv+OFWznCbNk6QllPDs0JMVBuxkYXQdsFFeoZxcMIxSXHBdh6nRN
         Ti5+r0X77k3ZKAQvklX57wN44w/EbSZvYcRCc+0PLOJbu7wqkgktHi1ONxyWpAwqmzeH
         lBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234044; x=1761838844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXJXpPmoDUJ02UXvoOXxjG7CEpQb9FPd/0KUDwpNI4k=;
        b=s6LcMZMxBrisjNHmlvwZcs03hDCFgXgokzOyXv9pfrxtRMNGtRUYxFUuIf/ayXxDB5
         JTOrE0NnX5lHaoYxvDZGMJfW8qVK7BtsoL1svqTtHmGh059+cZ/E9/q5c3lxhHsfFnIb
         2OI0x9n0NXhysZm+WfZirxSCQXq4FgiDAPvelkDu7WRczoaVRtt9Slzn4zR+gH6GSGRq
         fvTlD2cW4wMm5H5JbOOsNhDp/1CQYlOi/6PH8eARbj5sUT40T65WMZvjdpppD3PZNyj5
         u6WumF78sjfV9PvQQLFUEQYpj5DcRWQHqhgqycI84EO2nMhJERzUwvxIGzLrZRf1fvZY
         oQTA==
X-Forwarded-Encrypted: i=1; AJvYcCVTXulQvuY7HgPiLM3TW8ZoCHfl4lse44NbuwaEQDgAcgmBwEsLp0O7O4Ky3o0tu0Kf7j+qafgS+BmDbP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOEowudyZGwlYupIRWXvwXme6hijExtP5C2GbiuQ0uPyJLLO+
	iW5Ti4mxpDkmuhVOvD8j9cx9n4mLk2eJnEb4depLfqpu1u1XXVC9FM8f
X-Gm-Gg: ASbGnctTO8jjpmtG86EhyLI39p7UnkGr4vUtDZ7E46Sq8vSSa9XWvSSJj6ixjajZ9DL
	FWb/3M4vLnSNtw4amqKW1vnwJGvUarCqj8e0c6a5AnUgK/zB8UcmDPjw+cDn9Dx421mcznK+0s2
	h4mepu3lLKeAoJki6zwkEyGJGyulK1JAqz8GuC0bDHyH4YLudqJea0cFZSFyvD7AjqCg9efQgbQ
	vfKZei+0k4TMhCZ4D2K0fGMIGwN3j7xCIist891y61vki0XHMQhT9ECuBQUrQemxgnQesSYxXMX
	3wNPZgAX+qGDMmyeoyms4Pl4FoeKr1izbYVOB9XI5zDqCsVQaty6RFxC1OfhJ12xzO6pF9ykv8Q
	tFdlZhK/rcJ729fwP3Iy2U6Ef6/GQRIFh+CT0RpLRB/4DttWuzZbeM2iw1quOX6GOYtwFaKgVxf
	Br9Xq4sVaiDa+vawON/AoPtruXbtlF8SEQ
X-Google-Smtp-Source: AGHT+IFArWijSKHwpar8JwYxB7WZc8vpMdPPlpUQNI5RWkup0YN+rTI2t69HTMgDeXnxkhaW+vdAkg==
X-Received: by 2002:a17:903:3546:b0:267:e097:7a9c with SMTP id d9443c01a7336-290cc6d4ba8mr326690025ad.53.1761234043638;
        Thu, 23 Oct 2025 08:40:43 -0700 (PDT)
Received: from [192.168.1.5] ([27.7.191.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddee569sm27029435ad.31.2025.10.23.08.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:40:43 -0700 (PDT)
Message-ID: <879da8d0-1ea5-4495-90e5-03b55aa91362@gmail.com>
Date: Thu, 23 Oct 2025 21:10:38 +0530
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
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <CAL_JsqKH2NTvXGPoimpVp=-yvcQgbXSoxKY6AO16WgJHSeOT5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20-10-2025 21:28, Rob Herring wrote:
> On Mon, Oct 20, 2025 at 10:44 AM Charan Pedumuru
> <charan.pedumuru@gmail.com> wrote:
>>
>>
>>
>> On 20-10-2025 19:57, Rob Herring wrote:
>>> On Sun, Oct 19, 2025 at 01:04:36PM +0000, Charan Pedumuru wrote:
>>>> Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
>>>> property typo for a DTS file.
>>>>
>>>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>>>> ---
>>>> Note: The property "ti,needs-special-reset" was not removed from DTS cause it will
>>>>       disrupt the compilation for other compatibles as the node &mmc is used for all
>>>>       compatibles for some DTS files.
>>>
>>> I don't understand. AFIACT, "ti,needs-special-reset" is only used for
>>> the hsmmc driver/binding. But this series for for the sdhci
>>> driver/binding. So shouldn't the property be removed from sdhci nodes
>>> (and the binding), but kept for hsmmc nodes?
>>
>>
>> Yes we can remove that property from sdhci , but &mmc node in DTS is common for all mmc drivers and this "ti,needs-special-reset" property is defined there for one board, so even when I remove it from DTSI for sdhci nodes, the DTS file still contains this property in &mmc node which is also common for other mmc drivers, so even if we remove that property for sdhci node, we still need to define it in YAML to resolve dtb_check. The issue here is not removing the property from sdhci node in DTSI file, but to remove it from &mmc node from a DTS file which is common to all mmc drivers.
>>
>> Here is the DTS node (ti/omap/am5729-beagleboneai.dts) which contain that property and is common for all mmc drivers.
>> &mmc2 {
>>         status = "okay";
>>         vmmc-supply = <&vdd_1v8>;
>>         vqmmc-supply = <&vdd_1v8>;
>>         bus-width = <8>;
>>         ti,non-removable;
>>         non-removable;
>>         mmc-pwrseq = <&emmc_pwrseq>;
>>
>>         ti,needs-special-reset;
>>         dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
>>         dma-names = "tx", "rx";
>>
>> };
> 
> I'm pretty sure that's not how &mmc2 works and you are confused. I
> would suggest you do a dtb->dts pass and compare the results.

So, I can remove ti,needs-special-hs-handling and cap-mmc-dual-data-rate properties from a similar DTS file along with ti,needs-special-reset as these properties are not used for sdhci-omap driver and are no longer in use, I will remove these properties from YAML too, if this is true. Can you confirm this?

> 
> Rob

-- 
Best Regards,
Charan.


