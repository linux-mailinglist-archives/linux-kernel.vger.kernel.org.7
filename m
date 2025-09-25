Return-Path: <linux-kernel+bounces-831960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A9B9E039
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58FA1B26B92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F1A271446;
	Thu, 25 Sep 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbYmaUXC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F643C01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788260; cv=none; b=iIYpi733gB2gFY/ZbAf2gk4/VjYV5FaLePo01b0FL8Hr5pSXqsdU25O0djEtcJ7Kg0FSnExpDMHV0xpzhXOtFmCkX2jxSr6AB3AeVCdS6t5Ou2p3Nw9wcu1spmdeIAcwcEklSoT91hPVNRNEU7TV7quPW/85k4I0NlolCBYnXso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788260; c=relaxed/simple;
	bh=ju12c3zjPCtwHhJY5tJSfmtZsr1XQWEIbv3qoFgD6pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct72wE03lrWPE6I6oZzXRKygQ3c9Xh55vfYdBmr06BUERAixwKwnzOGFglP4GGmiKCX9CbdYl/Ia1OqufILF3MUXOvxf6Vp7urMP1tOdLz1H9vOQAWq+VbgJYUZ6ql82SSdnsx6QA74idZ86Y9eXnEbPE3FAcB8JH1FtQ8899L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kbYmaUXC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0lAex020897
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fLKQEQMFjt1N2xpVRrqiWeNYSDottJz1+F03bmyEkI=; b=kbYmaUXCQi8bHp+K
	wd35uNqqFInk6kWa3kLXOQS1zizK9CcAdrSjRGpv6Zj4Tb8pG/0YReliECEbIF27
	UAfCEt09lYfdLOEHgK57vXFMnfuKNEC+C+OKXyLPQQ0onC92EJcZd66pXnxnMyaw
	m+1KGpg0zJ9I2fQ/rorZuwvZ0TXAGD5fxtoXVj1ym+zijcceZOmZhvKN5skmp+QG
	tsHiE+ucLlgEgivDGs2VehN1tWJ03Qm4A9ESsgV5PK6feim0HEpiocZClnV/xuWN
	ewQMA8xHVJ4+KtqN1qM0oL/0bvglsC62S2v4OrRlVDyRs+zXIAZ6aXi2rVDonMkA
	S2u6/Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe0jhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:17:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eb2b284e4so1105523a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788253; x=1759393053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fLKQEQMFjt1N2xpVRrqiWeNYSDottJz1+F03bmyEkI=;
        b=Lvvm/YjDIb+12c62zah6P4P8f4WVzQTqDDX/7uw539Nx0PS9BlgAavMqrmCMTyfV7W
         ikk4DKfJiuM15Bm/pC9RXa2tkRfzGulNAQHwi+Qw3+gW0wiq99xiQ9fiYEbW1ymuQDfk
         rU8W8PNSkqcSKLLb8T3iEAfUPYUGFhqtL0NxpZwLNIrOG//Rw+xGWnX+Z1fjgvhcJxW1
         NP6xlYTLD/dVsGkWsnmwwwWVUQQQ0dobRIkP3QZtT08AF1MnMsYZOSygL7KIaVKelzGd
         9uayUHRn1MbNLOIhLROrZCTVPXQB7yOAEH6C92PufHh4JI073szXFcdp06WMmugn884p
         DSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGbZv8Cmgx7fdSSXd8bFhQjxEJJ+irPgUvGdxtBLWyfZXVq2flTkaDR8I2V8pl2ItyYN2iltgzxjbXOAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV81zI/d8tThs4Dq0/9aw7/yWfB7ex+DKNqvDVUi/UFPPnxADb
	TD7S5q9ATDLd+TDFVgjYKFbldaOjI6bQ/Oq14n81It0C5hAcjOo5ORbN4eE9weuCnYNoospCvmM
	EEEsUTDbdy8hDcDGkNqH5FwsLElx8/klCiyVdWnV6Y4FONw7Ni/f8dGjY6VQHoZKCP9U=
X-Gm-Gg: ASbGnctgOnv533LNOMFpZ1Z1TRMIfpTyoS+PfcArtM2Xfb/kCm3j4gyccsF2SuW+ukh
	knlHBeyumt6oPKr0xGwwVvN5myFkIg9dhe7ysZO4zwtUO9vE/TE2b7SKr5hf99YAE2wTsB3m1EY
	jW00StiN6J1Mc1nV1pHXVprrsj59LeDNhuwYKizh4knm6iyddpwv2JqM+2mUtJ4qi4ewkwY/kCr
	MFkNmdUFqA/Wxe5cedkLj+c7FuWe94T7m5IAQImwHQufcJW6nFmaVk+/L8cchSNXKoshFmzD++v
	XrpbiC8kE+51gXBOZOTJC8YiQzJBljXzrLEpHSApq7JBdUjyMwUWU2TgZXoowqEyQRtlle+MamE
	=
X-Received: by 2002:a17:90b:4aca:b0:32e:36f4:6fdc with SMTP id 98e67ed59e1d1-3342a22bf5amr2775637a91.4.1758788253382;
        Thu, 25 Sep 2025 01:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3TdWftX0GIOeoRo8a4WJF4ISLW7hj+j1rgOCz2Hj1YzXysTp2Kbgg5cqycEtg6gU4pGGGlA==
X-Received: by 2002:a17:90b:4aca:b0:32e:36f4:6fdc with SMTP id 98e67ed59e1d1-3342a22bf5amr2775587a91.4.1758788252754;
        Thu, 25 Sep 2025 01:17:32 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.248.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be45620sm4866509a91.29.2025.09.25.01.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:17:32 -0700 (PDT)
Message-ID: <4c6f1216-9047-22ae-837d-992a47189018@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:47:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] media: iris: Add platform data for kaanapali
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-8-e323c0b3c0cd@oss.qualcomm.com>
 <23b56m4xjblk27rgpuu5pn5zecv25laoo2yijk7r7ns4kkvfh5@4s2ijgt4qq22>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <23b56m4xjblk27rgpuu5pn5zecv25laoo2yijk7r7ns4kkvfh5@4s2ijgt4qq22>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tdmEvOoIzmrAyAyW0NDfiTb-o4HTXiQO
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d4fa9e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=AkZwv1uTgJSVxlfcUQlFCg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=rsDqbdP52k_1ZPLE-y0A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: tdmEvOoIzmrAyAyW0NDfiTb-o4HTXiQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfXyzbKWSyGBGX7
 RvNqp+u4T+p+DpUeMUy0u6W/qFrWElqcQH4IsT6wxXrYSfk4FzWFQdbZQj4BWzYxqtqwnVomYZC
 GH/+zTEe0k+yLaDeh4dsKiioFtNU8HyBzC2vp3fpIjjN4KjEzoRXQdKPEmAyUviBLBi++moHp/Y
 +IYcLVBEX8EuE9n1oyHuvvJ6OorR2Znq1VFZPlxcyHO7EGlX4O0fo8J5T9JTIF8HjwSjjDzfFEa
 LH0xkpc2st0H6GsWIyHTN/APiEcEGry7wpEgayErVbb9+TNLumLiVHDH3p9dcZ/ijB6xszBDNfH
 RshbSE/WldrITbPcSd2PeUfU4UyZWqZJjn0ziBLH+nNEsyCt5q8JLn6pjGRxfu/Ga2SpQmb6D3+
 N6aEELfw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020


On 9/25/2025 8:14 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 04:44:46AM +0530, Vikash Garodia wrote:
>> Add support for the kaanapali platform by re-using the SM8550
>> definitions and using the vpu4 ops.
>> Move the configurations that differs in a per-SoC platform
>> header, that will contain SoC specific data.
>>
>> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>> ---
>>  .../platform/qcom/iris/iris_platform_common.h      |  1 +
>>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 86 ++++++++++++++++++++++
>>  .../platform/qcom/iris/iris_platform_kaanapali.h   | 63 ++++++++++++++++
>>  drivers/media/platform/qcom/iris/iris_probe.c      |  4 +
>>  4 files changed, 154 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> index d6d4a9fdfc189797f903dfeb56d931741b405ee2..465943db0c6671e9b564b40e31ce6ba2d645a84c 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
>> @@ -46,6 +46,7 @@ extern struct iris_platform_data sm8250_data;
>>  extern struct iris_platform_data sm8550_data;
>>  extern struct iris_platform_data sm8650_data;
>>  extern struct iris_platform_data sm8750_data;
>> +extern struct iris_platform_data kaanapali_data;
> 
> Please keep it sorted

ACK. Started the development as sm8850 hence was kept at the end, and was missed
when the name was changed to kaanapali.

> 
>>  
>>  enum platform_clk_type {
>>  	IRIS_AXI_CLK, /* AXI0 in case of platforms with multiple AXI clocks */
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> index 00c6b9021b98aac80612b1bb9734c8dac8146bd9..142b7d84ee00a9b65420158ac1f168515b56f4a3 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> @@ -15,6 +15,7 @@
>>  #include "iris_platform_qcs8300.h"
>>  #include "iris_platform_sm8650.h"
>>  #include "iris_platform_sm8750.h"
>> +#include "iris_platform_kaanapali.h"
> 
> And this

ACK

> 
>>  
>>  #define VIDEO_ARCH_LX 1
>>  #define BITRATE_MAX				245000000
>> @@ -1095,3 +1096,88 @@ struct iris_platform_data qcs8300_data = {
>>  	.enc_op_int_buf_tbl = sm8550_enc_op_int_buf_tbl,
>>  	.enc_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_enc_op_int_buf_tbl),
>>  };
>> +
>> +struct iris_platform_data kaanapali_data = {
> 
> Hopefully can also be sorted.

Yes, this can be as well.

> 
>> +	.get_instance = iris_hfi_gen2_get_instance,
>> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
>> index ad82a62f8b923d818ffe77c131d7eb6da8c34002..9a0db65dbdb2eedf3974bcb8a2327e664b556ccd 100644
>> --- a/drivers/media/platform/qcom/iris/iris_probe.c
>> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
>> @@ -370,6 +370,10 @@ static const struct of_device_id iris_dt_match[] = {
>>  		.compatible = "qcom,sm8750-iris",
>>  		.data = &sm8750_data,
>>  	},
>> +	{
>> +		.compatible = "qcom,kaanapali-iris",
>> +		.data = &kaanapali_data,
>> +	},
> 
> And this one.

ACK.

Regards,
Vikash

