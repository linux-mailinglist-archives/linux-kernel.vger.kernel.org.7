Return-Path: <linux-kernel+bounces-752256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8601B17316
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30905840D2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8640E130A54;
	Thu, 31 Jul 2025 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrwX3gXf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F52F24
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971563; cv=none; b=eJak/cy+VP2VSfwJAZwOsb1fsU36d5UYK+Ld49YixWfZeKaXrI/wjH2/W1E1vDRjXtpKQUAcWFoauj3jm4UFiouST9mXxW0ybtZDudvoefsfhTuX7asu8+RGkFDnLcpXbkDi2iPR+rmnwSTvp7yi+1KxC7vZ6f/Nf3ToydFA3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971563; c=relaxed/simple;
	bh=Qw4pFHrzOdxadPlOIEaNsBko7KznwCW6BqAbKVS6rLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fku9A1C3iAz6rkIUsCA4CtbWJcv9YTeDuyRG82VrHy9O1013pnxEVNPMUNc4Y8Cf0FmDfQCBcTTPoE240guKQJPJe9/7aFNoLEvayH4jZcEJ+NaJx0VFYcoPu7pugM+9XVzBrwuIFSMTP1Nym554m6k3uypCH2tmPP1uOCS73GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrwX3gXf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VDf4f8021637
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/SNOf+4G4zyCZV6YFfxz7XUorkDY17ov7WJ2xEOK/BA=; b=KrwX3gXfqJhv1dUm
	l9T/1v1Hdec0nMGMmfNqC3FcNmuZzw+JCUoHXDCzwwjsP7qFa4SFwRLXz87uyP7e
	bDQnRn0YYetO1e3l1uwe5gD4pNePvuA8q5njCclZSn45opp4YpJIvShYH6vXoQgt
	xyDXhrkLLz6YnogY+/lcKAhWMD9UA/0LOFg9PhevZVGlZ1SPaWko2Yqs9st49RiR
	wzWn6tjZM4kS5oURlz30KB1w6t0SFhRE7lLPWdnH2N5opIYfHia/tRo8SD6k5+iQ
	QOq6LM5NKDE5gIhAN4eJ5sW511MNVwaLcGpNN3gXyFLFCepYLAElL6jNEWV/gg9Z
	3KRgNQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrg83f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 14:19:20 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-41b357bd679so404091b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971559; x=1754576359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SNOf+4G4zyCZV6YFfxz7XUorkDY17ov7WJ2xEOK/BA=;
        b=TnxNYZ+mG/nMUxBjZLNLT2Z+99qkRi9IFMCdHjQ0QGXczrTE+B+/SlSGhPZyijJvrf
         yBgguRAEr5XHPI0b0fyKELPr8w9sWe4t0sIdHaMA4j5sAtsDYwcdCkaLfcQDa+nZAYzi
         FuMWB9YEF/rVedP/Z4umGfhe1urUxyuTI42ijN2mgVK0SlXo0iG+zPZWDlTnmSW8CBSS
         P7aWjZ7sDdLwDigj5YgeWeLD5VEXVoJMYxTbGuX/EZWdwKS6sl+6bK5p5XdkJ4E5S8xE
         dxbzJ9OP8cpR+7RwdLRDbHdRqSJcnMzG9n5CiGYEaXcr7XIoKljIntrSzWNjbQukPkSX
         k3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXeJL8wwGdSk0hDoJTifABa/xwY1J8Xhp9QuKcTWiDGQeSmokOW4lVc61iki+XqQZ0KLM403s0p28i8Eac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKs8QiV/V3udmtLmHVKuRAQnAQiQPWwMFUTsT7/5zYQHNpaEvu
	pG9MlRBDYcCSBLJeOeOQc8xyI6o9TMQUj3quwjXaKyuQ5OHzuCFobgvR6zA7FI+SSSJz20Qi8WN
	CZCuETTx+IKQyTTDrvGyH3QOKj6uC1hXjGOEcY6cgooSGVBHOdn5Y1/mGJ4KfHT6a9JI=
X-Gm-Gg: ASbGncv4dXG1MzPDje4TrDswGv0eYUjpBJP8eh5BAio67cR8u8h2gfgpU5vdwoO64To
	ChaqgxQeYECvWfZ4VDWwdOnw9b2+B7yCRBu3QAILVU0+0Hqo7LyGQWL29EUV9egZvjaLM3C9dp5
	LqfHY86+jf3mHJ6OAaywEjGtuqZXFZ5wspq1AzUnex0TKIrUKF6WnicodQpFjW3EOK2T0Tl3HJA
	5dw7VJtZid11J28RdItfZzaDI2gcAmEqPuSGPnVJZoCXSorJjk/EdrlgdqfXcabPMaUILOjMwh9
	MXK9QBSzMtbRUUERANgrwgOJ3IJNe3QgobQyikAuxJK+mx6H5lHk0rLqFzT1w77Qzr2OMn8+6AG
	XDx8CztVOs0sOtg==
X-Received: by 2002:a05:6808:3998:b0:40b:4230:387f with SMTP id 5614622812f47-4319bfee52bmr4796538b6e.32.1753971559322;
        Thu, 31 Jul 2025 07:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhExdeYZh9bGg37wkHjZqMBXQhg07o4VOQ+HBvIRZQY6XYxO2AVM5PEjkgZ/Xq6HBYLOpDRg==
X-Received: by 2002:a05:6808:3998:b0:40b:4230:387f with SMTP id 5614622812f47-4319bfee52bmr4796485b6e.32.1753971558771;
        Thu, 31 Jul 2025 07:19:18 -0700 (PDT)
Received: from [10.148.43.238] (87-95-32-33.bb.dnainternet.fi. [87.95.32.33])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a6ac3sm2618651fa.22.2025.07.31.07.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 07:19:17 -0700 (PDT)
Message-ID: <1f910d65-de34-424d-adf9-7669c22afeaa@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 17:19:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mmc: sdhci-msm: Rectify DLL programming sequence
 for SDCC
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sachin Gupta <quic_sachgupt@quicinc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson
 <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_mapa@quicinc.com,
        quic_nitirawa@quicinc.com, quic_sartgarg@quicinc.com
References: <20241218091057.15625-1-quic_sachgupt@quicinc.com>
 <20241218091057.15625-3-quic_sachgupt@quicinc.com>
 <a2mnkliubpdryxdwsd33kccvnlb4fnyzik5ywxw4xhnimwdwsm@oxe34zogzfot>
 <bb60a145-1e8f-4004-b266-9f26a11440b9@quicinc.com>
 <otfof56qvqxyjaq6onor2f3egrt57h2xazncias72qnn4xjgz5@2aj2pyj5xmyl>
 <a885b32c-c59f-4fb6-b2cb-7955d2d3ae69@quicinc.com>
 <mpuyg4ndd7xvfpwd6oubn7zmzkuienyrig5pmkrd4badlpebvf@h6weyimpcfv2>
 <769268c2-9a7f-4b6e-aabd-a6cf5a744d5b@quicinc.com>
 <d5ykzwuk3wrwycol3wpeontfp5t7h7vfrfcxnmxei3qs74xsp7@ihtzne5wbytf>
 <81323b02-a7be-847a-b973-ca0cdb906558@quicinc.com>
 <p7o2ykmpghx5jqagpkhd2rfqgizcdagn366rltyn4gmbmnmpje@vcygaqcaowkn>
 <82d11cf6-bfed-9b73-c697-c692d1c7e02d@quicinc.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <82d11cf6-bfed-9b73-c697-c692d1c7e02d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA5NyBTYWx0ZWRfX5Inx42J+O+23
 2o1jvu9RVnCCOh3V7LKChBOinp1vP1EHp2MQGtLph6f021thslXgsJBUPqO29Z4T8v8TsD9DZD6
 6rYgLvkiYqoXmFZ1yrkVuizkCh/varYD82uLgjeW4QK+kbcTxKiupd7d64Zo1RzCar1UUEr7mPd
 YWiLdaw+v7zOQxEnEf9uPnlPFWzI24bvI05rB/oC0bA/12E1ddUsPXd8ZTgml4JVuYp4/Bt5UIk
 qpGKw/b4lq4iPwFPb+TnKiZumdRVoD1QQUWAJsvrJLDxfG43AmlDL3D9axj34g2QEpvoxMPhrHY
 swkPV7nrXvnL/NUwmMMYTdOZJndIbOYx/qo/vYH2BRao0fYPQ8vEIKDTiQZ1rCDLTg0HvnZRsWK
 F7wSevJsiiSEYDtToRI+ERZf/qCHwIlOHfNMzETb/5sVRJhNFwh8soPPWHtMWr0n7wLFc2bI
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688b7b68 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=H8T8cKqSsIHj2cBiWKmgXw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=y10v7vMIaVi46rMawBgA:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: gDZlXdy0vol6Oz_Amhlmhx3oGrSPzsvo
X-Proofpoint-ORIG-GUID: gDZlXdy0vol6Oz_Amhlmhx3oGrSPzsvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_02,2025-07-31_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310097

On 31/07/2025 14:46, Ram Prakash Gupta wrote:
> 
> On 7/30/2025 11:26 PM, Dmitry Baryshkov wrote:
>> On Wed, Jul 23, 2025 at 03:43:37PM +0530, Ram Prakash Gupta wrote:
>>> On 1/22/2025 3:20 PM, Dmitry Baryshkov wrote:
>>>> On Wed, Jan 22, 2025 at 02:57:59PM +0530, Sachin Gupta wrote:
>>>>> On 1/7/2025 8:38 PM, Dmitry Baryshkov wrote:
>>>>>> On Tue, Jan 07, 2025 at 11:13:32AM +0530, Sachin Gupta wrote:
>>>>>>> On 12/27/2024 12:23 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Thu, Dec 26, 2024 at 11:22:40AM +0530, Sachin Gupta wrote:
>>>>>>>>> On 12/19/2024 11:24 AM, Dmitry Baryshkov wrote:
>>>>>>>>>> On Wed, Dec 18, 2024 at 02:40:57PM +0530, Sachin Gupta wrote:
>>>>>>>>>>> +
>>>>>>>>>>> +static unsigned int sdhci_msm_get_clk_rate(struct sdhci_host *host, u32 req_clk)
>>>>>>>>>>> +{
>>>>>>>>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>>>>>>>> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>>>>>>>>>>> +	struct clk *core_clk = msm_host->bulk_clks[0].clk;
>>>>>>>>>>> +	unsigned int sup_clk;
>>>>>>>>>>> +
>>>>>>>>>>> +	if (req_clk < sdhci_msm_get_min_clock(host))
>>>>>>>>>>> +		return sdhci_msm_get_min_clock(host);
>>>>>>>>>>> +
>>>>>>>>>>> +	sup_clk = clk_round_rate(core_clk, clk_get_rate(core_clk));
>>>>>>>>>>> +
>>>>>>>>>>> +	if (host->clock != msm_host->clk_rate)
>>>>>>>>>>> +		sup_clk = sup_clk / 2;
>>>>>>>>>>> +
>>>>>>>>>>> +	return sup_clk;
>>>>>>>>>> Why?
>>>>>>>>> Sorry, I did not understand your question. Can you please explain in detail.
>>>>>>>> Please explain the maths. You get the rate from the clock, then you
>>>>>>>> round it, but it is the rate that has just been returned, so there
>>>>>>>> should be no need to round it. And after that there a division by two
>>>>>>>> for some reason. So I've asked for an explanation for that code.
>>>>>>>>
>>>>>>> clk_round_rate is used in case of over clocking issue we can round it to the
>>>>>>> usable frequency.
>>>>>> If it is a frequency _returned_ by the clock driver, why do you need to
>>>>>> round it? It sounds like that freq should be usable anyway.
>>>>>>
>>>>> I agree, rounding will be taken care by clock driver. Will remove in my next
>>>>> patch.
>>>>>
>>>>>>> Divide by 2 is used as for HS400 the tuning happens in
>>>>>>> HS200 mode only so to update the frequency to 192 Mhz.
>>>>>> Again, is it really 192 MHz? Or 19.2 MHz?
>>>>>> Also if it is for HS400, then shouldn't /2 be limited to that mode?
>>>>>>
>>>>> Yes, It is 192 MHz.
>>>> Good, thanks for the confirmation.
>>>>
>>>>> As part of eMMC Init, driver will try to init with the best mode supported
>>>>> by controller and device. In this case it is HS400 mode, But as part of
>>>>> HS400 mode, we perform Tuning in HS200 mode only where we need to configure
>>>>> half of the clock.
>>>> This isn't an answer to the question. Let me rephrase it for you: if the
>>>> /2 is only used for HS400, why should it be attempted in all other
>>>> modes? Please limit the /2 just to HS400.
>>> Hi Dmitry,
>>>
>>> like updated earlier by Sachin, HS400 tuning happens in HS200 mode, so if
>>> we try to use "ios->timing == MMC_TIMING_MMC_HS400" that wont help, as at
>>> this stage timing can be MMC_TIMING_MMC_HS200/MMC_TIMING_MMC_HS400 for
>>> hs200 tuning and hs400 selection. In this case we must divide clk by 2
>>> to get 192MHz and we find this as host->clock wont be equal to
>>> msm_host->clk_rate.
>> What are host->clock and msm_host->clk_rate at this point?
>> What is the host->flags value? See sdhci_msm_hc_select_mode().
> 
> There are 2 paths which are traced to this function when card initializes
> in HS400 mode, please consider below call stack in 2 paths
> 
> sdhci_msm_configure_dll
> sdhci_msm_dll_config
> sdhci_msm_execute_tuning
> mmc_execute_tuning
> mmc_init_card
> _mmc_resume
> mmc_runtime_resume
> 
> with values of host->clock as 200000000 & msm_host-clk_rate as 400000000

Please check the rates explicitly in the code rather than just checking 
that they are not equal.

> and host->flags as 0x90c6.
> 
> and
> 
> sdhci_msm_configure_dll
> sdhci_msm_dll_config
> sdhci_msm_set_uhs_signaling
> sdhci_set_ios
> mmc_set_clock
> mmc_set_bus_speed
> mmc_select_hs400
> mmc_init_card
> _mmc_resume
> mmc_runtime_resume
> 
> with values of host->clock as 200000000 & msm_host-clk_rate as 400000000
> and host->flags as 0x90c6 which are same as 1st.
> 
> Now if card is initialized in HS200 mode only below is the call stack
> 
> sdhci_msm_configure_dll
> sdhci_msm_dll_config
> sdhci_msm_execute_tuning
> mmc_execute_tuning
> mmc_init_card
> _mmc_resume
> mmc_runtime_resume
> 
> with values of host->clock as 200000000 & msm_host-clk_rate as 200000000
> and host->flags as 0x90c6.
> 
> now if you see the host->flags value, its same across the modes, and if
> I am getting it right from the pointed out function
> sdhci_msm_hc_select_mode(), your suggestion seems to be using the check
> host->flags & SDHCI_HS400_TUNING which is bit[13], but in above dumped
> host->flags SDHCI_HS400_TUNING bit is not set where we are using the /2.
> 
> and the reason is, this bit is getting cleared in sdhci_msm_execute_tuning()
> before sdhci_msm_dll_config() call.
> 
> so this /2, is eventually called only for HS400 mode.
> 
> Thanks,
> Ram
> 
>>
>>> Now if we go for only HS200 mode supported card, there
>>> the supported clock value would be 192Mhz itself and we need to pass
>>> clk freq as 192MHz itself, hence division by 2 wont be needed, that is
>>> achieved there as host->clock would be equal to msm_host->clk_rate. Hence
>>> no other check is needed here.
>> Please think about the cause, not about the symptom. Clocks being
>> unequal is a result of some other checks being performed by the driver.
>> Please use those checks too.
>>
>>> sorry for it took time to update as I was gathering all this data.
>> 6 months? Well, that's a nice time to "gather all this data".
> 
> Took it up from sachin last month but still its a long gap.
> Thanks for helping revive.
> 
>>
>>> since Sachin have already pushed patchset #3, and if this explanation
>>> helps, let me know if we can continue on patchset #3.
>>>
>>> Thanks,
>>> Ram
>>>


-- 
With best wishes
Dmitry

