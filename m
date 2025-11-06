Return-Path: <linux-kernel+bounces-887815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19EDC39267
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 06:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DCE3B376A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 05:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3524A058;
	Thu,  6 Nov 2025 05:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WY5U3PG4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7ugUMaq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8501241663
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762406424; cv=none; b=On6JjnxkgOxvc0NXsqbqfW5Aec8FR2TvFFm1w5tkTPAaoEn0NJ1GghMTz1IYhehEaNn31Nww15yX/mhph9LOu7Oi+WiXZX1LCISQeHJe6wpUezBFqxOY2Xptd3axcx+IIm2cMNc2TmLnbWukQyqg3AIntBPdmOQoBSaxyX64e18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762406424; c=relaxed/simple;
	bh=PCRT/VnjscuohG3qd1r/9oEnwYE+hozkOIujPshDmnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap4aGwtIknOKyTY17gcPD4+v3Bhj5CyAjrgXXVWfGWAio4xNSbMM+6of0UvTjxe/nHwNWjtYjZ7a/dbTUqK73u4BxeUcCc/Kr5zz2PRtlBkUpcKCS0leavO3kpUrN6Y4dzDQNmkHvjE5EX51y0z7pswFJXn4D6xOb/HGzpT9sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WY5U3PG4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7ugUMaq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A655skk3217824
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 05:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RbncP33QuByCSLGI1byB0rZspAPVjU3fy2uppZLE2jY=; b=WY5U3PG4eUJLipRu
	BebhURNIeJ9CDJWrOCxeTHjrsPo5v3vVvjZ5rTe62ecmyJEkBvPfDPSnpDJYWLY3
	LtD8YTOqv3vzjXA82IizMEH/BAZXyh9ubpV41rpDKnOv9tbFUaLShk5O0rpAtRvR
	8aREZj1pZblM5WYszuAAj7vxoXGSOOoxc47MEptdZZOKj8Lzt8e+9XkdHaRcjoGH
	DYC2UE6tv6BXeraAQQFkXjQG19VkrUcp6eKEaU2TBqJkPP/NfNuzjKb7ODqRvJgj
	gspW0qNK4zE+4u/ghe+kkteBNMB/oG7NLhJyGjwK9LdWmMesN78fthJWs3A4KPeW
	FVkPdQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8n7pg13e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:20:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso141871a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 21:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762406421; x=1763011221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbncP33QuByCSLGI1byB0rZspAPVjU3fy2uppZLE2jY=;
        b=J7ugUMaqnjcbYOgib4ounkwiF9EOZR21Ovu7A1SunZYKunHRmVFU8kzJ9TvC1ul64y
         3MZyXZ4jJ+sNC4C6a9RqgpyVa9ofUcf4mh2v6EF87X4K8O4xDfIa51K4tY/3KQGSvDQL
         G9oXc18+PRyoJNRmfzVbyHcIV0ewFt3Rb3WrrjG2AXgOBql3gs/+CLnv2PIIBYqPMPjv
         9X4cL3KPEtIC4GV4x8GkFrG8Fx/leatOnMDNlRh9eMBvMa3eODMgEDwH/d2Mp9rn+pj7
         zGKuHRzXDfkjrXD5cvD44pCDaX5UUv9ODn+89I6HxytdOh0zXO78jYFqkgj/BDyFCGAK
         qpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762406421; x=1763011221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbncP33QuByCSLGI1byB0rZspAPVjU3fy2uppZLE2jY=;
        b=HhtzsmkQwuJCHXANGQ33WItmQquHF5jL2MjXH2LG8PhWyL8tcAipA+OwNY6hVW0d8c
         X5aouqISa+NC7plCmGVv09TVkYJw4CpyeQyAVr2iCngWK0EQTotPp2Ud/9M8wQ6jbVuS
         Mgrdy0NMCiPF+GlXm+ND7ppjADKNoUaFgiLYv8uJ7ZKFImYdPQUhNfYLvN5lzlb5Tqwf
         D0sdLrmZAg0tq9lt/GYbC4hqmZF8+bi4SpjTMQeGeBVyKb8iEC8hcTqJnikr4q/CCWC1
         4xc7ptZxWJUBvgAfGskP54uR4yq3qPWzzRy59fA6D7J8JppIz/lF4Hfo/hhRQABJYdst
         eitQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6KKHQfbXvlG3JwVnX9ys+9kHbQUvgpRKL3c3pus0fK7XkvOy2RijQQ8GcxHHi6y7gGzlPTwKs4GxzApk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2h+vqR1lf6nSVACtaKU+xy+uY4g/4F3JsDBWq5MxOkDjPUKC
	6cngEUdSKiPiiyA9c3fk5dB3Y3ltlCl+GNNDicBs3pLZxAidzUk3VmmG2CRDz6YQpcW1WspAM7Q
	rj2JDtIeLnykS0M+y72y+/P4CiysAxG+V/Y2XgNvHicQdLoFdTR4TVPDkatGccv/FjvE=
X-Gm-Gg: ASbGncu0tkYXMQjyeKqPeznR47XzZorvjv6JBzbarJxl/KaNH9XiPtRUj8nAZsopkO+
	jS11dhnjBARLZF4t969AIMovokNEWz8VY6goVkSVuDjSk6v10YqK2qkF0IVkHbQmtGZRrAEXcru
	85ytXy+9Kxj9p524EniLN2s+9QEp53cxyUQWFEpD/JdWKZyPW4hAPZFg/XsX/G3Lc6jWlOPpBkW
	CzOwJz0xjgDIGPx3Jkr8NxbO6uqscxJY+R9QhCm6afMx0Ge5U58dMgQ70MkJsqfxBH0j8TkIjMT
	dQuY//oVYR/2nJT+1UnrWTqc74wT+i1uVpN89QKqm7T7XKof7arb2ecELJmnOWfGJ5wjAQLOLyS
	Pj7ZqHrZeT2+tBtpVwT2sm/YepCiUVCqrDWyBX8FCMPloSjfRJpGZI1MuW3+fSR9u
X-Received: by 2002:a17:90b:4a0e:b0:33b:b453:c900 with SMTP id 98e67ed59e1d1-341a6dc3ef0mr7716786a91.19.1762406421347;
        Wed, 05 Nov 2025 21:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA8v7A+ayync/726jkKTD5KYJxkRhenVh6tscIPPHnasEdHKYvxouPnrmMzhPLa+hczUysXQ==
X-Received: by 2002:a17:90b:4a0e:b0:33b:b453:c900 with SMTP id 98e67ed59e1d1-341a6dc3ef0mr7716756a91.19.1762406420807;
        Wed, 05 Nov 2025 21:20:20 -0800 (PST)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d1347db0sm535859a91.4.2025.11.05.21.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 21:20:19 -0800 (PST)
Message-ID: <cfc7871a-73b0-43ca-bdf0-bcb8b5f17396@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 13:20:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] coresight: add static TPDM support
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: elSnlAPsosxkVo9pz7cHXqfEyDLjLELs
X-Proofpoint-GUID: elSnlAPsosxkVo9pz7cHXqfEyDLjLELs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0MCBTYWx0ZWRfX3kmly8zfosq+
 ouWZkeXhqiv2IPeiw4m4NLQYywg64A3tkzFrkkrugNfQpjWJlv8hmFOeeR6ZO2L678wnWDJYmvB
 17xNXAlIss7uK79xrJBNjjTbSydKKr+MADs8T5Zjizg768c7O0vaD/0WMJv56O6reCaLFzwe43d
 9APHj07Xf2So4Yq0PlLfR02/T+PCpxyyyS0gcDFufwIXZRRpvZHUjtm9ykN0gFA0GOEFQw8PPZV
 sabeE+sgeflTCwLICOc3xdI4tf1K+L35D+arcl1iaRRBDiK+da+9g3or5x50xkVFytjr37l359F
 J4cd8/ZZFBvG4GE5f3wNM1/Ib+dnzsJuL8ghZsy5X+mOrdWAKTjwjW9FVu1kcOJndtuPFt8a3d/
 oMWiep3JEA9dZJHoNaKKKUvLJ/MeTw==
X-Authority-Analysis: v=2.4 cv=ErnfbCcA c=1 sm=1 tr=0 ts=690c3016 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=43WlQIeRwcEhdZomQpkA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060040



On 10/28/2025 6:11 PM, Jie Gan wrote:
> The static TPDM function as a dummy source, however, it is essential
> to enable the port connected to the TPDA and configure the element size.
> Without this, the TPDA cannot correctly receive trace data from the
> static TPDM. Since the static TPDM does not require MMIO mapping to
> access its registers, a clock controller is not mandatory for its
> operation.
> 
> Meanwhile, a function has been introduced to determine whether the
> current csdev is a static TPDM. This check enables the TPDA device
> to correctly read the element size and activate its port accordingly.
> Otherwise the TPDA cannot receive the trace data from the TPDM device.
> 

Gentle reminder.

> Changes in V4:
> 1. decouple from tpda driver code.
> 2. Introduce a new solution to identify static TPDM.
> Link to V3 - https://lore.kernel.org/all/20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com/
> 
> Changes in V3:
> 1. rebased on next-20251010
> Link to V2 - https://lore.kernel.org/all/20250911-add_static_tpdm_support-v2-0-608559d36f74@oss.qualcomm.com/
> 
> Changes in V2:
> 1. Remove the dependency.
> 2. Collect tags from Rob and Konard for patchset 1 and patchset 3.
> Link to V1 - https://lore.kernel.org/all/20250822103008.1029-1-jie.gan@oss.qualcomm.com/
> 
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
> Jie Gan (3):
>        dt-bindings: arm: document the static TPDM compatible
>        coresight: tpdm: add static tpdm support
>        arm64: dts: qcom: lemans: enable static TPDM
> 
>   .../bindings/arm/qcom,coresight-tpdm.yaml          |  23 ++-
>   arch/arm64/boot/dts/qcom/lemans.dtsi               | 105 +++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.c       |   7 -
>   drivers/hwtracing/coresight/coresight-tpdm.c       | 174 +++++++++++++++++----
>   drivers/hwtracing/coresight/coresight-tpdm.h       |  12 ++
>   5 files changed, 279 insertions(+), 42 deletions(-)
> ---
> base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
> change-id: 20251028-add_static_tpdm_support-1f62477857e2
> 
> Best regards,


