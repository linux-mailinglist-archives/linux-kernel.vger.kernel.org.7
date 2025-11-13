Return-Path: <linux-kernel+bounces-898986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2CC568A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C3894E67AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09683321AB;
	Thu, 13 Nov 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGYsqAmV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M2YTs9BP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121C331A7A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024340; cv=none; b=nNcqNtVlT+6lW0opdnHUvDXpqVnp9DZ04Lzp/GtBxDjFlNeVUYMt+HklyD/S7xkDKpxz9if7A86QkCS+P455K0yqCcl0qvR3iGhnL3d8Gzv56yyD7tbB+TPNeMGgktaSo1AeDtmGnnvs7Z/9vQ9+v6IVrlmXQUDFI2NcvQojHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024340; c=relaxed/simple;
	bh=xeygKzfNcFQdWUmw0ipAs/cIwF7l2/4A6HjIVo7GqkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfLszHQdALgAB48W2YPkxel1HPur7JhOEC3io8SrXDDyCsw2j+Ntpr/TOqzIhz9FFA+yNGQJOd7zbrrAPZB8kpdMxMiGdmo+959R2OpfKCVukiBRs9YoI+yY/rWc3OrHBxjQBixJUbeTBOMvvAfwZmaA2iO0KL3VkSw3myQodqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGYsqAmV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M2YTs9BP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD4weBt3336823
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sROjm0GfKSzH5SLU/NEBWTltDSLd9LFgr/GT0GVKZ6c=; b=FGYsqAmVJ91Sm7TH
	DutOPdwu+77i+E/LtYnIJJzBPx486I817RtREncP/Qr1BM6eD1LfnOIXMaiMXeIX
	G+qwtR5Mmy9oOohqtrSkydhHo1eEUovPv870xZGRj63f3lkXbom4NFXnnYXbBoaL
	fCYi645gOYSLwCkEjGiekb1i7a4IMWlmaNtS+Ue1wZn10BX2lFTg4gtOXK5XDW0g
	osnFt4QMdiEq8yc2s4wI99ERamW8FLWzhszDgUEl5DiZ2U5OwPfE5WFWLYWygMbO
	3O03qXhAcL1ebRgYAf/5b+/tY6jzMumlyC5K8wm167zrLkCs1aima/cbLrWATLOA
	o4YuOQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ad8sa0q6g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:58:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29848363458so15052555ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763024336; x=1763629136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sROjm0GfKSzH5SLU/NEBWTltDSLd9LFgr/GT0GVKZ6c=;
        b=M2YTs9BP5etJCe7Jkjo71XZJ2mTtJAuUlUAOmtpm7pKuZod8ZmHvFuFGlbvunSbyhX
         /spjShQV/Kb4ZF3qrR7+tV098Mx+8Oi6Kh1uEIG020NHjdRGo1rM1E8coj7j4Tz5YyCZ
         Rsob4K7Fd7ftI7MtvtMRT8/g7RYF9YEpo/WbIdSGGd7vQ2IQe71haztJ0Q77kbo1pXcb
         Bec2IOGpG3zGUunETg3ZSaJad0cMt1nLa+vB4KbhWjl2TC3OOqizblKuj0Uh+VNTWfcB
         3UGgNf6QOvT6oK5bJhuTm1qBQ3uP9yOy2XX5PSpInHKg9D7WJlusCnhg+ZJYfi27BQJ2
         3aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024336; x=1763629136;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sROjm0GfKSzH5SLU/NEBWTltDSLd9LFgr/GT0GVKZ6c=;
        b=nBaKVY9Eoj5gaZ055Ny6VJqDRprFpSqqJNU/16K7ye3rPNTacX4AzJM9y2ivOHIScL
         WLm1MRffrM3xTOWJqUmaCLA+Ja4l+8oZrxcq1hbRglQdW0npRIIPdv/y46k3CMOiUBAb
         xYkswlUBrMV1S+saWXGhQrqstUF2Nh4Hxf2xsxpH62Of13vSaG9uqpjvh5T1lL7PSsxn
         5bHTpDY8sdqgPsuqU3xYWQrBIjR02rHUobuAA41uoibH7R3pRSH4pbKj72Pe0g7HG8ek
         vaMelhf8SUU9RKwmDKByQyUTHql5yJhR9v4wDWsCSpBizuAxFfZTTY1OUFcPhy2uJ4jM
         9eSg==
X-Forwarded-Encrypted: i=1; AJvYcCU/DyQUXdOE3F6owyGme1js75MDGpjpKB/u//6c+exVa32agNhuB13WqwywVQE0r+hnNSTziS9RN7jTWXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPDn3J+aK784/9Kvk+a0n+OOht3Js8FyTjMglMjHGhUnNJ/C6
	d6Hh7tzDAYiSfavOtmfOUl9dpq4EejKh2YeBigJ3aIb0Qeg6QrUS8OiMdMtfjr0q6ljeUWF+pWX
	5Zwo+PcLV376Q0edzY7Nk4h4OF4sP9i18q0sFjLT3MPuM47M/4W5dyvn0Zu+0PAsAwA0=
X-Gm-Gg: ASbGncu080r3JRootduvTxiYofrOaT02m1v2LifsX+4RVlk6iM3NAt1RAPRYA1HI4A3
	uATSvTe6AP3Fmetk08CVGf9uGO+sBuzoh7uRm+6iL0fDzUIiuomPkMTywc2ExQO3rU8wj/EuSJT
	isIRH1debSBn1MdPbxgL2z7UXntULv1JU9I4uJhjuDQq8R3oAf3DKx4LnK3GsCquhpbHavCgKKt
	PKtK5mTG/JGsEOHWGCp85JmOU5idRkVXiciyEP1GhKFeVNRZwig/AE3/JwncoWoTp3wXOveqt36
	88RyEBL0Se3MlJLki7d5KAlNg5WcSNx+C+57w/3wf3/yRTyoVY2pKt7l4MBuxTASd/HXyyNHQqr
	RgkfWxAP+GVyFmT/Q+BGnUmuzdOFa1nOQBThbOSlIUYkdEffnw7ZijRt6JcOSwkB0j+b2uIr8
X-Received: by 2002:a17:902:e5d1:b0:296:ec5:ab3d with SMTP id d9443c01a7336-2984ee3523dmr75868705ad.61.1763024336332;
        Thu, 13 Nov 2025 00:58:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzgUlzNtw8/rYEnIQrkWBFku2DIdKphkHqn6UbV00gDuOF+BZfctiwr/Qw6rkA2ESsI4XQ0g==
X-Received: by 2002:a17:902:e5d1:b0:296:ec5:ab3d with SMTP id d9443c01a7336-2984ee3523dmr75868465ad.61.1763024335662;
        Thu, 13 Nov 2025 00:58:55 -0800 (PST)
Received: from [10.133.33.34] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccc03sm17458615ad.109.2025.11.13.00.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:58:55 -0800 (PST)
Message-ID: <4d4fad1f-aa89-4aae-a856-b032ebc4ea9d@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 16:58:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] coresight-tnoc: Add support for Interconnect TNOC
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@arm.com>
References: <20251015-itnoc-v5-0-d7ca2b1cc6df@oss.qualcomm.com>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20251015-itnoc-v5-0-d7ca2b1cc6df@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yrPzUf2yFb2dSwFi5CKVVc6KvquYntbM
X-Proofpoint-ORIG-GUID: yrPzUf2yFb2dSwFi5CKVVc6KvquYntbM
X-Authority-Analysis: v=2.4 cv=dcGNHHXe c=1 sm=1 tr=0 ts=69159dd1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Wn57KMgoQ4YZn1JjiAUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2NCBTYWx0ZWRfX3VONLFQLU+N1
 IxFOyGWG+Dqo91p9Q0LCt4e+y60idIKsYFIhfUDdqunI3U45vLVK2X7zQaXmFn5PtAPVOJIZxew
 V0bwZosGpuXZ0XHKgsfLCqNTqgmcLrAMKUTk9ef77ggsH0HkxGbU1dy3yLTOZLzky4leR0oRFeR
 Xetp5yWmcntc73CG9Dsh8e8XGq1yb91ItVJHzjkochpXKxcVnBXRTNMk/u2FUjm6ihi63P74Bku
 /nof7Te3kUab5D0nRL4HcH0v8k4RF5W3PTj/1u94tJjG1hRHonRIjFXXeNHIWOZbqG7IGrRzaYo
 xptS7LCXnq9BkRIv1am5SxAFar8/6qGRtn7irHJmNCfOVwJnhBum+2Ue8FiNXwz1Di/xjucH+pZ
 xR2KnVTIWZdZqFyaINdnvTNNmnjANw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130064



On 10/16/2025 1:49 PM, Yuanfang Zhang wrote:
> This patch series adds support for the Qualcomm CoreSight Interconnect TNOC
> (Trace Network On Chip) block, which acts as a CoreSight graph link forwarding
> trace data from subsystems to the Aggregator TNOC. Unlike the Aggregator TNOC,
> this block does not support aggregation or ATID assignment.
> 
> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> ---
> Changes in v5:
> - Add the missing review-by tag for patch 3.
> - Link to v4: https://lore.kernel.org/r/20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com
> 
> Changes in v4:
> - Fix unintended blank line removals in trace_noc_enable_hw.
> - Link to v3: https://lore.kernel.org/r/20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com
> 
> Changes in v3:
> - Add detail for changes in V2.
> - Remove '#address-cells' and '#size-cells' properties from in-ports field.
> - Fix comment indentation for packet description.
> - Link to v2: https://lore.kernel.org/r/20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com
> 
> Changes in v2:
> - Removed the trailing '|' after the description in qcom,coresight-itnoc.yaml.
> - Dropped the 'select' section from the YAML file.
> - Updated node name to use a more generic naming convention.
> - Removed the 'items' property from the compatible field.
> - Deleted the description for the reg property.
> - Dropped clock-names and adjusted the order of clock-names and clocks.
> - Moved additionalProperties to follow the $ref of out-ports.
> - Change "atid" type from u32 to int, set it as "-EOPNOTSUPP" for non-AMBA device.
> - Link to v1: https://lore.kernel.org/r/20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com
> 
> ---
> Yuanfang Zhang (3):
>       dt-bindings: arm: qcom: Add Coresight Interconnect TNOC
>       coresight-tnoc: add platform driver to support Interconnect TNOC
>       coresight-tnoc: Add runtime PM support for Interconnect TNOC
> 
>  .../bindings/arm/qcom,coresight-itnoc.yaml         |  90 ++++++++++++++
>  drivers/hwtracing/coresight/coresight-tnoc.c       | 136 +++++++++++++++++++--
>  2 files changed, 215 insertions(+), 11 deletions(-)
> ---
> base-commit: 2b52cf338d39d684a1c6af298e8204902c026aca
> change-id: 20250815-itnoc-460273d1b80c
> 
> Best regards,

Gentle reminder. 

thanks,
Yuanfang.



