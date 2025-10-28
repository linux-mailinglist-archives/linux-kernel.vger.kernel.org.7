Return-Path: <linux-kernel+bounces-873373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038CC13C83
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1F485053D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A4301477;
	Tue, 28 Oct 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e1h/4f9Y"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F3301004
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643362; cv=none; b=mJnUFvo699i+V/Q4ssVDqVSA5ZxduLdQrNprb4Z5v45q+pX9ILkj1lfJUNg6EsZxZ/aSEZipnfEuBfgPZattV+5H2Eic685rYzCDfdS5V4iMVKPoMuYtQzTj2kLwjPwE2OyJhAYLy41z4NYYsVHr0hzZogfjTiEoWx1HCg7Mj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643362; c=relaxed/simple;
	bh=qsFC1t/fVaM3KdBTuNCtkaYnQArD/UtI3nrJ3KbKVlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMcXoHR8HHqepyCDgoz2wQ5tNsPDPMkz5V/S8gXgAgLzmYchUQauvXVuFrsgKvOZzFAiv4bmAtnO5n0TL9QBl5FpEFTcOGsEiFkbYTxXiAI1DJ6Nli8t8P/h04UrZL+qYhS0knjkvQn5HoT7mInMfxrRWiwQsMQgtYa5PK2q8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e1h/4f9Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4otw5589647
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:22:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IX/AJuPm2H3fYAH/Y3OWD0ONewAieu2FIaoXZk0cs+s=; b=e1h/4f9YDvRe1gvj
	fdP5jIbAD+QDcmuvJIqaGlfuOYHhVbNbAsP0u3qaO68jCxX0MKFdSMXo7q5ZV3Wl
	hkVigg7lyJX9nF1wFcN0c/pqyuQLa4DSqkCAaAwSTTeo+QhhgMoHt8EghrA7biQq
	kzrrfG1yQaxTizMSZyAIsM58/g0eTwyeylLgirEuRpAEY1M1W5FczTrdubr16CH6
	nqJCCadPsGbuZtLs2wo6M7tD5+GBfejKisOLkP0MTN5iG8WXXyVsUWGJOgIk4aQB
	lz5Gh+aU8Rfc0DDNGw3StQAPmfE7NQhf0zOzhe598yGgYJR8YoxtClk1RtTncgZ3
	lCvtsw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u8rtn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:22:38 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87ff7511178so3156106d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643358; x=1762248158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IX/AJuPm2H3fYAH/Y3OWD0ONewAieu2FIaoXZk0cs+s=;
        b=vm6j+iRQGyGB4OBubCIuTYNn5AIz61T2Fqu5ie9088rZDwNFByCRM/kd9PP3Zb5KJd
         sKDl6JN7uXip+IELcSNiRpeCAqiqYlfTp+sQNbkRNaIOfANtWl8j5nW3L4705b4hD6LN
         OUr+6HPjuLm/sOaFRmT7YBy4qlz9JXNw6/LtnA1GuwBpG/BZr6Fjdxu1M61PvP+e2ltf
         BWCHgjRgbzlMwTT/rTB6jNrHshMoUbB/Hp0gc3uk+UMXfLQZaGfXFNLwypSVnbJ8we7t
         Gx7O7HhyeYaJmUbcd1+J70Ccnodt4tfgdWb+sVWtEN8DUhUA36psbqTkw8hbTvF1XVWf
         cq1w==
X-Forwarded-Encrypted: i=1; AJvYcCVSynqJnNUBqEDxwO7Xjz5DcN2v4WH6HfSMY+/X1CiPvPMsMeDqylfcNLmmy13CvSoW/2WkCdV7ClM2YZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1JTVWTXHgg6mb3GosWyUal3sxr6wV+lFniOwtX6uQBBgXX4NF
	2D7Bb3bz760g7DzyNcwjr3zja0UqPmZ6kR4ZjKUJWABElVS5OQTKh9EYnXy1cNC/+lGzqW+Nnt0
	sZAhhABdx4hJwLGxWXky8SO493U8ko2QNFruqLPeheJtiOMOxphosTK5+dmIHDCiBmuA=
X-Gm-Gg: ASbGncvmbxV4nmgXueqc8lqKqvm6Iz30kig5uxo9MEpwxbEJKNu6NU1I+gPbbN2gDCX
	See5ihbtabHB2DvUGSNv+yhbUUff4Uekpg3PV1clmAwTDcm+AM5lu3tzttJdWrtEd+qqQ60h34n
	cxc3JtYAah6vxyHn2O5yrfEX4X5vvRaHgpgu/UjfQEGncaImwLWYiWMG1b/hyK3+n7gW5X0Ofd3
	xVhVEZJUmrZPe3e8130Le6CFh4rwwtHRvBW7aDhu1GX2EVNyLW6oluTVf5STLeN/Sp+iaCKrKt6
	l5BDxbVGu6bbWR9/HU0iL4pL/qua6Y5Bkq5OBDl+Cee4CQMo0apniUMV5HR3jmUKmF4VNsI4+ur
	o6C418zDBgbaVeUuLPktaFpzYbs8cslENyAlTfnrqP0NhJpc8LZUuxhOr
X-Received: by 2002:a05:6214:27e9:b0:830:4f29:a648 with SMTP id 6a1803df08f44-87ffb112d3emr22293306d6.6.1761643358055;
        Tue, 28 Oct 2025 02:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ZreXF9W3AcLutVyZajvD/Nw87lTiLoKTGKUZuS/I2lkFW6ZVkmxbJZsXQ+QjTyDQ5ip2zw==
X-Received: by 2002:a05:6214:27e9:b0:830:4f29:a648 with SMTP id 6a1803df08f44-87ffb112d3emr22293176d6.6.1761643357549;
        Tue, 28 Oct 2025 02:22:37 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077e8sm1038621166b.14.2025.10.28.02.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:22:37 -0700 (PDT)
Message-ID: <a9da8c31-fb88-4350-96a4-de61d68fd756@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:22:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] soc: qcom: pmic_glink: Add charger PDR service
 path and service name to client data
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
 <20251027212250.3847537-3-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251027212250.3847537-3-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA3OSBTYWx0ZWRfX5Vx1BIvigaIA
 +dWWxlbZMD9bKaJNjdKiwB9gTMe2cfSbASHlcE1oOAE2+9YqUQ+tdFsE3nJtuPbFyTK5IHawTpC
 nEYCOBDlKFptKSM3/6wsctj+pzLgpGxlrZ2WHGJ2TBCpH5WZVnIGJoj/WD4o4/XtHPLTgoHoUui
 tqNznoRr1NRqKCfirI95k0tfq0u2yZBcPOV/rRX3viORoxGbymG36eUm8k7WMo37Qrj1y38N+Xb
 XGUdSQrrLPbC804g9HMsGbB3yakNWRRPKB7NUFqR3JIh+nwu75GEcnxtMOD8DArw8ffqcGhdXSE
 XNda12GzUFSPKnwo5xrAO/sSw9NJae+Dkxjcp2xsWt92JwX0q4va/KSX4wyKqHXacIPBWMt5V4B
 cYXiPCqGucU5vVUUYE7naprfXdfMEA==
X-Proofpoint-ORIG-GUID: nb-_Y3D0-GCHcQQC5xrlsFqz5CxYqpUw
X-Proofpoint-GUID: nb-_Y3D0-GCHcQQC5xrlsFqz5CxYqpUw
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=69008b5e cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WU2mBd_dA-PMypUZboQA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280079

On 10/27/25 10:22 PM, Anjelique Melendez wrote:
> Currently, the charger PD service path and service name are hard coded
> however these paths are not guaranteed to be the same between PMICs. For
> example, on Kaanapali and Glymur, Charger FW runs on SOCCP(another subsystem)
> which does not have any specific charger PDs defined.
> 
> Define charger PDR service path and service name as client data so that
> each PMIC generation can properly define these paths.
> 
> While at it, add the qcom,kaanapali-pmic-glink and
> qcom,glymur-pmic-glink compatible strings.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---

I think this change disqualifies Glymur from having a fallback to 8550,
since it couldn't have worked without ignoring the PDR

Konrad

