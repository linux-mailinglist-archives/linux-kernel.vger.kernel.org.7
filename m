Return-Path: <linux-kernel+bounces-882601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 561F1C2ADA8
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E60B4EE5CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7D2FAC0D;
	Mon,  3 Nov 2025 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n274YcmW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OfttIeR1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B82FABE0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163442; cv=none; b=AREtQDwY1Zl5djOQTWjyWDWmkGceWSbJzGMT9AcO5UzzURLRB++CqjyFpcmIJs6rIgQzWCJxy1mvEm1hmHZ2OBNjdaEebbFAtiIeEit/9m2gqHF9TmHW7FI7XXcjWVMLWXj9+pOiXSRqRQKmlD+xGLrS6mFxhfvqY+mVAiDnlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163442; c=relaxed/simple;
	bh=8+/xzV2on4rrn+lAPCsi+lObQn8aZjFJ9O9i3JBGvmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXgHveQiRzYeX7B60JTEmP3FYIDZXM0V20BgCyBlrRaFeM2F9H9cFm2BRz1xgKcI8GIb2wfemsl9QPI5afNRcATofvIocWXj6wsktu87ak4NVsX817IPW1SEdm0kOAXgLSChKk5XKkSmkjU7Smr4ww7KWlryVePxXVjqgXKXf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n274YcmW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OfttIeR1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A38Efhs1115111
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 09:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UJ1aDhkB06vvZs1dKrWIYRYXNH0OKlW47PivXqNYdno=; b=n274YcmWN0qtJwrX
	Em2QGFKIoE2LhxWEZBkNMhi9Eg6/cAjsomJRdLnSPpVyINZ2wREI4HJmV2ciZLiq
	Z3StYT8RiXPOt38/eU4xQkUxm1k3Xpv7XvbkHuABO5yVTeIk7JsogrNW5Q/so0M1
	tzRfi/Hvn6bhTTVYyqTUkblLklItFNROSc7552ysIayR2Vcy/duO/aYna7AeErSn
	4bFHtE9z9dNUtHIaz/tW6HuYWWhtqUH6UF3qe2gvfD9uanrnAXTbhq+tR/gIAld6
	yPA78GBcVBGuPnmdX9Fbfg7pDXlWiz3J8a6gHokPCNHQgG+N+IedhLcBpJGEfnWS
	CozVFw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6f0w9g3p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:50:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34029cbe2f5so9764859a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762163439; x=1762768239; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJ1aDhkB06vvZs1dKrWIYRYXNH0OKlW47PivXqNYdno=;
        b=OfttIeR1Gn0UEC5U9VQUqnzJoz65C6zwUqtwP6hcMB1pZr/k6iXZNTThw6yaD/50XK
         rahpPCqtEOnFVyjkixPohQdtfOY3QIjkigKpSURt0GaUZFUnTUyETm57AyIhJBaWjBAm
         xbbnxf3+BRoKCKIeFvcs0JSIqiQdiLqhCykT30rLBQWzPpdv7WwZpOMAVwbTuv55vg3A
         4uSvwFBEeu08wYflExi+hiYobjW1pPdE5fT0K2tHDvO4nrPKoyyNSE0q2xs2Cr3/JJGA
         +7MKpmZZUOWKIj1/+i7giMxuN2H04nGRtIQm1lAxZCjuN4+YpmNnfjrsGKt1HLyyz0Jv
         0PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163439; x=1762768239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ1aDhkB06vvZs1dKrWIYRYXNH0OKlW47PivXqNYdno=;
        b=tDU+087fLahQgSWTgP79vBLMPIhGOjnhOlCSiUepDTDWr5SXAaR/DE/wjWtcPgTEok
         zOWLdV1/XPHPbIcFl/os6mew8C4wZ+N+xItgAL0zD8TWv/lmdVtWARYCwqtZb6JS1M7+
         FeJB7UrLthdIfvO3eUYp1Ea25aLQsyfs/0fpVCepvlC2VyATo8lmtnEbpbhiJA1KCMos
         YI2y/kQ3KI2Osw5kAUqrp1zhPYqIRG7sITjhehUPqdmQcJwFNch+s3CGXQJTbsDcVHP1
         g3p8JyVGMGFQin48O4ktfJWTUxOJ7X6QYao6S+QI/HBXSfcpq1n8BhQhb8sdyw+iI70y
         oUGw==
X-Forwarded-Encrypted: i=1; AJvYcCViW6n9YorLiqWx5Ud2xXKybMgBtksjH6AP5OkdwiInoe2OkpejMXMy9Co/KOvT1n6aifw5cwxZMok1le8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy027J385GoL8OLyIzy9O//VpURtpuQ4J+2zo8oM3Nc77yX2Fwz
	L/adWfDX6oESYwTM5KysWpEgRQ1P1e9Q+UkamxRaN1zEwTQjjhiS40NRYpWDABhdM7Kp4BmBPxm
	G5x9yAg0+tWnAQVyExSoOhIQVOhUA0T7VzrA3K2JcwWZ5Bqusbm48ANDWVT3nr5RW5PI=
X-Gm-Gg: ASbGncvHb70eb1S5ni14CpbtWZcQSZua9MjMGBC3s/ve1DXw5yh+IbigobzS8AYwBM5
	+TT/6T47LZ7O5pzTpeHBjqxR59xcMcVu3Ugm41D5FizJvgNBYKod/lTaLCKusiCLC2iayGlvm5T
	hs6iOjITGFVTuxRBZOVQZYYR3QNuRVfdn2Ke0kKKQPzv88xKDVDZjTVD20awwxajoXHlaJ3qtuL
	XJQrhi8WJ7txpKv8WafpyF3PEB4QJrICRy9E83cUgcQDcPqlQM3Y/H1oo3WoboTQCOO+Kqbs1RU
	rwNu7U4ZhXBVvuJ0elhKVawrp/VI5QqxcpUiFNrbQAvRw9RDWrxWYpjl1hu8LxvYqztJpHayn54
	uSZR2BJGbfTOHCUh6kZx4K4IS2GiEKjx5L4fe6IZ1iRh6+YxFE6HfOa6dKy91VGfVSBV0REwsWN
	NHC/eg4IYL0DfxUK9UxCoRvA==
X-Received: by 2002:a17:90b:51d1:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-3408306b9f3mr14441355a91.23.1762163438898;
        Mon, 03 Nov 2025 01:50:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4T8dX9DwnT9dVx72hgvS77fZ0A4adsitM1oKseFqCGFEOjAHZrBIUEAOPs8AMu+Vod5aBWw==
X-Received: by 2002:a17:90b:51d1:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-3408306b9f3mr14441335a91.23.1762163438338;
        Mon, 03 Nov 2025 01:50:38 -0800 (PST)
Received: from [10.190.211.199] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c2f30sm377765a91.7.2025.11.03.01.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:50:37 -0800 (PST)
Message-ID: <f248a779-1f35-482b-ac71-2671c38985ca@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 15:20:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] soc: qcom: smem: Register gunyah watchdog device
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <20251031-gunyah_watchdog-v4-0-7abb1ee11315@oss.qualcomm.com>
 <20251031-gunyah_watchdog-v4-1-7abb1ee11315@oss.qualcomm.com>
 <9421ff80-bd86-4b29-baca-c86da90c91aa@roeck-us.net>
Content-Language: en-US
From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
In-Reply-To: <9421ff80-bd86-4b29-baca-c86da90c91aa@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4OCBTYWx0ZWRfX/OX9zzMao899
 zmSS+mm+ZDGNyRiU+T8n/ApXFVV9OUlO0sTkp+/PpwaknAEgDjWW2Qtf8MCQahUBbI80YaPdI/3
 jTn+eMNBJf+WLpb9Nnr8RcODZcEvUUsNusdxHAlt0mfWpo2yvQ8OCaCYmxTOrpKs6eQEzwBLTGS
 2EHVLN0wupzXjv4PCPNOMUiPPqcPKd/NInXWtbK039bbvccNiv1YR/y3flFTSo0uzl/EtKQgGEi
 rl/7OcmRBHgQsw8GP7YKp1197ZaOkbKablJ3Ox6tbJTPsMhFkRAYU3DlU4Xo3aE2cuKLS7gUyiR
 yvyay9iPacxB6XKIPlW1dBI56WZiAfb/lEAKo9xSBbDF2fmyVvSdxp8cgkCVov6hxWkxp2QNOwH
 dT7ngivnYLAU8S46ArTFLPe1xjHa0w==
X-Authority-Analysis: v=2.4 cv=LcAxKzfi c=1 sm=1 tr=0 ts=69087aef cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=GPS-_471uPuZnZ3Duw8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: c87WZQ0q7U3D1xMzddk7tP9TKL5nsiJB
X-Proofpoint-GUID: c87WZQ0q7U3D1xMzddk7tP9TKL5nsiJB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030088


On 10/31/2025 8:54 PM, Guenter Roeck wrote:
> On 10/31/25 03:18, Hrishabh Rajput via B4 Relay wrote:
>> From: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>>
>> To restrict gunyah watchdog initialization to Qualcomm platforms,
>> register the watchdog device in the SMEM driver.
>>
>> When Gunyah is not present or Gunyah emulates MMIO-based
>> watchdog, we expect Qualcomm watchdog or ARM SBSA watchdog device to be
>> present in the devicetree. If none of these device nodes are detected,
>> we register the SMC-based Gunyah watchdog device.
>>
>
> There should also be an explanation why there is no "qcom,gunyah-wdt"
> devicetree node, both here and in the file.
>

Ok sure, we'll include an explanation about this in the commit 
description and in the file.

>> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
>> ---
>>   drivers/soc/qcom/smem.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>> index cf425930539e..40e4749fab02 100644
>> --- a/drivers/soc/qcom/smem.c
>> +++ b/drivers/soc/qcom/smem.c
>> @@ -1118,6 +1118,34 @@ static int qcom_smem_resolve_mem(struct 
>> qcom_smem *smem, const char *name,
>>       return 0;
>>   }
>>   +static int register_gunyah_wdt_device(void)
>> +{
>> +    struct platform_device *gunyah_wdt_dev;
>> +    struct device_node *np;
>> +
>> +    /*
>> +     * When Gunyah is not present or Gunyah is emulating a 
>> memory-mapped
>> +     * watchdog, either of Qualcomm watchdog or ARM SBSA watchdog 
>> will be
>> +     * present. Skip initialization of SMC-based Gunyah watchdog if 
>> that is
>> +     * the case.
>> +     */
>> +    np = of_find_compatible_node(NULL, NULL, "qcom,kpss-wdt");
>> +    if (np) {
>> +        of_node_put(np);
>> +        return 0;
>> +    }
>> +
>> +    np = of_find_compatible_node(NULL, NULL, "arm,sbsa-gwdt");
>> +    if (np) {
>> +        of_node_put(np);
>> +        return 0;
>> +    }
>> +
>> +    gunyah_wdt_dev = platform_device_register_simple("gunyah-wdt", -1,
>> +                             NULL, 0);
>> +    return PTR_ERR_OR_ZERO(gunyah_wdt_dev);
>> +}
>> +
>>   static int qcom_smem_probe(struct platform_device *pdev)
>>   {
>>       struct smem_header *header;
>> @@ -1236,11 +1264,20 @@ static int qcom_smem_probe(struct 
>> platform_device *pdev)
>>       if (IS_ERR(smem->socinfo))
>>           dev_dbg(&pdev->dev, "failed to register socinfo device\n");
>>   +    ret = register_gunyah_wdt_device();
>> +    if (ret)
>> +        dev_dbg(&pdev->dev, "failed to register watchdog device\n");
>> +
>>       return 0;
>>   }
>>     static void qcom_smem_remove(struct platform_device *pdev)
>>   {
>> +    /*
>> +     * Gunyah watchdog is intended to be a persistent module. Hence, 
>> the
>> +     * watchdog device is not unregistered.
>> +     */
>> +
>
> Odd explanation. I would assume that the smem device is supposed to be
> persistent as well. Since  that is not the case, what happens if _this_
> device is unregistered and registered again ?
>

Thanks for pointing this out. qcom_smem_probe() will try to register the 
watchdog device again while it is already registered. As per the 
discussion in the other thread, we'll be implementing the module_exit() 
for Gunyah watchdog driver so it will not be a persistent module 
anymore. This problem will not exist then.


Thanks,

Hrishabh


