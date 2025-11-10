Return-Path: <linux-kernel+bounces-892883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7BC460A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462281887830
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150B22F25F1;
	Mon, 10 Nov 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bRR5fElt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hw0LS9m/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F8288C22
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762771630; cv=none; b=ejqaP4bS9lBhW6fKFoe/60ZdQURiuGuY5cUU7lGaSdTjVgCjVhS8jDa6E4WNam8OxAhQ1S8OsRZXATB0fUnEIiz4KlF/XZwm6BDOO/2WtIDRZ0gs1zX0t2LQ7JdXbdCDm5PWbo+kvTuDMErZu1+YGDpM5ObqsdzlryOdYEwwqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762771630; c=relaxed/simple;
	bh=nsbpNFFqe00U17LB7W+qjtwWVN/NgsQ/5KyFtH+XojU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRTyXC8YQ5/ZHlCY59004S2T6iR8NiRepxG0KixDaXpyhOU4ffmDB1/LlWNplFdfGeyls/nshkLdNFhitBg1tRalU++8pDKb0NzJfCdOU71r1TNal0xnqF9PTaycZR0b76Jc7yiuCHRXm8tFTVwyOqBogILJUwD+Fiez0mQh5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bRR5fElt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hw0LS9m/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8qL2Q1795143
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cBJVNfik5OiCeMMLHOumoYf4lo5WTFo4GRQQQ/riu2k=; b=bRR5fEltyaQ5HPAz
	Wmj2NCLsxpW+BbxhoGgmu7VRuHespbktdXn3g0KRMdigp5cXpK3jbg+hzcyYqdaN
	VragxiCG3MUVqHfEZa0/a4HmlUc70SlMHHy6ClkENRP8umVJzaiD5uMv0jq4hNTH
	hu7ABM3UGgi+jY9AP21cAhkpuXwq2GIu1Hab/jPc4xv1X+j/SOK0kuy23oewlPmp
	OM7NsW5S3BPhZeFEpYTaDw0HVIce4sM2RxChQMLR/zO8QziFelLpZoHc9AF1c0+1
	PWJCK0vX/PmQH9P3sfYxQz+/Img1wReVi4l/TqKdLSRKiWfUwNvm7qKYy3nIcyJ6
	5bge+g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xvjce09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:47:07 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7ae9be0d8d5so5724095b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762771626; x=1763376426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBJVNfik5OiCeMMLHOumoYf4lo5WTFo4GRQQQ/riu2k=;
        b=Hw0LS9m/ZIyyNF8T3Gc76jFIjpwplA8NFJEJGjX2H0clp2/wALC6kObHSx08mBVwup
         JSMpF7IgPadgAUwUIwaTLf/bBql8W+eWIk1DSk3wW4lD0BlrZWwIoeVw/qM/WFpWiu4Z
         5VGeB6kQQ+ddSwSpJvgkDi0ahVOs2MdurtMac0f1JVJZV83hwqv0qChb7C6QjxjDqUTa
         cKJmUpB34wBTZl0GGgiALfGqPZ4P74ceDQLVpw5VCBJj7eFfFNokTr8dhzpCzJsp2tI1
         JGldzNnbP1in6snemeht6AqYESqRd0cGhpjen2jAN+exBRLzB2PbnkprmsRAK01dJnxn
         jiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762771626; x=1763376426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBJVNfik5OiCeMMLHOumoYf4lo5WTFo4GRQQQ/riu2k=;
        b=BSm47ivTYGgwxflaH1/M9aGkcH7t3lbtT8l1NduClUucMltjKarK27yR/buJXIx+m9
         inijqX6aLYcCAGFDkg3B0PIYO0mxitSDNiYrxqAIDMIGOQahs4VW6raKN4jVwsmUmAo9
         eLkzI6zIXbz+mILyqtD9KQSalBi/IXLMPNrUWH30dr26rPjSXchj3RZAN/mlkWiReP8L
         qDZT5TZJ5AxiixQ35G6cy7ILHxEipYLvsKZWi/fys7yS0d7DpqC5fEmPChXFNle3hZZ+
         4wMkR9260S07VBPylPaQmNvrhKkfbEv/Gm+G5n9QTkLmYw94MDMZe+XbCM83/wt6p0jw
         azZw==
X-Forwarded-Encrypted: i=1; AJvYcCW4qsIm6XEnNr/v75qN6/CjjMAqSRIqO33mqUuwoVkcq3I7yWLW7Vrimk8YzwcHr+t0Qy63eKGCxntebqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxuYv2IJY8fmoT76EgSgXZuMV+ULdTF+m5Z0OAU/gP7Bid02nF
	DOZxHJAmbRfhocA2R8y7Umr2Gtl/ityLaJtp/iIJYaxAQE+w8pJEkK3juotXbjTrDECtm8FgCT5
	pboGbE4xyEmXkpLrKWOMkUFi5KLob/pZQLVi0vJD7WY/VZpJzVWAfvCW9KwuY6hsNm2g=
X-Gm-Gg: ASbGncuoJ+W2pGPbwYX+QC0FBuGIZOsaMYO74kdokqcsa1tdgNTUR7Hzh+hFRa1wYMh
	RyU3YmOdjZE7f9bhDgSfb1V1LnZc1klkzFtiPvJCACx+1homOIDm+rKWS73CRcqm/RAW+qb43iT
	To9FNFpsEGQGZZo+kiyXz24bKBjVIFS4yD84rcNHcRgt+EQin8ATXhKJJTMuMmtCmuw2oCoc+6L
	RyUFUm0EDBsdPg8JMHyVHpG0BOV7mTpGwzyKbgyFnGt+V2K4IpLZXX7GMuJqiMIPpFbzBS1Xl6c
	Nsg94/EjcUNYA4gNotj44Tt0QJTMbpv8XGzZP/YUjESXgTs0e9Ba7pVQ0wm0PdFvJ9Dl2/NSIN7
	+2EYfIjHC39gSFUr0opWFOQ==
X-Received: by 2002:a05:6a00:2315:b0:7a2:7d23:f6df with SMTP id d2e1a72fcca58-7b225ac3be3mr9947252b3a.7.1762771626238;
        Mon, 10 Nov 2025 02:47:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4vJOPjqb72Lut8GdThOc2xoDZ3DeILcxOCSGvZKHBENufhfY65hftt13Ag1lzGMrSMfn2JQ==
X-Received: by 2002:a05:6a00:2315:b0:7a2:7d23:f6df with SMTP id d2e1a72fcca58-7b225ac3be3mr9947206b3a.7.1762771625715;
        Mon, 10 Nov 2025 02:47:05 -0800 (PST)
Received: from [10.204.104.20] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc76c0e8sm11310969b3a.52.2025.11.10.02.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 02:47:05 -0800 (PST)
Message-ID: <0deaf045-4728-47da-8e1a-48a50d035f91@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 16:16:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Support for Adreno 612 GPU - Respin
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jie Zhang <quic_jiezh@quicinc.com>,
        Jie Zhang <jie.zhang@oss.qualcomm.com>,
        Qingqing Zhou <quic_qqzhou@quicinc.com>
References: <20251107-qcs615-spin-2-v2-0-a2d7c4fbf6e6@oss.qualcomm.com>
 <83cafa2f-8fc3-4506-8987-1b5e10d8eff6@oss.qualcomm.com>
Content-Language: en-US
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
In-Reply-To: <83cafa2f-8fc3-4506-8987-1b5e10d8eff6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QuxTHFyd c=1 sm=1 tr=0 ts=6911c2ab cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NnskH1bFij-3DXFgURQA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: xATmdv9AtQTPtEruuj6FGmoKO7uacdQy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NCBTYWx0ZWRfX0GxTSdlzNxJ8
 2okqUSaYnmQya0ojzHgo0CxE2RX80Pl7QsvMy4P/Fj4l1MSj33ngQKxyoCV29Zigh2hquFu2EDz
 YsbcX8qawoB/z3Lunqh51/wfUG3H+eeJKgl5GJPNflfE2NUC2pQe/Mq1JyE4Qu3YWCPoDVVotrz
 3qzLBviF2Er+dyWKM0+4CMJ8oXxC7xxGCEuhXvIO0z/nsJx7r44EbhSNBS6QlfUm0tmgSkJnEJU
 kOK94JylDTt7RcPXiTJIzAtxDtSZxUf3cWALdvdi1tEnk9yrOxUpYv14orBdCIsOQ/RGLx7jrQs
 LLzNjmyUIKuIhbDyYOzCvXxDsJDMq5691SYHuDzali/hZJy4qV0245EvEEChzMBa55seT7nRr4N
 OVFOV9hfiDTEGNa/Nl+qdPFooP/9AA==
X-Proofpoint-GUID: xATmdv9AtQTPtEruuj6FGmoKO7uacdQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100094

On 11/7/2025 2:22 PM, Konrad Dybcio wrote:
> On 11/6/25 9:50 PM, Akhil P Oommen wrote:
>> This is a respin of an old series [1] that aimed to add support for
>> Adreno 612 GPU found in SM6150/QCS615 chipsets. In this version, we
>> have consolidated the previously separate series for DT and driver
>> support, along with some significant rework.
> 
> [...]
> 
>> Changes in v2:
>> - Rebased on next-20251105
>> - Fix hwcg configuration (Dan)
>> - Reuse a few gmu-wrapper routines (Konrad)
>> - Split out rgmu dt schema (Krzysztof/Dmitry)
>> - Fixes for GPU dt binding doc (Krzysztof)
>> - Removed VDD_CX from rgmu dt node. Will post a separate series to
>> address the gpucc changes (Konrad)
>> - Fix the reg range size for adreno smmu node and reorder the properties (Konrad)
> 
> The size stayed the same

Weird, I had a fixup commit which updated this. Seems like it was lost
somewhere along the way. :(

Will correct this. Thanks.

-Akhil.

> 
> Konrad


