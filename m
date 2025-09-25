Return-Path: <linux-kernel+bounces-832437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6832B9F507
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D32384DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB325FA13;
	Thu, 25 Sep 2025 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTiAQQir"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B215B135
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758804247; cv=none; b=Yv8JgpYGi1tsRKtgOL2YX/uadvddySsY+xE2JsCfwauJtXq1IffeB9HhT0SaKcA6FgqomC+AE/eetKNi5xkr6j56uwzZpNF1PoYBqmWeEi7Wk9YCMnw/+DCSpZAsrIl6tftTCMo5wMgQLcBuBlyNBLaR/ft8xoLwznRPrFEn6Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758804247; c=relaxed/simple;
	bh=FDZQOCz16djFlBDx5G+q/SJZvR1Nd4tnacSZ3RZpF6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWzvGGtwG2g/cKYX9URizs+L4sJkFeGAwDCheHWb0Qbp2Yg7RRSRvTFEXfP6w+zjyNeeHWIAtIQqNWogqO2lPF124zlADjhOvwysat4aqohY4c1zPlU6l+rLSRAvxlTLf/YCBoxOI52xYF3tp2V8errIFybNCL/UmFnubTtcZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTiAQQir; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9jmfi002152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J1dwgELFlCnM0xIxl3rJVZougZALziWUncte4Klhh90=; b=ZTiAQQirl4hUHOrO
	ABNQSD+zst6QwW3Mx5Htc8nHBSCq2PE+UFQiVFgJQ6MvE19n1shtl3QsK6CwWlDz
	DGY0dNYq1GxRKV1Soz4p53iJGsRt0kmJmdeWvIGWmwmrCJuDjzEirwDpgjQNwsf7
	RZFLR8OUodHYoRJO5sIyHeoIjS6ZNUPhehjQaI6gCdBPldzsxu2BuUGlWyTqClOD
	zDjJgOWupElvQwst68F4g87Vk/Ycksl6CeEx4d6HuqAINQ4aVZeL9dw5NdbfqnQ+
	sJshWOPmtEi4YWGFfgCVWXz3fYNGqaV4V3X9iTQLhY6fLOWAQ6rCNYHMnauoMfEf
	hrTSxQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98r2qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:44:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-819d2492a75so43935385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758804243; x=1759409043;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1dwgELFlCnM0xIxl3rJVZougZALziWUncte4Klhh90=;
        b=f9/hX92lSgXp6Fl0ZOhSgSNcg9kQdFRxndG7j7Jfy2L3C93vOxDGv/AWNqEywwKmEu
         vaj1SQOTL6wYL+hq46xZaKN9St2LloaAboLG11+UPsCz92WyLVUCPQ6M58bi+tRXRlwr
         jUvtiURhG4Hir7eTduwlNRD4U6FfL1VQIc8P3UWKzMCEHNtGhnSwHYmHuXT8dWmtDSlJ
         TnA76Desk3Yrbo7p6c/D49DhKLspQCUg5tvTyTVGXIjj1lv/UmLPAPayLMiUcuI7dRMy
         yWj7fWbn8jhtbrl+zEPF8oUeAeXmvx/hoT7ZY/UUYyZBAbEnBhkPcuW3VEDNA5MjPnsA
         eXUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3vdU1goWvWZOFV/bKPwK9EEC8c71iYH6SCl9yxcR4f7XaeMU2pU9JbzWqWsuIvcPqTYmv5ZJdI3/yUa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3n4eoeTrK7m2iQPyierP7D8i9J7GbiiEj7XF3pfKKe2+PbZEP
	FjJVx23vh+IDcEfk5yAdRW//LpOtk3AqxcPV2Jm10V6rB+FaW+KvAKZRskRLQhFtMhdh6oM5jNw
	ENjB9PMa172fMlqq5IyuZzA0QVvGdwzKhkhZEVlThWCt7iNlwErqIIfChMtwKOIwYebE=
X-Gm-Gg: ASbGncvanQiNFX1MgN+SSUpK+s418j8qDhoqEWjL7neGsyQ0GKujg6ZKgz66HuvGWGE
	k1/MrfFQzdsz5g4RJiY2YVLK1CWK8tLVLfpAwE5EmwwctA2TyXdTrdQvB7gNrd6x6AQXR2zErXX
	fdv0U+qwMAqXmJGor+aoouno+PxOgpGKdpAaFEvytDh5cjZgG9q+9Ho1xeHV7HV+O09HbNoCRT9
	sobPaOCL7Po69TG/eeuqnq1LP8bzmwasA2fyO4/YgGSKO49ueEVkPDMQ/Zs0ZK8dhWmmTTztmUa
	Muv22/vJ+TuH7EktL8I884+U3l8ptHAuGCMsaiO/Xs3VdYNfSH7Wr2fB3/ArRhQQH6c8I99/wnk
	mxLF7ASWbNy6Srcym2X6I0g==
X-Received: by 2002:a05:620a:4888:b0:85a:dcb:a0fc with SMTP id af79cd13be357-85aea416316mr275179585a.13.1758804243443;
        Thu, 25 Sep 2025 05:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTirFLDo0M0Czkw5tWy8aR4EZDdLw5DUbB9F6HAhp2U1yQ+4dTFZ34JK/WVzP/W4uKPnDE5g==
X-Received: by 2002:a05:620a:4888:b0:85a:dcb:a0fc with SMTP id af79cd13be357-85aea416316mr275176485a.13.1758804242839;
        Thu, 25 Sep 2025 05:44:02 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9978bsm163475566b.95.2025.09.25.05.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:44:02 -0700 (PDT)
Message-ID: <eea3ad4e-d656-4ee4-b4fd-2414ea78669f@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:43:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: add the tlmm driver for Kaanapali
 platforms
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com>
 <20250924-knp-tlmm-v1-2-acabb59ae48c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-tlmm-v1-2-acabb59ae48c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PR51GKEOtrLPYhmtlSB-JXjKu9P4Nw6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXz2BzI6s8+dvd
 cjQp3qbcgEMjShvdCCcq5n3aLKvlD+YLc3Ko+I9J1vS4HoYXhSE24enM3sIubOb9cbAZlihJsrf
 ItyWutv+TrXy3muudv7Qpa3DljGRiICRbz1Cz2E2iWwfGEVQ1WJUmsyYen33JO8MAVhIIvyBrLQ
 NeZGQSQmA9HMqVdOcmqrdpFkkFXBTffVLY4Iw0Pri4NXzC97yj73D3YJYO27tisMM5fT69mG7kO
 m3y0zeODM/31aZS7eHyPpl2EemEV2nKqdeZ5WRfyF2FQR+CjxnXche46qB9nInAScy8hdazneku
 FY/uY6Vshl842L7hiZ4kAx3sKAJXPgZcNLU4GjV1kS9eBikNTA/BP+z2X89i3hWqdG/86VVy3lS
 Mn7BmRig
X-Proofpoint-ORIG-GUID: PR51GKEOtrLPYhmtlSB-JXjKu9P4Nw6v
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d53914 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=3KcoXW5xE102B6w2v2sA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 1:16 AM, Jingyi Wang wrote:
> Add support for Kaanapali TLMM configuration and control via the pinctrl
> framework.
> 
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

