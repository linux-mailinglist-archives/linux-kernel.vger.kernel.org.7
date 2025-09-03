Return-Path: <linux-kernel+bounces-798138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E724B419EB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D194546C96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB09221859A;
	Wed,  3 Sep 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IM2RCMQj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B7C2F1FC7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891590; cv=none; b=Mgb5fmPGC8+8B48skd1vpwl/UX1PKiGasY7q4vvOQYJBkpodTU9B6qI3IIQyu14uJvgHvHDsOFyF7HYMD6jE2cP0e7xTFewwWK2MUo8aPyjuICNdrocgfjYXwqhSSKigrpq6eHWqEaviM2fIlOszcJRtWAbocD3hpnY4jqxHaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891590; c=relaxed/simple;
	bh=10sA292kwL2A1iaOlb+UU/OrApoXHSI2mjwMRVd0G2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqujZbf3ucWpw3e8uhWlRJNAfzsajcePo6X3IH8iUqezh9Z80hcLCV9ETRcPBGD47x13H7v9LgbuUywPfk8/pMl8uBJNAv/z6yTDXNSnjHCv0Z+GtpXKEenclkjAN9I6EXbiGy4/w46nerhLdpgcoeuw+vXkjFuYCtbYtOIqHjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IM2RCMQj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832RHef012705
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UjHv5Rny7NYvIIV6SOi+RWSfsQ+PhjUoJoUt/TGYKPk=; b=IM2RCMQjbHLbuwvm
	2BmlzDGPZayYsO2J1lR9qLo22+LH1D5ZvmuGZAYEa8W9HqsGkDBEDlylPrQPBvIb
	YE6Uo0ykRkO+REHUELqP0sSvnEEDUBogf6jmygOCaVqcZPZ26w9qM3idbW9WfL2u
	ZVuQt/N5CtCLuZt38SaCCYbglU/f0VEwphCzt77mSgJZB9jop3y14cEb+tCeRk9b
	WqUKC/lvGQetvcIbVaty673cO/NdMVs1rsbj11RlvTocqg6/DzMBhiBZtftQBzmX
	zIBjkmxrDwKtY/819dqGMpYgQBCXSPgy4Wo1AT+NDRYTZNN5RqSHj+se4zm5EaEF
	8lSUYQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk92tct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:26:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f5a43b6so15657196d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891586; x=1757496386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjHv5Rny7NYvIIV6SOi+RWSfsQ+PhjUoJoUt/TGYKPk=;
        b=qak9mlql6PEJjg5tAh0z4WPOs9au49b4y+4ZyvPndnVYWo6E1sMSKRsqYclBkO76NQ
         6LDMUUuA5BXlgOLwgMfEuKg4TCwevUNhhsJ+Xm4MQRXUqHX+X29GIwI2eNq3v7ddng2v
         1up1N81gjJmiRjxopZUGvQB2s7HivrNZcHiiCZ1yqjFB0pTW7wcuWVWh6e2s48V7GBKL
         z7I5ryQqle63GLzcjlxhmiiv8MsgDuNSNmH9gUJEaNoe0CP5nebbK8qx9qebZ0YfT1D1
         lrJzZBAee2/91kbrVzac0oYqsw0RLIWAxGrj2znAHOqcpVVgDYp+p419oNhC9pKc4RAm
         UY1w==
X-Forwarded-Encrypted: i=1; AJvYcCUz9QAw7E88fZydH0JJaGiPQl5zNaoWk7XNHeqAJmTNHqyWKSCW/5X7n9zfd8olu+jjTaKiyTIaB9dNeEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGbdUGcoxBjwW4Cqf3OePNRMGrXQhOHDERqcwSYh/Eq8PIiTy
	fPQ7S/1jB8p0WZDkcji1y3ihf0mfV1NUM7n95nTK8bl7TDyOTnsuE9ofjxMtxPOfr/tE1EPpTRr
	B8IBZMXfw0PTgU5cOV+mUHGNZiTfJSEaycEvy1VPsxs/Kh85cnyqnVbGlqA8wD8AMLjY=
X-Gm-Gg: ASbGncuewOfjtBsDUWsdsz+fG7zDU6h3TN5uhsaan954DngzfKlFC0Uilmonw5hFx/A
	LFOvg0ngDi09AZN91CVEpbOH/SEoc2P1td2And3FBYD4KnxtuXydg3Slo7rw87arSMPv44C9IB1
	NKmu/GVFIkZdTRElrxv0igm0EhXd/RX+fBaqHpb4KyI6mfqxbA+AnBVa8VlRF663zpt4f7rBH84
	y43tLeuOSJkXqH3k0JuXlNapJncYkGD89qA/MGLp4Nlhrktme45SyTW3jjvw80DvgiQ0mdUFn8n
	ZbrXOIREH+SX0WjA0w8bM6GeG2PthbjhF5Y4sUw+9CbnEM8J80alHJF0VPjCJ6nRJ5fl29l6sUK
	dysFQ0WFgavhU1zW7CaP0TQ==
X-Received: by 2002:ad4:5d4e:0:b0:70d:bcbe:4e79 with SMTP id 6a1803df08f44-70f5a5fae45mr157318056d6.6.1756891585975;
        Wed, 03 Sep 2025 02:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGodqLINHIr1ti5AIWKv/NvUfg7lci7ZbbtsKiF5IU1s9PYba1/SeEbO5pfCLhRpYbPSD1A==
X-Received: by 2002:ad4:5d4e:0:b0:70d:bcbe:4e79 with SMTP id 6a1803df08f44-70f5a5fae45mr157317826d6.6.1756891585382;
        Wed, 03 Sep 2025 02:26:25 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7a27sm11650300a12.10.2025.09.03.02.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 02:26:23 -0700 (PDT)
Message-ID: <7382b6e3-3872-4e18-a1bc-b2c75c888a5e@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 11:26:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/msm/a6xx: Add a comment to acd_probe()
To: rob.clark@oss.qualcomm.com
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-4-f3ec9baed513@oss.qualcomm.com>
 <694f0989-64ea-4c3c-8613-863da1dd286a@oss.qualcomm.com>
 <CACSVV037e-GquRk7P1_qT7T4HF=f-TF93FpJ16NiKShqicaCfw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV037e-GquRk7P1_qT7T4HF=f-TF93FpJ16NiKShqicaCfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bn66rD8mASfLPr9tnwQ70_AEzuFvMISq
X-Proofpoint-ORIG-GUID: bn66rD8mASfLPr9tnwQ70_AEzuFvMISq
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b809c3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5-JTw_7GLCY5IPuysb0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX1EATE/ZFGLYY
 P8ZThR2eHyjrLZGESOMGvC20zYVEXAHv32Cl0pDpp1vsMuAwTo8rR1LR96aklCJkw3JkRCH23+e
 Cp/1BXOVnjUmqBTta1g8FAWADka0n88NYhVof6/gist6rcOH7dC4nsp233NwAE1DUJMCCBNL3Pf
 jaVVhOjIl/kMiM7+SiTNgLI8gMs1OdY6etNNsfcuryA0pwcBwOyHcOc+PqxOXfkg4xT6ldMeZN1
 rrE/1r32wfGd5j0rfiMvTxkhynaGb/p8uZCH6wvpzly3X9UpB0r36rHcRBMsGm1v9Q6xNE+yB3d
 ZHDnUKNwmfJ4E2BdMRNDnBK6FHPhQEXbqxNhlM/abagBQvx9cXfvuU31wYXL4MiqvUIc/JHrIeT
 KuAtwciv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On 9/2/25 5:57 PM, Rob Clark wrote:
> On Tue, Sep 2, 2025 at 5:33 AM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 9/2/25 1:50 PM, Akhil P Oommen wrote:
>>> It is not obvious why we can skip error checking of
>>> dev_pm_opp_find_freq_exact() API. Add a comment explaining it.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> ---
>>>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> index ea52374c9fcd481d816ed9608e9f6eb1c2e3005a..de8f7051402bf0fd931fc065b5c4c49e2bfd5dc7 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
>>> @@ -1694,6 +1694,7 @@ static int a6xx_gmu_acd_probe(struct a6xx_gmu *gmu)
>>>               u32 val;
>>>
>>>               freq = gmu->gpu_freqs[i];
>>> +             /* This is unlikely to fail because we are passing back a known freq */
>>
>> This could probably mention that known == we just retrieved it a couple
>> function calls above, but I suppose the reader can come up with such
>> conclusions
> 
> Also, I think s/unlikely/not expected/ ?  "Unlikely" implies that it
> could still happen..

Yeah, "unlikely" as in "cosmic rays" or other kinds of mem corruption

Konrad

