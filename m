Return-Path: <linux-kernel+bounces-896835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D20C515A4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221DB3A3A86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1F52FDC3C;
	Wed, 12 Nov 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NcehQdir";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eAsbqoQn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2117B3E1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939278; cv=none; b=ntnWZyN2UtCt6vb/HD4kaX/NEGwHSOx23E1A3iZi6+X1ACNAMwXvD+yybCNprAoMc0sKtTcWl4eos9HF54PupZZ5tAQ09RQ1LBaM9sQpJ+NkcoieoShhTM6o0HZXQez+TgSe76CCrkOXVugvCQA1gJp0Um7rYtAGo6kxn6GPLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939278; c=relaxed/simple;
	bh=p/3gdJ0mEWz4X0Zw7w1a/Dom8p0nO9b3dR4aFzb7OLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btCnBEUTmX+MJIp1dgq6IYS2VjDQF0a8P9Y1cTGDg6sYtXnhStfxFIL0bsF1/3KKzjRCHmwAHMSOReg7k1EIay2kOQkAulWUXuOv+tgKaTxQ1RyEwHZ6ROZG5YEgQPoVghTHs0/Lc2dPnfQHn9rmTqL96xqOHkF9zEiTf81aB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NcehQdir; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eAsbqoQn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC9Cklj510766
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TkA+4SpVmmeTiao6KIqZ4pvqPqOwV4VDAKwhI/CEjf8=; b=NcehQdirr5n3hmeP
	/7bwgJEhQ8aKIJRmaHh8K2vVoGAmx4KtGdfqx6ljdaU7SRykOpSnHG2obj4nHFGK
	tR8HDnad7YTQLNppdAr0pyIyMV2DHBHB/MJEAvGXkWCg+rAInGaU3L2U627axl19
	A9iF/8LnT9ssi6onQSUoojLAxoNoY2REqs4F/rci/KEvMnFI+WVBviSSucgoHkOQ
	yUuu+4J4kGEzDVp+1s4BOBPBrCbRANzK7vo//v7U1jP/IQnfY4hthv8HkKqzNqKw
	pzu6k202MFLzIctSlsgagq5CzjwQ46i1Fe5vHFEd1AwlYtr1oTzRVFca2JaoDDmw
	i0048A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acqdgg117-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:21:16 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edaa289e0dso2403191cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762939275; x=1763544075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TkA+4SpVmmeTiao6KIqZ4pvqPqOwV4VDAKwhI/CEjf8=;
        b=eAsbqoQncV/P62M+dFyrxBIGR7TPymNEA6h46e6rAiyEakPWKX/tNVKRgq7fbJALwT
         wh0mw19GnTchBESfU6AFMo0FaUpQbGLn9vmk/T1fAV9uMOFW65iW6ibS9hm6SNZn14cI
         ueHi37tQBVI0H0/4O2hgIQmiNliKjIyG4OiPvx6yVUljwdv/QGpmr9WGBiO1nzi/XW+s
         7kQsfHuspdWoWQ0lkMdffejsQsqAS5972dbrT8cCNrngrOSQwOpBfZOf+4BdOKR3iYHr
         lWBFobb2LgwawRvUWzm5kfXEVGKwRZUZvUmog7K3cy3NW3ByNd/fuhSGEnC3GPcY/aO3
         CPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939275; x=1763544075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkA+4SpVmmeTiao6KIqZ4pvqPqOwV4VDAKwhI/CEjf8=;
        b=hKD3+ritkJi4Ehdn3Gk7q7b+RLjRvZq2lm/c3dFRHxyfwC1mhK7LeVXVzSysi/Gh5T
         ifEfNhvJ0niq5BRNJBcV3zq2Ict6HOvlG+mLKy+wUzE4NwA+IqiBGqeVAxNe42bV5uiS
         KIuSriLC0FBu7EGp2smWbN9ZnwGBlyDpGM0DnEpBzeuNzlc8XZlnKkPNlwj5EeOqulSa
         uTY970gQ8spbtuFGybSXSWJxk7lc+qzZ9lMOolPRiLTiJho2+LLdZeV/6h5FUMtluWKD
         WCCse691VzAtgs6L5Kj9Ocskoho8fFXRXRcddDBveADfxmUN/csR2Sp4zOSEP9uYT/LO
         peeA==
X-Forwarded-Encrypted: i=1; AJvYcCW8SPqK82jQ4Z9WtrziRK8q510XldNEaoA+ehIhAvV1KhJ3AZ2Ns4k65TOIb6eh8tNdcYbw4YsUIBPEk6g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9L05905qTOAjJqHPzffXtnqSFwpDSO4pWKVBW58EpHpabsT1
	+JT2G7W3ey1M7qpTpnQMrI0Re7i/Obh8geXb2iZgMA3Qm/cbPDO8nBoaTlTjkxu8cbIqGXvaS6A
	Dt37bckYWki6uRDizQoL7zYVh6ptUu9JseJEgRdiXHBZLPLBA44CWnN0k0VeDBczj7/o=
X-Gm-Gg: ASbGncsS7KG3CAiSqW0LBiQMOdJ6ANj6lbCnw2HhYT7u5PCsan0aX3RRR/9HUep/wwX
	VSsJ/fVTBdpT8ZgQ7NFKZFMIA9dynZdchS53RvJxm1Q/LoCynhflBuE4/NQsXLPwJSI4xNxHKzL
	jjkvQb1Y1rJP7+zdXFTjjPVRI5EruW03BWKresm6eLCTbIblHM+FYo1xjWeqZFEnVNFp/ipCP0p
	dCKgnbxt9QzG5K0Djse1jGFyW4SAD+PzFhWbv/Lrp81maM9zyO02Bv7dQ2c5j+ozwj80EMiG3Vf
	EeLbmI5gkBdtr7X9g6///VpUoEvcd3/rfusrSaEu4y1IAxw1P+3yLzQC4lDcPLtLsCWk46e/I0y
	LYWX/t+NNS165VJC8lfHKN8G92QgXqY4fGUEfAtjRlKirq/hYhZtWgS/Z
X-Received: by 2002:a05:622a:1808:b0:4ed:3cfa:638a with SMTP id d75a77b69052e-4eddbd6f1bdmr17859321cf.8.1762939275331;
        Wed, 12 Nov 2025 01:21:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1gI36KuIEWI4rn/hNy3hzO7bxb+zuycrzvicz8tGoIOMN6OA9SGPB+GEKzLD3Tiqg9VPG8Q==
X-Received: by 2002:a05:622a:1808:b0:4ed:3cfa:638a with SMTP id d75a77b69052e-4eddbd6f1bdmr17859171cf.8.1762939274937;
        Wed, 12 Nov 2025 01:21:14 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a22sm1557621166b.29.2025.11.12.01.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:21:14 -0800 (PST)
Message-ID: <ec38f267-2d44-446d-b538-78f849ffec9a@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: rpmh: Add support for Kaanapali rpmh
 clocks
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, jingyi.wang@oss.qualcomm.com,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251030-gcc_kaanapali-v2-v2-0-a774a587af6f@oss.qualcomm.com>
 <20251030-gcc_kaanapali-v2-v2-4-a774a587af6f@oss.qualcomm.com>
 <swma6lyjfmyhl5ookdzvpjn5qresgsze5wptg45jfgj7ub6a4t@bdgfstw6gzoq>
 <507b121b-98c0-4632-8a61-e9d7a6a13a3e@oss.qualcomm.com>
 <42xj5qgoh3m26y4hmdck5hfyqaxncfaeugymrmrxb7tusxjvm2@wsjztnhbp5jf>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42xj5qgoh3m26y4hmdck5hfyqaxncfaeugymrmrxb7tusxjvm2@wsjztnhbp5jf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=6914518c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=k9nrLfKtrhbSy2XMf4sA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: FUfeaR3GMGcnfeuWeP-2srNIi8nnNuSn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MyBTYWx0ZWRfX343/7GaiWGC1
 kH5d3DVfEz/ZfYd7yJEnJgCCr3t1h5oIPY1ItFxpmJWkslx0mS3eDLdVr0tiWAmEiqH8RSDIZQY
 hsiAGE4nm+mYH4E+2/RcnS32ShFCyoWckAn/dHZ06mpq+e1/2PO3mrP7qa30tUueRpGWulzEUlh
 68IT40lZ9helTug4SUxqv1a+K2NDfIhyPVOE71KXJSRIUWn8igOf4nu698/FNmWScIy6h9Sflb0
 6E3N0MxYrwYQXzFcRkyiOuUKGo5E0OnLT1av67FubSWu6o0H9z7UJ+zHqh79IESy6bGwjozVQtT
 LMMtEfK0QLRMv4T0a8PGkChXuYHIeHiCO1cQe4D57Aboxmra39bKbWz9hoPdzdeBa6/sLoDQmWB
 xU3N/HfqxmQbHCtR72HlcnBhEp+/qg==
X-Proofpoint-ORIG-GUID: FUfeaR3GMGcnfeuWeP-2srNIi8nnNuSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120073

On 11/11/25 1:16 PM, Dmitry Baryshkov wrote:
> On Tue, Nov 11, 2025 at 07:44:36PM +0800, Aiqun(Maria) Yu wrote:
>> On 11/11/2025 6:46 PM, Dmitry Baryshkov wrote:
>>> On Thu, Oct 30, 2025 at 04:39:07PM +0530, Taniya Das wrote:
>>>> Add the RPMH clocks present in Kaanapali SoC.
>>>>
>>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>> ---
>>>>  drivers/clk/qcom/clk-rpmh.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 42 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
>>>> index 1a98b3a0c528c24b600326e6b951b2edb6dcadd7..fd0fe312a7f2830a27e6effc0c0bd905d9d5ebed 100644
>>>> --- a/drivers/clk/qcom/clk-rpmh.c
>>>> +++ b/drivers/clk/qcom/clk-rpmh.c
>>>> @@ -395,6 +395,19 @@ DEFINE_CLK_RPMH_VRM(clk4, _a, "C4A_E0", 1);
>>>>  DEFINE_CLK_RPMH_VRM(clk5, _a, "C5A_E0", 1);
>>>>  DEFINE_CLK_RPMH_VRM(clk8, _a, "C8A_E0", 1);
>>>>  
>>>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2_e0, "C6A_E0", 2);
>>>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a2_e0, "C7A_E0", 2);
>>>> +DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2_e0, "C8A_E0", 2);
>>
>>
>> Shall this suffix necessary to have e0?
> 
> Can there be C6A_E1 at some point?

Yes

Konrad

