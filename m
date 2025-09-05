Return-Path: <linux-kernel+bounces-802194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ECFB44EAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CA61C266A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8FB2D837E;
	Fri,  5 Sep 2025 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1UCHN8W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CE2D4801
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757055836; cv=none; b=DqSp9GY5IcjM5BJvMHn4i9UJW9hzWZ7YbwpsGG3uqsPeZpF7XI7Jb4ptijxjHJiQ5EMZAMLoD0x2nDpu1zPBaAAWJ9P3cM35TIIkXzLVQI7qkXmwfN75YkmW8zxF2A+5wfKuhDEHkSekCJF084RVJI6tPy3++QLiwyqhP4n0Gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757055836; c=relaxed/simple;
	bh=VM0nKVBbJC3EXcL+2r1nh5KaJBUzAyVK/5lsmjwQ2TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7sUI+8VZNqC1Ywj8rLje9KtRwOKtvGnIvHQyOHRhPEl0bzYOm1ze5rAxzMFsQii+zib66G/Fq3Ush6mUMHhPABdI/W5WJBmBKdQrjWZNjQkmciO6BKskhLVqhKFehqn9vhzom4Qt3xAbNjAC5kiRF2o6nlldiOFbnGT/6rsIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1UCHN8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5856hnqh022174
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 07:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uh0zHPqensMvXDsKJ/9Mhe+pmsC/EijM0tWsWvi8kEQ=; b=O1UCHN8WC97vjYZZ
	HQDZWIFmZIQ4qKqGMXT5X6HeLjpiPQPpx5JctW96J4S4dEenQjD/UXfLN6gaBOAO
	8gkxhFeptvAr0AWXVActyILCKrNApNne09l4WZWh7n1hbWoHLRuSfaV54jvmHNjS
	nrp7MeNseUepje+n/GuywGdDlYSahWdn4CC8EAkFdBtJIBMHe98Po9JPS2NdQjLY
	9oxW+WGXgIJNOAPelHTFWUWxUoNNANnMmYxvyH+oJHGzvjE5O4JD+dx7/YNxtXIS
	cFCWyGEKilV4X3TAArof6gNI5lhNzYgVlPkuXXMkJmqJrTKVeflcSkaj/b87+fX2
	Hvkk8Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk9a1th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:03:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b31bea5896so21386051cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757055833; x=1757660633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh0zHPqensMvXDsKJ/9Mhe+pmsC/EijM0tWsWvi8kEQ=;
        b=OI+8usZi00z8E7ZzwTfPDOqzEwiTuPWMl6sCFjUOAMgDezvC6cr6FTzcY3bbxWIMK4
         Xv2zZfGc7G5JR37i1EOUhd5IOJ4Wagr61pGOzs6+Xh2R5KbTNt1WwcHOdw5qXVZuRiA7
         DemE2vG1vwM706Ee7ZHEbPA0O3CvAD2bgzzQn/wFTuJ5xMZPug43lZ2j8Q1VXb0RC/Xj
         bLTuq2v9uTrddyyn5GC8P84N52TMPMFkpS23REaINgJfQ07s09bQK+EBacLetgifUMM7
         EggVER8RSnkHlOud0Vypd6CNuziPMnCCRH3I5ftHWWiCIYUz7JIziXddyS34Krd7EMUb
         sw6w==
X-Forwarded-Encrypted: i=1; AJvYcCXoLkHbdGNAvwbqbf+dQBRhT650sOqM9zWFv8qMRgfy3klnFVYTF6322gTXKiJat9qMVbeggDO97jqdOJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywes4Y70rrBe2Jr1rfkVzybaOICIceCly4pKGVAEGznnuhucHvv
	/CI2CJRTvhIRKVVR7Mt1zyIKBQo+nzTcCUOBBhIlAbT4pkmjQCNQZ8OlHOYTzSmUUsFIA/BHz49
	s4SOOjVZOXvAVLfUFvALLqeLsZetXGG4wqfbIeNlsWVCUGoj+dGTykB9ubGC4RWx1KNk=
X-Gm-Gg: ASbGncuRmv2mgwjy6gRmB9imx2uHhI1ss2wysLncFUGv3FOQDY4tLbUkwk4PlFsBuPZ
	fTYDdOlp86p5iOQO2LHLa3bq5uWRyjIzyeogKcVVCH4K2jvsH4zWEtTcAhaEC3DEigZ2w+dRjeB
	5rx+80rxKnvCgs8hav8UiKnCforF6ai60AImD9nrpdg3mRym6h7OH4iYhpDOmnuneFaBpEexkAW
	gD7DImoUzigHw2AlS07tH86fUrcZCVA5ZzSPwTSSn+iW313o7JJak7bpOo6IUPEZIkxEfPPOmRn
	SHFTICgowjRlAGybTiZXzcvuad0OV6QGAfVD08G9u+lRozYGHbouC5fSL+dtOt6uiyw=
X-Received: by 2002:a05:622a:8ca:b0:4b3:4fdb:f2a4 with SMTP id d75a77b69052e-4b34feb3e21mr151706411cf.73.1757055831879;
        Fri, 05 Sep 2025 00:03:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG2WGOBevUmbvF6L6SlA1g/1cS0fHSL6yPVxAnOVTWc4dOXAnkfXOBDdkJYebg/JKqxCflAg==
X-Received: by 2002:a05:622a:8ca:b0:4b3:4fdb:f2a4 with SMTP id d75a77b69052e-4b34feb3e21mr151706061cf.73.1757055831200;
        Fri, 05 Sep 2025 00:03:51 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b8f2d3c88sm183965295e9.19.2025.09.05.00.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 00:03:50 -0700 (PDT)
Message-ID: <f6a631bb-d17d-4eba-adfc-4db08540f5a0@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 08:03:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ASoC: codecs: wcd: add common helper for wcd
 codecs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org
References: <20250822104927.2621866-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822104927.2621866-3-srinivas.kandagatla@oss.qualcomm.com>
 <kmm4e5bg7uehmlsgrfhzo4agr6ga6d5gxtpxq5sg4t3wql5p6m@llwyz4kzsj7y>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <kmm4e5bg7uehmlsgrfhzo4agr6ga6d5gxtpxq5sg4t3wql5p6m@llwyz4kzsj7y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QZG0NI7K-N3wTH98L9wOhvn6hipsj20M
X-Proofpoint-ORIG-GUID: QZG0NI7K-N3wTH98L9wOhvn6hipsj20M
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68ba8b5a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Jf94gfbLdGj3VxC-8ggA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX7HuicEVJDENg
 vHOUZYpImy/62i4Aj8eID1WeOTjbIHQgaNy757BsvCbL/BS9hlld60nVkrBx1dQdHJmS6SHY4vD
 CDd+94lZS2lR79cKHHTcmyKGlSWInirOGODZdxD7yE7Dpx71K4MYfIuSMar+igyMHdqTV1G2ex2
 H8/ci4cjX1Q9aBRN/oiyl0iQGBwPBlEfXPb+U4TaAe00dUJCUjryCxIjU0F7xFCsvuL3H+bayYL
 5opg/CtLKBxo+7FV3JanFFBzGFHX9ghn3r7KRPWAC9ypoeiBa3qJ2mHF1FUj3XRE14JqXp1FW7C
 HJRCBe7yjAR/VwjF2UaqcUQqDDNA9djL2L9vFOOnFwttpmANL0c8OsV2pQomzQ/S8byhZIH34M4
 G2HRjtkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Sorry for some reason I did not notice this email!.

On 8/22/25 12:18 PM, Dmitry Baryshkov wrote:
>> + */
>> +
>> +#ifndef __WCD_COMMON_H__
>> +#define __WCD_COMMON_H___
>> +
>> +#define WCD_MIN_MICBIAS_MV	1000
>> +#define WCD_DEF_MICBIAS_MV	1800
>> +#define WCD_MAX_MICBIAS_MV	2850
> These do not belong to a public header.


All the wcd codecs have same MICBIAS circuitry, this is the internal
micbias circuit we are talking about here.

Actual micbias value comes from device tree, but these are min/max
ranges that are supported by all WCD codecs.

Why do you think it should not be part of common header?

--srini
> 
>> +#define WCD_MAX_MICBIAS		4
>> +
>> +struct wcd_common {
>> +	struct device *dev;
>> +	int max_bias;
>> +	u32 micb_mv[WCD_MAX_MICBIAS];
>> +	u32 micb_vout[WCD_MAX_MICBIAS];
>> +};
>> +
>> +int wcd_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv);
>> +int wcd_dt_parse_micbias_info(struct wcd_common *common);
>> +
>> +#endif /* __WCD_COMMON_H___  */


