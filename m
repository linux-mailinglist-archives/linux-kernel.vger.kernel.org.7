Return-Path: <linux-kernel+bounces-734665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B074EB08488
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4623AB88E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6484200112;
	Thu, 17 Jul 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZLV2ZRl3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D91FE45A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732292; cv=none; b=aAzeDSm2/P4YgvRLxe9au+f4UPTSShddaHQyBen7jC+Dz3lruTQCNZ3TbudK4+VTt4anNMSPsxEQ+XxZDqyPvwvc80kEda++ooWL0z2LT9ohTt+YzOZBrBke1abrBgGM+mP/uQGnXQi+wfoYEsa95K0bD1nKFkUjWJSgw3NRaUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732292; c=relaxed/simple;
	bh=/eI8FTCpncUNzSRdBop7/8qiRihLxNb69wVgieMvvy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmAJso3B3EXKwGoUMQ2g2y8ZzHWhQm11JlEwlK2S/6I1jCvnsr6R7fN5WSHHjLWpVI6gGZLtdTnVJbCagJQD98jI9fEWNhKg6P761QS4L5GPGG4vPAeotbQdqOdE3zObGQICKQYBcL49fzK0vZ9HqStxUcV8dXx8ky1qqtidruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZLV2ZRl3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H40Ju4028099
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ectNLSsr0geVGNTSYPuw96/Hkm3S5cAjwHokocTaqA8=; b=ZLV2ZRl3Rg7wgDRP
	QHagA1gAAS0/iFZO9Pv79mBwHopjmEYU0EToYHuzp8p1PzSAidNDCf+daY/1orXP
	JeuHLrQ2nzP7Rpax4gt0jUBmdfykWeQhIqslBIaugLjmfkJcKgCMoo6r1NJhtw5z
	nTUm90E1rgRpXDRchNCkFkmSDv4kXGiYAWDas9VRLAS4OGFe5AI7G7/aZk1V9i6I
	TyixfZRUj/uJgX8ocsO2BXwG6sfFQT4pe4kQNOFclCgkwQVSQUJ4YMH4Yh/EgPlL
	MscWNr3p1StnFBB6AD2afK2e1e/JpqFQaVaWYAnV4aeGoFq4m/ly29TS5/zjvZqY
	JClcIA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5xqdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:04:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7492da755a1so584095b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732288; x=1753337088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ectNLSsr0geVGNTSYPuw96/Hkm3S5cAjwHokocTaqA8=;
        b=C8iM+cBA1hy5JPWOpokJ/h2U/Z3KaChvAivwEcyiJ6HNfV5GyGmawZddK1H9CT6i4T
         JuzNSH3+dZeI2+4Xq1F8ZiZh0cg+f1xvPr+1VadG8wzoCLXd+8fNxCIl0bufaCJZPJhS
         OGTZMjE0Ylle0HPOuQHknjcaVR7CbktrQtYk5JS75RRbsO9jdoD8XR52WT62N5mTouvn
         ormu4Z5sl3cnnzeV58UpEs/8Ut23KfHvqQP+9aMHEc9N8CDztLesReSuHthPfC19O0Qt
         kb9hapNKLdISJljsXia3eX8dEeqOmD2922NffHlV3hUhN+du7txmHs3K9dNfiMbnbAt9
         6UvA==
X-Forwarded-Encrypted: i=1; AJvYcCVA+t1ZzpZryBylxbZmD52fP6sN/cphZopKVypUGK/YiAYh5c75nWmRF3VhH339AYuBifa++Pvh/yVhbm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcklSsV+PiPgiMR5Ks1ntCDhE+nbDSGYqn3C6iuszLxTQ2Rn2
	VpjA3k/Y/6wrKHnVidCfiXnNN5IAKwoChXLRuue38WHTB9mymykQTQ1NurfErJibd4qt3K3uBtW
	pIkS0cvuqVMFCowijw75/1hPumBHXesXIQnUoEvUoZV7JvtVRwB2G8iZTLxLS7Crc04Q=
X-Gm-Gg: ASbGncsLheQpDQoGxui8mT7DXjAHZWteN7PiiYtMnmcEjCMsO7vKtfNlI+NNGlBIBJT
	ITnGd91EbltX3KuxlyW1ADCqWwE3MYgpMFhaCcOgc1OWtQfBSrOgXiXriZQJZmLe8mn8Q/I75JV
	n2kmIdbf7tvWlPtedQHX4ag0nJYUEr4n/V29oftE30J0KQxW3YS4gAfZtWgK5GsRbhkCk18PrLS
	0/faRwlS4pTv8Pe+E9LNhmx6Vyw2+v6IAl4tD8G47FH4YUJ9XZhFX602dghDpKBwMYwPXEJ4Gp8
	KSDmyyWOTx5XLpPPFc8+/+jjZVBVYf5iz76maTbw8MR7SgXCjIqiGgX4yhnY
X-Received: by 2002:a05:6a00:1945:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-75722869626mr7421091b3a.7.1752732288337;
        Wed, 16 Jul 2025 23:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyCadxiKqAnRGrg3kJEgXbKAZ6HS0QuHqlNsqoAGcHtBpNmUUMpDgDD0/MOYYxsR7Y2b2Q5w==
X-Received: by 2002:a05:6a00:1945:b0:736:5f75:4a3b with SMTP id d2e1a72fcca58-75722869626mr7421020b3a.7.1752732287518;
        Wed, 16 Jul 2025 23:04:47 -0700 (PDT)
Received: from [10.216.10.110] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd73c3sm14960668b3a.7.2025.07.16.23.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 23:04:47 -0700 (PDT)
Message-ID: <617d207c-995a-4375-bd5d-2e1e5c459bba@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 11:34:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 4/5] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzysztof.kozlowski@linaro.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
        lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, daniel.lezcano@linaro.org, sboyd@kernel.org,
        amitk@kernel.org, thara.gopinath@gmail.com, lee@kernel.org,
        rafael@kernel.org, subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com, rui.zhang@intel.com, lukasz.luba@arm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
 <20250509110959.3384306-5-jishnu.prakash@oss.qualcomm.com>
 <20250511140418.33171ca3@jic23-huawei>
 <ff19780e-5bbd-4074-9db3-b4f27922a093@oss.qualcomm.com>
 <20250628173112.63d9334e@jic23-huawei>
 <5b55acbf-065d-4383-a816-82561bf91273@oss.qualcomm.com>
 <20250713143149.60763b52@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20250713143149.60763b52@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=68789281 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=rjtObUXQbTieMrY6Fj4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 6v7vYGYC1Bf52Doqt99ROke8RSU7HFAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA1MCBTYWx0ZWRfX+8si6YBGfp2+
 ShxBCHqp5XwQlszUi7baxLd5tQtlDmknB4ZUV2/hI0KUirp1fhVw1pV0zT7a/SCWaytW6+7yEhM
 4Gy/cZDXsrsyFbp/gck4c9v2UwRJvQAWSGzTB0EqhMdLKTk/vTbYeCMmSs1plLN9DhMXEu/td65
 ZI+UfbFjBiJZR0sigMV6biau5zkD7HtfepdwzTafUYRj/NCKPgsQackrpHdg2OQnlBEGzSb98vj
 KDnMMaZULvIbT0TT2X+HfFrwRzzCfepGB1bJKqS4PcZpuA4+1Pil60Ee3e8mI591NjyDPWDpfNt
 6/Wy5fcTPpvc/LvkSvmtHBiV1/yvLN3WSl8SmE1+oUsgLaDuxV36wkvAao4RUfwJ5W0iipns2K7
 4DGQKdSbPk7i9G+ugK+QE5pxgPo2swWGV16vXXnBSAX2Q5QFoaSurGPwqZN8uqXWXiB7VnLN
X-Proofpoint-ORIG-GUID: 6v7vYGYC1Bf52Doqt99ROke8RSU7HFAc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 mlxlogscore=766 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170050

Hi Jonathan,

On 7/13/2025 7:01 PM, Jonathan Cameron wrote:
> On Thu, 10 Jul 2025 12:14:13 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 6/28/2025 10:01 PM, Jonathan Cameron wrote:
>>>
>>>   
>>>>>> +	.hw_settle_1 = (unsigned int [VADC_HW_SETTLE_SAMPLES_MAX])
>>>>>> +				{ 15, 100, 200, 300, 400, 500, 600, 700,
>>>>>> +				  1000, 2000, 4000, 8000, 16000, 32000,
>>>>>> +				  64000, 128000 },    
>>>>> Andy often points this out, but I'll do it this time. Fixed numbers (typically power of 2)
>>>>> elements per line make it much easier to see which element is which in these arrays.
>>>>> Reduce the indent a little to allow that here.    
>>
>> ...
>>
>>>>>
>>>>> It was never worth bothering with release until we had devm managed form but
>>>>> now we do the code complexity cost is low enough to make it reasonable.
>>>>>     
>>>>>> +	indio_dev->name = pdev->name;    
>>>>>
>>>>> Just to check.  Does that end up as a part number or similar?    
>>>>
>>>> I printed this name and it appeared like this:
>>>>
>>>> indio_dev->name: c426000.spmi:pmic@0:adc@9000
>>>>
>>>> It only gets the DT node names, which are generic, there are 
>>>> no part numbers in this name.  
>>> I thought it might be something along those lines.
>>>
>>> indio_dev->name should be the part number so hard code it rather than
>>> getting it from the pdev->name
>>>   
>>
>> Actually there would be more than one PMIC which can function as the master PMIC
>> for Gen3 ADC functionality, so I don't think I can simply hard code a name here
>> based on PMK8550, if we want to keep the part number correct.
>>
>> Since we can't get the part number directly from the DT node names, we
>> could try one of the following ways to add it:
>>
>> 1. Add a devicetree property for the part number
>>    This would be simple, but I'm not sure if this is the best way, 
>>    if the below method looks good.
> Nope as if you need a part number, that's should be via the compatible.
>>
>> 2. Add a string in the compatible property for the part number.
>>    This means updating the compatible from "qcom,spmi-adc5-gen3"
>>    to something like this for PMK8550:
>>
>>    compatible = "qcom,pmk8550-adc5-gen3", "qcom,spmi-adc5-gen3";
>>
>>    and then extracting the part number from the first string.
> 
> Do it via a compatible lookup + data in relevant tables rather
> than messing with string break up.  Sometimes we'll get the
> part number of the fallback compatible but I don't really care.
> However, see below - I think spmi-adc5-gen3 is effectively the
> part number for the IP. It just happens to be inside a PMIC
> that has another name.
> 
>>
>> Please let me know which method you would prefer.
>>
>> In addition, does the below string look fine, to assign to
>> indio_dev->name for PMK8550?
>>
>> pmk8550_adc
> 
> That's ok, though given it's an ADC anyway, pmk8550 should be sufficient
> for this IIO specific name.
> If it makes no practical difference what PMIC it is for this driver
> then simply use spmi-adc5-gem3 or something along those lines.
> So kind of a generic part number for the IP rather than specifics of
> which PMIC it is implemented in.
> 

Thanks for your confirmation. Your above statement is true here, the
exact PMIC used here does not make any practical difference for the driver's
functionality, so I'll use the generic part name "spmi-adc5-gen3" for this IP.

Thanks,
Jishnu

> Jonathan
> 
> 


