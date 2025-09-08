Return-Path: <linux-kernel+bounces-805481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7058B4890F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4375F189839E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F332ECD3F;
	Mon,  8 Sep 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wo59aM0q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA22ECD10
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324999; cv=none; b=eONHOgUQBwS/kuYyrvyKokCT9ND5J01/uOQTyramVS4eZyZxXL6/Gg7v5VTbK7wRDCk542mIVmNx575jy/xR0bU/ez9mSqRx6e86XTQPaexjk953YDAMh1WU2NOvsv9XDbgA7Rw5hcRVpwukOanWoF86wJrPM9AfLxGtSDbYBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324999; c=relaxed/simple;
	bh=/1qeyyrYEEifT3QeM8Q+fXPgtyXCmu+JFWWL/hFWG90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+he5jEOUuumZrrTc1dA/KaNtu3xc9WC67PIC1nWKbaT6fdAA5rVY17iWZ3M+jG1CLQsFXzvghrBrWrortjByEeMs/tkkOqd6U7Nz7JrD+iZHIK6sQjW6bFGrbCX8yu2vdWMDD6tRybcMn+y0Ysbm7gdqTavSWg42i5RGboOKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wo59aM0q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58890wMn003301
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 09:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lD6KEG3zwEbdfYQAGN1f+cGXwCANVO3gniDOdrVcexg=; b=Wo59aM0qVggtWo45
	OryuIuaLthROh7vzp7ABJDOVBTbdnTH4LypIyCpBja0d0eWvlm8ynTKJyEvKm5y6
	EPBIvGGMcTdakg3EsMsDJ8QC3cw1bF9+Rx3Vmc7pE5xogHvfdla0mPVn8vnU8m+A
	rxZE1M/yZ9hOzn1MAllTUtGYMujI7VMDId8WSFYgVGpG9qsSmB+u2WYNQ2eU7lz0
	wAAoeEPL4JUVippz1QcFzC/kyZvejSVl8E7/6DVJZhD/41ntvnirXGiAaSpjxU5K
	sospCPmYw2HcNNt8fPkye+0b/bQXNPd8PwJQHy1C0Je4NQcSP9L37ilbasB2AncH
	m+nQ0w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8v6qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:49:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f92a6936so8923801cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324996; x=1757929796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD6KEG3zwEbdfYQAGN1f+cGXwCANVO3gniDOdrVcexg=;
        b=nA0ZBOVvX4/09RRMX7e5np2uu7aq3I/USFPd1/hoSiqhlGFsQ6coZG0hLsXolhYkQt
         NhyAq9+LRMKFfiPpytSnUrKDYOAdKclMOn++pTpDXA8Nl0VuFiw5x954J/9bPZ3O1nQv
         kZ18bBq0676qbJ5myxSZZgfpEa60g4Dnd+b4NuGrHpu/Y1RMpGVbpxmtb0RLxfgawU53
         vkQfhL+neoeYm0DITqzBSgrLU4lj8yK6msftfrIn2J9vZtWo5TvV4W8tRm/+VcgmZ0rl
         EHvy/GCaMqWz+FH+cBNFuw9PPGQ+Ph44uvFhes1PcRe90JQIq/NnkOjCNSGm0TaeGk12
         o0AA==
X-Forwarded-Encrypted: i=1; AJvYcCXosH7aPsn3hGWwOnjG9rxgwJrQzG/8Sa+UhVHxuks4AmExsLnxQ0YJ6JMASLngH6/2sQcOAVZ3CjW88kI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOsm2gFBFlrHtqiPI1KwMJ8fn6SDU+sbum96uxWvgJYqoXq+8
	+5B8Ye6YVSPeMMQYzgJGxtDWqBM3mzU3vquYToMAwYMHqlUdf70Vt1FmBYXTRXuypcxDev857xJ
	NXogyFr2X79a4mXLkVGplKePeZtxCs0mE7iibtBbGDGHDwgIvp7g63M+kbPaK5c0wyyg=
X-Gm-Gg: ASbGnctpDcMVyta1IrBufVklEaRnJ8CG/xogP/ID2DYhfbAyPv1ZwumRsx3+pME5IuM
	G+Ibv2UMvoihxYRcRm5QeDYKTilnv8E+01Dcv4iFGqYFEE8MutVyq9Ci3JZqTXBKtaSij23Pr5L
	5hdkjr36N8tZeqYo0qeML5nz11swdFk3a4v4yvKTLF3JBOsq2NwySlxUmev7i57TILAUW58VMtr
	8lWzBuX9DprGwyLjsHfn5Zcf4u2E8ysWPsAbiA9IblVpOz4+eo3J9VnPNyV2r8Oo0gZnkOypFBb
	aVm09xEMoPKmyRK5ScuPGjt8jUVqB/DD2pXYOrrxPMEDWDu+tyiqmYq12z6N0tNkxE6s8Yh9zJ0
	OgfvbUroDjJWQzq1FVwohEg==
X-Received: by 2002:ac8:5981:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b5f83a513fmr54659751cf.4.1757324995625;
        Mon, 08 Sep 2025 02:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Nr1cvJLpayhWkgcnt8UH3czXMtnD+kOQ5FfN3g+uja3rrF4K07g61R9UqbF9Dwg7GRukAA==
X-Received: by 2002:ac8:5981:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b5f83a513fmr54659661cf.4.1757324994936;
        Mon, 08 Sep 2025 02:49:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046f2dda22sm1231244666b.40.2025.09.08.02.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:49:54 -0700 (PDT)
Message-ID: <5178a6b1-1b5a-40d9-af40-68ee13975509@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 11:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i2c: qcom-cci: Add OPP table support and enforce
 FAST_PLUS requirements
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss
 <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20250904-topic-cci_updates-v1-0-d38559692703@oss.qualcomm.com>
 <20250904-topic-cci_updates-v1-4-d38559692703@oss.qualcomm.com>
 <aL6Vp-3er71AJPJd@linaro.org>
 <f508bf92-a513-467a-a946-17c41e1d72d1@oss.qualcomm.com>
 <aL6X-RiCyPVbHlYN@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <aL6X-RiCyPVbHlYN@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68bea6c4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1skEbHYOOoY0r-gFCEEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Sdo5__-HL4Nke4NJu8ScyZK7yiDHlfHf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX3U6DTL/Gs0bC
 U1zg/QjP67g2ELNPF9f8AVe8ESxpmCqYrbK0ZhQxpp6vYwzyTfypoBAKmQ44OwRmQEdXubH5Oa4
 XwDuOKsxmeeVA0+8o6x0siuH27R7EnhAk2GQ0nHaCaRQk6A5UyF7TMAXl2cTA/y+O2Hq1dmEBz7
 AegvrQgd3troLTswrCKMuGe3WZmMIMlxvCncQ6Zl+9GrPF0kbn2Pyshyxm5PJhibEc4ZDAJGSxq
 fytUMVsXd9mcXRqvoJlmoXB+q7HfmgIpAEn+WN7/CHluAViDWuhSnhGDKLpQ52NN9V76kJ7bR0h
 Vm0wC5yeI6uiSwlK+cGFOsxWbYuJLajueYVBAgLdbq8eHVxTQb+rJfSefTxCQwmJ7bvbRUnS0uI
 XhjjKLbu
X-Proofpoint-ORIG-GUID: Sdo5__-HL4Nke4NJu8ScyZK7yiDHlfHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_03,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/8/25 10:46 AM, Stephan Gerhold wrote:
> On Mon, Sep 08, 2025 at 10:43:50AM +0200, Konrad Dybcio wrote:
>> On 9/8/25 10:36 AM, Stephan Gerhold wrote:
>>> On Thu, Sep 04, 2025 at 04:31:23PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> The CCI clock has voltage requirements, which need to be described
>>>> through an OPP table.
>>>>
>>>> The 1 MHz FAST_PLUS mode requires the CCI core clock runs at 37,5 MHz
>>>> (which is a value common across all SoCs), since it's not possible to
>>>> reach the required timings with the default 19.2 MHz rate.
>>>>
>>>> Address both issues by introducing an OPP table and using it to vote
>>>> for the faster rate.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>
>>> Using an OPP table for a single static rate that remains the same over
>>> the whole lifetime of the driver feels like overkill to me. Couldn't you
>>> just put the "required-opps" directly into the device node so that it is
>>> automatically applied when the device goes in/out of runtime suspend?
>>>
>>> And since you need to make DT additions anyway, couldn't you just use
>>> "assigned-clock-rates" to avoid the need for a driver patch entirely? We
>>> use that for e.g. USB clocks as well.
>>
>> This is futureproofing, in case someone invents FastMode++ with a higher
>> dvfs requirement or for when the driver adds presets for a 19.2 MHz CCI
>> clock which would (marginally) decrease power consumption
>>
> 
> If 19.2 MHz CCI clock is feasible and has lower voltage requirements,
> then I would expect a separate entry for 19.2 MHz in the OPP table of
> PATCH 5/5? The DT is unrelated to what functionality you implement in
> the driver, and that would make the OPP table look less useless. :-)

The frequency plan for 8280 does not recommend any rate != 37.5 MHz

For x1e80100 however, the lovsvs_d1 corner is recommended to be 30
(yes, thirty) MHz, sourced from CAM_PLL8 for $reasons

Konrad

