Return-Path: <linux-kernel+bounces-850521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E5BD3155
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F65C1899A69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39F2DF139;
	Mon, 13 Oct 2025 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7iQBH7z"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7732877D5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359974; cv=none; b=DkfAgBndjQSI7YunumgjyH6KqyLrW7HeNH1utvoLSXtmwFSJw+gE8ujoU7BGMEd5eT844aRPdduXldZxB4UUmKmoyiZv3cDCIOkStpU85b0hjdDEhhV0eDc/vKxuDPbgh4dSShh6Z9Cq8Rr+Wbnhui0RH68T8sK5L0FZL+YAmCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359974; c=relaxed/simple;
	bh=veB2ekC+v+jOvBRwKgJpVvI2Ki/SBVYFi1JBEeYd+Dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxJJwM/eBv8nBwzndQeLDRq2j18o6IP939pul+lM/lu/EootCiy+rRMcAFysIZKpV2f5gyXRfn9jIcaBiTL59oUhimVa35/TOrDmE4q+rYF/Yy7UzOVVCp3+PxFXKZJJNEVsPpC9WDUM4fxpORx9/99zGMAG2ytXwK4I3ayQOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7iQBH7z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso690714266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760359971; x=1760964771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGTQzqOpqmdFB4gV3HPPWK1ZwdyzuxlpeMip3GTHBhA=;
        b=V7iQBH7zsKGQy995T4R2WkgNgku82vaDfEA8pEuYev7FQAQcHDnt4gWtdd9gLsAtC1
         G1NVaF9FIh6ypFgliNGkd2uCiwzf32kdOTeKupZbxXGhwpWbjQeqT8e/FCstePPLKBSl
         ZB8r/RvnheKPhmFMIHczAx0H8GJV2iGv1vyvamdBPrY6o1h1LlzL9xiJjJPTkKy4+nsk
         efpElqcHyXhdtmsk8DtUmTMnp7m9LBVCE8LFU8z9V0Eq2TFyzF8SHRbu+LsBiC4XMXlz
         GkaIkG5MymXEPU/tb+TlZcuFQEuvRben+cF6WPjQ8+ujbbVLZS+42XuAO1xZrJbZdLSi
         E67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359971; x=1760964771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGTQzqOpqmdFB4gV3HPPWK1ZwdyzuxlpeMip3GTHBhA=;
        b=uCk79CZ1qyHE1X819jV69+UIOW218/YKHw9w7K3Q7RWUjghZCk3tCJpPUxsm1GeJ8V
         E3Wq0I9a20MnZI1d+dOq4LocsNIo9XnB8kc5xj+nfkHdyOvSGORTPQHlrD+UaF1Du3mc
         0aTzHrtouyXx1Mwo/EAWRtvma0Cj4iQmPhaTo2cQZDOJ3KJVIxxY0hkcGqUhTQxVZX08
         xIqaLSK3Ezd77DIZGFOgTo3Uol8yr84XsOUmRNqIOxayQi/1f/FocCOSEnHINiOGyxxW
         /Mk4nqbi2UZ/IchLXXYSzisLkpJbbFYxaft8mNmvI+GEzp53iUCVAYrrzCLY7g05X+ZE
         d6nA==
X-Forwarded-Encrypted: i=1; AJvYcCUzRBneamATAzvuzl3JW6sYMVePd+8MOUvUnrWLLXdPnik1xH3NMuIhALQabWsy+Ef5AficQlhLoB4e3RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcmw6YoYFJA/Si4jpQtMYBEEZMvOK06G+sfIXKNxANfG5msJq
	a29odhAO/ReVem92AdE72VBIzmQI1TPeYxsmXjoC9RVgjRl31dhWi5Lo
X-Gm-Gg: ASbGncvLraYjuDB4/oHlnczTeisIlANTON4R9/tY+W4yHJVTYUT+MjSFT0op4Sd+8v8
	FDmwTppOGldkwtIj17gTIzRYzsXE+ceV2uOevf8q9KrAnxnqcC306RF3TQ/0Rao6Ra+spQCUEkU
	DpI8kpd48dmtyreya7M5DIWj1FdSHGjingWMo4FtF9LBJ4XNnlNnsQGpZfp4JRsKJPmQhcY6+SM
	xtQQnciCObv7cPML4eB+lx/Jo/nxHSUxL+t/QuECOWpBf/pibVGwB4a5Ikmw/UmC85d13ueRQ5M
	b2o2rCpIw7rwUvn85AfL4J75SHNTgkmHmyT9XeqGQv0oyzITy1DSyTRihST0ZL8W0niTn7yTBTe
	UMgISQfK5aZ7p/XtKs6tMaenGnsIBE6v9KDErovubdHdd2R1YUq+suSK9gz9UX+2AeiNJT/jLaV
	RLeFmg
X-Google-Smtp-Source: AGHT+IFmmG7MUY5yB4mZ2FFQqWGfn+1ow8HKXXWlks0nW+FmPuADWQrKCGGjfAyKnyrLWQQf+T1dkg==
X-Received: by 2002:a17:907:7290:b0:b45:a03f:d172 with SMTP id a640c23a62f3a-b50acc2f5bemr2364136766b.57.1760359970930;
        Mon, 13 Oct 2025 05:52:50 -0700 (PDT)
Received: from [192.168.4.55] ([92.120.5.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d95257c8sm920389866b.77.2025.10.13.05.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:52:50 -0700 (PDT)
Message-ID: <27b2e692-ecff-483f-bb88-392f6ce87574@gmail.com>
Date: Mon, 13 Oct 2025 15:52:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] dt-bindings: clock: imx8ulp: add SIM LPAV clock gate
 ID definitions
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
 <20250804155407.285353-3-laurentiumihalcea111@gmail.com>
 <20250805-natural-vulture-of-glamour-5fac8d@kuoka>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250805-natural-vulture-of-glamour-5fac8d@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/5/2025 10:02 AM, Krzysztof Kozlowski wrote:
> On Mon, Aug 04, 2025 at 11:54:02AM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add ID definitions for the clock gates managed by the SIM LPAV module.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  include/dt-bindings/clock/imx8ulp-clock.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
> This is part of bindings patch.


ACK. Again, sorry for the easily avoidable mistakes.....


>
>
>> diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
>> index 827404fadf5c..ebebb4831761 100644
>> --- a/include/dt-bindings/clock/imx8ulp-clock.h
>> +++ b/include/dt-bindings/clock/imx8ulp-clock.h
>> @@ -255,4 +255,11 @@
>>  
>>  #define IMX8ULP_CLK_PCC5_END		56
>>  
>> +/* LPAV SIM */
>> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_CORE		0
>> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PBCLK		1
>> +#define IMX8ULP_CLK_SIM_LPAV_HIFI_PLAT		2
>> +
>> +#define IMX8ULP_CLK_SIM_LPAV_END		3
> Drop. Not a binding (see other discussions for many SoCs why).


these definitions are being used by the clock driver we're introducing here


>
> Best regards,
> Krzysztof
>

