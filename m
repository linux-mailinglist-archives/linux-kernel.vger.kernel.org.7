Return-Path: <linux-kernel+bounces-735446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4138EB08F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651D61C41ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB4A2F7D16;
	Thu, 17 Jul 2025 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KrcjY3dA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099EC2F7D0D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762522; cv=none; b=r3jC4DYRFyp8VfCJHhAQg4ACAUjsZ0Ig4MDcOSWMmAyMByjfQR/pN1YGNY3+DtKR1zYZnf5YbiXDgrgkcBVWW1dh3HrQsdYlPA13x1VCJIHRwyGNu+Vst+eXq9vC3G6dEhnWFzgo4tZjSj2wE6zx4qCMh/4EQ5M9xSWqu0Zih64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762522; c=relaxed/simple;
	bh=v3oOU8PVA/bqEGOL4lt720q1ULAXf932Qx4T5j1qZUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeUFc2rRzhsSY1SMKwtSol8LMH2GkgT2qeRw/AUqX1uaW1rH5OXNqyFBxdaowIPNnJ/BwLIlLSILieMMsJT1yskVxsxRW7pnPQ/TOAZQP0Ql36Mf+hh0oiP4mklXlBoq7iDXILyINQdqy6XQW1HqGMqgR2WymnmoJxQzQkMnHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KrcjY3dA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBhV4d004464
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oQ+icyUZ+5njb3VMCS4dcZ4gTJQBpU0JDW0kKoJZke4=; b=KrcjY3dAgvQxpZ2X
	SMRvmyBueyY8pan1IHX+7wEItcc/wW0tECSzxGIEY7zGxXLrtiQau/oRZuOCXfAv
	b+FR8rX9FoTh3FspCf/ByO3lRmRlMdgzMvTW1dsuPrfT1YjYlqVzNvziQ2JjbmyN
	Sl0bDFQ+M9JW8M3Db+hCdCtO4iIx9jBaX2tKjXaWYN7x/7Z+U3OZkISrnID0zuKf
	x0saciahfZ5n0jBLTypGLgmd+yKOVDefaqEaDwEAEhuDXzwYPe7SLSSnSgQXvZMd
	kNDr1+9BW2b7wIib3HR1Wn6+pQlZtssH2UecczqIrRvzr61TIcZTQ/6V6nuhXF6j
	UdHDDA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsukstqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:28:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6facde431b2so3018556d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762519; x=1753367319;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ+icyUZ+5njb3VMCS4dcZ4gTJQBpU0JDW0kKoJZke4=;
        b=Uy+Ip7A4TftQK4c7YYDmLHjj6OGkbC6I3btrr9gbBYr6qzPKKNRDTbUNaPtPTXIh2T
         e1U84xzA1WXu6l+grtEMzhivl6YzhoIc2vt92JXMyUcV2EP1CgcNXJPVT6cZU2pCZEIH
         7PKTL8sigNoJRXTTw3IEyjWzb3lUNHcG16ct2e6sbxI5dNfzQdA+2vnDJL1dt9ATB06/
         Zttx+a2AnlrQIt8nYIHMR8hwzcE4Bz8yBdtG3dR/Rhq2QKAMn8odP8vLKx18wmdCCIl1
         i/+N1aWu8vWc4FR6mo5OXuuFc31FsYgVTXrGJr5El5Hlr267KN1BhbL165ugoeUzQJYr
         3Caw==
X-Forwarded-Encrypted: i=1; AJvYcCUZBKAsQeFHHS/efR0Ahkhr548LZgYwLamqYp4SHDryrargkFof9XexyhuQspPod0suORIwkQMy4lIdBaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1z8cyC5/l4jtkDgK+Vj/0gwfMXEDoq7nKsmyrUNaqKsTTGbt
	COZuhbv5wSXwZgg6pQls3oKB6VPYiWGHVd6ZzfQv8E8J9zxmTk21xrlOY3nD58ME6oe5dDjC6cl
	JDLjwtYDX5EYfC1Aer32Bl7tXpELdkrmkEYeVfJV52j9C6tXjqc6tFofbT+8OQ5gQDwk=
X-Gm-Gg: ASbGncsbFIzCFoLcJV1MC/K8g6MmAJeMVqj4fYILPgxxBJ30Vrn63bqn63rOSPMO2k4
	Vb458XwDXqVu7pkRMNCqkMh7OGk1eS2rsVxfsODPaYKy+TLBQttdZg2pHUd7PDGeHcsnCwIASaY
	jDEzrZG/QPcHTEYDxYLmNsifOV7CJMaf1AbtL9on3+juIe36tbG/twDzRwU7IrAxLY1/2Nb09Ph
	HhhYMV4eg4eTUTP8LhBDUIVC912AybOA43xUpWZClPmqs+nZfZjfFiCjWhBORS+XBL7pXS/AgM5
	S7AvjSxTiV1wz5ZIzV3ckai3VrzSyF46dkHzgRj73Bjf0gHXDdPIDPG+LgtDTkhWBFfHEqWu2ST
	yNpHNEOAveCiyIYrLb/Cv
X-Received: by 2002:a05:620a:1a9f:b0:7d4:4353:880 with SMTP id af79cd13be357-7e342aa89e3mr435817785a.6.1752762518769;
        Thu, 17 Jul 2025 07:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT/4SwF38PAfg0B4c9eWQ7/O/SGHhZwcsWSCvKWkBoYrLT6UHikWMUgn/PtK4mB6zV9GV53A==
X-Received: by 2002:a05:620a:1a9f:b0:7d4:4353:880 with SMTP id af79cd13be357-7e342aa89e3mr435815285a.6.1752762518275;
        Thu, 17 Jul 2025 07:28:38 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c973439bsm10331941a12.47.2025.07.17.07.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:28:37 -0700 (PDT)
Message-ID: <2c1d8048-7ce4-4fbd-8af5-88d1afb5577a@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:28:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sa8775p: fix RPMh power domain
 indices
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
 <20250717-fix-rpmhpd-abi-v1-1-4c82e25e3280@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250717-fix-rpmhpd-abi-v1-1-4c82e25e3280@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kQ2dXugnQN4GbEmlC6GCiwg9KDAdDebA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyNyBTYWx0ZWRfX79bZczNMFMs7
 XhZxVm5fb2Z6B00CRHM4KigPXqfAsGvUDplgxqHP/1v3zfJYnp0X6AZOdckyDUTyTFtuHxQ2J+/
 sPbwjgMYUgeH4Fgc0JXnJKF/PvEN4rRm46evanpgCysfSH6aAYgq2zYFL7bpPSZ7J4+4oB00299
 8AbAUSVCi9lUa8jPFzFN9Xpm1Lrl3wnFXZcRYlfT7nEHnouBAIUbchiFynlBpido797JweceaWN
 F7Pz6zk1xHU0sgwkQ2bV4OsUheX9tpdW2MZdyVjD783GLxim1m4XcFlL4natJz3PPsoovq2JF53
 e9D0Quxwn7iI4BhxvAviRFelYlqq/lF2IG4UQdyaEuNWFsaENUBiXdGrkHArGtVC7Qh7dAaO2XG
 sbuIAk516/ny8nnkn/+AjnOm+4AYlVV6cBObM6DLRGpGcsui1U+46qEhA3qMhdf1EFEpHysi
X-Proofpoint-GUID: kQ2dXugnQN4GbEmlC6GCiwg9KDAdDebA
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=68790898 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=NamI24IyYu8Bov36B24A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=773 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170127

On 7/17/25 2:48 PM, Dmitry Baryshkov wrote:
> On SA8775P power domains device doesn't use unufied (RPMHPD_foo) ABI,
> but it uses SoC-specific indices (SA8775P_foo). Consequently, all DSP on
> that platform are referencing random PDs instead of the expected ones.
> 
> Correct indices used for that platform.
> 
> Fixes: df54dcb34ff2 ("arm64: dts: qcom: sa8775p: add ADSP, CDSP and GPDSP nodes")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

