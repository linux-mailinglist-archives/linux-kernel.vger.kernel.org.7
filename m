Return-Path: <linux-kernel+bounces-806329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A9B4951F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6D16679E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3630DD26;
	Mon,  8 Sep 2025 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ljPZ4wD9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5F4205ABA
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757348533; cv=none; b=NsQWxSafKSrOSZgejq27StNfObf+mkd+3Jl/HMd1TvtbKxzgFP7WdV/OC4b64gtRVFnNJ2iBSlvK2Z4OPx9bkWd3PH6Xfhzkg790M/SQs0QZjZKAoniy41/nRLWbdPKDNgljabjTkGh2I4WkNGKD6Jeb+fwn0BwCNDg7jwwrnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757348533; c=relaxed/simple;
	bh=o5SLnijNzSdwRulDkEezTSBK40PVHGU3+ZkYzGRYe3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SS2Dpi/36Kb9e3N1Xry8vdAY6u7GjiOYWEXD4+9enLpbxgGzUYgF1Xg8NLt5WZSXFez4d5kJGyUJF4f/yCfTfBIa5lUv1ce7kFEzykfiguKkwxgipON1EjawmJD+1vM6JAUxl9vI9Wd7rjXo+aYgTKN+LroiWrS2K0UIo/oeA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ljPZ4wD9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888xTYE025960
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+rdrikp7bBevt5yb6lYYZbNkqBe9kBUGdXeaOgnPNc=; b=ljPZ4wD9UTrVeaVC
	WMB9FhYLf1+jhrLCFecGC8ohUOenUwWLiNNTyZOJFkJgzsUCyCQHnygaWCE3OXAJ
	y6+kqB3S9EU9hbj4yDTuIcuPZYdfblyPeMSd6gSCIjU57ZwR37+oXeFiIN6vDSZr
	WnA7YdfHncMFewSH+f0OU6yRow5AQoowIdm8wZBRaB6WagkFMUP2kxS2zpv2aM0Q
	krNbm5Jud8TduKECJZkufnR6U6sEdTToV83O5YgFnOzrMKE/TADUqcs6xPIwR5NQ
	bnWty3Syj4y6x1QGs/Cf6jh9ET/wvAOwsewh+7TtDYGyVYOh3n1tzaDnEYH3wMvo
	7eSE8g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kw3hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:22:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f76fe6f6so7358141cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757348530; x=1757953330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+rdrikp7bBevt5yb6lYYZbNkqBe9kBUGdXeaOgnPNc=;
        b=L0lj9JJZUapbRCKyD526jSO9vRlj2pH1lkkJQ3GHHoe/rHxtW00zB68Q1p+qSpse2d
         V0pQ8JeMCZ7pETOJ0xLCXGWcrnfIr2HpRwojYot1l8gOYZHKwmWQU3DRbCppnrKzGtGq
         bz5W2kPLf/6m95tqqCLNLAKdTMQJ9oem6v6XyK1vMHqmFP3uYFhRjGadxyYSlgF7X0iR
         0Emm0NWCuW+ssZ/dxOjztlQYjJsnceXz/W3lIRr6/gq7XWzoI0TJcpLPTvnEzun199NP
         fJwwdOfB6poz/Vpn5KhTi4px7EA9GdGVQOyOfDGR5AM6GCs54xkJixlczbeIdd6YZfhH
         MgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIHRJOQZpbAXnZbWqMg10ldhMERRx2yKqce9MY0z/X7D14Bd7Y/2YUUdUtmRgkr2H1Z6ctWHv5r2nwt04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvX0wIzctJmJxZ2ymH+R7kbGO8UnHTPTDRUbk1HYwxv+ijKr0s
	2YNr1Dzv3WeOCbzkJOInCgjek7HH1h/yzehl96S7blRwD0IvRaDTNQoRgg8h4BO8mcZ/AWfD9s7
	gcbpigAOvKxPB6r4urWx7B9Hi8Z1m2iL4fbKE7yp6ie/PKWmSFTZxJjn7K8gQa2eTAf0=
X-Gm-Gg: ASbGnct3IsTLHzFRGddoUu0NX0zuHg28L9OCTlseIBjwg5DBxmosJM73VdrgW3WBiOq
	BJ//zVU4/R88XcBQJRonA39NCv+F0L67BZ7NqzmrhX5+XH0uVjCz7fBejU5LZa7wr3WQ0Dqmgbo
	yV4m8MFLJgHYYb6igfOjNpy6Qg25Z6REI5HNWU+hSMjmnbVG9p46uTA8WzgbiDUo4bg629W7jKP
	8SwKAGWggWZWHFrR31zCkWNVqcmjVrcpJJ99tRUcRZRIPC4vJnf6fTXXBXgg0kIwFAME7dHMVOt
	KGpd4y0u9G4HaxSH4xEJET0A1oOYN3VYsdqgFGpHjTLYw6lnkSkPxyBWiOk60iv+fvtHFM340HI
	sc64uhkkq5WEvnLkkI6zOhQ==
X-Received: by 2002:ac8:574d:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5f8485b15mr55798571cf.7.1757348529513;
        Mon, 08 Sep 2025 09:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYOBJx4IJkeJeAPl8HAgvgXSbH1A+bDveiyp+jDidpl9Ny8oP0uh/qo/0V2HKO1R7C2uho2A==
X-Received: by 2002:ac8:574d:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4b5f8485b15mr55798281cf.7.1757348528898;
        Mon, 08 Sep 2025 09:22:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6248711bfe8sm5192325a12.20.2025.09.08.09.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:22:08 -0700 (PDT)
Message-ID: <4fa44ec5-2792-45e3-af87-b3e4d2ed5d86@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 18:22:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
 <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
 <33442cc4-a205-46a8-a2b8-5c85c236c8d4@oss.qualcomm.com>
 <b4f283ce-5be1-4d2f-82e2-e9c3be22a37f@oss.qualcomm.com>
 <269506b6-f51b-45cc-b7cc-7ad0e5ceea47@linaro.org>
 <1727374d-0461-4442-ab35-9acb8ef7f666@oss.qualcomm.com>
 <df007b41-5c3d-4c69-81b9-27155485ccf9@oss.qualcomm.com>
 <pxigrjxtizcrhn4l25ph4yh4runebintfp4swqfiewfq5hqceo@g5cy3mdgjir5>
 <77db4861-4868-4110-8c31-eb2045ddbf4b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <77db4861-4868-4110-8c31-eb2045ddbf4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfXykMR74gN/sxs
 P/T8FAzY1F2qkD7/OlwD/NB8saHJejhjUhVy3ehIfQSMIvieNy/YTPMfBAHr5Y4BV7TJy9x67QJ
 TT+UR6b3USeeq5aG7CQhsIgrHglc06I3zjeD04ZLCHUmfBHzWch9xiWHCn7yQwZEWWsbEPbPrRF
 XVRY40TNBznda4SvAUzNGMn23yl6oDpXGeKnVdpWNskAlolm7CZ9UCikE8i4keVlKLuf2DwmWLw
 t714ZNQaHKLdYwav4nrijJtGTlMFXBGNnzqUlgOlpZgRmMdiFX6XlUnlzdrWvYCkcmcBFZP57RS
 TF+WPbMtts1XJZjl1KFyx65rc/5IzWsPGG1geC1P25DFd4RTGfWdioS3pX03eK+gPKPz2kGxrZ5
 1UwD/3fW
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bf02b3 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=-rBNSpjuQUH0YdP2-XMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eR7PIJwI080nSmHQi-AAig4V9YPVYReV
X-Proofpoint-ORIG-GUID: eR7PIJwI080nSmHQi-AAig4V9YPVYReV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 8/18/25 9:17 AM, Akhil P Oommen wrote:
> On 8/16/2025 3:45 AM, Dmitry Baryshkov wrote:
>> On Thu, Aug 14, 2025 at 07:52:13PM +0200, Konrad Dybcio wrote:
>>> On 8/14/25 6:38 PM, Akhil P Oommen wrote:
>>>> On 8/14/2025 7:56 PM, Neil Armstrong wrote:
>>>>> Hi,
>>>>>
>>>>> On 14/08/2025 13:22, Konrad Dybcio wrote:
>>>>>> On 8/14/25 1:21 PM, Konrad Dybcio wrote:
>>>>>>> On 7/31/25 12:19 PM, Konrad Dybcio wrote:
>>>>>>>> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>>>>>>>>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth
>>>>>>>>> along
>>>>>>>>> the Frequency and Power Domain level, but by default we leave the
>>>>>>>>> OPP core scale the interconnect ddr path.
>>>>>>>>>
>>>>>>>>> Declare the Bus Control Modules (BCMs) and the corresponding
>>>>>>>>> parameters
>>>>>>>>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>>> ---
>>>>>>>>> Changes in v2:
>>>>>>>>> - Used proper ACV perfmode bit/freq
>>>>>>>>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-
>>>>>>>>> gpu-bwvote-v1-1-946619b0f73a@linaro.org
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>>>>>>>>   1 file changed, 11 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/
>>>>>>>>> gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>> index
>>>>>>>>> 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>>>>>>>>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>>>>>>>>               .pwrup_reglist = &a7xx_pwrup_reglist,
>>>>>>>>>               .gmu_chipid = 0x7050001,
>>>>>>>>>               .gmu_cgc_mode = 0x00020202,
>>>>>>>>> +            .bcms = (const struct a6xx_bcm[]) {
>>>>>>>>> +                { .name = "SH0", .buswidth = 16 },
>>>>>>>>> +                { .name = "MC0", .buswidth = 4 },
>>>>>>>>> +                {
>>>>>>>>> +                    .name = "ACV",
>>>>>>>>> +                    .fixed = true,
>>>>>>>>> +                    .perfmode = BIT(3),
>>>>>>>>> +                    .perfmode_bw = 16500000,
>>>>>>>>
>>>>>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>>>>
>>>>>>> Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)
>>>>
>>>> You are right that BIT(2) is GPU specific, but that support was
>>>> commercialized from A7XX_GEN3. Anyway, the Win KMD uses BIT(2), so lets
>>>> use that in Linux too.
>>>>
>>>> I know some docs show BIT(2) support, but lets not bring in untested
>>>> configurations.
>>>
>>> Eh, then let's get the docs fixed if you don't trust them because we can't
>>> work like that..
>>>
>>> FWIW this is information from per-platform RPMh cmd-db data
>>
>> If it comes from cmd-db, then we should be requesting it from the cmd-db
>> driver rather than hardcoding it here.

No, what I meant is that there is a piece of configuration that reflects
what goes into cmd-db as its compiled and that's where I found that
information

> 
> Not really. This should be under the control of GPU driver.
> BIT(3) is correct for X1E.

BIT(3) is for APPS, see the interconnect driver which also uses it.
This will create conflicts and may cause unvotes when some other
driver requests perf_mode through the ICC API, but the GPU is sitting
idle.

Konrad

