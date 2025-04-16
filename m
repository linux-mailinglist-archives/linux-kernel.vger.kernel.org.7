Return-Path: <linux-kernel+bounces-602933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F410A88131
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71152188C3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B652D1F48;
	Mon, 14 Apr 2025 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bSx59Lrn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF702C3769
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635991; cv=none; b=PMZBuIa7K4PaWN42dQC22zPj39o0J+0171F4ruUtvyFLv8DxD/kwjlt79umnwlQXh4AHnlODbmqDCTbT0ZOE93sDo7p4Rxm1KZpzhDUKrVlxrGycQZXpgau8Ehn54+dfDRrugYQsCf6jy64d6JL50KF3tPrLjL9H6xOqn46B87w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635991; c=relaxed/simple;
	bh=AZK9XRS9ZWhSfx4eNw0ALr+aw3DDUZiMNW2qilWfAtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQuJOfQGiTEbjXrpzTs6W+js7rqMFeT9+FHZHa0M6QuhJ81f5CYRPNJCRDFYA42p8TaZwjap1mNeJPJYnzDThcqzqmbf/8q288LVjIxQvO9i+hq/LXwkZwuANEQS+MAnPCJ+79YU2wcFnFCaJ+ZvSS0KM4FnvKNK01RATv7eOtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bSx59Lrn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99rwX030666
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J8coqQeKvuFh+O3TZuuEoTer55FpYo41z991GNWMMUg=; b=bSx59LrnlpAfCR6t
	90Qfr3Piwo2r8+qIQXekEASVX5PDX0gqN2/lfXMu4RlPUPiGZ/vpYavUObSUEAPV
	UCdx7I/l2CSNxD/YKXAo6IRyqqZwIJ+p+Ovntnx8bubpWRpyLyu2n+Er6foLh20p
	3COPambWzbpDsfaRWwjj9kiDj8TCmGeGv3EdxyMmUTdqujA2DoRvelj8yHE0Xb5x
	KPHROGhRH4AFdslD0iqTPr+DAyspuYBY/hJ38B/bj5zMO6WA+JIGyRW1VLuZNvnY
	SWxx6pJzvTvvgsEgaeXhw913dF0V6CqDQKu9XvYFnbC6PZUrHadTR19DYpG/NKyS
	GMvYrg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydvj4t7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 13:06:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5ad42d6bcso90568685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 06:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744635987; x=1745240787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8coqQeKvuFh+O3TZuuEoTer55FpYo41z991GNWMMUg=;
        b=fcaMRlMiodrEadEn8++8d98voiAhB/P0uHjGFfv4PALvbAZ73Nmjazp7i4O4VoEiZL
         NipCJfMlDcftqr+wz5HLGpQ3gzCEhiIJiRn/nCpZdNgOpo9d2hgetSqUnc3PDfTou9Ds
         tvIkJkL0vvJ8UBqR0LkN40k0W2nudmKGkh/8Q1FE4bHTW5iCDa/2fJOeCvEgln9r+5Fs
         zs8zluDLzX9FMRb6bCek2TMSTvSsZPneX8D1DWNw0vZYKm0LbzQmrdPU493f33k5OZOr
         88MSNVSTJb/yJFHXVx2jxniauFOA4FIMHG8nlXN9N+7OmK0jpustaY4lk3TyQBL1yqaH
         W2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXIJDZYYKmjLTZNLdKbycrTJJJ5ftgmmVjl1vHvJknDDWPZ3FtNh/bvfiYK8V5cvC7tWt8UqmF32zIQbA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+Qw4ZzQQB/YrxVwWns8lRGyq0PyIk6l4TQ3pxQjF9nNzqfFg
	XdS30ppLg65Wd3CTqOEIQgKWdQaYs9DtaOFIjeUSk8iOhskU5oDwRZMPuZfxJWMlJH7cNJhw5J0
	3z5zlOUtgoyTD8Ns+bbvegNMLn8VCy4C/v9Gk3SgiLSb4GxCeLV749uj4+ge4H0c=
X-Gm-Gg: ASbGnctjso6qcNUF1TN8SV0X7cCUZbtKOlCb6A5B8Kj4FmnIn2Cd+0mv/fbrEtCYf9u
	TKryY9LbZ7TWN0i27WoBqqIy1V+crm11OB++716cLOC2CmVxE98HgX2Yoz2WF1ofOTdkDLmZ8TY
	uLj6TXjBHR8QOBC+8W+lazfwIIZ52K18BWGnwc8LsZHhyo5h6N+skjVceegPjYHSNAzqdgA+2dQ
	XTKm7lMJk01HdSuchM+MBMHqLS9SjA6xL1vG3SeDpoOwomNGq/cmLryHCLbSlCcW8LAWv3LODIc
	vOkTm545GTZ4tpGFjF9dqluDPSnZH/FQsCm1+8C1KM3cP3II66kOpMG8rbIzR719fw==
X-Received: by 2002:a05:620a:bce:b0:7c0:af16:b4a8 with SMTP id af79cd13be357-7c7b189ed2cmr593266085a.3.1744635987456;
        Mon, 14 Apr 2025 06:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF6qbagUm+W4XTsW+veeL8DouR+tzZeh7A7q5mtlDE4nmmTvZe6ePtnwhw7Dz4PGEXvzT/kA==
X-Received: by 2002:a05:620a:bce:b0:7c0:af16:b4a8 with SMTP id af79cd13be357-7c7b189ed2cmr593262485a.3.1744635986887;
        Mon, 14 Apr 2025 06:06:26 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f526da3sm4827693a12.67.2025.04.14.06.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 06:06:26 -0700 (PDT)
Message-ID: <868c635b-0b26-4062-9a44-4ba07ca684f4@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 15:06:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Retrieve information about DDR from SMEM
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com>
 <685e784c-3f36-4cd1-9c34-7f98c64d50f2@oss.qualcomm.com>
 <0bec3e62-0753-4c3d-abe1-1a43356afc80@oss.qualcomm.com>
 <e7bd2840-dd93-40dd-a1bc-4cd606a34b44@oss.qualcomm.com>
 <CAO9ioeUeNeSxz7ADZ-BbJbhEKkszVS+SmbqaZCgTpL=csak=hg@mail.gmail.com>
 <b04464b6-2ad9-4866-88e9-437e96645726@oss.qualcomm.com>
 <sgjporlde6bgcp2mhr3r5c6wj3a3u37s5nlrrokbutsyizixod@7shpt55muqki>
 <4e265348-3466-49fb-82e2-255205052d1e@oss.qualcomm.com>
 <qdip4rtk2zusxkdlui4ujnybsh7jfqk25tazx477tueytp6cbm@dom2fduk2r6z>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <qdip4rtk2zusxkdlui4ujnybsh7jfqk25tazx477tueytp6cbm@dom2fduk2r6z>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZIrXmW7b c=1 sm=1 tr=0 ts=67fd0854 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=BMwtVS2TDCMlKGfjk1MA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: g3v-pJQLu09JTFyZZP9DlSa_AxUvFfMG
X-Proofpoint-ORIG-GUID: g3v-pJQLu09JTFyZZP9DlSa_AxUvFfMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=524
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140096

On 4/14/25 2:28 PM, Dmitry Baryshkov wrote:
> On Fri, Apr 11, 2025 at 12:52:32PM +0200, Konrad Dybcio wrote:
>> On 4/11/25 12:50 PM, Dmitry Baryshkov wrote:
>>> On Fri, Apr 11, 2025 at 12:03:03PM +0200, Konrad Dybcio wrote:
>>>> On 4/11/25 11:57 AM, Dmitry Baryshkov wrote:
>>>>> On Fri, 11 Apr 2025 at 12:49, Konrad Dybcio
>>>>> <konrad.dybcio@oss.qualcomm.com> wrote:
>>>>>>
>>>>>> On 4/9/25 5:49 PM, Konrad Dybcio wrote:
>>>>>>> On 4/9/25 5:44 PM, Dmitry Baryshkov wrote:
>>>>>>>> On 09/04/2025 17:47, Konrad Dybcio wrote:
>>>>>>>>> SMEM allows the OS to retrieve information about the DDR memory.
>>>>>>>>> Among that information, is a semi-magic value called 'HBB', or Highest
>>>>>>>>> Bank address Bit, which multimedia drivers (for hardware like Adreno
>>>>>>>>> and MDSS) must retrieve in order to program the IP blocks correctly.
>>>>>>>>>
>>>>>>>>> This series introduces an API to retrieve that value, uses it in the
>>>>>>>>> aforementioned programming sequences and exposes available DDR
>>>>>>>>> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
>>>>>>>>> information can be exposed in the future, as needed.
>>>>>>>>
>>>>>>>> I know that for some platforms HBB differs between GPU and DPU (as it's being programmed currently). Is there a way to check, which values are we going to program:
>>>>>>>>
>>>>>>>> - SM6115, SM6350, SM6375 (13 vs 14)
>>>>>>
>>>>>> SM6350 has INFO_V3
>>>>>> SM6375 has INFO_V3_WITH_14_FREQS
>>>>>
>>>>> I'm not completely sure what you mean here. I pointed out that these
>>>>> platforms disagreed upon the HBB value between the DPU/msm_mdss.c and
>>>>> a6xx_gpu.c.
>>>>> In some cases (a610/SM6115 and a619/SM6350) that was intentional to
>>>>> fix screen corruption issues. I don't remember if it was the case for
>>>>> QCM2290 or not.
>>>>
>>>> As I said below, I couldn't get a good answer yet, as the magic value
>>>> is not provided explicitly and I'll hopefully be able to derive it from
>>>> the available data
>>>
>>> I see...
>>> Is this data even supposed to be poked into? The foo_WITH_bar types
>>> doesn't sound like a very stable API.
>>
>> Yeah, it was designed with both the producer and consumer being part
>> of a single codebase, always having the data structures in sync..
> 
> I feel somewhat worried about parsing those structures then. But... the
> only viable alternative is to have an in-kernel list of possible
> platform configurations and parse the /memory@foo/ddr_device_type
> property.

Well, this is where that property's value comes from..

Konrad

