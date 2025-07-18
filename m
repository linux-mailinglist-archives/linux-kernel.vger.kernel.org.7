Return-Path: <linux-kernel+bounces-737270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070D8B0AA28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D6CD5A0E22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA717A305;
	Fri, 18 Jul 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oWjJPj1x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753B192D68
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863460; cv=none; b=DagO2tQi+6hsZgKSjFrHKwIf3cAl83LQu8CQJcWUd44yYo5+9L283Se8QQ4fZ7ImjeFSIMPdZUPLBhB4t3mB+OQoopMvHjkU8QWo/8a1WyeoAFYFuBcAOcJ2jhT9vCUrTXzAX++H4Rn4C3E50yhqod+3sRDoqcJhvN5tC3MsUv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863460; c=relaxed/simple;
	bh=cwCr3EmN4ljODSdOYfAE4b95OmqV3a1GLgmXbYYUam4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8/6FCc0gPJOG7+F5Lyf3UfiFKvXMLylxUCKT1zwWUgBbc772B+ZltyKEFpeqD1q06nt1HK7En4GYjA9ZNYVZSvIlLo3i5UoqgfOgKRB5Serq5VmA/K+lW7f5QUrWX1J+iZrxrmzdmtAqObriPPOAxTOnzG7IK5j5ECf8JG+mYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oWjJPj1x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHh3aE020753
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r4h89Vyse17RRrUr1f05/FGG03KvAET2RVT1D25eAKE=; b=oWjJPj1xH/VrdjzL
	tWfus+B2UXGhpidyUuyT0Qii23tUed3HUFf8cgQ5yfbNEUdr3Sk55TnXlVal48y2
	XYamV9MJUv+hY9L9IyQ9PQHBELHlwhx6Pw8dsdo3CONzbheGMeam9QSeRMTp7+Yi
	toAz0LEq9CsalNqGR/C+LajHghty4fnskS2xaaKUS6eTmSHWMuCvxOQzB7SJx8pt
	1i+S3VmTR8WHN4cEjVzESrR8HwZHEjkNkEa+Gha//sq/xgtDBg6pUfWreRW/h96O
	ftGFjxkkjW47Xqy7fnSb2+H5dgewxSuJezlxSCmZMkT8nuiiHYXMwBmBNC2eDu1I
	tS+DLw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpqnpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:30:58 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-87ed30e2375so2961632241.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863457; x=1753468257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4h89Vyse17RRrUr1f05/FGG03KvAET2RVT1D25eAKE=;
        b=tJw0BGABNeR1sn8x3iJon6iIlx1l1krhu3H9+jsFOmdizBiIRluW4BV7caStrmnq9L
         4KwHChsJyDKFodY0t9cWUbkapAx/XcS5HLuqP7flvtsvnAYDoTGxX3fjbu1vI2jl9UUY
         ZE4CI5T/8XsYMtm4LISqk/k8tn1J8OVItWz/Dulmxy8uuG3Vf8M7NuYcaWBYBhxydB7W
         Qz4BFNPiK1bfSuGTT0EcpO9UhDsBBQY9MxHdfa/33A7QsYRwGYsIJTUldEUIV8NH9a6F
         O/6F7T4UEhrtgaDv20IbPoatv8RwImfCYQ8/ezr//KWuDTgPnmmG5hHA8lrAu+GsLelk
         B1DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+/GwBg6B9B2sizEZLrM8huW4DlklSTvG3brofbThXT78rbhMueu5Rp59TthMynQW8IOXyCzHEoG/3yjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuBI/jDcBzlLBFAzIe8/Zq2O4CR98tC0ZFaRYldKc3HF8E0j2E
	lSI7B+ydtLLeVySqsE5kwQQj3+SRVCOxUnRCpJrzIMrmZOKvdcTU5BExvWLYCp9ATSDqxBJWuEq
	c0jrjCR0SbKQmxlwassnT/i3E244fQPVpALE7eMbLXSD0Iskvy6X/nwKLw1zxJflmIfs=
X-Gm-Gg: ASbGncuwlv4QAZnPOInTr6mDAaaAa/7KA+bDfHEpjcVeL7BeemSF7enNB9y0ru8RvuO
	nFHiAOwsoSdaz1qtCdWIGyBNh47d86UUaKbkw7Mecoz2+EX/cMAPRk9pKC0/+6D0zCtZ4LyX0NB
	oI4HK2gKdF5bEGkP9tX+VH/dmuyZSV309rph+XZ3En+ob2oDjPR5Z8+AvFEZjjEcHHhrAR/XvOS
	tR8u6u31vAZ3fGb1bVmtBaY/x/RvRBkuAt0NCvY1DEPZkHlR3aTHmapJiLbBPoJQ2LDORjsxux7
	R2K80GoOHHTyjquvlLYWnnxAr2IOB5PiUJQ7BLsNoFZwtQGL8kBastmOoGFzmgj8FaLxfbomE7/
	F7wFZXVmZXpWWF0eAW6PkQXeDb4Y02epTWVWofxNoFPw=
X-Received: by 2002:a05:6102:3f90:b0:4e6:f7e9:c481 with SMTP id ada2fe7eead31-4f955aafcc1mr7300355137.7.1752863456727;
        Fri, 18 Jul 2025 11:30:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWyWfF3+tSP9AxR7UCyIPlKJus3GeSYS6RzS+bb0n22cuscjLeVO6oqysB5eD95XIzb3VFmA==
X-Received: by 2002:a05:6102:3f90:b0:4e6:f7e9:c481 with SMTP id ada2fe7eead31-4f955aafcc1mr7300253137.7.1752863455983;
        Fri, 18 Jul 2025 11:30:55 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0c3:3a00::55f? (2001-14ba-a0c3-3a00--55f.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::55f])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31a9b7c0sm357341e87.10.2025.07.18.11.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 11:30:55 -0700 (PDT)
Message-ID: <0bb0c437-e680-4160-b98f-efb816c9f049@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 21:30:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] drm/msm/dp: Work around bogus maximum link rate
To: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Xilin Wu <sophon@radxa.com>, Dale Whinham <daleyo@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-7-daleyo@gmail.com>
 <A9DB4AE061FD8BB9+3519a519-1a29-49c1-a07d-28a0577677cc@radxa.com>
 <CA+kEDGGaKrYO9Pu3un_Nq_6AOZC5L9sG+CEwh2ZEzWFeHGqtEA@mail.gmail.com>
 <eb0f5be5-3a6f-4969-affd-c01a6216ad0c@oss.qualcomm.com>
 <CA+kEDGE1kb12pW_OH1n4LmB9PVtgEsft563p9Cx_Mxev9Em3Ow@mail.gmail.com>
 <jsynzhzzt4drqcrvbuprjnvu33go4gow3l3hxgafuczdn67uhm@2eq7c5rzflr5>
 <CA+kEDGGVimBZDq1sa0gOXB7Vi6U8AVgD2E8mG_iTUJDce=56PA@mail.gmail.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <CA+kEDGGVimBZDq1sa0gOXB7Vi6U8AVgD2E8mG_iTUJDce=56PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0NyBTYWx0ZWRfX7ZXSInJ1tSNa
 rDdoDEKeoEbTe+jgy3zT4pC25598nYb5hZ5yuoVoy0zelTuVIvJXX67ozfuTber2kjtCKzof1Xc
 AaA7sIR1Jn8VSRWj/2AnR039kxnQboj+StwOZnkFCAxBcQXlvh1DwA2dKnJR4Zi1c6wgvzRJ0GW
 vMqJJ/yMiMMgagfGLbixW2CrW7WU/1uymjQva1edFEH17qV9u+JDCJ8/zPLA2qmINv35rEeL5OX
 XEx7Am/60S4mO8T/rRlZLg4/1t/CrILNiGD9cr2IzGJnJs5eHoJ+50kOvDXTMAj6cxIqMF4O76i
 xYpML8E1ocbXqnMvblN7gq//ImR89E0v9FLy5nyEDGINfSHwCV4Ly2QEgp4MdIXCaSI4H4N6/zg
 g0ZIx/upipSHlvgtNGQdAcUGDLNylbDRfN5tAH5H+wVHp8fSMuY+lWvQpKKwCFYC6UWbfOSa
X-Proofpoint-GUID: Bdl6V5mPCP8oKK5tEPxMt5dhqqPWkPFQ
X-Proofpoint-ORIG-GUID: Bdl6V5mPCP8oKK5tEPxMt5dhqqPWkPFQ
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=687a92e2 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=ksxQWNrZAAAA:8
 a=pGLkceISAAAA:8 a=t_Of-uX1f6KDt8Xra0EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180147

On 18/07/2025 21:26, Jérôme de Bretagne wrote:
> On Friday, Jul 18, 2025, Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Thu, Jul 17, 2025 at 11:36:38PM +0200, Jérôme de Bretagne wrote:
>>> Le jeu. 17 juil. 2025 à 23:10, Konrad Dybcio
>>> <konrad.dybcio@oss.qualcomm.com> a écrit :
>>>>
>>>> On 7/17/25 10:27 PM, Jérôme de Bretagne wrote:
>>>>> On 2025/7/17 04:21, Xilin Wu <sophon@radxa.com> wrote :
>>>>>>
>>>>>> On 2025/7/15 01:35:42, Dale Whinham wrote:
>>>>>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>>>>>
>>>>>>> The OLED display in the Surface Pro 11 reports a maximum link rate of
>>>>>>> zero in its DPCD, causing it to fail to probe correctly.
>>>>>>>
>>>>>>> The Surface Pro 11's DSDT table contains some XML with an
>>>>>>> "EDPOverrideDPCDCaps" block that defines the max link rate as 0x1E
>>>>>>> (8.1Gbps/HBR3).
>>>>>>>
>>>>>>> Add a quirk to conditionally override the max link rate if its value
>>>>>>> is zero specifically for this model.
>>>>>>>
>>>>>>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>>>>> Signed-off-by: Dale Whinham <daleyo@gmail.com>
>>>>>>> ---
>>>>>>>    drivers/gpu/drm/msm/dp/dp_panel.c | 13 +++++++++++++
>>>>>>>    1 file changed, 13 insertions(+)
>>>>>>>
>>
>> [...]
>>
>>>
>>>>>
>>>>> Is it a feature planned in the short-medium term within the MSM driver?
>>>>> If not, would a quirk like [4] be acceptable upstream in the meanwhile?
>>>>
>>>> I'm not a display guy, but this looks like yet another block of code
>>>> begging to be commonized across DP drivers,
>>>
>>> I agree 100% in principle, but the 3 implementations are different today.
>>>
>>>> so I wouldn't expect it to be a big blocker.
>>>
>>> Well, it is for me :)
>>>
>>>> Adding a panel quirk doesn't seem in order, as the panel is /probably/
>>>> very much in spec, and it's the driver bit that's missing.
>>>
>>> I agree that a quirk shouldn't be needed. I guess we'll work on
>>> upstreaming everything else and keep an out-of-tree patch for this
>>> issue for the moment That's a bit sad as this will block regular
>>> users from easily installing / testing via the Ubuntu Concept ISO
>>> for instance.
>>>
>>> Or could the quirk be accepted temporarily with good comments
>>> then reverted when the driver adds the missing support? I guess
>>> it would depend on the time scale of this support landing.
>>
>> Unforutunately, there is more than that. We should also be writing the
>> LINK_RATE_SET register. So, just setting the max_bw is not enough.
> 
> Maybe I've misunderstood. When you say max_bw is not enough,
> are you talking about some future driver changes or about a potential
> shorter-term fix?
> 
> I can confirm that this initial simple patch (and also the updated one
> reusing the quirk list [4]) is enough to get the SP11 OLED display
> working whereas it doesn't probe and remains off without such a fix.

These parts were changed in eDP 1.4 and then 1.5, but basically, if 
MAX_LINK_RATE is 0, the driver should also write LINK_RATE_SET register. 
See how it's handled by the intel or AMD drivers.

> 
> Thanks,
> Jérôme
> 
> [4] https://github.com/JeromeDeBretagne/linux-surface-pro-11/commit/d265cfb
>> --
>> With best wishes
>> Dmitry


-- 
With best wishes
Dmitry

