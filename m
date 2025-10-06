Return-Path: <linux-kernel+bounces-842704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D4BBD560
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C1B5349B90
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641F25F975;
	Mon,  6 Oct 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JSSvtF+E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D6225D540
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739336; cv=none; b=tSdMhzJjAz1asyQDpfnLN1JXhLk3NijFNS69l3qbWqxtmrGB5OQk9nj+HeYMmegAUcKskacWOhDzYmYFUqvN75E8lYotQCN58B3kiK9ivA8qywHVm8XJInGE6U/CwH6LwUAym4c6e1GRzUlQ1sZKNtkgT9mrQIJx/OfKHnLxDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739336; c=relaxed/simple;
	bh=ew0vJWVJulFUpGzp6GbSkojdXLce2+5kVbuDWsVNrrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/3DrkngpwUQeiw4nuIoN/ft0wp+YC+11yg/AX5j2d1VbZ5XqGUxky4/S/FSZn6+MQnQQs81GKDH9GpyZByt7QLabthw3k95ZeByfiLpaSR7fFz9Zdj5ZQC5BsFc4Fhzljrfktoi3hhp2/RgxHfly9Q4XqQKINp2XFRf4tKcaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JSSvtF+E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5961EIgl028800
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 08:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fySFI0+vB4C2jZwTubej+JIBaPURTzcto53v2iuju/0=; b=JSSvtF+EV+lEe3aW
	HdCNglBweJ7uJXfNoYT/GyNTNvVOLaG6JqNdCqvQUqx6Bg1onQwFvG0S5V7hN6qy
	GWU9oH5N+kPsFyQJiGypl4mFosNXvRl8peDSkz1GAVJnm67uQ5y2g7ZOMzTnCg7v
	6L6OZssRWfcWLOFZS9EOsajv5bHTQbTCKWPn6DEJgUzSCNMYPxurMTWd/E1CsKlm
	SFnr2dXyIeb8dEar1Agjt33dL3+DABK9vL0Ogl/A/OH2gw8gf7boUqOH091S+a9r
	MY7GinrPiCmEgvNkRYtSygH49dtSf/0q65Xr0Ifqw4OGNNsIcWRjDwQIaxRdbEaq
	gmdhlw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ju5xbb6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:28:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-85d43cd080eso146560385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759739333; x=1760344133;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fySFI0+vB4C2jZwTubej+JIBaPURTzcto53v2iuju/0=;
        b=sL2D1xhykEKuXo++B5lTDd6hUR2JUbiFT2a4gooGiZSQwmDH19UCf32YGcUP/zQlxJ
         8cO4ecu/oj56rjXEyX49cYIG/6MEX6A/wxGHolRat5cgEmVt1KPNRFPzORvEA7hO3JbZ
         UhzsNXc3QrTFom9QYJ/5kLRk000zfiA2H0scldyP3GgH4eAOiJEnV5uSNzujSGuGyEZZ
         joIMu1R72Et1Ksj+s8LmVMaIusgVh9R9iFbEw18ylwBnGNXjlry8c4mz8yxBX2RsJs0W
         4rQ+o361vpgudNNxlnImoY+dlJdSyctrGgC/YNu2wQHEVUFDBewUcQ2zLvlZ44RU1oBg
         bumA==
X-Forwarded-Encrypted: i=1; AJvYcCXSFxra7FWiV1yj9fBW6rj6+Vg57Gb59vco4H1+3J+gf6xvIGaTHn+nVKA6mylq5lFjmI2IKmVbhH7SOWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26kU9uTCojOMCPN+S1rOmCW5BLpdYkA7YcsCg87R4XetoXSqA
	lLe7Pr/NFuTVVmOQhDDyRE7tXRrFnUaIJgfsxhfwcGsbUiieZEbk+4ewBWz8Q1rO8lb1MM11Jc+
	esEmdETfTx3/X0cTjUPUfkYqRsHiOEi6yvuhcn170uYNw/7XndPQpAK5PEMQSAJBkI6E=
X-Gm-Gg: ASbGncupaMp3NLnuRZwjH0b/1LvcFodXemteuTcEG7JnkMi8e88BSkEpmeYsnhbNG8P
	IA4pM18VkOUHgYx21ywb/R2pFEhcLMZqhhHgFfi2dmaDRdUS35FO3NMxwq86Quxx2gImbr3Vzhl
	RytmRZfHDrt0LzUlokp7U/gjNaLDhgmAWC1LGSvAT+XhpZrCTnJ/kc/pIr1n7Vq4c7nSWcM+xY3
	KRHQaPFWPlbf31dLW+O0iid663O1So/55yC15wGyn+1lSHGFOwmRIPbA8Np3g7soMjeeUKXBCYS
	UdGxgAMLKbSwoODuI0ZFCNFxbPBedGnCMCmk+RgbHyLZsZn9bN3hzhMsBdlGGk2SwpEavuKP3nl
	Mq0fqQwcQGYKRw4gfRezBxbOY4kc=
X-Received: by 2002:a05:620a:28cc:b0:855:b82a:eba5 with SMTP id af79cd13be357-87a342f8541mr1018834585a.2.1759739332433;
        Mon, 06 Oct 2025 01:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExpG1GPi83h7oEKjeN5OxS64YtQ149fVac/bi4Nb1qP6pl8aEItSm3iduplFbNPRMuPJyo9Q==
X-Received: by 2002:a05:620a:28cc:b0:855:b82a:eba5 with SMTP id af79cd13be357-87a342f8541mr1018831185a.2.1759739331800;
        Mon, 06 Oct 2025 01:28:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83f6csm1105339366b.31.2025.10.06.01.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:28:51 -0700 (PDT)
Message-ID: <565924dc-84d4-40cc-8826-5143338cca21@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 10:28:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/msm/dsi: add DSI support for QCS8300
To: Ayushi Makhija <quic_amakhija@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: robdclark@gmail.com, dmitry.baryshkov@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-6-quic_amakhija@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251006013924.1114833-6-quic_amakhija@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FooIPmrq c=1 sm=1 tr=0 ts=68e37dc5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=rHxuBsFVyQJAZ78EHecA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BwZoQ218h6cOjL_TnPAzKmk9NoKxZm0f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMiBTYWx0ZWRfX/9MLmRLhI4cH
 NmbNhOTWHNT33Ms9kFBAwNdkzLo4IRmmUhAYrdOdHhZP567rS/gQh1ACsFCrwioT1TwDVkanZqu
 ApB/9ADthUjjL83I0WNbhT01GQYK+H5fku6rp3jPgwLHvtnZNqxqH7Q72nAUvoLV5pTkWPGjSPt
 iyPweNPynxs2HB4v7fhLXrwfKjqWgfcgWCpXJBucybU2FTX1nb6CwMMa+eOm3b7vFGMialqLagt
 wPPwPR1zVxvfLCl+tzybDJE2i7889Cnp2BR3nSzNQcnRE/0Q8LHJkWudD5YSGHik78sznA3QpPU
 6voh2sJhqP5WtShhLaLYbNVlz3Twysl2MwSJg806nJ1yM4Rz+gP3bnqBDcaSrBrQzX9QbsCBqUL
 Z6Oah6Eh4oTXBm0H7wPMnK6hoDUzfg==
X-Proofpoint-GUID: BwZoQ218h6cOjL_TnPAzKmk9NoKxZm0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040022

On 10/6/25 3:39 AM, Ayushi Makhija wrote:
> Add DSI Controller v2.5.1 support for QCS8300 SoC.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index fed8e9b67011..b60384ea0b32 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -226,6 +226,17 @@ static const struct regulator_bulk_data sa8775p_dsi_regulators[] = {
>  	{ .supply = "refgen" },
>  };
>  
> +static const struct msm_dsi_config qcs8300_dsi_cfg = {
> +	.io_offset = DSI_6G_REG_SHIFT,
> +	.regulator_data = sa8775p_dsi_regulators,
> +	.num_regulators = ARRAY_SIZE(sa8775p_dsi_regulators),
> +	.bus_clk_names = dsi_v2_4_clk_names,
> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
> +	.io_start = {
> +		{ 0xae94000},

"{ 0xae94000 },"

But there is no need to introduce this ops (vs 8775), if the secondary
IO base is never requested, it will simply be left unused

Konrad

