Return-Path: <linux-kernel+bounces-864808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845CFBFB959
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F1A19A4321
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CA932ED27;
	Wed, 22 Oct 2025 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RHRMhbOx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE332E73E
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131799; cv=none; b=mqDv7fUE2eRslLxCgFFuzm2SUgPN2dUF3VJUyXBJsPybMrf7kQJhytY297IulF2/fottovmInZ3goViAJMXTzMj5/W+9R3qCLMUBKXAqg5p6q3p5k6HjHKDFf8hbEB7HO5gRytP+FCFh/Dj0mSjpSeZVZZG0C1BMUvdUg0zGVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131799; c=relaxed/simple;
	bh=Jm3uLOZtRPxHI6IK3sy3F4UdLfXMgaAjhJr3zJ5I8kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIKsm7tfnWq20nTjbmHP30/5d8c/fl6tlic+D0aA4ks/ZdjlKyhieJpRYMEJogdyMpaG9LEY+9jYucZIrVG95T1L7VEbEfakPuWFsz75KphD4QwxYQxlCFyu4ZPd5LwPyVnOokfTpLD/VJfioQBDHM1njdtUXmAhWqNNMgvBAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RHRMhbOx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA9NU7002534
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2/XKwr4n4TC+ITwBrL2OP0RDLGxOxAW/3WtJ2aFNP9o=; b=RHRMhbOxHPMQOxKJ
	0bC5I2cBeDk3Q/JzcE/rDJ2OcrA+AFH5rjuOiFPotYhxJzUX4UBKkPgxTKCsG5mE
	6EasLvQxRsV/HistJlTJw5CqLGVmAe0zsRcgHgeQgDWGj6fNrxEX4eZ/ekmfJXla
	L3zRHLZILCndOWCHF4nbhNObm4zyzt3kAf8yzaXWVpCZwBD2UkcyajdYKwC/UEgy
	xWhPc8drdVA5nEunzehj4S/YwjcOb4gh43QiDqq14MZd73k/HSPF/nSjd2MAMuCj
	TMmh8VVjWXfRRA04QWiGv+HQylTuuPue6lmorNQM7O1Fu2h8mkJvkJFX126aQwh7
	ZhDdpQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wa1f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:16:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87dfd456d01so1001266d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131796; x=1761736596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/XKwr4n4TC+ITwBrL2OP0RDLGxOxAW/3WtJ2aFNP9o=;
        b=heZTZNbtkOxlpH3eAm4bAtnUqKgdVXdMBBvMAXiPDKkPXy85p/Ym24KIQd3XBj7aS6
         NT53qoEi/8ktBxLFk2Q4p+XTq2aN3dwOEoxyEfvqaGhnelIPl4OhRpvungLHS5DDuYcy
         XR7IBiAgs3g+a592q5wqz5pMxOIi9r+W5gF0gdlOHGkiw9CWHLraNQza4AUP1vajgcBW
         epdYBe5oeZBUMaTDtTUi0VlNvV0ViRIzQ7rKmO+mFwEQn55pOx+c6dWqwgrxD65ttu0V
         FEOLzUDe9f/3F0LU40PaD8jzH/MyV0k/JJjW2pTRB1QO+831PeGEiYg3K5r5OvSsC9jd
         AtXA==
X-Forwarded-Encrypted: i=1; AJvYcCWUacpR4T3UcqlZxS3uRdJpp/+gBxbmvBo91+FpGqIMOcTAunMB7PClq1q6VvSboIA68Xo0QiJ5oi0x/UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjC4P9u8JokwyEG02QPGY5dv/dpJo7AwrH3+9PfaBDpNw0+7d
	DTEnPLnKy5//HZ2iTKIclSFbns+pnu3PRyIc2Na38VrIVklYGZvLYUkIp8IkkpWCGbssHgkbfL4
	LaD1rnGQDbg2aMwsaRrwN+ko3BaETucUyHol1eudIRVkFirp51/YHCuu3pZlkdaeM46A=
X-Gm-Gg: ASbGncskubyk1JfoIjrkWz/I5Ry/5y2rxG2y714DVg77CwPAELMWzP0hjd7gHnk5SZE
	1l3RIPiFbgDOble5hxcRbkU02vSDIo1dkJPgmX+zb3KCo/WlVTUlAsIhAMimbMj7gMWrRcnsCXz
	m93I6YB2d642yK68ZQei3iwGCaGh9mgaeRuhguIO3ykjAf0Ya5Obqv7zoHq1+zcl/2aWIHYM5D2
	HntRRHg6vMfG45/XtUo/SWu+2PCmUMSCZGfrCotQ1vP90cK9ubCWaCUpUT9NfFriYQTQS67Guin
	DDf/dnWLXjPKyQxnN19jmseos3BkuDCC0p0EyH429f+TTkgIZSHD4+grp00yxvMESFS9jNXRiub
	am8PsgNcM3lVBOaF58fdOXITx7/w1xHZMxov3Ou0YdL212iIYibgOnhnM
X-Received: by 2002:ac8:7c4e:0:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4ea117a5b7fmr52762831cf.9.1761131795815;
        Wed, 22 Oct 2025 04:16:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeA3+PEnZOUseZLDtXfAVmeVdOnmr0b8PKWtvHThf68jn90VUbNoN9ykrr/MODPrJ/wV25QA==
X-Received: by 2002:ac8:7c4e:0:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4ea117a5b7fmr52762431cf.9.1761131795294;
        Wed, 22 Oct 2025 04:16:35 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb725f3fsm1315242266b.68.2025.10.22.04.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 04:16:34 -0700 (PDT)
Message-ID: <349b031b-7e2c-479d-92ed-52b7ae0d15bb@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 13:16:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] drm/msm: Add display support for Glymur platform
To: Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251020-astonishing-zebra-of-respect-1c2eca@kuoka>
 <d6ivp57mh77gxybjvvwpmqoc5fsy52yydtvs23bepwdxgkxhzj@ahryeick6yaw>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <d6ivp57mh77gxybjvvwpmqoc5fsy52yydtvs23bepwdxgkxhzj@ahryeick6yaw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: w1ZBPeukYbWNa9R4UkhWuto5W0lRwZT_
X-Proofpoint-GUID: w1ZBPeukYbWNa9R4UkhWuto5W0lRwZT_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX4sit9kBaEf9/
 6s53PlFxetgx+CVooLOb3NhLrsF5DIGmgqyl+Cnc496KoceX9BvpqNjyuO6tsRuM3DYVQ3bScof
 rxnRpKfKSJQ7/SNdrllq/pvYrQUFq9VbRasz7s0+gOlJL5qBoC1cc7jldL00cMnGAVAbCTKAaj2
 cYriQlRzU/cq8T+jpygW4Jd0rwE1bEnEmOb0Vr0awrRri40YpXu6w8YeTdYbr6RA7Xn3XWY8ziP
 J01mbEGnJOsmIp6xxNBEFmWPPnuYlFBN5+m2DUWWfds+IPGSGBKpEAC1tsfJ/4lKEp11U7kw6xN
 NW5lsiY2bW8bSnesOY//0PDadlddV1gIBxCFGQ49KAng+Vh2u2v7dh1azLLxcI1rQhrPgifvulv
 q1l+UWkn9Zz9XU7bROGLc4eig1Qibw==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f8bd15 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=3ACIv-cKCvEmzLgNCBYA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/22/25 12:51 PM, Abel Vesa wrote:
> On 25-10-20 12:40:24, Krzysztof Kozlowski wrote:
>> On Tue, Oct 14, 2025 at 03:38:25PM +0300, Abel Vesa wrote:
>>> The Glymur MDSS is based on the one found in SM8750, with 2 minor number
>>> version bump. Differences are mostly in the DPU IP blocks numbers.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>> Changes in v2:
>>>  - Picked-up Krzysztof's and Dmitry's R-b tags.
>>>  - Fixed the bindings check reported by Rob.
>>>  - Fixed indentation reported by Krzysztof.
>>>  - Re-worded the commits to better explain the incompatibility
>>>    with previous platforms.
>>>  - Add the UBWC config patch, as suggested by Dmitry.
>>
>> Where are lore links? b4 provides them automatically.
>>
> 
> This patchset was enrolled with b4 due to logistical reasons
> which lead to losing initial kernel tree.
> 
> I thought the b4 prep -e should be the one to use in this case,
> but now I realized that has a different purpose. My bad.

b4 prep -e base_commit has always worked for me

git config alias.last 'describe --abbrev=0'

-> b4 prep -e $(git last)

really handy

Konrad

