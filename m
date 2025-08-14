Return-Path: <linux-kernel+bounces-768680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDF6B2641D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 430284E573E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC62318137;
	Thu, 14 Aug 2025 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="euaRl9WN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F72BEC52
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170506; cv=none; b=qWDSXxEHOBxAnDnJIXWuNPXEnAV8KYO2AgoVFGmiSE861xu/ru4cbd2UzxX9PQEX+42iBVbPMMKCjwFYy+bo+FSMPmsaY++cWCgPnypFml6K1LHRv5jjbTZL/dhs2UbRSzkQjKOnx72dyF5nFOE+CzuXijRbAmRqxww2usgjwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170506; c=relaxed/simple;
	bh=AnVdNMo/fM/KCQMMQLsEvfIMWPZn2xenZ+yFprNLl4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsijSDaZRwBcMiKHcG6uRICAxYI+JgXcib8wgwM3bpBhZahgDVT9xhzn8WoAQUPgNXhVaLtrTGsaouTPM+ulYOmFR1y1N34VOi6vUC/gS5/4UgLtSQD+r7R8/es6ZgQbKrgTF4KmXeyX9JsmEXAdR0P9oXtoNjF1LWUDRuf2zgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=euaRl9WN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9AtAN026997
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BLzSrsvlz1k7U0IApR8xjk7JKOJ6PPWdleXZ1uW1ptM=; b=euaRl9WNX9NsW8OO
	/OnDGUTHnSJqOcIpM+ERPAffH9ircd+a1aV16KBhMT4nLYU3IUTZYcFK2Ba5wX3X
	JiGFsECAxEv2/+2SMItlzqgRzBVwLMjhLmjSTkal6gbFNc4CQADVf6ROuggcLd8H
	C95uH1jq3v48osVuu4V/eFVQ7KRqdQS3IRkJOSiu8sZkSKEPQ3b4IyWbAWYYYaHc
	3p8+495wNoO9fTXi3CLZX0xvipyJunroaaSz5rtcqhL2p+WCYNhHV1eMTHJdxMGn
	oR35uXiO0w/6UjeYURysgxKlSVUY70W6bUJMChqPC93F+cdmTYBpOjzewNWysabv
	bSnDWQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjuama-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:21:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109b11c4eso2603821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 04:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170503; x=1755775303;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLzSrsvlz1k7U0IApR8xjk7JKOJ6PPWdleXZ1uW1ptM=;
        b=tlBxx4XIUsPAlYMeJCqb0QnzmKEBZLLj8/qxx5yvHAR9L7x1lMVHq7Mb1EKJBLbJve
         OwQgH5aJsobS6aTrSEiYnyCIxcAT0aWY0UxaqKA0OHvSucb6tOxjytTSq7DSeIudYy3v
         Hou5/MbOijxl4ZY3v1hxaBSYeK2WPPFA6jdiIdzHlZVSXX7pz7iZVWNfrl58L/x4MmPN
         A7TFBTzlb5VVFwDieoI1ilXUDobRs5J6wkts26qKGo5WeJdVEI/ZZjSTXOGksJwD9Gqd
         CYNPYLNZXxdSAQRmSCSCteyzBG1pctAac9W/19Lws9I6VUfdZelc+9MHhj/a/uC+yPQF
         6W8A==
X-Forwarded-Encrypted: i=1; AJvYcCW1FJ4LE04tMcEkqG4vtDbGlaqZ2l50Yigh6WTKgl8hND+HsTJ0QrzRWTKTlBNXlnWJMdENKB/7JmtBhq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dfjKWnpDw42DvJjnOWbzq4TW3PhjkkQPC6mPcRZwuab1blsC
	j1yjKY9sfwsOVH1VTkJUF0ntjj9jXCnp8vdo/mnzIOQKmXR9uMKqbXcB/Fl+E/M2vD7FomzCzsF
	krKhEE7apFuAnldsWknDLBFmfPvTNDN3clCGLVd8kZXiav7m0NEFr2WrRSByB97W3mD8=
X-Gm-Gg: ASbGncuY7Js7DLcY4vbb4kb+473YK/ZNZIlCOC+1swPITIw/BFQm8xKqozkUIMpDCDF
	dDgzqqDUEeFSByEeGhw6drbQNtAhgAq0IttkHspKbhIX/n4ofQMKBHHUBNy6bzyDa+xQ/C8JUSm
	EqiUKPk25bQefxml2FMkD5frt6cPBOqKTSt57+Onm0j4vovynjRFo9QvXXgr7puNPMk6yFi/Pf+
	R0nSkzhw+mXMae8bVlktQXCjTZs54nUKAW6jC/A5uH81wcPkphCDM4sIaOqQtFpeO+Uk3Em+wPh
	jiYz7raaMCJubZT0evX5zGlKHdZcVpHGmtwqW+V/nfcU9SCP9knNKh3z97ZmM5EMOwmV9L8MYls
	DoEM35SLEhoqlMttd6A==
X-Received: by 2002:ac8:5a0d:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b10aa82b70mr16850401cf.7.1755170502740;
        Thu, 14 Aug 2025 04:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGvtOWlrpuz/iNQTwiGREwfxnYm+3vQJfqpP9BRWhj2V2vfmiGGO6FJVbo4wdvgDfBPNzUHQ==
X-Received: by 2002:ac8:5a0d:0:b0:4ab:723e:fba7 with SMTP id d75a77b69052e-4b10aa82b70mr16850081cf.7.1755170502199;
        Thu, 14 Aug 2025 04:21:42 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e6cecsm2578916266b.70.2025.08.14.04.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:21:41 -0700 (PDT)
Message-ID: <33442cc4-a205-46a8-a2b8-5c85c236c8d4@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 13:21:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm: adreno: a6xx: enable GMU bandwidth voting for
 x1e80100 GPU
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250725-topic-x1e80100-gpu-bwvote-v2-1-58d2fbb6a127@linaro.org>
 <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e7ddfe18-d2c7-4201-a271-81be7c814011@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX8WE1dN1qwwdv
 BAXjidLu23QH3P1N9W7GT4XgdnFc6SxpZm0rTd6lLlDLtR223IypEmzf7WqH3GMX96/aB/8MBRg
 nkqF7FFdLGJMV4GRbpKp17ZcX+MIobl1tsIJ4Q2RNfGYDBzJnCxb+E8dH/GR2xzJQcFsIBIv2uO
 FPV42jq438YNwbSifgUnFiR4YCga/NUnBG8eirXxsmOizntlHfKyvAfPLN3DptmhXEadeatgL/P
 sUlt28bdA/7+AWxmm2m3Bby1xJAxnhptdfm7Nw/LePe0VITcA+AcH1N+VfN5xpGAq0Ru77Fw8sJ
 MGABMjOgr5tJgCkr1jb/C4+jcFd1AvOpxC/1Kn4F1uZt0gaRfoeBHfR90X3X9Mw8kDOW0UToGyt
 qURAGl/0
X-Proofpoint-GUID: ElC7HXhIU-EBL5nkING8ijXpzh-TI2cD
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689dc6c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=vBWWQJBIfp5UPC7yhvoA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ElC7HXhIU-EBL5nkING8ijXpzh-TI2cD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 7/31/25 12:19 PM, Konrad Dybcio wrote:
> On 7/25/25 10:35 AM, Neil Armstrong wrote:
>> The Adreno GPU Management Unit (GMU) can also scale DDR Bandwidth along
>> the Frequency and Power Domain level, but by default we leave the
>> OPP core scale the interconnect ddr path.
>>
>> Declare the Bus Control Modules (BCMs) and the corresponding parameters
>> in the GPU info struct to allow the GMU to vote for the bandwidth.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v2:
>> - Used proper ACV perfmode bit/freq
>> - Link to v1: https://lore.kernel.org/r/20250721-topic-x1e80100-gpu-bwvote-v1-1-946619b0f73a@linaro.org
>> ---
>>  drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 00e1afd46b81546eec03e22cda9e9a604f6f3b60..892f98b1f2ae582268adebd758437ff60456cdd5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1440,6 +1440,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>  			.pwrup_reglist = &a7xx_pwrup_reglist,
>>  			.gmu_chipid = 0x7050001,
>>  			.gmu_cgc_mode = 0x00020202,
>> +			.bcms = (const struct a6xx_bcm[]) {
>> +				{ .name = "SH0", .buswidth = 16 },
>> +				{ .name = "MC0", .buswidth = 4 },
>> +				{
>> +					.name = "ACV",
>> +					.fixed = true,
>> +					.perfmode = BIT(3),
>> +					.perfmode_bw = 16500000,
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Actually no, BIT(3) is for the CPU (OS), GPU should use BIT(2)

Konrad

