Return-Path: <linux-kernel+bounces-723160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EECAFE3D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776EC189B8C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB65283FF8;
	Wed,  9 Jul 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MD04QiCb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2E24169F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052575; cv=none; b=WJFFpIY/RnMHa7vNT9ytidQ2VpXnCV4QvYzN3Q43EzeiZLU2HcdDIw8ITSFazw4MmxZwilzLA+XEgrZYkp4Of0aP1pJJUPq+DVouLADtOeW8WdCiaiXmrO+fI7UbYTGpxjXLVWgG3CL9WQy18QnuDiD/KQVLup4CvAnBl29YWMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052575; c=relaxed/simple;
	bh=Wif2EAnH+uS1OueMuNGozeeBl8sbJsE1ULddgFc131Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HurPr3id2YnTh4PfmHDcHRFSl2qiPlJpOVE3NiOBG0+K7QXTCw7VzW+xkKWZYfVLGYKRSoSFG4aHUp78GrusVgdne8EpezgBGr3zLM5l5G5wfiIMo/kqcLDbskDOYfai+GxVV6dgNybFVORlDSnBHBt/h6kG/5uDBpYYE6PEMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MD04QiCb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5697ld3j023230
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 09:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cv1BCk8MYMc74KhkADwnTl/g1Y3GZM+AUyi9qevFM4U=; b=MD04QiCbcyupDjwl
	uMpXji2CFwUbWFMp4gW7xRrfwrZxp4LFM7WwubrPVypwEkJ4RNX5iWmon+pTowUp
	JSmny1owcMo9YZW1vft36dB9wAFi2pcXdOLdReDPrdxwxGwAKAmeqRlidX/FTtSw
	p1od8/Z6bq4ShAqeq9qtDW+4MDxabq/a2vZJf0Wtl+ubakfRm42HMYLSTsI6iIyP
	pnEhGuFJ9ArUQcl2QMnMEXzZPgX6xjC5Sj2k+zbRX7SmHTmM+9RzntQeSv7km1K5
	dxDP2hvWQSW7EetVn/i7lzhakHkyVMw6vpYV4yYGjybvf6aSVka0Kf8ILF9f3AqI
	RtKmNQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbnr92b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 09:16:12 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c0c961cso1575989a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752052571; x=1752657371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cv1BCk8MYMc74KhkADwnTl/g1Y3GZM+AUyi9qevFM4U=;
        b=RGQC63VaTR1TnPBXTAMpRxVuOicmun7ZRS1GnqxGfz1ZHdJbPsWpVdmDSkoBXuXIcM
         UObuFqJC5fv1vbJXv58+GkfstlmHb7abGNpvQ70qNw9D0nx8gzh51RQtapLDhrwcXCI2
         NJXeRZ56C8eE2noQSollCF0Ff6smK5D8YgtHbXXglo9LYEfhAYn3vyOQ8Q2ccAl7QXge
         0f/UYzuBiya8BpQWO8jjPljOWTYYN7lct61z0Xz+mt4tcKvvyawnfyTe22ItIrsEG3Qp
         f+YYuQue1bxX4NTwC/ccwzdkXI7O5hxRqwK+mquV6mPZvXptNVsSFZs8FUqoNZEvHoJD
         dicA==
X-Forwarded-Encrypted: i=1; AJvYcCVEzkN3ygPZROVCfnYmubx6X637RGkhoI6cph0LdDyAxR/Sgt0ejLQBcTwSD3ia+4P5As+KWZ5ag6C0LbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZF47Z9JChNzkfMfFZnUHrMgYIxSVILIjxLCrrNIKz1NiGza/3
	kWQozl1FfheOa+sTApanngrdaNNCUjMahO1at6CKHeqnrjkZoQiu6TRLcI3MErESRGEWpHXLUhu
	jrTcJzU2wwDpQu9kypOc/aG953PxxIkHv7A6bt/lKx18404y/sOgczXGrjcFi9IRWRDA=
X-Gm-Gg: ASbGnct3kIJwQkRyfUe6KsTW+vctGRM4tcMZw/l/KCU90O3ujz+oWYve95WSE35MmTi
	TDl70p6dSHj9d4BnFMv/wKNtmFJlMaJ6mXY6a5RR/BYlQgRUdpc4CCQ8h2e3xa7CjDVHA35Z2dC
	a7lbo2rTdIPiH9zihCLs0iwI61IRMJNklj6ci0yAI/wxJMbB7UtSBSyBX+RneVeBCcoDKTgpLMx
	tvWwzD6UYgz0PT3dj/80UG2/Bt8vuleHNkrvue9BRXS6TqV2XV/Eo8Hx1WtIz3LvYXewH03Vk61
	4z6yRPXlaWXoYMaC8xXM6v9pgvLbovYCG79bU3CH3UpHUNdKTZZEjwBm9fXkwWiCapXh/UgXhuj
	fsKDPWZ0AcBWp
X-Received: by 2002:a17:90b:35ca:b0:312:25dd:1c8b with SMTP id 98e67ed59e1d1-31c2fcb0251mr1322486a91.2.1752052571534;
        Wed, 09 Jul 2025 02:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdfQoEh/GXWJ6Pu0rY5iE3WeMtosEwrdpewcGf70D85+7o6PThtirQuZHfaVGHEd9tQdVP5w==
X-Received: by 2002:a17:90b:35ca:b0:312:25dd:1c8b with SMTP id 98e67ed59e1d1-31c2fcb0251mr1322454a91.2.1752052571046;
        Wed, 09 Jul 2025 02:16:11 -0700 (PDT)
Received: from [10.133.33.178] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c30067a55sm1502877a91.14.2025.07.09.02.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 02:16:10 -0700 (PDT)
Message-ID: <d427de7d-76ac-4e5b-b79a-3b7638a8e7fc@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 17:16:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] drm/msm/dp: Retry Link Training 2 with lower pattern
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        dmitry.baryshkov@oss.qualcomm.com
Cc: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
 <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
 <brgl@bgdev.pl>, quic_lliu6@quicinc.com,
        quic_fangez@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-gpio@vger.kernel.org,
        quic_xiangxuy@quicinc.com
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-7-09a4338d93ef@quicinc.com>
 <CAA8EJpoN1qBHyZrQJT_=e_26+tcaKRnSrhtxrK6zBP4BwpL=Hg@mail.gmail.com>
 <b4345b9e-62c6-470d-b1b0-4758cef7f175@quicinc.com>
 <xlmgdysjah3ueypdrdu5b6botvidb2wn4rfm4qpeysclscmuwy@vpfv2ymprblj>
 <b4e1ea54-ff3c-408e-8716-f48001ec9113@oss.qualcomm.com>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <b4e1ea54-ff3c-408e-8716-f48001ec9113@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4MyBTYWx0ZWRfX4cWFtKOIVK7b
 2LiSjB5c8tbPKceZ1h3ZJrLsY1N1a6WaygU23JQ6f0DAm8xUCkY2jwNDO/hhW+XGr8/Y5ILhcd4
 1TY5QGPyvYRhuXZS4X3Recs2TMuRlJ+oD6UVoFPOZcfN2pCMIM5i1YbbDT6NQSMs4U+69RRShj4
 mpMjdHUvP5gMT/gS35Ee+NTTsMnK1A60PaLQWJo3GvaT4XDRgMxaxU/1I/0J/Z3Pt8DuGQxEY7X
 kH8ic4ecvACpIdrCVVlRCI1KYWQktMOF+UItR8f7KAQS2OZ2A+NYT95ENiK85WTtqFOSC/wQTfi
 uaYkeR4RDj22CgIFn7i/FUO6Qb0TUne0jpzXMhuNzhvKzQRH48vbM7fVSJZ4Ifhk54nNLp97Llq
 b6jUn9LK3LxcpCKMFegOoNTVPcikqR1bVICUJ1PKIlFh+AxmNk1HRc5EEZWUG07+DJjmpBuZ
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686e335c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=M9roUVu_bSbsc9sLP4sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Nb4oiiN6BfbwSp-M1KxfJs9fy_AH9sH2
X-Proofpoint-GUID: Nb4oiiN6BfbwSp-M1KxfJs9fy_AH9sH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090083



On 5/28/2025 4:49 AM, Konrad Dybcio wrote:
> On 12/3/24 3:07 PM, Dmitry Baryshkov wrote:
>> On Tue, Dec 03, 2024 at 04:13:22PM +0800, Xiangxu Yin wrote:
>>>
>>>
>>> On 11/29/2024 9:53 PM, Dmitry Baryshkov wrote:
>>>> On Fri, 29 Nov 2024 at 09:59, Xiangxu Yin <quic_xiangxuy@quicinc.com> wrote:
>>>>>
>>>>> Add a mechanism to retry Link Training 2 by lowering the pattern level
>>>>> when the link training #2 first attempt fails. This approach enhances
>>>>> compatibility, particularly addressing issues caused by certain hub
>>>>> configurations.
>>>>
>>>> Please reference corresponding part of the standard, describing this lowering.
>>>>
>>> Per DisplayPort 1.4a specification Section 3.5.1.2 and Table 3-10, while the standard doesn't explicitly define a TPS downgrade mechanism, it does specify:
>>
>> Anything in DP 2.1?
>>
In the DP 2.1 spec, mainly on section '3.6.7.2 8b/10b DP Link Layer LTTPR Link Training Mandates', defined 'LTTPR shall support TPS4'.
The other parts seems similar to the 1.4 spec.
>>> - All devices shall support TPS1 and TPS2
>>> - HDR2-capable devices shall support TPS3
>>> - HDR3-capable devices shall support TPS4
>>> While these capabilities are explicitly defined DPCD for sink devices, source device capabilities are less strictly defined, with the minimum requirement being support for TPS1 and TPS2.
>>> In QCS615 DP phy is only supporting to HBR2, we observed a critical interoperability scenario with a DP->HDMI bridge. When link training at TPS4 consistently failed, downgrading to the next lower training pattern successfully established the link and display output successfully.
>>
>> Any other driver doing such TPS lowering? Or maybe we should be
>> selecting TPS3 for HBR2-only devices?
> 
This logic is porting from qualcomm downstream, 
For other device, only found in some older Tx chips like i915（intel_dp_training_pattern) used the maximum hardware-supported patterns, but not lowering.

According to the description in DPCD table 2-232 003h, From the DP spec perspective, it appears that all supported cases should preferably adopt TPS4, as it is more robust.
'DPRXs should support TPS4 and set this bit, regardless of whether the DPRX supports HBR3 because TPS4 is more conducive to robust link establishment than TPS2 and TPS3.
0 = TPS4 is not supported.
1 = TPS4 is supported (shall be supported for downstream devices with DPCD r1.4, except for eDPRXs).'

Although maximum capability of QCS615 is HBR2, but the actual pattern supports TPS4. 
From pure design perspective, it would be cleaner to drop this lowering in next patch. 
> Bump, this patch looks interesting and I'd like to see it revisited if
> it's correct
> 
> Konrad



