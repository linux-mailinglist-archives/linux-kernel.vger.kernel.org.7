Return-Path: <linux-kernel+bounces-851667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E9ABD7061
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B443B0DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07528274FE8;
	Tue, 14 Oct 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="b0ZpkTIN"
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8FB263F22
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407041; cv=none; b=iHQDLxI9KMMlzGVTpkRrRI+T37OxUb7E9H5faXyaVNU53Fhk7N1qoV8hBQStjbp3Dk7PzJLkw+voFwoz7fV8Ez6SM90s03/5wrfglSoiJo4QNEfqon+4isH9SIlrPHbii61JHzotOwKG9rIWSMGjGVLQLFHUlnbvl+H/88CECHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407041; c=relaxed/simple;
	bh=i3JH/UyTwdORR76plBkkx4i80jRqEPvGe7n87tMkr6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0GCl2jkl0rbZ22HxOL9bfA3z/5wk9moH3PnCUlGoIZcBHwudNmsqXNXF4BnF5tJdru8G3o5nS0BEKys0mN67tUe6d8tecZcPXZ0fX+hF2bGgee53UKFQpyyxePQzFeJXPTGF0A2B/RTLffzi89JPjKB4nMpNSK4BS+8PUcATxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=b0ZpkTIN; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-91179e3fe34so254358339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760407037; x=1761011837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DRqpVkhMILdGgOXoNXOKPLRF82QFKKsH1zKrfan+k9o=;
        b=b0ZpkTIN4KOUZXsZnh0wl4usA1yfdHCD4r9A9/T2OY2Zbf/w48kqvskyMMOE2QYBZx
         eGrPHjVDJCnGN62RodHUilqHNc7X4WVDv8nN2dxNWOsKxV+QmeT1u7Ux3bwjoO8BQ3n4
         hyrPFGy+281itNpFm7L6LZZqOjWv6EgXmD/QdR6yZvR0AAcOubFtkKfIoa+ntx/0/95C
         Zcid492UkX83icxyVg6rt42MRw3fWUf8zeTME09jlB0Io9dIQG5QIZSJBgqqxzSDYZlT
         3T8pcU0A58CmJlxeHc9b4z9vJod397IZQfLN1kOhMKlCO56UfKEq/loFq2Np1WrlmC5K
         28WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760407037; x=1761011837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DRqpVkhMILdGgOXoNXOKPLRF82QFKKsH1zKrfan+k9o=;
        b=acVy4lZ9Cy2vbT3s3uEsS9qJgTWqbuU98MWrM64b7yNYLNk0LBZZJCOJDbz3R0RxG5
         A03WTINIEx8HNKexVXnBjOjkbsAAv/mX3mXQ8+RgAKIWgdRra40+0VKeUTsuivGE8azF
         rgQ+EPq1V+ZkFQAVz31ylfP6VnmPYDIbZKPtMwINqPjS+4Y7qjYqAYXzE/z39KiYZcF0
         eNBdg6mkUebWexQnCJwpVxP8HQKSdpa7nNLDpGDxFmhA++pOSjG2epXEPgC63aRYXPrH
         bPHZ2LyX3mPg4PuPcfEu8/GdiLsmgpgHff1jXH7Qp3w1eL2I0nsd8o2PtYM3iWpqZmwe
         aApg==
X-Forwarded-Encrypted: i=1; AJvYcCWEZnrg9YfvqEcA3j+iijtccvv88AlQUcANNZFwsXfkAi7/HLIl2xYF4DGNJ6C6Zfhno+3i2zVb6PHP9+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6+z2XmqbcLfgPCvD7pl7/90pvH7ruHDY610yDNef4USZMrBS
	i5Vax7SXGtwXfMrerABhoAeXtPFdxIhjLwTvyibT6lkhpuQvm5xEUjEF3wM8/qfp7as=
X-Gm-Gg: ASbGncvuOcQyItvtZ18OBUU1ZO5hP12xMACsZt6rvmVNHEivCZeDFJd46q7b8Mw0V+j
	dY8eeq6TVm7n/B3e9Eeseio4PGa4HLOi8p8954CkP315wL5eibMCcTNAwudemP8KQPdNDBRzDP/
	20L+dtPxaMAaMPT44yrd/V1y6SXmwTAwLvgN1fiNP/fPSXTu8b+fgtvw0WgSSWjiE52lI8MOE23
	RACSIGkSW2oMtRmn4pfEmoKpe3eDBHO0XSfnTPwqskoxuifcODI2icTc1lQts+9DJstb/xGKikK
	E2IQXS3dwsG/wbIKIIOrnd+cDW11lAa9cH9xYwR0H+vJXhiP+DJSpKzpo8TeAQ5QrUMqNaiAEON
	f/+rqVTXjpmJIft+qMXCeLMxXdAKvR/jRtEhVpyNpAeH3ee68vR+NcU4Lyuah1UxYl1hLkYXEry
	nmuXPceq0BWwQYKQ==
X-Google-Smtp-Source: AGHT+IFz+6u4FT7mXO0HjOe5eXpI34wWI1ZFKrY/cjEseejOQH/7Ctss1Fp2rB13acyyKvsMsu5OOA==
X-Received: by 2002:a05:6602:811:b0:87c:2a76:4cf9 with SMTP id ca18e2360f4ac-93bc4074509mr2599466339f.1.1760407037052;
        Mon, 13 Oct 2025 18:57:17 -0700 (PDT)
Received: from [10.211.55.5] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a659a0sm455091539f.17.2025.10.13.18.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 18:57:16 -0700 (PDT)
Message-ID: <860df9d7-9791-40de-903d-0f62d34533e7@riscstar.com>
Date: Mon, 13 Oct 2025 20:57:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
To: Yao Zi <ziyao@disroot.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bhelgaas@google.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, vkoul@kernel.org, kishon@kernel.org
Cc: dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 p.zabel@pengutronix.de, christian.bruel@foss.st.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
 namcao@linutronix.de, thippeswamy.havalige@amd.com, inochiama@gmail.com,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com> <aO2tkGSUTYssSaVf@pie>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aO2tkGSUTYssSaVf@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 8:55 PM, Yao Zi wrote:
> On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
>> Add the Device Tree binding for the PCIe root complex found on the
>> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
>> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
>> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
>> typically used to support a USB 3 port.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>> v2: - Renamed the binding, using "host controller"
>>      - Added '>' to the description, and reworded it a bit
>>      - Added reference to /schemas/pci/snps,dw-pcie.yaml
>>      - Fixed and renamed the compatible string
>>      - Renamed the PMU property, and fixed its description
>>      - Consistently omit the period at the end of descriptions
>>      - Renamed the "global" clock to be "phy"
>>      - Use interrupts rather than interrupts-extended, and name the
>>        one interrupt "msi" to make clear its purpose
>>      - Added a vpcie3v3-supply property
>>      - Dropped the max-link-speed property
>>      - Changed additionalProperties to unevaluatedProperties
>>      - Dropped the label and status property from the example
>>
>>   .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
>>   1 file changed, 156 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> new file mode 100644
>> index 0000000000000..87745d49c53a1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
>> @@ -0,0 +1,156 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SpacemiT K1 PCI Express Host Controller
>> +
>> +maintainers:
>> +  - Alex Elder <elder@riscstar.com>
>> +
>> +description: >
>> +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
>> +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
>> +  MSI interrupt controller, and supports 256 MSIs.
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
>> +
>> +properties:
> 
> ...
> 
>> +  num-viewport:
>> +    const: 8
> 
> This property has been deprecated for a long time, and the driver now
> detects viewports at runtime since commit 281f1f99cf3a (PCI: dwc: Detect
> number of iATU windows, 2020-11-05), IOW, it makes no effect with the
> current mainline DWC PCIe driver. Is it really necessary?

Based on what you say, the answer is "no" and I'll gladly remove it.

Thanks.

					-Alex

> Best regards,
> Yao Zi


