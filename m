Return-Path: <linux-kernel+bounces-866646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDDC0056B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 991174E6B14
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434C30AAC9;
	Thu, 23 Oct 2025 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DU4i7kTL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11012D8360
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212778; cv=none; b=pgrcYUOTQ5aZHUnLHBZRmfg5RywQoy3kBpLO656IWQjmLha32Tj2mYzSmcOHI0nCrvhQrZFFgEGgWd/ETeyBRvmhqsHfVTN3eqwUQOB9f8w+rSpaWd8nyVG+LNiwnshD8AQRQSZZsqdFF7Ydkx9YMJLN02guj60Wqi4YyNir46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212778; c=relaxed/simple;
	bh=/zzyfqI1GWC6rbxv6U3DhjywDwjjR1Wgryy0JdaC0vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFHOWNoUkDuPzbVpKJM0dnvNgUPVdIk7jLACGVKMjmU2LgJCWWOuENLyhZxeqf35DnUU6k35CItVw0sfLVOivb74mYn1QWlMG04Mq0MnRTzvkNBv41i6meuhnydlIK3xMoUUCTKa6SNUXfghYEZPp5QQCr2WozaJb+qKyepYORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DU4i7kTL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6PK5G025807
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h/rdWFEDoY0e0ccprEgn3vcjXMen3ykKbsVJ0M/ZEss=; b=DU4i7kTLq98cjMxY
	gmRIbSOYDDK98w5tvRcP2nMdMia2r53Mma3Tl1UlCKtSWfCjaxIgJa8OAxNer8G0
	fN7jxwIN+ePqG+m53Fm+xSdmUq/eRmuWYCgEXifGsur4Ww+BDWXqxH2Scy4D6f8f
	NyC2vkH1x0sLUklOPSxoZrv7Kn7oIvqNfdhlIvDR1sHRsb+dWUMDGlnqu+rWuZ0q
	gIWNV/89kRc4LoMHv/2YRb2wCWPcDZLAInP/P+hgBe0M8ebPqyd6TDt552Qs5lrW
	lmYiUJGHAtI1OkbkPRUfG3kz7Vv5gVaz8+7Nv5vnj0GOCnbeRwBu40THdZmKaPNZ
	MmcOJA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kfq32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:46:15 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290992f9693so16310885ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761212775; x=1761817575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/rdWFEDoY0e0ccprEgn3vcjXMen3ykKbsVJ0M/ZEss=;
        b=QGbUURrDM54DN1iG6++oVb5N8Cy0VVN4xsL1R6T+Mg1qjndT9v9LXniRcK2/eU7Tqy
         /3+cSlSTypHQq/xkFqwyI7fi3YToziwkrIIZ0oCqmcZdl07zD8icN6L11YEmyAzV7y1F
         BuQrz6v67x5fv+if1qEjOyeV6icQad+29SlbwHe1vhAWcb6WLv0/Nc+CGbA5KCamGBAV
         w5Ah1rBEqehCZoaNmanBjn2OheEnXD1P2glTfcp6FkQ6PPxsXJzrAWSAHMRNUfHtz4SX
         fpYxaksW0Aqdos6hMa2gY5FLSjdgG/QvbxN54vxlTzDT0rnW5DPTe2EednJCSojTE+cn
         01iw==
X-Forwarded-Encrypted: i=1; AJvYcCXA22ovPLaQsbGbFKHKZtPGy4i3jBAiyA5N5PRt8FfHEAkDmW6EudO2zcRxc5QReq1KD12nU0itKpR5Px8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZd0C9ELzMTRLESPpljAx6I++SrpHzBC69fxE3flDtPKYguX+
	TVTcwsx7LdN3NFiAYHkgElD1op4p1fl9l1AS0LAmVn4GQWjGefop5DYmnaEMoy28+/Akq54ht8P
	/sQYAmaPoiakhES1bADw/Xyoue7GiKVHmracNldWnJ4QXypr5+uOmhwTy8x2vHF6sC7A=
X-Gm-Gg: ASbGncv8dui5F//v/vP/YgA8jMoS0gjJuRuJ55YCEF8cg3X2eaPo2I2Km97juxSeZrf
	R6yQ2hhsjO00VnRDBOTeTFAghkp5oEX4WMPGufIccM+AHhDYz6QyF7MVAeGAH2oTb+ZmQHCqJip
	QLFH6xSM1j7vHUVXIDc22jRLYf4I9GHHBAm/APNDRKoHlDqSdJKbfPmFq6uXoczYhupdStqoGNC
	1/oCMk2CapGUwRBIWspF1tl6Gle4ijVqUUkkhepxAmrZr/VqtbW2ckqC2l7jV6/BPFTvqVMtaqw
	65tddjzDRX7UdDjzptuYAetKovtH/x47iV8V9H9RWjh8vlazHsxLnr4vkkKW8K8bxIsZTCYx9EJ
	ht7eA+0GJICyUUqbaNvhrpXs=
X-Received: by 2002:a17:903:1107:b0:271:9b0e:54ca with SMTP id d9443c01a7336-2935e04b272mr57496425ad.13.1761212774888;
        Thu, 23 Oct 2025 02:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+rCl4FXeidBANxzSUeLVvoA72I8aUoNHILGqf6sbGJKMCWJxjC37VjIhDYOs2bxv5z0xp0A==
X-Received: by 2002:a17:903:1107:b0:271:9b0e:54ca with SMTP id d9443c01a7336-2935e04b272mr57496205ad.13.1761212774412;
        Thu, 23 Oct 2025 02:46:14 -0700 (PDT)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb0196831sm1843255a91.20.2025.10.23.02.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 02:46:14 -0700 (PDT)
Message-ID: <9a227c15-dc60-4086-8d81-f80e3398a083@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 15:16:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
 <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
 <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
 <cb361d77-6845-45c9-b418-67649880495e@oss.qualcomm.com>
 <ef247fe6-6d9c-4a74-b3f8-a56857332758@oss.qualcomm.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <ef247fe6-6d9c-4a74-b3f8-a56857332758@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OcVPws-Dg8rikXH0TiLeZYvKHUCUVI7J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXzw+5xK/QfkbC
 rgooYC+egR0og3mroyTlyom0bFyS4UzoBWbiH/ixOq1wh4J3sC7JWWP0izOBvgfHueZN8NmOPLR
 NHNTaxtz3swtrXrCG4dK19gk+gx5iCP72/z4eEEKdhPiZ8quZ7oXBkQn1Uz4IV+QHah4GHnbAUR
 XvevjqFZkKgV/MEn3wwyvUKuXZYQYF9UTpGohYOB8RUArD6Gejsa4DeZWL44GERkLwDPjlOhSWd
 nd70ylvzNKVhOUpJGDf61JDcT6Vr5onVU+uXAISZJhfgTh7iSvGImjGGTLv/I/pbcqsvLu896xK
 rXdByzCsKo+B0FnB+pbXREl30WjjgPk67klZbgS6/3F5M44h+gAe2r1ZhXladyHALhHyaOXZ/eg
 ZSpRmvbZZP9PkAkkB5Iifmq3+RYN/Q==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9f968 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=YAA2XIu200uozTIaui8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: OcVPws-Dg8rikXH0TiLeZYvKHUCUVI7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/23/2025 2:39 PM, Konrad Dybcio wrote:
> On 10/23/25 10:57 AM, Maulik Shah (mkshah) wrote:
>>
>>
>> On 10/23/2025 1:47 PM, Konrad Dybcio wrote:
>>> On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
>>>>
>>>>
>>>> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>>>>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>>>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>>>>
>>>>>> All rpmh_*() APIs so far have supported placing votes for various
>>>>>> resource settings but the H/W also have option to read resource
>>>>>> settings.
>>>>>>
>>>>>> This change adds a new rpmh_read() API to allow clients
>>>>>> to read back resource setting from H/W. This will be useful for
>>>>>> clients like regulators, which currently don't have a way to know
>>>>>> the settings applied during bootloader stage.
>>>>>>
>>>>>
>>>>> Allow me to express my disappointment over the fact that you sat on this
>>>>> for 7 years!
>>>>
>>>> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
>>>> Read support was eventually removed from downstream driver too for the same reason.
>>>> There were early discussions to remove read support from RSC H/W, due to lack of users.
>>>> Its not realized yet and all SoCs still supports read.
>>>
>>> Can we read BCM states from HLOS this way too?
>>
>> Yes, Any of ARC/BCM/VRM can be read to get HLOS/DRV2 votes.
> 
> Wow this is amazing..
> 
> Do you have code for this already, or should I hack on it?

No, it won't be of much help, as i said above it gets HLOS/DRV2 votes only for a given resource.
More specifically, the read does not give the aggregated vote result across all the DRVs.

Thanks,
Maulik

> 
> Konrad


