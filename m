Return-Path: <linux-kernel+bounces-801080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA225B43F94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8BD4844BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC627CB0A;
	Thu,  4 Sep 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nWBjnhvg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2EB1DF97F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997418; cv=none; b=L9dd63nR6mq/2ZJD2XefUTVlNh7TTPrBploYVtf5ABYWXQM7/j0vTfCqeBEwseMbI3ASKNBfKoHIws0cnZAOBWuT+S0xBRwgU/8TRN6MP8Ae0ag8sOgxRv6unCTW4clQTRS+teafvMxHoqQGhH6Osjxq6zBsguYf0JXAtPVvRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997418; c=relaxed/simple;
	bh=alMbirdT3CCc6D7G4e583oLfyh6D9HJKmtifjlFhTOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ufk6lHy8Rr5inALoU9T/HdPVfB2IbNZjJV1+n8q6bWvZwBKYzelTmJ+1pzimVcMZJIVfnWWN3NbCWwVdv7Baq5fT6jhnHScLXpQ+ubuJbv9kQObf5tHTw67l9Y/X/euLVDRo8jVxUgzwMwNbrUviY+3S//RlyariRAup4rXTydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nWBjnhvg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XJUR014353
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 14:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vEN3DVQPWnQ3YmNmi0dGVFvSE5AeHGCdQkQ8yWp6IEM=; b=nWBjnhvgBAlcyJEd
	8K6sQ67Jt1vV0mUBXuWNZB+AydZGmLwO7+mQn/QTdhJEmnNJuR8YBYCSvkHnhBuZ
	iDiuP60TvAkucuIN4zMJ/SqcgtBVS6qUZxVuk+s3d+YxKKcCov7Hrfjxu3V7F9US
	fBSVit+0cQzXoXHUBmuCosYJUyzi74tuK7wTIY2xFGsJ+CZIbq+4AsTrze4WRt7L
	xI8xGXNZbUYTX9Jzq64Mi8g7k84jVxUVyXdDiM1V9qzyr+Sawp1oiu9dANZ3CrrH
	xYMS9RrjcGUCXSS8jvCMAQ0/dt/CyIlh2VbcpsH2J+xFhdBMUi8NG5GW/fPHTXhc
	oRx9VA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscv807v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 14:50:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4bcb1e32dso4459031cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756997407; x=1757602207;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEN3DVQPWnQ3YmNmi0dGVFvSE5AeHGCdQkQ8yWp6IEM=;
        b=XHi74b4u0UILq6HkLw7g/dAtBe3xALpxVgvJcDJiFj/41YkZiwrFRGlKlN8dSCOUGk
         X4ZGgQrVHLG9iX5UwxkO254g2q77AnS3sMSXl4hj5a/7GkWAuq1Yu3DE2DU2xPHlnh+E
         Wl1zlXB0IaMWUTc/JVUd+LjCLXZEbt/qHJkrhf/NQDYILJp0QdLa97osMOF6RoRQCDNk
         KjKx0gdk3Lc2HtbRpyG1BG8QhVT6qdAm5GyggN0W4xYCOuhlXqYESf0pcp9yxnNvfHtc
         y6pey/cVF8ewtAgddfUsPXoSHNwjHBoKEloLt86cWimGX9RF9tSn94qEKUpykaD2Cs+9
         uyPg==
X-Forwarded-Encrypted: i=1; AJvYcCVqi2DjgUH1qnr9mnId9xPfGtU8MKea/IYbe1nZGc/nFeYGKGreXR6ZWnQnk9ugt597ckngJG7R9PUr/wM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+huoCiTrUs2Z12g2FTZsoWGnfilcFf73AOPebcER4QawTXbM
	oKuF/Rg4tgdSSRXQ1K+fzNQYeDIwr40a0JngCGIWL7II/oZJ5IJcDonYXyH7VgYjXLH+yE9B3OT
	GrfnUl4uYumZBxyd67pA6gXU+DmliB7GTh6RmEcI1qWR1qWT3U60u16RGbSCy2Zmjy68=
X-Gm-Gg: ASbGncsG78TgLOSjfjnUbGQBq3idLDwTYmDReHnXi69Lk0xBmtftNWE1LtZ/7I7wnIU
	Lmoe2+Brug5IFRpzXVRcaE2G2Fg2Y78ydaXmanT5Y08ohuNaVgORGW9zhNtm0UcnTk8AxYI7bem
	wt06cOIHd5lAPYGbpVAoCREC7NGXY/ciNOUVDNiY0lMqINEDNHYa6weFoToS1NKJkVblMbDiTcF
	lOST82R1k/7UAliMPQ95gzt0qypLH37fBBetnekEB9IiSnspXwUZBKiRBDyQYpYSqJ1KFksa21s
	4fvp25F8rU28SNWGnMoS39Cwp6TPu5Rk6iw22CtPxwB7kBnpAGi6p7c93+dJlr07PU2JoFfF3u1
	Bs1VlO01yw0KplqmikdIu8g==
X-Received: by 2002:a05:622a:314:b0:4b2:9c61:4925 with SMTP id d75a77b69052e-4b313f6f611mr170378101cf.11.1756997406613;
        Thu, 04 Sep 2025 07:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6TDGPjmSsCamHewOM2+IFNcFZnByXwpc+6NwBdpVl4gFaguUqKR2wdfL7cEbd1fWAsWZrWw==
X-Received: by 2002:a05:622a:314:b0:4b2:9c61:4925 with SMTP id d75a77b69052e-4b313f6f611mr170377791cf.11.1756997405872;
        Thu, 04 Sep 2025 07:50:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046cd5c274sm375616366b.98.2025.09.04.07.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 07:50:05 -0700 (PDT)
Message-ID: <6501e5b4-9939-4dac-991c-7a2033cfb506@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 16:50:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
To: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXyuiXVtQJ7Wod
 92J9b34HbmAyZDWJYj2u8GDI9ktPoSQw6O7UL/wvO2Es1Zca5Okz0KqAmx366ohCaksmshfg4M0
 ie2YCb1anu5R5QqL0O3kv2vY9tpzvv+69BoVf/QHHEOZOT6rTtTJHCoXzMV4HC3FV9+Ac324v3r
 HpfuhgfrvtK1oKUCRdC08si71VOVSUwisiJI6NSLX4QPihDtxtkxeOPT+TrVq58wUObSpVhs4k2
 0QHFqtw3XKZWWqeaS9UK/w97UNa+8VGDM4np2anNl1PIJpx6salyTPvdfXMIS8Qo0NHBJj4Q/22
 rcoNKCZilvDMecAV7uVqSL5h5NaI9QLOd4p17L28+/sm44VyRnqm3xwZ1S2HBIYPtxDKimwodkh
 PxXGsdej
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b9a727 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=scFqH3SFngUqC7XewS8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: wKxVpDQpIupGjNQ__YtshRFhnpDX_EJm
X-Proofpoint-GUID: wKxVpDQpIupGjNQ__YtshRFhnpDX_EJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

On 9/4/25 4:31 PM, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The CCI clock has voltage requirements, which need to be described
> through an OPP table.
> 
> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
> (which is a value common across all SoCs), since it's not possible to
> reach the required timings with the default 19.2 MHz rate.
> 
> Address both issues by introducing an OPP table and using it to vote
> for the faster rate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index 74fedfdec3ae4e034ec4d946179e963c783b5923..d6192e2a5e3bc4d908cba594d1910a41f3a41e9c 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  
>  #define CCI_HW_VERSION				0x0
> @@ -121,6 +122,7 @@ struct cci_data {
>  	struct i2c_adapter_quirks quirks;
>  	u16 queue_size[NUM_QUEUES];
>  	struct hw_params params[3];
> +	bool fast_mode_plus_supported;
>  };
>  
>  struct cci {
> @@ -466,9 +468,22 @@ static const struct i2c_algorithm cci_algo = {
>  	.functionality = cci_func,
>  };
>  
> +static unsigned long cci_desired_clk_rate(struct cci *cci)
> +{
> +	if (cci->data->fast_mode_plus_supported)
> +		return 37500000ULL;
> +
> +	return 19200000ULL;

Well this is embarrassing

ULL -> UL

Konrad

