Return-Path: <linux-kernel+bounces-894787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF7C4C19C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FE6189C4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28E329C66;
	Tue, 11 Nov 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS4zEskl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB72459C9;
	Tue, 11 Nov 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845481; cv=none; b=MOibc688Urun4SWlynkh4r1il5rMiFxygJ/k/48CDU/eXNYAKfz90ILjuVFN5nJfVGIW0i5A7FPhH+nlaZWz6V6/zPy4BtylxQAXOiZoSDbFxmR1MTKB2UeNllaQVpPpBl3iToSrhJXsgc/Begotia+0PC4HFm0WzyZCRKjxfr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845481; c=relaxed/simple;
	bh=nFjY/NLOGH3SLyK9YM2DaehQQgiJfQ5DDVKyBdysy0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCbLW1f/MNvbaZeg51vuOvc8TDKIN7lyHOF4x5JDCvteovhfjwM6FKaj+8UjAT0pR9RTdOfMYh9JBJj/BOjXAjXV3MZBMBNLWoHAr8SJUyBH5TlSIxWNr0prr0w7KJloZF/QkJfvG/0zrN45eodymcIx4UFStvIy4FhsS1CG58o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS4zEskl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB9BC16AAE;
	Tue, 11 Nov 2025 07:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762845479;
	bh=nFjY/NLOGH3SLyK9YM2DaehQQgiJfQ5DDVKyBdysy0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WS4zEskl4bUf8swlIe3uH4R/1Suhu4fYqB0rboWe+cYaPUxRkyM3a9SUC7gXqTt/y
	 LcNw4SA3wblG5mR8HRNZTAELbBV98NNEn/Q3K1rHkeWwMKwZSOOsWAgk3+bhdLh2Cy
	 wCU//SRdM1R3WJAvsfjTeGYWV1JHLyuKvlWGV9S3oLtQXXGp0wNrKUCHKAYjF3P+rY
	 H4Qw4t2eiaawqBe+d0/v+j1KfvzGYLHGVPjstkJmXh7FG3cidtsVINCZDEK0zE/md9
	 cG/tA0VFNfrF6mBNPTIULjH4fae2FhXR4NjOZnF7znhYahcetesXepXrFAUGi0LSEP
	 KRoU0vWF+ff9g==
Message-ID: <d6ba62ec-25b2-4c51-8915-8e69d76b610e@kernel.org>
Date: Tue, 11 Nov 2025 08:17:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add
 TAS2568/5806M/5806MD/5830 support
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de"
 <tiwai@suse.de>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "13916275206@139.com" <13916275206@139.com>,
 "Ding, Shenghao" <shenghao-ding@ti.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
 "Chen, Robin" <robinchen@ti.com>, "Wang, Will" <will-wang@ti.com>,
 "jim.shil@goertek.com" <jim.shil@goertek.com>,
 "toastcheng@google.com" <toastcheng@google.com>,
 "chinkaiting@google.com" <chinkaiting@google.com>
References: <20251108110759.2409-1-baojun.xu@ti.com>
 <20251108110759.2409-2-baojun.xu@ti.com>
 <20251109-heavenly-observant-quetzal-b1bead@kuoka>
 <ecc69a98a23d406ea1eada62144415fc@ti.com>
 <035d6c35-c27a-4f5c-8603-ea5857d78e63@kernel.org>
 <460cd1da65bd42be890e69f26402670b@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <460cd1da65bd42be890e69f26402670b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 08:12, Xu, Baojun wrote:
> 
>> ________________________________________
>> From: Krzysztof Kozlowski <krzk@kernel.org>
>> Sent: 10 November 2025 15:11
>> To: Xu, Baojun
>> Cc: broonie@kernel.org; tiwai@suse.de; andriy.shevchenko@linux.intel.com; 13916275206@139.com; Ding, Shenghao; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; lgirdwood@gmail.com; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; devicetree@vger.kernel.org; Yi, Ken; Lo, Henry; Chen, Robin; Wang, Will; jim.shil@goertek.com; toastcheng@google.com; chinkaiting@google.com
>> Subject: Re: [EXTERNAL] Re: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add TAS2568/5806M/5806MD/5830 support
>>
>>>
>>> Hi Krzysztof,
>>>
>>> Thanks for your review.
>> Do you mean I need to add a text file,
>> for example "ti,tas2781.txt", include the required properties,
>> and the example of the devicetree node?
>>>
>>
>> Did you read the actual resources I pointed you? I don't know how to
>> express it clearer.
>>
> Hi Krzysztof,
> 
> Thanks for your review.
> Do you mean I need to add an rst file in Documentation\sound\codecs?

Where anything like that is explained in the docs I linked? Do you
understand what patch I commented on and what documented I linked?

Best regards,
Krzysztof

